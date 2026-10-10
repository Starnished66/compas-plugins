-- Tests for OutputAwareSound:
-- Initial snapshot, output_changed events, deduplication, codec mappings,
-- transient PEQ application, hearing safety (no volume jumps), EQ ownership policy,
-- unmapped route runtime baseline restoration, baseline preservation across UI edits,
-- 1e-6 numeric precision, traversal rejection, UI roundtrip.

local harness = require("context_harness")

return function(assert_eq, assert_true, assert_false)
    local test_dir = os.getenv("PWD") .. "/build_test/context_plugin_tests/output_aware"
    os.execute("rm -rf '" .. test_dir .. "' && mkdir -p '" .. test_dir .. "'")

    -- 1. Route key resolution & Bluetooth codec mappings with fallbacks
    do
        local h = harness.new({ sd_root = test_dir .. "/case1" })
        local M = h.load("plugins/OutputAwareSound/OutputAwareSound.lua")

        local r1 = M.resolve_route_key({ route = "wired", active = true })
        assert_eq(r1, "wired", "wired route key")

        local r2 = M.resolve_route_key({ route = "usb_dac", active = true })
        assert_eq(r2, "usb_dac", "usb_dac route key")

        local r3 = M.resolve_route_key({ route = "bluetooth", active = true, bluetooth_codec = "LDAC" })
        assert_eq(r3, "bluetooth:ldac", "bluetooth ldac key lowercase")

        local r4 = M.resolve_route_key({ route = "bluetooth", active = true, bluetooth_codec = nil })
        assert_eq(r4, "bluetooth:unknown", "bluetooth without codec maps to bluetooth:unknown")

        M.config.routes = {
            ["wired"] = "Wired.peq",
            ["usb_dac"] = "DAC.peq",
            ["bluetooth:ldac"] = "LDAC.peq",
            ["bluetooth:default"] = "BT_Default.peq",
        }

        assert_eq(M.resolve_profile_for_route_key("wired"), "Wired.peq", "wired profile")
        assert_eq(M.resolve_profile_for_route_key("usb_dac"), "DAC.peq", "usb_dac profile")
        assert_eq(M.resolve_profile_for_route_key("bluetooth:ldac"), "LDAC.peq", "bluetooth ldac profile")
        assert_eq(M.resolve_profile_for_route_key("bluetooth:aptx"), "BT_Default.peq", "aptx falls back to bluetooth:default")
        assert_eq(M.resolve_profile_for_route_key("bluetooth:unknown"), "BT_Default.peq", "unknown falls back to bluetooth:default")
    end

    -- 2. Initial snapshot on enable & output_changed deduplication
    do
        local h = harness.new({ sd_root = test_dir .. "/case2" })
        h.create_fixture_profile("Wired.peq")
        h.create_fixture_profile("BT_SBC.peq")
        h.create_fixture_profile("BT_LDAC.peq")
        local M = h.load("plugins/OutputAwareSound/OutputAwareSound.lua")

        M.config.routes["wired"] = "Wired.peq"
        M.config.routes["bluetooth:sbc"] = "BT_SBC.peq"
        M.config.routes["bluetooth:ldac"] = "BT_LDAC.peq"

        h.output_info.route = "wired"
        M.config.enabled = true
        M.grant_control(false)

        assert_eq(#h.eq_apply_calls, 1, "initial route snapshot applied Wired.peq on enable")
        assert_eq(h.eq_apply_calls[1].opts.persist, false, "applied transiently")
        assert_eq(#h.volume_calls, 0, "no automatic volume changes (hearing safety)")
        assert_eq(#h.eq_set_preamp_calls, 0, "no persistent eq_set_preamp calls")

        h.emit("output_changed", { route = "wired", active = true }, { route = "wired", active = true })
        assert_eq(#h.eq_apply_calls, 1, "deduplicated: no redundant profile apply for same route")

        h.emit("output_changed", { route = "bluetooth", active = true, bluetooth_codec = "sbc" }, { route = "wired" })
        assert_eq(#h.eq_apply_calls, 2, "Bluetooth SBC profile applied")

        h.emit("output_changed", { route = "bluetooth", active = true, bluetooth_codec = "ldac" }, { route = "bluetooth", bluetooth_codec = "sbc" })
        assert_eq(#h.eq_apply_calls, 3, "Bluetooth LDAC profile applied on codec switch")

        h.emit("output_changed", { route = "bluetooth", active = true, bluetooth_codec = "ldac" }, { route = "bluetooth", bluetooth_codec = "ldac" })
        assert_eq(#h.eq_apply_calls, 3, "deduplicated: no duplicate apply for same codec")
    end

    -- 3. Restore runtime baseline when switching to unmapped output route
    do
        local h = harness.new({ sd_root = test_dir .. "/case3" })
        h.create_fixture_profile("BT_Profile.peq")
        local M = h.load("plugins/OutputAwareSound/OutputAwareSound.lua")

        h.eq_state.preamp_db = -1.5
        M.config.routes["bluetooth:sbc"] = "BT_Profile.peq"
        -- usb_dac is left unmapped ("")
        M.config.routes["usb_dac"] = ""

        M.config.enabled = true
        M.grant_control(false)

        -- Route 1: Bluetooth SBC (matches profile)
        h.emit("output_changed", { route = "bluetooth", active = true, bluetooth_codec = "sbc" }, { route = "wired" })
        assert_eq(#h.eq_apply_calls, 1, "BT_Profile applied")

        -- Route 2: Unmapped route (USB DAC)
        h.emit("output_changed", { route = "usb_dac", active = true }, { route = "bluetooth" })

        -- Plugin MUST restore runtime baseline and clear active profile!
        assert_eq(#h.eq_state_calls, 1, "baseline EQ restored when switching to unmapped route")
        assert_eq(h.eq_state.preamp_db, -1.5, "EQ returned to initial baseline")
        assert_eq(M.get_status().last_applied_profile, nil, "cleared last applied profile")

        -- Case B: Manual override no-clobber when leaving mapped route
        h.emit("output_changed", { route = "bluetooth", active = true, bluetooth_codec = "sbc" }, { route = "usb_dac" })
        assert_eq(#h.eq_apply_calls, 2, "re-applied BT profile")

        -- User manual edit during Bluetooth
        h.eq_state.preamp_db = 6.2
        local calls_before = #h.eq_state_calls

        -- Switch to unmapped USB DAC
        h.emit("output_changed", { route = "usb_dac", active = true }, { route = "bluetooth" })
        assert_true(M.get_status().suspended, "suspended on manual edit during route exit")
        assert_eq(#h.eq_state_calls, calls_before, "did not overwrite user manual EQ")
        assert_eq(h.eq_state.preamp_db, 6.2, "user manual EQ preserved intact")
    end

    -- 4. Baseline preservation across multiple UI profile edits
    do
        local h = harness.new({ sd_root = test_dir .. "/case4" })
        h.create_fixture_profile("WiredA.peq")
        h.create_fixture_profile("WiredB.peq")
        local M = h.load("plugins/OutputAwareSound/OutputAwareSound.lua")

        -- Initial baseline is -5.0 dB
        h.eq_state.preamp_db = -5.0
        h.output_info.route = "wired"
        M.config.routes["wired"] = "WiredA.peq"
        M.config.enabled = true
        M.grant_control(false)

        assert_eq(M.get_status().baseline_state.preamp_db, -5.0, "initial baseline recorded")

        -- User edits Wired profile in UI to WiredB
        M.config.routes["wired"] = "WiredB.peq"
        M.grant_control(false)
        assert_eq(M.get_status().baseline_state.preamp_db, -5.0, "baseline NOT overwritten by WiredB")

        -- User disables plugin -> must restore original -5.0 dB baseline!
        M.release_control()
        assert_eq(h.eq_state.preamp_db, -5.0, "disable restored original runtime EQ")
    end

    -- 5. Tight numeric precision (1e-6): 0.01 dB change triggers suspension
    do
        local h = harness.new({ sd_root = test_dir .. "/case5" })
        h.create_fixture_profile("RouteEQ.peq")
        local M = h.load("plugins/OutputAwareSound/OutputAwareSound.lua")

        M.config.routes["wired"] = "RouteEQ.peq"
        M.config.routes["usb_dac"] = "RouteEQ.peq"
        h.output_info.route = "wired"
        M.config.enabled = true
        M.grant_control(false)

        -- 0.01 dB manual change
        local snap = h.plugin.get_eq_state()
        snap.preamp_db = snap.preamp_db + 0.01
        h.eq_state = snap

        -- Route changes to USB DAC
        h.emit("output_changed", { route = "usb_dac", active = true }, { route = "wired" })
        assert_true(M.get_status().suspended, "0.01 dB difference detected with 1e-6 precision")
    end

    -- 6. Profile validation: path traversal rejection
    do
        local h = harness.new({ sd_root = test_dir .. "/case6" })
        local M = h.load("plugins/OutputAwareSound/OutputAwareSound.lua")

        assert_true(M.is_valid_profile_name("Safe.peq"), "safe peq valid")
        assert_false(M.is_valid_profile_name("../etc/shadow.peq"), "traversal rejected")
        assert_false(M.is_valid_profile_name("a/b.peq"), "slash rejected")
        assert_false(M.is_valid_profile_name("a\\b.peq"), "backslash rejected")
    end

    -- 7. Full UI configuration roundtrip
    do
        local h = harness.new({ sd_root = test_dir .. "/case7" })
        h.create_fixture_profile("UIWired.peq")
        local M = h.load("plugins/OutputAwareSound/OutputAwareSound.lua")

        assert_true(#h.list_items > 0, "registered list item exists")
        h.list_items[1].cb()

        assert_true(#h.settings_screens > 0, "settings screen opened")
        local main_screen = h.settings_screens[#h.settings_screens]

        -- Toggle Enabled
        main_screen.rows[1].on_change(true)
        assert_true(M.config.enabled, "enabled via toggle")

        -- Select Wired Headphones profile row
        local wired_row = nil
        for _, r in ipairs(main_screen.rows) do
            if r.label:find("Wired Headphones", 1, true) then wired_row = r break end
        end
        assert_true(wired_row ~= nil, "found Wired Headphones row")
        wired_row.on_select()

        -- Profile picker opened
        assert_true(#h.lists_shown > 0, "profile picker opened")
        local picker = h.lists_shown[#h.lists_shown]
        local pick_idx = nil
        for idx, item in ipairs(picker.items) do
            if item == "UIWired.peq" then pick_idx = idx break end
        end
        assert_true(pick_idx ~= nil, "found UIWired.peq in picker")
        picker.cb(pick_idx)

        assert_eq(M.config.routes["wired"], "UIWired.peq", "wired route configured via UI")

        -- Verify persistence roundtrip
        M.config.routes["wired"] = ""
        M.load_config()
        assert_eq(M.config.routes["wired"], "UIWired.peq", "wired route reloaded from persistence")
    end

    -- 8. Authoritative storage regression:
    --    Old durable config in namespaced storage, failed replacement save,
    --    live session works with new values, reload recovers old durable values,
    --    no SD file fallback writes on failure, exactly one namespaced write on success.
    do
        local h = harness.new({ sd_root = test_dir .. "/case8" })
        h.create_fixture_profile("DurableWired.peq")
        h.create_fixture_profile("NewDAC.peq")
        local M = h.load("plugins/OutputAwareSound/OutputAwareSound.lua")

        -- 1. Initial successful save: one namespaced write, zero SD file writes
        h.storage_set_calls = 0
        M.config.routes["wired"] = "DurableWired.peq"
        M.config.enabled = true
        local ok1 = M.save_config()
        assert_true(ok1, "initial durable config saved to storage")
        assert_eq(h.storage_set_calls, 1, "exactly one namespaced write on save")

        local sd_file = io.open(test_dir .. "/case8/.plugins/output_aware_sound_config.json", "r")
        assert_true(sd_file == nil, "no SD file written on successful save")

        -- 2. User modifies config live, but storage replacement fails
        M.config.routes["usb_dac"] = "NewDAC.peq"

        h.storage_fail_writes = true
        h.storage_set_calls = 0
        local ok2 = M.save_config()
        assert_false(ok2, "save_config reported failure when storage write failed")
        assert_eq(h.storage_set_calls, 1, "attempted one namespaced write")

        -- Failure notification
        assert_true(#h.toasts > 0, "toast displayed on save failure")
        assert_true(h.toasts[#h.toasts]:find("live for this session", 1, true) ~= nil, "toast notified changes are live for this session only")

        -- Old durable record remains in storage intact
        local durable_raw = h.storage_store["config"]
        assert_true(durable_raw ~= nil and durable_raw:find("DurableWired.peq", 1, true) ~= nil, "storage kept old durable wired profile")
        assert_true(durable_raw:find("NewDAC.peq", 1, true) == nil, "storage does not contain failed new DAC profile")

        -- No SD file fallback was written
        sd_file = io.open(test_dir .. "/case8/.plugins/output_aware_sound_config.json", "r")
        assert_true(sd_file == nil, "no fallback SD file written on failure")

        -- 3. Live interaction continues working with in-memory changes during this session
        assert_eq(M.config.routes["usb_dac"], "NewDAC.peq", "in-memory config preserves live change")
        M.grant_control(false)
        h.emit("output_changed", { route = "usb_dac", active = true }, { route = "wired" })
        assert_eq(M.get_status().last_applied_profile, "NewDAC.peq", "live session evaluation uses in-memory route profile")

        -- 4. Reload config: restores the old durable record from storage
        M.config.routes = {}
        M.load_config()
        assert_eq(M.config.routes["wired"], "DurableWired.peq", "reloaded old durable wired profile from storage")
        assert_eq(M.config.routes["usb_dac"], "", "failed new DAC profile was not remembered, reloaded durable empty string")
    end
end
