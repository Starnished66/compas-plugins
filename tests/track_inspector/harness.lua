-- Test harness for Track Inspector plugin in Compas Plugin API 16.
-- Exercises the real Lua plugin in an isolated sandbox with authentic mock APIs.

local harness = {}

-- Valid events as enforced by plugin_manager.c (PLUGIN_EVENT_* enum)
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

local MAX_LIST_STACK = 4
local MAX_SETTINGS_STACK = 2

function harness.new(opts)
    opts = opts or {}
    local self = {
        sd_root_path = opts.sd_root or "/tmp/compas_test_sd",
        api_ver = opts.api_version or 16,
        capabilities = opts.capabilities or {
            ["playback.format"] = true,
            ["playback.output_info"] = true,
            ["audio.peq.state"] = true,
            ["library.track_metadata"] = true,
            ["playback.output_events"] = true,
            ["playback.settings"] = true,
            ["storage.namespaced"] = true,
            ["ui.list"] = true,
            ["ui.list_update"] = true,
            ["ui.settings"] = true,
            ["filesystem.sd"] = true,
        },
        storage_data = {},
        storage_fail = opts.storage_fail or false,
        registered_list_items = {},
        events = {},
        intervals = {},
        next_interval_id = 1,
        next_handle = 1,
        screen_stack = {},
        active_screens = {},
        toasts = {},
        files = opts.files or {},
        dirs = opts.dirs or {},

        -- Live playback mocks
        format_snapshot = opts.format_snapshot or nil,
        output_info = opts.output_info or nil,
        eq_state = opts.eq_state or nil,
        track_metadata = opts.track_metadata or {},
        now_playing = opts.now_playing or nil,
    }

    local plugin = {}

    function plugin.define(def)
        self.defined = def
    end

    function plugin.api_version()
        return self.api_ver
    end

    function plugin.has_capability(cap)
        return self.capabilities[cap] == true
    end

    function plugin.sd_root()
        return self.sd_root_path
    end

    function plugin.list_dir(path)
        return self.dirs[path] or {}
    end

    function plugin.get_playback_format()
        return self.format_snapshot
    end

    function plugin.get_output_info()
        return self.output_info
    end

    function plugin.get_eq_state()
        return self.eq_state
    end

    function plugin.get_track_metadata(path)
        return self.track_metadata[path]
    end

    function plugin.get_now_playing()
        return self.now_playing
    end

    function plugin.register_list_item(list_id, label, on_open)
        self.registered_list_items[#self.registered_list_items + 1] = {
            list_id = list_id,
            label = label,
            on_open = on_open,
        }
    end

    -- Real Compas show_list binding with ui.list_update replace option:
    -- options.replace: replaces currently top list screen owned by this plugin in place.
    -- Returns fresh handle (old handle invalid); returns nil for closed/covered/invalid handle.
    function plugin.show_list(title, items, on_select, options)
        local replace_handle = options and options.replace or nil
        if replace_handle ~= nil then
            if type(replace_handle) ~= "number" or replace_handle <= 0 then
                return nil
            end
            -- Check if replace_handle matches current top list screen
            local top_screen = self.screen_stack[#self.screen_stack]
            if not top_screen or top_screen.type ~= "list" or top_screen.handle ~= replace_handle then
                return nil -- Stale, covered, or closed handle
            end
            -- In-place replacement
            local new_handle = self.next_handle
            self.next_handle = self.next_handle + 1
            top_screen.title = title
            top_screen.items = items
            top_screen.on_select = on_select
            top_screen.options = options
            top_screen.handle = new_handle
            self.active_screens[#self.active_screens + 1] = top_screen
            return new_handle
        end

        local list_depth = 0
        for _, s in ipairs(self.screen_stack) do
            if s.type == "list" then list_depth = list_depth + 1 end
        end
        if list_depth >= MAX_LIST_STACK then
            error("show_list: list stack overflow (max " .. MAX_LIST_STACK .. ")", 2)
        end

        local new_handle = self.next_handle
        self.next_handle = self.next_handle + 1
        local screen = {
            type = "list",
            handle = new_handle,
            title = title,
            items = items,
            on_select = on_select,
            options = options,
        }
        self.screen_stack[#self.screen_stack + 1] = screen
        self.active_screens[#self.active_screens + 1] = screen
        return new_handle
    end

    function plugin.show_settings_list(title, items, options)
        local settings_depth = 0
        for _, s in ipairs(self.screen_stack) do
            if s.type == "settings" then settings_depth = settings_depth + 1 end
        end
        if settings_depth >= MAX_SETTINGS_STACK then
            error("show_settings_list: settings stack overflow (max " .. MAX_SETTINGS_STACK .. ")", 2)
        end

        local new_handle = self.next_handle
        self.next_handle = self.next_handle + 1
        local screen = {
            type = "settings",
            handle = new_handle,
            title = title,
            items = items,
            options = options,
        }
        self.screen_stack[#self.screen_stack + 1] = screen
        self.active_screens[#self.active_screens + 1] = screen
        return new_handle
    end

    function self.pop_screen()
        if #self.screen_stack > 0 then
            table.remove(self.screen_stack)
        end
    end
    plugin.pop_screen = self.pop_screen

    function plugin.is_list_showing(handle)
        local top = self.screen_stack[#self.screen_stack]
        return top ~= nil and top.handle == handle
    end

    function plugin.show_toast(msg)
        self.toasts[#self.toasts + 1] = msg
    end

    -- Compas Player API: plugin.set_interval takes SECONDS (double), not milliseconds
    function plugin.set_interval(seconds, cb)
        if type(seconds) ~= "number" or seconds <= 0 then
            error("plugin.set_interval: seconds must be positive number", 2)
        end
        if type(cb) ~= "function" then
            error("plugin.set_interval: callback must be function", 2)
        end
        local id = self.next_interval_id
        self.next_interval_id = self.next_interval_id + 1
        self.intervals[id] = { seconds = seconds, cb = cb, active = true }
        return id
    end

    function plugin.clear_interval(id)
        if self.intervals[id] then
            self.intervals[id].active = false
            self.intervals[id] = nil
        end
    end

    -- Compas Player API: plugin.on strictly validates event string against known enum
    function plugin.on(event, cb)
        if not VALID_EVENTS[event] then
            error("plugin.on: unknown event '" .. tostring(event) .. "'", 2)
        end
        if type(cb) ~= "function" then
            error("plugin.on: callback must be function", 2)
        end
        self.events[event] = self.events[event] or {}
        table.insert(self.events[event], cb)
    end

    plugin.storage = {
        get = function(key, default)
            if self.storage_fail then error("simulated storage failure") end
            local val = self.storage_data[key]
            if val == nil then return default end
            return val
        end,
        set = function(key, value)
            if self.storage_fail then error("simulated storage failure") end
            self.storage_data[key] = tostring(value)
            return true
        end,
        delete = function(key)
            if self.storage_fail then error("simulated storage failure") end
            self.storage_data[key] = nil
            return true
        end,
        list = function(prefix)
            if self.storage_fail then error("simulated storage failure") end
            local res = {}
            for k in pairs(self.storage_data) do
                if not prefix or k:sub(1, #prefix) == prefix then
                    res[#res + 1] = k
                end
            end
            return res
        end,
    }

    self.plugin = plugin

    function self.emit(event, ...)
        if not VALID_EVENTS[event] then
            error("harness.emit: unknown event '" .. tostring(event) .. "'", 2)
        end
        for _, cb in ipairs(self.events[event] or {}) do
            cb(...)
        end
    end

    function self.tick_intervals()
        for id, t in pairs(self.intervals) do
            if t.active and t.cb then
                t.cb()
            end
        end
    end

    function self.count_active_intervals()
        local count = 0
        for _, t in pairs(self.intervals) do
            if t.active then count = count + 1 end
        end
        return count
    end

    function self.load(plugin_path)
        _G.COMPAS_PLUGIN_TEST = true
        local env = {
            plugin = self.plugin,
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
        if not chunk then error("Failed to load plugin: " .. tostring(err)) end
        chunk()
        self.under_test = env.COMPAS_PLUGIN_UNDER_TEST or _G.COMPAS_PLUGIN_UNDER_TEST
        _G.COMPAS_PLUGIN_UNDER_TEST = nil
        _G.COMPAS_PLUGIN_TEST = nil
        return self.under_test
    end

    return self
end

return harness
