-- Tests for A-B Repeat practice looper (API 16).
local harness = require("tests.ab_plugins.harness")

local PLUGIN_PATH = "plugins/ABRepeat/ABRepeat.lua"

local function find_row(items, label_part)
    for _, item in ipairs(items) do
        if item.label and item.label:find(label_part, 1, true) then
            return item
        end
    end
    return nil
end

return function(assert_eq, assert_true, assert_false)
    -- Test 1: Plugin definition and metadata
    do
        local h = harness.new()
        h.load_plugin(PLUGIN_PATH)
        assert_eq(h.state.defined.id, "example.ab_repeat", "ABRepeat stable id")
        assert_eq(h.state.defined.name, "A-B Repeat", "ABRepeat name")
        assert_eq(h.state.defined.version, "1.1.0", "ABRepeat version 1.1.0")
        assert_eq(h.state.defined.api_min, 16, "ABRepeat api_min 16")
        assert_eq(#h.state.registered_list_items, 1, "Registered 1 entry point")
        assert_eq(h.state.registered_list_items[1].list_id, "playback", "Registered in playback menu")
        assert_eq(h.state.registered_list_items[1].label, "A-B Repeat", "Registered label matches")
        assert_eq(h.active_timer_count(), 0, "No initial active timers allocated")
    end

    -- Test 2: Capability gating (missing playback.ab_loop)
    do
        local h = harness.new({
            capabilities = {
                ["playback.format"] = true,
                -- playback.ab_loop is missing!
            }
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list
        assert_true(screen ~= nil, "Menu opened")

        -- Attempt to mark and activate
        find_row(screen.items, "Mark Point A").on_select()
        h.state.position = 45.0
        find_row(screen.items, "Mark Point B").on_select()

        find_row(screen.items, "Engage Loop").on_select()
        assert_true(#h.state.toasts > 0, "Toast generated on refusal")
        local last_toast = h.state.toasts[#h.state.toasts]
        assert_true(last_toast:find("playback.ab_loop", 1, true) ~= nil, "Refused due to missing capability")
        assert_eq(h.state.ab_loop, nil, "No native loop created")
        assert_eq(h.active_timer_count(), 0, "No timer leaked")
    end

    -- Test 3: Format restrictions (lossless <= 16-bit, normal speed, crossfade off)
    do
        -- 3a: Reject MP3 (lossless only!)
        local h = harness.new({
            format = {
                codec = "mp3",
                bit_depth = 0,
                sample_rate = 44100,
                playback_speed = 1.0,
                crossfade_enabled = false,
            }
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list
        find_row(screen.items, "Mark Point A").on_select()
        h.state.position = 50.0
        find_row(screen.items, "Mark Point B").on_select()
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("FLAC or PCM", 1, true) ~= nil, "Rejected MP3 for practice looper")

        -- 3b: Reject 24-bit FLAC (must be <= 16-bit)
        h.state.format.codec = "flac"
        h.state.format.bit_depth = 24
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("16-bit or less", 1, true) ~= nil, "Rejected 24-bit FLAC")

        -- 3c: Reject stream
        h.state.format.bit_depth = 16
        h.state.format.is_stream = true
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("Streaming audio", 1, true) ~= nil, "Rejected stream")
        h.state.format.is_stream = false

        -- 3d: Reject stretched speed != 1.0
        h.state.format.playback_speed = 1.5
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("speed must be 1.0x", 1, true) ~= nil, "Rejected speed != 1.0")
        h.state.format.playback_speed = 1.0

        -- 3e: Reject crossfade enabled
        h.state.format.crossfade_enabled = true
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("Crossfade must be disabled", 1, true) ~= nil, "Rejected crossfade")
        h.state.format.crossfade_enabled = false

        -- 3f: Reject paused playback
        h.state.paused = true
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("must be playing", 1, true) ~= nil, "Rejected while paused")
        h.state.paused = false

        -- 3g: Accept 16-bit FLAC!
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.ab_loop ~= nil, "Loop accepted for 16-bit FLAC")
        assert_eq(h.state.ab_loop.start, 30.0, "Start frame accurate")
        assert_eq(h.state.ab_loop.finish, 50.0, "Finish frame accurate")
        assert_eq(h.active_timer_count(), 1, "Interval allocated while loop active")

        -- 3h: Disengage clears loop and timer
        find_row(h.state.active_settings_list.items, "Disengage Loop").on_select()
        assert_eq(h.state.ab_loop, nil, "Native loop cleared")
        assert_eq(h.active_timer_count(), 0, "Interval cleared on disengage")

        -- 3i: Accept 16-bit WAV (PCM)
        h.state.format.codec = "pcm"
        find_row(h.state.active_settings_list.items, "Engage Loop").on_select()
        assert_true(h.state.ab_loop ~= nil, "Loop accepted for 16-bit PCM")
        assert_eq(h.active_timer_count(), 1, "Interval allocated")
        find_row(h.state.active_settings_list.items, "Disengage Loop").on_select()
        assert_eq(h.active_timer_count(), 0, "Interval cleared")
    end

    -- Test 4: Marking and editing A/B points (numeric input, validation)
    do
        local h = harness.new({ position = 15.25 })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list

        -- Mark A at 15.25s
        find_row(screen.items, "Mark Point A").on_select()

        -- Text input for Point B
        find_row(screen.items, "Edit Point B").on_select()
        assert_true(h.state.active_text_input ~= nil, "Text input displayed for Point B")
        -- Invalid: B <= A
        h.state.active_text_input.on_submit("10.0")
        assert_true(h.state.toasts[#h.state.toasts]:find("must be after Point A", 1, true) ~= nil, "Validated B > A")

        -- Valid B
        h.state.active_text_input.on_submit("42.500")

        -- Engage loop
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.ab_loop ~= nil, "Loop engaged")
        assert_eq(h.state.ab_loop.start, 15.25, "Point A accurate")
        assert_eq(h.state.ab_loop.finish, 42.5, "Point B accurate")

        -- Text input for Point A
        find_row(screen.items, "Edit Point A").on_select()
        assert_true(h.state.active_text_input ~= nil, "Text input displayed for Point A")
        h.state.active_text_input.on_submit("20.100")
        -- Check updated
        assert_true(h.state.active_settings_list.items[1].label:find("0:20.10 - 0:42.50", 1, true) ~= nil, "Persisted and updated point A")
    end

    -- Test 5: Playback interruption & state preservation (do not silently disable user settings)
    do
        local h = harness.new({ position = 10.0 })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list
        find_row(screen.items, "Mark Point A").on_select()
        h.state.position = 25.0
        find_row(screen.items, "Mark Point B").on_select()
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.ab_loop ~= nil, "Loop active")
        assert_eq(h.active_timer_count(), 1, "Polling timer running")

        -- User pauses playback -> native audio engine clears loop
        h.state.ab_loop = nil
        h.state.paused = true
        h.trigger_event("paused")

        assert_eq(h.active_timer_count(), 0, "Polling timer stopped on pause")

        -- Reopen menu
        h.state.registered_list_items[1].on_open()
        screen = h.state.active_settings_list

        -- Check: points A and B are NOT silently erased!
        local status_row = screen.items[1].label
        assert_true(status_row:find("Ready (0:10.00 - 0:25.00)", 1, true) ~= nil, "Preserved points after pause: " .. status_row)

        -- Resume playback and re-engage
        h.state.paused = false
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.ab_loop ~= nil, "Re-engaged using preserved points")
        assert_eq(h.state.ab_loop.start, 10.0, "Start preserved")
        assert_eq(h.state.ab_loop.finish, 25.0, "Finish preserved")

        -- Stop event
        h.state.ab_loop = nil
        h.trigger_event("stopped")
        assert_eq(h.active_timer_count(), 0, "Timer stopped on stop event")
        h.state.registered_list_items[1].on_open()
        assert_true(h.state.active_settings_list.items[1].label:find("Ready", 1, true) ~= nil, "Points kept after stop")

        -- Track started event
        h.trigger_event("track_started")
        assert_eq(h.active_timer_count(), 0, "Timer stopped on track change")
    end

    -- Test 6: Clear all points
    do
        local h = harness.new({ position = 5.0 })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list
        find_row(screen.items, "Mark Point A").on_select()
        h.state.position = 12.0
        find_row(screen.items, "Mark Point B").on_select()
        find_row(screen.items, "Clear Loop Points").on_select()

        assert_eq(h.state.storage_store["point_a"], nil, "Point A cleared from storage")
        assert_eq(h.state.storage_store["point_b"], nil, "Point B cleared from storage")
        assert_eq(h.state.ab_loop, nil, "Loop cleared")
        assert_eq(h.active_timer_count(), 0, "Zero active timers")
    end

    -- Test 7: Minimal storage writes (never write every tick)
    do
        local h = harness.new({ position = 1.0 })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list
        find_row(screen.items, "Mark Point A").on_select()
        h.state.position = 10.0
        find_row(screen.items, "Mark Point B").on_select()
        find_row(screen.items, "Engage Loop").on_select()

        local writes_before = h.state.storage_write_count
        -- Run 10 timer ticks while loop active
        for _ = 1, 10 do
            h.tick_timers()
        end
        assert_eq(h.state.storage_write_count, writes_before, "Zero storage writes during timer ticks")
    end

    -- Test 8: Track identity association (no silent reuse across different songs)
    do
        local h = harness.new({
            current_path = "/data/mnt/sd_0/Music/track1.flac",
            position = 10.0,
            duration = 200.0,
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list

        -- Mark points on track 1
        find_row(screen.items, "Mark Point A").on_select()
        h.state.position = 25.0
        find_row(screen.items, "Mark Point B").on_select()
        assert_true(h.state.active_settings_list.items[1].label:find("0:10.00 - 0:25.00", 1, true) ~= nil, "Track 1 points set")

        -- Track changes to track 2
        h.state.current_path = "/data/mnt/sd_0/Music/track2.flac"
        h.state.position = 5.0
        h.trigger_event("track_started")

        -- Reopen menu on track 2
        h.state.registered_list_items[1].on_open()
        local screen2 = h.state.active_settings_list
        assert_true(screen2.items[1].label:find("Not configured", 1, true) ~= nil, "Did not silently reuse track 1 points on track 2")

        -- Switch back to track 1
        h.state.current_path = "/data/mnt/sd_0/Music/track1.flac"
        h.trigger_event("track_started")
        h.state.registered_list_items[1].on_open()
        local screen3 = h.state.active_settings_list
        assert_true(screen3.items[1].label:find("0:10.00 - 0:25.00", 1, true) ~= nil, "Track 1 points restored when returning to track 1")
    end

    -- Test 9: Bounds to actual duration and refusal when idle or duration unknown
    do
        -- Idle refusal
        local h = harness.new({
            playing = false,
            current_path = nil,
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list
        find_row(screen.items, "Mark Point A").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("idle or paused", 1, true) ~= nil, "Refused mark Point A when idle")

        -- Unknown duration refusal
        local h2 = harness.new({
            playing = true,
            duration = 0,
        })
        h2.load_plugin(PLUGIN_PATH)
        h2.state.registered_list_items[1].on_open()
        local screen2 = h2.state.active_settings_list
        find_row(screen2.items, "Mark Point A").on_select()
        assert_true(h2.state.toasts[#h2.state.toasts]:find("duration unknown", 1, true) ~= nil, "Refused mark when duration unknown")

        -- Manual edit exceeding duration
        local h3 = harness.new({
            duration = 100.0,
        })
        h3.load_plugin(PLUGIN_PATH)
        h3.state.registered_list_items[1].on_open()
        local screen3 = h3.state.active_settings_list
        find_row(screen3.items, "Edit Point A").on_select()
        h3.state.active_text_input.on_submit("150.0")
        assert_true(h3.state.toasts[#h3.state.toasts]:find("exceeds track duration", 1, true) ~= nil, "Refused Point A exceeding duration")

        -- Non-finite input
        find_row(screen3.items, "Edit Point A").on_select()
        h3.state.active_text_input.on_submit("invalid_number")
        assert_true(h3.state.toasts[#h3.state.toasts]:find("Invalid Point A", 1, true) ~= nil, "Refused non-numeric input")
    end

    -- Test 10: Timer slot exhaustion handled cleanly without crashing
    do
        local h = harness.new({ position = 10.0 })
        -- Exhaust all 8 timer slots in the host
        for i = 1, 8 do
            h.plugin.set_interval(5, function() end)
        end
        assert_eq(h.active_timer_count(), 8, "All 8 timer slots occupied")

        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list
        find_row(screen.items, "Mark Point A").on_select()
        h.state.position = 20.0
        find_row(screen.items, "Mark Point B").on_select()

        -- Activating loop attempts set_interval, which will throw error in mock
        find_row(screen.items, "Engage Loop").on_select()
        -- Must not throw, loop is still active in engine, user is notified cleanly
        assert_true(h.state.ab_loop ~= nil, "Engine loop engaged despite timer exhaustion")
        local found_toast = false
        for _, msg in ipairs(h.state.toasts) do
            if msg:find("timer slots full", 1, true) then found_toast = true break end
        end
        assert_true(found_toast, "Handled timer exhaustion cleanly")
    end

    -- Test 11: Rejection of unknown native event names
    do
        local h = harness.new()
        local ok, err = pcall(function()
            h.plugin.on("some_unknown_event", function() end)
        end)
        assert_false(ok, "Harness rejects unknown event name")
        assert_true(tostring(err):find("unknown event", 1, true) ~= nil, "Error mentions unknown event")
    end

    -- Test 12: Generation match, exact 1.0x speed, and settings pool 2 enforcement
    do
        local h = harness.new({
            format = {
                path = "/data/mnt/sd_0/Music/track.flac",
                codec = "flac",
                bit_depth = 16,
                sample_rate = 44100,
                playback_speed = 1.0,
                generation = 5,
                duration_seconds = 120.0,
            }
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        assert_eq(#h.state.settings_stack, 1, "ABRepeat uses exactly 1 settings screen slot")

        local screen = h.state.active_settings_list
        find_row(screen.items, "Mark Point A").on_select()
        h.state.position = 40.0
        find_row(screen.items, "Mark Point B").on_select()

        -- Exact 1.0x speed requirement: 1.0005 must be rejected
        h.state.format.playback_speed = 1.0005
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("speed must be 1.0x", 1, true) ~= nil, "Rejected 1.0005x speed (exact 1.0x required)")
        h.state.format.playback_speed = 1.0

        -- Generation change invalidates compatibility
        h.state.format.generation = 6
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("generation mismatch", 1, true) ~= nil, "Rejected generation mismatch")
        h.state.format.generation = 5

        -- Valid engage
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.ab_loop ~= nil, "Engaged with matching generation")

        -- Interruption events must not push or call show_settings_list
        local count_before = #h.state.settings_screens
        h.trigger_event("paused")
        h.trigger_event("stopped")
        h.trigger_event("track_started")
        assert_eq(#h.state.settings_screens, count_before, "Playback events do not push or re-open settings list")
        assert_eq(#h.state.settings_stack, 1, "Settings stack remains exactly 1")
    end

    -- Test 13: Collision-resistant MD5 storage keys for distinct paths with same sanitized suffix
    do
        local p1 = "/data/mnt/sd_0/Music/A B.wav"
        local p2 = "/data/mnt/sd_0/Music/A_B.wav"

        -- Demonstrate that old sanitization collided
        local old_clean1 = p1:gsub("[^%w%._%-]", "_")
        local old_clean2 = p2:gsub("[^%w%._%-]", "_")
        assert_eq(old_clean1, old_clean2, "Old sanitization logic produced identical keys (collision)")

        local h = harness.new({
            current_path = p1,
            position = 10.0,
            duration = 100.0,
            format = {
                path = p1,
                codec = "pcm",
                bit_depth = 16,
                sample_rate = 44100,
                playback_speed = 1.0,
                generation = 1,
                duration_seconds = 100.0,
            }
        })

        -- MD5 produces distinct hashes
        local hash1 = h.plugin.md5(p1)
        local hash2 = h.plugin.md5(p2)
        assert_true(hash1 ~= hash2, "MD5 hashes for p1 and p2 are distinct")

        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list

        -- Mark points on p1
        find_row(screen.items, "Mark Point A").on_select()
        h.state.position = 25.0
        find_row(screen.items, "Mark Point B").on_select()

        -- Verify storage contains keys with hash1
        local key_a1 = "ab_a_" .. hash1
        local key_b1 = "ab_b_" .. hash1
        local key_a2 = "ab_a_" .. hash2
        local key_b2 = "ab_b_" .. hash2
        assert_eq(h.state.storage_store[key_a1], "10.000", "Point A stored under p1 MD5 key")
        assert_eq(h.state.storage_store[key_b1], "25.000", "Point B stored under p1 MD5 key")
        assert_eq(h.state.storage_store[key_a2], nil, "p2 key not yet touched")

        -- Switch playback to p2
        h.state.current_path = p2
        h.state.format.path = p2
        h.state.position = 5.0
        h.trigger_event("track_started")

        h.state.registered_list_items[1].on_open()
        local screen2 = h.state.active_settings_list
        assert_true(screen2.items[1].label:find("Not configured", 1, true) ~= nil, "p2 points start unconfigured")

        -- Mark points on p2
        find_row(screen2.items, "Mark Point A").on_select()
        h.state.position = 50.0
        find_row(screen2.items, "Mark Point B").on_select()

        assert_eq(h.state.storage_store[key_a2], "5.000", "Point A stored under p2 MD5 key")
        assert_eq(h.state.storage_store[key_b2], "50.000", "Point B stored under p2 MD5 key")
        -- Verify p1 keys remain unaltered
        assert_eq(h.state.storage_store[key_a1], "10.000", "p1 Point A remains intact")
        assert_eq(h.state.storage_store[key_b1], "25.000", "p1 Point B remains intact")

        -- Switch back to p1
        h.state.current_path = p1
        h.state.format.path = p1
        h.trigger_event("track_started")
        h.state.registered_list_items[1].on_open()
        local screen3 = h.state.active_settings_list
        assert_true(screen3.items[1].label:find("0:10.00 - 0:25.00", 1, true) ~= nil, "p1 points restored without collision")
    end

    -- Test 14: Text input callbacks race conditions (track change, generation change, paused/idle)
    do
        local p1 = "/data/mnt/sd_0/Music/track1.flac"
        local p2 = "/data/mnt/sd_0/Music/track2.flac"
        local h = harness.new({
            current_path = p1,
            position = 10.0,
            duration = 120.0,
            format = {
                path = p1,
                codec = "flac",
                bit_depth = 16,
                sample_rate = 44100,
                playback_speed = 1.0,
                generation = 1,
                duration_seconds = 120.0,
            }
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list

        -- 1. Track change while text input is open
        find_row(screen.items, "Edit Point A (Numeric)...").on_select()
        assert_true(h.state.active_text_input ~= nil, "Text input modal opened for Point A")
        local modal_cb = h.state.active_text_input.on_submit

        -- Now track changes to p2 with new generation
        h.state.current_path = p2
        h.state.format.path = p2
        h.state.format.generation = 2
        h.trigger_event("track_started")

        -- Stale callback executes
        local writes_before = h.state.storage_write_count
        modal_cb("15.000")
        assert_eq(h.state.storage_write_count, writes_before, "No storage writes on stale track change callback")
        assert_true(h.state.toasts[#h.state.toasts]:find("track changed", 1, true) ~= nil, "Rejected stale callback due to track change")

        -- Check p2 menu has no points
        h.state.registered_list_items[1].on_open()
        assert_true(h.state.active_settings_list.items[1].label:find("Not configured", 1, true) ~= nil, "p2 points not mutated")

        -- 2. Generation changed on SAME path while text input is open (track restarted/reloaded)
        h.state.current_path = p1
        h.state.format.path = p1
        h.state.format.generation = 3
        h.trigger_event("track_started")
        h.state.registered_list_items[1].on_open()

        find_row(h.state.active_settings_list.items, "Edit Point A (Numeric)...").on_select()
        local modal_cb2 = h.state.active_text_input.on_submit

        -- Generation changes on same path
        h.state.format.generation = 4
        modal_cb2("12.000")
        assert_true(h.state.toasts[#h.state.toasts]:find("track reloaded", 1, true) ~= nil, "Rejected stale callback due to generation change")

        -- 3. Playback becomes paused/idle while text input is open
        h.state.format.generation = 4
        find_row(h.state.active_settings_list.items, "Edit Point A (Numeric)...").on_select()
        local modal_cb3 = h.state.active_text_input.on_submit

        h.state.paused = true
        modal_cb3("14.000")
        assert_true(h.state.toasts[#h.state.toasts]:find("paused or idle", 1, true) ~= nil, "Rejected stale callback due to paused state")

        h.state.paused = false
        find_row(h.state.active_settings_list.items, "Edit Point A (Numeric)...").on_select()
        local unavailable_cb = h.state.active_text_input.on_submit
        local saved_format = h.state.format
        local writes_before_unavailable = h.state.storage_write_count
        h.state.format = nil
        unavailable_cb("15.000")
        assert_eq(h.state.storage_write_count, writes_before_unavailable, "Missing format during input cannot persist a marker using stale UI path")
        h.state.format = saved_format

        -- 4. Point B safeguards on track change
        h.state.paused = false
        find_row(h.state.active_settings_list.items, "Edit Point A (Numeric)...").on_select()
        h.state.active_text_input.on_submit("10.000") -- valid Point A commit

        find_row(h.state.active_settings_list.items, "Edit Point B (Numeric)...").on_select()
        local modal_cb_b = h.state.active_text_input.on_submit

        -- Track changes
        h.state.current_path = p2
        h.state.format.path = p2
        h.state.format.generation = 10
        h.trigger_event("track_started")

        modal_cb_b("30.000")
        assert_true(h.state.toasts[#h.state.toasts]:find("track changed", 1, true) ~= nil, "Point B rejected on track change")
        assert_eq(h.state.ab_loop, nil, "No loop engaged on track 2")
    end

    -- Test 15: Duration bounds, overshoot rounding, and ordering validation
    do
        local h = harness.new({
            position = 5.0,
            duration = 100.0004,
            format = {
                path = "/data/mnt/sd_0/Music/track.flac",
                codec = "flac",
                bit_depth = 16,
                sample_rate = 44100,
                playback_speed = 1.0,
                generation = 1,
                duration_seconds = 100.0004,
            }
        })
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list

        -- Entering value exceeding duration
        find_row(screen.items, "Edit Point A (Numeric)...").on_select()
        h.state.active_text_input.on_submit("100.5")
        assert_true(h.state.toasts[#h.state.toasts]:find("exceeds track duration", 1, true) ~= nil, "Rejected Point A > duration")

        -- Entering valid value that rounds without exceeding duration
        find_row(screen.items, "Edit Point A (Numeric)...").on_select()
        h.state.active_text_input.on_submit("100.0004")
        assert_true(h.state.toasts[#h.state.toasts]:find("Point A set to 1:40.00", 1, true) ~= nil, "Point A clamped/rounded within duration")

        -- Reset Point A to 10.0
        find_row(screen.items, "Edit Point A (Numeric)...").on_select()
        h.state.active_text_input.on_submit("10.000")

        -- Point B must be after Point A
        find_row(screen.items, "Edit Point B (Numeric)...").on_select()
        h.state.active_text_input.on_submit("9.5")
        assert_true(h.state.toasts[#h.state.toasts]:find("must be after Point A", 1, true) ~= nil, "Rejected Point B <= Point A")

        find_row(screen.items, "Edit Point B (Numeric)...").on_select()
        h.state.active_text_input.on_submit("10.0")
        assert_true(h.state.toasts[#h.state.toasts]:find("must be after Point A", 1, true) ~= nil, "Rejected Point B == Point A")

        -- Point B exceeding duration
        find_row(screen.items, "Edit Point B (Numeric)...").on_select()
        h.state.active_text_input.on_submit("101.0")
        assert_true(h.state.toasts[#h.state.toasts]:find("exceeds track duration", 1, true) ~= nil, "Rejected Point B > duration")

        -- Point B valid commit
        find_row(screen.items, "Edit Point B (Numeric)...").on_select()
        h.state.active_text_input.on_submit("20.0")
        assert_true(h.state.toasts[#h.state.toasts]:find("Point B set to 0:20.00", 1, true) ~= nil, "Point B accepted")
    end

    -- Test 16: Durable storage error handling and live memory loop persistence
    do
        local h = harness.new({
            position = 5.0,
            duration = 60.0,
        })
        h.state.storage_fail = true -- simulate persistent storage failure
        h.load_plugin(PLUGIN_PATH)
        h.state.registered_list_items[1].on_open()
        local screen = h.state.active_settings_list

        -- Mark Point A when storage fails
        find_row(screen.items, "Mark Point A").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("not remembered across restarts", 1, true) ~= nil, "Notified markers not remembered without claiming saved")

        -- Mark Point B when storage fails
        h.state.position = 20.0
        find_row(screen.items, "Mark Point B").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("not remembered across restarts", 1, true) ~= nil, "Point B notified not remembered")

        -- Live markers still work!
        find_row(screen.items, "Engage Loop").on_select()
        assert_true(h.state.ab_loop ~= nil, "Live loop engaged successfully despite storage failure")
        assert_eq(h.state.ab_loop.start, 5.0, "Loop start correct")
        assert_eq(h.state.ab_loop.finish, 20.0, "Loop finish correct")

        -- Zero unnecessary timer flash writes
        local writes_before = h.state.storage_write_count
        for _ = 1, 5 do
            h.tick_timers()
        end
        assert_eq(h.state.storage_write_count, writes_before, "Zero flash writes on timer ticks")

        -- Also test storage throwing an exception
        find_row(h.state.active_settings_list.items, "Disengage Loop").on_select()
        h.state.storage_fail = false
        h.state.storage_throw = true
        h.state.position = 6.0
        find_row(h.state.active_settings_list.items, "Mark Point A").on_select()
        assert_true(h.state.toasts[#h.state.toasts]:find("not remembered across restarts", 1, true) ~= nil, "Handled storage exception safely without crash")
    end
end
