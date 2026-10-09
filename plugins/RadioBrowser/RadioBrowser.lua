plugin.define({ id = "compas.radio_browser", name = "Radio Browser", version = "1.0", api_min = 15 })

-- Searches the Radio Browser directory and appends favorites to Radio.txt
-- in the same "Name | http(s)://direct-stream" form Net Radio already reads.
-- Existing Radio.txt bytes are only extended, never rewritten.

local RADIO_FILE = plugin.sd_root() .. "/Radio.txt"
local USER_AGENT = "Compas/1.0"
local PAGE_SIZE = 20
local MAX_SERVER_ATTEMPTS = 4
local MAX_OFFSET = 480
local MAX_FILE_BYTES, MAX_LINE_BYTES, MAX_STATIONS = 65536, 1024, 500
-- plugin.play_list copies each path into char[512], so 511 bytes is the limit.
local MAX_PLAY_URL = 511
local FALLBACK_SERVERS = {
    "https://de1.api.radio-browser.info",
    "https://all.api.radio-browser.info",
}

local servers = { FALLBACK_SERVERS[1], FALLBACK_SERVERS[2] }
local discovery_started = false
local search_generation = 0

local function trim(value)
    return (tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function url_encode(value)
    return (tostring(value):gsub("([^%w%-%.%_%~])", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

local function lower_scheme(url)
    return (url:gsub("^([Hh][Tt][Tt][Pp][Ss]?)://", function(scheme)
        return scheme:lower() .. "://"
    end))
end

local function sanitize_name(name)
    local text = tostring(name or ""):gsub("[%c|]", " ")
    text = trim(text:gsub("%s+", " "))
    if text == "" then text = "Station" end
    if #text > 120 then text = text:sub(1, 120) end
    return text
end

local function sanitize_query(query)
    local text = tostring(query or ""):gsub("%c", " ")
    text = trim(text:gsub("%s+", " "))
    if #text > 80 then text = text:sub(1, 80) end
    return text
end

local function unsupported_path(url)
    local path = url:match("^https?://[^/%?#]+([^?#]*)") or ""
    path = path:lower()
    return path:match("%.m3u8?$") ~= nil
        or path:match("%.pls$") ~= nil
        or path:match("%.asx$") ~= nil
        or path:match("%.xspf$") ~= nil
        or path:match("%.ogg$") ~= nil
        or path:match("%.oga$") ~= nil
        or path:match("%.opus$") ~= nil
        or path:match("%.wav$") ~= nil
        or path:match("%.wma$") ~= nil
end

local function valid_authority(authority)
    if type(authority) ~= "string" or authority == "" then return false end
    if authority:find("@", 1, true) or authority:find("?", 1, true) or authority:find("#", 1, true) then
        return false
    end
    local host, port = authority:match("^([%w%-%.]+):(%d+)$")
    if not host then host = authority:match("^([%w%-%.]+)$") end
    if not host or host == "" or port == "" then return false end
    if host:sub(1, 1) == "." or host:sub(-1) == "." then return false end
    return true
end

local function normalized_base(url)
    if type(url) ~= "string" then return nil end
    if url:find("%c") or url:find("%s") or url:find("|", 1, true) then return nil end
    local base = lower_scheme(url:gsub("#.*$", ""))
    local scheme, authority = base:match("^(https?)://([^/%?#]*)")
    if not scheme or not valid_authority(authority) then return nil end
    if #base > MAX_PLAY_URL or unsupported_path(base) then return nil end
    return base
end

local function canonical_url(url)
    local base = normalized_base(url)
    if not base then return nil end
    local scheme, host, rest = base:match("^(https?)://([^/%?#]+)(.*)$")
    if not scheme or not host then return nil end
    host = host:lower()
    if scheme == "http" then host = host:gsub(":80$", "") end
    if scheme == "https" then host = host:gsub(":443$", "") end
    return scheme .. "://" .. host .. (rest or "")
end

local function codec_kind(codec)
    local kind = tostring(codec or ""):lower():gsub("%s+", "")
    if kind == "mp3" then return "mp3" end
    if kind == "flac" then return "flac" end
    if kind == "aac" then return "aac" end
    if kind == "aac+" or kind == "aacp" or kind == "aacplus" then return "aacp" end
    return nil
end

local function is_hls(value)
    if value == true then return true end
    return tonumber(value) == 1
end

local function apply_hint(base, kind)
    if kind == "flac" then return base .. "#.flac" end
    if kind == "aac" then return base .. "#.aac" end
    if kind == "aacp" then return base .. "#.aacp" end
    return base
end

local function playable_url(station)
    if type(station) ~= "table" or is_hls(station.hls) then return nil end
    local kind = codec_kind(station.codec)
    if not kind then return nil end
    local base = normalized_base(station.url_resolved)
    if not base then base = normalized_base(station.url) end
    if not base then return nil end
    local hinted = apply_hint(base, kind)
    if #hinted > MAX_PLAY_URL then return nil end
    return hinted
end

local function clean_uuid(value)
    if type(value) ~= "string" then return nil end
    local uuid = value:lower()
    if not uuid:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
        return nil
    end
    return uuid
end

local function backend_url(name)
    if type(name) ~= "string" then return nil end
    local host = name:lower()
    if host:find("..", 1, true) then return nil end
    if not host:match("^[a-z0-9%-%.]+%.api%.radio%-browser%.info$") then return nil end
    return "https://" .. host
end

local function is_list(value)
    if type(value) ~= "table" then return false end
    local count = 0
    for key in pairs(value) do
        if type(key) ~= "number" then return false end
        count = count + 1
    end
    return count == #value
end

local function http_json(method, url, body, limit, callback)
    local options = {
        url = url,
        method = method,
        headers = { ["User-Agent"] = USER_AGENT },
        verify_tls = true,
        max_response_bytes = limit,
        connect_timeout_ms = 8000,
        read_timeout_ms = 12000,
        total_timeout_ms = 20000,
        redirect_limit = 0,
    }
    if body then
        options.body = body
        options.content_type = "application/x-www-form-urlencoded"
    end
    return plugin.http_request(options, callback)
end

local function form_body(query, offset)
    return "name=" .. url_encode(query)
        .. "&limit=" .. tostring(PAGE_SIZE)
        .. "&offset=" .. tostring(offset)
        .. "&hidebroken=true&order=name"
end

-- Same line rules as Net Radio: comments and blanks ignored, "Name | URL"
-- or a bare http(s) URL. `limit` caps the list used by the screen. Dedupe
-- passes no limit so a duplicate past the first 500 still matches.
local function scan_stations(body, limit)
    local labels, urls = {}, {}
    local truncated = false
    if type(body) ~= "string" then return labels, urls, truncated end
    if #body > MAX_FILE_BYTES then
        body = body:sub(1, MAX_FILE_BYTES):match("^(.*)\n") or ""
        truncated = true
    end
    for line in (body .. "\n"):gmatch("(.-)\n") do
        if #line > MAX_LINE_BYTES then
            truncated = true
        else
            local text = trim(line:gsub("\r$", ""))
            if text ~= "" and text:sub(1, 1) ~= "#" then
                local name, url = text:match("^(.-)%s*|%s*(https?://.+)$")
                if not url and text:match("^https?://") then
                    name, url = text, text
                end
                if url and limit and #urls >= limit then
                    truncated = true
                    break
                end
                if url then
                    name, url = trim(name), trim(url)
                    if name == "" then name = url end
                    labels[#labels + 1] = name
                    urls[#urls + 1] = url
                end
            end
        end
    end
    return labels, urls, truncated
end

local function parse_stations(body)
    return scan_stations(body, MAX_STATIONS)
end

local function read_radio()
    local file = io.open(RADIO_FILE, "rb")
    if not file then return nil end
    local body = file:read(MAX_FILE_BYTES + 1) or ""
    file:close()
    return body
end

local function already_saved(play_url)
    local body = read_radio()
    if not body then return false end
    if #body > MAX_FILE_BYTES then return nil end
    local want = canonical_url(play_url)
    if not want then return nil end
    local _, urls = scan_stations(body)
    for i = 1, #urls do
        if canonical_url(urls[i]) == want then return true end
    end
    return false
end

local function append_line(line)
    local file, _, open_error = io.open(RADIO_FILE, "r+b")
    if not file then
        -- Only ENOENT proves the path is missing. Permission and other
        -- errors must preserve the file, even if write-only access works.
        if open_error ~= 2 or #line > MAX_FILE_BYTES then return false end
        file = io.open(RADIO_FILE, "ab")
        if not file then return false end
        -- Append mode also protects a file created between the two opens.
        if file:seek("end") ~= 0 then
            file:close()
            return false
        end
        local ok = file:write(line)
        local closed = file:close()
        return ok and closed and true
    end
    local size = file:seek("end")
    if type(size) ~= "number" then
        file:close()
        return false
    end
    local extra = #line
    if size > 0 then
        if not file:seek("set", size - 1) then
            file:close()
            return false
        end
        local last = file:read(1)
        if not file:seek("end") then
            file:close()
            return false
        end
        if last ~= "\n" then extra = extra + 1 end
    end
    if size + extra > MAX_FILE_BYTES then
        file:close()
        plugin.show_toast("Radio.txt is too large to update")
        return false
    end
    if extra ~= #line and not file:write("\n") then
        file:close()
        return false
    end
    local ok = file:write(line)
    local closed = file:close()
    return ok and closed and true
end

local function append_favorite(name, play_url)
    if type(play_url) ~= "string" or #play_url > MAX_PLAY_URL or not normalized_base(play_url) then
        plugin.show_toast("Could not save that station")
        return false
    end
    if play_url:find("%c") or play_url:find("%s") or play_url:find("|", 1, true) then
        plugin.show_toast("Could not save that station")
        return false
    end
    local hint = play_url:match("#(%.flac)$") or play_url:match("#(%.aacp)$") or play_url:match("#(%.aac)$")
    if play_url:find("#", 1, true) and not hint then
        plugin.show_toast("Could not save that station")
        return false
    end
    local safe_name = sanitize_name(name)
    local line = safe_name .. " | " .. play_url .. "\n"
    if #line > MAX_LINE_BYTES then
        plugin.show_toast("Could not save that station")
        return false
    end
    local saved = already_saved(play_url)
    if saved == nil then
        plugin.show_toast("Radio.txt is too large to update")
        return false
    end
    if saved then
        plugin.show_toast("Already in Radio.txt")
        return true
    end
    if not append_line(line) then
        plugin.show_toast("Could not save that station")
        return false
    end
    plugin.show_toast("Saved to Radio.txt")
    return true
end

local function open_favorites()
    local body = read_radio()
    if not body or body == "" then
        plugin.show_toast("No saved stations in Radio.txt")
        return
    end
    if #body > MAX_FILE_BYTES then
        plugin.show_toast("Some stations could not be listed")
    end
    local labels, urls, truncated = parse_stations(body)
    if #urls == 0 then
        plugin.show_list("Saved favorites", { "Check again" }, function(index)
            if index == 1 then open_favorites() end
        end)
        return
    end
    plugin.show_list("Saved favorites", labels, function(index)
        local url = urls[index]
        if url then
            if #url > MAX_PLAY_URL or not normalized_base(url) then
                plugin.show_toast("This station URL cannot be played")
                return
            end
            plugin.play_list({ url }, 1)
        end
    end)
    if truncated then plugin.show_toast("Some stations could not be listed") end
end

local function report_click(server, uuid)
    if not server or not uuid then return end
    http_json("GET", server .. "/json/url/" .. uuid, nil, 8192, function() end)
end

local function play_station(station)
    if not station or not station.play_url then
        plugin.show_toast("This station cannot be played")
        return
    end
    plugin.play_list({ station.play_url }, 1)
    report_click(station.server, station.uuid)
end

local begin_search

local function show_page(data, server, query, offset, generation)
    if generation ~= search_generation then return end
    local raw_count = math.min(#data, PAGE_SIZE)
    local visible = {}
    for i = 1, raw_count do
        local row = data[i]
        if type(row) == "table" then
            local play_url = playable_url(row)
            if play_url then
                visible[#visible + 1] = {
                    name = sanitize_name(row.name),
                    play_url = play_url,
                    uuid = clean_uuid(row.stationuuid),
                    server = server,
                }
            end
        end
    end
    if generation ~= search_generation then return end
    if #visible == 0 and raw_count < PAGE_SIZE then
        plugin.show_toast("No playable stations found")
        return
    end
    local items = {}
    for i = 1, #visible do items[i] = visible[i].name end
    local previous_at, next_at = nil, nil
    if offset > 0 then
        items[#items + 1] = "Previous page"
        previous_at = #items
    end
    if raw_count >= PAGE_SIZE and offset + PAGE_SIZE <= MAX_OFFSET then
        items[#items + 1] = "Next page"
        next_at = #items
    end
    if #items == 0 then
        plugin.show_toast("No playable stations found")
        return
    end
    plugin.show_list("Stations", items, function(index)
        if index == previous_at then
            begin_search(query, offset - PAGE_SIZE)
            return
        end
        if index == next_at then
            begin_search(query, offset + PAGE_SIZE)
            return
        end
        local station = visible[index]
        if not station then return end
        plugin.show_list(station.name, { "Play", "Save favorite" }, function(action)
            if action == 1 then play_station(station)
            elseif action == 2 then append_favorite(station.name, station.play_url) end
        end)
    end)
    if #visible == 0 then
        plugin.show_toast("No playable stations on this page")
    end
end

local function ensure_discovery()
    if discovery_started then return end
    discovery_started = true
    http_json("GET", FALLBACK_SERVERS[1] .. "/json/servers", nil, 16384, function(status, body, err)
        if err or status ~= 200 or type(body) ~= "string" then return end
        local data = plugin.json_decode(body)
        if not is_list(data) then return end
        local found = {}
        local function add(url)
            if not url or #found >= 4 then return end
            for i = 1, #found do
                if found[i] == url then return end
            end
            found[#found + 1] = url
        end
        for i = 1, math.min(#data, 8) do
            if #found >= 2 then break end
            local row = data[i]
            if type(row) == "table" then add(backend_url(row.name)) end
        end
        if #found > 0 then
            for _, fallback in ipairs(FALLBACK_SERVERS) do add(fallback) end
            servers = found
        end
    end)
end

local function failover(status, err)
    if err or type(status) ~= "number" then return true end
    if status == 408 or status == 429 or status >= 500 then return true end
    if status >= 300 and status < 400 then return true end
    return false
end

begin_search = function(query, offset)
    query = sanitize_query(query)
    if query == "" then
        plugin.show_toast("Enter a station name")
        return
    end
    offset = math.floor(tonumber(offset) or 0)
    if offset < 0 then offset = 0 end
    if offset > MAX_OFFSET then
        plugin.show_toast("No more stations")
        return
    end
    search_generation = search_generation + 1
    local generation = search_generation
    ensure_discovery()
    -- Discovery updates later searches without reshuffling an active retry.
    local search_servers = {}
    for i, server in ipairs(servers) do search_servers[i] = server end
    local tries = 0
    local function attempt(index)
        if generation ~= search_generation then return end
        tries = tries + 1
        if tries > MAX_SERVER_ATTEMPTS or not search_servers[index] then
            plugin.show_toast("Could not reach Radio Browser")
            return
        end
        local server = search_servers[index]
        local handle = http_json("POST", server .. "/json/stations/search", form_body(query, offset), 65536,
            function(status, body, err)
                if generation ~= search_generation then return end
                if failover(status, err) then
                    attempt(index + 1)
                    return
                end
                local data = type(body) == "string" and plugin.json_decode(body) or nil
                if status ~= 200 or not is_list(data) then
                    if tries < MAX_SERVER_ATTEMPTS and search_servers[index + 1] then
                        attempt(index + 1)
                    else
                        plugin.show_toast("Could not read station results")
                    end
                    return
                end
                show_page(data, server, query, offset, generation)
            end)
        if not handle then attempt(index + 1) end
    end
    attempt(1)
end

local function prompt_search()
    local ok = plugin.show_text_input("Station name", nil, false, function(text)
        if text == nil or trim(text) == "" then return end
        begin_search(text, 0)
    end)
    if not ok then plugin.show_toast("Could not open text entry. Try again.") end
end

local function open_browser()
    plugin.show_list("Radio Browser", { "Search stations", "Saved favorites" }, function(index)
        if index == 1 then prompt_search()
        elseif index == 2 then open_favorites() end
    end)
end

plugin.register_stream_media_tile("Radio Browser", open_browser, "stream_media/radio_row.png")

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        open_browser = open_browser,
        open_favorites = open_favorites,
        playable_url = playable_url,
        canonical_url = canonical_url,
        sanitize_name = sanitize_name,
        parse_stations = parse_stations,
        append_favorite = append_favorite,
        search = begin_search,
    }
end
