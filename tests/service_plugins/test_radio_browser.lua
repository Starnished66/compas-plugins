local harness = require("service_harness")

local PLUGIN = "plugins/RadioBrowser/RadioBrowser.lua"
local UUID = "12345678-1234-1234-1234-123456789abc"

local function read_file(path)
    local file = io.open(path, "rb")
    if not file then return nil end
    local body = file:read("*a")
    file:close()
    return body
end

local function write_file(path, body)
    local file = assert(io.open(path, "wb"))
    file:write(body)
    file:close()
end

local function station(name, codec, extra)
    extra = extra or {}
    return {
        name = name,
        codec = codec,
        hls = extra.hls or 0,
        url = extra.url or "https://fallback.example/should-not-play",
        url_resolved = extra.url_resolved,
        stationuuid = extra.uuid or UUID,
    }
end

local function page(count, prefix)
    local rows = {}
    for index = 1, count do
        rows[index] = station(prefix .. " " .. index, "MP3", {
            url_resolved = "https://cdn.example/" .. prefix .. "/" .. index .. ".mp3",
            uuid = UUID,
        })
    end
    return rows
end

return function(assert_eq, assert_true, assert_false)
    local root = "build_test/service_plugin_tests/radio"
    os.execute("rm -rf '" .. root .. "' && mkdir -p '" .. root .. "'")

    local function boot(dir)
        os.execute("mkdir -p '" .. dir .. "'")
        local h = harness.new({ sd_root = dir })
        local api = h.load(PLUGIN)
        return h, api, dir .. "/Radio.txt"
    end

    do
        local h, api = boot(root .. "/search")
        assert_eq(h.definition.id, "compas.radio_browser", "plugin id")
        assert_eq(h.definition.api_min, 15, "api_min 15")
        assert_eq(h.tiles[1].label, "Radio Browser", "stream media tile")
        api.search("rock & roll", 0)
        assert_eq(h.http_calls[1].options.url, "https://de1.api.radio-browser.info/json/servers", "discovery URL")
        assert_eq(h.http_calls[1].options.method, "GET", "discovery GET")
        local search = h.http_calls[2].options
        assert_eq(search.method, "POST", "bounded search is POST")
        assert_eq(search.url, "https://de1.api.radio-browser.info/json/stations/search", "search URL")
        assert_eq(search.body, "name=rock%20%26%20roll&limit=20&offset=0&hidebroken=true&order=name", "encoded search body")
        assert_true(not search.body:find("100000", 1, true), "search does not ask for the whole catalog")
        assert_true(not search.url:find("/json/stations/all", 1, true), "search is not the all-stations endpoint")
        assert_eq(search.headers["User-Agent"], "Compas/1.0", "search user agent")
        assert_eq(search.verify_tls, true, "search verifies TLS")
        assert_eq(search.redirect_limit, 0, "search does not follow redirects")
        assert_eq(search.max_response_bytes, 65536, "search body is bounded")
        assert_true(search.url:sub(1, 8) == "https://", "search uses HTTPS")
        assert_eq(api.search("", 0), nil, "empty query does not search")
        assert_true(table.concat(h.toasts, "\n"):find("Enter a station name", 1, true) ~= nil, "empty query toast")
    end

    do
        local _, api = boot(root .. "/codec")
        local flac = api.playable_url(station("FLAC", "FLAC", {
            url_resolved = "https://cdn.example/live?token=abc",
        }))
        assert_eq(flac, "https://cdn.example/live?token=abc#.flac", "FLAC hint keeps the query")
        assert_eq(api.playable_url(station("AAC", "AAC", {
            url_resolved = "https://cdn.example/aac?id=1",
        })), "https://cdn.example/aac?id=1#.aac", "AAC hint")
        assert_eq(api.playable_url(station("Plus", "AAC+", {
            url_resolved = "https://cdn.example/plus?id=1",
        })), "https://cdn.example/plus?id=1#.aacp", "AAC+ hint")
        assert_eq(api.playable_url(station("MP3", "MP3", {
            url_resolved = "https://cdn.example/mp3?id=1",
        })), "https://cdn.example/mp3?id=1", "MP3 has no fragment")
        assert_eq(api.playable_url(station("Broken", "MP3", {
            url_resolved = "https://cdn.example/playlist.m3u8",
            url = "https://cdn.example/direct.mp3?x=1",
        })), "https://cdn.example/direct.mp3?x=1", "invalid resolved URL falls back to url")
        assert_eq(api.playable_url(station("HLS off", "MP3", {
            hls = 0, url_resolved = "https://cdn.example/plain",
        })), "https://cdn.example/plain", "hls 0 stays playable")
        assert_eq(api.playable_url(station("HLS on", "MP3", {
            hls = 1, url_resolved = "https://cdn.example/plain",
        })), nil, "hls 1 is not played")
        assert_eq(api.playable_url(station("HLS text", "MP3", {
            hls = "1", url_resolved = "https://cdn.example/plain",
        })), nil, "hls string 1 is not played")
        assert_eq(api.playable_url(station("Playlist", "MP3", {
            url = "https://cdn.example/list.pls",
            url_resolved = "https://cdn.example/list.pls",
        })), nil, "PLS is not played")
        assert_eq(api.playable_url(station("Ogg", "OGG", {
            url = "https://cdn.example/stream",
            url_resolved = "https://cdn.example/stream",
        })), nil, "OGG codec is not played")
        assert_eq(api.playable_url(station("Wav path", "MP3", {
            url = "https://cdn.example/stream.wav",
            url_resolved = "https://cdn.example/stream.wav",
        })), nil, "WAV path is not played")
        assert_eq(api.playable_url(station("Newline", "MP3", {
            url = "https://cdn.example/a\nhttps://evil.example/b",
            url_resolved = "https://cdn.example/a\nhttps://evil.example/b",
        })), nil, "newline in a stream URL is rejected")
        assert_eq(api.playable_url(station("Pipe", "MP3", {
            url = "https://cdn.example/a|https://evil.example/b",
            url_resolved = "https://cdn.example/a|https://evil.example/b",
        })), nil, "pipe in a stream URL is rejected")
        assert_eq(api.playable_url(station("Query host", "MP3", {
            url = "https://?x=1",
            url_resolved = "https://?x=1",
        })), nil, "empty host is rejected")
        assert_eq(api.playable_url(station("Fragment host", "MP3", {
            url = "https://#station",
            url_resolved = "https://#station",
        })), nil, "fragment without a host is rejected")
        assert_eq(api.playable_url(station("Userinfo", "MP3", {
            url = "https://user:pass@cdn.example/live",
            url_resolved = "https://user:pass@cdn.example/live",
        })), nil, "userinfo is rejected")
        assert_eq(api.playable_url(station("Port", "MP3", {
            url_resolved = "https://cdn.example:8443/live?token=abc",
        })), "https://cdn.example:8443/live?token=abc", "host, port and query stay playable")
        local prefix = "https://h.example/a?"
        local function with_query(total)
            return prefix .. string.rep("q", total - #prefix)
        end
        assert_eq(#with_query(511), 511, "511-byte fixture")
        assert_eq(api.playable_url(station("Edge", "MP3", { url_resolved = with_query(511) })),
            with_query(511), "511-byte MP3 URL is playable")
        assert_eq(api.playable_url(station("Over", "MP3", {
            url = with_query(512), url_resolved = with_query(512),
        })), nil, "512-byte URL is not playable")
        assert_eq(api.playable_url(station("Flac edge", "FLAC", { url_resolved = with_query(505) })),
            with_query(505) .. "#.flac", "FLAC hint fits in 511 bytes")
        assert_eq(#(with_query(505) .. "#.flac"), 511, "hinted FLAC boundary")
        assert_eq(api.playable_url(station("Flac over", "FLAC", { url_resolved = with_query(506) })),
            nil, "FLAC hint that exceeds 511 is rejected")
        assert_eq(api.canonical_url("HTTPS://CDN.Example:443/live?x=1#.flac"),
            "https://cdn.example/live?x=1", "canonical URL ignores case, port and hint")
        assert_eq(api.sanitize_name("Bad\r\nEvil | http://injected.example/x"),
            "Bad Evil http://injected.example/x", "names cannot inject a record")
    end

    do
        local h, api = boot(root .. "/page")
        api.search("alpha", 0)
        local discovery, first = 1, 2
        h.reply(discovery, 200, '[{"name":"evil.example.com"},{"name":"../../etc"},{"name":"de2.api.radio-browser.info"},{"name":"api.radio-browser.info"}]')
        h.reply(first, 200, harness.encode_json(page(20, "Alpha")))
        local listed = h.lists[#h.lists]
        assert_eq(listed.title, "Stations", "first page is shown")
        assert_eq(listed.items[21], "Next page", "full page offers the next page")
        assert_eq(#listed.items, 21, "page size stays at 20 stations")
        listed.on_select(21)
        local second = #h.http_calls
        assert_eq(h.http_calls[second].options.body:match("offset=(%d+)"), "20", "next page offset is 20")
        api.search("beta", 0)
        h.reply(second, 200, harness.encode_json(page(20, "Stale")))
        local titles = {}
        for _, list in ipairs(h.lists) do titles[#titles + 1] = table.concat(list.items, "|") end
        assert_true(not table.concat(titles, "\n"):find("Stale", 1, true), "stale page is ignored")
        local beta = #h.http_calls
        h.reply(beta, 200, harness.encode_json({ station("Beta Hit", "MP3", {
            url_resolved = "https://cdn.example/beta.mp3",
        }) }))
        local fresh = h.lists[#h.lists]
        assert_eq(fresh.items[1], "Beta Hit", "newest search replaces the page")
        fresh.on_select(1)
        local action = h.lists[#h.lists]
        assert_eq(action.items[1], "Play", "station offers play")
        action.on_select(1)
        assert_eq(h.play_lists[#h.play_lists].paths[1], "https://cdn.example/beta.mp3", "play uses the direct URL")
        local click = h.http_calls[#h.http_calls].options
        assert_eq(click.method, "GET", "click report is GET")
        assert_eq(click.url, "https://de2.api.radio-browser.info/json/url/" .. UUID, "click uses the discovered server")
        assert_true(h.play_lists[#h.play_lists].paths[1] ~= click.url, "playback does not wait on the click URL")
        api.search("gamma", 0)
        local gamma = #h.http_calls
        assert_true(h.http_calls[gamma].options.url:find("https://de2.api.radio-browser.info/", 1, true) == 1,
            "later search prefers the verified discovered host")
        for _, call in ipairs(h.http_calls) do
            assert_true(not call.options.url:find("evil.example", 1, true), "discovered arbitrary hosts are ignored")
            assert_true(not call.options.url:find("https://api.radio-browser.info/", 1, true),
                "directory host is not a station backend")
        end
    end

    do
        local h, api = boot(root .. "/fail")
        api.search("news", 0)
        h.reply(2, 503, "unavailable")
        assert_true(h.http_calls[3].options.url:find("https://all.api.radio-browser.info/json/stations/search", 1, true) == 1,
            "503 fails over to the next backend")
        h.reply(3, 200, harness.encode_json({ station("News One", "AAC", {
            url_resolved = "https://cdn.example/news?id=9",
        }) }))
        assert_eq(h.lists[#h.lists].items[1], "News One", "failover result is shown")
        h.lists[#h.lists].on_select(1)
        h.lists[#h.lists].on_select(1)
        assert_eq(h.play_lists[#h.play_lists].paths[1], "https://cdn.example/news?id=9#.aac", "AAC station plays with a hint")
        api.search("down", 0)
        local start = #h.http_calls
        h.reply(start, 503, "")
        h.reply(start + 1, 500, "")
        assert_eq(#h.http_calls, start + 1, "failover stops after the backend list")
        assert_true(table.concat(h.toasts, "\n"):find("Could not reach Radio Browser", 1, true) ~= nil,
            "exhausted backends explain the failure")
        api.search("bad-json", 0)
        local bad = #h.http_calls
        h.reply(bad, 200, "{")
        h.reply(bad + 1, 200, "null")
        assert_true(table.concat(h.toasts, "\n"):find("Could not read station results", 1, true) ~= nil,
            "invalid JSON is explained")
    end

    do
        local h, api, path = boot(root .. "/favorites")
        local original = "# comment stays\nCustom | http://custom.example/a.mp3\nhttp://only.example/b\nNo final newline"
        write_file(path, original)
        assert_eq(api.append_favorite("Jazz FM", "http://play.example/live.mp3"), true, "favorite appends")
        local saved = read_file(path)
        assert_eq(saved:sub(1, #original), original, "existing Radio.txt bytes are preserved")
        assert_eq(saved:sub(#original + 1), "\nJazz FM | http://play.example/live.mp3\n", "missing newline is added before the new record")
        local before = read_file(path)
        assert_eq(api.append_favorite("Bad\r\nEvil | http://injected.example/x", "https://CDN.Example:443/live.mp3?x=1#.aac"), true,
            "sanitized favorite appends")
        local injected = read_file(path)
        local labels, urls = api.parse_stations(injected)
        assert_eq(#urls, 4, "injection stays one record")
        for _, url in ipairs(urls) do
            assert_true(not url:find("injected.example", 1, true), "station name cannot add a URL")
            assert_true(not url:find("\n", 1, true), "saved URLs stay on one line")
        end
        assert_eq(labels[4], "Bad Evil http://injected.example/x", "sanitized favorite name")
        local untouched = read_file(path)
        assert_eq(api.append_favorite("Nope", "http://play.example/evil\nhttp://other.example/a"), false, "newline URL is rejected")
        assert_eq(read_file(path), untouched, "rejected URL does not change Radio.txt")
        assert_eq(api.append_favorite("Again", "https://cdn.example/live.mp3?x=1"), true, "same stream is a duplicate")
        assert_true(table.concat(h.toasts, "\n"):find("Already in Radio.txt", 1, true) ~= nil, "duplicate toast")
        assert_eq(read_file(path), untouched, "duplicate does not append")
        local calls = #h.http_calls
        api.open_favorites()
        local favorites = h.lists[#h.lists]
        assert_eq(favorites.items[1], "Custom", "comments are hidden and custom names remain")
        assert_eq(favorites.items[2], "http://only.example/b", "URL-only line stays playable")
        favorites.on_select(2)
        assert_eq(h.play_lists[#h.play_lists].paths[1], "http://only.example/b", "offline favorite plays the saved URL")
        favorites.on_select(4)
        assert_eq(h.play_lists[#h.play_lists].paths[1], "https://CDN.Example:443/live.mp3?x=1#.aac",
            "saved hint and query are kept")
        assert_eq(#h.http_calls, calls, "favorite playback does not use the network")
        assert_eq(#h.play_lists, 2, "both saved entries played")
    end

    do
        local h, api, path = boot(root .. "/beyond-500")
        local lines = {}
        for index = 1, 500 do
            lines[index] = string.format("S%03d | http://e/%d\n", index, index)
        end
        lines[501] = "Dup | http://e/dup\n"
        local original = table.concat(lines)
        write_file(path, original)
        local _, visible = api.parse_stations(original)
        assert_eq(#visible, 500, "the favorites screen stays capped at 500")
        assert_eq(api.append_favorite("Other", "http://e/dup"), true, "duplicate past 500 is recognized")
        assert_eq(read_file(path), original, "duplicate past 500 does not append")
        assert_true(table.concat(h.toasts, "\n"):find("Already in Radio.txt", 1, true) ~= nil, "past-500 duplicate toast")
    end

    do
        local h, api, path = boot(root .. "/append-error")
        write_file(path, "keep\n")
        local modes = {}
        local real_open = io.open
        h.io.open = function(target, mode)
            modes[#modes + 1] = mode
            if mode == "r+b" or mode == "wb" or mode == "w" then return nil end
            return real_open(target, mode)
        end
        assert_eq(api.append_favorite("X", "http://x.example/a"), false, "unwritable existing file is not replaced")
        local saw_write = false
        for _, mode in ipairs(modes) do
            if mode == "wb" or mode == "w" then saw_write = true end
        end
        assert_false(saw_write, "failed r+b does not open wb")
        assert_eq(read_file(path), "keep\n", "failed update preserves every byte")
        assert_true(table.concat(h.toasts, "\n"):find("Could not save that station", 1, true) ~= nil, "update failure is reported")
    end

    do
        local _, api, path = boot(root .. "/oversize")
        local original = string.rep("a", 65530)
        write_file(path, original)
        assert_eq(api.append_favorite("N", "http://n.example/a"), false, "missing newline that would pass 65536 is rejected")
        assert_eq(read_file(path), original, "rejected append does not add the newline")
        local line = "N | http://n.example/a\n"
        local over = string.rep("b", 65536 - #line)
        write_file(path, over)
        assert_eq(#over + 1 + #line, 65537, "one-byte-over fixture")
        assert_eq(api.append_favorite("N", "http://n.example/a"), false, "one byte over the cap is rejected")
        assert_eq(read_file(path), over, "oversize file is unchanged")
        local room = string.rep("c", 65536 - #line - 1)
        write_file(path, room)
        assert_eq(#room + 1 + #line, 65536, "exact-fit fixture includes the added newline")
        assert_eq(api.append_favorite("N", "http://n.example/a"), true, "append that lands on 65536 is kept")
        local saved = read_file(path)
        assert_eq(#saved, 65536, "saved file is exactly 65536 bytes")
        assert_eq(saved:sub(1, #room), room, "exact append keeps the original bytes")
    end

    do
        local _, api, path = boot(root .. "/create")
        assert_eq(api.append_favorite("Created", "http://created.example/a.mp3"), true, "missing Radio.txt is created")
        assert_eq(read_file(path), "Created | http://created.example/a.mp3\n", "new favorite file has one record")
        local long_url = "https://h.example/a?" .. string.rep("q", 512 - #"https://h.example/a?")
        assert_eq(#long_url, 512, "512-byte save fixture")
        assert_eq(api.append_favorite("Too long", long_url), false, "512-byte URL is not saved")
        assert_eq(read_file(path), "Created | http://created.example/a.mp3\n", "rejected long URL leaves the file")
    end
    do
        local h, api, path = boot(root .. "/unreadable")
        write_file(path, "keep every byte\n")
        local real_open, truncating = io.open, false
        h.io.open = function(target, mode)
            if target == path and (mode == "r+b" or mode == "rb") then
                return nil, "Permission denied", 13
            end
            if target == path and mode == "wb" then truncating = true end
            return real_open(target, mode)
        end
        assert_eq(api.append_favorite("X", "http://x.example/a"), false, "unreadable writable file is preserved")
        assert_false(truncating, "read failure never falls back to truncation")
        assert_eq(read_file(path), "keep every byte\n", "unreadable favorite file stays unchanged")
    end

    do
        local h, api, path = boot(root .. "/long-existing-favorite")
        write_file(path, "Long | https://h.example/" .. string.rep("x", 512) .. "\n")
        api.open_favorites()
        h.lists[#h.lists].on_select(1)
        assert_eq(#h.play_lists, 0, "pre-existing long URL cannot reach truncating native API")
    end

    do
        local h, api = boot(root .. "/discovery-fallback")
        api.search("jazz", 0)
        h.reply(1, 200, harness.encode_json({ { name = "de1.api.radio-browser.info" } }))
        h.reply(2, 503, "")
        assert_eq(h.http_calls[3].options.url, "https://all.api.radio-browser.info/json/stations/search",
            "single-host discovery preserves the public DNS pool fallback")
    end

    do
        local h, api = boot(root .. "/discovered-pool-fallback")
        api.search("first", 0)
        local mirrors = {}
        for i = 1, 4 do mirrors[i] = { name = "test" .. i .. ".api.radio-browser.info" } end
        h.reply(1, 200, harness.encode_json(mirrors))
        h.reply(2, 503, "")
        assert_eq(h.http_calls[3].options.url, "https://all.api.radio-browser.info/json/stations/search",
            "discovery does not reshuffle an active retry")
        h.reply(3, 200, "[]")
        api.search("later", 0)
        local start = #h.http_calls
        for i = 0, 2 do h.reply(start + i, 503, "") end
        assert_eq(h.http_calls[start + 3].options.url, "https://all.api.radio-browser.info/json/stations/search",
            "DNS pool fallback is reachable after discovered mirrors fail")
        h.reply(start + 3, 200, "[]")
        assert_eq(#h.http_calls, start + 3, "server retry count stays bounded at four")
    end

end
