local harness = require("harness")

local JPEG = string.char(0xFF, 0xD8, 0xFF, 0xE0) .. "fakejpeg"

-- MusicBrainz release-group search replies. Editions of one album are one
-- release group, so they collapse into one row here.
local MB_OK = [[{
  "created": "2017-03-12T16:27:16.317Z",
  "count": 1,
  "offset": 0,
  "release-groups": [
    {
      "id": "76df3287-6cda-33eb-8e9a-044b5e15ffdd",
      "score": 100,
      "title": "Dummy",
      "primary-type": "Album",
      "artist-credit": [{"name": "The Artist", "joinphrase": "", "artist": {"name": "The Artist"}}]
    }
  ]
}]]

-- Shape of the live MusicBrainz reply for Weezer / Weezer: several
-- self-titled albums, each its own release group.
local MB_SELF_TITLED = [[{
  "count": 2,
  "offset": 0,
  "release-groups": [
    {"id": "eeeeeeee-0000-0000-0000-000000000001", "score": 100, "title": "Weezer", "primary-type": "Album",
     "artist-credit": [{"name": "Weezer", "artist": {"name": "Weezer"}}]},
    {"id": "eeeeeeee-0000-0000-0000-000000000002", "score": 98, "title": "Weezer", "primary-type": "Album",
     "artist-credit": [{"name": "Weezer", "artist": {"name": "Weezer"}}]}
  ]
}]]

local MB_COLLISION = [[{
  "count": 2,
  "offset": 0,
  "release-groups": [
    {
      "id": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
      "score": 100,
      "title": "Greatest Hits",
      "artist-credit": [{"name": "Alpha", "artist": {"name": "Alpha"}}]
    },
    {
      "id": "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb",
      "score": 99,
      "title": "Greatest Hits",
      "artist-credit": [{"name": "Beta", "artist": {"name": "Beta"}}]
    }
  ]
}]]

local CAA_JSON = [[{
  "images": [
    {
      "types": ["Front"],
      "front": true,
      "back": false,
      "image": "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842.jpg",
      "thumbnails": {
        "250": "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842-250.jpg",
        "500": "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842-500.jpg",
        "large": "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842-500.jpg"
      },
      "approved": true,
      "id": "829521842"
    }
  ],
  "release": "http://musicbrainz.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd"
}]]

local CAA_BACK_ONLY = [[{
  "images": [
    {
      "types": ["Back"],
      "front": false,
      "back": true,
      "image": "http://coverartarchive.org/release/99b09d02-9cc9-3fed-8431-f162165a9371/135822686.jpg",
      "thumbnails": {
        "250": "http://coverartarchive.org/release/99b09d02-9cc9-3fed-8431-f162165a9371/135822686-250.jpg",
        "500": "http://coverartarchive.org/release/99b09d02-9cc9-3fed-8431-f162165a9371/135822686-500.jpg"
      },
      "approved": true,
      "id": "135822686"
    }
  ],
  "release": "http://musicbrainz.org/release/99b09d02-9cc9-3fed-8431-f162165a9371"
}]]

local ARCHIVE_500 = "https://archive.org/download/mbid-76df3287-6cda-33eb-8e9a-044b5e15ffdd/mbid-76df3287-6cda-33eb-8e9a-044b5e15ffdd-829521842-500.jpg"
local ARCHIVE_SECOND = "https://archive.org/download/mbid-cccccccc-cccc-cccc-cccc-cccccccccccc/mbid-cccccccc-cccc-cccc-cccc-cccccccccccc-123456-500.jpg"
local CAA_500 = "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842-500.jpg"
local CAA_500_HTTPS = "https://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842-500.jpg"

local function write_file(path, data)
    local f = assert(io.open(path, "wb"))
    f:write(data)
    f:close()
end

local function read_file(path)
    local f = io.open(path, "rb")
    if not f then return nil end
    local d = f:read("*a")
    f:close()
    return d
end

local function exists(path)
    return read_file(path) ~= nil
end

-- Image hops are GETs of .jpg URLs; their body is the JPEG itself.
-- image_body(url) can vary the bytes per album.
local function router(kind, image_body)
    image_body = image_body or function() return JPEG end
    return function(options)
        local url = options.url
        local method = options.method or "GET"
        if url:find("musicbrainz.org", 1, true) then
            if kind == "offline" then return nil, nil, "dns_failure", nil end
            if kind == "collision" then return 200, MB_COLLISION, nil, {} end
            if kind == "nomatch" then
                return 200, '{"count":0,"offset":0,"release-groups":[]}', nil, {}
            end
            if url:find("Second%%20Album") then
                return 200, (MB_OK:gsub("76df3287%-6cda%-33eb%-8e9a%-044b5e15ffdd", "cccccccc-cccc-cccc-cccc-cccccccccccc")
                    :gsub('"Dummy"', '"Second Album"')), nil, {}
            end
            return 200, MB_OK, nil, {}
        end
        if url:find("coverartarchive.org/release-group/cccccccc-cccc-cccc-cccc-cccccccccccc", 1, true) and url:sub(-1) == "/" then
            return 200, (CAA_JSON:gsub("76df3287%-6cda%-33eb%-8e9a%-044b5e15ffdd", "cccccccc-cccc-cccc-cccc-cccccccccccc")
                :gsub("829521842", "123456")), nil, {}
        end
        if url:find("coverartarchive.org/release-group/76df3287", 1, true) and url:sub(-1) == "/" then
            if kind == "direct200" then
                return 200, [[{
  "images":[{"types":["Front"],"front":true,"back":false,
    "image":"http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842.jpg",
    "thumbnails":{"250":"https://archive.org/download/mbid-76df3287-6cda-33eb-8e9a-044b5e15ffdd/mbid-76df3287-6cda-33eb-8e9a-044b5e15ffdd-829521842-250.jpg",
      "500":"https://archive.org/download/mbid-76df3287-6cda-33eb-8e9a-044b5e15ffdd/mbid-76df3287-6cda-33eb-8e9a-044b5e15ffdd-829521842-500.jpg"},
    "approved":true,"id":"829521842"}],
  "release":"http://musicbrainz.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd"
}]], nil, {}
            end
            if kind == "nofront" then return 200, CAA_BACK_ONLY, nil, {} end
            return 200, CAA_JSON, nil, {}
        end
        if method == "GET" and url:match("%.jpg$") then
            if kind == "headfail" then return nil, nil, "connect_failed", nil end
            if kind == "oversize" and url:find("archive.org", 1, true) then
                -- What the native client reports past max_response_bytes.
                return nil, nil, "response_too_large", nil
            end
            if kind == "notjpeg" and url:find("archive.org", 1, true) then
                return 200, "<html>not an image</html>", nil, {}
            end
            if kind == "empty" and url:find("archive.org", 1, true) then
                return 200, "", nil, {}
            end
            if kind == "direct200" and url:find("archive.org", 1, true) then
                return 200, image_body(url), nil, {}
            end
            if kind == "tworedirect" then
                if url:find("coverartarchive.org", 1, true) and url:find("829521842-500.jpg", 1, true) then
                    return 307, "", nil, { Location = "front-500.jpg" }
                end
                if url:find("/front-500.jpg", 1, true) then
                    return 302, "", nil, { Location = ARCHIVE_500 }
                end
                if url:find("archive.org", 1, true) then
                    return 200, image_body(url), nil, {}
                end
            end
            if kind == "loop" then
                return 307, "", nil, { Location = url }
            end
            if kind == "toomany" then
                return 307, "", nil, { Location = url .. "/h.jpg" }
            end
            if kind == "invalid" then
                return 307, "", nil, { Location = "ftp://example.invalid/cover.jpg" }
            end
            if url:find("coverartarchive.org", 1, true) and url:find("123456-500.jpg", 1, true) then
                return 307, "", nil, { Location = ARCHIVE_SECOND }
            end
            if url:find("coverartarchive.org", 1, true) and url:find("829521842-500.jpg", 1, true) then
                return 307, "", nil, {
                    Location = "http://archive.org/download/mbid-76df3287-6cda-33eb-8e9a-044b5e15ffdd/mbid-76df3287-6cda-33eb-8e9a-044b5e15ffdd-829521842-500.jpg",
                }
            end
            if url:find("archive.org", 1, true) then
                return 200, image_body(url), nil, {}
            end
        end
        return 404, "", nil, {}
    end
end

