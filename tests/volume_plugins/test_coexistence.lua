local harness = require("harness")

local SLEEP_PLUGIN_PATH = "plugins/ExtendedSleepTimer/ExtendedSleepTimer.lua"
local LIMITER_PLUGIN_PATH = "plugins/VolumeLimiter/VolumeLimiter.lua"

local function run_tests(assert_eq, assert_true, assert_false)
    -- Test 1: Default features remain disabled, proper menu mapping, 0 timers when idle
    do
        local h = harness.new()
        local sleep_mod = h.load(SLEEP_PLUGIN_PATH)
        local limiter_mod = h.load(LIMITER_PLUGIN_PATH)

        assert_false(sleep_mod.is_armed(), "sleep timer is disabled by default")
        assert_false(limiter_mod.is_enabled(), "limiter is disabled by default")
        assert_eq(h.active_interval_count(), 0, "0 intervals allocated when features idle")

        local has_timers = false
        local has_audio = false
        for _, item in ipairs(h.list_items) do
            if item.list_id == "music_timers" and item.label == "Extended Sleep Timer" then
                has_timers = true
            elseif item.list_id == "music_audio" and item.label == "Volume Limiter" then
                has_audio = true
            end
        end
        assert_true(has_timers, "Extended Sleep Timer in music_timers")
        assert_true(has_audio, "Volume Limiter in music_audio")
        h.cleanup()
    end

    -- Test 2: Limiter enabled during fade immediately clamps volume quietly and transiently
    do
        local h = harness.new({ volume = 80 })
        local sleep_mod = h.load(SLEEP_PLUGIN_PATH)
        local limiter_mod = h.load(LIMITER_PLUGIN_PATH)

        sleep_mod.open_settings()
        local screen = h.settings_screens[1]
        screen.items[3].on_change(true) -- enable fade
        screen.items[4].on_change(15)   -- 15 min fade
        sleep_mod.set_armed(true)       -- 60 min timer

        -- Advance 48 minutes (into fade, 12 min left)
        h.advance_time(48 * 60)
        assert_true(sleep_mod.is_fade_in_progress(), "sleep timer fade is in progress")
        local vol_faded = h.volume
        assert_true(vol_faded > 55 and vol_faded < 80, "volume is between 55 and 80")

        -- Limiter is enabled with cap 50% in the middle of the fade
        limiter_mod.set_enabled(true)
        limiter_mod.set_max_volume(50)

        assert_eq(h.volume, 50, "limiter immediately clamped live volume to 50%")
        local last_call = h.set_volume_calls[#h.set_volume_calls]
        assert_true(last_call.silent, "clamp call was silent")
        assert_false(last_call.persist, "clamp call was transient (persist = false)")

        -- Advance 1 minute: sleep timer detects volume change and cancels further fading
        h.advance_time(60)
        assert_true(sleep_mod.is_fade_cancelled_manual(), "external volume change cancels fading for this countdown")
        assert_eq(h.volume, 50, "volume stays capped at 50%")

        -- Advance to completion: countdown still stops playback at deadline
        h.advance_time(11 * 60)
        assert_true(h.stop_called, "sleep timer stops at deadline")
        assert_eq(h.volume, 50, "volume remains safely capped at 50% without auto raise")

        h.cleanup()
    end

    -- Test 3: Limiter cap lowered during fade immediately clamps volume
    do
        local h = harness.new({ volume = 70 })
        local sleep_mod = h.load(SLEEP_PLUGIN_PATH)
        local limiter_mod = h.load(LIMITER_PLUGIN_PATH)

        limiter_mod.set_enabled(true)
        limiter_mod.set_max_volume(60)
        assert_eq(h.volume, 60, "initial clamp to 60")

        sleep_mod.open_settings()
        local screen = h.settings_screens[1]
        screen.items[3].on_change(true)
        screen.items[4].on_change(15)
        sleep_mod.set_armed(true)

        -- Advance 46 minutes (into fade)
        h.advance_time(46 * 60)
        local cur_vol = h.volume
        assert_true(cur_vol <= 60, "volume is <= 60")

        -- User lowers limiter cap to 35%
        limiter_mod.set_max_volume(35)
        assert_eq(h.volume, 35, "volume immediately clamped to new lower cap 35%")
        local last_call = h.set_volume_calls[#h.set_volume_calls]
        assert_true(last_call.silent, "silent clamp")
        assert_false(last_call.persist, "transient clamp")

        h.cleanup()
    end

    -- Test 4: Cancel, rearm, and finish produce NO automatic volume increase
    do
        local h = harness.new({ volume = 80 })
        local sleep_mod = h.load(SLEEP_PLUGIN_PATH)
        local limiter_mod = h.load(LIMITER_PLUGIN_PATH)

        sleep_mod.open_settings()
        local screen = h.settings_screens[1]
        screen.items[3].on_change(true)
        sleep_mod.set_armed(true)

        -- Advance into fade
        h.advance_time(50 * 60)
        local vol_at_cancel = h.volume
        assert_true(vol_at_cancel < 80, "volume faded")

        -- 1. Cancel
        sleep_mod.set_armed(false)
        assert_eq(h.volume, vol_at_cancel, "cancel produces NO automatic volume increase")

        -- 2. Rearm
        sleep_mod.set_armed(true)
        assert_eq(h.volume, vol_at_cancel, "rearm produces NO automatic volume increase")

        -- Advance to completion (60 min)
        h.advance_time(60 * 60)
        assert_true(h.stop_called, "stop called at deadline")
        assert_true(h.volume <= 1, "finish produces NO automatic volume increase")

        h.cleanup()
    end

    -- Test 5: Manual intervention during fade preserves volume without extra drain or auto raise
    do
        local h = harness.new({ volume = 80 })
        local sleep_mod = h.load(SLEEP_PLUGIN_PATH)
        local limiter_mod = h.load(LIMITER_PLUGIN_PATH)

        sleep_mod.open_settings()
        local screen = h.settings_screens[1]
        screen.items[3].on_change(true)
        sleep_mod.set_armed(true)

        -- Advance into fade
        h.advance_time(50 * 60)
        -- User manually adjusts volume to 45
        h.volume = 45
        h.advance_time(1) -- detected

        -- Advance 5 minutes
        h.advance_time(5 * 60)
        assert_eq(h.volume, 45, "volume stays at user manual 45 without unrequested drain")

        -- Cancel timer
        sleep_mod.set_armed(false)
        assert_eq(h.volume, 45, "manual volume preserved on cancel")

        h.cleanup()
    end

    -- Test 6: Assert { silent = true, persist = false } on EVERY setter call
    do
        local h = harness.new({ volume = 90 })
        local sleep_mod = h.load(SLEEP_PLUGIN_PATH)
        local limiter_mod = h.load(LIMITER_PLUGIN_PATH)

        limiter_mod.set_enabled(true)
        limiter_mod.set_max_volume(70)

        sleep_mod.open_settings()
        local screen = h.settings_screens[1]
        screen.items[3].on_change(true)
        sleep_mod.set_armed(true)
        h.advance_time(60 * 60)

        assert_true(#h.set_volume_calls > 0, "calls were made")
        for i, call in ipairs(h.set_volume_calls) do
            assert_true(call.silent, "call " .. i .. " must have silent = true")
            assert_false(call.persist, "call " .. i .. " must have persist = false")
        end

        h.cleanup()
    end

    -- Test 7: Preference save failure / missing storage handled cleanly
    do
        local h = harness.new({ fail_storage = true })
        local sleep_mod = h.load(SLEEP_PLUGIN_PATH)
        local limiter_mod = h.load(LIMITER_PLUGIN_PATH)

        -- Changing settings does not crash
        limiter_mod.set_enabled(true)
        limiter_mod.set_max_volume(65)
        sleep_mod.set_armed(true)
        assert_true(sleep_mod.is_armed(), "sleep timer armed despite storage failure")
        sleep_mod.set_armed(false)
        h.cleanup()
    end
end

return run_tests
