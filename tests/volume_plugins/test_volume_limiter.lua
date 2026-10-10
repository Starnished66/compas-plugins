local harness = require("harness")

local PLUGIN_PATH = "plugins/VolumeLimiter/VolumeLimiter.lua"

local function run_tests(assert_eq, assert_true, assert_false)
    -- A remembered volume above a persisted cap must be clamped on load,
    -- even when no volume_changed event follows boot.
    do
        local h = harness.new({ volume = 90 })
        h.storage_data.config = '{"version":1,"enabled":true,"max_volume":10}'
        local mod = h.load(PLUGIN_PATH)
        assert_true(mod.is_enabled(), "persisted limiter enabled on boot")
        assert_eq(h.volume, 10, "startup volume clamped without an event")
        assert_eq(#h.set_volume_calls, 1, "one startup clamp")
        assert_true(h.set_volume_calls[1].silent, "startup clamp silent")
        assert_false(h.set_volume_calls[1].persist, "startup clamp transient")
        assert_eq(h.storage_set_calls or 0, 0, "startup enforcement does not write preferences")
        assert_eq(h.active_interval_count(), 0, "startup enforcement needs no timer")
        h.cleanup()
    end

    -- Test 1: Definition and Default State
    do
        local h = harness.new()
        local mod = h.load(PLUGIN_PATH)
        assert_eq(h.definition.id, "compas.volume_limiter", "stable volume limiter id")
        assert_eq(h.definition.version, "1.1.0", "version 1.1.0")
        assert_eq(h.definition.api_min, 16, "targets api_min 16")
        assert_eq(#h.list_items, 1, "registers exactly one list item")
        assert_eq(h.list_items[1].list_id, "music_audio", "registered in music_audio menu")
        assert_false(mod.is_enabled(), "limiter is disabled by default")
        assert_eq(mod.get_max_volume(), 70, "default maximum volume is 70%")
        assert_eq(h.active_interval_count(), 0, "no timers allocated for volume limiter")
        h.cleanup()
    end

    -- Test 2: Immediate clamping upon enable asserts silent=true AND persist=false
    do
        local h = harness.new({ volume = 85 })
        local mod = h.load(PLUGIN_PATH)
        assert_eq(h.volume, 85, "volume initially 85%")

        mod.set_enabled(true)
        assert_eq(h.volume, 70, "volume immediately clamped to 70% upon enable")
        local last_call = h.set_volume_calls[#h.set_volume_calls]
        assert_eq(last_call.percent, 70, "set_volume percent is 70")
        assert_true(last_call.silent, "clamping is silent (no popup)")
        assert_false(last_call.persist, "clamping is transient (persist = false to avoid saving overshoots)")
        h.cleanup()
    end

    -- Test 3: Immediate clamping upon lowering cap asserts persist=false
    do
        local h = harness.new({ volume = 65 })
        local mod = h.load(PLUGIN_PATH)
        mod.set_enabled(true)
        assert_eq(h.volume, 65, "volume stays 65% since below default cap 70%")

        -- Lower cap to 50%
        mod.set_max_volume(50)
        assert_eq(h.volume, 50, "volume immediately clamped to 50% upon lowering cap")
        local last_call = h.set_volume_calls[#h.set_volume_calls]
        assert_eq(last_call.percent, 50, "clamped to 50%")
        assert_true(last_call.silent, "clamping is silent")
        assert_false(last_call.persist, "clamping is transient (persist = false)")
        h.cleanup()
    end

    -- Test 4: volume_changed event callback signature, clamping, and NO flash writes
    do
        local h = harness.new({ volume = 50 })
        local mod = h.load(PLUGIN_PATH)
        mod.set_enabled(true)
        mod.set_max_volume(60)

        local storage_writes_before = h.storage_set_calls or 0

        -- Fire volume_changed with 40% (below cap): no clamping
        local calls_before = #h.set_volume_calls
        h.volume = 40
        h.emit("volume_changed", 40)
        assert_eq(#h.set_volume_calls, calls_before, "idempotent: no clamp for volume below cap")

        -- Fire volume_changed with 80% (above cap): clamped to 60%
        h.volume = 80
        h.emit("volume_changed", 80)
        assert_eq(h.volume, 60, "clamped to cap on volume_changed event")
        local last_call = h.set_volume_calls[#h.set_volume_calls]
        assert_eq(last_call.percent, 60, "clamped to 60%")
        assert_true(last_call.silent, "clamped silently")
        assert_false(last_call.persist, "clamped with persist = false")

        -- Assert NO flash writes (storage.set calls) occurred during volume events or clamping!
        assert_eq(h.storage_set_calls, storage_writes_before, "no flash/storage writes during volume clamp events")

        h.volume = 20 -- a fade already lowered the live value after this event was sampled
        calls_before = #h.set_volume_calls
        h.emit("volume_changed", 80)
        assert_eq(h.volume, 20, "stale overshoot notification cannot raise faded volume")
        assert_eq(#h.set_volume_calls, calls_before, "stale notification does not write volume")

        h.cleanup()
    end

    -- Test 5: Reentrancy guard with error recovery
    do
        local h = harness.new({
            volume = 50,
            synchronous_reentrant_volume_changed = true,
        })
        local mod = h.load(PLUGIN_PATH)
        mod.set_enabled(true)
        mod.set_max_volume(65)

        -- Synchronous reentrancy: set_volume dispatches volume_changed
        local ok, err = pcall(function()
            h.volume = 90
            h.emit("volume_changed", 90)
        end)
        assert_true(ok, "reentrant volume_changed did not raise error: " .. tostring(err))
        assert_eq(h.volume, 65, "volume clamped safely despite reentrant notifications")
        assert_false(mod.is_in_clamp(), "in_clamp guard reset to false after normal clamp")

        -- Simulate native set_volume throwing an error: in_clamp MUST NOT get stuck!
        h.fail_set_volume = true
        mod.apply_clamp(60)
        assert_false(mod.is_in_clamp(), "in_clamp guard reset to false even when set_volume raises error")
        h.fail_set_volume = false

        h.cleanup()
    end

    -- Test 6: Capability gating requires BOTH silent and transient volume
    do
        -- Lacking transient_volume
        local h1 = harness.new({
            volume = 80,
            capabilities = {
                ["playback.silent_volume"] = true,
                ["playback.transient_volume"] = false,
            },
        })
        local mod1 = h1.load(PLUGIN_PATH)
        mod1.open_settings()
        local screen1 = h1.settings_screens[#h1.settings_screens]
        assert_eq(screen1.items[1].label, "Volume Limiter: Unsupported", "unsupported when missing transient volume")
        mod1.set_enabled(true)
        assert_eq(h1.volume, 80, "does not clamp without transient volume capability")
        h1.cleanup()

        -- Lacking silent_volume
        local h2 = harness.new({
            volume = 80,
            capabilities = {
                ["playback.silent_volume"] = false,
                ["playback.transient_volume"] = true,
            },
        })
        local mod2 = h2.load(PLUGIN_PATH)
        mod2.open_settings()
        local screen2 = h2.settings_screens[#h2.settings_screens]
        assert_eq(screen2.items[1].label, "Volume Limiter: Unsupported", "unsupported when missing silent volume")
        mod2.set_enabled(true)
        assert_eq(h2.volume, 80, "does not clamp without silent volume capability")
        h2.cleanup()
    end

    -- Test 7: Hearing safety disclaimer and coalesced 500ms disclosure in About screen
    do
        local h = harness.new()
        local mod = h.load(PLUGIN_PATH)
        mod.open_settings()
        local screen = h.settings_screens[#h.settings_screens]
        screen.items[#screen.items].on_select() -- About Volume Limiter
        local about_screen = h.lists_shown[#h.lists_shown]
        assert_true(about_screen ~= nil, "about screen was shown")

        local text = table.concat(about_screen.items, " ")
        assert_true(text:find("Software limiter only", 1, true) ~= nil,
            "discloses software ceiling nature without false hardware hearing safety guarantees")
        assert_true(text:find("500ms", 1, true) ~= nil,
            "discloses native 500ms event coalescing")
        h.cleanup()
    end

    -- Test 8: Old blob + failed new save + reload and caller toast honoring save failure
    do
        local h = harness.new({ volume = 90 })
        local mod = h.load(PLUGIN_PATH)

        -- Initial successful save
        mod.set_enabled(true)
        mod.set_max_volume(60)
        local initial_blob = h.storage_data["config"]
        assert_true(initial_blob ~= nil, "config blob saved")

        -- Now simulate storage durable/quota failure where storage.set returns false, error
        h.storage_failed = true
        local prev_toasts = #h.toasts

        -- Attempt to change cap to 40
        mod.set_max_volume(40)

        -- Toast explicitly informs user it applies for this session only
        local failure_toast_found = false
        for i = prev_toasts + 1, #h.toasts do
            if h.toasts[i]:find("for this session only (storage failed)", 1, true) then
                failure_toast_found = true
                break
            end
        end
        assert_true(failure_toast_found, "failure toast shown once without being overwritten by success toast")

        -- Live clamp STILL works immediately
        assert_eq(h.volume, 40, "live clamp works immediately even when persistence fails")

        -- Attempt to toggle enabled while storage fails
        prev_toasts = #h.toasts
        mod.set_enabled(false)
        local disable_toast_found = false
        for i = prev_toasts + 1, #h.toasts do
            if h.toasts[i]:find("for this session only (storage failed)", 1, true) then
                disable_toast_found = true
                break
            end
        end
        assert_true(disable_toast_found, "set_enabled honors save failure with session toast")

        -- Storage retains old complete blob on failure
        assert_eq(h.storage_data["config"], initial_blob, "storage preserves old complete blob on failure")

        -- Reload after failed save restores previous valid blob
        mod.load_state()
        assert_true(mod.is_enabled(), "reload restores previous valid enabled true")
        assert_eq(mod.get_max_volume(), 60, "reload restores previous valid max_volume 60")

        h.cleanup()
    end

    -- Test 9: Malformed JSON matching regex fragments is strictly rejected by native JSON decoder
    do
        local h = harness.new()
        -- Malformed JSON that would match a loose regex (missing quote around key or unquoted string)
        h.storage_data["config"] = '{version:1,enabled:true,max_volume:50'
        local mod = h.load(PLUGIN_PATH)
        -- Native json_decode fails, so invalid JSON stays invalid
        assert_false(mod.is_enabled(), "malformed json safely defaults enabled to false")
        assert_eq(mod.get_max_volume(), 70, "malformed json safely defaults max_volume to 70")
        h.cleanup()
    end
end

return run_tests
