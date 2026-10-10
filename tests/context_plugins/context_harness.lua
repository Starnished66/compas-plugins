-- Mock test harness for API 16 Compás Context Plugins
-- Provides exact simulation of runtime APIs, PEQ state, output info,
-- metadata, native playback settings with bidirectional coupling, and sandbox filesystem.

local harness = {}

local VALID_EVENTS = {
    ["track_started"] = true,
    ["paused"] = true,
    ["resumed"] = true,
    ["stopped"] = true,
    ["screen_woke"] = true,
    ["queue_exhausted"] = true,
    ["volume_changed"] = true,
    ["battery_changed"] = true,
    ["suspending"] = true,
    ["system_resumed"] = true,
    ["screenshot_saved"] = true,
    ["screenshot_failed"] = true,
    ["output_changed"] = true,
}

local function deep_copy(orig)
    if type(orig) ~= "table" then return orig end
    local copy = {}
    for k, v in pairs(orig) do
        copy[k] = deep_copy(v)
    end
    return copy
end

local function default_eq_state()
    local bands = {}
    local freqs = { 31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000 }
    for i = 1, 10 do
        bands[i] = {
            index = i,
            freq_hz = freqs[i],
            gain_db = 0.0,
            q = 0.7,
            type = (i == 1 and "low_shelf" or (i == 10 and "high_shelf" or "peaking")),
            enabled = true,
        }
    end
    return {
        bypass = false,
        preamp_db = 0.0,
        stereo_width = 1.0,
        bands = bands,
    }
end

