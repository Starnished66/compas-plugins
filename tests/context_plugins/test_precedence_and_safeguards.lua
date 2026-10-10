-- Tests for cross-plugin precedence safeguards, conflict resolution,
-- unknown event rejection, unsupported capability degradation, and storage error resilience.

local harness = require("context_harness")

return function(assert_eq, assert_true, assert_false)
    local test_dir = os.getenv("PWD") .. "/build_test/context_plugin_tests/safeguards"
    os.execute("rm -rf '" .. test_dir .. "' && mkdir -p '" .. test_dir .. "'")

    -- 1. Mock rejects unknown native event names (no invented events like shutdown/unload)
    do
        local h = harness.new({ sd_root = test_dir .. "/case1" })
        local ok_fake1 = pcall(h.plugin.on, "shutdown", function() end)
        assert_false(ok_fake1, "rejected invented shutdown event")

        local ok_fake2 = pcall(h.plugin.on, "unload", function() end)
        assert_false(ok_fake2, "rejected invented unload event")

        local ok_real = pcall(h.plugin.on, "track_started", function() end)
        assert_true(ok_real, "accepted valid native track_started event")
    end

    -- 2. Precedence Safeguards: AutoEQContext and OutputAwareSound Coexistence
    do
        local h = harness.new({ sd_root = test_dir .. "/case2" })
        h.create_fixture_profile("EQ_Rock.peq")
        h.create_fixture_profile("EQ_Bluetooth.peq")

        local M_AutoEQ = h.load("plugins/AutoEQContext/AutoEQContext.lua")
        local M_Output = h.load("plugins/OutputAwareSound/OutputAwareSound.lua")

        M_AutoEQ.config.rules.genre["rock"] = "EQ_Rock.peq"
        M_Output.config.routes["bluetooth:sbc"] = "EQ_Bluetooth.peq"

        -- User enables AutoEQ Context first
        M_AutoEQ.config.enabled = true
        M_AutoEQ.grant_control(false)

        h.current_track_path = "/rock/song.flac"
        h.metadata_db["/rock/song.flac"] = { genre = "rock" }
        M_AutoEQ.evaluate_current_track()

        assert_eq(#h.eq_apply_calls, 1, "AutoEQ applied EQ_Rock.peq")
        assert_false(M_AutoEQ.get_status().suspended, "AutoEQ owns EQ")

        -- User explicitly enables Output-Aware Sound
        M_Output.config.enabled = true
        h.output_info.route = "bluetooth"
        h.output_info.bluetooth_codec = "sbc"
        M_Output.grant_control(true)

        assert_eq(#h.eq_apply_calls, 2, "Output-Aware applied EQ_Bluetooth.peq")
        assert_false(M_Output.get_status().suspended, "Output-Aware owns EQ")

        -- Next track plays while AutoEQ is still enabled
        h.current_track_path = "/rock/song2.flac"
        h.metadata_db["/rock/song2.flac"] = { genre = "rock" }
        M_AutoEQ.evaluate_current_track()

        -- AutoEQ checks last applied state, sees OutputAware changed EQ, suspends without fighting
        assert_true(M_AutoEQ.get_status().suspended, "AutoEQ detected external change and suspended")
        assert_eq(#h.eq_apply_calls, 2, "no fighting: AutoEQ did NOT overwrite OutputAware EQ!")

        -- User explicitly re-applies AutoEQ
        M_AutoEQ.grant_control(true)
        assert_eq(#h.eq_apply_calls, 3, "AutoEQ re-applied on explicit user command")

        -- Route changes in OutputAware:
        -- OutputAware detects AutoEQ modified EQ, suspends itself
        h.output_info.bluetooth_codec = "sbc"
        M_Output.handle_output_snapshot({ route = "bluetooth", active = true, bluetooth_codec = "ldac" })
        assert_true(M_Output.get_status().suspended, "OutputAware suspended, avoiding fighting AutoEQ")
        assert_eq(#h.eq_apply_calls, 3, "no fighting: OutputAware did NOT overwrite AutoEQ")
    end

    -- 3. Unsupported Capabilities Graceful Degradation
    do
        local h = harness.new({
            sd_root = test_dir .. "/case3",
            capabilities = {
                ["library.track_metadata"] = false,
                ["audio.peq.transient"] = false,
                ["audio.peq.state"] = false,
                ["playback.settings"] = false,
            }
        })
        local M_AutoEQ = h.load("plugins/AutoEQContext/AutoEQContext.lua")
        local M_Album = h.load("plugins/AlbumPlaybackRules/AlbumPlaybackRules.lua")

        h.current_track_path = "/song.flac"
        h.now_playing = { title = "Song", artist = "ArtistFallback", album = "Album", duration = 180 }
        M_AutoEQ.config.rules.artist["artistfallback"] = "Fallback.peq"
        M_AutoEQ.config.enabled = true
        M_AutoEQ.grant_control(false)

        local prof = M_AutoEQ.resolve_profile_for_track("/song.flac")
        assert_eq(prof, "Fallback.peq", "resolved artist via get_now_playing fallback")

        local key = M_Album.make_album_key("ArtistFallback", "Album")
        M_Album.config.rules[key] = { artist = "ArtistFallback", album = "Album", crossfade = true }
        M_Album.config.enabled = true
        local ok, err = pcall(function() M_Album.evaluate_playback() end)
        assert_true(ok, "AlbumPlaybackRules handles missing playback.settings gracefully")
    end

    -- 4. Storage Error & Corrupt JSON Resilience (malformed rules do not crash)
    do
        local h = harness.new({ sd_root = test_dir .. "/case4" })
        local conf_path = test_dir .. "/case4/.plugins/autoeq_context_config.json"
        local f = io.open(conf_path, "w")
        if f then
            -- Corrupted JSON table with malformed types and NaN/traversal attempts
            f:write('{"enabled":"not_a_boolean","rules":{"folder":[{"folder":123,"profile":"../../bad.peq"},{"invalid_entry":true}],"artist":"not_a_table"}}')
            f:close()
        end

        local M_AutoEQ = h.load("plugins/AutoEQContext/AutoEQContext.lua")
        assert_eq(M_AutoEQ.config.enabled, false, "gracefully defaulted enabled to false on malformed type")
        assert_eq(#M_AutoEQ.config.rules.folder, 0, "malformed folder entries cleanly dropped without crashing")
        assert_eq(type(M_AutoEQ.config.rules.artist), "table", "artist rules remained table")
    end

    -- 5. Legacy migration precedence:
    --    Authoritative namespaced storage record always takes precedence over legacy SD file.
    --    Legacy SD file is only read as a migration fallback when namespaced storage has no record.
    do
        local h = harness.new({ sd_root = test_dir .. "/case5" })
        local legacy_dir = test_dir .. "/case5/.plugins"
        os.execute("mkdir -p '" .. legacy_dir .. "'")
        local legacy_file = io.open(legacy_dir .. "/autoeq_context_config.json", "w")
        if legacy_file then
            legacy_file:write('{"enabled":true,"default_profile":"LegacyProfile.peq","rules":{"folder":[],"artist":{},"genre":{}}}')
            legacy_file:close()
        end

        -- Case 5A: Namespaced storage has an authoritative record
        h.storage_store["config"] = '{"enabled":true,"default_profile":"AuthoritativeStorage.peq","rules":{"folder":[],"artist":{},"genre":{}}}'
        local M_AutoEQ = h.load("plugins/AutoEQContext/AutoEQContext.lua")
        assert_eq(M_AutoEQ.config.default_profile, "AuthoritativeStorage.peq", "authoritative namespaced record preferred over legacy file")

        -- Case 5B: Namespaced storage has NO record -> migrates from legacy file
        h.storage_store["config"] = nil
        M_AutoEQ.config.default_profile = ""
        M_AutoEQ.load_config()
        assert_eq(M_AutoEQ.config.default_profile, "LegacyProfile.peq", "migrated from legacy file when namespaced storage has no record")
    end
end
