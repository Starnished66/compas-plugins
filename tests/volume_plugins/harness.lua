-- Host-side mock for ExtendedSleepTimer and VolumeLimiter tests.
-- Conforms to Compas API 16 specification in ../compas-player/PLUGINS.md.

local harness = {}

local id_counter = 0

local function json_error(msg, i)
    error(msg .. " at " .. tostring(i), 2)
end

local function decode_json(text)
    if type(text) ~= "string" then return nil, "not a string" end
    local i = 1
    local n = #text
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

local function encode_json(val)
    local t = type(val)
    if t == "nil" then return "null"
    elseif t == "boolean" then return val and "true" or "false"
    elseif t == "number" then
        if val ~= val or val == math.huge or val == -math.huge then
            return nil, "cannot encode NaN or Inf"
        end
        return tostring(val)
    elseif t == "string" then
        return string.format("%q", val):gsub("\\\n", "\\n")
    elseif t == "table" then
        local is_array = true
        local n = #val
        for k, _ in pairs(val) do
            if type(k) ~= "number" or k < 1 or k > n or math.floor(k) ~= k then
                is_array = false
                break
            end
        end
        local parts = {}
        if is_array and n > 0 then
            for i = 1, n do
                local sub = encode_json(val[i])
                parts[#parts + 1] = sub
            end
            return "[" .. table.concat(parts, ",") .. "]"
        else
            for k, v in pairs(val) do
                if type(k) == "string" then
                    local sub = encode_json(v)
                    parts[#parts + 1] = string.format("%q", k) .. ":" .. sub
                end
            end
            return "{" .. table.concat(parts, ",") .. "}"
        end
    else
        return nil, "cannot encode type " .. t
    end
end

function harness.new(opts)
    opts = opts or {}
    id_counter = id_counter + 1
    local temp_sd = "build_test/test_sd_" .. tostring(os.time()) .. "_" .. tostring(id_counter)
    os.execute("mkdir -p '" .. temp_sd .. "/.plugins'")

    local self = {
        sd_root_path = temp_sd,
        current_time = opts.time or 1000000,
        volume = opts.volume or 80,
        playing = (opts.playing ~= false),
        paused = false,
        stop_called = false,
        active_intervals = {},
        next_interval_id = 1,
        toasts = {},
        set_volume_calls = {},
        storage_set_calls = 0,
        event_handlers = {},
        list_items = {},
        settings_screens = {},
        lists_shown = {},
        storage_data = {},
        storage_failed = (opts.fail_storage == true),
        sync_reentrant = (opts.synchronous_reentrant_volume_changed == true),
        auto_fire_volume_changed = (opts.auto_dispatch_volume_changed == true),
        fail_set_volume = (opts.fail_set_volume == true),
        capabilities = {
            ["playback.control"] = true,
            ["playback.state"] = true,
            ["playback.events"] = true,
            ["playback.silent_volume"] = true,
            ["playback.transient_volume"] = true,
            ["storage.namespaced"] = true,
            ["filesystem.sd"] = true,
            ["data.json"] = true,
        },
    }

    if opts.capabilities then
        for k, v in pairs(opts.capabilities) do
            self.capabilities[k] = v
        end
    end

    local plugin = {}

    function plugin.define(def)
        assert(type(def) == "table", "plugin.define requires a table")
        assert(def.id and #def.id > 0, "plugin id is required")
        assert(def.name and #def.name > 0, "plugin name is required")
        assert(def.version and #def.version > 0, "plugin version is required")
        assert(def.api_min == 16, "All plugins must target api_min 16")
        self.definition = def
    end

    function plugin.api_version()
        return 16
    end

    function plugin.has_capability(name)
        return self.capabilities[name] == true
    end

    function plugin.sd_root()
        return self.sd_root_path
    end

    function plugin.get_volume()
        return self.volume
    end

    function plugin.set_volume(percent, vopts)
        if self.fail_set_volume then
            error("native set_volume failed")
        end
        assert(type(percent) == "number", "percent must be a number")
        local clamped = math.floor(percent)
        if clamped < 0 then clamped = 0 end
        if clamped > 100 then clamped = 100 end

        local silent = false
        local persist = true
        if type(vopts) == "table" then
            if vopts.silent ~= nil then silent = (vopts.silent == true) end
            if vopts.persist ~= nil then persist = (vopts.persist == true) end
        end

        local call_record = {
            percent = clamped,
            opts = vopts,
            silent = silent,
            persist = persist,
            time = self.current_time,
        }
        self.set_volume_calls[#self.set_volume_calls + 1] = call_record
        self.volume = clamped

        if self.sync_reentrant or self.auto_fire_volume_changed then
            self.emit("volume_changed", clamped)
        end
    end

    function plugin.is_playing()
        return self.playing
    end

    function plugin.is_paused()
        return self.paused
    end

    function plugin.stop()
        self.stop_called = true
        self.playing = false
        self.emit("stopped")
    end

    function plugin.set_interval(seconds, cb)
        assert(type(seconds) == "number" and seconds > 0, "interval seconds must be positive")
        assert(type(cb) == "function", "interval callback must be a function")

        local active_count = self.active_interval_count()
        if active_count >= 8 then
            error("plugin.set_interval: too many active intervals (max 8)")
        end

        local handle = self.next_interval_id
        self.next_interval_id = self.next_interval_id + 1
        self.active_intervals[handle] = {
            seconds = seconds,
            callback = cb,
            active = true,
        }
        return handle
    end

    function plugin.clear_interval(handle)
        if type(handle) == "number" and self.active_intervals[handle] then
            self.active_intervals[handle].active = false
            return true
        end
        return false
    end

    function plugin.on(event, cb)
        assert(type(event) == "string", "event name must be string")
        assert(type(cb) == "function", "event callback must be function")
        self.event_handlers[event] = self.event_handlers[event] or {}
        if #self.event_handlers[event] >= 16 then
            error("plugin.on: too many subscribers registered for \"" .. event .. "\" (max 16)")
        end
        self.event_handlers[event][#self.event_handlers[event] + 1] = cb
    end

    function plugin.register_list_item(list_id, label, on_open, ropts)
        self.list_items[#self.list_items + 1] = {
            list_id = list_id,
            label = label,
            on_open = on_open,
            options = ropts,
        }
    end

    function plugin.show_settings_list(title, items, sopts)
        self.settings_screens[#self.settings_screens + 1] = {
            title = title,
            items = items,
            options = sopts,
        }
    end

    function plugin.show_list(title, items, on_select)
        self.lists_shown[#self.lists_shown + 1] = {
            title = title,
            items = items,
            on_select = on_select,
        }
    end

    function plugin.show_toast(msg)
        self.toasts[#self.toasts + 1] = tostring(msg)
    end

    function plugin.json_encode(value)
        if not self.capabilities["data.json"] then
            error("capability data.json not supported")
        end
        local res, err = encode_json(value)
        if not res then return nil, err end
        return res
    end

    function plugin.json_decode(text)
        if not self.capabilities["data.json"] then
            error("capability data.json not supported")
        end
        local res, err = decode_json(text)
        if res == nil and err then return nil, err end
        return res
    end

    plugin.storage = {
        get = function(key, default)
            local val = self.storage_data[key]
            if val ~= nil then return val end
            return default
        end,
        set = function(key, value)
            self.storage_set_calls = (self.storage_set_calls or 0) + 1
            if self.storage_failed then
                return false, "storage failure"
            end
            self.storage_data[key] = tostring(value)
            return true
        end,
        delete = function(key)
            self.storage_data[key] = nil
            return true
        end,
    }

    function self.emit(event, ...)
        local handlers = self.event_handlers[event] or {}
        for _, cb in ipairs(handlers) do
            cb(...)
        end
    end

    function self.active_interval_count()
        local count = 0
        for _, item in pairs(self.active_intervals) do
            if item.active then count = count + 1 end
        end
        return count
    end

    function self.advance_time(seconds)
        for _ = 1, seconds do
            self.current_time = self.current_time + 1
            for _, item in pairs(self.active_intervals) do
                if item.active then
                    item.callback()
                end
            end
        end
    end

    function self.load(plugin_path)
        _G.COMPAS_PLUGIN_TEST = true
        local mock_os = {
            time = function() return self.current_time end,
            date = os.date,
            clock = os.clock,
            difftime = os.difftime,
            remove = os.remove,
            rename = os.rename,
        }
        local env = {
            plugin = plugin,
            io = io,
            os = mock_os,
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
            COMPAS_PLUGIN_TEST = true,
        }
        setmetatable(env, { __index = _G })

        local chunk, err = loadfile(plugin_path, "t", env)
        if not chunk then error(err) end
        chunk()

        local under_test = env.COMPAS_PLUGIN_UNDER_TEST or _G.COMPAS_PLUGIN_UNDER_TEST
        _G.COMPAS_PLUGIN_UNDER_TEST = nil
        _G.COMPAS_PLUGIN_TEST = nil
        return under_test, env
    end

    function self.cleanup()
        if self.sd_root_path and self.sd_root_path:match("^build_test/") then
            os.execute("rm -rf '" .. self.sd_root_path .. "'")
        end
    end

    return self
end

return harness
