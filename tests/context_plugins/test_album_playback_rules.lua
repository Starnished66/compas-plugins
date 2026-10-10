-- Tests for AlbumPlaybackRules:
-- Artist+album identity, album name collisions, boolean false persistence in load/save,
-- bidirectional gapless/crossfade coupling, post-apply pair ownership,
-- manual override preservation, UI roundtrip.

local harness = require("context_harness")

return function(assert_eq, assert_true, assert_false)
    local test_dir = os.getenv("PWD") .. "/build_test/context_plugin_tests/album_rules"
    os.execute("rm -rf '" .. test_dir .. "' && mkdir -p '" .. test_dir .. "'")

    -- 1. Boolean false persistence: load_config preserves false (not lost to nil)
    do
        local h = harness.new({ sd_root = test_dir .. "/case1" })
        local M = h.load("plugins/AlbumPlaybackRules/AlbumPlaybackRules.lua")

        local key = M.make_album_key("ArtistBoolean", "AlbumOff")
        M.config.rules[key] = {
            artist = "ArtistBoolean",
            album = "AlbumOff",
            gapless = false,   -- explicit boolean false
            crossfade = false, -- explicit boolean false
            replaygain = "off",
            play_mode = "sequential",
        }
        M.config.enabled = true
        local saved = M.save_config()
        assert_true(saved, "saved config successfully")

        -- Clear config in memory and reload
        M.config.rules = {}
        M.load_config()

        local loaded_rule = M.config.rules[key]
        assert_true(loaded_rule ~= nil, "rule reloaded from storage/file")
        assert_eq(loaded_rule.gapless, false, "boolean false for gapless preserved across load/save")
        assert_eq(loaded_rule.crossfade, false, "boolean false for crossfade preserved across load/save")
        assert_eq(loaded_rule.replaygain, "off", "replaygain off preserved")
    end

    -- 2. Bidirectional coupling: set_gapless(false) clears crossfade, set_crossfade(true) enables gapless
    do
        local h = harness.new({ sd_root = test_dir .. "/case2" })
        local M = h.load("plugins/AlbumPlaybackRules/AlbumPlaybackRules.lua")

        -- Start with gapless = true, crossfade = true
        h.gapless = true
        h.crossfade = true

        -- Rule only explicitly requests gapless = false
        local key = M.make_album_key("BandCoupling", "NoGap")
        M.config.rules[key] = {
            artist = "BandCoupling",
            album = "NoGap",
            gapless = false,
        }
        M.config.enabled = true

        h.current_track_path = "/coupling/01.flac"
        h.metadata_db["/coupling/01.flac"] = { artist = "BandCoupling", album = "NoGap" }
        M.evaluate_playback()

        local s = M.get_active_session()
        assert_true(s ~= nil, "session active")
        assert_eq(h.gapless, false, "gapless set to false")
        assert_eq(h.crossfade, false, "crossfade implicitly cleared by gapless false")
        assert_true(s.applied.coupled_pair, "coupled pair recorded")
        assert_eq(s.applied.gapless, false, "post-apply gapless recorded")
        assert_eq(s.applied.crossfade, false, "post-apply crossfade recorded")

        -- On leaving album, restores baseline (gapless=true, crossfade=true)
        h.current_track_path = "/other/01.flac"
        h.metadata_db["/other/01.flac"] = { artist = "OtherBand", album = "OtherAlbum" }
        M.evaluate_playback()

        assert_eq(h.gapless, true, "gapless restored to baseline true")
        assert_eq(h.crossfade, true, "crossfade restored to baseline true")
    end

    -- 3. Coupled pair manual override: do NOT clobber if user changed either field
    do
        local h = harness.new({ sd_root = test_dir .. "/case3" })
        local M = h.load("plugins/AlbumPlaybackRules/AlbumPlaybackRules.lua")

        h.gapless = true
        h.crossfade = false

        -- Rule enables crossfade (which natively also enables gapless)
        local key = M.make_album_key("BandOverride", "CrossAlbum")
        M.config.rules[key] = {
            artist = "BandOverride",
            album = "CrossAlbum",
            crossfade = true,
        }
        M.config.enabled = true

        h.current_track_path = "/cross/01.flac"
        h.metadata_db["/cross/01.flac"] = { artist = "BandOverride", album = "CrossAlbum" }
        M.evaluate_playback()

        assert_eq(h.crossfade, true, "crossfade applied true")
        assert_eq(h.gapless, true, "gapless is true")

        -- USER MANUAL OVERRIDE: user turns crossfade back OFF during the album!
        h.crossfade = false

        -- Leave album
        h.current_track_path = "/next/01.flac"
        h.metadata_db["/next/01.flac"] = { artist = "NextBand", album = "NextAlbum" }
        M.evaluate_playback()

        -- Plugin must recognize that one field in the coupled pair was manually changed,
        -- so it MUST NOT restore either field against user manual change!
        assert_eq(h.crossfade, false, "manual crossfade override preserved")
    end

    -- 4. Contradictory rule normalization (gapless=false + crossfade=true)
    do
        local h = harness.new({ sd_root = test_dir .. "/case4" })
        local M = h.load("plugins/AlbumPlaybackRules/AlbumPlaybackRules.lua")

        local key = M.make_album_key("BadRuleBand", "Contradiction")
        M.config.rules[key] = {
            artist = "BadRuleBand",
            album = "Contradiction",
            gapless = false,
            crossfade = true, -- Contradictory!
        }
        M.config.enabled = true

        h.current_track_path = "/contra/01.flac"
        h.metadata_db["/contra/01.flac"] = { artist = "BadRuleBand", album = "Contradiction" }
        M.evaluate_playback()

        -- Contradiction normalized: gapless=false forces crossfade=false natively
        assert_eq(h.gapless, false, "gapless is false")
        assert_eq(h.crossfade, false, "contradictory crossfade normalized to false")
    end

    -- 5. Full UI configuration roundtrip
    do
        local h = harness.new({ sd_root = test_dir .. "/case5" })
        local M = h.load("plugins/AlbumPlaybackRules/AlbumPlaybackRules.lua")

        -- Locate registered list item
        assert_true(#h.list_items > 0, "registered list item exists")
        local entry = h.list_items[1]
        assert_eq(entry.label, "Album Playback Rules", "correct list item label")

        -- Open main settings
        entry.cb()
        assert_true(#h.settings_screens > 0, "opened settings screen")
        local screen = h.settings_screens[#h.settings_screens]

        -- Toggle Enabled to true via UI
        local toggle_item = screen.rows[1]
        assert_eq(toggle_item.label, "Enabled", "found Enabled toggle")
        toggle_item.on_change(true)
        assert_true(M.config.enabled, "enabled via UI toggle")

        -- Add rule manually via UI text inputs
        local add_manually_row = nil
        for _, r in ipairs(screen.rows) do
            if r.label:find("Add Rule Manually", 1, true) then
                add_manually_row = r
                break
            end
        end
        assert_true(add_manually_row ~= nil, "found Add Rule Manually row")
        add_manually_row.on_select()

        -- Simulate text input submissions
        assert_true(h.last_text_input ~= nil, "prompted for Artist Name")
        h.last_text_input.cb("UIRoundtripArtist")
        assert_true(h.last_text_input ~= nil, "prompted for Album Name")
        h.last_text_input.cb("UIRoundtripAlbum")

        -- Verify rule created
        local rule_key = M.make_album_key("UIRoundtripArtist", "UIRoundtripAlbum")
        assert_true(M.config.rules[rule_key] ~= nil, "rule created via UI flow")

        -- Verify it persisted to disk/storage
        M.config.rules = {}
        M.load_config()
        assert_true(M.config.rules[rule_key] ~= nil, "rule reloaded from persistence after UI creation")
    end

    -- 6. In-flight rule edit while playing matched album:
    --    Settings apply immediately while playing the album,
    --    and the original baseline is preserved across multiple edits.
    do
        local h = harness.new({ sd_root = test_dir .. "/case6" })
        local M = h.load("plugins/AlbumPlaybackRules/AlbumPlaybackRules.lua")

        -- Establish initial baseline state
        h.gapless = true
        h.crossfade = false
        h.replaygain = "off"
        h.play_mode = "sequential"

        local artist = "InFlightBand"
        local album = "LiveParis"
        local key = M.make_album_key(artist, album)

        M.config.rules[key] = {
            artist = artist,
            album = album,
            gapless = true,
            crossfade = nil, -- initially Default
            replaygain = "track",
            play_mode = "sequential",
        }
        M.config.enabled = true

        -- Start playing track from this album
        h.current_track_path = "/inflight/01.flac"
        h.metadata_db["/inflight/01.flac"] = { artist = artist, album = album }
        M.evaluate_playback()

        local session = M.get_active_session()
        assert_true(session ~= nil, "active session started for matched album")
        assert_eq(h.replaygain, "track", "replaygain rule applied on session start")
        assert_eq(session.baseline.crossfade, false, "initial baseline crossfade recorded as false")
        assert_eq(session.baseline.play_mode, "sequential", "initial baseline play_mode recorded as sequential")
        assert_eq(session.baseline.replaygain, "off", "initial baseline replaygain recorded as off")

        -- USER IN-FLIGHT EDIT 1: User opens rule edit menu and toggles Crossfade to true
        M.open_edit_rule(key)
        local screen = h.settings_screens[#h.settings_screens]
        local cf_row = nil
        for _, r in ipairs(screen.rows) do
            if r.label:find("Crossfade:", 1, true) then cf_row = r break end
        end
        assert_true(cf_row ~= nil, "found Crossfade row in edit menu")
        cf_row.on_select() -- nil -> true

        -- Verify edit took effect IMMEDIATELY while playing the album!
        assert_eq(h.crossfade, true, "crossfade applied immediately during active album session")
        assert_eq(h.gapless, true, "gapless enabled due to crossfade=true coupling")
        -- Original baseline MUST NOT be overwritten by the in-flight edit:
        assert_eq(session.baseline.crossfade, false, "original baseline crossfade preserved as false")

        -- USER IN-FLIGHT EDIT 2: User changes play_mode to 'shuffle'
        M.open_edit_rule(key)
        screen = h.settings_screens[#h.settings_screens]
        local pm_row = nil
        for _, r in ipairs(screen.rows) do
            if r.label:find("Play Order:", 1, true) then pm_row = r break end
        end
        assert_true(pm_row ~= nil, "found Play Order row in edit menu")
        -- Cycle play_mode: sequential -> repeat_all -> repeat_one -> shuffle
        pm_row.on_select() -- sequential -> repeat_all
        pm_row.on_select() -- repeat_all -> repeat_one
        pm_row.on_select() -- repeat_one -> shuffle
        assert_eq(h.play_mode, "shuffle", "play_mode shuffle applied immediately during active album session")
        assert_eq(session.baseline.play_mode, "sequential", "original baseline play_mode preserved as sequential")

        -- USER IN-FLIGHT EDIT 3: User transitions play_mode to Default (nil)
        pm_row.on_select() -- shuffle -> nil (Default)
        assert_eq(M.config.rules[key].play_mode, nil, "rule play_mode set to Default (nil)")
        -- Must immediately restore the original owned baseline value!
        assert_eq(h.play_mode, "sequential", "play_mode immediately restored to original baseline sequential")
        assert_eq(session.applied.play_mode, nil, "session play_mode ownership cleared")

        -- USER IN-FLIGHT EDIT 4: User transitions Crossfade to Default (nil)
        M.open_edit_rule(key)
        screen = h.settings_screens[#h.settings_screens]
        for _, r in ipairs(screen.rows) do
            if r.label:find("Crossfade:", 1, true) then cf_row = r break end
        end
        cf_row.on_select() -- true -> false
        cf_row.on_select() -- false -> nil (Default)
        assert_eq(M.config.rules[key].crossfade, nil, "rule crossfade set to Default")
        -- And gapless also to Default:
        local gl_row = nil
        for _, r in ipairs(screen.rows) do
            if r.label:find("Gapless:", 1, true) then gl_row = r break end
        end
        assert_true(gl_row ~= nil, "found Gapless row")
        gl_row.on_select() -- true -> false
        gl_row.on_select() -- false -> nil (Default)
        assert_eq(M.config.rules[key].gapless, nil, "rule gapless set to Default")

        -- Both gapless and crossfade transitioned to Default:
        -- Must immediately restore original owned baseline values (gl=true, cf=false)!
        assert_eq(h.gapless, true, "gapless restored to original baseline true")
        assert_eq(h.crossfade, false, "crossfade restored to original baseline false")
        assert_eq(session.applied.coupled_pair, nil, "session coupled_pair cleared")

        -- Finally, leave album:
        h.current_track_path = "/other/01.flac"
        h.metadata_db["/other/01.flac"] = { artist = "OtherArtist", album = "OtherAlbum" }
        M.evaluate_playback()

        -- Verify all settings restored to initial baseline:
        assert_eq(h.gapless, true, "baseline gapless held on album exit")
        assert_eq(h.crossfade, false, "baseline crossfade held on album exit")
        assert_eq(h.replaygain, "off", "baseline replaygain restored on album exit")
        assert_eq(h.play_mode, "sequential", "baseline play_mode held on album exit")
        assert_true(M.get_active_session() == nil, "active session cleared on album exit")
    end

    -- 7. Manual override preservation during active session and rule edits
    do
        local h = harness.new({ sd_root = test_dir .. "/case7" })
        local M = h.load("plugins/AlbumPlaybackRules/AlbumPlaybackRules.lua")

        h.gapless = true
        h.crossfade = false
        h.replaygain = "off"
        h.play_mode = "sequential"

        local artist = "ManualArtist"
        local album = "ManualAlbum"
        local key = M.make_album_key(artist, album)

        M.config.rules[key] = {
            artist = artist,
            album = album,
            gapless = true,
            crossfade = nil,
            replaygain = "off",
            play_mode = "repeat_all",
        }
        M.config.enabled = true

        h.current_track_path = "/manual/01.flac"
        h.metadata_db["/manual/01.flac"] = { artist = artist, album = album }
        M.evaluate_playback()

        assert_eq(h.play_mode, "repeat_all", "rule play_mode applied")

        -- USER MANUAL OVERRIDE: user changes play_mode in player UI to "shuffle"
        h.play_mode = "shuffle"

        -- User now edits crossfade in Album Playback Rules (play_mode rule is untouched)
        M.open_edit_rule(key)
        local screen = h.settings_screens[#h.settings_screens]
        local cf_row = nil
        for _, r in ipairs(screen.rows) do
            if r.label:find("Crossfade:", 1, true) then cf_row = r break end
        end
        cf_row.on_select() -- nil -> true (crossfade becomes true)

        -- Verify manual play_mode was NOT clobbered!
        assert_eq(h.play_mode, "shuffle", "user manual play_mode override preserved during crossfade edit")
        assert_eq(h.crossfade, true, "crossfade edit applied")

        -- Now user changes play_mode rule directly to Default (nil)
        M.config.rules[key].play_mode = nil
        M.evaluate_playback()
        assert_eq(M.config.rules[key].play_mode, nil, "play_mode rule set to Default")

        -- Because current player play_mode ("shuffle") did not match what plugin applied ("repeat_all"),
        -- plugin recognizes manual override and does NOT clobber with baseline ("sequential")!
        assert_eq(h.play_mode, "shuffle", "user manual play_mode override preserved when transitioning rule to Default")
    end

    -- 8. Delete rule while playing matched album restores baseline immediately
    do
        local h = harness.new({ sd_root = test_dir .. "/case8" })
        local M = h.load("plugins/AlbumPlaybackRules/AlbumPlaybackRules.lua")

        h.gapless = false
        h.crossfade = false
        h.replaygain = "off"
        h.play_mode = "sequential"

        local artist = "DeleteArtist"
        local album = "DeleteAlbum"
        local key = M.make_album_key(artist, album)

        M.config.rules[key] = {
            artist = artist,
            album = album,
            gapless = true,
            crossfade = true,
            replaygain = "album",
            play_mode = "repeat_all",
        }
        M.config.enabled = true

        h.current_track_path = "/del/01.flac"
        h.metadata_db["/del/01.flac"] = { artist = artist, album = album }
        M.evaluate_playback()

        assert_eq(h.gapless, true, "gapless applied")
        assert_eq(h.crossfade, true, "crossfade applied")
        assert_eq(h.replaygain, "album", "replaygain applied")
        assert_eq(h.play_mode, "repeat_all", "play_mode applied")

        -- Open edit menu and click Delete Rule
        M.open_edit_rule(key)
        local screen = h.settings_screens[#h.settings_screens]
        local del_row = nil
        for _, r in ipairs(screen.rows) do
            if r.label == "Delete Rule" then del_row = r break end
        end
        assert_true(del_row ~= nil, "found Delete Rule row")
        del_row.on_select()

        -- Verify rule deleted and original baseline immediately restored while still playing!
        assert_true(M.config.rules[key] == nil, "rule deleted from config")
        assert_true(M.get_active_session() == nil, "active session cleared")
        assert_eq(h.gapless, false, "gapless restored to baseline false")
        assert_eq(h.crossfade, false, "crossfade restored to baseline false")
        assert_eq(h.replaygain, "off", "replaygain restored to baseline off")
        assert_eq(h.play_mode, "sequential", "play_mode restored to baseline sequential")
    end

    -- 9. Avoid unchanged native flash writes
    do
        local h = harness.new({ sd_root = test_dir .. "/case9" })
        local M = h.load("plugins/AlbumPlaybackRules/AlbumPlaybackRules.lua")

        h.gapless = true
        h.crossfade = false
        h.replaygain = "off"
        h.play_mode = "sequential"

        local artist = "FlashBand"
        local album = "FlashAlbum"
        local key = M.make_album_key(artist, album)

        -- Rule specifies gapless=true, crossfade=false (exact same as player state)
        M.config.rules[key] = {
            artist = artist,
            album = album,
            gapless = true,
            crossfade = false,
            replaygain = "off",
            play_mode = "sequential",
        }
        M.config.enabled = true

        local prev_gl_calls = h.setter_calls.gapless
        local prev_cf_calls = h.setter_calls.crossfade
        local prev_rg_calls = h.setter_calls.replaygain
        local prev_pm_calls = h.setter_calls.play_mode

        h.current_track_path = "/flash/01.flac"
        h.metadata_db["/flash/01.flac"] = { artist = artist, album = album }
        M.evaluate_playback()

        -- Zero native setter calls because values were already matching!
        assert_eq(h.setter_calls.gapless, prev_gl_calls, "no flash write to set_gapless")
        assert_eq(h.setter_calls.crossfade, prev_cf_calls, "no flash write to set_crossfade")
        assert_eq(h.setter_calls.replaygain, prev_rg_calls, "no flash write to set_replaygain")
        assert_eq(h.setter_calls.play_mode, prev_pm_calls, "no flash write to set_play_mode")
    end

    -- 10. Authoritative storage regression:
    --     Old durable config in namespaced storage, failed replacement save,
    --     live session works with new values, reload recovers old durable values,
    --     no SD file fallback writes on failure, exactly one namespaced write on success.
    do
        local h = harness.new({ sd_root = test_dir .. "/case10" })
        local M = h.load("plugins/AlbumPlaybackRules/AlbumPlaybackRules.lua")

        h.gapless = true
        h.crossfade = false
        h.replaygain = "off"
        h.play_mode = "sequential"

        local artist = "ArtistDurable"
        local album = "AlbumDurable"
        local key = M.make_album_key(artist, album)

        -- 1. Initial successful save: one namespaced write, zero SD file writes
        h.storage_set_calls = 0
        M.config.rules[key] = {
            artist = artist,
            album = album,
            gapless = true,
            crossfade = false,
            replaygain = "off",
            play_mode = "sequential",
        }
        M.config.enabled = true
        local ok1 = M.save_config()
        assert_true(ok1, "initial durable config saved to storage")
        assert_eq(h.storage_set_calls, 1, "exactly one namespaced write on save")

        local sd_file = io.open(test_dir .. "/case10/.plugins/album_playback_rules_config.json", "r")
        assert_true(sd_file == nil, "no SD file written on successful save")

        -- 2. User modifies rule live, but storage replacement fails
        M.config.rules[key].crossfade = true

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
        assert_true(durable_raw ~= nil and durable_raw:find('"crossfade":false', 1, true) ~= nil, "storage kept old durable crossfade=false")
        assert_true(durable_raw:find('"crossfade":true', 1, true) == nil, "storage does not contain failed new crossfade=true")

        -- No SD file fallback was written
        sd_file = io.open(test_dir .. "/case10/.plugins/album_playback_rules_config.json", "r")
        assert_true(sd_file == nil, "no fallback SD file written on failure")

        -- 3. Live interaction continues working with in-memory changes during this session
        assert_eq(M.config.rules[key].crossfade, true, "in-memory config preserves live change")
        h.current_track_path = "/durable/01.flac"
        h.metadata_db["/durable/01.flac"] = { artist = artist, album = album }
        M.evaluate_playback()
        assert_eq(h.crossfade, true, "live session evaluation uses in-memory crossfade setting")

        -- 4. Reload config: restores the old durable record from storage
        M.config.rules = {}
        M.load_config()
        assert_true(M.config.rules[key] ~= nil, "reloaded rule for durable album")
        assert_eq(M.config.rules[key].crossfade, false, "reloaded old durable crossfade=false from storage")
    end
end
