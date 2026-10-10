-- Tests for AutoEQContext:
-- Boundaries, genre lookup, retry on load failure, cache on success,
-- deterministic priority, transient EQ application, EQ ownership policy,
-- runtime baseline restoration on unmatched/tagless tracks, baseline preservation
-- across UI profile changes, 1e-6 numeric precision, traversal rejection, UI roundtrip.

local harness = require("context_harness")

return function(assert_eq, assert_true, assert_false)
    local test_dir = os.getenv("PWD") .. "/build_test/context_plugin_tests/autoeq"
    os.execute("rm -rf '" .. test_dir .. "' && mkdir -p '" .. test_dir .. "'")

    -- 1. Folder boundary matching & longest prefix
    do
        local h = harness.new({ sd_root = test_dir .. "/case1" })
        local M = h.load("plugins/AutoEQContext/AutoEQContext.lua")

        assert_true(M.folder_matches_track("/music/rock", "/music/rock/queen/song.flac"), "subfolder matches")
        assert_true(M.folder_matches_track("/music/rock/", "/music/rock/song.flac"), "trailing slash in rule matches")
        assert_true(M.folder_matches_track("/music/rock", "/music/rock"), "exact folder matches")
        assert_false(M.folder_matches_track("/music/rock", "/music/rock_and_roll/song.flac"), "no boundary match into sibling folder")
        assert_false(M.folder_matches_track("/music/rock", "/music/other/song.flac"), "different folder no match")

        h.create_fixture_profile("General.peq")
        h.create_fixture_profile("Rock.peq")
        h.create_fixture_profile("Queen.peq")

        M.config.rules.folder = {
            { folder = "/music", profile = "General.peq" },
            { folder = "/music/rock", profile = "Rock.peq" },
            { folder = "/music/rock/queen", profile = "Queen.peq" },
        }
        M.config.enabled = true
        M.grant_control(false)

        local p1, match_type1 = M.resolve_profile_for_track("/music/rock/queen/bohemian.flac")
        assert_eq(p1, "Queen.peq", "longest prefix matched deepest folder")
        assert_eq(match_type1, "folder", "match type folder")

        local p2, match_type2 = M.resolve_profile_for_track("/music/rock/acdc/highway.flac")
        assert_eq(p2, "Rock.peq", "medium prefix matched")

        local p3, match_type3 = M.resolve_profile_for_track("/music/pop/abba/waterloo.flac")
        assert_eq(p3, "General.peq", "shallowest prefix matched")

        local p4, match_type4 = M.resolve_profile_for_track("/music/rock_metal/metallica/one.flac")
        assert_eq(p4, "General.peq", "boundary prevents matching /music/rock, falls back to /music")
    end

    -- 2. Metadata: Genre lookup & no stale overrides when unresolved
    do
        local h = harness.new({ sd_root = test_dir .. "/case2" })
        h.create_fixture_profile("Jazz.peq")
        h.create_fixture_profile("Classical.peq")
        local M = h.load("plugins/AutoEQContext/AutoEQContext.lua")

        M.config.rules.genre = {
            ["jazz"] = "Jazz.peq",
            ["classical"] = "Classical.peq",
        }
        M.config.enabled = true
        M.grant_control(false)

        h.metadata_db["/track1.flac"] = { genre = "Jazz", artist = "Miles Davis" }
        local prof1 = M.resolve_profile_for_track("/track1.flac")
        assert_eq(prof1, "Jazz.peq", "genre rule resolved")

        h.metadata_db["/track2.flac"] = { genre = "", artist = "Unknown" }
        local prof2 = M.resolve_profile_for_track("/track2.flac")
        assert_eq(prof2, nil, "empty genre means unresolved, no rule matched")

        local prof3 = M.resolve_profile_for_track("/unindexed.flac")
        assert_eq(prof3, nil, "nil metadata row returns nil, no stale override")
    end

    -- 3. Restore owned runtime baseline when leaving matched context (unmatched/tagless/remote)
    do
        local h = harness.new({ sd_root = test_dir .. "/case3" })
        h.create_fixture_profile("Rock.peq")
        local M = h.load("plugins/AutoEQContext/AutoEQContext.lua")

        -- Establish initial baseline
        h.eq_state.preamp_db = -2.5
        M.config.rules.genre["rock"] = "Rock.peq"
        M.config.enabled = true
        M.grant_control(false)

        -- Track 1: matches Rock.peq
        h.current_track_path = "/t1.flac"
        h.metadata_db["/t1.flac"] = { genre = "rock" }
        M.evaluate_current_track()
        assert_eq(#h.eq_apply_calls, 1, "applied Rock.peq")
        assert_true(M.get_status().last_applied_profile == "Rock.peq", "recorded active profile")

        -- Track 2: Tagless / unmatched track!
        h.current_track_path = "/t2.flac"
        h.metadata_db["/t2.flac"] = { genre = "" } -- unresolved
        M.evaluate_current_track()

        -- Plugin MUST restore runtime baseline and clear successful cache!
        assert_eq(#h.eq_state_calls, 1, "restored baseline EQ when leaving matched context")
        assert_eq(h.eq_state_calls[1].opts.persist, false, "restoration is transient")
        assert_eq(h.eq_state.preamp_db, -2.5, "EQ returned to initial baseline")
        assert_eq(M.get_status().last_applied_profile, nil, "cleared last applied profile")

        -- Case B: Manual override no-clobber when leaving matched context
        -- Play Track 1 again (applies Rock.peq)
        h.current_track_path = "/t1.flac"
        M.evaluate_current_track()
        assert_eq(#h.eq_apply_calls, 2, "re-applied Rock.peq")

        -- User manually edits EQ during Track 1!
        h.eq_state.preamp_db = 7.0 -- manual edit
        local calls_before = #h.eq_state_calls

        -- Track 3 plays (unmatched)
        h.current_track_path = "/t3.flac"
        h.metadata_db["/t3.flac"] = nil
        M.evaluate_current_track()

        -- Plugin MUST suspend and NOT clobber the user's manual change!
        assert_true(M.get_status().suspended, "suspended on manual edit during context exit")
        assert_eq(#h.eq_state_calls, calls_before, "did not overwrite manual edit")
        assert_eq(h.eq_state.preamp_db, 7.0, "user manual EQ preserved intact")
    end

    -- 4. Baseline preservation across multiple UI profile/rule edits
    do
        local h = harness.new({ sd_root = test_dir .. "/case4" })
        h.create_fixture_profile("ProfA.peq")
        h.create_fixture_profile("ProfB.peq")
        h.create_fixture_profile("ProfC.peq")
        local M = h.load("plugins/AutoEQContext/AutoEQContext.lua")

        -- Initial baseline is -4.0 dB
        h.eq_state.preamp_db = -4.0
        M.config.rules.genre["pop"] = "ProfA.peq"
        M.config.enabled = true
        M.grant_control(false)

        h.current_track_path = "/pop.flac"
        h.metadata_db["/pop.flac"] = { genre = "pop" }
        M.evaluate_current_track()
        assert_eq(M.get_status().baseline_state.preamp_db, -4.0, "initial baseline recorded")

        -- User edits rule in UI to ProfB, then ProfC
        M.config.rules.genre["pop"] = "ProfB.peq"
        M.grant_control(false)
        assert_eq(M.get_status().baseline_state.preamp_db, -4.0, "baseline NOT overwritten by ProfB")

        M.config.rules.genre["pop"] = "ProfC.peq"
        M.grant_control(false)
        assert_eq(M.get_status().baseline_state.preamp_db, -4.0, "baseline NOT overwritten by ProfC")

        -- User disables plugin -> must restore original -4.0 dB baseline!
        M.release_control()
        assert_eq(h.eq_state.preamp_db, -4.0, "disable restored original runtime EQ")
    end

    -- 5. Tight numeric precision (1e-6): 0.01 dB change triggers suspension
    do
        local h = harness.new({ sd_root = test_dir .. "/case5" })
        h.create_fixture_profile("Test.peq")
        local M = h.load("plugins/AutoEQContext/AutoEQContext.lua")

        M.config.rules.genre["rock"] = "Test.peq"
        M.config.enabled = true
        M.grant_control(false)

        h.current_track_path = "/r1.flac"
        h.metadata_db["/r1.flac"] = { genre = "rock" }
        M.evaluate_current_track()

        -- Subtle 0.01 dB change made manually
        local snap = h.plugin.get_eq_state()
        snap.preamp_db = snap.preamp_db + 0.01
        h.eq_state = snap

        -- Next track
        h.current_track_path = "/r2.flac"
        h.metadata_db["/r2.flac"] = { genre = "rock" }
        M.evaluate_current_track()

        assert_true(M.get_status().suspended, "0.01 dB difference detected with 1e-6 precision")
    end

    -- 6. Profile validation: path traversal rejection
    do
        local h = harness.new({ sd_root = test_dir .. "/case6" })
        local M = h.load("plugins/AutoEQContext/AutoEQContext.lua")

        assert_true(M.is_valid_profile_name("Valid.peq"), "normal peq valid")
        assert_false(M.is_valid_profile_name("../etc/passwd.peq"), "path traversal rejected")
        assert_false(M.is_valid_profile_name("sub/folder.peq"), "slash rejected")
        assert_false(M.is_valid_profile_name("sub\\folder.peq"), "backslash rejected")
        assert_false(M.is_valid_profile_name("NotPeq.txt"), "non-peq extension rejected")
        assert_false(M.is_valid_profile_name(""), "empty name rejected")
    end

    -- 7. Full UI configuration roundtrip
    do
        local h = harness.new({ sd_root = test_dir .. "/case7" })
        h.create_fixture_profile("UIRock.peq")
        local M = h.load("plugins/AutoEQContext/AutoEQContext.lua")

        -- Open via registered list item
        assert_true(#h.list_items > 0, "registered list item exists")
        h.list_items[1].cb()

        assert_true(#h.settings_screens > 0, "settings screen opened")
        local main_screen = h.settings_screens[#h.settings_screens]

        -- Toggle Enabled
        main_screen.rows[1].on_change(true)
        assert_true(M.config.enabled, "enabled via toggle")

        -- Open Genre Rules
        local genre_row = nil
        for _, r in ipairs(main_screen.rows) do
            if r.label:find("Genre Rules", 1, true) then genre_row = r break end
        end
        assert_true(genre_row ~= nil, "found Genre Rules row")
        genre_row.on_select()

        local genre_screen = h.settings_screens[#h.settings_screens]
        -- Tap "+ Add Genre Rule..."
        genre_screen.rows[1].on_select()
        assert_true(h.last_text_input ~= nil, "prompted for Genre Name")
        h.last_text_input.cb("Alternative")

        -- Profile picker opened
        assert_true(#h.lists_shown > 0, "profile picker opened")
        local picker = h.lists_shown[#h.lists_shown]
        -- Pick UIRock.peq
        local pick_idx = nil
        for idx, item in ipairs(picker.items) do
            if item == "UIRock.peq" then pick_idx = idx break end
        end
        assert_true(pick_idx ~= nil, "found UIRock.peq in picker")
        picker.cb(pick_idx)

        assert_eq(M.config.rules.genre["alternative"], "UIRock.peq", "genre rule configured via UI")

        -- Verify persistence roundtrip
        M.config.rules.genre = {}
        M.load_config()
        assert_eq(M.config.rules.genre["alternative"], "UIRock.peq", "genre rule reloaded from persistence")
    end

    -- 8. Authoritative storage regression:
    --    Old durable config in namespaced storage, failed replacement save,
    --    live session works with new values, reload recovers old durable values,
    --    no SD file fallback writes on failure, exactly one namespaced write on success.
    do
        local h = harness.new({ sd_root = test_dir .. "/case8" })
        h.create_fixture_profile("DurableDefault.peq")
        h.create_fixture_profile("NewRock.peq")
        local M = h.load("plugins/AutoEQContext/AutoEQContext.lua")

        -- 1. Initial successful save: one namespaced write, zero SD file writes
        h.storage_set_calls = 0
        M.config.default_profile = "DurableDefault.peq"
        M.config.enabled = true
        local ok1 = M.save_config()
        assert_true(ok1, "initial durable config saved to storage")
        assert_eq(h.storage_set_calls, 1, "exactly one namespaced write on save")

        local sd_file = io.open(test_dir .. "/case8/.plugins/autoeq_context_config.json", "r")
        assert_true(sd_file == nil, "no SD file written on successful save")

        -- 2. User modifies config live, but storage replacement fails
        M.config.default_profile = "FailedDefault.peq"
        M.config.rules.genre["rock"] = "NewRock.peq"

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
        assert_true(durable_raw ~= nil and durable_raw:find("DurableDefault.peq", 1, true) ~= nil, "storage kept old durable default profile")
        assert_true(durable_raw:find("FailedDefault.peq", 1, true) == nil, "storage does not contain failed default profile")

        -- No SD file fallback was written
        sd_file = io.open(test_dir .. "/case8/.plugins/autoeq_context_config.json", "r")
        assert_true(sd_file == nil, "no fallback SD file written on failure")

        -- 3. Live interaction continues working with in-memory changes during this session
        assert_eq(M.config.default_profile, "FailedDefault.peq", "in-memory config preserves live change")
        h.current_track_path = "/rock/song.flac"
        h.metadata_db["/rock/song.flac"] = { genre = "rock" }
        M.grant_control(false)
        M.evaluate_current_track()
        assert_eq(M.get_status().last_applied_profile, "NewRock.peq", "live session evaluation uses in-memory rule")

        -- 4. Reload config: restores the old durable record from storage
        M.config.rules.genre = {}
        M.config.default_profile = ""
        M.load_config()
        assert_eq(M.config.default_profile, "DurableDefault.peq", "reloaded old durable default profile from storage")
        assert_true(M.config.rules.genre["rock"] == nil, "failed new rock rule was not remembered on reload")
    end
end
