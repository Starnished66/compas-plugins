local harness = require("harness")

local PLUGIN_PATH = "plugins/ExtendedSleepTimer/ExtendedSleepTimer.lua"

local function run_tests(assert_eq, assert_true, assert_false)
    -- Test 1: Definition and Default State
    do
        local h = harness.new()
        local mod = h.load(PLUGIN_PATH)
        assert_eq(h.definition.id, "example.extended_sleep_timer", "stable plugin id preserved")
        assert_eq(h.definition.version, "1.2.0", "bumped version is 1.2.0")
        assert_eq(h.definition.api_min, 16, "targets api_min 16")
        assert_eq(#h.list_items, 1, "registers exactly one list item")
        assert_eq(h.list_items[1].list_id, "music_timers", "registered in music_timers menu")
        assert_false(mod.is_armed(), "timer is not armed by default")
        assert_eq(h.active_interval_count(), 0, "no timer intervals allocated while unarmed")
        h.cleanup()
    end

    -- Test 2: Arming, Disarming, and Timer Slot Allocation Failure
    do
        local h = harness.new()
        local mod = h.load(PLUGIN_PATH)
        assert_eq(h.active_interval_count(), 0, "initially 0 active intervals")

        mod.set_armed(true)
        assert_true(mod.is_armed(), "timer is armed")
        assert_eq(h.active_interval_count(), 1, "exactly 1 interval allocated while armed")
        assert_true(mod.has_timer(), "timer handle active")

        -- Rearm while already armed preserves the existing timer handle
        mod.set_armed(true)
        assert_true(mod.is_armed(), "remains armed after rearm")
        assert_eq(h.active_interval_count(), 1, "prior timer handle preserved on rearm")

        mod.set_armed(false)
        assert_false(mod.is_armed(), "timer is disarmed")
        assert_eq(h.active_interval_count(), 0, "interval cleared on disarm")
        assert_false(mod.has_timer(), "timer handle cleared")

        -- Test allocation failure when all 8 global intervals are occupied
        h.active_intervals = {}
        for i = 1, 8 do
            h.active_intervals[i] = { active = true, callback = function() end }
        end
        assert_eq(h.active_interval_count(), 8, "8 intervals saturated")

        local arm_result = mod.set_armed(true)
        assert_false(arm_result, "set_armed returns false when slots full")
        assert_false(mod.is_armed(), "arm must not claim active without a timer")
        assert_false(mod.has_timer(), "no timer handle held when slots full")

        h.cleanup()
    end

    -- Test 3: Bedtime Fade-out timing, proper ratio, monotonicity, and NO flash writes on ticks
    do
        local h = harness.new({ volume = 80 })
        local mod = h.load(PLUGIN_PATH)
        mod.open_settings()
        local screen = h.settings_screens[#h.settings_screens]

        -- Enable bedtime fade (item 3) and set fade duration to 15 min (item 4)
        local fade_toggle = screen.items[3]
        fade_toggle.on_change(true)
        assert_true(mod.is_fade_enabled(), "fade is enabled")

        local fade_slider = screen.items[4]
        fade_slider.on_change(15)
        assert_eq(mod.get_fade_minutes(), 15, "fade duration is 15 min")

        -- Arm timer for 60 minutes
        mod.set_armed(true)
        local start_calls = #h.set_volume_calls
        local start_storage_writes = h.storage_set_calls or 0

        -- Advance 44 minutes (2640 seconds). Timer has 16 minutes left; fade should NOT have started yet.
        h.advance_time(44 * 60)
        assert_eq(#h.set_volume_calls, start_calls, "no volume changes before fade window")
        assert_false(mod.is_fade_in_progress(), "fade is not in progress yet")
        assert_eq(h.volume, 80, "volume remains untouched at 80")

        -- Advance 60 seconds to exactly 15 minutes remaining (900s). Fade window starts!
        h.advance_time(60)
        assert_true(mod.is_fade_in_progress(), "fade begins at exactly fade window")
        assert_eq(mod.get_captured_volume(), 80, "captured starting volume once")

        -- Advance halfway through fade (7.5 min / 450s remaining)
        h.advance_time(450)
        local vol_mid = h.volume
        assert_true(vol_mid >= 38 and vol_mid <= 42, "volume ratio is ~50% at 50% time remaining")

        -- Assert that EVERY volume setter call passed { silent = true, persist = false }
        for i = start_calls + 1, #h.set_volume_calls do
            local c = h.set_volume_calls[i]
            assert_true(c.silent, "fade call must be silent (no popup)")
            assert_false(c.persist, "fade call must be transient (persist = false)")
        end

        -- Advance another 6 minutes (360 seconds), leaving ~1.5 minutes
        h.advance_time(360)
        local vol_late = h.volume
        assert_true(vol_late < vol_mid, "fade is strictly monotonic down")

        -- Assert NO storage/flash writes occurred during any of the timer ticks or volume fades!
        assert_eq(h.storage_set_calls, start_storage_writes, "no flash/storage writes during timer ticks or volume fades")

        h.cleanup()
    end

    -- Test 4: Timer completion stops playback without automatic volume increase
    do
        local h = harness.new({ volume = 75 })
        local mod = h.load(PLUGIN_PATH)
        mod.open_settings()
        local screen = h.settings_screens[#h.settings_screens]
        screen.items[3].on_change(true) -- enable fade
        screen.items[4].on_change(15)   -- 15 min fade
        mod.set_armed(true)             -- 60 min timer

        -- Advance 60 minutes to completion
        h.advance_time(60 * 60)

        assert_true(h.stop_called, "plugin.stop() was called upon timer completion")
        assert_false(mod.is_armed(), "timer is disarmed upon completion")
        assert_eq(h.active_interval_count(), 0, "interval cleared at finish")
        -- Volume must NOT automatically raise back to 75; live volume stays at its current level
        assert_true(h.volume <= 1, "volume stays at faded level, no race raising hardware gain on stop")

        h.cleanup()
    end

    -- Test 5: Timer cancellation leaves volume at current level with disclosure
    do
        local h = harness.new({ volume = 70 })
        local mod = h.load(PLUGIN_PATH)
        mod.open_settings()
        local screen = h.settings_screens[#h.settings_screens]
        screen.items[3].on_change(true)
        screen.items[4].on_change(15)
        mod.set_armed(true)

        -- Advance 50 minutes (into fade, 10 min left)
        h.advance_time(50 * 60)
        local vol_faded = h.volume
        assert_true(vol_faded < 70, "volume faded down")

        -- User cancels timer
        mod.set_armed(false)
        assert_false(mod.is_armed(), "timer disarmed")
        assert_eq(h.active_interval_count(), 0, "interval cleared on cancellation")
        -- Volume stays at current level; no automatic volume increase
        assert_eq(h.volume, vol_faded, "cancel does not automatically raise volume")

        local toast_found = false
        for _, t in ipairs(h.toasts) do
            if t:find("Volume stays at its current level", 1, true) then
                toast_found = true
                break
            end
        end
        assert_true(toast_found, "disclosed volume stays at current level upon cancel")

        h.cleanup()
    end

    -- Test 6: Manual volume intervention during fade cancels further fading for this countdown
    do
        local h = harness.new({ volume = 80 })
        local mod = h.load(PLUGIN_PATH)
        mod.open_settings()
        local screen = h.settings_screens[#h.settings_screens]
        screen.items[3].on_change(true)
        screen.items[4].on_change(15)
        mod.set_armed(true)

        -- Advance 50 minutes into fade
        h.advance_time(50 * 60)
        assert_true(mod.is_fade_in_progress(), "fade is in progress")

        -- User manually intervenes and adjusts volume to 55
        h.volume = 55
        h.advance_time(1) -- next tick detects manual change

        assert_true(mod.is_fade_cancelled_manual(), "manual change flags fade as cancelled")
        assert_false(mod.is_fade_in_progress(), "fade in progress is false after manual intervention")

        -- Check status display
        screen.items[#screen.items - 1].on_select() -- Show Time Remaining
        local last_toast = h.toasts[#h.toasts]
        assert_true(last_toast:find("fade cancelled by volume change", 1, true) ~= nil,
            "status visibly discloses fade cancelled by volume change")

        -- Advance further: volume stays at user's manual 55, no further fade drain
        h.advance_time(5 * 60)
        assert_eq(h.volume, 55, "volume stays at user manual 55 without unwanted draining")

        -- Timer reaches deadline: still stops playback
        h.advance_time(5 * 60)
        assert_true(h.stop_called, "countdown still stops playback at deadline")
        assert_eq(h.volume, 55, "finish preserves user manual volume without auto raise")

        h.cleanup()
    end

    -- Test 7: Disabling fade while armed leaves volume at current level with disclosure
    do
        local h = harness.new({ volume = 80 })
        local mod = h.load(PLUGIN_PATH)
        mod.open_settings()
        local screen = h.settings_screens[#h.settings_screens]
        screen.items[3].on_change(true)
        mod.set_armed(true)

        h.advance_time(50 * 60)
        local vol_faded = h.volume
        assert_true(vol_faded < 80, "volume faded")

        -- Disable fade toggle while armed
        screen.items[3].on_change(false)
        assert_false(mod.is_fade_enabled(), "fade disabled")
        assert_eq(h.volume, vol_faded, "disabling fade does not raise volume")

        local toast_found = false
        for _, t in ipairs(h.toasts) do
            if t:find("Volume stays at its current level", 1, true) then
                toast_found = true
                break
            end
        end
        assert_true(toast_found, "disclosed volume stays at current level when disabling fade")

        h.cleanup()
    end

    -- Test 8: Duration change while armed restarts countdown without raising volume
    do
        local h = harness.new({ volume = 90 })
        local mod = h.load(PLUGIN_PATH)
        mod.open_settings()
        local screen = h.settings_screens[#h.settings_screens]
        screen.items[3].on_change(true)
        mod.set_armed(true)

        h.advance_time(50 * 60)
        local vol_faded = h.volume

        -- Change duration slider from 60 to 90 min
        screen.items[2].on_change(90)
        assert_eq(mod.get_duration_minutes(), 90, "duration changed to 90 min")
        assert_false(mod.is_fade_in_progress(), "fade state reset")
        assert_eq(h.volume, vol_faded, "duration change does not raise volume")

        h.cleanup()
    end

    -- Test 9: Unsupported capabilities fallback to stop-only timer
    do
        local h = harness.new({
            volume = 80,
            capabilities = {
                ["playback.silent_volume"] = false,
                ["playback.transient_volume"] = false,
            },
        })
        local mod = h.load(PLUGIN_PATH)
        mod.open_settings()
        local screen = h.settings_screens[#h.settings_screens]

        assert_eq(screen.items[3].label, "Bedtime Fade-out: Unsupported", "reports unsupported in settings")

        mod.set_armed(true)
        h.advance_time(60 * 60)
        assert_true(h.stop_called, "stop-only timer still stops playback when capabilities missing")
        assert_eq(h.volume, 80, "volume was never modified")
        assert_eq(#h.set_volume_calls, 0, "no volume calls made")
        h.cleanup()
    end

    -- Test 10: Input validation for finite numbers
    do
        local h = harness.new()
        local mod = h.load(PLUGIN_PATH)
        mod.open_settings()
        local screen = h.settings_screens[#h.settings_screens]

        screen.items[2].on_change("invalid")
        assert_eq(mod.get_duration_minutes(), 60, "invalid duration defaults to 60")
        screen.items[2].on_change(math.huge)
        assert_eq(mod.get_duration_minutes(), 60, "infinite duration rejected")

        if screen.items[4] and screen.items[4].on_change then
            screen.items[4].on_change(-5)
            assert_eq(mod.get_fade_minutes(), 1, "negative fade clamped to 1")
            screen.items[4].on_change(100)
            assert_eq(mod.get_fade_minutes(), 30, "excessive fade clamped to 30")
        end

        h.cleanup()
    end

    -- Test 11: Transactional JSON blob, no ongoing SD file writes, failed save reload, and legacy migration
    do
        -- Subtest A: Modern JSON blob saved in plugin.storage["config"] and NO SD file created
        local h1 = harness.new()
        local mod1 = h1.load(PLUGIN_PATH)
        mod1.open_settings()
        local screen1 = h1.settings_screens[#h1.settings_screens]
        screen1.items[2].on_change(120) -- 2 hours
        screen1.items[3].on_change(true) -- enable fade
        screen1.items[4].on_change(20)   -- 20 min fade

        local blob = h1.storage_data["config"]
        assert_true(blob ~= nil, "config saved as JSON blob in storage")
        assert_true(blob:find('"version":1'), "contains version 1")
        assert_true(blob:find('"duration_minutes":120'), "contains duration 120")
        assert_true(blob:find('"fade_enabled":true'), "contains fade_enabled true")
        assert_true(blob:find('"fade_minutes":20'), "contains fade_minutes 20")

        -- Ongoing SD fallback writes must be removed: no SD state file created
        local sd_file = h1.sd_root_path .. "/.plugins/.extended_sleep_timer_state"
        local f_sd = io.open(sd_file, "r")
        assert_true(f_sd == nil, "no ongoing SD file writes performed when using storage")

        -- Subtest B: Migration from existing legacy 1-line SD file (duration-only)
        local h2 = harness.new()
        local legacy_sd = h2.sd_root_path .. "/.plugins/.extended_sleep_timer_state"
        local f_leg = assert(io.open(legacy_sd, "w"))
        f_leg:write("45\n")
        f_leg:close()

        local mod2 = h2.load(PLUGIN_PATH)
        assert_eq(mod2.get_duration_minutes(), 45, "migrated legacy duration 45")
        assert_false(mod2.is_fade_enabled(), "legacy migration defaults fade to disabled")
        assert_eq(mod2.get_fade_minutes(), 15, "legacy migration defaults fade to 15 min")

        -- Subtest C: Partial/incomplete blob does NOT mask legacy SD file
        local h3 = harness.new()
        local complete_sd = h3.sd_root_path .. "/.plugins/.extended_sleep_timer_state"
        local f_comp = assert(io.open(complete_sd, "w"))
        f_comp:write("90\n1\n25\n")
        f_comp:close()
        -- Stored config blob is incomplete (missing fade_enabled and fade_minutes)
        h3.storage_data["config"] = '{"version":1,"duration_minutes":30}'

        local mod3 = h3.load(PLUGIN_PATH)
        assert_eq(mod3.get_duration_minutes(), 90, "complete SD fallback duration loaded")
        assert_true(mod3.is_fade_enabled(), "complete SD fallback fade enabled loaded, not masked by partial blob")
        assert_eq(mod3.get_fade_minutes(), 25, "complete SD fallback fade minutes loaded")

        -- Subtest D: Malformed JSON matching regex fragments is strictly rejected
        local h4 = harness.new()
        h4.storage_data["config"] = '{version:1,duration_minutes:45,fade_enabled:true,fade_minutes:10'
        local mod4 = h4.load(PLUGIN_PATH)
        assert_eq(mod4.get_duration_minutes(), 60, "malformed JSON strictly rejected, defaults to 60")
        assert_false(mod4.is_fade_enabled(), "malformed JSON defaults fade to disabled")
        assert_eq(mod4.get_fade_minutes(), 15, "malformed JSON defaults fade minutes to 15")

        -- Subtest E: Old blob + failed new save + reload
        local h5 = harness.new()
        local mod5 = h5.load(PLUGIN_PATH)
        mod5.open_settings()
        local screen5 = h5.settings_screens[#h5.settings_screens]
        screen5.items[2].on_change(75)
        screen5.items[3].on_change(true)
        screen5.items[4].on_change(10)
        local initial_blob = h5.storage_data["config"]

        -- Now simulate storage durable/quota failure (storage.set returns false, error)
        h5.storage_failed = true
        local prev_toasts = #h5.toasts

        screen5.items[2].on_change(150)
        local toast_found = false
        for i = prev_toasts + 1, #h5.toasts do
            if h5.toasts[i]:find("for this session only (storage failed)", 1, true) then
                toast_found = true
                break
            end
        end
        assert_true(toast_found, "failure toast shown once without being overwritten")

        -- Also test fade toggle when save fails
        prev_toasts = #h5.toasts
        screen5.items[3].on_change(false)
        local toast_fade_found = false
        for i = prev_toasts + 1, #h5.toasts do
            if h5.toasts[i]:find("for this session only (storage failed)", 1, true) then
                toast_fade_found = true
                break
            end
        end
        assert_true(toast_fade_found, "fade toggle honors save failure with session toast")

        -- Also test fade duration slider when save fails
        prev_toasts = #h5.toasts
        screen5.items[4].on_change(20)
        local toast_dur_found = false
        for i = prev_toasts + 1, #h5.toasts do
            if h5.toasts[i]:find("for this session only (storage failed)", 1, true) then
                toast_dur_found = true
                break
            end
        end
        assert_true(toast_dur_found, "fade duration honors save failure with session toast")

        -- Storage retains old blob on failure
        assert_eq(h5.storage_data["config"], initial_blob, "storage preserves old complete blob on failure")

        -- No SD file is ever created
        assert_true(io.open(h5.sd_root_path .. "/.plugins/.extended_sleep_timer_state", "r") == nil,
            "no SD file written on save failure or success")

        -- Reload after failed save restores previous valid blob
        mod5.load_state()
        assert_eq(mod5.get_duration_minutes(), 75, "reload restores previous valid duration 75")
        assert_true(mod5.is_fade_enabled(), "reload restores previous valid fade enabled")
        assert_eq(mod5.get_fade_minutes(), 10, "reload restores previous valid fade minutes 10")

        h1.cleanup()
        h2.cleanup()
        h3.cleanup()
        h4.cleanup()
        h5.cleanup()
    end
end

return run_tests
