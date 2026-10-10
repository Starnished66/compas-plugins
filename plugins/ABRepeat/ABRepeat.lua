plugin.define({
    id = "example.ab_repeat",
    name = "A-B Repeat",
    version = "1.1.0",
    api_min = 16,
})

-- Practice looper utilizing native gapless A-B repeat.
-- Loop wrapping runs directly in the audio engine at decoder frame boundaries;
-- this plugin does not perform any timer-based seek approximations.
-- Supports finite local lossless audio (FLAC, WAV, AIFF, CAF) up to 16-bit PCM
-- at normal 1.0x playback speed with crossfade disabled.

local point_a = nil
local point_b = nil
local tracked_path = nil
local tracked_generation = nil
local poll_timer = nil

local function is_finite_number(n)
    return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end

local function get_track_storage_key(path, suffix)
    if not path or path == "" then return nil end
    local hash = plugin.md5 and plugin.md5(path)
    if type(hash) ~= "string" or hash == "" then return nil end
    return "ab_" .. suffix .. "_" .. hash
end

local function load_saved_points_for_track(path)
    point_a = nil
    point_b = nil
    tracked_path = path
    local cur_fmt = plugin.get_playback_format and plugin.get_playback_format()
    tracked_generation = cur_fmt and cur_fmt.generation or nil
    if not path or not plugin.storage then return end

    local key_a = get_track_storage_key(path, "a")
    local key_b = get_track_storage_key(path, "b")
    if key_a then
        local ok_a, val_a = pcall(function() return plugin.storage.get(key_a) end)
        if ok_a and val_a then
            local num = tonumber(val_a)
            if is_finite_number(num) and num >= 0 then point_a = num end
        end
    end
    if key_b then
        local ok_b, val_b = pcall(function() return plugin.storage.get(key_b) end)
        if ok_b and val_b then
            local num = tonumber(val_b)
            if is_finite_number(num) and num >= 0 then point_b = num end
        end
    end
end

local function persist_point_a(val)
    point_a = val
    if not tracked_path or not plugin.storage or not plugin.storage.set then
        return false
    end
    local key_a = get_track_storage_key(tracked_path, "a")
    if not key_a then return false end
    if is_finite_number(val) then
        local ok, res = pcall(function()
            return plugin.storage.set(key_a, string.format("%.3f", val))
        end)
        if not ok or not res then
            return false
        end
        return true
    else
        pcall(function()
            plugin.storage.delete(key_a)
        end)
        return true
    end
end

local function persist_point_b(val)
    point_b = val
    if not tracked_path or not plugin.storage or not plugin.storage.set then
        return false
    end
    local key_b = get_track_storage_key(tracked_path, "b")
    if not key_b then return false end
    if is_finite_number(val) then
        local ok, res = pcall(function()
            return plugin.storage.set(key_b, string.format("%.3f", val))
        end)
        if not ok or not res then
            return false
        end
        return true
    else
        pcall(function()
            plugin.storage.delete(key_b)
        end)
        return true
    end
end

local function stop_polling()
    if poll_timer then
        plugin.clear_interval(poll_timer)
        poll_timer = nil
    end
end

local function start_polling()
    if poll_timer then return end
    -- Wrap in pcall: timer slot exhaustion (8 max globally) can raise a native Lua error.
    local ok, handle = pcall(plugin.set_interval, 1, function()
        local loop = plugin.get_ab_loop and plugin.get_ab_loop()
        if not loop then
            -- Native loop was cleared by playback engine (seek, stop, eof); stop polling
            stop_polling()
        end
    end)
    if ok and handle then
        poll_timer = handle
    else
        poll_timer = nil
        plugin.show_toast("Warning: timer slots full; loop active in audio engine")
    end
end

