-- Test harness for JellyfinEmby on Compas API 16 with ui.list_update support.
local surface = require("api16_surface")

local harness = {}

local function decode_json(text)
    if type(text) ~= "string" then return nil, "not a string" end
    local i, n = 1, #text
    local parse_value

    local function skip()
        while i <= n and text:sub(i, i):match("%s") do i = i + 1 end
    end

    local function parse_string()
        if text:sub(i, i) ~= '"' then error("expected string at " .. i) end
        i = i + 1
        local out = {}
        while i <= n do
            local c = text:sub(i, i)
            if c == '"' then
                i = i + 1
                return table.concat(out)
            elseif c == "\\" then
                local e = text:sub(i + 1, i + 1)
                local map = { ['"'] = '"', ["\\"] = "\\", ["/"] = "/", b = "\b", f = "\f", n = "\n", r = "\r", t = "\t" }
                if e == "u" then
                    local hex = text:sub(i + 2, i + 5)
                    out[#out + 1] = utf8.char(tonumber(hex, 16) or 0)
                    i = i + 6
                else
                    out[#out + 1] = map[e] or e
                    i = i + 2
                end
            else
                out[#out + 1] = c
                i = i + 1
            end
        end
        error("unterminated string at " .. i)
    end

    local function parse_number()
        local s, e = text:find("^-?%d+%.?%d*[eE]?[%+%-]?%d*", i)
        if not s then error("expected number at " .. i) end
        local num = tonumber(text:sub(s, e))
        i = e + 1
        return num
    end

    local function parse_array()
        i = i + 1
        local arr = {}
        skip()
        if text:sub(i, i) == "]" then i = i + 1 return arr end
        while true do
            arr[#arr + 1] = parse_value()
            skip()
            local c = text:sub(i, i)
            if c == "]" then i = i + 1 return arr end
            if c ~= "," then error("expected ',' or ']' at " .. i) end
            i = i + 1
            skip()
        end
    end

    local function parse_object()
        i = i + 1
        local obj = {}
        skip()
        if text:sub(i, i) == "}" then i = i + 1 return obj end
        while true do
            skip()
            local key = parse_string()
            skip()
            if text:sub(i, i) ~= ":" then error("expected ':' at " .. i) end
            i = i + 1
            obj[key] = parse_value()
            skip()
            local c = text:sub(i, i)
            if c == "}" then i = i + 1 return obj end
            if c ~= "," then error("expected ',' or '}' at " .. i) end
            i = i + 1
        end
    end

    parse_value = function()
        skip()
        local c = text:sub(i, i)
        if c == '"' then return parse_string() end
        if c == "{" then return parse_object() end
        if c == "[" then return parse_array() end
        if c == "t" and text:sub(i, i + 3) == "true" then i = i + 4 return true end
        if c == "f" and text:sub(i, i + 4) == "false" then i = i + 5 return false end
        if c == "n" and text:sub(i, i + 3) == "null" then i = i + 4 return nil end
        if c == "-" or c:match("%d") then return parse_number() end
        error("unexpected character '" .. tostring(c) .. "' at " .. i)
    end

    local ok, value = pcall(parse_value)
    if not ok then return nil, value end
    return value
end

local function encode_string(text)
    return '"' .. text:gsub('[%z\1-\31\\"]', function(c)
        local map = { ['"'] = '\\"', ["\\"] = "\\\\", ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t" }
        return map[c] or string.format("\\u%04x", string.byte(c))
    end) .. '"'
end

local function is_array(value)
    local count, max = 0, 0
    for key in pairs(value) do
        if type(key) ~= "number" or key < 1 or key ~= math.floor(key) then return false end
        count = count + 1
        if key > max then max = key end
    end
    return count > 0 and count == max
end

local function encode_json(value)
    local kind = type(value)
    if kind == "nil" then return "null" end
    if kind == "boolean" then return value and "true" or "false" end
    if kind == "number" then
        if value ~= value or value == math.huge or value == -math.huge then return nil, "number" end
        if value == math.floor(value) and math.abs(value) < 2 ^ 53 then
            return string.format("%.0f", value)
        end
        return string.format("%.16g", value)
    end
    if kind == "string" then return encode_string(value) end
    if kind ~= "table" then return nil, "type" end
    if is_array(value) then
        local parts = {}
        for index = 1, #value do
            local encoded, err = encode_json(value[index])
            if not encoded then return nil, err end
            parts[index] = encoded
        end
        return "[" .. table.concat(parts, ",") .. "]"
    end
    local parts = {}
    for key, item in pairs(value) do
        if type(key) ~= "string" then return nil, "key" end
        local encoded, err = encode_json(item)
        if not encoded then return nil, err end
        parts[#parts + 1] = encode_string(key) .. ":" .. encoded
    end
    table.sort(parts)
    return "{" .. table.concat(parts, ",") .. "}"
end

local function md5_mock(text)
    local hash = 2166136261
    for index = 1, #tostring(text) do
        hash = (hash + string.byte(text, index) * index) % 4294967296
    end
    return string.format("%08x", hash)
end

function harness.new(opts)
    opts = opts or {}
    local storage_bag = opts.storage or {}
    local secrets_bag = opts.secrets or {}

    local self = {
        storage = storage_bag,
        secrets = secrets_bag,
        fail_storage = opts.fail_storage or false,
        fail_storage_key = opts.fail_storage_key or nil,
        fail_secrets = opts.fail_secrets or false,
        http_error_mode = opts.http_error_mode or nil,
        max_http_slots = opts.max_http_slots or nil,
        toasts = {},
        http_calls = {},
        cancels = {},
        remote_plays = {},
        remote_queues = {},
        stream_tiles = {},
        list_items = {},
        settings_screens = {},
        list_screens = {},
        text_inputs = {},
        active_playback_format = opts.playback_format or nil,
        capabilities = {
            ["playback.remote"] = true,
            ["playback.format"] = true,
            ["storage.secrets"] = true,
            ["storage.secrets_get"] = true,
            ["network.http.async"] = true,
            ["data.json"] = true,
            ["ui.list"] = true,
            ["ui.list_update"] = true,
            ["ui.list_showing"] = true,
            ["ui.settings"] = true,
            ["ui.text_input"] = true,
        },
        next_http_handle = 1,
        next_list_handle = 1,
    }

    if opts.capabilities then
        for k, v in pairs(opts.capabilities) do
            self.capabilities[k] = v
        end
    end

    local plugin = {}

    function plugin.define(def)
        self.definition = def
        assert(type(def) == "table", "plugin.define requires a table")
        assert(def.api_min == 16, "JellyfinEmby must declare api_min = 16")
    end

    function plugin.has_capability(token)
        return self.capabilities[token] == true
    end

    function plugin.show_toast(msg)
        self.toasts[#self.toasts + 1] = tostring(msg)
    end

    function plugin.md5(text)
        return md5_mock(text)
    end

    function plugin.json_encode(value)
        return encode_json(value)
    end

    function plugin.json_decode(text)
        return decode_json(text)
    end

    plugin.storage = {}
    function plugin.storage.get(key, default)
        if storage_bag[key] == nil then return default end
        return storage_bag[key]
    end
    function plugin.storage.set(key, value)
        if self.fail_storage then return false, "storage failure" end
        if self.fail_storage_key and self.fail_storage_key == key then return false, "storage failure" end
        storage_bag[key] = tostring(value)
        return true
    end
    function plugin.storage.delete(key)
        storage_bag[key] = nil
        return true
    end
    function plugin.storage.list()
        local keys = {}
        for k in pairs(storage_bag) do keys[#keys + 1] = k end
        table.sort(keys)
        return keys
    end

    plugin.secrets = {}
    function plugin.secrets.get(key)
        return secrets_bag[key]
    end
    function plugin.secrets.set(key, value)
        if self.fail_secrets then return false, "secrets storage failure" end
        secrets_bag[key] = tostring(value)
        return true
    end
    function plugin.secrets.delete(key)
        secrets_bag[key] = nil
        return true
    end
    function plugin.secrets.exists(key)
        return secrets_bag[key] ~= nil
    end

    function plugin.http_request(options, callback)
        if self.http_error_mode == "throw" then
            error("Invalid options: buffer allocation failure")
        elseif self.http_error_mode == "nil" then
            return nil, "Slot allocation failed"
        end

        if self.max_http_slots then
            local active_count = 0
            for _, c in ipairs(self.http_calls) do
                if not c.answered and not c.cancelled then
                    active_count = active_count + 1
                end
            end
            if active_count >= self.max_http_slots then
                return nil, "All HTTP slots in use (maximum " .. tostring(self.max_http_slots) .. ")"
            end
        end

        local call = {
            options = options,
            callback = callback,
            handle = self.next_http_handle,
            cancelled = false,
            answered = false,
        }
        self.next_http_handle = self.next_http_handle + 1
        self.http_calls[#self.http_calls + 1] = call
        return call.handle
    end

    function plugin.cancel(handle)
        self.cancels[#self.cancels + 1] = handle
        for _, call in ipairs(self.http_calls) do
            if call.handle == handle then
                call.cancelled = true
                return true
            end
        end
        return false
    end

    function plugin.play_remote(track)
        assert(type(track) == "table", "track must be a table")
        assert(track.provider and track.provider ~= "", "track provider required")
        assert(track.track_id and track.track_id ~= "", "track_id required")
        assert(track.stream_url and track.stream_url ~= "", "stream_url required")
        self.remote_plays[#self.remote_plays + 1] = track
        return true
    end

    function plugin.queue_remote_list(tracks, start_index)
        assert(type(tracks) == "table", "tracks must be a table")
        for _, t in ipairs(tracks) do
            assert(t.provider and t.provider ~= "", "provider required")
            assert(t.track_id and t.track_id ~= "", "track_id required")
            assert(t.stream_url and t.stream_url ~= "", "stream_url required")
        end
        self.remote_queues[#self.remote_queues + 1] = {
            tracks = tracks,
            start_index = start_index or 1,
        }
        return true
    end

    function plugin.register_stream_media_tile(label, on_open, icon)
        self.stream_tiles[#self.stream_tiles + 1] = {
            label = label,
            on_open = on_open,
            icon = icon,
        }
    end

    function plugin.register_list_item(list_id, label, on_open, options)
        self.list_items[#self.list_items + 1] = {
            list_id = list_id,
            label = label,
            on_open = on_open,
            options = options,
        }
    end

    function plugin.show_settings_list(title, items, options)
        self.settings_screens[#self.settings_screens + 1] = {
            title = title,
            items = items,
            options = options,
        }
    end

    function plugin.show_list(title, items, on_select, options)
        options = options or {}
        if options.replace then
            local rep_handle = options.replace
            if #self.list_screens == 0 or self.list_screens[#self.list_screens].handle ~= rep_handle then
                -- Stale, covered, or closed handle cannot be replaced
                return nil
            end
            local new_handle = self.next_list_handle
            self.next_list_handle = self.next_list_handle + 1
            self.list_screens[#self.list_screens] = {
                title = title,
                items = items,
                on_select = on_select,
                options = options,
                handle = new_handle,
            }
            return new_handle
        else
            local new_handle = self.next_list_handle
            self.next_list_handle = self.next_list_handle + 1
            self.list_screens[#self.list_screens + 1] = {
                title = title,
                items = items,
                on_select = on_select,
                options = options,
                handle = new_handle,
            }
            return new_handle
        end
    end

    function plugin.is_list_showing(handle)
        if not handle or #self.list_screens == 0 then return false end
        return self.list_screens[#self.list_screens].handle == handle
    end

    function self.pop_top_screen()
        if #self.list_screens > 0 then
            table.remove(self.list_screens)
            return true
        end
        return false
    end

    function plugin.show_text_input(title, initial, is_password, on_submit)
        self.text_inputs[#self.text_inputs + 1] = {
            title = title,
            initial = initial,
            is_password = is_password,
            on_submit = on_submit,
        }
        return true
    end

    function plugin.get_playback_format()
        return self.active_playback_format
    end

    self.plugin = surface(plugin)

    function self.reply(index, status, body, err, headers)
        local call = self.http_calls[index]
        if not call then error("No HTTP call at index " .. tostring(index)) end
        if call.answered then error("HTTP call " .. tostring(index) .. " already answered") end
        call.answered = true
        if not call.cancelled then
            call.callback(status, body, err, headers)
        end
    end

    function self.load(plugin_path)
        _G.COMPAS_PLUGIN_TEST = true
        local env = {
            plugin = self.plugin,
            COMPAS_PLUGIN_TEST = true,
            os = { time = function() return 1700000000 end },
            math = math,
            string = string,
            table = table,
            utf8 = utf8,
            tonumber = tonumber,
            tostring = tostring,
            type = type,
            pairs = pairs,
            ipairs = ipairs,
            pcall = pcall,
            error = error,
            select = select,
            assert = assert,
            print = print,
            rawget = rawget,
            _G = _G,
        }
        setmetatable(env, { __index = _G })
        local chunk, err = loadfile(plugin_path, "t", env)
        if not chunk then error("Failed to load plugin: " .. tostring(err)) end
        chunk()
        self.under_test = _G.COMPAS_PLUGIN_UNDER_TEST
        _G.COMPAS_PLUGIN_UNDER_TEST = nil
        _G.COMPAS_PLUGIN_TEST = nil
        return self.under_test
    end

    return self
end

harness.encode_json = encode_json
harness.decode_json = decode_json
return harness
