local harness = require("service_harness")

local PLUGIN = "plugins/ListenBrainzScrobbler/ListenBrainzScrobbler.lua"
local TOKEN_A = "synthetic-token-a"
local TOKEN_B = "synthetic-token-b"
local TOKEN_BAD = "synthetic-token-rejected"
local VALIDATE = "https://api.listenbrainz.org/1/validate-token"
local SUBMIT = "https://api.listenbrainz.org/1/submit-listens"

local function blob(bag)
    local parts = {}
    for key, value in pairs(bag) do
        parts[#parts + 1] = tostring(key) .. "=" .. tostring(value)
    end
    return table.concat(parts, "\n")
end

local function joined_toasts(h)
    return table.concat(h.toasts, "\n")
end

local function assert_token_hidden(assert_true, h, token)
    assert_true(not blob(h.storage):find(token, 1, true), "storage does not contain the token")
    assert_true(not joined_toasts(h):find(token, 1, true), "toasts do not contain the token")
    for _, call in ipairs(h.http_calls) do
        assert_true(not call.options.url:find(token, 1, true), "token stays out of the URL")
        local body = call.options.body or ""
        assert_true(not body:find(token, 1, true), "token stays out of the body")
    end
end

local function queue_value(h)
    for key, value in pairs(h.storage) do
        if key:sub(1, 6) == "queue_" then return key, value end
    end
    return nil, nil
end

local function post_indexes(h, kind)
    local found = {}
    for index, call in ipairs(h.http_calls) do
        local body = call.options.body or ""
        if call.options.method == "POST" and body:find('"' .. kind .. '"', 1, true) then
            found[#found + 1] = index
        end
    end
    return found
end

local function open_token_entry(h, api)
    api.open_menu()
    local screen = h.settings[#h.settings]
    screen.items[1].on_select()
    return h.inputs[#h.inputs]
end

local function enable(h, api)
    api.open_menu()
    h.settings[#h.settings].items[2].on_change(true)
end

local function play(h, title, artist, album, duration)
    h.playing = true
    h.paused = false
    h.position = 0
    h.duration = duration
    h.emit("track_started", title, artist, album, duration)
end

local function listen_for(h, seconds)
    local left = seconds
    while left > 0 do
        local step = math.min(5, left)
        h.now = h.now + step
        h.position = h.position + step
        left = left - step
        h.tick()
    end
end

return function(assert_eq, assert_true, assert_false)
    do
        local h = harness.new({})
        local api = h.load(PLUGIN)
        assert_eq(h.definition.id, "compas.listenbrainz_scrobbler", "plugin id")
        assert_eq(h.definition.api_min, 15, "api_min 15")
        assert_eq(h.list_items[1].list_id, "playback", "playback menu")
        local input = open_token_entry(h, api)
        assert_eq(input.initial, nil, "token field is not prefilled")
        assert_eq(input.password, true, "token entry is masked")
        input.callback(TOKEN_BAD)
        assert_eq(#h.http_calls, 1, "one validate request")
        local call = h.http_calls[1].options
        assert_eq(call.method, "GET", "validate is GET")
        assert_eq(call.url, VALIDATE, "validate URL has no query")
        assert_eq(call.headers.Authorization, "Token " .. TOKEN_BAD, "Authorization Token header")
        assert_eq(call.headers["User-Agent"], "Compas/1.0", "validate user agent")
        assert_eq(call.verify_tls, true, "validate verifies TLS")
        assert_eq(call.body, nil, "validate has no body")
        assert_eq(call.redirect_limit, 0, "validate does not follow redirects")
        assert_true(call.connect_timeout_ms > 0 and call.read_timeout_ms > 0 and call.total_timeout_ms > 0,
            "validate sets timeouts")
        h.reply(1, 200, '{"code":200,"message":"Token invalid.","valid":false}')
        assert_eq(h.secrets.user_token, nil, "HTTP 200 valid=false does not save the token")
        assert_true(joined_toasts(h):find("did not accept that token", 1, true) ~= nil, "invalid token toast")
        assert_token_hidden(assert_true, h, TOKEN_BAD)
        input = open_token_entry(h, api)
        local before = #h.http_calls
        input.callback("bad token\r\nAuthorization: x")
        assert_eq(#h.http_calls, before, "control characters are not sent")
    end

    local function session(now)
        local storage, secrets = {}, {}
        local h = harness.new({ storage = storage, secrets = secrets, now = now or 1700000000 })
        local api = h.load(PLUGIN)
        return h, api, storage, secrets
    end

    local function sign_in(h, api, token, user)
        local before = #h.http_calls
        open_token_entry(h, api).callback(token)
        local index = before + 1
        h.reply(index, 200, '{"valid":true,"user_name":"' .. user .. '"}')
        assert_eq(h.secrets.user_token, token, "token saved in secrets")
        assert_eq(h.storage.user_name, user, "display name saved separately")
        assert_token_hidden(assert_true, h, token)
        return index
    end

    do
        local h, api = session(1700000000)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        enable(h, api)
        local started = h.now
        play(h, "Synthetic Track", "Synthetic Artist", "Synthetic Release", 200)
        local now_posts = post_indexes(h, "playing_now")
        assert_eq(#now_posts, 1, "one playing_now")
        local now_call = h.http_calls[now_posts[1]].options
        assert_eq(now_call.url, SUBMIT, "playing_now URL")
        assert_eq(now_call.method, "POST", "playing_now POST")
        assert_eq(now_call.content_type, "application/json", "JSON content type")
        assert_eq(now_call.verify_tls, true, "submit verifies TLS")
        assert_eq(now_call.headers.Authorization, "Token " .. TOKEN_A, "playing_now token header")
        assert_true(not now_call.body:find("listened_at", 1, true), "playing_now omits listened_at")
        local now_payload = harness.decode_json(now_call.body)
        assert_eq(now_payload.listen_type, "playing_now", "playing_now type")
        assert_eq(now_payload.payload[1].track_metadata.artist_name, "Synthetic Artist", "playing_now artist")
        assert_eq(now_payload.payload[1].track_metadata.additional_info.submission_client, "Compas", "client name")
        assert_eq(now_payload.payload[1].track_metadata.additional_info.submission_client_version, "1.0", "client version")
        h.reply(now_posts[1], 200, '{"status":"ok"}')

        h.now = h.now + 5
        h.position = 180
        h.tick()
        assert_eq(api.listened(), 5, "forward seek credits only the poll interval")
        h.now = h.now + 5
        h.position = 20
        h.tick()
        assert_eq(api.listened(), 5, "seeking backward does not add or remove time")

        h.paused = true
        h.emit("paused")
        h.now = h.now + 60
        h.tick()
        assert_eq(api.listened(), 5, "pause gap is not listening time")
        h.paused = false
        h.emit("resumed")
        listen_for(h, 95)
        assert_eq(api.listened(), 100, "later playback reaches half the track")
        local singles = post_indexes(h, "single")
        assert_eq(#singles, 1, "one single submit at the threshold")
        local single = h.http_calls[singles[1]].options
        assert_eq(single.headers.Authorization, "Token " .. TOKEN_A, "single uses the saved token")
        local payload = harness.decode_json(single.body)
        assert_eq(payload.listen_type, "single", "single listen type")
        assert_eq(#payload.payload, 1, "one listen in the payload")
        assert_eq(payload.payload[1].listened_at, started, "listened_at is the original start")
        assert_true(payload.payload[1].listened_at ~= h.now, "listened_at is not the submit time")
        local meta = payload.payload[1].track_metadata
        assert_eq(meta.artist_name, "Synthetic Artist", "single artist")
        assert_eq(meta.track_name, "Synthetic Track", "single track")
        assert_eq(meta.release_name, "Synthetic Release", "single release")
        assert_eq(meta.additional_info.duration_ms, 200000, "duration_ms")
        assert_eq(meta.additional_info.submission_client, "Compas", "single client")
        assert_true(queue_value(h) ~= nil, "qualified listen is stored before acceptance")
        listen_for(h, 40)
        assert_eq(#post_indexes(h, "single"), 1, "still one submit while the first is in flight")
        h.reply(singles[1], 200, '{"status":"ok"}')
        assert_eq(queue_value(h), nil, "accepted listen leaves the queue")
        listen_for(h, 50)
        assert_eq(#post_indexes(h, "single"), 1, "the same track is submitted once")
        assert_token_hidden(assert_true, h, TOKEN_A)
    end

    do
        local h, api = session(1700000100)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        enable(h, api)
        play(h, "Short", "Synthetic Artist", "", 29)
        listen_for(h, 40)
        assert_eq(#h.http_calls, 1, "under 30 seconds is not submitted")
        play(h, "Edge", "Synthetic Artist", "", 30)
        assert_eq(#post_indexes(h, "playing_now"), 1, "30 second track sends playing_now")
        h.reply(post_indexes(h, "playing_now")[1], 200, "{}")
        listen_for(h, 14)
        assert_eq(#post_indexes(h, "single"), 0, "half of 30 seconds is required")
        listen_for(h, 1)
        assert_eq(#post_indexes(h, "single"), 1, "exactly half of a 30 second track qualifies")
        local meta = harness.decode_json(h.http_calls[post_indexes(h, "single")[1]].options.body).payload[1].track_metadata
        assert_eq(meta.release_name, nil, "blank release is omitted")
        play(h, "", "Synthetic Artist", "Album", 180)
        local posts = #post_indexes(h, "playing_now")
        listen_for(h, 30)
        assert_eq(#post_indexes(h, "playing_now"), posts, "blank title is skipped")
        play(h, "Radio Show", "Synthetic Station", "", 0)
        listen_for(h, 240)
        assert_eq(#post_indexes(h, "single"), 1, "unknown duration is not a listen")
        assert_eq(api.submitted(), false, "radio snap is not marked submitted")
    end

    do
        local storage, secrets = {}, {}
        local h = harness.new({ storage = storage, secrets = secrets, now = 1700001000 })
        local api = h.load(PLUGIN)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        enable(h, api)
        play(h, "Track A", "Artist A", "Release A", 30)
        h.reply(post_indexes(h, "playing_now")[1], 200, "{}")
        listen_for(h, 15)
        local first = post_indexes(h, "single")[1]
        assert_true(first ~= nil, "track A is submitted")
        local _, raw = queue_value(h)
        h.storage[queue_value(h)] = "keep-9\t1700001000\t30000\t0\tKeep%20Me\tOther\t\nNOT-A-RECORD\n" .. raw
        play(h, "Track B", "Artist B", "Release B", 180)
        assert_eq(api.submitted(), false, "new track is not already submitted")
        h.reply(first, 200, '{"status":"ok"}')
        local _, after = queue_value(h)
        assert_true(after:find("Keep%20Me", 1, true) ~= nil, "other queue record is kept")
        assert_true(after:find("NOT-A-RECORD", 1, true) ~= nil, "unparsed queue text is kept")
        assert_true(not after:find("Artist%20A", 1, true), "accepted track A is removed by id")
        assert_eq(api.submitted(), false, "track A callback does not mark track B")
        local follow = post_indexes(h, "single")
        assert_eq(#follow, 2, "kept record is what the callback submits next")
        local follow_body = harness.decode_json(h.http_calls[follow[2]].options.body)
        assert_eq(follow_body.payload[1].track_metadata.artist_name, "Keep Me", "next submit is the kept record")
        assert_eq(h.http_calls[follow[2]].options.headers.Authorization, "Token " .. TOKEN_A, "kept record stays on account A")
    end

    do
        local storage, secrets = {}, {}
        local function boot(now)
            local h = harness.new({ storage = storage, secrets = secrets, now = now })
            local api = h.load(PLUGIN)
            return h, api
        end
        local h, api = boot(1700002000)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        enable(h, api)
        play(h, "Offline Track", "Offline Artist", "Offline Release", 40)
        h.reply(post_indexes(h, "playing_now")[1], 200, "{}")
        listen_for(h, 20)
        local pending = post_indexes(h, "single")[1]
        h.reply(pending, nil, nil, "network down")
        local _, queued = queue_value(h)
        assert_true(queued and queued:find("Offline%20Artist", 1, true) ~= nil, "network failure keeps the listen")
        local h2 = harness.new({ storage = storage, secrets = secrets, now = h.now + 5 })
        h2.load(PLUGIN)
        local again = post_indexes(h2, "single")
        assert_eq(#again, 1, "restart retries the saved listen once")
        assert_eq(h2.http_calls[again[1]].options.headers.Authorization, "Token " .. TOKEN_A, "retry uses the same token")
        h2.reply(again[1], 200, '{"status":"ok"}')
        assert_eq(queue_value(h2), nil, "accepted retry leaves the queue")
        local h3 = harness.new({ storage = storage, secrets = secrets, now = h2.now + 5 })
        h3.load(PLUGIN)
        assert_eq(#post_indexes(h3, "single"), 0, "a later restart does not send it again")

        local h4, api4 = boot(h3.now + 10)
        play(h4, "Rate Limited", "Offline Artist", "", 40)
        local now_index = post_indexes(h4, "playing_now")[1]
        h4.reply(now_index, 200, "{}")
        listen_for(h4, 20)
        local limited = post_indexes(h4, "single")[1]
        h4.reply(limited, 429, "{}")
        local after_limit = #post_indexes(h4, "single")
        h4.now = h4.now + 14
        h4.tick()
        assert_eq(#post_indexes(h4, "single"), after_limit, "429 waits out the backoff")
        h4.now = h4.now + 1
        h4.tick()
        assert_eq(#post_indexes(h4, "single"), after_limit + 1, "429 retries once the backoff ends")
        h4.reply(post_indexes(h4, "single")[2], 200, '{"status":"ok"}')
        h4.tick()
        assert_eq(#post_indexes(h4, "single"), after_limit + 1, "accepted listen is not retried")
        assert_true(api4.submitted(), "rate-limited track was accepted")
    end

    do
        local storage, secrets = {}, {}
        local h = harness.new({ storage = storage, secrets = secrets, now = 1700003000 })
        local api = h.load(PLUGIN)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        enable(h, api)
        play(h, "Rejected", "Rejected Artist", "", 40)
        h.reply(post_indexes(h, "playing_now")[1], 200, "{}")
        listen_for(h, 20)
        local denied = post_indexes(h, "single")[1]
        h.reply(denied, 401, '{"code":401,"error":"Invalid authorization."}')
        assert_eq(h.storage.auth_hold, "1", "401 is remembered")
        assert_true(queue_value(h) ~= nil, "401 keeps the saved listen")
        assert_true(joined_toasts(h):find(TOKEN_A, 1, true) == nil, "401 toast hides the token")
        local posts = #post_indexes(h, "single")
        h.now = h.now + 100000
        h.tick()
        assert_eq(#post_indexes(h, "single"), posts, "401 does not retry")
        local h2 = harness.new({ storage = storage, secrets = secrets, now = h.now + 10 })
        h2.load(PLUGIN)
        assert_eq(#h2.http_calls, 0, "restart does not spam a rejected token")
        assert_eq(h2.storage.auth_hold, "1", "auth hold survives restart")
    end

    do
        local storage, secrets = {}, {}
        local h = harness.new({ storage = storage, secrets = secrets, now = 1700004000 })
        local api = h.load(PLUGIN)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        enable(h, api)
        play(h, "Account A", "Artist A", "Release A", 30)
        h.reply(post_indexes(h, "playing_now")[1], 200, "{}")
        listen_for(h, 15)
        local inflight = post_indexes(h, "single")[1]
        assert_eq(h.http_calls[inflight].options.headers.Authorization, "Token " .. TOKEN_A, "inflight request belongs to A")
        local generation = api.generation()
        open_token_entry(h, api).callback(TOKEN_B)
        local validate_b = #h.http_calls
        assert_eq(h.http_calls[validate_b].options.headers.Authorization, "Token " .. TOKEN_B, "new validate uses token B")
        h.reply(validate_b, 200, '{"valid":true,"user_name":"synthetic-user-b"}')
        assert_true(api.generation() > generation, "account change bumps the generation")
        assert_eq(h.secrets.user_token, TOKEN_B, "secret is replaced")
        assert_eq(queue_value(h), nil, "account A queue is cleared before another request")
        assert_true(#h.cancels > 0, "account change cancels the inflight request")
        play(h, "Account B", "Artist B", "Release B", 30)
        local b_now = post_indexes(h, "playing_now")
        h.reply(b_now[#b_now], 200, "{}")
        listen_for(h, 15)
        local b_single = post_indexes(h, "single")
        local b_call = h.http_calls[b_single[#b_single]].options
        assert_eq(b_call.headers.Authorization, "Token " .. TOKEN_B, "B's listen uses B's token")
        local b_body = harness.decode_json(b_call.body)
        assert_eq(b_body.payload[1].track_metadata.artist_name, "Artist B", "B's payload is B's track")
        assert_true(b_body.payload[1].track_metadata.artist_name ~= "Artist A", "B does not receive A's artist")
        h.reply(inflight, 200, "{}")
        local _, b_queue = queue_value(h)
        assert_true(b_queue and b_queue:find("Artist%20B", 1, true) ~= nil, "late A callback does not delete B")
        assert_true(b_queue and not b_queue:find("Artist%20A", 1, true), "late A callback does not store A on B")
        api.open_menu()
        local rows = h.settings[#h.settings].items
        assert_true(rows[3].label:find("synthetic-user-b", 1, true) ~= nil, "logout shows the account name")
        rows[3].on_select()
        assert_eq(h.secrets.user_token, nil, "logout removes the secret")
        assert_eq(queue_value(h), nil, "logout clears the queue")
        assert_token_hidden(assert_true, h, TOKEN_A)
        assert_token_hidden(assert_true, h, TOKEN_B)
    end

    do
        local h, api = session(1700005000)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        enable(h, api)
        play(h, "Read Error", "Read Artist", "", 40)
        h.reply(post_indexes(h, "playing_now")[1], 200, "{}")
        listen_for(h, 20)
        local pending = post_indexes(h, "single")[1]
        local _, before = queue_value(h)
        h.reply(pending, 200, "{}", "read error")
        local _, after = queue_value(h)
        assert_eq(after, before, "HTTP 200 with a read error keeps the queue")
        local posts = #post_indexes(h, "single")
        h.now = h.now + 14
        h.tick()
        assert_eq(#post_indexes(h, "single"), posts, "read error backs off")
        h.now = h.now + 1
        h.tick()
        assert_eq(#post_indexes(h, "single"), posts + 1, "read error retries after backoff")

        h.reply(post_indexes(h, "single")[2], 429, "{}", nil, { ["Retry-After"] = "30" })
        local limited = #post_indexes(h, "single")
        h.now = h.now + 29
        h.tick()
        assert_eq(#post_indexes(h, "single"), limited, "numeric Retry-After holds the submit")
        h.now = h.now + 1
        h.tick()
        assert_eq(#post_indexes(h, "single"), limited + 1, "submit retries when Retry-After ends")
    end

    do
        local h, api = session(1700006000)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        enable(h, api)
        play(h, "Advisory", "Advisory Artist", "", 200)
        h.reply(post_indexes(h, "playing_now")[1], 429, "{}", nil, { ["retry-after"] = "99999" })
        local posts = #post_indexes(h, "playing_now")
        play(h, "Next Advisory", "Next Artist", "", 200)
        assert_eq(#post_indexes(h, "playing_now"), posts, "backoff blocks a new playing_now")
        h.now = h.now + 3599
        h.tick()
        assert_eq(#post_indexes(h, "playing_now"), posts, "Retry-After above 3600 waits 3600 seconds")
        h.now = h.now + 1
        h.tick()
        assert_eq(#post_indexes(h, "playing_now"), posts + 1, "playing_now starts after the bounded wait")
        assert_eq(api.submitted(), false, "advisory backoff does not mark the new track submitted")
    end

    local function start_validate(h, api, token)
        open_token_entry(h, api).callback(token)
        return #h.http_calls
    end

    do
        local h, api = session(1700007000)
        local first = start_validate(h, api, TOKEN_A)
        local second = start_validate(h, api, TOKEN_B)
        h.reply(first, 200, '{"valid":true,"user_name":"user-a"}')
        assert_eq(h.secrets.user_token, nil, "older validation cannot save if a newer one is open")
        h.reply(second, 200, '{"valid":true,"user_name":"user-b"}')
        assert_eq(h.secrets.user_token, TOKEN_B, "the newest validation saves")
    end

    do
        local h, api = session(1700007100)
        local first = start_validate(h, api, TOKEN_A)
        local second = start_validate(h, api, TOKEN_B)
        h.reply(second, 200, '{"valid":true,"user_name":"user-b"}')
        assert_eq(h.secrets.user_token, TOKEN_B, "newer validation saves before the older response")
        h.reply(first, 200, '{"valid":true,"user_name":"user-a"}')
        assert_eq(h.secrets.user_token, TOKEN_B, "older response does not replace the saved token")
        assert_eq(h.storage.user_name, "user-b", "older response does not replace the account name")
    end

    do
        local h, api = session(1700008000)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        enable(h, api)
        play(h, "Kept", "Kept Artist", "", 40)
        h.reply(post_indexes(h, "playing_now")[1], 200, "{}")
        listen_for(h, 20)
        local _, queued = queue_value(h)
        local generation = api.generation()
        h.plugin.secrets.set = function() return false end
        local index = start_validate(h, api, TOKEN_B)
        h.reply(index, 200, '{"valid":true,"user_name":"user-b"}')
        assert_eq(h.secrets.user_token, TOKEN_A, "failed secret save keeps the old token")
        assert_eq(api.generation(), generation, "failed secret save does not change account")
        assert_eq(select(2, queue_value(h)), queued, "failed secret save keeps A's queue")
        assert_true(joined_toasts(h):find("Could not save the ListenBrainz token", 1, true) ~= nil, "save failure is reported")

        h.plugin.secrets.delete = function() return false end
        api.open_menu()
        h.settings[#h.settings].items[3].on_select()
        assert_eq(h.secrets.user_token, TOKEN_A, "failed logout keeps the token")
        assert_eq(api.generation(), generation, "failed logout does not change account")
        assert_eq(select(2, queue_value(h)), queued, "failed logout keeps the queue")
        assert_true(joined_toasts(h):find("Could not log out of ListenBrainz", 1, true) ~= nil, "logout failure is reported")
        api.open_menu()
        assert_true(h.settings[#h.settings].items[3].label:find("Log out", 1, true) == 1, "still logged in after failed logout")
    end

    do
        local storage, secrets = {}, {}
        local h = harness.new({ storage = storage, secrets = secrets, now = 1700009000 })
        local api = h.load(PLUGIN)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        local pending = start_validate(h, api, TOKEN_B)
        api.open_menu()
        h.settings[#h.settings].items[3].on_select()
        assert_eq(h.secrets.user_token, nil, "logout removes the token")
        h.reply(pending, 200, '{"valid":true,"user_name":"user-b"}')
        assert_eq(h.secrets.user_token, nil, "logout invalidates an in-flight token check")
    end

    do
        local h, api = session(1700010000)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        enable(h, api)
        local key = "queue_" .. harness.fingerprint(TOKEN_A)
        local preserved = string.rep("x", 32760)
        h.storage[key] = preserved
        play(h, "Overflow", "Overflow Artist", "", 30)
        h.reply(post_indexes(h, "playing_now")[1], 200, "{}")
        listen_for(h, 15)
        assert_eq(h.storage[key], preserved, "byte cap leaves the saved queue untouched")
        assert_eq(api.submitted(), false, "unsaved listen is not marked submitted")
        local notices = 0
        for _, toast in ipairs(h.toasts) do
            if toast:find("Could not save that ListenBrainz listen", 1, true) then notices = notices + 1 end
        end
        assert_eq(notices, 1, "byte cap notifies once")
        listen_for(h, 15)
        notices = 0
        for _, toast in ipairs(h.toasts) do
            if toast:find("Could not save that ListenBrainz listen", 1, true) then notices = notices + 1 end
        end
        assert_eq(notices, 1, "byte-cap notice is not repeated")
        assert_eq(h.storage[key], preserved, "retries do not rewrite the full queue")
    end

    do
        local h, api = session(1700011000)
        sign_in(h, api, TOKEN_A, "synthetic-user")
        enable(h, api)
        local key = "queue_" .. harness.fingerprint(TOKEN_A)
        local preserved = "keep-1\t1700011000\t30000\t0\tOld%20Artist\tSong\t"
        h.storage[key] = preserved
        local real_set = h.plugin.storage.set
        h.plugin.storage.set = function(name, value)
            if type(name) == "string" and name:sub(1, 6) == "queue_" then return false end
            return real_set(name, value)
        end
        play(h, "Write Fail", "Write Artist", "", 30)
        h.reply(post_indexes(h, "playing_now")[1], 200, "{}")
        listen_for(h, 15)
        assert_eq(h.storage[key], preserved, "storage write failure keeps old records")
        assert_true(joined_toasts(h):find("Could not save that ListenBrainz listen", 1, true) ~= nil,
            "storage write failure is reported")
        listen_for(h, 10)
        local notices = 0
        for _, toast in ipairs(h.toasts) do
            if toast:find("Could not save that ListenBrainz listen", 1, true) then notices = notices + 1 end
        end
        assert_eq(notices, 1, "storage-failure notice is rate limited")
    end
end
