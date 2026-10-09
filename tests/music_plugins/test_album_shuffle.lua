local harness = require("harness")

local function setup(dir, spec)
    spec = spec or {}
    os.execute("mkdir -p '" .. dir .. "/.plugins'")
    local h = harness.new({ sd_root = dir })
    h.play_mode = spec.play_mode or "sequential"
    h.albums = spec.albums or {
        { name = "Blue", count = 2, first_song_id = 1, album_artist = "A" },
        { name = "Red", count = 2, first_song_id = 3, album_artist = "A" },
        { name = "Greatest Hits", count = 1, first_song_id = 5, album_artist = "Alpha" },
        { name = "Greatest Hits", count = 1, first_song_id = 6, album_artist = "Beta" },
    }
    h.songs = spec.songs or {
        [1] = { id = 1, path = "/m/A/Blue/01.flac", title = "B1", artist = "A", album = "Blue", album_artist = "A" },
        [2] = { id = 2, path = "/m/A/Blue/02.flac", title = "B2", artist = "A", album = "Blue", album_artist = "A" },
        [3] = { id = 3, path = "/m/A/Red/01.flac", title = "R1", artist = "A", album = "Red", album_artist = "A" },
        [4] = { id = 4, path = "/m/A/Red/02.flac", title = "R2", artist = "A", album = "Red", album_artist = "A" },
        [5] = { id = 5, path = "/m/Alpha/GH/01.flac", title = "G1", artist = "Alpha", album = "Greatest Hits", album_artist = "Alpha" },
        [6] = { id = 6, path = "/m/Beta/GH/01.flac", title = "G1", artist = "Beta", album = "Greatest Hits", album_artist = "Beta" },
    }
    h.album_tracks = spec.album_tracks or {
        ["A\tBlue"] = { "/m/A/Blue/01.flac", "/m/A/Blue/02.flac" },
        ["A\tRed"] = { "/m/A/Red/01.flac", "/m/A/Red/02.flac" },
        ["Alpha\tGreatest Hits"] = { "/m/Alpha/GH/01.flac" },
        ["Beta\tGreatest Hits"] = { "/m/Beta/GH/01.flac" },
    }
    local M = h.load("plugins/AlbumShuffle/AlbumShuffle.lua")
    return h, M
end

local function album_of(paths)
    if not paths or not paths[1] then return nil end
    if paths[1]:find("/Blue/", 1, true) then return "Blue" end
    if paths[1]:find("/Red/", 1, true) then return "Red" end
    if paths[1]:find("/Alpha/", 1, true) then return "Alpha GH" end
    if paths[1]:find("/Beta/", 1, true) then return "Beta GH" end
    return paths[1]
end

