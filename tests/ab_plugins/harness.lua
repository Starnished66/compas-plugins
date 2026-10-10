-- Test harness for Compas API 16 A-B audio plugins.
-- Provides isolated sandboxed execution matching plugin_manager.c semantics.

local freeze_surface = require("tests.ab_plugins.api16_surface")

local harness = {}

function harness.create_default_eq_state()
    local bands = {}
    local freqs = { 31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000 }
    for i = 1, 10 do
        bands[i] = {
            index = i,
            freq_hz = freqs[i],
            gain_db = 0.0,
            q = 1.0,
            type = (i == 1 and "low_shelf") or (i == 10 and "high_shelf") or "peaking",
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

function harness.deep_copy(orig)
    if type(orig) ~= "table" then return orig end
    local copy = {}
    for k, v in pairs(orig) do
        copy[k] = harness.deep_copy(v)
    end
    return copy
end

function harness.new(opts)
    opts = opts or {}
    local state = {
        defined = nil,
        capabilities = opts.capabilities or {
            ["playback.ab_loop"] = true,
            ["playback.ab_switch"] = true,
            ["playback.format"] = true,
            ["audio.peq.state"] = true,
            ["audio.peq.transient"] = true,
            ["audio.stereo_width"] = true,
            ["ui.list_update"] = true,
            ["crypto.md5"] = true,
        },
        sd_root = opts.sd_root or "/data/mnt/sd_0",
        current_path = opts.current_path or "/data/mnt/sd_0/Music/track.flac",
        playing = (opts.playing ~= false),
        paused = (opts.paused == true),
        position = opts.position or 30.0,
        duration = opts.duration or 180.0,
        format = {
            path = (opts.format and opts.format.path) or opts.current_path or "/data/mnt/sd_0/Music/track.flac",
            codec = (opts.format and opts.format.codec) or "flac",
            bit_depth = (opts.format and opts.format.bit_depth ~= nil) and opts.format.bit_depth or 16,
            sample_rate = (opts.format and opts.format.sample_rate) or 44100,
            channels = (opts.format and opts.format.channels) or 2,
            is_stream = (opts.format and opts.format.is_stream == true) or false,
            is_dsd = (opts.format and opts.format.is_dsd == true) or false,
            playback_speed = (opts.format and opts.format.playback_speed) or 1.0,
            crossfade_enabled = (opts.format and opts.format.crossfade_enabled == true) or false,
            generation = (opts.format and opts.format.generation) or opts.generation or 1,
            duration_seconds = (opts.format and opts.format.duration_seconds) or opts.duration or 180.0,
        },
        -- Native AB loop state
        ab_loop = nil, -- { start = ..., finish = ... }
        -- Native AB switch state
        ab_switch_prepared = false,
        ab_switch_preparing = false,
        ab_switch_ready = false,
        ab_switch_source_b = false,
        ab_switch_target_path = nil,
        ab_switch_cleared_count = 0,
        -- Native EQ state
        live_eq = opts.initial_eq or harness.create_default_eq_state(),
        -- Timers (max 8 globally)
        timers = {},
        next_timer_id = 1,
        total_timer_allocations = 0,
        -- Storage
        storage_store = {},
        storage_fail = false,
        storage_write_count = 0,
        -- UI interactions recorded
        toasts = {},
        registered_list_items = {},
        active_settings_list = nil,
        settings_screens = {},
        settings_stack = {},
        list_screens = {},
        next_list_handle = 1,
        active_list = nil,
        active_text_input = nil,
        -- Events
        event_handlers = {},
        -- Filesystem
        files = opts.files or {},
    }

    local p = {}

    p.define = function(def)
        state.defined = def
    end

    p.api_version = function()
        return 16
    end

    p.has_capability = function(name)
        return state.capabilities[name] == true
    end

    p.sd_root = function()
        return state.sd_root
    end

    p.md5 = function(text)
        if type(text) ~= "string" and type(text) ~= "number" then
            error("bad argument #1 to 'md5' (string expected)", 2)
        end
        local str = tostring(text)
        local h1, h2, h3, h4 = 0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476
        for i = 1, #str do
            local b = string.byte(str, i)
            h1 = (h1 * 31 + b * i) % 0x100000000
            h2 = (h2 * 37 + b * (i + 7)) % 0x100000000
            h3 = (h3 * 41 + b * (i + 13)) % 0x100000000
            h4 = (h4 * 43 + b * (i + 19)) % 0x100000000
        end
        return string.format("%08x%08x%08x%08x", h1, h2, h3, h4)
    end

    p.is_playing = function()
        return state.playing and not state.paused
    end

    p.is_paused = function()
        return state.paused
    end

    p.get_current_track_path = function()
        return state.current_path
    end

    p.get_position = function()
        return state.position
    end

    p.get_duration = function()
        return state.duration
    end

    p.get_playback_format = function()
        if not state.playing then return nil end
        return harness.deep_copy(state.format)
    end

    p.get_playback_speed = function()
        return state.format.playback_speed or 1.0
    end

    p.get_crossfade = function()
        return state.format.crossfade_enabled == true
    end

    p.show_toast = function(msg)
        state.toasts[#state.toasts + 1] = msg
    end

    p.register_list_item = function(list_id, label, on_open, opts_reg)
        state.registered_list_items[#state.registered_list_items + 1] = {
            list_id = list_id,
            label = label,
            on_open = on_open,
            options = opts_reg,
        }
    end

    -- Settings screen pool (max 2 screens)
    p.show_settings_list = function(title, items, options)
        local capped_items = {}
        for i = 1, math.min(#items, 24) do
            capped_items[i] = items[i]
        end
        local screen = {
            title = title,
            items = capped_items,
            options = options,
        }
        if options and options.update == true then
            -- Prefer the most deeply nested live screen with this exact title
            for i = #state.settings_stack, 1, -1 do
                if state.settings_stack[i].title == title then
                    state.settings_stack[i] = screen
                    state.active_settings_list = state.settings_stack[#state.settings_stack]
                    state.settings_screens[#state.settings_screens + 1] = screen
                    return
                end
            end
        end
        -- Otherwise push a new settings screen; fail if pool of 2 is full
        if #state.settings_stack >= 2 then
            error("Native settings screen pool exhausted: maximum 2 screens can be stacked simultaneously", 2)
        end
        state.settings_stack[#state.settings_stack + 1] = screen
        state.active_settings_list = screen
        state.settings_screens[#state.settings_screens + 1] = screen
    end

    -- List screen pool (max 4 screens) with replace handle support
    p.show_list = function(title, items, on_select, options)
        local capped_items = {}
        for i = 1, math.min(#items, 500) do
            capped_items[i] = items[i]
        end

        if options and options.replace then
            local rep_handle = options.replace
            if #state.list_screens == 0 or state.list_screens[#state.list_screens].handle ~= rep_handle then
                return nil
            end
            local new_h = state.next_list_handle
            state.next_list_handle = state.next_list_handle + 1
            local screen = {
                handle = new_h,
                title = title,
                items = capped_items,
                on_select = on_select,
                options = options,
            }
            state.list_screens[#state.list_screens] = screen
            state.active_list = screen
            return new_h
        end

        if #state.list_screens >= 4 then
            return nil
        end
        local new_h = state.next_list_handle
        state.next_list_handle = state.next_list_handle + 1
        local screen = {
            handle = new_h,
            title = title,
            items = capped_items,
            on_select = on_select,
            options = options,
        }
        state.list_screens[#state.list_screens + 1] = screen
        state.active_list = screen
        return new_h
    end

    p.is_list_showing = function(handle)
        if #state.list_screens > 0 and state.list_screens[#state.list_screens].handle == handle then
            return true
        end
        return false
    end

    p.show_text_input = function(title, initial_text, is_password, on_submit)
        state.active_text_input = {
            title = title,
            initial_text = initial_text,
            is_password = is_password,
            on_submit = on_submit,
        }
        return true
    end

    -- Timers
    p.set_interval = function(seconds, callback)
        local active_count = 0
        for _ in pairs(state.timers) do active_count = active_count + 1 end
        if active_count >= 8 then
            error("Timer limit exceeded: maximum 8 active timers globally", 2)
        end
        local id = state.next_timer_id
        state.next_timer_id = state.next_timer_id + 1
        state.total_timer_allocations = state.total_timer_allocations + 1
        state.timers[id] = { seconds = seconds, callback = callback }
        return id
    end

    p.clear_interval = function(id)
        if id then
            state.timers[id] = nil
        end
    end

    -- Native AB loop
    p.set_ab_loop = function(start_s, finish_s)
        if not state.capabilities["playback.ab_loop"] then return false end
        if not state.playing or state.paused then return false end
        if not state.format or state.format.is_stream or state.format.is_dsd then return false end
        if state.format.codec ~= "flac" and state.format.codec ~= "pcm" then return false end
        if not state.format.bit_depth or state.format.bit_depth <= 0 or state.format.bit_depth > 16 then return false end
        if math.abs((state.format.playback_speed or 1.0) - 1.0) > 0.001 then return false end
        if state.format.crossfade_enabled then return false end
        if start_s < 0 or finish_s <= start_s or finish_s > state.duration then return false end

        state.ab_loop = { start = start_s, finish = finish_s }
        return true
    end

    p.get_ab_loop = function()
        if not state.ab_loop then return nil end
        return { start = state.ab_loop.start, finish = state.ab_loop.finish }
    end

    p.clear_ab_loop = function()
        state.ab_loop = nil
    end

    -- Native AB switch
    p.prepare_ab_switch = function(path)
        if not state.capabilities["playback.ab_switch"] then return false end
        if not state.playing or state.paused then return false end
        if not state.format or state.format.is_stream or state.format.is_dsd then return false end
        local is_16bit_lossless = (state.format.bit_depth == 16 and (state.format.codec == "flac" or state.format.codec == "pcm"))
        local is_mp3 = (state.format.codec == "mp3" and state.format.bit_depth == 0)
        if not is_16bit_lossless and not is_mp3 then return false end
        if math.abs((state.format.playback_speed or 1.0) - 1.0) > 0.001 then return false end
        if state.format.crossfade_enabled then return false end
        if not path or path == "" then return false end

        state.ab_switch_target_path = path
        state.ab_switch_preparing = true
        state.ab_switch_ready = false
        state.ab_switch_source_b = false
        return true
    end

    p.get_ab_switch = function()
        return {
            preparing = (state.ab_switch_preparing == true),
            ready = (state.ab_switch_ready == true),
            source = state.ab_switch_source_b and "b" or "a",
        }
    end

    p.select_ab_source = function(source_letter)
        if not state.ab_switch_ready then return false end
        if source_letter ~= "a" and source_letter ~= "b" then
            error("source must be 'a' or 'b'", 2)
        end
        state.ab_switch_source_b = (source_letter == "b")
        return true
    end

    p.clear_ab_switch = function()
        state.ab_switch_cleared_count = state.ab_switch_cleared_count + 1
        state.ab_switch_preparing = false
        state.ab_switch_ready = false
        state.ab_switch_source_b = false
        state.ab_switch_target_path = nil
    end

    -- Native EQ
    p.get_eq_state = function()
        if not state.capabilities["audio.peq.state"] then return nil end
        return harness.deep_copy(state.live_eq)
    end

    p.eq_apply_state = function(new_state, opts_apply)
        if not state.capabilities["audio.peq.state"] then return false end
        if type(new_state) ~= "table" then error("state must be table", 2) end
        if type(new_state.bypass) ~= "boolean" then error("bypass must be boolean", 2) end
        if type(new_state.preamp_db) ~= "number" then error("preamp_db must be number", 2) end
        if type(new_state.stereo_width) ~= "number" then error("stereo_width must be number", 2) end
        if type(new_state.bands) ~= "table" or #new_state.bands ~= 10 then
            error("bands must have 10 entries", 2)
        end
        state.live_eq = harness.deep_copy(new_state)
        return true
    end

    p.eq_apply_profile = function(path, opts_apply)
        if not state.capabilities["audio.peq.transient"] then return false end
        local profile = state.files[path]
        if not profile then return false end
        -- Apply profile to live_eq
        if type(profile) == "table" then
            state.live_eq = harness.deep_copy(profile)
        end
        return true
    end

    -- Events
    local valid_events = {
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

    p.on = function(event_name, handler)
        if not valid_events[event_name] then
            error(string.format("plugin.on: unknown event '%s'", tostring(event_name)), 2)
        end
        state.event_handlers[event_name] = state.event_handlers[event_name] or {}
        local list = state.event_handlers[event_name]
        if #list >= 16 then
            error("Event listener limit reached (max 16)", 2)
        end
        list[#list + 1] = handler
    end

    -- Storage
    local storage = {}
    storage.get = function(key)
        return state.storage_store[key]
    end
    storage.set = function(key, val)
        if state.storage_throw then error("storage hardware error", 2) end
        if state.storage_fail then return false end
        state.storage_write_count = state.storage_write_count + 1
        state.storage_store[key] = tostring(val)
        return true
    end
    storage.delete = function(key)
        if state.storage_throw then error("storage hardware error", 2) end
        if state.storage_fail then return false end
        state.storage_write_count = state.storage_write_count + 1
        state.storage_store[key] = nil
        return true
    end
    p.storage = storage

    -- Filesystem
    p.list_dir = function(dir)
        local res = {}
        for path, is_dir in pairs(state.files) do
            local parent = path:match("^(.*)/[^/]+$")
            if parent == dir then
                local name = path:match("[^/]+$")
                res[#res + 1] = { name = name, dir = (is_dir == true) }
            end
        end
        return res
    end

    -- Wrap and validate surface
    local frozen = freeze_surface(p)

    -- Simulation helpers on harness object
    local instance = {
        state = state,
        plugin = frozen,
    }

    function instance.trigger_event(event_name, ...)
        local list = state.event_handlers[event_name] or {}
        for _, handler in ipairs(list) do
            handler(...)
        end
    end

    function instance.tick_timers()
        -- Call all active timers
        for _, t in pairs(state.timers) do
            t.callback()
        end
    end

    function instance.active_timer_count()
        local count = 0
        for _ in pairs(state.timers) do count = count + 1 end
        return count
    end

    function instance.pop_list()
        if #state.list_screens > 0 then
            table.remove(state.list_screens)
            state.active_list = state.list_screens[#state.list_screens]
        end
    end

    function instance.pop_settings()
        if #state.settings_stack > 0 then
            table.remove(state.settings_stack)
            state.active_settings_list = state.settings_stack[#state.settings_stack]
        end
    end

    function instance.load_plugin(file_path)
        local env = {
            plugin = frozen,
            math = math,
            string = string,
            table = table,
            type = type,
            tostring = tostring,
            tonumber = tonumber,
            pcall = pcall,
            pairs = pairs,
            ipairs = ipairs,
            assert = assert,
            error = error,
            os = {
                time = os.time,
                clock = os.clock,
                date = os.date,
                difftime = os.difftime,
            },
            io = {
                open = io.open,
            },
        }
        local chunk, err = loadfile(file_path, "t", env)
        if not chunk then error("Failed to load plugin: " .. tostring(err)) end
        chunk()
        return env
    end

    return instance
end

return harness
