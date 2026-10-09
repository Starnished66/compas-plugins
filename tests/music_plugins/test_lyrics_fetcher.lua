local harness = require("harness")

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

local SYNCED = "[00:17.12] Synthetic first test line\n[00:21.00] Synthetic second test line\n"

local LRCLIB_OK = [[{
  "id": 3396226,
  "name": "I Want to Live",
  "trackName": "I Want to Live",
  "artistName": "Borislav Slavov",
  "albumName": "Baldur's Gate 3 (Original Game Soundtrack)",
  "duration": 233,
  "instrumental": false,
  "hasWordSync": false,
  "plainLyrics": "Synthetic first test line\n",
  "syncedLyrics": "[00:17.12] Synthetic first test line\n[00:21.00] Synthetic second test line\n",
  "lyricsfile": "version: '1.0'\n"
}]]

local function setup(dir, extra)
    extra = extra or {}
    os.execute("mkdir -p '" .. dir .. "/.plugins' '" .. dir .. "/Music/Album'")
    local h = harness.new({
        sd_root = dir,
        defer_http = extra.defer_http,
        http_impl = extra.http_impl,
    })
    local audio = dir .. "/Music/Album/track.flac"
    write_file(audio, "audio")
    h.current_path = audio
    h.now_playing = { "I Want to Live", "Borislav Slavov", "Baldur's Gate 3 (Original Game Soundtrack)", 233 }
    local M = h.load("plugins/LyricsFetcher/LyricsFetcher.lua")
    return h, M, audio, dir .. "/Music/Album/track.lrc"
end

return function(assert_eq, assert_true, assert_false)
    local root = assert(os.getenv("PWD")) .. "/build_test/plugin_example_tests/lyrics"
    os.execute("rm -rf '" .. root .. "' && mkdir -p '" .. root .. "'")

    -- sidecar naming matches lyrics_load_sidecar
    do
        local h, M = setup(root .. "/name")
        assert_eq(M.sidecar_path("/music/Album/song.flac"), "/music/Album/song.lrc", "replace extension")
        assert_eq(M.sidecar_path("/music/Album/song"), "/music/Album/song.lrc", "no extension")
        assert_eq(M.sidecar_path("/music/Album/song.with.dots.mp3"), "/music/Album/song.with.dots.lrc", "last extension")
        assert_eq(M.sidecar_path("https://example.com/x.mp3"), nil, "reject URL")
        assert_eq(M.sidecar_path("http://example.com/x.mp3"), nil, "reject http URL")
        assert_eq(M.sidecar_path("remote://qobuz/12345"), nil, "reject remote://")
        assert_eq(M.sidecar_path("ftp://host/x.mp3"), nil, "reject other schemes")
        assert_eq(M.sidecar_path("Album/song.flac"), nil, "reject relative")
        assert_true(M.is_absolute_local_path("/music/Album/song.flac"), "absolute local")
        assert_true(not M.is_absolute_local_path("remote://qobuz/1"), "remote not local")
    end

    -- success: writes LRC text, not the JSON body
    do
        local h, M, audio, dest = setup(root .. "/ok", {
            http_impl = function() return 200, LRCLIB_OK, nil, { ["Content-Type"] = "application/json" } end,
        })
        M.fetch_current(false)
        local body = read_file(dest)
        assert_true(body ~= nil, "sidecar created")
        assert_true(body:find("%[00:17.12%]", 1, false) ~= nil, "synced line saved")
        assert_true(not body:find('"syncedLyrics"', 1, true), "did not save JSON")
        assert_true(body:find("\n", 1, true) ~= nil, "kept newlines")
        assert_eq(#h.http_calls, 1, "one request")
        assert_true(h.http_calls[1].verify_tls == true, "tls verified")
        assert_true(h.http_calls[1].url:find("lrclib.net/api/get", 1, true) ~= nil, "lrclib get")
        assert_true(h.http_calls[1].url:find("track_name=", 1, true) ~= nil, "encoded title")
    end

    -- existing sidecar is not replaced
    do
        local h, M, audio, dest = setup(root .. "/exists", {
            http_impl = function() return 200, LRCLIB_OK, nil, {} end,
        })
        write_file(dest, "[00:00.00] original\n")
        M.fetch_current(false)
        assert_eq(read_file(dest), "[00:00.00] original\n", "kept original")
        assert_eq(#h.http_calls, 0, "no request when sidecar exists")
    end

    -- 404 / instrumental / no-sync / network do not create a file
    local function expect_no_file(name, http_impl)
        local h, M, audio, dest = setup(root .. "/" .. name, { http_impl = http_impl })
        M.fetch_current(false)
        assert_eq(read_file(dest), nil, name .. " must not write .lrc")
    end
    expect_no_file("offline", function() return nil, nil, "timeout", nil end)
    expect_no_file("nomatch", function() return 404, '{"message":"Failed to find specified track","name":"TrackNotFound","statusCode":404}', nil, {} end)
    expect_no_file("instrumental", function()
        return 200, '{"id":1,"instrumental":true,"syncedLyrics":null,"plainLyrics":null}', nil, {}
    end)
    expect_no_file("nosync", function()
        return 200, '{"id":1,"instrumental":false,"syncedLyrics":null,"plainLyrics":"unsynced"}', nil, {}
    end)
    expect_no_file("empty-sync", function()
        return 200, '{"id":1,"instrumental":false,"syncedLyrics":"no timestamps here","plainLyrics":"x"}', nil, {}
    end)

    -- streams and remote:// are not treated as filesystem paths
    do
        local h, M = setup(root .. "/stream", {
            http_impl = function() error("should not request") end,
        })
        h.current_path = "https://radio.example/stream.mp3"
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "no fetch for URL")
    end

    do
        local h, M, audio, dest = setup(root .. "/remote", {
            http_impl = function() error("should not request remote://") end,
        })
        h.current_path = "remote://qobuz/3396226"
        h.now_playing = { "I Want to Live", "Borislav Slavov", "OST", 233 }
        M.fetch_current(false)
        assert_eq(#h.http_calls, 0, "no request for remote://")
        assert_eq(read_file(dest), nil, "no sidecar write for remote://")
    end

    -- duplicate in-flight requests
    do
        local h, M, audio, dest = setup(root .. "/dup", {
            defer_http = true,
            http_impl = function() return 200, LRCLIB_OK, nil, {} end,
        })
        M.fetch_current(false)
        M.fetch_current(false)
        assert_eq(#h.http_calls, 1, "deduped while pending")
        h.flush()
        assert_true(read_file(dest) ~= nil, "completed once")
    end

    -- stale callback after the track changed must not write the old dest
    do
        local h, M, audio, dest = setup(root .. "/stale", {
            defer_http = true,
            http_impl = function() return 200, LRCLIB_OK, nil, {} end,
        })
        M.fetch_current(false)
        h.current_path = root .. "/stale/Music/Album/other.flac"
        write_file(h.current_path, "x")
        h.flush()
        assert_eq(read_file(dest), nil, "stale callback did not write")
    end

    -- extract_synced rejects JSON-shaped records without LRC
    do
        local h, M = setup(root .. "/extract")
        local lrc, why = M.extract_synced({ instrumental = true, syncedLyrics = "[00:00.00] x" })
        assert_eq(lrc, nil, "instrumental")
        assert_eq(why, "instrumental", "instrumental reason")
        lrc, why = M.extract_synced({ syncedLyrics = SYNCED })
        assert_true(lrc:find("Synthetic first", 1, true) ~= nil, "extracted lrc")
    end
end