-- Image GETs that reached archive.org, i.e. the final hop of each fetch.
local function image_gets(h)
    local out = {}
    for _, req in ipairs(h.http_calls) do
        if (req.method or "GET") == "GET" and req.url:find("archive.org/download", 1, true) then
            out[#out + 1] = req
        end
    end
    return out
end

local function setup(dir, extra)
    extra = extra or {}
    os.execute("mkdir -p '" .. dir .. "/.plugins' '" .. dir .. "/Music/Dummy'")
    local audio = dir .. "/Music/Dummy/01.flac"
    write_file(audio, "audio")
    local h = harness.new({
        sd_root = dir,
        api_version = 16,
        defer_http = extra.defer_http,
        http_impl = extra.http_impl or router("ok", extra.image_body),
        download_impl = function() error("cover fetcher must not use download_file_async") end,
    })
    h.current_path = audio
    h.now_playing = { "Song", extra.artist or "The Artist", extra.album or "Dummy", 180 }
    h.songs[1] = {
        id = 1, path = audio, title = "Song",
        artist = extra.artist or "The Artist",
        album = extra.album or "Dummy",
        album_artist = extra.album_artist or "The Artist",
    }
    local M = h.load("plugins/CoverArtFetcher/CoverArtFetcher.lua")
    local album_name = (extra.album or "Dummy"):gsub('"', "'"):gsub('[%*/:<>?\\|]', "_")
    return h, M, dir .. "/Music/Dummy/" .. album_name .. ".jpg", audio
end

return function(assert_eq, assert_true, assert_false)
    local root = assert(os.getenv("PWD")) .. "/build_test/plugin_example_tests/cover"
    os.execute("rm -rf '" .. root .. "' && mkdir -p '" .. root .. "'")

    do
        local h, M, dest = setup(root .. "/ok")
        M.fetch_current(false)
        local body = read_file(dest)
        assert_true(body ~= nil, "album-title.jpg written")
        assert_eq(body:byte(1), 0xFF, "jpeg magic")
        assert_eq(body:byte(2), 0xD8, "jpeg magic 2")
        assert_eq(h.library_refresh_count, 1, "refresh_library after success")
        local saw_ua = false
        for _, req in ipairs(h.http_calls) do
            if req.headers and req.headers["User-Agent"] and req.headers["User-Agent"]:find("CoverArtFetcher", 1, true) then
                saw_ua = true
            end
            assert_true(req.verify_tls == true, "tls on lookup")
        end
        assert_true(saw_ua, "MusicBrainz User-Agent")
        assert_eq(#h.downloads, 0, "no unbounded download_file_async transfer")
        assert_false(exists(dest .. ".compas-fetch"), "staging file is promoted, not left behind")
        assert_true(h.http_calls[1].url:find("/ws/2/release-group/", 1, true) ~= nil, "lookup searches release groups")
        assert_true(h.http_calls[2].url:find("coverartarchive.org/release-group/76df3287", 1, true) ~= nil,
            "archive listing is the release group's")
        local images = 0
        for _, req in ipairs(h.http_calls) do
            if req.url:match("%.jpg$") then
                images = images + 1
                assert_eq(req.method, "GET", "image hop is a GET")
                assert_eq(req.max_response_bytes, M.MAX_IMAGE_BYTES, "image hop is capped at 2 MiB")
                assert_eq(req.redirect_limit, 0, "image hop follows redirects itself")
                assert_eq(req.total_timeout_ms, 90000, "image hop has a bounded 90 s timeout")
                assert_eq(req.connect_timeout_ms, 10000, "image hop connect timeout")
                assert_eq(req.read_timeout_ms, 15000, "image hop read timeout")
            else
                assert_eq(req.total_timeout_ms, 30000, "JSON lookup keeps a 30 s timeout")
                assert_true(req.url:match("^https://") ~= nil, "image hop is https")
            end
        end
        assert_eq(images, 2, "CAA redirect then archive.org image")
    end

    do
        local h, M, dest = setup(root .. "/exists")
        write_file(dest, "already")
        M.fetch_current(false)
        assert_eq(read_file(dest), "already", "did not replace album-title.jpg")
        assert_eq(#h.http_calls, 0, "no traffic when cover exists")
    end

    do
        local h, M, dest = setup(root .. "/legacy-generic")
        local generic = root .. "/legacy-generic/Music/Dummy/cover.jpg"
        write_file(generic, "user generic cover")
        M.fetch_current(false)
        assert_eq(read_file(generic), "user generic cover", "legacy generic cover is preserved")
        assert_true(exists(dest), "album-specific sidecar is still fetched")
    end

    do
        local count = 0
        local h, M = setup(root .. "/shared-folder", {
            image_body = function()
                count = count + 1
                return JPEG .. tostring(count)
            end,
        })
        local shared = root .. "/shared-folder/Music/Dummy"
        M.fetch_current(false)
        local first = read_file(shared .. "/Dummy.jpg")
        h.current_path = shared .. "/02.flac"
        write_file(h.current_path, "audio")
        h.now_playing = { "Song two", "The Artist", "Second Album", 180 }
        h.songs[2] = { id = 2, path = h.current_path, title = "Song two", artist = "The Artist", album = "Second Album", album_artist = "The Artist" }
        local original_time = os.time
        local now = original_time() + 2
        os.time = function() return now end
        M.fetch_current(false)
        h.tick_intervals()
        os.time = original_time
        assert_true(exists(shared .. "/Second Album.jpg"), "second album in shared folder gets its own sidecar")
        assert_true(first ~= read_file(shared .. "/Second Album.jpg"), "shared-folder album covers have distinct bytes")
        local images = image_gets(h)
        assert_eq(#images, 2, "both shared-folder albums download artwork")
        assert_true(images[1].url ~= images[2].url, "shared-folder albums resolve distinct CAA thumbnails")
    end

    do
        local h, M = setup(root .. "/sanitized-collision", { album = "A/B", artist = "Alpha" })
        h.songs[2] = { id = 2, path = root .. "/sanitized-collision/Music/Dummy/02.flac", title = "Other", artist = "Beta", album = "A:B", album_artist = "Beta" }
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "different artists with colliding sanitized title are refused")
        assert_false(exists(root .. "/sanitized-collision/Music/Dummy/A_B.jpg"), "collision writes no sidecar")
    end

    do
        local h, M = setup(root .. "/same-artist-sanitized-collision", { album = "A/B", artist = "Alpha" })
        h.songs[2] = { id = 2, path = root .. "/same-artist-sanitized-collision/Music/Dummy/02.flac", title = "Other", artist = "Alpha", album = "A:B", album_artist = "Alpha" }
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "same artist titles with same sanitized filename are refused")
    end

    do
        local h, M = setup(root .. "/parent-child-collision", { album = "Shared Title", artist = "Alpha" })
        local child = root .. "/parent-child-collision/Music/Dummy/Disc 1/02.flac"
        os.execute("mkdir -p '" .. root .. "/parent-child-collision/Music/Dummy/Disc 1'")
        h.songs[2] = { id = 2, path = child, title = "Other", artist = "Beta", album = "Shared Title", album_artist = "Beta" }
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "same sidecar title across parent and child folders is refused")
    end

    do
        local h, M = setup(root .. "/track-basename-collision", { album = "Title", artist = "Alpha" })
        h.songs[2] = { id = 2, path = root .. "/track-basename-collision/Music/Dummy/Title.mp3", title = "Title", artist = "Beta", album = "Other", album_artist = "Beta" }
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "album filename colliding with another track basename is refused")
    end

    do
        local h, M = setup(root .. "/reserved-name", { album = "cover", artist = "Alpha" })
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "generic native sidecar basename is refused")
        assert_false(exists(root .. "/reserved-name/Music/Dummy/cover.jpg"), "generic cover.jpg is not written")
    end

    do
        local h, M = setup(root .. "/native-cache-name", { album = "Album.72x72", artist = "Alpha" })
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "native resized-cache basename is refused")
    end

    do
        local h, M = setup(root .. "/sibling-disc-collision", { album = "Shared", artist = "Alpha" })
        local base = root .. "/sibling-disc-collision/Music/Dummy"
        h.current_path = base .. "/CD1/01.flac"
        h.songs[1].path = h.current_path
        h.songs[2] = { id = 2, path = base .. "/Disc 2/02.flac", artist = "Beta", album = "Shared", album_artist = "Beta" }
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "sibling disc artwork fallback cannot share different albums")
    end

    do
        local h, M = setup(root .. "/case-collision", { album = "A/B", artist = "Alpha" })
        h.songs[2] = { id = 2, path = root .. "/case-collision/Music/Dummy/02.flac", artist = "Alpha", album = "a:b", album_artist = "Alpha" }
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "case insensitive sidecar filename collisions are refused")
    end

    do
        local h, M = setup(root .. "/uppercase-cache-name", { album = "Album.72X72" })
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "case insensitive sized artwork alias is refused")
    end

    do
        local h, M = setup(root .. "/incomplete-library")
        h.plugin.library_get_songs = function() return { h.songs[1] }, 2 end
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "incomplete library scan writes no artwork")
    end

    do
        local h, M = setup(root .. "/changing-path")
        local path, calls = h.current_path, 0
        h.plugin.get_current_track_path = function()
            calls = calls + 1
            return calls == 1 and path or path .. ".different"
        end
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "changing path snapshot writes no artwork")
    end

    do
        local h, M = setup(root .. "/metadata-mismatch")
        h.now_playing = { "Song", "Other Artist", "Other Album", 180 }
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "current path with inconsistent playback tags is refused")
        assert_false(exists(root .. "/metadata-mismatch/Music/Dummy/Dummy.jpg"), "metadata mismatch writes nothing")
    end

    do
        local h, M = setup(root .. "/deferred-track-change", { defer_http = true })
        M.fetch_current(false)
        h.current_path = root .. "/deferred-track-change/Music/Other/02.flac"
        os.execute("mkdir -p '" .. root .. "/deferred-track-change/Music/Other'")
        h.now_playing = { "Other Song", "Other Artist", "Other Album", 180 }
        h.flush()
        assert_true(exists(root .. "/deferred-track-change/Music/Dummy/Dummy.jpg"), "pending job saves to captured album path")
        assert_false(exists(root .. "/deferred-track-change/Music/Other/Other Album.jpg"), "track change does not retarget pending job")
    end

    do
        local h, M, dest = setup(root .. "/offline", { http_impl = router("offline") })
        M.fetch_current(false)
        assert_false(exists(dest), "offline writes nothing")
        local calls = #h.http_calls
        M.fetch_current(true)
        assert_eq(#h.http_calls, calls, "auto mode does not retry a recent failure")
    end

    do
        local h, M, dest = setup(root .. "/nomatch", { http_impl = router("nomatch") })
        M.fetch_current(false)
        assert_false(exists(dest), "no-match writes nothing")
    end

    do
        local h, M = setup(root .. "/collision", {
            http_impl = router("collision"),
            album = "Greatest Hits",
            artist = "Alpha",
        })
        -- Our tags are Alpha / Greatest Hits: only Alpha's group matches,
        -- Beta's same-titled group is dropped, and an unknown artist gets none.
        local picked = M.pick_release_group(harness.decode_json(MB_COLLISION), "Unknown", "Greatest Hits", "")
        assert_eq(picked, nil, "do not pick an unrelated Greatest Hits")
        picked = M.pick_release_group(harness.decode_json(MB_COLLISION), "Alpha", "Greatest Hits", "Alpha")
        assert_eq(picked, "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa", "exact artist match")
    end

    do
        local h, M, dest = setup(root .. "/dup", {
            defer_http = true,
            http_impl = router("ok"),
        })
        M.fetch_current(false)
        M.fetch_current(false)
        local mb = 0
        for _, req in ipairs(h.http_calls) do
            if req.url:find("musicbrainz.org", 1, true) then mb = mb + 1 end
        end
        assert_eq(mb, 1, "deduped MusicBrainz lookup")
        h.flush()
        assert_true(exists(dest), "cover saved after flush")
    end

    local function has_toast(h, fragment)
        for _, message in ipairs(h.toasts) do
            if message:find(fragment, 1, true) then return true end
        end
        return false
    end

    local function has_progress(h, fragment)
        for _, event in ipairs(h.progress_events) do
            if event.message and event.message:find(fragment, 1, true) then return true end
        end
        return false
    end

    do
        local h, M = setup(root .. "/manual-progress", { defer_http = true, http_impl = router("ok") })
        M.fetch_current(false)
        assert_true(has_progress(h, "Looking up MusicBrainz"), "manual fetch immediately reports MusicBrainz lookup")
        M.fetch_current(false)
        assert_true(has_progress(h, "already in progress"), "duplicate active request has specific feedback")
        h.flush()
        assert_true(has_progress(h, "Checking Cover Art Archive"), "manual status reports archive phase")
        assert_true(has_progress(h, "Downloading cover"), "manual status reports image download phase")
        assert_true(has_progress(h, "Saving cover"), "manual status reports save phase")
        assert_true(has_toast(h, "Saved Dummy.jpg"), "manual completion toast remains visible")
        assert_true(exists(root .. "/manual-progress/Music/Dummy/Dummy.jpg"), "manual fetch saves album sidecar")
        assert_eq(h.active_progress, nil, "success closes manual progress card")
    end

    do
        -- A bounded GET reports no byte progress, so every phase stays
        -- indeterminate; no percentage is invented.
        local h, M = setup(root .. "/manual-image-progress", { defer_http = true, http_impl = router("ok") })
        local original_time = os.time
        local now = original_time()
        os.time = function() return now end
        M.fetch_current(false)
        h.flush_one_batch() -- MusicBrainz
        h.flush_one_batch() -- Cover Art Archive
        h.flush_one_batch() -- CAA image redirect
        now = now + 26
        h.tick_intervals()
        os.time = original_time
        assert_eq(h.progress_events[#h.progress_events].message, "Downloading cover…", "image phase is visible")
        h.flush()
        for _, event in ipairs(h.progress_events) do
            assert_eq(event.fraction, nil, "progress stays indeterminate: " .. tostring(event.message))
        end
        assert_eq(h.active_progress, nil, "completed image fetch closes progress")
        assert_true(exists(root .. "/manual-image-progress/Music/Dummy/Dummy.jpg"), "image saved after deferred hops")
    end

    do
        local h, M = setup(root .. "/manual-dismiss", { defer_http = true, http_impl = router("ok") })
        M.fetch_current(false)
        local first_handle = h.active_progress
        local request_count = #h.http_calls
        h.dismiss_progress()
        assert_eq(h.plugin.update_progress(first_handle, "stale", nil), false, "dismissed progress handle is stale")
        h.tick_intervals()
        assert_eq(h.active_progress, nil, "polling does not reopen dismissed manual progress")
        M.fetch_current(false)
        assert_true(h.active_progress ~= nil and h.active_progress ~= first_handle, "intentional tap reopens dismissed progress")
        assert_eq(#h.http_calls, request_count, "reopening does not duplicate active lookup")
        h.flush()
    end

    do
        local h, M = setup(root .. "/manual-failure", {
            defer_http = true,
            http_impl = router("offline"),
        })
        M.fetch_current(false)
        assert_true(has_progress(h, "Looking up MusicBrainz"), "failed manual fetch has immediate status")
        h.flush()
        assert_true(has_toast(h, "Cover fetch failed (network)"), "manual failure is reported")
        assert_eq(h.active_progress, nil, "failure closes manual progress card")
    end

    do
        local h, M = setup(root .. "/manual-refresh", { defer_http = true, http_impl = router("ok") })
        local original_time = os.time
        local now = original_time()
        os.time = function() return now end
        M.fetch_current(false)
        local initial_count = #h.progress_events
        now = now + 26
        h.tick_intervals()
        os.time = original_time
        assert_true(#h.progress_events > initial_count, "long manual phase refreshes its visible status")
        assert_eq(h.active_progress ~= nil, true, "manual status card remains visible")
    end

    do
        local h, M = setup(root .. "/manual-queue", { defer_http = true, http_impl = router("ok") })
        local original_time = os.time
        local now = original_time()
        os.time = function() return now end
        M.fetch_current(false)
        local second_dir = root .. "/manual-queue/Music/Other"
        os.execute("mkdir -p '" .. second_dir .. "'")
        h.current_path = second_dir .. "/02.flac"
        h.now_playing = { "Song", "The Artist", "Other", 180 }
        h.songs[2] = { id = 2, path = h.current_path, title = "Song", artist = "The Artist", album = "Other", album_artist = "The Artist" }
        M.fetch_current(false)
        assert_true(has_toast(h, "Cover fetch queued"), "manual request behind active manual work reports queued")
        M.fetch_current(false)
        assert_true(has_toast(h, "Cover fetch already queued"), "duplicate queued request has specific feedback")
        local queued_count = 0
        for _, event in ipairs(h.progress_events) do
            if event.message == "Cover fetch queued" then queued_count = queued_count + 1 end
        end
        now = now + 26
        h.tick_intervals()
        os.time = original_time
        local refreshed_count = 0
        for _, event in ipairs(h.progress_events) do
            if event.message == "Cover fetch queued" then refreshed_count = refreshed_count + 1 end
        end
        assert_eq(refreshed_count, queued_count, "queued status does not overwrite active manual progress")
        assert_eq(h.progress_events[#h.progress_events].message, "Looking up MusicBrainz…", "active manual status takes refresh priority")
    end

    do
        local h, M = setup(root .. "/queued-cover-already-present", { defer_http = true, http_impl = router("ok") })
        M.fetch_current(false)
        local second_dir = root .. "/queued-cover-already-present/Music/Other"
        os.execute("mkdir -p '" .. second_dir .. "'")
        h.current_path = second_dir .. "/02.flac"
        h.now_playing = { "Song", "The Artist", "Other", 180 }
        h.songs[2] = { id = 2, path = h.current_path, title = "Song", artist = "The Artist", album = "Other", album_artist = "The Artist" }
        M.fetch_current(false)
        assert_true(h.active_progress ~= nil, "queued manual job has a progress card")
        write_file(second_dir .. "/Other.jpg", "already here")
        local original_time = os.time
        local now = original_time() + 10
        os.time = function() return now end
        h.tick_intervals()
        h.flush()
        os.time = original_time
        assert_eq(h.active_progress, nil, "skipped existing-cover queue item closes its progress")
        assert_true(has_toast(h, "Other.jpg already present"), "skipped manual queue item reports existing cover")
    end

    do
        local h, M = setup(root .. "/auto-quiet", { defer_http = true, http_impl = router("ok") })
        M.state.auto = true
        h.emit("track_started")
        assert_eq(#h.toasts, 0, "automatic fetch remains quiet")
        M.fetch_current(false)
        assert_true(has_progress(h, "Looking up MusicBrainz"), "manual tap joining automatic job reports its actual stage")
        assert_eq(#h.http_calls, 1, "manual tap joining auto job does not duplicate lookup")
        h.flush()
        assert_true(has_toast(h, "Saved Dummy.jpg"), "joined manual request receives completion")
    end

    do
        local h, M = setup(root .. "/manual-queued-behind-auto", {
            defer_http = true,
            http_impl = router("ok"),
        })
        local original_time = os.time
        local now = original_time()
        os.time = function() return now end
        M.state.auto = true
        h.emit("track_started")
        assert_eq(#h.toasts, 0, "automatic job stays quiet before a manual queue request")

        local second_dir = root .. "/manual-queued-behind-auto/Music/Other"
        os.execute("mkdir -p '" .. second_dir .. "'")
        h.current_path = second_dir .. "/02.flac"
        h.now_playing = { "Song", "The Artist", "Other", 180 }
        h.songs[2] = { id = 2, path = h.current_path, title = "Song", artist = "The Artist", album = "Other", album_artist = "The Artist" }
        M.fetch_current(false)
        assert_true(has_progress(h, "Cover fetch queued"), "manual job queued behind auto job is announced")
        local queued_handle = h.active_progress
        h.dismiss_progress()
        M.fetch_current(false)
        assert_true(h.active_progress ~= nil and h.active_progress ~= queued_handle,
            "intentional duplicate tap reopens dismissed queued progress")
        assert_eq(#h.http_calls, 1, "reopening queued progress does not duplicate lookup")
        local count_before_refresh = #h.progress_events

        now = now + 26
        h.tick_intervals()
        os.time = original_time
        assert_true(#h.progress_events > count_before_refresh, "queued manual status refreshes behind automatic work")
        assert_eq(h.progress_events[#h.progress_events].message, "Cover fetch queued", "explicitly reopened queued status stays visible")
        for _, event in ipairs(h.progress_events) do
            assert_eq(event.message, "Cover fetch queued", "automatic phase remains quiet while manual work waits")
        end
    end

    do
        local h, M, dest = setup(root .. "/stale", { defer_http = true })
        M.fetch_current(false)
        write_file(dest, "user-cover")
        h.flush()
        assert_eq(read_file(dest), "user-cover", "in-flight callback did not replace album-title.jpg")
    end

    do
        local listing = harness.decode_json(CAA_JSON)
        local h, M = setup(root .. "/thumb")
        local url = M.thumbnail_url(listing)
        assert_true(url:find("-500.jpg", 1, true) ~= nil, "prefer 500px thumb")
        assert_eq(M.to_https("http://archive.org/x"), "https://archive.org/x", "upgrade http")
        assert_eq(M.resolve_reference(CAA_500_HTTPS, "ftp://host/image.jpg"), nil, "reject redirect schemes")
        assert_eq(M.thumbnail_url(harness.decode_json(CAA_BACK_ONLY)), nil, "no-front listing")
        assert_eq(
            M.resolve_reference(CAA_500_HTTPS, "front-500.jpg"),
            "https://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/front-500.jpg",
            "relative Location"
        )
    end

    do
        local h, M = setup(root .. "/thumb-aliases")
        local base = "http://coverartarchive.org/release/978c4483-e56a-4ba7-acdc-ecb782d25371/14000958155"
        local function listing(thumbnails, front)
            return { images = { { front = front ~= false, image = base .. ".jpg", thumbnails = thumbnails } } }
        end
        assert_eq(M.thumbnail_url(listing({ small = base .. "-250.jpg", large = base .. "-500.jpg" })),
            base .. "-500.jpg", "legacy large alias is used for 500px")
        assert_eq(M.thumbnail_url(listing({ small = base .. "-250.jpg" })), base .. "-250.jpg",
            "legacy small alias is used when it is the only size")
        assert_eq(M.thumbnail_url(listing({ ["250"] = base .. "-250.jpg", large = base .. "-500.jpg" })),
            base .. "-250.jpg", "numeric keys are preferred over aliases")
        assert_eq(M.thumbnail_url(listing({ ["500"] = base .. "-500.jpg", large = base .. "-x.jpg" })),
            base .. "-500.jpg", "numeric 500 wins")
        assert_eq(M.thumbnail_url(listing({ large = base .. ".jpg" })), nil,
            "an alias pointing at the unsized original is refused")
        assert_eq(M.thumbnail_url(listing({ large = base .. "-1200.jpg", small = base .. "-250.png" })), nil,
            "aliases must name their documented size")
        assert_eq(M.thumbnail_url(listing({ ["500"] = base .. ".jpg" })), nil,
            "a numeric key pointing at the unsized original is refused")
        assert_eq(M.thumbnail_url(listing({})), nil, "the original image is never used without thumbnails")
        assert_eq(M.thumbnail_url(listing({ large = base .. "-500.jpg" }, false)), nil, "non-front art is ignored")
    end

    do
        -- Exact live responses (2026-10-10): the release-group search for
        -- Fear of the Dark / Iron Maiden also returns the "Fear of the Dark
        -- Live" single, and the CAA release-group listing for the album has
        -- only the legacy small/large thumbnail aliases.
        local live_groups = assert(read_file("tests/music_plugins/fixtures/cover_live_release_groups_fear_of_the_dark.json"))
        local live_cover = assert(read_file("tests/music_plugins/fixtures/cover_live_caa_group_153c0331.json"))
        local group = "153c0331-41b2-33b9-b86e-c6717761aa80"
        local caa_500 = "https://coverartarchive.org/release/978c4483-e56a-4ba7-acdc-ecb782d25371/14000958155-500.jpg"
        local archive_500 = "https://archive.org/download/mbid-978c4483-e56a-4ba7-acdc-ecb782d25371/mbid-978c4483-e56a-4ba7-acdc-ecb782d25371-14000958155_thumb500.jpg"
        local h, M, dest = setup(root .. "/live-fear-of-the-dark", {
            album = "Fear of the Dark", artist = "Iron Maiden", album_artist = "Iron Maiden",
            http_impl = function(options)
                local url = options.url
                if url:find("musicbrainz.org/ws/2/release-group/", 1, true) then return 200, live_groups, nil, {} end
                if url == "https://coverartarchive.org/release-group/" .. group .. "/" then return 200, live_cover, nil, {} end
                if url == caa_500 then return 307, "", nil, { Location = archive_500 } end
                if url == archive_500 then return 200, JPEG .. "fear", nil, {} end
                error("unexpected request " .. url)
            end,
        })
        local payload = harness.decode_json(live_groups)
        assert_eq(M.pick_release_group(payload, "Iron Maiden", "Fear of the Dark", "Iron Maiden"), group,
            "live search picks the album group despite the Live single")
        assert_eq(M.pick_release_group(payload, "Iron Maiden", "Fear of the Dark Live", "Iron Maiden"),
            "f5552fe0-55b2-333e-a58a-1078d72d5993", "the Live single is a separate exact title")
        assert_eq(M.thumbnail_url(harness.decode_json(live_cover)),
            "http://coverartarchive.org/release/978c4483-e56a-4ba7-acdc-ecb782d25371/14000958155-500.jpg",
            "live listing resolves to the 500px large alias")
        M.fetch_current(false)
        assert_eq(read_file(dest), JPEG .. "fear", "live album saves its cover instead of reporting no art")
        assert_true(has_toast(h, "Saved Fear of the Dark.jpg"), "live album save is reported")
        local images = {}
        for _, req in ipairs(h.http_calls) do
            if req.url:match("%.jpg$") then images[#images + 1] = req end
        end
        assert_eq(#images, 2, "CAA 500px hop then archive.org image")
        assert_eq(images[1].url, caa_500, "the large alias is upgraded to https")
        for _, req in ipairs(images) do
            assert_true(not req.url:find("14000958155.jpg", 1, true), "the unsized original is never fetched")
            assert_eq(req.max_response_bytes, M.MAX_IMAGE_BYTES, "live image hop stays capped at 2 MiB")
            assert_eq(req.total_timeout_ms, 90000, "live image hop allows 90 s")
            assert_eq(req.redirect_limit, 0, "live image hop follows redirects itself")
        end
        assert_eq(h.http_calls[1].total_timeout_ms, 30000, "live lookup keeps 30 s")
        assert_eq(#h.json_decode_calls, 2, "both live JSON replies decode within the limits")
    end

    local function run_resolve(dir, kind, start_url)
        local h, M, dest = setup(root .. "/" .. dir, { http_impl = router(kind) })
        M.pending_dest[dest] = 1
        M.fetch_image({ dest = dest, is_auto = false, key = "k" }, start_url, 1)
        return h, M, dest
    end

    local function count_gets(h)
        local n = 0
        for _, req in ipairs(h.http_calls) do
            if req.method == "GET" and req.url:match("%.jpg$") then n = n + 1 end
        end
        return n
    end

    do
        local h, M, dest = run_resolve("direct200", "direct200", ARCHIVE_500)
        assert_eq(read_file(dest), JPEG, "direct 200 body is saved as the sidecar")
        assert_eq(#image_gets(h), 1, "one image GET")
        assert_eq(image_gets(h)[1].url, ARCHIVE_500, "fetched archive URL")
        assert_eq(h.http_calls[1].redirect_limit, 0, "image GET does not auto-follow")
        assert_false(exists(dest .. ".compas-fetch"), "staging is promoted")
    end

    do
        local h, M, dest = run_resolve("tworedirect", "tworedirect", CAA_500)
        assert_true(exists(dest), "two redirects then image")
        assert_eq(h.http_calls[#h.http_calls].url, ARCHIVE_500, "final hop fetched")
        assert_eq(count_gets(h), 3, "GET at each hop including 200")
    end

    do
        local h, M, dest = run_resolve("loop", "loop", CAA_500_HTTPS)
        assert_false(exists(dest), "redirect loop writes nothing")
        assert_eq(count_gets(h), 1, "loop stops at the repeated URL")
    end

    do
        local h, M, dest = run_resolve("toomany", "toomany", CAA_500_HTTPS)
        assert_false(exists(dest), "too many redirects writes nothing")
        assert_eq(count_gets(h), 6, "initial plus 5 hops")
    end

    do
        local h, M, dest = run_resolve("invalid", "invalid", CAA_500_HTTPS)
        assert_false(exists(dest), "invalid Location writes nothing")
        assert_eq(count_gets(h), 1, "invalid Location is not followed")
    end

    do
        local h, M, dest = run_resolve("headfail", "headfail", ARCHIVE_500)
        assert_false(exists(dest), "image request failure writes nothing")
    end

    do
        -- No Content-Length is needed: the native client stops at the cap.
        local h, M, dest = run_resolve("oversize", "oversize", ARCHIVE_500)
        assert_false(exists(dest), "response over the cap writes nothing")
        assert_false(exists(dest .. ".compas-fetch"), "response over the cap leaves no staging file")
        assert_true(M.failed_recently("k"), "oversize is a remembered no-art result")
    end

    do
        local h, M, dest = run_resolve("notjpeg", "notjpeg", ARCHIVE_500)
        assert_false(exists(dest), "a 200 body that is not JPEG is not promoted")
        assert_false(exists(dest .. ".compas-fetch"), "rejected body leaves no staging file")
    end

    do
        local h, M, dest = run_resolve("empty", "empty", ARCHIVE_500)
        assert_false(exists(dest), "an empty 200 body writes nothing")
        assert_false(exists(dest .. ".compas-fetch"), "empty body creates no staging file")
    end

    do
        -- Staging write failure: the album folder is read-only.
        local h, M, dest = setup(root .. "/staging-write-fail", { http_impl = router("direct200") })
        local dir = root .. "/staging-write-fail/Music/Dummy"
        M.pending_dest[dest] = 1
        os.execute("chmod 555 '" .. dir .. "'")
        M.fetch_image({ dest = dest, is_auto = false, manual_requested = true, key = "k" }, ARCHIVE_500, 1)
        os.execute("chmod 755 '" .. dir .. "'")
        assert_false(exists(dest), "unwritable folder saves nothing")
        assert_false(exists(dest .. ".compas-fetch"), "unwritable folder leaves no staging file")
        assert_true(has_toast(h, "Could not save album sidecar"), "write failure is reported")
    end

    do
        -- A late image body for a superseded generation is discarded.
        local h, M, dest = setup(root .. "/stale-image", { http_impl = router("direct200") })
        M.pending_dest[dest] = 2
        M.fetch_image({ dest = dest, is_auto = false, key = "k" }, ARCHIVE_500, 1)
        assert_eq(#h.http_calls, 0, "stale generation sends no image request")
        assert_false(exists(dest), "stale generation writes nothing")
    end

    do
        local h, M, dest = setup(root .. "/staging-size")
        write_file(dest .. ".big", JPEG .. string.rep("x", M.MAX_IMAGE_BYTES))
        M.pending_dest[dest] = 1
        M.promote_cover({ dest = dest, is_auto = false, key = "k" }, dest .. ".big", 1)
        assert_false(exists(dest), "staging over 2MiB not promoted")
    end

    do
        local h, M, dest = setup(root .. "/nofront", { http_impl = router("nofront") })
        M.fetch_current(false)
        assert_false(exists(dest), "back-only listing is no-art")
        assert_eq(#image_gets(h), 0, "no image download without front")
    end

    do
        local h, M = setup(root .. "/remote-cover", {
            http_impl = function() error("no HTTP for remote://") end,
        })
        h.current_path = "remote://tidal/abc"
        h.now_playing = { "Song", "The Artist", "Dummy", 180 }
        local n = #h.http_calls
        M.fetch_current(false)
        assert_eq(#h.http_calls, n, "no lookup for remote://")
        assert_eq(#image_gets(h), 0, "no download for remote://")
        assert_eq(M.current_album(), nil, "current_album rejects remote://")
    end

    do
        local dir = root .. "/identity"
        os.execute("mkdir -p '" .. dir .. "/.plugins' '" .. dir .. "/Music/Alpha/Hits' '" .. dir .. "/Music/Beta/Hits'")
        local alpha = dir .. "/Music/Alpha/Hits/01.flac"
        local beta = dir .. "/Music/Beta/Hits/01.flac"
        write_file(alpha, "a")
        write_file(beta, "b")
        local h = harness.new({
            sd_root = dir,
            api_version = 16,
            http_impl = function() error("identity test must not HTTP") end,
        })
        h.current_path = beta
        h.now_playing = { "Song", "Sam", "Hits", 180 }
        for i = 1, 51 do
            h.songs[i] = {
                id = i,
                path = dir .. "/Music/Alpha/Hits/pad-" .. i .. ".flac",
                title = "Song",
                artist = "Sam",
                album = "Hits",
                album_artist = "Alpha",
            }
        end
        h.songs[1].path = alpha
        h.songs[51] = {
            id = 51, path = beta, title = "Song",
            artist = "Sam", album = "Hits", album_artist = "Beta",
        }
        local M = h.load("plugins/CoverArtFetcher/CoverArtFetcher.lua")
        local job = M.current_album()
        assert_true(job ~= nil, "current album from beta folder")
        assert_eq(job.album_artist, "Beta", "album_artist from matching path, not first page")
        assert_eq(job.dir, dir .. "/Music/Beta/Hits", "folder of the playing file")
        h.current_path = dir .. "/Music/Unknown/Hits/01.flac"
        job = M.current_album()
        assert_eq(job, nil, "unknown path is refused when it has no matching indexed row")
    end

    -- ---- 1.1.3: MusicBrainz release-group ambiguity ----

    do
        local h, M = setup(root .. "/release-groups")
        local function pick(payload) return M.pick_release_group(payload, "Weezer", "Weezer", "Weezer") end
        local payload = harness.decode_json(MB_SELF_TITLED)
        local id, reason = pick(payload)
        assert_eq(id, nil, "same artist and title across release groups is refused")
        assert_eq(reason, "no-match", "two groups are an ambiguous match")

        local one = harness.decode_json(MB_SELF_TITLED)
        table.remove(one["release-groups"], 2)
        one.count = 1
        assert_eq(pick(one), "eeeeeeee-0000-0000-0000-000000000001", "a single complete group matches")

        local repeated = harness.decode_json(MB_SELF_TITLED)
        repeated["release-groups"][2].id = repeated["release-groups"][1].id
        assert_eq(pick(repeated), "eeeeeeee-0000-0000-0000-000000000001", "the same group listed twice still matches")

        -- Truncation: the reply reports more groups than it returned. The
        -- missing rows could be a second album with this title.
        local truncated = harness.decode_json(MB_SELF_TITLED)
        table.remove(truncated["release-groups"], 2)
        id, reason = pick(truncated)
        assert_eq(id, nil, "a truncated page is not proof of one group")
        assert_eq(reason, "incomplete", "truncation is reported as incomplete")

        local paged = harness.decode_json(MB_OK)
        paged.offset = 25
        assert_eq(M.pick_release_group(paged, "The Artist", "Dummy", "The Artist"), nil, "a later page is refused")
        local no_count = harness.decode_json(MB_OK)
        no_count.count = nil
        assert_eq(M.pick_release_group(no_count, "The Artist", "Dummy", "The Artist"), nil,
            "a reply without a result count is refused")
        local fewer = harness.decode_json(MB_OK)
        fewer.count = 0
        assert_eq(M.pick_release_group(fewer, "The Artist", "Dummy", "The Artist"), nil,
            "a count below the returned rows is refused")
        local release_shape = { count = 1, offset = 0, releases = harness.decode_json(MB_OK)["release-groups"] }
        assert_eq(M.pick_release_group(release_shape, "The Artist", "Dummy", "The Artist"), nil,
            "a reply without release groups is refused")

        local bad_id = harness.decode_json(MB_OK)
        bad_id["release-groups"][1].id = "../../evil"
        assert_eq(M.pick_release_group(bad_id, "The Artist", "Dummy", "The Artist"), nil,
            "a matching row whose id is not an MBID is refused")
        local missing_id = harness.decode_json(MB_SELF_TITLED)
        missing_id["release-groups"][2].id = nil
        assert_eq(pick(missing_id), nil, "a matching row without an id fails closed")
        local unrelated_bad = harness.decode_json(MB_OK)
        unrelated_bad["release-groups"][2] = { id = "junk", title = "Something Else",
            ["artist-credit"] = { { name = "The Artist" } } }
        unrelated_bad.count = 2
        assert_eq(M.pick_release_group(unrelated_bad, "The Artist", "Dummy", "The Artist"),
            "76df3287-6cda-33eb-8e9a-044b5e15ffdd", "a non-matching row does not block the match")
    end

    do
        local h, M, dest = setup(root .. "/self-titled", {
            album = "Weezer", artist = "Weezer", album_artist = "Weezer",
            http_impl = function(options)
                if options.url:find("musicbrainz.org", 1, true) then return 200, MB_SELF_TITLED, nil, {} end
                error("ambiguous match must not reach the Cover Art Archive")
            end,
        })
        M.fetch_current(false)
        assert_false(exists(dest), "ambiguous self-titled album writes nothing")
        assert_eq(#h.http_calls, 1, "ambiguous self-titled album fetches nothing further")
        assert_true(h.toasts[#h.toasts]:find("conservatively", 1, true) ~= nil, "ambiguity reports no conservative match")
        local url = h.http_calls[1].url
        assert_true(url:find("limit=25", 1, true) ~= nil and url:find("offset=0", 1, true) ~= nil,
            "lookup asks for the first 25 release groups")
        assert_true(url:find("releasegroup%3A", 1, true) ~= nil, "lookup matches the release-group title field")
        local limits = h.json_decode_calls[1].limits
        assert_eq(limits.max_input_bytes, 262144, "MusicBrainz JSON decode is size bounded")
        assert_eq(limits.max_nesting, 16, "MusicBrainz JSON decode is nesting bounded")
        assert_eq(limits.max_entries, 8000, "MusicBrainz JSON decode is entry bounded")
    end

    do
        local h, M, dest = setup(root .. "/truncated-search", {
            http_impl = function(options)
                if options.url:find("musicbrainz.org", 1, true) then
                    return 200, '{"count":40,"offset":0,"release-groups":[{"id":"76df3287-6cda-33eb-8e9a-044b5e15ffdd",'
                        .. '"title":"Dummy","artist-credit":[{"name":"The Artist"}]}]}', nil, {}
                end
                error("a truncated search must not reach the Cover Art Archive")
            end,
        })
        M.fetch_current(false)
        assert_false(exists(dest), "truncated search writes nothing")
        assert_eq(#h.http_calls, 1, "truncated search stops after the lookup")
        assert_true(has_toast(h, "Too many MusicBrainz matches"), "truncated search is explained")
    end

    do
        local h, M, dest = setup(root .. "/json-size-guard", {
            http_impl = function(options)
                if options.url:find("musicbrainz.org", 1, true) then
                    return 200, '{"pad":"' .. string.rep("x", 262144) .. '"}', nil, {}
                end
                error("an oversized lookup body must stop")
            end,
        })
        M.fetch_current(false)
        assert_eq(#h.json_decode_calls, 0, "a body over the JSON cap is not decoded")
        assert_false(exists(dest), "an oversized lookup body writes nothing")
    end

    do
        local h, M, dest = setup(root .. "/caa-json-limits")
        M.fetch_current(false)
        assert_eq(#h.json_decode_calls, 2, "lookup and archive listing are decoded")
        assert_eq(h.json_decode_calls[2].limits.max_input_bytes, 262144, "archive JSON decode is size bounded")
        assert_eq(h.json_decode_calls[2].limits.max_entries, 8000, "archive JSON decode is entry bounded")
    end

    do
        local h, M, dest = setup(root .. "/bad-json", {
            http_impl = function(options)
                if options.url:find("musicbrainz.org", 1, true) then return 200, "{not json", nil, {} end
                error("invalid JSON must not continue")
            end,
        })
        M.fetch_current(false)
        assert_false(exists(dest), "invalid MusicBrainz JSON writes nothing")
        assert_true(h.toasts[#h.toasts]:find("conservatively", 1, true) ~= nil, "invalid JSON ends as no match")
    end

    do
        local h, M, dest = setup(root .. "/mb-busy", {
            http_impl = function(options)
                if options.url:find("musicbrainz.org", 1, true) then return 503, "", nil, {} end
                error("rate-limited lookup must stop")
            end,
        })
        M.fetch_current(false)
        assert_false(exists(dest), "rate-limited lookup writes nothing")
        assert_true(h.toasts[#h.toasts]:find("busy", 1, true) ~= nil, "rate limit is reported as busy")
        assert_eq(next(M.fail_memory), nil, "rate limit is not remembered as a failed album")
    end

    -- ---- 1.1.3: raw album whitespace ----

    for index, raw in ipairs({ "Dummy ", " Dummy", "Dummy\t" }) do
        local label = string.format("%q", raw)
        local h, M = setup(root .. "/raw-space-" .. index, { album = raw })
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "raw album " .. label .. " with outer whitespace is not looked up")
        assert_false(exists(root .. "/raw-space-" .. index .. "/Music/Dummy/Dummy.jpg"),
            "raw album " .. label .. " writes no sidecar the native lookup would miss")
        assert_true(h.toasts[#h.toasts]:find("spaces", 1, true) ~= nil, "whitespace refusal is explained")
        local path, reason = M.cover_path("/x", raw)
        assert_eq(path, nil, "cover_path refuses raw " .. label)
        assert_eq(reason, "untrimmed-album", "cover_path names the whitespace reason")
    end

    do
        local h, M = setup(root .. "/raw-space-auto", { album = "Dummy " })
        M.state.auto = true
        h.emit("track_started")
        assert_eq(#h.toasts, 0, "automatic whitespace refusal stays quiet")
        assert_eq(#h.http_calls, 0, "automatic whitespace refusal sends nothing")
    end

    do
        -- A neighbour whose raw tag has outer spaces maps to a different native
        -- filename, so it is not a collision for the trimmed current album.
        local h, M, dest = setup(root .. "/raw-space-neighbour")
        h.songs[2] = { id = 2, path = root .. "/raw-space-neighbour/Music/Dummy/02.flac", title = "Other",
            artist = "Other", album = "Dummy ", album_artist = "Other" }
        M.fetch_current(false)
        assert_true(exists(dest), "untrimmed neighbour does not block the exact native filename")
    end

    -- ---- 1.1.3: coalesced, retried library refresh ----

    local function with_clock(fn)
        local original_time = os.time
        local clock = { now = original_time() }
        os.time = function() return clock.now end
        local ok, err = pcall(fn, clock)
        os.time = original_time
        if not ok then error(err, 0) end
    end

    do
        local h, M = setup(root .. "/refresh-rate-limited")
        h.refresh_results = { { false, "rate_limited" } }
        with_clock(function(clock)
            M.fetch_current(false)
            assert_eq(h.library_refresh_count, 1, "save requests one refresh")
            assert_true(M.refresh.pending, "rate-limited refresh stays pending")
            clock.now = clock.now + 30
            h.tick_intervals()
            assert_eq(h.library_refresh_count, 1, "rate-limited refresh waits for the native window")
            clock.now = clock.now + 31
            h.tick_intervals()
            assert_eq(h.library_refresh_count, 2, "rate-limited refresh retries after the window")
            assert_false(M.refresh.pending, "retried refresh completes")
            h.tick_intervals()
            assert_eq(h.library_refresh_count, 2, "completed refresh is not repeated")
        end)
    end

    do
        local h, M = setup(root .. "/refresh-busy")
        h.refresh_results = { { false, "already_running" }, { false, "already_running" } }
        with_clock(function(clock)
            M.fetch_current(false)
            clock.now = clock.now + 14
            h.tick_intervals()
            assert_eq(h.library_refresh_count, 1, "busy library is not polled every second")
            clock.now = clock.now + 1
            h.tick_intervals()
            assert_eq(h.library_refresh_count, 2, "busy library is retried after 15 seconds")
            clock.now = clock.now + 15
            h.tick_intervals()
            assert_eq(h.library_refresh_count, 3, "refresh starts once the library is idle")
            assert_false(M.refresh.pending, "busy retry completes")
        end)
    end

    do
        local count = 0
        local h, M = setup(root .. "/refresh-coalesce", {
            image_body = function()
                count = count + 1
                return JPEG .. tostring(count)
            end,
        })
        local shared = root .. "/refresh-coalesce/Music/Dummy"
        with_clock(function(clock)
            M.fetch_current(false)
            assert_eq(h.library_refresh_count, 1, "first save starts a refresh")
            h.current_path = shared .. "/02.flac"
            write_file(h.current_path, "audio")
            h.now_playing = { "Song two", "The Artist", "Second Album", 180 }
            h.songs[2] = { id = 2, path = h.current_path, title = "Song two", artist = "The Artist",
                album = "Second Album", album_artist = "The Artist" }
            clock.now = clock.now + 2
            M.fetch_current(false)
            h.tick_intervals()
            assert_true(exists(shared .. "/Second Album.jpg"), "second save inside the window succeeds")
            assert_eq(h.library_refresh_count, 1, "second save inside the native window is not refused natively")
            assert_true(M.refresh.pending, "second save leaves one coalesced refresh pending")
            clock.now = clock.now + 61
            h.tick_intervals()
            h.tick_intervals()
            assert_eq(h.library_refresh_count, 2, "two saves cause exactly two native refresh starts")
        end)
    end

    do
        local h, M = setup(root .. "/refresh-bounded")
        for i = 1, 60 do h.refresh_results[i] = { false, "rate_limited" } end
        with_clock(function(clock)
            M.fetch_current(false)
            for _ = 1, 60 do
                clock.now = clock.now + 61
                h.tick_intervals()
            end
            assert_eq(h.library_refresh_count, 40, "refresh retries are bounded")
            assert_false(M.refresh.pending, "refresh gives up after the bound")
        end)
    end

    do
        local h, M = setup(root .. "/refresh-unknown")
        h.refresh_results = { { false, "plugin_disabled" } }
        with_clock(function(clock)
            M.fetch_current(false)
            clock.now = clock.now + 120
            h.tick_intervals()
            assert_eq(h.library_refresh_count, 1, "unknown refusal is not retried")
            assert_false(M.refresh.pending, "unknown refusal clears the request")
        end)
    end

    -- ---- 1.1.3: bounded image transfer and the cancel contract ----

    do
        -- Harness matches the native contract: a cancelled request or download
        -- never calls back, and download progress is gone at once. A plugin
        -- that waited for such a callback would hang; this one never cancels.
        local h = harness.new({ sd_root = root, api_version = 16, defer_http = true,
            http_impl = function() return 200, "x", nil, {} end,
            download_impl = function(_, dest) return dest, nil end })
        local request_called, download_called = false, false
        local rh = h.plugin.http_request({ url = "https://example.invalid/a" }, function() request_called = true end)
        local dh = h.plugin.download_file_async("https://example.invalid/b", root .. "/b", true,
            function() download_called = true end)
        h.set_download_progress(dh, 10, 100)
        assert_true(h.plugin.cancel(rh), "cancel reports a running request")
        assert_true(h.plugin.cancel(dh), "cancel reports a running download")
        assert_eq(h.plugin.get_download_progress(dh), nil, "progress is unavailable right after cancel")
        h.flush()
        assert_false(request_called, "cancelled request callback is suppressed")
        assert_false(download_called, "cancelled download callback is suppressed")
        assert_false(h.plugin.cancel(rh), "cancelling twice reports not running")
    end

    do
        -- Over-cap image during an automatic fetch: the native size limit
        -- fails the GET, the job finishes quietly and the queue moves on.
        local h, M, dest = setup(root .. "/oversize-auto", { defer_http = true, http_impl = router("oversize") })
        M.state.auto = true
        h.emit("track_started")
        h.flush()
        assert_false(exists(dest), "automatic oversize image writes nothing")
        assert_false(exists(dest .. ".compas-fetch"), "automatic oversize image leaves no staging file")
        assert_eq(#h.toasts, 0, "automatic oversize image stays quiet")
        assert_eq(next(M.pending_dest), nil, "oversize image releases its destination")
        assert_eq(#h.downloads, 0, "no download_file_async transfer to cancel")
    end

    do
        local h, M, dest = setup(root .. "/oversize-manual", { http_impl = router("oversize") })
        M.fetch_current(false)
        assert_false(exists(dest), "manual oversize image writes nothing")
        assert_true(has_toast(h, "No cover art"), "manual oversize image is reported as no art")
        assert_eq(h.active_progress, nil, "manual oversize image closes progress")
    end

    -- ---- 1.1.3: shared generic artwork repair ----

    local function song(id, path, album, artist)
        return { id = id, path = path, title = "T" .. id, artist = artist or "Artist",
            album = album, album_artist = artist or "Artist" }
    end

    -- layout: list of { relative audio path, album, artist }; files: relative image paths.
    local function repair_setup(name, layout, files, current)
        local dir = root .. "/" .. name
        os.execute("rm -rf '" .. dir .. "' && mkdir -p '" .. dir .. "/.plugins'")
        local h = harness.new({ sd_root = dir, api_version = 16,
            http_impl = function() error("repair must not use the network") end })
        for i, entry in ipairs(layout) do
            local path = dir .. "/" .. entry[1]
            os.execute("mkdir -p '" .. path:match("^(.*)/") .. "'")
            write_file(path, "audio")
            h.songs[i] = song(i, path, entry[2], entry[3])
        end
        for _, rel in ipairs(files or {}) do
            local path = dir .. "/" .. rel
            os.execute("mkdir -p '" .. path:match("^(.*)/") .. "'")
            write_file(path, "image:" .. rel)
        end
        local cur = h.songs[current or 1]
        h.current_path = cur.path
        h.now_playing = { cur.title, cur.artist, cur.album, 180 }
        local M = h.load("plugins/CoverArtFetcher/CoverArtFetcher.lua")
        return h, M, dir
    end

    local function last_list(h) return h.lists[#h.lists] end

    local function list_paths(list)
        local out = {}
        for _, item in ipairs(list.items) do
            if type(item) == "table" then out[#out + 1] = item.label end
        end
        return out
    end

    do
        local h, M, dir = repair_setup("repair-cancel",
            { { "Music/Shared/a.flac", "Album A" }, { "Music/Shared/b.flac", "Album B" } },
            { "Music/Shared/cover.jpg" })
        M.open_generic_repair()
        local list = last_list(h)
        assert_true(list ~= nil, "shared local cover opens a preview")
        local paths = list_paths(list)
        assert_eq(#paths, 1, "preview lists exactly the shared generic file")
        assert_eq(paths[1], dir .. "/Music/Shared/cover.jpg", "preview shows the exact path")
        assert_true(list.items[#list.items - 1]:find("compas-backup", 1, true) ~= nil, "confirm row names the backup")
        assert_eq(list.items[#list.items], "Cancel", "preview offers cancel")
        list.on_select(1)
        assert_eq(read_file(dir .. "/Music/Shared/cover.jpg"), "image:Music/Shared/cover.jpg", "tapping a path changes nothing")
        list.on_select(#list.items)
        assert_eq(read_file(dir .. "/Music/Shared/cover.jpg"), "image:Music/Shared/cover.jpg", "cancel leaves bytes unchanged")
        assert_false(exists(dir .. "/Music/Shared/cover.jpg.compas-backup"), "cancel creates no backup")
        assert_true(has_toast(h, "No files changed"), "cancel is confirmed")
        list.on_select(#list.items - 1)
        assert_true(exists(dir .. "/Music/Shared/cover.jpg"), "confirm after cancel does nothing")
        assert_eq(h.library_refresh_count, 0, "cancel requests no refresh")
    end

    do
        local h, M, dir = repair_setup("repair-confirm",
            { { "Music/Shared/a.flac", "Album A" }, { "Music/Shared/b.flac", "Album B" } },
            { "Music/Shared/cover.jpg", "Music/Shared/folder.png", "Music/Shared/notes.txt", "Music/Shared/Album Z.jpg" })
        M.open_generic_repair()
        local list = last_list(h)
        assert_eq(#list_paths(list), 2, "every generic name the native lookup reaches is listed")
        list.on_select(#list.items - 1)
        assert_false(exists(dir .. "/Music/Shared/cover.jpg"), "confirmed cover.jpg is moved")
        assert_eq(read_file(dir .. "/Music/Shared/cover.jpg.compas-backup"), "image:Music/Shared/cover.jpg",
            "backup keeps the original bytes")
        assert_eq(read_file(dir .. "/Music/Shared/folder.png.compas-backup"), "image:Music/Shared/folder.png",
            "second generic file is backed up too")
        assert_eq(read_file(dir .. "/Music/Shared/notes.txt"), "image:Music/Shared/notes.txt", "unrelated file is preserved")
        assert_eq(read_file(dir .. "/Music/Shared/Album Z.jpg"), "image:Music/Shared/Album Z.jpg",
            "album-specific sidecar is preserved")
        assert_true(has_toast(h, "Renamed 2"), "result is reported")
        assert_eq(h.library_refresh_count, 1, "renaming requests a library refresh")
        list.on_select(#list.items - 1)
        assert_eq(h.library_refresh_count, 1, "a repeated confirm tap does nothing")
    end

    do
        local h, M, dir = repair_setup("repair-existing-backup",
            { { "Music/Shared/a.flac", "Album A" }, { "Music/Shared/b.flac", "Album B" } },
            { "Music/Shared/cover.jpg", "Music/Shared/cover.jpg.compas-backup" })
        M.open_generic_repair()
        last_list(h).on_select(#last_list(h).items - 1)
        assert_eq(read_file(dir .. "/Music/Shared/cover.jpg.compas-backup"), "image:Music/Shared/cover.jpg.compas-backup",
            "existing backup is never overwritten")
        assert_eq(read_file(dir .. "/Music/Shared/cover.jpg.compas-backup-2"), "image:Music/Shared/cover.jpg",
            "next free backup name is used")
    end

    do
        local h, M, dir = repair_setup("repair-own-cover",
            { { "Music/Solo/a.flac", "Album A" } }, { "Music/Solo/cover.jpg" })
        M.open_generic_repair()
        assert_eq(#h.lists, 0, "generic art only this album uses is not offered")
        assert_true(has_toast(h, "No shared generic artwork"), "unshared art is explained")
        assert_true(exists(dir .. "/Music/Solo/cover.jpg"), "unshared art is untouched")
    end

    do
        local h, M, dir = repair_setup("repair-others-have-sidecars",
            { { "Music/Shared/a.flac", "Album A" }, { "Music/Shared/b.flac", "Album B" } },
            { "Music/Shared/cover.jpg", "Music/Shared/Album B.jpg" })
        M.open_generic_repair()
        assert_eq(#h.lists, 0, "generic art is not shared when every other album has its own sidecar")
        assert_true(exists(dir .. "/Music/Shared/cover.jpg"), "that generic art stays as this album's art")
    end

    do
        local h, M, dir = repair_setup("repair-album-named-cover",
            { { "Music/Shared/a.flac", "Album A" }, { "Music/Shared/b.flac", "Album B" },
              { "Music/Shared/c.flac", "Cover" } },
            { "Music/Shared/cover.jpg", "Music/Shared/folder.jpg" })
        M.open_generic_repair()
        local paths = list_paths(last_list(h))
        assert_eq(#paths, 1, "a file that is another album's own sidecar is not offered")
        assert_eq(paths[1], dir .. "/Music/Shared/folder.jpg", "only the truly generic file is listed")
        last_list(h).on_select(#last_list(h).items - 1)
        assert_eq(read_file(dir .. "/Music/Shared/cover.jpg"), "image:Music/Shared/cover.jpg",
            "album \"Cover\" keeps its sidecar")
    end

    do
        local h, M, dir = repair_setup("repair-own-sidecar",
            { { "Music/Shared/a.flac", "Album A" }, { "Music/Shared/b.flac", "Album B" } },
            { "Music/Shared/cover.jpg", "Music/Shared/Album A.png" })
        M.open_generic_repair()
        assert_eq(#h.lists, 0, "album with its own sidecar is not affected by generic art")
        assert_true(exists(dir .. "/Music/Shared/cover.jpg"), "generic art stays for other albums")
    end

    do
        local h, M, dir = repair_setup("repair-parent",
            { { "Music/Artist/A/a.flac", "Album A" }, { "Music/Artist/B/b.flac", "Album B" } },
            { "Music/Artist/folder.jpg" })
        M.open_generic_repair()
        local paths = list_paths(last_list(h))
        assert_eq(#paths, 1, "parent generic art reached by sibling albums is listed")
        assert_eq(paths[1], dir .. "/Music/Artist/folder.jpg", "parent path is exact")
    end

    do
        local h, M, dir = repair_setup("repair-parent-unshared",
            { { "Music/Artist/A/a.flac", "Album A" }, { "Music/Artist/B/b.flac", "Album B" } },
            { "Music/Artist/folder.jpg", "Music/Artist/B/Album B.jpg" })
        M.open_generic_repair()
        assert_eq(#h.lists, 0, "parent art no other album reaches is left alone")
    end

    do
        local h, M, dir = repair_setup("repair-local-and-parent",
            { { "Music/Mixed/a.flac", "Album A" }, { "Music/Mixed/b.flac", "Album B" },
              { "Music/Other/c.flac", "Album C" } },
            { "Music/Mixed/cover.jpg", "Music/folder.jpg" })
        M.open_generic_repair()
        local paths = list_paths(last_list(h))
        assert_eq(#paths, 2, "shared local and shared parent art are both listed")
        assert_eq(paths[1], dir .. "/Music/Mixed/cover.jpg", "local art is listed first, in native order")
        assert_eq(paths[2], dir .. "/Music/folder.jpg", "parent art follows")
    end

    do
        local h, M, dir = repair_setup("repair-sd-root",
            { { "Album/a.flac", "Album A" }, { "Other/b.flac", "Album B" } },
            { "cover.jpg" })
        M.open_generic_repair()
        assert_eq(#h.lists, 0, "art at the top of the card is never offered")
        assert_true(exists(dir .. "/cover.jpg"), "top-level art is untouched")
    end

    do
        local h, M, dir = repair_setup("repair-top-track",
            { { "a.flac", "Album A" }, { "b.flac", "Album B" } }, { "cover.jpg" })
        M.open_generic_repair()
        assert_eq(#h.lists, 0, "a track at the top of the card is refused")
        assert_true(has_toast(h, "top of the card"), "top-level refusal is explained")
    end

    do
        local h, M, dir = repair_setup("repair-directory-name",
            { { "Music/Shared/a.flac", "Album A" }, { "Music/Shared/b.flac", "Album B" } }, {})
        os.execute("mkdir -p '" .. dir .. "/Music/Shared/cover.jpg'")
        M.open_generic_repair()
        assert_eq(#h.lists, 0, "a folder named like artwork is not listed")
    end

    do
        local h, M, dir = repair_setup("repair-mismatch",
            { { "Music/Shared/a.flac", "Album A" }, { "Music/Shared/b.flac", "Album B" } },
            { "Music/Shared/cover.jpg" })
        h.now_playing = { "T1", "Someone", "Else", 180 }
        M.open_generic_repair()
        assert_eq(#h.lists, 0, "playback tags that differ from the index are refused")
    end

    do
        local h, M, dir = repair_setup("repair-vanished",
            { { "Music/Shared/a.flac", "Album A" }, { "Music/Shared/b.flac", "Album B" } },
            { "Music/Shared/cover.jpg" })
        M.open_generic_repair()
        os.remove(dir .. "/Music/Shared/cover.jpg")
        last_list(h).on_select(#last_list(h).items - 1)
        assert_false(exists(dir .. "/Music/Shared/cover.jpg.compas-backup"), "a vanished file creates no backup")
        assert_true(has_toast(h, "could not rename 1"), "vanished file is reported")
        assert_eq(h.library_refresh_count, 0, "nothing renamed, no refresh")
    end

    do
        local h, M, dir = repair_setup("repair-backup-race",
            { { "Music/Shared/a.flac", "Album A" }, { "Music/Shared/b.flac", "Album B" } },
            { "Music/Shared/cover.jpg" })
        M.open_generic_repair()
        write_file(dir .. "/Music/Shared/cover.jpg.compas-backup", "appeared")
        last_list(h).on_select(#last_list(h).items - 1)
        assert_eq(read_file(dir .. "/Music/Shared/cover.jpg.compas-backup"), "appeared",
            "a backup created after preview is not overwritten")
        assert_eq(read_file(dir .. "/Music/Shared/cover.jpg"), "image:Music/Shared/cover.jpg",
            "the original stays when its backup name is taken")
    end

    do
        local h, M, dir = repair_setup("repair-io-failure",
            { { "Music/Shared/a.flac", "Album A" }, { "Music/Shared/b.flac", "Album B" } },
            { "Music/Shared/cover.jpg" })
        M.open_generic_repair()
        os.execute("chmod 555 '" .. dir .. "/Music/Shared'")
        last_list(h).on_select(#last_list(h).items - 1)
        os.execute("chmod 755 '" .. dir .. "/Music/Shared'")
        assert_eq(read_file(dir .. "/Music/Shared/cover.jpg"), "image:Music/Shared/cover.jpg",
            "failed rename leaves the original bytes")
        assert_false(exists(dir .. "/Music/Shared/cover.jpg.compas-backup"), "failed rename leaves no backup")
        assert_true(has_toast(h, "could not rename 1"), "rename failure is reported")
    end

    do
        -- The repair is independent of an in-flight fetch and its captured target.
        local h, M, dest = setup(root .. "/repair-during-fetch", { defer_http = true })
        local shared = root .. "/repair-during-fetch/Music/Dummy"
        write_file(shared .. "/cover.jpg", "legacy")
        write_file(shared .. "/02.flac", "audio")
        h.songs[2] = { id = 2, path = shared .. "/02.flac", title = "Other", artist = "Other",
            album = "Other Album", album_artist = "Other" }
        M.fetch_current(false)
        M.open_generic_repair()
        last_list(h).on_select(#last_list(h).items - 1)
        h.flush()
        assert_true(exists(dest), "pending fetch still saves its album sidecar")
        assert_eq(read_file(shared .. "/cover.jpg.compas-backup"), "legacy", "repair renamed the shared cover")
        assert_eq(#image_gets(h), 1, "repair adds no network work")
    end
end
