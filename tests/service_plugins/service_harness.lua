-- Host-side mock for ListenBrainz and Radio Browser. Not shipped to the device.
-- plugin.storage and plugin.secrets are the real API 15 names; tables may be
-- shared across loads so a restart keeps the same queue and token.

local harness = {}

local function json_error(msg, i)
    error(msg .. " at " .. tostring(i), 2)
end

local function decode_json(text)
    if type(text) ~= "string" then return nil, "not a string" end
    local i, n = 1, #text
    local parse_value

    local function skip()
        while i <= n and text:sub(i, i):match("%s") do i = i + 1 end
    end

    local function parse_string()
        if text:sub(i, i) ~= '"' then json_error("string", i) end
        i = i + 1
        local out = {}
        while i <= n do
            local c = text:sub(i, i)
            if c == '"' then
                i = i + 1
                return table.concat(out)
            elseif c == "\\" then
                local e = text:sub(i + 1, i + 1)
                local map = {
                    ['"'] = '"', ["\\"] = "\\", ["/"] = "/",
                    b = "\b", f = "\f", n = "\n", r = "\r", t = "\t",
                }
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
        json_error("unterminated string", i)
    end

    local function parse_number()
        local s, e = text:find("^-?%d+%.?%d*[eE]?[%+%-]?%d*", i)
        if not s then json_error("number", i) end
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
            if c ~= "," then json_error("array", i) end
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
            if text:sub(i, i) ~= ":" then json_error("colon", i) end
            i = i + 1
            obj[key] = parse_value()
            skip()
            local c = text:sub(i, i)
            if c == "}" then i = i + 1 return obj end
            if c ~= "," then json_error("object", i) end
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
        json_error("value", i)
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

function harness.new(opts)
    opts = opts or {}
    local storage_bag = opts.storage or {}
    local secrets_bag = opts.secrets or {}
    local self = {
        sd_root_path = opts.sd_root or "/tmp/compas-service-plugin-test",
        storage = storage_bag,
        secrets = secrets_bag,
        now = opts.now or 1700000000,
        position = 0,
        duration = 0,
        playing = false,
        paused = false,
        toasts = {},
        http_calls = {},
        play_lists = {},
        events = {},
        intervals = {},
        list_items = {},
        tiles = {},
        settings = {},
        lists = {},
        inputs = {},
        cancels = {},
        next_handle = 1,
        capabilities = {
            ["storage.secrets"] = true,
            ["storage.secrets_get"] = true,
            ["network.http.async"] = true,
            ["data.json"] = true,
        },
    }
    if opts.capabilities then
        for name, enabled in pairs(opts.capabilities) do
            self.capabilities[name] = enabled
        end
    end

    local plugin = {}

    function plugin.define(def)
        self.definition = def
        assert(type(def) == "table" and def.api_min == 15, "service plugin must declare API 15")
    end

    function plugin.sd_root() return self.sd_root_path end
    function plugin.has_capability(name) return self.capabilities[name] == true end
    function plugin.show_toast(message) self.toasts[#self.toasts + 1] = tostring(message) end
    function plugin.get_position() return self.position end
    function plugin.get_duration() return self.duration end
    function plugin.is_playing() return self.playing end
    function plugin.is_paused() return self.paused end
    function plugin.md5(text) return harness.fingerprint(text) end
    function plugin.json_encode(value) return encode_json(value) end
    function plugin.json_decode(text) return decode_json(text) end
    function plugin.cancel(handle)
        self.cancels[#self.cancels + 1] = handle
        return true
    end

    plugin.storage = {}
    function plugin.storage.get(key, default)
        if storage_bag[key] == nil then return default end
        return storage_bag[key]
    end
    function plugin.storage.set(key, value)
        if type(key) ~= "string" or type(value) ~= "string" then return false, "type" end
        if #key > 128 or #value > 262144 then return false, "size" end
        storage_bag[key] = value
        return true
    end
    function plugin.storage.delete(key)
        storage_bag[key] = nil
        return true
    end
    function plugin.storage.list()
        local keys = {}
        for key in pairs(storage_bag) do keys[#keys + 1] = key end
        table.sort(keys)
        return keys
    end

    plugin.secrets = {}
    function plugin.secrets.get(key)
        return secrets_bag[key]
    end
    function plugin.secrets.set(key, value)
        if type(key) ~= "string" or type(value) ~= "string" then return false end
        secrets_bag[key] = value
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
        local call = { options = options, callback = callback, handle = self.next_handle }
        self.next_handle = self.next_handle + 1
        self.http_calls[#self.http_calls + 1] = call
        return call.handle
    end

    function plugin.on(event, callback)
        self.events[event] = self.events[event] or {}
        self.events[event][#self.events[event] + 1] = callback
    end
    function plugin.set_interval(seconds, callback)
        self.intervals[#self.intervals + 1] = { seconds = seconds, callback = callback }
        return #self.intervals
    end
    function plugin.register_list_item(list_id, label, on_open)
        self.list_items[#self.list_items + 1] = { list_id = list_id, label = label, on_open = on_open }
    end
    function plugin.register_stream_media_tile(label, on_open, icon)
        self.tiles[#self.tiles + 1] = { label = label, on_open = on_open, icon = icon }
    end
    function plugin.show_settings_list(title, items)
        self.settings[#self.settings + 1] = { title = title, items = items }
    end
    function plugin.show_list(title, items, on_select)
        self.lists[#self.lists + 1] = { title = title, items = items, on_select = on_select }
        return #self.lists
    end
    function plugin.show_text_input(title, initial, is_password, callback)
        self.inputs[#self.inputs + 1] = {
            title = title, initial = initial, password = is_password, callback = callback,
        }
        return true
    end
    function plugin.play_list(paths, start_index)
        local copy = {}
        for index, path in ipairs(paths or {}) do copy[index] = path end
        self.play_lists[#self.play_lists + 1] = { paths = copy, start_index = start_index or 1 }
        return true
    end

    self.plugin = require("api15_surface")(plugin)

    function self.emit(event, ...)
        for _, callback in ipairs(self.events[event] or {}) do callback(...) end
    end

    function self.tick()
        for _, timer in ipairs(self.intervals) do timer.callback() end
    end

    function self.reply(index, status, body, err, headers)
        local call = self.http_calls[index]
        if not call then error("no HTTP call " .. tostring(index)) end
        if call.answered then error("HTTP call " .. tostring(index) .. " already answered") end
        call.answered = true
        call.callback(status, body, err, headers)
    end

    function self.load(plugin_path)
        _G.COMPAS_PLUGIN_TEST = true
        local clock = self
        self.io = {
            open = function(path, mode)
                return io.open(path, mode)
            end,
        }
        local env = {
            plugin = plugin,
            COMPAS_PLUGIN_TEST = true,
            io = self.io,
            os = { time = function() return clock.now end },
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
        if not chunk then error(err) end
        chunk()
        self.under_test = _G.COMPAS_PLUGIN_UNDER_TEST
        _G.COMPAS_PLUGIN_UNDER_TEST = nil
        _G.COMPAS_PLUGIN_TEST = nil
        return self.under_test
    end

    return self
end

function harness.fingerprint(text)
    local hash = 2166136261
    for index = 1, #tostring(text) do
        hash = (hash + string.byte(text, index) * index) % 4294967296
    end
    return string.format("%08x", hash)
end

harness.encode_json = encode_json
harness.decode_json = decode_json
return harness