-- Validate current playback eligibility for native A-B looping.
local function validate_playback_compatibility()
    if not plugin.has_capability or not plugin.has_capability("playback.ab_loop") then
        return false, "Player lacks playback.ab_loop capability"
    end
    if not plugin.is_playing or not plugin.is_playing() then
        return false, "Playback is paused or stopped (must be playing)"
    end
    if not plugin.get_playback_format then
        return false, "Playback format query not supported"
    end
    local fmt = plugin.get_playback_format()
    if not fmt then
        return false, "No active audio format loaded"
    end
    if fmt.is_stream then
        return false, "Streaming audio cannot be looped"
    end
    if fmt.is_dsd then
        return false, "DSD tracks cannot be looped"
    end
    -- Practice looper remains lossless only <= 16 bits.
    -- Codec must be FLAC or PCM (WAV, AIFF, CAF are handled as pcm).
    if fmt.codec ~= "flac" and fmt.codec ~= "pcm" then
        return false, string.format("Unsupported codec (%s): practice looper requires FLAC or PCM (WAV/AIFF/CAF)", fmt.codec or "unknown")
    end
    if not fmt.bit_depth or fmt.bit_depth <= 0 or fmt.bit_depth > 16 then
        return false, string.format("Unsupported bit depth (%d-bit): looper is limited to 16-bit or less", fmt.bit_depth or 0)
    end
    local speed = fmt.playback_speed
    if speed == nil and plugin.get_playback_speed then
        speed = plugin.get_playback_speed()
    end
    if not is_finite_number(speed) or speed ~= 1.0 then
        return false, string.format("Playback speed must be 1.0x (currently %s)", tostring(speed or "unknown"))
    end
    local crossfade = fmt.crossfade_enabled
    if crossfade == nil and plugin.get_crossfade then
        crossfade = plugin.get_crossfade()
    end
    if crossfade then
        return false, "Crossfade must be disabled in Sound settings"
    end
    if not is_finite_number(fmt.duration_seconds) or fmt.duration_seconds <= 0 then
        return false, "Track duration must be positive and finite"
    end
    if tracked_path and fmt.path and tracked_path ~= fmt.path then
        return false, "Track path mismatch with active playback"
    end
    if tracked_generation and fmt.generation and tracked_generation ~= fmt.generation then
        return false, "Track playback generation mismatch (reloaded or changed)"
    end
    return true
end

local function format_time(seconds)
    if not seconds or seconds < 0 then return "--:--" end
    local mins = math.floor(seconds / 60)
    local secs = seconds - (mins * 60)
    return string.format("%d:%05.2f", mins, secs)
end

local open_menu -- forward declaration

local function activate_loop()
    local ok, reason = validate_playback_compatibility()
    if not ok then
        plugin.show_toast("Cannot loop: " .. reason)
        return false
    end
    local cur = plugin.get_current_track_path and plugin.get_current_track_path()
    if not cur or cur ~= tracked_path then
        plugin.show_toast("Loop points belong to a different track")
        return false
    end
    if not point_a or not point_b then
        plugin.show_toast("Both Point A and Point B must be marked")
        return false
    end
    if point_b <= point_a then
        plugin.show_toast("Point B must be greater than Point A")
        return false
    end
    local dur = plugin.get_duration and plugin.get_duration() or 0
    if dur > 0 and point_b > dur then
        plugin.show_toast(string.format("Point B (%.2fs) exceeds track duration (%.2fs)", point_b, dur))
        return false
    end

    local accepted = plugin.set_ab_loop(point_a, point_b)
    if accepted then
        start_polling()
        plugin.show_toast(string.format("A-B Loop engaged: %s -> %s", format_time(point_a), format_time(point_b)))
        if open_menu then open_menu(true) end
        return true
    else
        plugin.show_toast("Loop rejected by audio engine")
        return false
    end
end

local function disengage_loop()
    if plugin.clear_ab_loop then
        plugin.clear_ab_loop()
    end
    stop_polling()
    plugin.show_toast("A-B loop disengaged (points preserved)")
    if open_menu then open_menu(true) end
end

local function clear_all_points()
    if plugin.clear_ab_loop then
        plugin.clear_ab_loop()
    end
    stop_polling()
    persist_point_a(nil)
    persist_point_b(nil)
    plugin.show_toast("A-B loop points cleared")
    if open_menu then open_menu(true) end
end

