local harness = require("harness")

local JPEG = string.char(0xFF, 0xD8, 0xFF, 0xE0) .. "fakejpeg"

local MB_OK = [[{
  "created": "2017-03-12T16:27:16.317Z",
  "count": 1,
  "offset": 0,
  "releases": [
    {
      "id": "76df3287-6cda-33eb-8e9a-044b5e15ffdd",
      "score": 100,
      "title": "Dummy",
      "status": "Official",
      "artist-credit": [{"name": "The Artist", "joinphrase": "", "artist": {"name": "The Artist"}}],
      "cover-art-archive": {"artwork": true, "count": 1, "front": true, "back": false}
    }
  ]
}]]

local MB_COLLISION = [[{
  "count": 2,
  "releases": [
    {
      "id": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
      "score": 100,
      "title": "Greatest Hits",
      "status": "Official",
      "artist-credit": [{"name": "Alpha", "artist": {"name": "Alpha"}}],
      "cover-art-archive": {"front": true, "count": 1}
    },
    {
      "id": "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb",
      "score": 99,
      "title": "Greatest Hits",
      "status": "Official",
      "artist-credit": [{"name": "Beta", "artist": {"name": "Beta"}}],
      "cover-art-archive": {"front": true, "count": 1}
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

local function router(kind)
    return function(options)
        local url = options.url
        local method = options.method or "GET"
        if url:find("musicbrainz.org", 1, true) then
            if kind == "offline" then return nil, nil, "dns_failure", nil end
            if kind == "collision" then return 200, MB_COLLISION, nil, {} end
            if kind == "nomatch" then
                return 200, '{"count":0,"releases":[]}', nil, {}
            end
            return 200, MB_OK, nil, {}
        end
        if url:find("coverartarchive.org/release/76df3287", 1, true) and url:sub(-1) == "/" then
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
        if method == "HEAD" then
            if kind == "headfail" then return nil, nil, "connect_failed", nil end
            if kind == "oversize" and url:find("archive.org", 1, true) then
                return 200, "", nil, { ["Content-Length"] = "3000000" }
            end
            if kind == "direct200" and url:find("archive.org", 1, true) then
                return 200, "", nil, { ["Content-Length"] = "4096" }
            end
            if kind == "tworedirect" then
                if url:find("coverartarchive.org", 1, true) and url:find("829521842-500.jpg", 1, true) then
                    return 307, "", nil, { Location = "front-500.jpg" }
                end
                if url:find("/front-500.jpg", 1, true) then
                    return 302, "", nil, { Location = ARCHIVE_500 }
                end
                if url:find("archive.org", 1, true) then
                    return 200, "", nil, { ["Content-Length"] = "4096" }
                end
            end
            if kind == "loop" then
                return 307, "", nil, { Location = url }
            end
            if kind == "toomany" then
                return 307, "", nil, { Location = url .. "/h" }
            end
            if kind == "invalid" then
                return 307, "", nil, { Location = "ftp://example.invalid/cover.jpg" }
            end
            if url:find("coverartarchive.org", 1, true) and url:find("829521842-500.jpg", 1, true) then
                return 307, "", nil, {
                    Location = "http://archive.org/download/mbid-76df3287-6cda-33eb-8e9a-044b5e15ffdd/mbid-76df3287-6cda-33eb-8e9a-044b5e15ffdd-829521842-500.jpg",
                }
            end
            if url:find("archive.org", 1, true) then
                return 200, "", nil, { ["Content-Length"] = "4096" }
            end
        end
        return 404, "", nil, {}
    end
end

local function setup(dir, extra)
    extra = extra or {}
    os.execute("mkdir -p '" .. dir .. "/.plugins' '" .. dir .. "/Music/Dummy'")
    local audio = dir .. "/Music/Dummy/01.flac"
    write_file(audio, "audio")
    local h = harness.new({
        sd_root = dir,
        defer_http = extra.defer_http,
        http_impl = extra.http_impl or router("ok"),
        download_impl = extra.download_impl or function(url, dest)
            if not url:match("^https://") then error("download URL must be https") end
            write_file(dest, JPEG)
            return dest, nil
        end,
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
    return h, M, dir .. "/Music/Dummy/cover.jpg", audio
end

return function(assert_eq, assert_true, assert_false)
    local root = assert(os.getenv("PWD")) .. "/build_test/plugin_example_tests/cover"
    os.execute("rm -rf '" .. root .. "' && mkdir -p '" .. root .. "'")

    do
        local h, M, dest = setup(root .. "/ok")
        M.fetch_current(false)
        local body = read_file(dest)
        assert_true(body ~= nil, "cover.jpg written")
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
        assert_eq(h.downloads[1].verify_tls, true, "tls on image")
        assert_true(h.downloads[1].dest:find("cover.jpg.compas-fetch", 1, true) ~= nil, "staging dest")
        local head_n, get_image = 0, 0
        for _, req in ipairs(h.http_calls) do
            if req.method == "HEAD" then head_n = head_n + 1 end
            if (req.method or "GET") == "GET" and req.url:find("-500.jpg", 1, true) then
                get_image = get_image + 1
            end
        end
        assert_true(head_n >= 1, "HEAD used to resolve image")
        assert_eq(get_image, 0, "image not fetched via capped GET")
    end

    do
        local h, M, dest = setup(root .. "/exists")
        write_file(dest, "already")
        M.fetch_current(false)
        assert_eq(read_file(dest), "already", "did not replace cover.jpg")
        assert_eq(#h.http_calls, 0, "no traffic when cover exists")
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
        -- pick_release must refuse when two different artists share the title
        -- in the payload even if our tags name one of them? Conservative:
        -- our tags are Alpha / Greatest Hits, only Alpha matches, Beta dropped.
        -- Strengthen: payload-only helper.
        local picked = M.pick_release(harness.decode_json(MB_COLLISION), "Unknown", "Greatest Hits", "")
        assert_eq(picked, nil, "do not pick an unrelated Greatest Hits")
        picked = M.pick_release(harness.decode_json(MB_COLLISION), "Alpha", "Greatest Hits", "Alpha")
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

    do
        local h, M, dest = setup(root .. "/stale", { defer_http = true })
        M.fetch_current(false)
        write_file(dest, "user-cover")
        h.flush()
        assert_eq(read_file(dest), "user-cover", "in-flight callback did not replace cover.jpg")
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

    local function run_resolve(dir, kind, start_url)
        local h, M, dest = setup(root .. "/" .. dir, { http_impl = router(kind) })
        M.pending_dest[dest] = 1
        M.resolve_and_download({ dest = dest, is_auto = false, key = "k" }, start_url, 1)
        return h, M, dest
    end

    do
        local h, M, dest = run_resolve("direct200", "direct200", ARCHIVE_500)
        assert_true(exists(dest), "HEAD 200 downloads resolved URL")
        assert_eq(#h.downloads, 1, "one download")
        assert_eq(h.downloads[1].url, ARCHIVE_500, "downloaded archive URL")
        for _, req in ipairs(h.http_calls) do
            if req.method == "HEAD" then
                assert_eq(req.redirect_limit, 0, "HEAD does not auto-follow")
            end
        end
    end

    do
        local h, M, dest = run_resolve("tworedirect", "tworedirect", CAA_500)
        assert_true(exists(dest), "two redirects then download")
        assert_eq(h.downloads[1].url, ARCHIVE_500, "final hop downloaded")
        local heads = 0
        for _, req in ipairs(h.http_calls) do
            if req.method == "HEAD" then heads = heads + 1 end
        end
        assert_eq(heads, 3, "HEAD at each hop including 200")
    end

    do
        local h, M, dest = run_resolve("loop", "loop", CAA_500_HTTPS)
        assert_false(exists(dest), "redirect loop writes nothing")
        assert_eq(#h.downloads, 0, "loop does not download")
    end

    do
        local h, M, dest = run_resolve("toomany", "toomany", CAA_500_HTTPS)
        assert_false(exists(dest), "too many redirects writes nothing")
        assert_eq(#h.downloads, 0, "too-many does not download")
        local heads = 0
        for _, req in ipairs(h.http_calls) do
            if req.method == "HEAD" then heads = heads + 1 end
        end
        assert_eq(heads, 6, "initial plus 5 hops")
    end

    do
        local h, M, dest = run_resolve("invalid", "invalid", CAA_500_HTTPS)
        assert_false(exists(dest), "invalid Location writes nothing")
        assert_eq(#h.downloads, 0, "invalid URL does not download")
    end

    do
        local h, M, dest = run_resolve("headfail", "headfail", ARCHIVE_500)
        assert_false(exists(dest), "HEAD failure writes nothing")
        assert_eq(#h.downloads, 0, "HEAD failure does not download")
    end

    do
        local h, M, dest = run_resolve("oversize", "oversize", ARCHIVE_500)
        assert_false(exists(dest), "explicit oversize rejected")
        assert_eq(#h.downloads, 0, "oversize does not start download")
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
        assert_eq(#h.downloads, 0, "no image download without front")
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
        assert_eq(#h.downloads, 0, "no download for remote://")
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
        assert_eq(job.album_artist, "", "unknown path leaves album_artist empty")
    end
end
