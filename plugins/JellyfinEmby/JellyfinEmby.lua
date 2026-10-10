plugin.define({
    id = "compas.jellyfin_emby",
    name = "Jellyfin & Emby",
    version = "1.1",
    api_min = 16,
})

if not plugin.has_capability("playback.remote") then
    plugin.show_toast("Jellyfin & Emby requires remote playback")
    return
end

local VALID_CODECS = { flac = true, mp3 = true, aac = true }
local REQUEST_FIELDS = "MediaSources,MediaStreams,ProductionYear,RunTimeTicks,AlbumArtist,Artists,ParentIndexNumber,IndexNumber"

-- Asynchronous lifecycle, generation counters, and navigation state
local current_generation = 1
local account_generation = 1
local nav_generation = 1
local active_requests = {}

local current_browse_handle = nil
local browse_history = {}
local current_view = nil

local function cancel_active_requests()
    current_generation = current_generation + 1
    for handle in pairs(active_requests) do
        plugin.cancel(handle)
    end
    active_requests = {}
end

-- Strictly validate base http(s) URL with optional base path
local function validate_and_normalize_server_url(raw_url)
    if not raw_url or type(raw_url) ~= "string" then
        return nil, "Missing or invalid server URL"
    end

    if raw_url:find("[%z\1-\31\127]") then
        return nil, "Server URL contains control characters"
    end

    if raw_url:find("%s") then
        return nil, "Server URL cannot contain whitespace"
    end

    if raw_url:find("@", 1, true) then
        return nil, "Credentials (userinfo) not allowed in server URL"
    end

    if raw_url:find("?", 1, true) then
        return nil, "Query string not allowed in base server URL"
    end

    if raw_url:find("#", 1, true) then
        return nil, "Fragment not allowed in base server URL"
    end

    local scheme, rest
    if raw_url:match("^[hH][tT][tT][pP][sS]://") then
        scheme = "https"
        rest = raw_url:sub(9)
    elseif raw_url:match("^[hH][tT][tT][pP]://") then
        scheme = "http"
        rest = raw_url:sub(8)
    else
        if raw_url:find("://", 1, true) then
            return nil, "Unsupported URL scheme; must be http or https"
        end
        scheme = "https"
        rest = raw_url
    end

    local host_port, path = rest:match("^([^/]+)(.*)$")
    if not host_port or host_port == "" then
        return nil, "Missing host in server URL"
    end

    local host, port
    if host_port:sub(1, 1) == "[" then
        local ipv6, p = host_port:match("^%[([a-fA-F0-9:]+)%]:?(%d*)$")
        if not ipv6 then
            return nil, "Invalid IPv6 address in server URL"
        end
        host = "[" .. ipv6:lower() .. "]"
        port = p
    else
        host, port = host_port:match("^([^:]+):?(%d*)$")
        if not host or host == "" then
            return nil, "Invalid host in server URL"
        end
    end

    if port and port ~= "" then
        local pnum = tonumber(port)
        if not pnum or pnum < 1 or pnum > 65535 then
            return nil, "Invalid port number; must be 1-65535"
        end
    end

    if host:sub(1, 1) ~= "[" then
        local octets = { host:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$") }
        if #octets == 4 then
            for _, oct in ipairs(octets) do
                local n = tonumber(oct)
                if not n or n < 0 or n > 255 then
                    return nil, "Invalid IPv4 address in server URL"
                end
            end
        else
            if #host > 253 then
                return nil, "Host name exceeds 253 characters"
            end
            for label in host:gmatch("[^%.]+") do
                if #label == 0 or #label > 63 then
                    return nil, "Host label must be between 1 and 63 characters"
                end
                if label:match("^%-") or label:match("%-$") then
                    return nil, "Host domain label cannot start or end with hyphen"
                end
                if not label:match("^[a-zA-Z0-9%-]+$") then
                    return nil, "Invalid characters in host name"
                end
            end
        end
    end

    path = path or ""
    path = path:gsub("/+$", "")
    if path ~= "" and path:sub(1, 1) ~= "/" then
        path = "/" .. path
    end

    local port_str = (port and port ~= "") and (":" .. port) or ""
    return scheme .. "://" .. host:lower() .. port_str .. path, nil
end

local function url_encode(str)
    if not str then return "" end
    return (tostring(str):gsub("[^%w_%-%.~]", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

local function build_query(params)
    if not params then return "" end
    local parts = {}
    for k, v in pairs(params) do
        if v ~= nil and v ~= "" then
            parts[#parts + 1] = url_encode(k) .. "=" .. url_encode(tostring(v))
        end
    end
    table.sort(parts)
    return table.concat(parts, "&")
end

local function join_endpoint(base_url, endpoint)
    local norm_base, err = validate_and_normalize_server_url(base_url)
    if not norm_base then return nil, err end

    endpoint = (endpoint or ""):match("^%s*(.-)%s*$")
    endpoint = endpoint:gsub("^/+", "")

    local _, base_path = norm_base:match("^(https?://[^/]+)(.*)$")
    base_path = (base_path or ""):gsub("^/+", ""):gsub("/+$", "")

    if base_path ~= "" then
        if endpoint == base_path then
            endpoint = ""
        elseif endpoint:sub(1, #base_path + 1) == base_path .. "/" then
            endpoint = endpoint:sub(#base_path + 2)
        end
    end

    if endpoint == "" then
        return norm_base
    else
        return norm_base .. "/" .. endpoint
    end
end

local function api_url(endpoint, query_params)
    local server_url = plugin.storage.get("server_url", "")
    if server_url == "" then return nil end
    local full_url, err = join_endpoint(server_url, endpoint)
    if not full_url then return nil, err end
    if query_params then
        local qs = build_query(query_params)
        if qs ~= "" then
            full_url = full_url .. (full_url:find("?", 1, true) and "&" or "?") .. qs
        end
    end
    return full_url
end

local function get_device_id()
    local dev_id = plugin.storage.get("device_id", "")
    if dev_id == "" then
        local raw = tostring(os.time()) .. "-compas-" .. tostring(math.random(100000, 999999))
        if plugin.md5 then
            dev_id = plugin.md5(raw)
        else
            dev_id = "compas-device-" .. raw
        end
        plugin.storage.set("device_id", dev_id)
    end
    return dev_id
end

local function make_auth_header(token)
    local client = "Compas"
    local device = "Compas Player"
    local device_id = get_device_id()
    local version = "1.1"
    local parts = {
        string.format('Client="%s"', client),
        string.format('Device="%s"', device),
        string.format('DeviceId="%s"', device_id),
        string.format('Version="%s"', version),
    }
    if token and token ~= "" then
        parts[#parts + 1] = string.format('Token="%s"', token)
    end
    return "MediaBrowser " .. table.concat(parts, ", ")
end

local function is_tls_verify_enabled()
    return plugin.storage.get("verify_tls", "1") == "1"
end

local function is_authenticated()
    if not plugin.secrets or not plugin.secrets.get then return false end
    local token = plugin.secrets.get("access_token")
    local user_id = plugin.storage.get("user_id", "")
    return token ~= nil and token ~= "" and user_id ~= ""
end

local function get_clamped_page_size()
    local size = tonumber(plugin.storage.get("page_size", "25")) or 25
    size = math.floor(size)
    -- Keep requests small enough for the player's bounded JSON/UI memory.
    -- Older installs may still have stored 50; normalize that in memory.
    return size == 10 and 10 or 25
end

-- Invalidate all auth state immediately
local function clear_auth_state()
    account_generation = account_generation + 1
    nav_generation = nav_generation + 1
    cancel_active_requests()
    if plugin.secrets and plugin.secrets.delete then
        plugin.secrets.delete("access_token")
    end
    plugin.storage.delete("user_id")
    current_browse_handle = nil
    current_view = nil
    browse_history = {}
end

local function sanitize_error(err)
    if not err then return "Request failed" end
    local s = tostring(err)
    s = s:gsub("https?://[^%s\"',;>]+", "[server]")
    s = s:gsub("Token=\"[^\"]*\"", "Token=\"[REDACTED]\"")
    s = s:gsub("Authorization:[^\r\n]*", "Authorization: [REDACTED]")
    s = s:gsub("ApiKey=[^%s&]*", "ApiKey=[REDACTED]")
    s = s:gsub("api_key=[^%s&]*", "api_key=[REDACTED]")
    s = s:gsub("Pw=\"[^\"]*\"", "Pw=\"[REDACTED]\"")
    s = s:gsub("password=[^%s&]*", "password=[REDACTED]")
    return s
end

local function to_positive_integer(v)
    if type(v) == "number" and v > 0 and v == v and v ~= math.huge then
        return math.floor(v)
    elseif type(v) == "string" then
        local n = tonumber(v)
        if n and n > 0 and n == n and n ~= math.huge then
            return math.floor(n)
        end
    end
    return 0
end

local function safe_string(val, default, max_len)
    default = default or ""
    max_len = max_len or 256
    if type(val) == "string" then
        val = val:match("^%s*(.-)%s*$")
        if #val > max_len then
            val = val:sub(1, max_len)
        end
        return (val ~= "") and val or default
    elseif type(val) == "number" then
        return tostring(val)
    end
    return default
end

local function safe_artist_name(item)
    if not item or type(item) ~= "table" then return "Unknown Artist" end
    if type(item.AlbumArtist) == "string" and item.AlbumArtist:match("%S") then
        return safe_string(item.AlbumArtist, "Unknown Artist", 128)
    end
    if type(item.Artists) == "table" and #item.Artists > 0 then
        local names = {}
        for _, a in ipairs(item.Artists) do
            if type(a) == "string" and a:match("%S") then
                names[#names + 1] = safe_string(a, "", 64)
            elseif type(a) == "table" and type(a.Name) == "string" and a.Name:match("%S") then
                names[#names + 1] = safe_string(a.Name, "", 64)
            end
        end
        if #names > 0 then
            return table.concat(names, ", ")
        end
    end
    return "Unknown Artist"
end

local function safe_album_name(item)
    if not item or type(item) ~= "table" then return "Unknown Album" end
    return safe_string(item.Album or item.Name, "Unknown Album", 128)
end

local function safe_track_name(item)
    if not item or type(item) ~= "table" then return "Unknown Track" end
    return safe_string(item.Name, "Unknown Track", 128)
end

-- Asynchronous HTTP dispatch
local function http_call(opts, callback)
    local gen = current_generation
    local called = false
    local handle = nil

    local function safe_callback(status, body, err, headers)
        if called then return end
        called = true
        if gen ~= current_generation then
            return
        end
        local safe_err = err and sanitize_error(err) or nil
        callback(status, body, safe_err, headers)
    end

    local ok, res, req_err = pcall(function()
        return plugin.http_request(opts, function(status, body, err, headers)
            if handle then
                active_requests[handle] = nil
            end
            safe_callback(status, body, err, headers)
        end)
    end)

    if not ok then
        safe_callback(nil, nil, sanitize_error(res or "HTTP request threw an error"), nil)
        return nil
    end

    handle = res
    if not handle then
        safe_callback(nil, nil, sanitize_error(req_err or "Failed to start HTTP request"), nil)
        return nil
    end

    if not called then
        active_requests[handle] = gen
    end
    return handle
end

-- Authenticated API requests guarded by account, navigation generation and list visibility
local function request_api(method, endpoint, query_params, body, callback)
    local token = nil
    if plugin.secrets and plugin.secrets.get then
        token = plugin.secrets.get("access_token")
    end
    if not token or token == "" then
        callback(nil, "Not logged in")
        return
    end

    local url, url_err = api_url(endpoint, query_params)
    if not url then
        callback(nil, sanitize_error(url_err or "Server URL not configured"))
        return
    end

    local server_kind = plugin.storage.get("server_kind", "jellyfin")
    local auth_header = make_auth_header(token)

    local headers = {
        ["Authorization"] = auth_header,
        ["User-Agent"] = "Compas/1.1",
        ["Accept"] = "application/json",
    }
    if server_kind == "emby" then
        headers["X-Emby-Token"] = token
        headers["X-Emby-Authorization"] = auth_header
    end

    local content_type = body and "application/json" or nil
    local verify_tls = is_tls_verify_enabled()

    local req_acc_gen = account_generation
    local req_nav_gen = nav_generation
    local req_handle = current_browse_handle

    http_call({
        url = url,
        method = method or "GET",
        headers = headers,
        body = body,
        content_type = content_type,
        verify_tls = verify_tls,
        connect_timeout_ms = 15000,
        read_timeout_ms = 20000,
        total_timeout_ms = 35000,
    }, function(status, resp_body, err, resp_headers)
        if req_acc_gen ~= account_generation or req_nav_gen ~= nav_generation then
            return
        end

        if req_handle and plugin.has_capability("ui.list_showing") and not plugin.is_list_showing(req_handle) then
            return
        end

        if err then
            callback(nil, "Network error: " .. sanitize_error(err))
            return
        end

        if status == 401 then
            clear_auth_state()
            plugin.show_toast("Session expired - please log in again")
            callback(nil, "Unauthorized (401)")
            return
        end

        if status < 200 or status >= 300 then
            callback(nil, "HTTP error " .. tostring(status))
            return
        end

        if not resp_body or resp_body == "" then
            callback({}, nil)
            return
        end

        local data, json_err = plugin.json_decode(resp_body)
        if not data then
            callback(nil, "JSON decode error: " .. sanitize_error(json_err))
            return
        end

        callback(data, nil)
    end)
end

-- Login flow with pre-clearing of credentials
local function do_login(server_url, username, password, on_done)
    local norm_url, url_err = validate_and_normalize_server_url(server_url)
    if not norm_url then
        plugin.show_toast(url_err or "Invalid server URL")
        if on_done then on_done(false, url_err or "Invalid server URL") end
        return
    end

    username = (username or ""):match("^%s*(.-)%s*$")
    if username == "" then
        plugin.show_toast("Please enter a username")
        if on_done then on_done(false, "Missing username") end
        return
    end

    if not password then password = "" end

    -- Clear old auth state BEFORE attempting new login
    clear_auth_state()

    local url_ok = plugin.storage.set("server_url", norm_url)
    if not url_ok then
        plugin.show_toast("Failed to save server URL")
        if on_done then on_done(false, "Storage error: server_url") end
        return
    end

    local user_ok = plugin.storage.set("username", username)
    if not user_ok then
        plugin.show_toast("Failed to save username")
        if on_done then on_done(false, "Storage error: username") end
        return
    end

    local auth_endpoint = join_endpoint(norm_url, "Users/AuthenticateByName")
    local auth_header = make_auth_header(nil)
    local body_json = plugin.json_encode({
        Username = username,
        Pw = password,
    })

    local verify_tls = is_tls_verify_enabled()
    local server_kind = plugin.storage.get("server_kind", "jellyfin")
    local headers = {
        ["Authorization"] = auth_header,
        ["Content-Type"] = "application/json",
        ["User-Agent"] = "Compas/1.1",
        ["Accept"] = "application/json",
    }
    if server_kind == "emby" then
        headers["X-Emby-Authorization"] = auth_header
    end

    local login_acc_gen = account_generation

    http_call({
        url = auth_endpoint,
        method = "POST",
        headers = headers,
        body = body_json,
        content_type = "application/json",
        verify_tls = verify_tls,
        connect_timeout_ms = 15000,
        read_timeout_ms = 20000,
        total_timeout_ms = 35000,
    }, function(status, resp_body, err, resp_headers)
        if login_acc_gen ~= account_generation then
            return
        end

        if err then
            plugin.show_toast("Login failed: " .. sanitize_error(err))
            if on_done then on_done(false, sanitize_error(err)) end
            return
        end

        if status == 401 then
            plugin.show_toast("Invalid username or password")
            if on_done then on_done(false, "Invalid credentials") end
            return
        end

        if status ~= 200 then
            plugin.show_toast("Login failed (HTTP " .. tostring(status) .. ")")
            if on_done then on_done(false, "HTTP " .. tostring(status)) end
            return
        end

        local data, jerr = plugin.json_decode(resp_body)
        if not data or type(data) ~= "table" then
            plugin.show_toast("Invalid server response")
            if on_done then on_done(false, "JSON error") end
            return
        end

        local token = data.AccessToken
        local user = data.User

        if type(user) ~= "table" or type(user.Id) ~= "string" or #user.Id == 0 or
           type(token) ~= "string" or #token == 0 then
            plugin.show_toast("Login failed: missing access token or user ID")
            if on_done then on_done(false, "Missing token or user ID") end
            return
        end

        local user_id = user.Id

        if not plugin.secrets or not plugin.secrets.set then
            plugin.show_toast("Secure storage unavailable")
            if on_done then on_done(false, "plugin.secrets unavailable") end
            return
        end

        local token_saved = plugin.secrets.set("access_token", token)
        if not token_saved then
            clear_auth_state()
            plugin.show_toast("Failed to store access token safely")
            if on_done then on_done(false, "secrets storage failure") end
            return
        end

        local user_saved = plugin.storage.set("user_id", user_id)
        if not user_saved then
            clear_auth_state()
            plugin.show_toast("Failed to save user profile")
            if on_done then on_done(false, "storage failure") end
            return
        end

        if user.Name and type(user.Name) == "string" then
            plugin.storage.set("username", user.Name)
        end

        plugin.show_toast("Logged in as " .. tostring(user.Name or username))
        if on_done then on_done(true, nil) end
    end)
end

local function do_logout()
    clear_auth_state()
    plugin.show_toast("Logged out")
end

-- MediaSources and MediaStreams compatibility checking
local function is_mp4_container(container)
    -- Jellyfin's ProbeResultNormalizer preserves FFprobe's comma-separated
    -- aliases (mov,mp4,m4a,3gp,3g2,mj2). These name one container family.
    local family = { mov = true, mp4 = true, m4a = true, m4b = true, ["3gp"] = true, ["3g2"] = true, mj2 = true }
    local identified = false
    for raw_alias in container:gmatch("[^,]+") do
        local alias = raw_alias:match("^%s*(.-)%s*$")
        if not family[alias] then return false end
        if alias == "mp4" or alias == "m4a" or alias == "m4b" then identified = true end
    end
    return identified
end

local function evaluate_track_compatibility(item)
    if not item or type(item) ~= "table" then
        return nil, "Invalid track item"
    end

    local sources = item.MediaSources
    if not sources or type(sources) ~= "table" or #sources == 0 then
        return nil, "missing_metadata"
    end

    local first_incompatible_reason = nil
    local has_incomplete_source = false

    for _, src in ipairs(sources) do
        if type(src) ~= "table" then
            has_incomplete_source = true
        else
            local is_rejected = false
            local reject_reason = nil

            local raw_proto = (type(src.Protocol) == "string") and src.Protocol or "File"
            local proto = raw_proto:lower()
            if proto ~= "file" and proto ~= "http" then
                is_rejected = true
                reject_reason = "Unsupported stream protocol: " .. raw_proto
            end

            local raw_container = ""
            if type(src.Container) == "string" then
                raw_container = src.Container:lower()
            elseif type(item.Container) == "string" then
                raw_container = item.Container:lower()
            end

            if raw_container == "m3u8" or raw_container == "hls" then
                is_rejected = true
                reject_reason = "HLS streams not supported for direct playback"
            end

            if src.IsInfiniteStream == true or item.IsInfiniteStream == true then
                is_rejected = true
                reject_reason = "Live streams not supported for direct playback"
            end

            if src.IsKeyFrameRequired == true or src.DRM == true or src.IsEncrypted == true then
                is_rejected = true
                reject_reason = "DRM or protected media not supported"
            end

            if not is_rejected then
                local streams = src.MediaStreams
                if not streams or type(streams) ~= "table" or #streams == 0 then
                    has_incomplete_source = true
                else
                    local found_audio = false
                    for _, st in ipairs(streams) do
                        if type(st) == "table" and st.Type == "Audio" then
                            found_audio = true
                            local raw_codec = (type(st.Codec) == "string") and st.Codec or ""
                            local codec = raw_codec:lower()

                            if codec == "" then
                                has_incomplete_source = true
                            elseif not VALID_CODECS[codec] then
                                if not first_incompatible_reason then
                                    first_incompatible_reason = "Incompatible codec: " .. codec
                                end
                            else
                                local container_ok = false
                                local is_forward_only = false
                                local stream_ext = nil

                                if codec == "flac" then
                                    if raw_container == "flac" then
                                        container_ok = true
                                        stream_ext = "flac"
                                    else
                                        reject_reason = "FLAC in non-FLAC container (" .. raw_container .. ") unsupported"
                                    end
                                elseif codec == "mp3" then
                                    if raw_container == "mp3" or raw_container == "" then
                                        container_ok = true
                                        stream_ext = "mp3"
                                    else
                                        reject_reason = "MP3 in non-MP3 container (" .. raw_container .. ") unsupported"
                                    end
                                elseif codec == "aac" then
                                    if is_mp4_container(raw_container) then
                                        container_ok = true
                                        stream_ext = "m4a"
                                    elseif raw_container == "aac" then
                                        container_ok = true
                                        stream_ext = "aac"
                                        is_forward_only = true
                                    else
                                        reject_reason = "AAC in unsupported container (" .. raw_container .. ")"
                                    end
                                end

                                if container_ok then
                                    local src_id = (type(src.Id) == "string" or type(src.Id) == "number") and tostring(src.Id) or nil
                                    return {
                                        codec = codec,
                                        container = stream_ext,
                                        sample_rate = to_positive_integer(st.SampleRate),
                                        bit_depth = to_positive_integer(st.BitDepth),
                                        channels = to_positive_integer(st.Channels),
                                        bitrate_kbps = math.floor(to_positive_integer(st.BitRate) / 1000),
                                        source_id = src_id,
                                        is_forward_only = is_forward_only,
                                    }
                                else
                                    if not first_incompatible_reason then
                                        first_incompatible_reason = reject_reason
                                    end
                                end
                            end
                        end
                    end
                    if not found_audio then
                        has_incomplete_source = true
                    end
                end
            else
                if not first_incompatible_reason then
                    first_incompatible_reason = reject_reason
                end
            end
        end
    end

    if has_incomplete_source and not first_incompatible_reason then
        return nil, "missing_metadata"
    end

    return nil, first_incompatible_reason or (has_incomplete_source and "missing_metadata" or "No compatible audio stream found")
end

-- Resolve detailed item metadata if missing before playback
local function resolve_item_media(item, callback)
    if not item or type(item) ~= "table" then
        callback(nil, nil, "Invalid track item")
        return
    end

    local compat, err = evaluate_track_compatibility(item)
    if compat then
        callback(item, compat, nil)
        return
    end

    if err == "missing_metadata" and (item.Id or item.ItemId) then
        local it_id = tostring(item.Id or item.ItemId)
        local user_id = plugin.storage.get("user_id", "")
        local endpoint = (user_id ~= "") and ("Users/" .. user_id .. "/Items/" .. it_id)
            or ("Items/" .. it_id)
        local params = { Fields = REQUEST_FIELDS }

        request_api("GET", endpoint, params, nil, function(data, api_err)
            if api_err then
                callback(nil, nil, "Failed to resolve track details: " .. sanitize_error(api_err))
                return
            end
            local detailed_item = (type(data) == "table") and data or item
            local d_compat, d_err = evaluate_track_compatibility(detailed_item)
            if not d_compat then
                callback(nil, nil, d_err or "Unsupported audio format")
                return
            end
            callback(detailed_item, d_compat, nil)
        end)
    else
        callback(nil, nil, err or "Unsupported audio format")
    end
end

local function build_remote_track(item, compat, token, server_kind)
    local token_param = (server_kind == "emby") and "api_key" or "ApiKey"
    local it_id = (type(item.Id) == "string" or type(item.Id) == "number") and tostring(item.Id) or "unknown"
    local endpoint = "Audio/" .. it_id .. "/stream." .. compat.container
    local stream_query = {
        static = "true",
        [token_param] = token,
    }
    if compat.source_id then
        stream_query["mediaSourceId"] = compat.source_id
    end

    local raw_url = api_url(endpoint, stream_query)
    local stream_url = raw_url and (raw_url .. "#." .. compat.container) or ""

    local art_id = (type(item.AlbumId) == "string" or type(item.AlbumId) == "number") and tostring(item.AlbumId) or it_id
    local artwork_url = api_url("Items/" .. art_id .. "/Images/Primary", {
        [token_param] = token,
        maxWidth = "300",
    }) or ""

    local ticks = to_positive_integer(item.RunTimeTicks)
    local duration_ms = math.floor(ticks / 10000)

    local title = safe_track_name(item)
    local artist = safe_artist_name(item)
    local album = safe_album_name(item)

    return {
        provider = (server_kind == "emby") and "emby" or "jellyfin",
        track_id = it_id,
        stream_url = stream_url,
        verify_tls = is_tls_verify_enabled(),
        title = title,
        artist = artist,
        album = album,
        duration_ms = duration_ms,
        artwork_url = artwork_url,
        codec = compat.codec,
        sample_rate = compat.sample_rate,
        bit_depth = compat.bit_depth,
        channels = compat.channels,
        bitrate_kbps = compat.bitrate_kbps,
    }
end

local function play_single_item(item)
    resolve_item_media(item, function(detailed_item, compat, err)
        if not compat then
            plugin.show_toast(err or "Unsupported format")
            return
        end

        local token = plugin.secrets and plugin.secrets.get and plugin.secrets.get("access_token")
        if not token or token == "" then
            plugin.show_toast("Please log in first")
            return
        end

        local server_kind = plugin.storage.get("server_kind", "jellyfin")
        local track_meta = build_remote_track(detailed_item, compat, token, server_kind)
        plugin.play_remote(track_meta)
        plugin.show_toast("Playing: " .. (track_meta.title or "track"))
    end)
end

local function play_items_queue(items, selected_item_id)
    if not items or type(items) ~= "table" or #items == 0 then
        plugin.show_toast("No tracks to play")
        return
    end

    local token = plugin.secrets and plugin.secrets.get and plugin.secrets.get("access_token")
    if not token or token == "" then
        plugin.show_toast("Please log in first")
        return
    end

    local function proceed_queue(resolved_items)
        local server_kind = plugin.storage.get("server_kind", "jellyfin")
        local tracks = {}
        local selected_queue_index = 1
        local unsupported_count = 0
        local unresolved_count = 0

        for _, it in ipairs(resolved_items) do
            if #tracks >= 500 then break end
            local compat, err = evaluate_track_compatibility(it)
            if compat then
                local meta = build_remote_track(it, compat, token, server_kind)
                tracks[#tracks + 1] = meta
                if selected_item_id and tostring(it.Id) == tostring(selected_item_id) then
                    selected_queue_index = #tracks
                end
            elseif err == "missing_metadata" then
                unresolved_count = unresolved_count + 1
            else
                unsupported_count = unsupported_count + 1
            end
        end

        if #tracks == 0 then
            plugin.show_toast("No compatible playable tracks found in album")
            return
        end

        if unsupported_count > 0 and unresolved_count > 0 then
            plugin.show_toast(string.format("Queued %d tracks (%d unsupported, %d unresolved metadata)", #tracks, unsupported_count, unresolved_count))
        elseif unresolved_count > 0 then
            plugin.show_toast(string.format("Queued %d tracks (%d unresolved metadata skipped)", #tracks, unresolved_count))
        elseif unsupported_count > 0 then
            plugin.show_toast(string.format("Queued %d tracks (%d unsupported skipped)", #tracks, unsupported_count))
        else
            plugin.show_toast(string.format("Queued %d tracks", #tracks))
        end

        plugin.queue_remote_list(tracks, selected_queue_index)
    end

    if selected_item_id then
        local selected_item = nil
        local selected_index = nil
        for idx, it in ipairs(items) do
            if type(it) == "table" and (tostring(it.Id) == tostring(selected_item_id)) then
                selected_item = it
                selected_index = idx
                break
            end
        end

        if not selected_item then
            plugin.show_toast("Selected track not found in list")
            return
        end

        resolve_item_media(selected_item, function(detailed_item, sel_compat, sel_err)
            if not sel_compat then
                plugin.show_toast("Selected track is unsupported: " .. tostring(sel_err or "format"))
                return
            end
            local items_copy = {}
            for i, it in ipairs(items) do
                items_copy[i] = (i == selected_index) and detailed_item or it
            end
            proceed_queue(items_copy)
        end)
    else
        proceed_queue(items)
    end
end

-- Dynamic format inspection
local function show_playback_format_screen()
    if not plugin.has_capability("playback.format") or not plugin.get_playback_format then
        plugin.show_toast("Format inspection unsupported on this build")
        return
    end

    local fmt = plugin.get_playback_format()
    if not fmt or type(fmt) ~= "table" then
        plugin.show_toast("No active track is currently playing")
        return
    end

    local depth_label = "N/A (compressed)"
    local b_depth = to_positive_integer(fmt.bit_depth)
    if b_depth > 0 then
        depth_label = tostring(b_depth) .. " bit"
    end

    local seek_label = "Forward-only (Not seekable)"
    if fmt.seekable == true then
        seek_label = "Seekable (Confirmed by player Range)"
    end

    local gain_val = 1.0
    if type(fmt.software_volume_gain) == "number" and fmt.software_volume_gain == fmt.software_volume_gain then
        gain_val = fmt.software_volume_gain
    end

    local rows = {
        "Codec: " .. safe_string(fmt.codec, "unknown", 32),
        "Sample Rate: " .. tostring(to_positive_integer(fmt.sample_rate)) .. " Hz",
        "Bit Depth: " .. depth_label,
        "Channels: " .. tostring(to_positive_integer(fmt.channels)),
        "Bitrate: " .. tostring(to_positive_integer(fmt.bitrate_kbps)) .. " kbps",
        "Stream Source: " .. (fmt.is_stream and "Yes (HTTP)" or "No (Local)"),
        "Native Range Seeking: " .. seek_label,
        "Volume Gain: " .. string.format("%.2f", gain_val),
    }

    plugin.show_list("Playback Format", rows, function(index)
    end)
end

-- Virtual Browsing Screen with ui.list_update replace semantics
local execute_view

local function render_screen(title, items, on_select)
    local bounded_items = {}
    local n = math.min(#items, 500)
    for i = 1, n do
        bounded_items[i] = items[i]
    end

    local new_handle = nil
    if current_browse_handle and plugin.has_capability("ui.list_update") and plugin.is_list_showing(current_browse_handle) then
        new_handle = plugin.show_list(title, bounded_items, on_select, { replace = current_browse_handle })
    end

    if not new_handle then
        new_handle = plugin.show_list(title, bounded_items, on_select)
    end

    current_browse_handle = new_handle
    return new_handle
end

local function go_back()
    if #browse_history > 0 then
        local prev_view = table.remove(browse_history)
        nav_generation = nav_generation + 1
        current_view = prev_view
        execute_view(prev_view)
    else
        current_browse_handle = nil
        current_view = nil
    end
end

local function navigate_to(next_view)
    if current_view then
        if #browse_history >= 50 then
            table.remove(browse_history, 1)
        end
        browse_history[#browse_history + 1] = current_view
    end
    nav_generation = nav_generation + 1
    current_view = next_view
    execute_view(next_view)
end

local open_settings

local function prompt_login(on_finish)
    local cur_server = plugin.storage.get("server_url", "")
    local cur_user = plugin.storage.get("username", "")

    plugin.show_text_input("Server URL", cur_server, false, function(url)
        if not url or url == "" then return end
        local norm_url, err = validate_and_normalize_server_url(url)
        if not norm_url then
            plugin.show_toast(err or "Invalid server URL")
            return
        end

        plugin.show_text_input("Username", cur_user, false, function(user)
            if not user or user == "" then return end

            plugin.show_text_input("Password", nil, true, function(pwd)
                do_login(norm_url, user, pwd or "", on_finish)
            end)
        end)
    end)
end

open_settings = function()
    local server_url = plugin.storage.get("server_url", "")
    local server_kind = plugin.storage.get("server_kind", "jellyfin")
    local username = plugin.storage.get("username", "")
    local is_logged = is_authenticated()
    local verify_tls = is_tls_verify_enabled()
    local page_size = tostring(get_clamped_page_size())

    local items = {
        {
            type = "row",
            label = "Server URL: " .. (server_url ~= "" and server_url or "Not Set"),
            on_select = function()
                plugin.show_text_input("Server URL", server_url, false, function(new_url)
                    if new_url and new_url ~= "" then
                        local norm, err = validate_and_normalize_server_url(new_url)
                        if not norm then
                            plugin.show_toast(err or "Invalid server URL")
                            return
                        end
                        clear_auth_state()
                        local ok = plugin.storage.set("server_url", norm)
                        if not ok then
                            plugin.show_toast("Failed to save server URL")
                            return
                        end
                        plugin.show_toast("Server URL updated")
                    end
                end)
            end,
        },
        {
            type = "row",
            label = "Server Type: " .. (server_kind == "emby" and "Emby" or "Jellyfin"),
            on_select = function()
                local new_kind = (server_kind == "emby") and "jellyfin" or "emby"
                clear_auth_state()
                local ok = plugin.storage.set("server_kind", new_kind)
                if not ok then
                    plugin.show_toast("Failed to save server type")
                    return
                end
                plugin.show_toast("Switched to " .. (new_kind == "emby" and "Emby" or "Jellyfin"))
                open_settings()
            end,
        },
        {
            type = "row",
            label = "Username: " .. (username ~= "" and username or "Not Set"),
            on_select = function()
                plugin.show_text_input("Username", username, false, function(new_user)
                    if new_user and new_user ~= "" then
                        clear_auth_state()
                        local ok = plugin.storage.set("username", new_user)
                        if not ok then
                            plugin.show_toast("Failed to save username")
                            return
                        end
                        plugin.show_toast("Username updated")
                    end
                end)
            end,
        },
        {
            type = "toggle",
            label = "Verify HTTPS TLS",
            value = verify_tls,
            on_change = function(val)
                local ok = plugin.storage.set("verify_tls", val and "1" or "0")
                if not ok then
                    plugin.show_toast("Failed to save TLS setting")
                end
            end,
        },
        {
            type = "row",
            label = "Page Size: " .. page_size .. " items",
            on_select = function()
                local new_size = (page_size == "25") and "10" or "25"
                local ok = plugin.storage.set("page_size", new_size)
                if not ok then
                    plugin.show_toast("Failed to save page size")
                    return
                end
                open_settings()
            end,
        },
    }

    if is_logged then
        items[#items + 1] = {
            type = "row",
            label = "Log Out (" .. (username ~= "" and username or "Active") .. ")",
            on_select = function()
                do_logout()
                open_settings()
            end,
        }
    else
        items[#items + 1] = {
            type = "row",
            label = "Log In",
            on_select = function()
                prompt_login()
            end,
        }
    end

    plugin.show_settings_list("Jellyfin & Emby", items, { update = true })
end

local function prompt_search(library)
    local lib_name = (type(library) == "table") and safe_string(library.Name, "Music", 128) or "Music"
    local title = "Search " .. lib_name
    plugin.show_text_input(title, "", false, function(query)
        if not query or query == "" then return end
        navigate_to({ type = "search", library = library, query = query })
    end)
end

-- View rendering execution dispatcher
execute_view = function(view)
    if not is_authenticated() then
        open_settings()
        return
    end

    local page_size = get_clamped_page_size()
    local user_id = plugin.storage.get("user_id", "")

    if view.type == "libraries" then
        local endpoint = (user_id ~= "") and ("Users/" .. user_id .. "/Views") or "UserViews"
        request_api("GET", endpoint, nil, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local music_libs = {}
            for _, lib in ipairs(items) do
                if type(lib) == "table" and (type(lib.CollectionType) == "string") and lib.CollectionType:lower() == "music" then
                    music_libs[#music_libs + 1] = lib
                end
            end

            local final_libs = (#music_libs > 0) and music_libs or items
            local labels = {}
            local actions = {}

            if #browse_history > 0 then
                labels[#labels + 1] = "[< Back]"
                actions[#actions + 1] = go_back
            end

            for _, lib in ipairs(final_libs) do
                if type(lib) == "table" then
                    labels[#labels + 1] = safe_string(lib.Name, "Unnamed Library", 128)
                    actions[#actions + 1] = function()
                        navigate_to({ type = "library_menu", library = lib })
                    end
                end
            end

            labels[#labels + 1] = "Search Music"
            actions[#actions + 1] = function() prompt_search(nil) end

            labels[#labels + 1] = "Playback Format"
            actions[#actions + 1] = show_playback_format_screen

            labels[#labels + 1] = "Settings & Account"
            actions[#actions + 1] = open_settings

            render_screen("Music Libraries", labels, function(index)
                if actions[index] then actions[index]() end
            end)
        end)

    elseif view.type == "library_menu" then
        local lib = (type(view.library) == "table") and view.library or {}
        local lib_name = safe_string(lib.Name, "Library", 128)
        local labels = {
            "[< Back]",
            "Artists",
            "Albums",
            "Songs",
            "Search in Library",
        }
        local actions = {
            go_back,
            function() navigate_to({ type = "artists", library = lib, start_index = 0 }) end,
            function() navigate_to({ type = "albums", library = lib, start_index = 0 }) end,
            function() navigate_to({ type = "songs", library = lib, start_index = 0 }) end,
            function() prompt_search(lib) end,
        }
        render_screen(lib_name, labels, function(index)
            if actions[index] then actions[index]() end
        end)

    elseif view.type == "artists" then
        local lib = (type(view.library) == "table") and view.library or {}
        local start_idx = to_positive_integer(view.start_index)
        local params = {
            ParentId = lib.Id,
            SortBy = "SortName",
            SortOrder = "Ascending",
            StartIndex = start_idx,
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Artists", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local total = (type(data) == "table" and to_positive_integer(data.TotalRecordCount)) or #items
            if total < #items then total = #items end
            local labels = {}
            local actions = {}

            labels[#labels + 1] = "[< Back]"
            actions[#actions + 1] = go_back

            if start_idx > 0 then
                labels[#labels + 1] = "[< Previous Page]"
                actions[#actions + 1] = function()
                    view.start_index = math.max(0, start_idx - page_size)
                    execute_view(view)
                end
            end

            for _, art in ipairs(items) do
                if #labels >= 500 then break end
                if type(art) == "table" then
                    labels[#labels + 1] = safe_string(art.Name, "Unknown Artist", 128)
                    actions[#actions + 1] = function()
                        navigate_to({ type = "artist_albums", library = lib, artist = art, start_index = 0 })
                    end
                end
            end

            if (start_idx + #items < total) and (#labels < 500) then
                labels[#labels + 1] = "[Next Page >]"
                actions[#actions + 1] = function()
                    view.start_index = start_idx + page_size
                    execute_view(view)
                end
            end

            local title = string.format("Artists (%d-%d / %d)", start_idx + 1, start_idx + #items, total)
            render_screen(title, labels, function(index)
                if actions[index] then actions[index]() end
            end)
        end)

    elseif view.type == "artist_albums" then
        local lib = (type(view.library) == "table") and view.library or {}
        local art = (type(view.artist) == "table") and view.artist or {}
        local start_idx = to_positive_integer(view.start_index)
        local params = {
            ArtistIds = art.Id,
            IncludeItemTypes = "MusicAlbum",
            Recursive = "true",
            SortBy = "ProductionYear,SortName",
            SortOrder = "Descending",
            StartIndex = start_idx,
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if lib and lib.Id then params.ParentId = lib.Id end
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Items", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local total = (type(data) == "table" and to_positive_integer(data.TotalRecordCount)) or #items
            if total < #items then total = #items end
            local labels = {}
            local actions = {}

            labels[#labels + 1] = "[< Back]"
            actions[#actions + 1] = go_back

            if start_idx > 0 then
                labels[#labels + 1] = "[< Previous Page]"
                actions[#actions + 1] = function()
                    view.start_index = math.max(0, start_idx - page_size)
                    execute_view(view)
                end
            end

            for _, alb in ipairs(items) do
                if #labels >= 500 then break end
                if type(alb) == "table" then
                    local yr_num = to_positive_integer(alb.ProductionYear)
                    local yr = (yr_num > 0) and (" (" .. yr_num .. ")") or ""
                    labels[#labels + 1] = safe_string(alb.Name, "Unknown Album", 128) .. yr
                    actions[#actions + 1] = function()
                        navigate_to({ type = "album_tracks", album = alb, library = lib, start_index = 0 })
                    end
                end
            end

            if (start_idx + #items < total) and (#labels < 500) then
                labels[#labels + 1] = "[Next Page >]"
                actions[#actions + 1] = function()
                    view.start_index = start_idx + page_size
                    execute_view(view)
                end
            end

            local art_name = safe_string(art.Name, "Artist", 128)
            local title = string.format("%s Albums (%d-%d / %d)", art_name, start_idx + 1, start_idx + #items, total)
            render_screen(title, labels, function(index)
                if actions[index] then actions[index]() end
            end)
        end)

    elseif view.type == "albums" then
        local lib = (type(view.library) == "table") and view.library or {}
        local start_idx = to_positive_integer(view.start_index)
        local params = {
            ParentId = lib.Id,
            IncludeItemTypes = "MusicAlbum",
            Recursive = "true",
            SortBy = "SortName",
            SortOrder = "Ascending",
            StartIndex = start_idx,
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Items", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local total = (type(data) == "table" and to_positive_integer(data.TotalRecordCount)) or #items
            if total < #items then total = #items end
            local labels = {}
            local actions = {}

            labels[#labels + 1] = "[< Back]"
            actions[#actions + 1] = go_back

            if start_idx > 0 then
                labels[#labels + 1] = "[< Previous Page]"
                actions[#actions + 1] = function()
                    view.start_index = math.max(0, start_idx - page_size)
                    execute_view(view)
                end
            end

            for _, alb in ipairs(items) do
                if #labels >= 500 then break end
                if type(alb) == "table" then
                    local a_label = safe_artist_name(alb)
                    local by_a = (a_label ~= "Unknown Artist") and (" - " .. a_label) or ""
                    labels[#labels + 1] = safe_string(alb.Name, "Unknown Album", 128) .. by_a
                    actions[#actions + 1] = function()
                        navigate_to({ type = "album_tracks", album = alb, library = lib, start_index = 0 })
                    end
                end
            end

            if (start_idx + #items < total) and (#labels < 500) then
                labels[#labels + 1] = "[Next Page >]"
                actions[#actions + 1] = function()
                    view.start_index = start_idx + page_size
                    execute_view(view)
                end
            end

            local title = string.format("Albums (%d-%d / %d)", start_idx + 1, start_idx + #items, total)
            render_screen(title, labels, function(index)
                if actions[index] then actions[index]() end
            end)
        end)

    elseif view.type == "album_tracks" then
        local alb = (type(view.album) == "table") and view.album or {}
        local start_idx = to_positive_integer(view.start_index)
        local params = {
            ParentId = alb.Id,
            IncludeItemTypes = "Audio",
            SortBy = "ParentIndexNumber,IndexNumber,SortName",
            SortOrder = "Ascending",
            StartIndex = start_idx,
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Items", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local tracks = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local total = (type(data) == "table" and to_positive_integer(data.TotalRecordCount)) or #tracks
            if total < #tracks then total = #tracks end
            local labels = {}
            local actions = {}

            labels[#labels + 1] = "[< Back]"
            actions[#actions + 1] = go_back

            if #tracks < total then
                labels[#labels + 1] = string.format("[Play Page (%d of %d tracks)]", #tracks, total)
            else
                labels[#labels + 1] = string.format("[Play Album (%d tracks)]", #tracks)
            end
            actions[#actions + 1] = function()
                play_items_queue(tracks, nil)
            end

            if start_idx > 0 then
                labels[#labels + 1] = "[< Previous Page]"
                actions[#actions + 1] = function()
                    view.start_index = math.max(0, start_idx - page_size)
                    execute_view(view)
                end
            end

            local has_multi_disc = false
            for _, trk in ipairs(tracks) do
                if type(trk) == "table" and to_positive_integer(trk.ParentIndexNumber) > 1 then
                    has_multi_disc = true
                    break
                end
            end

            for _, trk in ipairs(tracks) do
                if #labels >= 500 then break end
                if type(trk) == "table" then
                    local p_idx = to_positive_integer(trk.ParentIndexNumber)
                    local idx = to_positive_integer(trk.IndexNumber)
                    local trk_name = safe_track_name(trk)
                    local track_label
                    if has_multi_disc and p_idx > 0 then
                        track_label = string.format("D%d.%02d %s", p_idx, idx, trk_name)
                    elseif idx > 0 then
                        track_label = string.format("%d. %s", idx, trk_name)
                    else
                        track_label = trk_name
                    end

                    local trk_id = (type(trk.Id) == "string" or type(trk.Id) == "number") and tostring(trk.Id) or nil
                    labels[#labels + 1] = track_label
                    actions[#actions + 1] = function()
                        play_items_queue(tracks, trk_id)
                    end
                end
            end

            if (start_idx + #tracks < total) and (#labels < 500) then
                labels[#labels + 1] = "[Next Page >]"
                actions[#actions + 1] = function()
                    view.start_index = start_idx + page_size
                    execute_view(view)
                end
            end

            local alb_title = safe_string(alb.Name, "Album Tracks", 128)
            render_screen(alb_title, labels, function(index)
                if actions[index] then actions[index]() end
            end)
        end)

    elseif view.type == "songs" then
        local lib = (type(view.library) == "table") and view.library or {}
        local start_idx = to_positive_integer(view.start_index)
        local params = {
            ParentId = lib.Id,
            IncludeItemTypes = "Audio",
            Recursive = "true",
            SortBy = "SortName",
            SortOrder = "Ascending",
            StartIndex = start_idx,
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Items", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local total = (type(data) == "table" and to_positive_integer(data.TotalRecordCount)) or #items
            if total < #items then total = #items end
            local labels = {}
            local actions = {}

            labels[#labels + 1] = "[< Back]"
            actions[#actions + 1] = go_back

            if start_idx > 0 then
                labels[#labels + 1] = "[< Previous Page]"
                actions[#actions + 1] = function()
                    view.start_index = math.max(0, start_idx - page_size)
                    execute_view(view)
                end
            end

            for _, trk in ipairs(items) do
                if #labels >= 500 then break end
                if type(trk) == "table" then
                    local art = safe_artist_name(trk)
                    local by_art = (art ~= "Unknown Artist") and (" - " .. art) or ""
                    labels[#labels + 1] = safe_track_name(trk) .. by_art
                    actions[#actions + 1] = function()
                        play_single_item(trk)
                    end
                end
            end

            if (start_idx + #items < total) and (#labels < 500) then
                labels[#labels + 1] = "[Next Page >]"
                actions[#actions + 1] = function()
                    view.start_index = start_idx + page_size
                    execute_view(view)
                end
            end

            local title = string.format("Songs (%d-%d / %d)", start_idx + 1, start_idx + #items, total)
            render_screen(title, labels, function(index)
                if actions[index] then actions[index]() end
            end)
        end)

    elseif view.type == "search" then
        local lib = (type(view.library) == "table") and view.library or {}
        local query = safe_string(view.query, "", 128)
        local params = {
            SearchTerm = query,
            IncludeItemTypes = "Audio,MusicAlbum,MusicArtist",
            Recursive = "true",
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if lib and lib.Id then params.ParentId = lib.Id end
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Items", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local labels = {}
            local actions = {}

            labels[#labels + 1] = "[< Back]"
            actions[#actions + 1] = go_back

            for _, it in ipairs(items) do
                if #labels >= 500 then break end
                if type(it) == "table" then
                    local it_type = (type(it.Type) == "string") and it.Type or ""
                    local it_name = safe_string(it.Name, "Item", 128)
                    if it_type == "Audio" then
                        labels[#labels + 1] = "[Song] " .. it_name
                        actions[#actions + 1] = function() play_single_item(it) end
                    elseif it_type == "MusicAlbum" then
                        labels[#labels + 1] = "[Album] " .. it_name
                        actions[#actions + 1] = function()
                            navigate_to({ type = "album_tracks", album = it, library = lib, start_index = 0 })
                        end
                    elseif it_type == "MusicArtist" then
                        labels[#labels + 1] = "[Artist] " .. it_name
                        actions[#actions + 1] = function()
                            navigate_to({ type = "artist_albums", library = lib, artist = it, start_index = 0 })
                        end
                    else
                        labels[#labels + 1] = it_name
                        actions[#actions + 1] = function() play_single_item(it) end
                    end
                end
            end

            if #labels == 1 then
                labels[#labels + 1] = "(No results found)"
                actions[#actions + 1] = function() end
            end

            render_screen("Search: " .. query, labels, function(index)
                if actions[index] then actions[index]() end
            end)
        end)
    end
end

local function open_stream_media_tile()
    if not is_authenticated() then
        open_settings()
        return
    end

    browse_history = {}
    current_browse_handle = nil
    nav_generation = nav_generation + 1
    current_view = { type = "libraries" }
    execute_view(current_view)
end

-- Plugin entry registrations
plugin.register_stream_media_tile("Jellyfin / Emby", open_stream_media_tile, "stream_media/radio.png")
plugin.register_list_item("settings", "Jellyfin & Emby", open_settings)

-- Test export hook
if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        do_login = do_login,
        do_logout = do_logout,
        is_authenticated = is_authenticated,
        validate_and_normalize_server_url = validate_and_normalize_server_url,
        join_endpoint = join_endpoint,
        url_encode = url_encode,
        build_query = build_query,
        api_url = api_url,
        make_auth_header = make_auth_header,
        is_tls_verify_enabled = is_tls_verify_enabled,
        cancel_active_requests = cancel_active_requests,
        account_generation = function() return account_generation end,
        nav_generation = function() return nav_generation end,
        evaluate_track_compatibility = evaluate_track_compatibility,
        resolve_item_media = resolve_item_media,
        build_remote_track = build_remote_track,
        play_single_item = play_single_item,
        play_items_queue = play_items_queue,
        show_playback_format_screen = show_playback_format_screen,
        open_settings = open_settings,
        open_stream_media_tile = open_stream_media_tile,
        request_api = request_api,
        navigate_to = navigate_to,
        go_back = go_back,
        get_current_view = function() return current_view end,
        get_browse_history = function() return browse_history end,
        get_current_browse_handle = function() return current_browse_handle end,
        execute_view = execute_view,
        clear_auth_state = clear_auth_state,
    }
end