local function mark_point_a_now()
    if not plugin.is_playing or not plugin.is_playing() then
        plugin.show_toast("Cannot mark point: playback is idle or paused")
        return
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    local cur = (fmt and fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
    if not cur or cur == "" then
        plugin.show_toast("Cannot mark point: no active track loaded")
        return
    end
    local dur = (fmt and fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or 0
    if not is_finite_number(dur) or dur <= 0 then
        plugin.show_toast("Track duration unknown; cannot set loop point")
        return
    end
    local pos = plugin.get_position and plugin.get_position()
    if not is_finite_number(pos) or pos < 0 then
        plugin.show_toast("Invalid playback position")
        return
    end
    if pos > dur then
        plugin.show_toast(string.format("Position (%.2fs) exceeds duration (%.2fs)", pos, dur))
        return
    end

    if cur ~= tracked_path or (fmt and fmt.generation and fmt.generation ~= tracked_generation) then
        load_saved_points_for_track(cur)
    end
    tracked_path = cur
    tracked_generation = fmt and fmt.generation or nil

    pos = math.floor(pos * 1000 + 0.5) / 1000
    if pos > dur then pos = dur end

    local saved = persist_point_a(pos)
    if point_b and point_b <= point_a then
        persist_point_b(nil)
        if saved then
            plugin.show_toast(string.format("Point A set to %s (Point B reset)", format_time(pos)))
        else
            plugin.show_toast(string.format("Point A set to %s (Point B reset; not remembered across restarts)", format_time(pos)))
        end
    else
        if saved then
            plugin.show_toast(string.format("Point A set to %s", format_time(pos)))
        else
            plugin.show_toast(string.format("Point A set to %s (not remembered across restarts)", format_time(pos)))
        end
    end

    local current_loop = plugin.get_ab_loop and plugin.get_ab_loop()
    if current_loop then
        if point_a and point_b and point_b > point_a then
            activate_loop()
        else
            disengage_loop()
        end
    elseif open_menu then
        open_menu(true)
    end
end

local function mark_point_b_now()
    if not plugin.is_playing or not plugin.is_playing() then
        plugin.show_toast("Cannot mark point: playback is idle or paused")
        return
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    local cur = (fmt and fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
    if not cur or cur == "" then
        plugin.show_toast("Cannot mark point: no active track loaded")
        return
    end
    local dur = (fmt and fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or 0
    if not is_finite_number(dur) or dur <= 0 then
        plugin.show_toast("Track duration unknown; cannot set loop point")
        return
    end
    local pos = plugin.get_position and plugin.get_position()
    if not is_finite_number(pos) or pos < 0 then
        plugin.show_toast("Invalid playback position")
        return
    end
    if pos > dur then
        plugin.show_toast(string.format("Position (%.2fs) exceeds duration (%.2fs)", pos, dur))
        return
    end

    if cur ~= tracked_path or (fmt and fmt.generation and fmt.generation ~= tracked_generation) then
        load_saved_points_for_track(cur)
    end

    pos = math.floor(pos * 1000 + 0.5) / 1000
    if pos > dur then pos = dur end

    if point_a and pos <= point_a then
        plugin.show_toast(string.format("Point B (%s) must be after Point A (%s)", format_time(pos), format_time(point_a)))
        return
    end

    tracked_path = cur
    tracked_generation = fmt and fmt.generation or nil

    local saved = persist_point_b(pos)
    if saved then
        plugin.show_toast(string.format("Point B set to %s", format_time(pos)))
    else
        plugin.show_toast(string.format("Point B set to %s (not remembered across restarts)", format_time(pos)))
    end

    local current_loop = plugin.get_ab_loop and plugin.get_ab_loop()
    if current_loop then
        if point_a and point_b and point_b > point_a then
            activate_loop()
        else
            disengage_loop()
        end
    elseif open_menu then
        open_menu(true)
    end
end

local function edit_point_a_text()
    if not plugin.show_text_input then return end
    if not plugin.is_playing or not plugin.is_playing() then
        plugin.show_toast("Cannot set point: playback is idle or paused")
        return
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    local cur = (fmt and fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
    if not cur or cur == "" then
        plugin.show_toast("No active track loaded")
        return
    end
    local dur = (fmt and fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or 0
    if not is_finite_number(dur) or dur <= 0 then
        plugin.show_toast("Track duration unknown; cannot set loop point")
        return
    end
    local captured_path = cur
    local captured_gen = fmt and fmt.generation or nil
    local captured_dur = dur

    if cur ~= tracked_path or (captured_gen and captured_gen ~= tracked_generation) then
        load_saved_points_for_track(cur)
    end

    local init = point_a and string.format("%.3f", point_a) or "0.000"
    plugin.show_text_input("Point A (seconds)", init, false, function(text)
        if not plugin.is_playing or not plugin.is_playing() then
            plugin.show_toast("Rejected: playback became paused or idle")
            return
        end
        local cur_fmt = plugin.get_playback_format and plugin.get_playback_format()
        local active_path = (cur_fmt and cur_fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
        if not active_path or active_path ~= captured_path then
            plugin.show_toast("Rejected: track changed while entering point")
            return
        end
        if not cur_fmt or not captured_gen or cur_fmt.generation ~= captured_gen then
            plugin.show_toast("Rejected: track reloaded while entering point")
            return
        end
        local val = tonumber(text)
        if not is_finite_number(val) or val < 0 then
            plugin.show_toast("Invalid Point A: enter non-negative finite seconds")
            return
        end
        local active_dur = (cur_fmt and cur_fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or captured_dur
        if not is_finite_number(active_dur) or active_dur <= 0 then
            plugin.show_toast("Track duration unknown; cannot set loop point")
            return
        end
        if val > active_dur then
            plugin.show_toast(string.format("Point A (%.2fs) exceeds track duration (%.2fs)", val, active_dur))
            return
        end
        val = math.floor(val * 1000 + 0.5) / 1000
        if val > active_dur then val = active_dur end

        tracked_path = captured_path
        tracked_generation = captured_gen
        local saved = persist_point_a(val)
        if point_b and point_b <= point_a then
            persist_point_b(nil)
            if saved then
                plugin.show_toast(string.format("Point A set to %s (Point B reset)", format_time(val)))
            else
                plugin.show_toast(string.format("Point A set to %s (Point B reset; not remembered across restarts)", format_time(val)))
            end
        else
            if saved then
                plugin.show_toast(string.format("Point A set to %s", format_time(val)))
            else
                plugin.show_toast(string.format("Point A set to %s (not remembered across restarts)", format_time(val)))
            end
        end

        local current_loop = plugin.get_ab_loop and plugin.get_ab_loop()
        if current_loop then
            if point_a and point_b and point_b > point_a then
                activate_loop()
            else
                disengage_loop()
            end
        elseif open_menu then
            open_menu(true)
        end
    end)
end

local function edit_point_b_text()
    if not plugin.show_text_input then return end
    if not plugin.is_playing or not plugin.is_playing() then
        plugin.show_toast("Cannot set point: playback is idle or paused")
        return
    end
    local fmt = plugin.get_playback_format and plugin.get_playback_format()
    local cur = (fmt and fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
    if not cur or cur == "" then
        plugin.show_toast("No active track loaded")
        return
    end
    local dur = (fmt and fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or 0
    if not is_finite_number(dur) or dur <= 0 then
        plugin.show_toast("Track duration unknown; cannot set loop point")
        return
    end
    local captured_path = cur
    local captured_gen = fmt and fmt.generation or nil
    local captured_dur = dur

    if cur ~= tracked_path or (captured_gen and captured_gen ~= tracked_generation) then
        load_saved_points_for_track(cur)
    end

    local init = point_b and string.format("%.3f", point_b) or (point_a and string.format("%.3f", point_a + 5) or "10.000")
    plugin.show_text_input("Point B (seconds)", init, false, function(text)
        if not plugin.is_playing or not plugin.is_playing() then
            plugin.show_toast("Rejected: playback became paused or idle")
            return
        end
        local cur_fmt = plugin.get_playback_format and plugin.get_playback_format()
        local active_path = (cur_fmt and cur_fmt.path) or (plugin.get_current_track_path and plugin.get_current_track_path())
        if not active_path or active_path ~= captured_path then
            plugin.show_toast("Rejected: track changed while entering point")
            return
        end
        if not cur_fmt or not captured_gen or cur_fmt.generation ~= captured_gen then
            plugin.show_toast("Rejected: track reloaded while entering point")
            return
        end
        local val = tonumber(text)
        if not is_finite_number(val) or val <= 0 then
            plugin.show_toast("Invalid Point B: enter positive finite seconds")
            return
        end
        local active_dur = (cur_fmt and cur_fmt.duration_seconds) or (plugin.get_duration and plugin.get_duration()) or captured_dur
        if not is_finite_number(active_dur) or active_dur <= 0 then
            plugin.show_toast("Track duration unknown; cannot set loop point")
            return
        end
        if val > active_dur then
            plugin.show_toast(string.format("Point B (%.2fs) exceeds track duration (%.2fs)", val, active_dur))
            return
        end
        val = math.floor(val * 1000 + 0.5) / 1000
        if val > active_dur then val = active_dur end
        if point_a and val <= point_a then
            plugin.show_toast(string.format("Point B (%s) must be after Point A (%s)", format_time(val), format_time(point_a)))
            return
        end

        tracked_path = captured_path
        tracked_generation = captured_gen
        local saved = persist_point_b(val)
        if saved then
            plugin.show_toast(string.format("Point B set to %s", format_time(val)))
        else
            plugin.show_toast(string.format("Point B set to %s (not remembered across restarts)", format_time(val)))
        end

        local current_loop = plugin.get_ab_loop and plugin.get_ab_loop()
        if current_loop then
            if point_a and point_b and point_b > point_a then
                activate_loop()
            else
                disengage_loop()
            end
        elseif open_menu then
            open_menu(true)
        end
    end)
end

local function show_about()
    if not plugin.show_list then return end
    plugin.show_list("About A-B Repeat", {
        "A-B Repeat practice looper provides sample-accurate looping.",
        "Looping executes natively in the audio engine frame processor.",
        "Supports finite local FLAC, WAV, AIFF, and CAF audio up to 16-bit.",
        "Playback speed must be 1.0x and crossfade must be disabled.",
        "Loop points are linked to the specific track and bounded by its duration.",
        "Engine loop clears on pause, seek, or track changes, but your points are kept.",
        "No continuous seeking is performed from Lua timers.",
    }, function() end)
end

open_menu = function(update)
    local cur = plugin.get_current_track_path and plugin.get_current_track_path()
    if cur and cur ~= tracked_path then
        load_saved_points_for_track(cur)
    end

    local current_loop = plugin.get_ab_loop and plugin.get_ab_loop()
    local is_active = (current_loop ~= nil)

    local status_text
    if is_active then
        status_text = string.format("Status: Active (%s - %s)", format_time(current_loop.start), format_time(current_loop.finish))
    elseif point_a and point_b then
        status_text = string.format("Status: Ready (%s - %s)", format_time(point_a), format_time(point_b))
    elseif point_a then
        status_text = string.format("Status: Incomplete (A: %s, B: --)", format_time(point_a))
    else
        status_text = "Status: Not configured"
    end

    local items = {
        {
            type = "row",
            label = status_text,
            on_select = function()
                plugin.show_toast(status_text)
            end,
        },
        {
            type = "row",
            label = is_active and "Disengage Loop" or "Engage Loop",
            on_select = function()
                if is_active then
                    disengage_loop()
                else
                    activate_loop()
                end
            end,
        },
        {
            type = "row",
            label = "Mark Point A (Current Time)",
            on_select = mark_point_a_now,
        },
        {
            type = "row",
            label = "Mark Point B (Current Time)",
            on_select = mark_point_b_now,
        },
        {
            type = "row",
            label = "Edit Point A (Numeric)...",
            on_select = edit_point_a_text,
        },
        {
            type = "row",
            label = "Edit Point B (Numeric)...",
            on_select = edit_point_b_text,
        },
        {
            type = "row",
            label = "Clear Loop Points",
            on_select = clear_all_points,
        },
        {
            type = "row",
            label = "About A-B Repeat",
            on_select = show_about,
        },
    }

    if plugin.show_settings_list then
        plugin.show_settings_list("A-B Repeat", items, { update = true })
    end
end

-- Initialize stored state for currently loaded track (if any)
local initial_track = plugin.get_current_track_path and plugin.get_current_track_path()
load_saved_points_for_track(initial_track)

-- React to playback events: pause, stop, track changes natively clear the loop.
-- Native invalidations must clear owned active polling.
if plugin.on then
    plugin.on("paused", function()
        stop_polling()
    end)
    plugin.on("stopped", function()
        stop_polling()
    end)
    plugin.on("track_started", function()
        stop_polling()
        local new_track = plugin.get_current_track_path and plugin.get_current_track_path()
        load_saved_points_for_track(new_track)
    end)
end

if plugin.register_list_item then
    plugin.register_list_item("playback", "A-B Repeat", function()
        open_menu(false)
    end)
end