function harness.new(opts)
    opts = opts or {}
    local sd = opts.sd_root or os.tmpname() .. "_sd"
    os.execute("mkdir -p '" .. sd .. "/.plugins' '" .. sd .. "/PEQ_Profiles'")

    local self = {
        sd_root_path = sd,
        capabilities = {
            ["audio.peq"] = true,
            ["audio.peq.state"] = true,
            ["audio.peq.transient"] = true,
            ["library.track_metadata"] = true,
            ["playback.output_info"] = true,
            ["playback.output_events"] = true,
            ["playback.settings"] = true,
            ["storage.namespaced"] = true,
            ["data.json"] = true,
            ["ui.settings"] = true,
            ["ui.list"] = true,
            ["ui.toast"] = true,
        },
        eq_state = default_eq_state(),
        eq_apply_calls = {},
        eq_state_calls = {},
        eq_set_preamp_calls = {},
        output_info = {
            route = "wired",
            active = true,
            bluetooth_codec = nil,
            dop = false,
            resampling = false,
            resampling_known = true,
            sample_rate = 44100,
            bit_depth = 16,
        },
        crossfade = false,
        gapless = true,
        replaygain = "off",
        play_mode = "sequential",
        volume = 50,
        volume_calls = {},
        setter_calls = {
            crossfade = 0,
            gapless = 0,
            replaygain = 0,
            play_mode = 0,
        },
        current_track_path = nil,
        now_playing = nil,
        metadata_db = {},
        events = {},
        list_items = {},
        settings_screens = {},
        lists_shown = {},
        toasts = {},
        fail_profile_loads = {},
        storage_store = {},
        storage_fail_writes = false,
        storage_set_calls = 0,
    }

    if opts.capabilities then
        for k, v in pairs(opts.capabilities) do
            self.capabilities[k] = v
        end
    end

    local plugin = {}

    function plugin.define(def)
        assert(def.api_min == 16, "Plugin must target API 16")
    end

    function plugin.api_version()
        return 16
    end

    function plugin.has_capability(cap)
        return self.capabilities[cap] == true
    end

    function plugin.sd_root()
        return self.sd_root_path
    end

    function plugin.mkdir(path)
        os.execute("mkdir -p '" .. path .. "'")
        return true
    end

    function plugin.list_dir(path)
        local out = {}
        local p = io.popen("ls -1 '" .. path .. "' 2>/dev/null")
        if p then
            for line in p:lines() do
                if line ~= "" and line:sub(1, 1) ~= "." then
                    local is_dir = os.execute("test -d '" .. path .. "/" .. line .. "'") == 0
                    out[#out + 1] = {
                        name = line,
                        dir = is_dir,
                        size = 100,
                        modified = os.time(),
                    }
                end
            end
            p:close()
        end
        return out
    end

    function plugin.get_eq_state()
        if not self.capabilities["audio.peq.state"] then return nil end
        return deep_copy(self.eq_state)
    end

    function plugin.eq_apply_state(state, opts)
        if not self.capabilities["audio.peq.state"] then return false end
        self.eq_state_calls[#self.eq_state_calls + 1] = { state = deep_copy(state), opts = opts }
        self.eq_state = deep_copy(state)
        return true
    end

    function plugin.eq_apply_profile(path, opts)
        if not self.capabilities["audio.peq.transient"] then return false end
        self.eq_apply_calls[#self.eq_apply_calls + 1] = { path = path, opts = opts }
        local filename = path:match("([^/]+)$") or path
        if self.fail_profile_loads[filename] or self.fail_profile_loads[path] then
            return false
        end
        local f = io.open(path, "r")
        if not f then return false end
        f:close()
        -- Modify EQ slightly to reflect profile application
        self.eq_state.preamp_db = (self.eq_state.preamp_db + 0.1) % 10.0
        return true
    end

    function plugin.eq_set_preamp(db)
        self.eq_set_preamp_calls[#self.eq_set_preamp_calls + 1] = db
        self.eq_state.preamp_db = db
    end

    function plugin.get_output_info()
        if not self.capabilities["playback.output_info"] then return nil end
        return deep_copy(self.output_info)
    end

    function plugin.get_track_metadata(path)
        if not self.capabilities["library.track_metadata"] then return nil end
        if not path then return nil end
        return self.metadata_db[path]
    end

    function plugin.get_current_track_path()
        return self.current_track_path
    end

    function plugin.get_now_playing()
        if not self.now_playing then return nil end
        return self.now_playing.title, self.now_playing.artist, self.now_playing.album, self.now_playing.duration
    end

    function plugin.get_crossfade()
        return self.crossfade
    end

    function plugin.set_crossfade(val)
        self.setter_calls.crossfade = self.setter_calls.crossfade + 1
        self.crossfade = val and true or false
        if self.crossfade then
            -- Native coupling: enabling crossfade enables gapless
            self.gapless = true
        end
    end

    function plugin.get_gapless()
        return self.gapless
    end

    function plugin.set_gapless(val)
        self.setter_calls.gapless = self.setter_calls.gapless + 1
        self.gapless = val and true or false
        if not self.gapless then
            -- Native coupling: disabling gapless disables crossfade
            self.crossfade = false
        end
    end

    function plugin.get_replaygain_mode()
        return self.replaygain
    end

    function plugin.set_replaygain_mode(mode)
        self.setter_calls.replaygain = self.setter_calls.replaygain + 1
        self.replaygain = mode
    end

    function plugin.get_play_mode()
        return self.play_mode
    end

    function plugin.set_play_mode(mode)
        self.setter_calls.play_mode = self.setter_calls.play_mode + 1
        self.play_mode = mode
    end

    function plugin.get_volume()
        return self.volume
    end

    function plugin.set_volume(pct, opts)
        self.volume_calls[#self.volume_calls + 1] = { percent = pct, opts = opts }
        self.volume = pct
    end

    function plugin.on(event, cb)
        if not VALID_EVENTS[event] then
            error("plugin.on: unknown event '" .. tostring(event) .. "'", 2)
        end
        self.events[event] = self.events[event] or {}
        self.events[event][#self.events[event] + 1] = cb
    end

    function plugin.register_list_item(list_id, label, cb)
        self.list_items[#self.list_items + 1] = { list_id = list_id, label = label, cb = cb }
    end

    function plugin.show_settings_list(title, rows, opts)
        self.settings_screens[#self.settings_screens + 1] = { title = title, rows = rows, opts = opts }
    end

    function plugin.show_list(title, items, cb)
        self.lists_shown[#self.lists_shown + 1] = { title = title, items = items, cb = cb }
    end

    function plugin.show_toast(msg)
        self.toasts[#self.toasts + 1] = msg
    end

    function plugin.show_text_view(title, text)
        self.last_text_view = { title = title, text = text }
    end

    function plugin.show_text_input(title, val, secret, cb)
        self.last_text_input = { title = title, val = val, secret = secret, cb = cb }
    end

    -- Plugin storage mock
    plugin.storage = {
        get = function(key, default)
            local val = self.storage_store[key]
            if val == nil then return default else return val end
        end,
        set = function(key, val)
            self.storage_set_calls = self.storage_set_calls + 1
            if self.storage_fail_writes then
                return false
            end
            self.storage_store[key] = val
            return true
        end,
        delete = function(key)
            self.storage_store[key] = nil
            return true
        end,
        list = function(prefix)
            local out = {}
            for k in pairs(self.storage_store) do
                if not prefix or k:sub(1, #prefix) == prefix then
                    out[#out + 1] = k
                end
            end
            return out
        end
    }

    -- Real JSON encode/decode
    local function parse_val(text, i)
        while i <= #text and text:sub(i, i):match("%s") do i = i + 1 end
        if i > #text then return nil, i end
        local c = text:sub(i, i)
        if c == '"' then
            local j = i + 1
            local parts = {}
            while j <= #text do
                local ch = text:sub(j, j)
                if ch == '"' then return table.concat(parts), j + 1
                elseif ch == "\\" then
                    parts[#parts + 1] = text:sub(j + 1, j + 1)
                    j = j + 2
                else
                    parts[#parts + 1] = ch
                    j = j + 1
                end
            end
        elseif c == "{" then
            local obj = {}
            local j = i + 1
            while j <= #text do
                while j <= #text and text:sub(j, j):match("%s") do j = j + 1 end
                if text:sub(j, j) == "}" then return obj, j + 1 end
                local key, next_j = parse_val(text, j)
                if not key then break end
                j = next_j
                while j <= #text and text:sub(j, j):match("%s") do j = j + 1 end
                if text:sub(j, j) == ":" then j = j + 1 end
                local val, after_val = parse_val(text, j)
                obj[key] = val
                j = after_val
                while j <= #text and text:sub(j, j):match("%s") do j = j + 1 end
                if text:sub(j, j) == "," then j = j + 1 end
            end
            return obj, j + 1
        elseif c == "[" then
            local arr = {}
            local j = i + 1
            while j <= #text do
                while j <= #text and text:sub(j, j):match("%s") do j = j + 1 end
                if text:sub(j, j) == "]" then return arr, j + 1 end
                local val, after_val = parse_val(text, j)
                arr[#arr + 1] = val
                j = after_val
                while j <= #text and text:sub(j, j):match("%s") do j = j + 1 end
                if text:sub(j, j) == "," then j = j + 1 end
            end
            return arr, j + 1
        elseif text:sub(i, i + 3) == "true" then return true, i + 4
        elseif text:sub(i, i + 4) == "false" then return false, i + 5
        elseif text:sub(i, i + 3) == "null" then return nil, i + 4
        else
            local s, e = text:find("^-?%d+%.?%d*", i)
            if s then return tonumber(text:sub(s, e)), e + 1 end
        end
        return nil, i + 1
    end

    function plugin.json_decode(text)
        if type(text) ~= "string" or text == "" then return nil end
        local val = parse_val(text, 1)
        return val
    end

    function plugin.json_encode(val)
        local t = type(val)
        if t == "nil" then return "null"
        elseif t == "boolean" then return val and "true" or "false"
        elseif t == "number" then return tostring(val)
        elseif t == "string" then
            return '"' .. val:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\n', '\\n') .. '"'
        elseif t == "table" then
            local is_array = true
            local count = 0
            for k in pairs(val) do
                count = count + 1
                if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then is_array = false break end
            end
            if is_array and count == #val then
                local parts = {}
                for i = 1, #val do parts[#parts + 1] = plugin.json_encode(val[i]) end
                return "[" .. table.concat(parts, ",") .. "]"
            else
                local parts = {}
                for k, v in pairs(val) do
                    parts[#parts + 1] = plugin.json_encode(tostring(k)) .. ":" .. plugin.json_encode(v)
                end
                return "{" .. table.concat(parts, ",") .. "}"
            end
        end
        return "null"
    end

    self.plugin = plugin

    function self.create_fixture_profile(name)
        local path = self.sd_root_path .. "/PEQ_Profiles/" .. name
        local f = io.open(path, "w")
        if f then
            f:write("preamp=0.0\n")
            for i = 1, 10 do
                f:write(string.format("band%d_freq=1000\nband%d_gain=0\nband%d_q=0.7\nband%d_type=0\nband%d_enabled=1\n", i-1, i-1, i-1, i-1, i-1))
            end
            f:close()
        end
        return path
    end

    function self.emit(event, ...)
        local cbs = self.events[event] or {}
        for _, cb in ipairs(cbs) do
            cb(...)
        end
    end

    function self.load(plugin_path)
        _G.COMPAS_PLUGIN_TEST = true
        local env = {
            plugin = plugin,
            COMPAS_PLUGIN_TEST = true,
            io = io,
            os = os,
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
        self.under_test = env.COMPAS_PLUGIN_UNDER_TEST or _G.COMPAS_PLUGIN_UNDER_TEST
        _G.COMPAS_PLUGIN_UNDER_TEST = nil
        _G.COMPAS_PLUGIN_TEST = nil
        return self.under_test
    end

    return self
end

return harness
