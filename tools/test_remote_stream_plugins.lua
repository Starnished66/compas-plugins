-- Host-level contract tests for Qobuz and Tidal on-demand queues.
-- These compile the production queue and event-handler blocks with mocked plugin APIs.
local function read(path)
    local file = assert(io.open(path, "rb"))
    local source = file:read("*a")
    file:close()
    return source
end

local function between(source, start_marker, end_marker)
    local first = assert(source:find(start_marker, 1, true), "missing " .. start_marker)
    local after = assert(source:find(end_marker, first + #start_marker, true), "missing " .. end_marker)
    return source:sub(first, after - 1)
end

local function compile(source, environment, label)
    local chunk, err = load(source, label, "t", environment)
    assert(chunk, err)
    return chunk()
end

local function check(condition, message)
    if not condition then error(message, 2) end
end

local function run_service(name, provider, resolver_name)
    local source = read("plugins/" .. name .. "/" .. name .. ".lua")
    check(source:match("api_min = 17"), name .. " requires API 17")
    check(source:find('local ON_DEMAND = plugin.has_capability("playback.remote_resolve")', 1, true),
          name .. " detects on-demand links")
    check(source:find('if ON_DEMAND then plugin.on("remote_stream_needed"', 1, true),
          name .. " registers its resolver only where the player has the event")
    check(source:find("local EAGER_QUEUE_CAP = 12", 1, true) and source:find("local function play_these_eager(", 1, true),
          name .. " keeps the short eager queue for older players")
    check(not source:find("Update the player", 1, true), name .. " no longer refuses older players")

    local queue_source = between(source, "local function queue_on_demand(", "local function play_these(")
    local event_source = between(source, "local function error_reason(", "local function queue_on_demand(")
    local resolver_calls = 0
    local stream_results = {}
    local captured_event
    local queued
    local http_calls = 0
    local supplied
    local resolver_error
    local env = {
        ipairs = ipairs, pairs = pairs, tostring = tostring, tonumber = tonumber,
        math = math, table = table, type = type,
        clip_utf8 = function(value) return value end,
        REMOTE_QUEUE_CAP = 500,
        BROWSE_CAP = 475,
        TRACK_FETCH_CAP = 500,
        PAGE = 25,
        browse_generation = 1,
        parent_showing = function() return true end,
        items_of = function(data) return data.items or data.tracks or data end,
        album_from = function(album) return album end,
        track_rows = function(list) return list end,
        country = function() return "US" end,
        url_encode = function(value) return tostring(value) end,
        playback_generation = 0,
        toast = function() end,
        ON_DEMAND = true,
        plugin = {
            has_capability = function(key) return key == "playback.remote_resolve" end,
            on = function(event, callback)
                if event == "remote_stream_needed" then captured_event = callback end
            end,
            queue_remote_list = function(items, start) queued = { items = items, start = start } end,
            provide_remote_stream = function(request_id, payload) supplied = { request_id, payload } end,
            http_request = function() http_calls = http_calls + 1 end,
        },
    }
    env[resolver_name] = function(track, callback)
        resolver_calls = resolver_calls + 1
        http_calls = http_calls + 1
        callback(stream_results[track.id], stream_results[track.id] and nil or (resolver_error or "mock resolver error"))
    end

    local queue_fn = compile(queue_source .. "\nreturn queue_on_demand", env, name .. " queue")
    compile(event_source .. "\nreturn true", env, name .. " event")
    check(type(captured_event) == "function", name .. " registers its API 17 remote event")

    local tracks = {}
    for i = 1, 510 do
        tracks[i] = { id = tostring(i), title = "Track " .. i, artist = "Artist", album = "Album", duration = 123, cover = "art", sample_rate = 96000, bit_depth = 24, channels = 2, bitrate_kbps = 1800, replaygain_db = -4.5, verify_tls = false, codec = "flac", streamable = i ~= 3 }
    end
    queue_fn(tracks, 8, true)
    check(queued and #queued.items == 500, name .. " caps on-demand queue at 500 streamable tracks")
    check(queued.items[1].track_id == "8", name .. " puts selected track first")
    check(queued.items[2].track_id == "9", name .. " preserves following order")
    check(queued.items[1].stream_url == nil, name .. " does not queue a pre-resolved URL")
    check(queued.items[1].duration_ms == 123000 and queued.items[1].artwork_url == "art", name .. " preserves queue metadata")
    check(queued.items[1].sample_rate == 96000 and queued.items[1].bit_depth == 24 and queued.items[1].channels == 2, name .. " preserves audio metadata")
    check(queued.items[1].bitrate_kbps == 1800 and queued.items[1].replaygain_db == -4.5 and queued.items[1].verify_tls == false, name .. " preserves optional metadata")
    check(queued.items[1].codec == "flac", name .. " preserves valid codec")
    check(resolver_calls == 0 and http_calls == 0, name .. " makes no upfront stream request")

    captured_event("other-provider", "8", "foreign")
    check(resolver_calls == 0 and supplied == nil, name .. " ignores foreign provider")
    stream_results["8"] = { stream_url = "https://stream.invalid/8", codec = "flac", sample_rate = 44100, bit_depth = 16 }
    captured_event(provider, "8", "success")
    check(resolver_calls == 1 and supplied[1] == "success", name .. " resolves asynchronously on event")
    check(supplied[2].stream_url == "https://stream.invalid/8" and supplied[2].url_ttl_s == 60, name .. " supplies stream URL and TTL")
    captured_event(provider, "9", "failure")
    check(supplied[1] == "failure" and supplied[2].error == "mock resolver error" and supplied[2].reason == nil,
          name .. " supplies resolver errors")
    resolver_error = "Not in this subscription"
    captured_event(provider, "10", "subscription")
    check(supplied[2].reason == "subscription", name .. " maps errors to player reason codes")
    resolver_error = nil
    stream_results["900"] = { stream_url = "https://stream.invalid/900" }
    captured_event(provider, "900", "after-reload")
    check(supplied[1] == "after-reload" and supplied[2].stream_url == "https://stream.invalid/900",
          name .. " resolves a track it did not queue, as after a plugin reload")

    local short = {}
    for i = 1, 10 do short[i] = { id = tostring(i), streamable = i ~= 8 } end
    queue_fn(short, 5, true)
    check(#queued.items == 9 and queued.items[1].track_id == "5", name .. " starts selected middle track")
    check(queued.items[5].track_id == "10" and queued.items[6].track_id == "1" and queued.items[9].track_id == "4", name .. " wraps through earlier tracks")

    -- Compile and exercise the production album/playlist page walkers with mocked transport.
    local function pagination_test(kind)
        local end_marker = kind == "album" and "local function open_playlist(" or (name == "Tidal" and "local function fetch_pages(" or "local function show_albums(")
        local start_marker = "local function open_" .. kind .. "("
        local page_source = between(source, start_marker, end_marker)
        local calls, captured = 0, nil
        local page_env = {}
        for key, value in pairs(env) do page_env[key] = value end
        page_env.browse_generation = 1
        page_env.plugin = { is_list_showing = function() return true end }
        page_env.show_tracks = function(_, rows) captured = rows end
        page_env.track_rows = function(list) return list end
        local function page_at(offset)
            calls = calls + 1
            local items = {}
            for id = offset + 1, math.min(offset + 25, 500) do
                items[#items + 1] = { id = tostring(id), streamable = true, title = "Track " .. id }
            end
            return items
        end
        if name == "Qobuz" then
            page_env.qobuz_get = function(path, _, callback)
                local offset = tonumber(path:match("offset=(%d+)")) or 0
                callback({ tracks = page_at(offset) })
            end
        else
            page_env.tidal_get = function(path, callback)
                local offset = tonumber(path:match("offset=(%d+)")) or 0
                callback({ items = page_at(offset) })
            end
        end
        local open = compile(page_source .. "\nreturn open_" .. kind, page_env, name .. " " .. kind .. " pagination")
        if kind == "album" then
            open({ id = "collection", title = "Collection", count = 500 }, 0, 2)
        else
            open({ id = "collection", name = "Collection", title = "Collection", count = 500 }, 0, 2)
        end
        check(calls == 20 and captured and #captured == 500, name .. " fetches collection pages through track 500")
        queue_fn(captured, 250, true)
        check(#queued.items == 500 and queued.items[1].track_id == "250" and queued.items[252].track_id == "1", name .. " queues the full fetched collection selected-first")
    end
    pagination_test("album")
    pagination_test("playlist")

    local play_source = between(source, "\nlocal function play_these(", "local function track_rows(")
    env.queue_on_demand = queue_fn
    local play_fn = compile(play_source .. "\nreturn play_these", env, name .. " play_these")
    queued = nil
    local eager_calls = 0
    env.play_these_eager = function() eager_calls = eager_calls + 1 end
    if name == "Qobuz" then play_fn(tracks, 8) else play_fn(tracks, true, 8) end
    check(queued and #queued.items == 500 and queued.items[1].track_id == "8" and eager_calls == 0,
          name .. " routes playback through the lazy queue on current players")
    env.ON_DEMAND = false
    queued = nil
    if name == "Qobuz" then play_fn(tracks, 8) else play_fn(tracks, true, 8) end
    check(queued == nil and eager_calls == 1, name .. " uses the eager queue on older players")
end

run_service("Qobuz", "qobuz", "file_url")
run_service("Tidal", "tidal", "stream_for")
print("Qobuz and Tidal remote stream plugin tests passed")