return function(assert_eq, assert_true, assert_false)
    local root = assert(os.getenv("PWD")) .. "/build_test/plugin_example_tests/shuffle"
    os.execute("rm -rf '" .. root .. "' && mkdir -p '" .. root .. "'")

    -- identity prefers album_artist, then song.artist
    do
        local h, M = setup(root .. "/id")
        local ident = M.identity_from_group({ name = "Greatest Hits", count = 1, first_song_id = 5, album_artist = "Alpha" })
        assert_eq(ident.artist, "Alpha", "album_artist from group")
        assert_eq(ident.album, "Greatest Hits", "album from song")
        ident = M.identity_from_group({ name = "Greatest Hits", count = 1, first_song_id = 6, album_artist = "Beta" })
        assert_eq(ident.artist, "Beta", "collision uses first_song_id + album_artist")
        ident = M.identity_from_group({ name = "Greatest Hits", count = 1, first_song_id = 5 })
        assert_eq(ident.artist, "Alpha", "song.album_artist when group field empty")
    end

    -- compilation: first track artist differs from album_artist
    do
        local tracks = {
            "/m/VA/Now/01-GuestA.flac",
            "/m/VA/Now/02-GuestB.flac",
            "/m/VA/Now/03-GuestC.flac",
        }
        local h, M = setup(root .. "/compilation", {
            albums = {
                { name = "Now 2000", count = 3, first_song_id = 10, album_artist = "Various Artists" },
            },
            songs = {
                [10] = {
                    id = 10, path = tracks[1], title = "One",
                    artist = "Guest A", album = "Now 2000", album_artist = "Various Artists",
                },
                [11] = {
                    id = 11, path = tracks[2], title = "Two",
                    artist = "Guest B", album = "Now 2000", album_artist = "Various Artists",
                },
                [12] = {
                    id = 12, path = tracks[3], title = "Three",
                    artist = "Guest C", album = "Now 2000", album_artist = "Various Artists",
                },
            },
            album_tracks = {
                ["Various Artists\tNow 2000"] = tracks,
                ["Guest A\tNow 2000"] = { tracks[1] },
            },
        })
        local ident = M.identity_from_group({
            name = "Now 2000", count = 3, first_song_id = 10, album_artist = "Various Artists",
        })
        assert_eq(ident.artist, "Various Artists", "compilation lookup key is album_artist")
        M.start_from_ui()
        assert_eq(#h.play_lists, 1, "played compilation")
        local paths = h.play_lists[1].paths
        assert_eq(#paths, 3, "full compilation tracklist")
        assert_eq(paths[1], tracks[1], "compilation order 1")
        assert_eq(paths[2], tracks[2], "compilation order 2")
        assert_eq(paths[3], tracks[3], "compilation order 3")
    end

    -- start plays a whole album in order
    do
        local h, M = setup(root .. "/start")
        math.randomseed(1)
        M.start_from_ui()
        assert_true(M.session.active, "session on")
        assert_eq(#h.play_lists, 1, "one play_list")
        local paths = h.play_lists[1].paths
        assert_true(#paths >= 1, "has tracks")
        if album_of(paths) == "Blue" then
            assert_eq(paths[1], "/m/A/Blue/01.flac", "album order 1")
            assert_eq(paths[2], "/m/A/Blue/02.flac", "album order 2")
        end
        assert_eq(h.play_lists[1].start_index, 1, "start at 1")
    end

    -- queue_exhausted continues to another album and avoids immediate repeat
    do
        local h, M = setup(root .. "/next")
        math.randomseed(2)
        M.start_from_ui()
        local first = album_of(h.play_lists[1].paths)
        -- force last identity so the next pick should prefer the reservoir alt
        for i = 1, 40 do
            h.emit("queue_exhausted", 1)
            if #h.play_lists > 1 then break end
        end
        assert_true(#h.play_lists >= 2, "continued")
        local second = album_of(h.play_lists[#h.play_lists].paths)
        -- With four albums, a repeat is possible but the plugin prefers alt.
        -- Check that continuation happened while session stayed active.
        assert_true(M.session.active, "still active")
        if first and second and first ~= "Alpha GH" then
            -- not a hard fail if unlucky; verify the avoid path with two albums below
        end
    end

    do
        local h, M = setup(root .. "/norepeat", {
            albums = {
                { name = "Blue", count = 2, first_song_id = 1, album_artist = "A" },
                { name = "Red", count = 2, first_song_id = 3, album_artist = "A" },
            },
        })
        math.randomseed(3)
        M.start_from_ui()
        local first = album_of(h.play_lists[1].paths)
        M.session.last_id = (first == "Blue") and 1 or 3
        M.session.last_artist = "A"
        M.session.last_album = first
        -- deterministic: pick_album_group still random; run until different or cap
        local changed = false
        for i = 1, 20 do
            h.emit("queue_exhausted", 1)
            local cur = album_of(h.play_lists[#h.play_lists].paths)
            if cur ~= first then changed = true break end
        end
        assert_true(changed, "avoided immediate repeat with two albums")
    end

    -- explicit stop / disable: later queue_exhausted must not hijack
    do
        local h, M = setup(root .. "/stop")
        M.start_from_ui()
        local n = #h.play_lists
        M.stop_from_ui()
        assert_false(M.session.active, "stopped")
        h.emit("queue_exhausted", 1)
        assert_eq(#h.play_lists, n, "no play after UI stop")
    end

    do
        local h, M = setup(root .. "/native-stop")
        M.start_from_ui()
        local n = #h.play_lists
        h.emit("stopped")
        assert_false(M.session.active, "native stop ends session")
        h.emit("queue_exhausted", 1)
        assert_eq(#h.play_lists, n, "no play after native stop")
    end

    -- user selects an unrelated track
    do
        local h, M = setup(root .. "/hijack")
        M.start_from_ui()
        local n = #h.play_lists
        h.current_path = "/somewhere/else.flac"
        h.emit("track_started", "Else", "Z", "Q", 10, "")
        assert_false(M.session.active, "unrelated track ends session")
        h.emit("queue_exhausted", 1)
        assert_eq(#h.play_lists, n, "no continuation after hijack")
    end

    -- empty / zero albums
    do
        local h, M = setup(root .. "/empty", { albums = {}, songs = {}, album_tracks = {} })
        M.start_from_ui()
        assert_false(M.session.active, "empty library")
        assert_eq(#h.play_lists, 0, "no play_list")
        local saw = false
        for _, t in ipairs(h.toasts) do
            if t:find("No albums", 1, true) then saw = true end
        end
        assert_true(saw, "empty library toast")
    end

    -- one album: plays it; exhaust replays that album rather than looping empty
    do
        local h, M = setup(root .. "/one", {
            albums = { { name = "Blue", count = 2, first_song_id = 1, album_artist = "A" } },
        })
        M.start_from_ui()
        assert_eq(#h.play_lists, 1, "played the only album")
        assert_eq(album_of(h.play_lists[1].paths), "Blue", "the one album")
        h.emit("queue_exhausted", 1)
        assert_eq(#h.play_lists, 2, "single album may repeat")
        assert_eq(h.play_lists[2].paths[1], "/m/A/Blue/01.flac", "order preserved on repeat")
    end

    -- no playable tracks: no recursive exhaust
    do
        local h, M = setup(root .. "/unplayable", {
            albums = { { name = "Blue", count = 2, first_song_id = 1, album_artist = "A" } },
            album_tracks = { ["A\tBlue"] = {} },
        })
        M.start_from_ui()
        assert_eq(#h.play_lists, 0, "nothing played")
        h.emit("queue_exhausted", 1)
        h.emit("queue_exhausted", 1)
        assert_eq(#h.play_lists, 0, "no recursive play_list")
        assert_false(M.session.active, "session stopped")
    end

    -- native shuffle: refuse to start
    do
        local h, M = setup(root .. "/shuffle-mode", { play_mode = "shuffle" })
        M.start_from_ui()
        assert_eq(#h.play_lists, 0, "did not start in shuffle")
        assert_false(M.session.active, "inactive")
    end

    -- paging: more than one page of albums
    do
        local albums, songs, tracks = {}, {}, {}
        for i = 1, 120 do
            albums[i] = { name = "A" .. i, count = 1, first_song_id = i, album_artist = "X" }
            songs[i] = { id = i, path = "/m/X/A" .. i .. "/01.flac", title = "t", artist = "X", album = "A" .. i, album_artist = "X" }
            tracks["X\tA" .. i] = { "/m/X/A" .. i .. "/01.flac" }
        end
        local h, M = setup(root .. "/page", { albums = albums, songs = songs, album_tracks = tracks })
        math.randomseed(9)
        M.start_from_ui()
        assert_eq(#h.play_lists, 1, "picked from paged albums")
        assert_true(h.play_lists[1].paths[1]:find("/m/X/", 1, true) ~= nil, "playable paged album")
    end

    -- queue_exhausted previous direction is ignored
    do
        local h, M = setup(root .. "/prev")
        M.start_from_ui()
        local n = #h.play_lists
        h.emit("queue_exhausted", -1)
        assert_eq(#h.play_lists, n, "ignore previous exhaust")
    end

    -- natural idle after the last track continues once, not on every tick
    do
        local h, M = setup(root .. "/idle")
        M.start_from_ui()
        local n = #h.play_lists
        h.playing = false
        h.paused = false
        h.tick_intervals()
        assert_eq(#h.play_lists, n, "one idle poll is not enough")
        h.tick_intervals()
        assert_true(#h.play_lists > n, "natural end continues")
        local after = #h.play_lists
        h.playing = true
        h.tick_intervals()
        h.tick_intervals()
        assert_eq(#h.play_lists, after, "no extra continuation while playing")
    end
    -- Pausing must not look like EOF; changing mode ends the session.
    do
        local h, M = setup(root .. "/paused")
        M.start_from_ui()
        local n = #h.play_lists
        h.playing = false
        h.paused = true
        h.tick_intervals()
        h.tick_intervals()
        assert_eq(#h.play_lists, n, "pause does not continue")
        h.play_mode = "shuffle"
        h.tick_intervals()
        assert_false(M.session.active, "changing mode cancels album shuffle")
        h.play_mode = "sequential"
        h.paused = false
        h.tick_intervals()
        h.tick_intervals()
        assert_eq(#h.play_lists, n, "mode change cannot resume the session")
    end

end
