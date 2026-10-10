-- Tests for ABX Blind Test plugin (API 16).
local harness = require("tests.ab_plugins.harness")

local PLUGIN_PATH = "plugins/ABXBlindTest/ABXBlindTest.lua"

local function find_row(items, label_part)
    for i, item in ipairs(items) do
        local lbl = type(item) == "table" and item.label or item
        if type(lbl) == "string" and lbl:find(label_part, 1, true) then
            if type(item) == "table" and item.on_select then
                return item
            else
                return { label = lbl, index = i }
            end
        end
    end
    return nil
end

return function(assert_eq, assert_true, assert_false)
    -- Test 1: Plugin definition and metadata
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        assert_eq(h.state.defined.id, "example.abx_blind_test", "ABX stable id")
        assert_eq(h.state.defined.name, "ABX Blind Test", "ABX name")
        assert_eq(h.state.defined.version, "1.1.0", "ABX version 1.1.0")
        assert_eq(h.state.defined.api_min, 16, "ABX api_min 16")
        assert_eq(#h.state.registered_list_items, 1, "Registered 1 entry point")
        assert_eq(h.state.registered_list_items[1].list_id, "playback", "Registered in playback menu")
        assert_eq(h.active_timer_count(), 0, "No initial active timers allocated")
    end

    -- Test 2: Capability gating
    do
        -- 2a: Missing playback.ab_switch gates file mode
        local h = harness.new({
            capabilities = {
                ["playback.format"] = true,
                ["audio.peq.state"] = true,
                -- playback.ab_switch missing!
            }
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        local last_toast = h.state.toasts[#h.state.toasts] or ""
        assert_true(last_toast:find("playback.ab_switch", 1, true) ~= nil, "File mode gated when capability missing")

        -- 2b: Missing audio.peq.state gates EQ mode
        local h2 = harness.new({
            capabilities = {
                ["playback.ab_switch"] = true,
                ["playback.format"] = true,
                -- audio.peq.state missing!
            }
        })
        h2.load_plugin(PLUGIN_PATH)
        h2.state.registered_list_items[1].on_open()
        find_row(h2.state.active_settings_list.items, "Equalizer Profile ABX Test").on_select()
        find_row(h2.state.active_settings_list.items, "Start ABX EQ Test").on_select()
        local last_toast2 = h2.state.toasts[#h2.state.toasts] or ""
        assert_true(last_toast2:find("audio.peq.state", 1, true) ~= nil, "EQ mode gated when capability missing")
    end

    -- Test 3: File mode format compatibility (FLAC, PCM, MP3 with depth 0, FLAC vs MP3 comparison)
    do
        local h = harness.new({
            current_path = "/data/mnt/sd_0/Music/track.flac",
            format = {
                codec = "flac",
                bit_depth = 16,
                sample_rate = 44100,
                channels = 2,
                playback_speed = 1.0,
                crossfade_enabled = false,
            }
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()

        -- Set Track B to a matched MP3
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/track_matched.mp3")

        -- 3a: Direct comparison of FLAC vs MP3 is accepted!
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        assert_true(h.state.ab_switch_preparing, "Engine accepted FLAC vs MP3 comparison preparation")
        assert_eq(h.active_timer_count(), 1, "Polling timer started for async preparation")

        -- Cancel preparation to reset to un-prepared state
        find_row(h.state.active_settings_list.items, "Cancel Preparation").on_select()
        assert_eq(h.active_timer_count(), 0, "Polling timer stopped")

        -- 3b: Reject 24-bit primary
        h.state.format.bit_depth = 24
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("unsupported", 1, true) ~= nil, "Rejected 24-bit primary")
        h.state.format.bit_depth = 16

        -- 3c: Reject stream primary
        h.state.format.is_stream = true
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("Stream playback cannot", 1, true) ~= nil, "Rejected stream primary")
        h.state.format.is_stream = false

        -- 3d: Reject crossfade enabled
        h.state.format.crossfade_enabled = true
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("Crossfade must be disabled", 1, true) ~= nil, "Rejected crossfade enabled")
        h.state.format.crossfade_enabled = false
    end

    -- Test 4: Async preparation polling, ready state, and rejection on mismatch
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/track_alt.wav")

        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        assert_eq(h.active_timer_count(), 1, "Preparation polling timer active")

        -- Tick 1: Still preparing
        h.tick_timers()
        assert_eq(h.active_timer_count(), 1, "Still polling")

        -- Engine finishes preparation successfully
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = true

        -- Tick 2: Observes ready
        h.tick_timers()
        assert_eq(h.active_timer_count(), 0, "Polling timer stopped upon ready")
        assert_true(h.state.toasts[#h.state.toasts]:find("ready for ABX test", 1, true) ~= nil, "User notified track ready")

        -- 4b: Rejection on mismatch
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        assert_eq(h.active_timer_count(), 1, "Polling restarted")
        -- Engine rejects job (mismatch in rate/channels/frames)
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = false
        h.tick_timers()
        assert_eq(h.active_timer_count(), 0, "Polling stopped on mismatch rejection")
        assert_true(h.state.toasts[#h.state.toasts]:find("mismatch", 1, true) ~= nil, "Notified format mismatch")

        -- 4c: Manual pause during preparation (async stale work handling)
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        assert_eq(h.active_timer_count(), 1, "Polling active")
        -- User pauses playback
        h.state.paused = true
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = false
        h.trigger_event("paused")
        assert_eq(h.active_timer_count(), 0, "Polling timer stopped on pause event")
    end

    -- Test 5: Blind Auditioning, Hidden X, and No Re-roll on List Open
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/track_b.flac")
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()

        -- Engine becomes ready
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = true
        h.tick_timers()

        -- Start test
        find_row(h.state.active_settings_list.items, "Start ABX File Test").on_select()
        local trial_menu = h.state.active_settings_list
        assert_true(trial_menu ~= nil, "Trial menu displayed")
        assert_true(find_row(trial_menu.items, "Trial 1 of 10") ~= nil, "Trial 1 active")

        -- Verify menu labels do NOT reveal identity
        local row_x = find_row(trial_menu.items, "Sample X (Hidden)")
        assert_true(row_x ~= nil, "Sample X label is hidden")
        assert_false(row_x.label:find("is A") ~= nil, "Does not reveal A")
        assert_false(row_x.label:find("is B") ~= nil, "Does not reveal B")

        -- Audition A -> calls select_ab_source("a")
        find_row(trial_menu.items, "Sample A").on_select()
        assert_eq(h.state.ab_switch_source_b, false, "Switched to source A")

        -- Audition B -> calls select_ab_source("b")
        find_row(trial_menu.items, "Sample B").on_select()
        assert_eq(h.state.ab_switch_source_b, true, "Switched to source B")

        -- Audition X
        find_row(trial_menu.items, "Sample X").on_select()
        -- Must match hidden trial_x without leaking
        local hidden_val = h.state.ab_switch_source_b

        -- CRITICAL: Reopen menu should NOT re-roll X!
        for _ = 1, 5 do
            h.state.registered_list_items[1].on_open()
        end
        find_row(h.state.active_settings_list.items, "Sample X").on_select()
        assert_eq(h.state.ab_switch_source_b, hidden_val, "X is stable across list opens; no re-roll on list open")
    end

    -- Test 6: Guessing, scoring, anti-repeat voting, and binomial probability
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/b.flac")
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = true
        h.tick_timers()
        find_row(h.state.active_settings_list.items, "Start ABX File Test").on_select()

        -- Vote trial 1
        find_row(h.state.active_settings_list.items, "Vote: X is A").on_select()
        -- Should advance to trial 2
        assert_true(find_row(h.state.active_settings_list.items, "Trial 2 of 10") ~= nil, "Advanced to Trial 2")

        -- Vote remaining 9 trials
        for i = 2, 10 do
            find_row(h.state.active_settings_list.items, "Vote: X is B").on_select()
        end

        -- Session finished
        local final_screen = h.state.active_settings_list
        local score_row = find_row(final_screen.items, "Final Score:")
        assert_true(score_row ~= nil, "Final score row displayed")
        local p_row = find_row(final_screen.items, "p-value:")
        assert_true(p_row ~= nil, "Binomial probability p-value displayed")

        -- Restart resets session
        find_row(final_screen.items, "Restart Test").on_select()
        assert_true(find_row(h.state.active_settings_list.items, "Trial 1 of 10") ~= nil, "Restarted to Trial 1")

        -- End session clears native context and timers
        find_row(h.state.active_settings_list.items, "Exit ABX Session").on_select()
        assert_eq(h.state.ab_switch_ready, false, "Native context cleared")
        assert_eq(h.active_timer_count(), 0, "No active timers after ending session")
    end

    -- Test 7: Binomial probability mathematical correctness
    do
        -- Pure function test using the formula
        local function p_val(k, n)
            local function n_choose_i(total, choose)
                if choose == 0 or choose == total then return 1 end
                if choose > total - choose then choose = total - choose end
                local c = 1
                for j = 1, choose do c = c * (total - j + 1) / j end
                return c
            end
            local sum = 0
            for i = k, n do sum = sum + n_choose_i(total or n, i) end
            return sum * (0.5 ^ n)
        end

        -- 10 out of 10: 1 / 1024 ~ 0.0009765
        local p10_10 = p_val(10, 10)
        assert_true(math.abs(p10_10 - 0.0009765625) < 0.000001, "p(10/10) ~ 0.000976")

        -- 8 out of 10: 56 / 1024 ~ 0.0546875
        local p8_10 = p_val(8, 10)
        assert_true(math.abs(p8_10 - 0.0546875) < 0.000001, "p(8/10) ~ 0.05468")

        -- 5 out of 10: 638 / 1024 ~ 0.62304
        local p5_10 = p_val(5, 10)
        assert_true(math.abs(p5_10 - 0.623046875) < 0.000001, "p(5/10) ~ 0.6230")
    end

    -- Test 8: EQ Profile Mode (transient loading, baseline restoration, external change detection)
    do
        local base_eq = harness.create_default_eq_state()
        local profile_b = harness.create_default_eq_state()
        profile_b.bands[1].gain_db = 6.0
        profile_b.preamp_db = -3.0

        local h = harness.new({
            initial_eq = base_eq,
            files = {
                ["/data/mnt/sd_0/bass.peq"] = profile_b,
            }
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Equalizer Profile ABX Test").on_select()

        -- Load Profile B
        find_row(h.state.active_settings_list.items, "Load .peq for Profile B").on_select()
        assert_true(h.state.active_list ~= nil, "File picker opened")
        -- Pick bass.peq
        h.state.active_list.on_select(1)
        assert_true(h.state.toasts[#h.state.toasts]:find("Loaded bass.peq", 1, true) ~= nil, "Loaded Profile B transiently")

        -- Start EQ test
        find_row(h.state.active_settings_list.items, "Start ABX EQ Test").on_select()
        local trial_menu = h.state.active_settings_list
        assert_true(find_row(trial_menu.items, "Trial 1 of 10") ~= nil, "EQ Trial 1 started")

        -- Audition A -> Baseline EQ applied
        find_row(trial_menu.items, "Sample A").on_select()
        assert_eq(h.state.live_eq.preamp_db, 0.0, "Sample A is baseline preamp")
        assert_eq(h.state.live_eq.bands[1].gain_db, 0.0, "Sample A is baseline band 1 gain")

        -- Audition B -> Profile B applied transiently
        find_row(trial_menu.items, "Sample B").on_select()
        assert_eq(h.state.live_eq.preamp_db, -3.0, "Sample B is profile B preamp")
        assert_eq(h.state.live_eq.bands[1].gain_db, 6.0, "Sample B is profile B band 1 gain")

        -- 8b: External EQ change during trial
        -- Simulate external manual modification of band 5
        h.state.live_eq.bands[5].gain_db = 8.5

        -- Next audition detects discrepancy and aborts trial to preserve user's manual change!
        find_row(trial_menu.items, "Sample A").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("External EQ change detected", 1, true) ~= nil, "Detected external EQ modification")
        assert_eq(h.state.live_eq.bands[5].gain_db, 8.5, "User's manual change was preserved and NOT overwritten")

        -- 8c: Normal session ending restores baseline if no external modification occurred
        local h2 = harness.new({
            initial_eq = base_eq,
            files = { ["/data/mnt/sd_0/bass.peq"] = profile_b }
        })
        h2.load_plugin(PLUGIN_PATH)
        h2.state.registered_list_items[1].on_open()
        find_row(h2.state.active_settings_list.items, "Equalizer Profile ABX Test").on_select()
        find_row(h2.state.active_settings_list.items, "Load .peq for Profile B").on_select()
        h2.state.active_list.on_select(1)
        find_row(h2.state.active_settings_list.items, "Start ABX EQ Test").on_select()
        -- Switch to B
        find_row(h2.state.active_settings_list.items, "Sample B").on_select()
        assert_eq(h2.state.live_eq.preamp_db, -3.0, "Profile B active")

        -- End session -> restores baseline EQ!
        find_row(h2.state.active_settings_list.items, "Exit ABX Session").on_select()
        assert_eq(h2.state.live_eq.preamp_db, 0.0, "Baseline EQ restored cleanly")
        assert_eq(h2.state.live_eq.bands[1].gain_db, 0.0, "Baseline band 1 restored")
    end

    -- Test 9: Path traversal, URL, and absolute paths outside SD card rejected before native prepare
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()

        -- 9a: URL rejection
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("http://example.com/audio.flac")
        assert_true(h.state.toasts[#h.state.toasts]:find("Network URLs", 1, true) ~= nil, "Rejected URL before prepare")
        assert_eq(h.state.ab_switch_target_path, nil, "Native prepare was not called")

        -- 9b: Path traversal rejection
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/../etc/shadow")
        assert_true(h.state.toasts[#h.state.toasts]:find("Path traversal", 1, true) ~= nil, "Rejected '..' traversal")
        assert_eq(h.state.ab_switch_target_path, nil, "Native prepare was not called")

        -- 9c: Absolute path outside SD card rejection
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/usr/bin/some_file.flac")
        assert_true(h.state.toasts[#h.state.toasts]:find("inside the SD card", 1, true) ~= nil, "Rejected path outside SD card")
        assert_eq(h.state.ab_switch_target_path, nil, "Native prepare was not called")
    end

    -- Test 10: Cancel before starting trial clears native preparation candidate
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/track_b.flac")

        -- Start prep
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        assert_true(h.state.ab_switch_preparing, "Native prepare started")
        assert_eq(h.active_timer_count(), 1, "Prep timer active")

        -- User cancels preparation before starting test
        find_row(h.state.active_settings_list.items, "Cancel Preparation").on_select()
        assert_eq(h.state.ab_switch_cleared_count, 1, "Called clear_ab_switch on cancel before active")
        assert_eq(h.active_timer_count(), 0, "Prep timer stopped on cancel")
    end

    -- Test 11: Interruption callbacks end active file session
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/track_b.flac")
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = true
        h.tick_timers()

        find_row(h.state.active_settings_list.items, "Start ABX File Test").on_select()
        assert_true(find_row(h.state.active_settings_list.items, "Trial 1 of 10") ~= nil, "Session active")

        -- Interruption: user pauses playback
        h.state.paused = true
        h.trigger_event("paused")

        -- Reopen menu: session must be ended!
        h.state.registered_list_items[1].on_open()
        assert_true(find_row(h.state.active_settings_list.items, "Audio File ABX Test") ~= nil, "Session ended and returned to main menu on pause")
    end

    -- Test 12: Readiness loss while active detected at controls (audition and vote)
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/track_b.flac")
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = true
        h.tick_timers()
        find_row(h.state.active_settings_list.items, "Start ABX File Test").on_select()

        -- Engine loses readiness silently (e.g. hardware seek)
        h.state.ab_switch_ready = false

        -- Audition attempt must detect readiness loss and end session
        find_row(h.state.active_settings_list.items, "Sample A").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("Readiness lost", 1, true) ~= nil, "Detected readiness loss on audition")

        -- Verify session ended
        h.state.registered_list_items[1].on_open()
        assert_true(find_row(h.state.active_settings_list.items, "Audio File ABX Test") ~= nil, "Returned to main menu")
    end

    -- Test 13: Stale vote callbacks from prior trial are rejected
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/track_b.flac")
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = true
        h.tick_timers()
        find_row(h.state.active_settings_list.items, "Start ABX File Test").on_select()

        local trial1_menu = h.state.active_settings_list
        local stale_vote_fn = find_row(trial1_menu.items, "Vote: X is A").on_select

        -- Legitimate vote advances to trial 2
        find_row(trial1_menu.items, "Vote: X is B").on_select()
        assert_true(find_row(h.state.active_settings_list.items, "Trial 2 of 10") ~= nil, "On Trial 2")

        -- Now execute stale trial 1 vote callback: must be rejected!
        stale_vote_fn()
        -- Still on trial 2!
        assert_true(find_row(h.state.active_settings_list.items, "Trial 2 of 10") ~= nil, "Stale vote was ignored; still on Trial 2")
    end

    -- Test 14: EQ manual override before guess terminates session without scoring
    do
        local base_eq = harness.create_default_eq_state()
        local profile_b = harness.create_default_eq_state()
        profile_b.bands[1].gain_db = 4.0

        local h = harness.new({
            initial_eq = base_eq,
            files = { ["/data/mnt/sd_0/bass.peq"] = profile_b }
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Equalizer Profile ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Load .peq for Profile B").on_select()
        h.state.active_list.on_select(1)
        find_row(h.state.active_settings_list.items, "Start ABX EQ Test").on_select()

        -- User listens to sample X
        find_row(h.state.active_settings_list.items, "Sample X").on_select()

        -- User manually alters EQ band 3 directly in hardware before voting
        h.state.live_eq.bands[3].gain_db = 7.0

        -- User tries to submit a vote
        find_row(h.state.active_settings_list.items, "Vote: X is A").on_select()

        -- Must detect external change BEFORE counting vote, terminate session, and preserve user change!
        assert_true(h.state.toasts[#h.state.toasts]:find("External EQ change detected before vote", 1, true) ~= nil, "Detected external change before vote")
        assert_eq(h.state.live_eq.bands[3].gain_db, 7.0, "User's manual adjustment was preserved")

        -- Session ended
        h.state.registered_list_items[1].on_open()
        assert_true(find_row(h.state.active_settings_list.items, "Equalizer Profile ABX Test") ~= nil, "Returned to main menu")
    end

    -- Test 15: Long MP3 preparation does not abort prematurely at 30 seconds
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/long.mp3")
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()

        -- Run 45 timer ticks while still preparing
        for _ = 1, 45 do
            h.tick_timers()
        end
        assert_eq(h.active_timer_count(), 1, "Polling still alive past 30 seconds for long MP3 indexing")

        -- Completes at tick 50
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = true
        h.tick_timers()
        assert_eq(h.active_timer_count(), 0, "Polling stopped upon ready")
        assert_true(h.state.toasts[#h.state.toasts]:find("ready for ABX test", 1, true) ~= nil, "Long MP3 successfully prepared")
    end

    -- Test 16: File browser 20 walks with replace handle, stale callbacks, malicious entries, and strict SD root
    do
        local files = {
            ["/data/mnt/sd_0/dir1"] = true,
            ["/data/mnt/sd_0/dir1/dir2"] = true,
            ["/data/mnt/sd_0/dir1/dir2/dir3"] = true,
            ["/data/mnt/sd_0/dir1/dir2/dir3/dir4"] = true,
            ["/data/mnt/sd_0/dir1/dir2/dir3/dir4/dir5"] = true,
            ["/data/mnt/sd_0/dir1/dir2/dir3/dir4/dir5/dir6"] = true,
            ["/data/mnt/sd_0/dir1/dir2/dir3/dir4/dir5/dir6/dir7"] = true,
            ["/data/mnt/sd_0/dir1/dir2/dir3/dir4/dir5/dir6/dir7/dir8"] = true,
            ["/data/mnt/sd_0/dir1/dir2/dir3/dir4/dir5/dir6/dir7/dir8/dir9"] = true,
            ["/data/mnt/sd_0/dir1/dir2/dir3/dir4/dir5/dir6/dir7/dir8/dir9/dir10"] = true,
            ["/data/mnt/sd_0/dir1/dir2/dir3/dir4/dir5/dir6/dir7/dir8/dir9/dir10/sample.flac"] = false,
        }
        local h = harness.new({ files = files })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Select Track B").on_select()

        -- Initial browser list opened
        assert_eq(#h.state.list_screens, 1, "Browser list opened, depth is 1")
        local handle1 = h.state.active_list.handle

        -- Walk down 10 levels
        for d = 1, 10 do
            local next_dir = "dir" .. d
            local row = find_row(h.state.active_list.items, "[DIR] " .. next_dir)
            assert_true(row ~= nil, "Found folder " .. next_dir)
            h.state.active_list.on_select(row.index)
            assert_eq(#h.state.list_screens, 1, "List depth remains 1 after walk down " .. d)
        end

        -- Walk up 10 levels
        for d = 10, 1, -1 do
            local row = find_row(h.state.active_list.items, "[..] Up to parent")
            assert_true(row ~= nil, "Found parent traversal at depth " .. d)
            h.state.active_list.on_select(row.index)
            assert_eq(#h.state.list_screens, 1, "List depth remains 1 after walk up " .. d)
        end

        -- 20 walks verified with replace handle, total list depth never exceeded 1!
        assert_true(h.state.active_list.handle > handle1, "Handle updated on replace")

        -- Stale callback test: attempting replace with an expired handle returns nil
        local stale_res = h.plugin.show_list("Stale Test", {"row"}, function() end, { replace = handle1 })
        assert_eq(stale_res, nil, "Expired handle rejected by show_list replace")

        -- Malicious entry names: slashes, .., .
        h.state.files["/data/mnt/sd_0/bad/entry"] = true
        h.state.files["/data/mnt/sd_0/..evil"] = false
        h.state.files["/data/mnt/sd_0/sub..dir"] = true
        h.pop_list()
        find_row(h.state.active_settings_list.items, "Select Track B").on_select()
        for _, it in ipairs(h.state.active_list.items) do
            local lbl = type(it) == "table" and it.label or it
            assert_false(lbl:find("evil", 1, true) ~= nil, "Skipped ..evil")
            assert_false(lbl:find("sub..dir", 1, true) ~= nil, "Skipped sub..dir")
            assert_false(lbl:find("bad/entry", 1, true) ~= nil, "Skipped slashes")
        end
    end

    -- Test 17: Settings pool is 2, single title 'ABX Blind Test', Back navigation, and no async reopening
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        assert_eq(#h.state.settings_stack, 1, "Stack depth is 1 on main view")
        assert_eq(h.state.active_settings_list.title, "ABX Blind Test", "Title is ABX Blind Test")

        -- Virtual view transitions
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        assert_eq(#h.state.settings_stack, 1, "Stack depth remains 1 in file view")
        assert_eq(h.state.active_settings_list.title, "ABX Blind Test", "Title remains ABX Blind Test")

        find_row(h.state.active_settings_list.items, "< Back to Main Menu").on_select()
        assert_eq(#h.state.settings_stack, 1, "Stack depth remains 1 after virtual Back")

        find_row(h.state.active_settings_list.items, "Equalizer Profile ABX Test").on_select()
        assert_eq(#h.state.settings_stack, 1, "Stack depth remains 1 in eq view")
        assert_eq(h.state.active_settings_list.title, "ABX Blind Test", "Title remains ABX Blind Test")

        -- Start prep in file mode, then user presses native Back (leaves plugin)
        find_row(h.state.active_settings_list.items, "< Back to Main Menu").on_select()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/track_b.flac")
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        assert_eq(h.active_timer_count(), 1, "Prep timer active")

        -- User presses native Back: screen popped from settings_stack
        h.pop_settings()
        assert_eq(#h.state.settings_stack, 0, "User left plugin, settings stack empty")

        -- Polling timer ticks and completes preparation in background: MUST NOT reopen settings screen!
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = true
        h.tick_timers()
        assert_eq(#h.state.settings_stack, 0, "Async prep completion did NOT reopen settings list after user left")

        -- Background playback interruption must also NOT reopen settings list
        h.trigger_event("paused")
        h.trigger_event("stopped")
        h.trigger_event("track_started")
        assert_eq(#h.state.settings_stack, 0, "Playback events did NOT reopen settings list")
    end

    -- Test 18: eq_states_match precision 1e-6: 0.01 dB/Q/width/preamp manual edits detected
    do
        local h = harness.new()
        h.state.files["/data/mnt/sd_0/test_b.peq"] = {
            bypass = false,
            preamp_db = -2.0,
            stereo_width = 1.0,
            bands = {
                { index = 1, freq_hz = 100, gain_db = 3.0, q = 1.0, type = "peaking", enabled = true },
                { index = 2, freq_hz = 250, gain_db = 0.0, q = 1.0, type = "peaking", enabled = true },
                { index = 3, freq_hz = 500, gain_db = 0.0, q = 1.0, type = "peaking", enabled = true },
                { index = 4, freq_hz = 1000, gain_db = 0.0, q = 1.0, type = "peaking", enabled = true },
                { index = 5, freq_hz = 2000, gain_db = 0.0, q = 1.0, type = "peaking", enabled = true },
                { index = 6, freq_hz = 4000, gain_db = 0.0, q = 1.0, type = "peaking", enabled = true },
                { index = 7, freq_hz = 8000, gain_db = 0.0, q = 1.0, type = "peaking", enabled = true },
                { index = 8, freq_hz = 12000, gain_db = 0.0, q = 1.0, type = "peaking", enabled = true },
                { index = 9, freq_hz = 16000, gain_db = 0.0, q = 1.0, type = "peaking", enabled = true },
                { index = 10, freq_hz = 20000, gain_db = 0.0, q = 1.0, type = "peaking", enabled = true },
            }
        }
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Equalizer Profile ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Load .peq for Profile B").on_select()
        local peq_row = find_row(h.state.active_list.items, "test_b.peq")
        h.state.active_list.on_select(peq_row.index)
        find_row(h.state.active_settings_list.items, "Start ABX EQ Test").on_select()

        -- 18a: Manual 0.01 dB gain edit before audition
        local edited_gain = h.state.live_eq.bands[1].gain_db + 0.01
        h.state.live_eq.bands[1].gain_db = edited_gain
        find_row(h.state.active_settings_list.items, "Sample A").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("External EQ change", 1, true) ~= nil, "Detected 0.01 dB gain manual edit before audition")
        assert_eq(h.state.live_eq.bands[1].gain_db, edited_gain, "User manual 0.01 dB gain preserved")

        -- Restart for 18b
        find_row(h.state.active_settings_list.items, "Equalizer Profile ABX Test").on_select()
        h.state.live_eq.bands[1].gain_db = 0.0
        find_row(h.state.active_settings_list.items, "Start ABX EQ Test").on_select()

        -- 18b: Manual 0.01 Q edit before audition
        h.state.live_eq.bands[1].q = h.state.live_eq.bands[1].q + 0.01
        find_row(h.state.active_settings_list.items, "Sample B").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("External EQ change", 1, true) ~= nil, "Detected 0.01 Q manual edit before audition")

        -- Restart for 18c
        find_row(h.state.active_settings_list.items, "Equalizer Profile ABX Test").on_select()
        h.state.live_eq.bands[1].q = 1.0
        find_row(h.state.active_settings_list.items, "Start ABX EQ Test").on_select()

        -- 18c: Manual 0.01 stereo_width edit before vote
        h.state.live_eq.stereo_width = h.state.live_eq.stereo_width + 0.01
        find_row(h.state.active_settings_list.items, "Vote: X is A").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("External EQ change detected before vote", 1, true) ~= nil, "Detected 0.01 width manual edit before vote")

        -- Restart for 18d
        find_row(h.state.active_settings_list.items, "Equalizer Profile ABX Test").on_select()
        h.state.live_eq.stereo_width = 1.0
        find_row(h.state.active_settings_list.items, "Start ABX EQ Test").on_select()

        -- 18d: Manual 0.01 preamp edit before vote
        h.state.live_eq.preamp_db = h.state.live_eq.preamp_db + 0.01
        find_row(h.state.active_settings_list.items, "Vote: X is B").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("External EQ change detected before vote", 1, true) ~= nil, "Detected 0.01 preamp manual edit before vote")
    end

    -- Test 19: Session epoch & trial ID guards against stale audition and stale vote across restarts
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/track_b.flac")
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = true
        h.tick_timers()
        find_row(h.state.active_settings_list.items, "Start ABX File Test").on_select()

        -- Capture callbacks for Session 1, Trial 1
        local trial1_screen = h.state.active_settings_list
        local stale_vote_a = find_row(trial1_screen.items, "Vote: X is A").on_select
        local stale_aud_b = find_row(trial1_screen.items, "Sample B").on_select

        -- Legitimate vote advances to Trial 2
        find_row(trial1_screen.items, "Vote: X is B").on_select()
        assert_true(find_row(h.state.active_settings_list.items, "Trial 2 of 10") ~= nil, "On Trial 2")

        -- Stale vote from Trial 1 executed while on Trial 2: must be ignored!
        stale_vote_a()
        assert_true(find_row(h.state.active_settings_list.items, "Trial 2 of 10") ~= nil, "Stale vote from Trial 1 ignored on Trial 2")

        -- User restarts session (new epoch!)
        find_row(h.state.active_settings_list.items, "Restart Test").on_select()
        assert_true(find_row(h.state.active_settings_list.items, "Trial 1 of 10") ~= nil, "Restarted to Trial 1 in Session 2")

        -- Stale vote from Session 1, Trial 1 executed on Session 2, Trial 1: must be ignored due to epoch mismatch!
        stale_vote_a()
        assert_true(find_row(h.state.active_settings_list.items, "Trial 1 of 10") ~= nil, "Stale vote from prior session epoch ignored")

        -- Stale audition from Session 1 executed on Session 2: ignored
        h.state.ab_switch_source_b = false
        stale_aud_b()
        assert_eq(h.state.ab_switch_source_b, false, "Stale audition from prior session epoch ignored")
    end

    -- Test 20: Finished session Restart regression (requires valid readiness, rejects invalid mode)
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/track_b.flac")
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = true
        h.tick_timers()
        find_row(h.state.active_settings_list.items, "Start ABX File Test").on_select()

        -- Vote all 10 trials to finish
        for _ = 1, 10 do
            find_row(h.state.active_settings_list.items, "Vote: X is A").on_select()
        end
        assert_true(find_row(h.state.active_settings_list.items, "Final Score:") ~= nil, "Session finished")

        -- Loss of native readiness while on finished screen (e.g. user paused playback)
        h.state.paused = true
        find_row(h.state.active_settings_list.items, "Restart Test").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("Readiness lost", 1, true) ~= nil, "Restart refused when readiness lost")
        assert_true(find_row(h.state.active_settings_list.items, "Trial 1 of 10") == nil, "Did not start active session or score")
    end

    -- Test 21: Real format generation and exact 1.0x speed validation on file and EQ mode
    do
        local h = harness.new({
            format = {
                path = "/data/mnt/sd_0/Music/track.flac",
                codec = "flac",
                bit_depth = 16,
                sample_rate = 44100,
                playback_speed = 1.0,
                generation = 3,
                duration_seconds = 180.0,
            }
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        find_row(h.state.active_settings_list.items, "Audio File ABX Test").on_select()
        find_row(h.state.active_settings_list.items, "Enter Track B Path").on_select()
        h.state.active_text_input.on_submit("/data/mnt/sd_0/Music/track_b.flac")
        find_row(h.state.active_settings_list.items, "Prepare Comparison").on_select()
        h.state.ab_switch_preparing = false
        h.state.ab_switch_ready = true
        h.tick_timers()
        find_row(h.state.active_settings_list.items, "Start ABX File Test").on_select()

        -- Generation change during audition invalidates file trial
        h.state.format.generation = 4
        find_row(h.state.active_settings_list.items, "Sample A").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("track restarted or changed", 1, true) ~= nil, "Detected generation mismatch during file audition")

        -- EQ mode: paused/stopped terminates active EQ trial
        local h_eq = harness.new({
            files = {
                ["/data/mnt/sd_0/profile.peq"] = {
                    bypass = false,
                    preamp_db = -1.0,
                    stereo_width = 1.0,
                    bands = harness.create_default_eq_state().bands
                }
            }
        })
        h_eq.load_plugin(PLUGIN_PATH)
        h_eq.state.registered_list_items[1].on_open()
        find_row(h_eq.state.active_settings_list.items, "Equalizer Profile ABX Test").on_select()
        find_row(h_eq.state.active_settings_list.items, "Load .peq for Profile B").on_select()
        local prof_row = find_row(h_eq.state.active_list.items, "profile.peq")
        h_eq.state.active_list.on_select(prof_row.index)
        find_row(h_eq.state.active_settings_list.items, "Start ABX EQ Test").on_select()
        assert_true(find_row(h_eq.state.active_settings_list.items, "Trial 1 of 10") ~= nil, "EQ Trial 1 active")

        -- Pausing playback invalidates EQ trial
        h_eq.trigger_event("paused")
        assert_true(h_eq.state.toasts[#h_eq.state.toasts]:find("Playback interrupted", 1, true) ~= nil, "EQ trial stopped on paused event")
    end
end
