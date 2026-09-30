-- Standalone integration tests for AutoEQ's plugin/API flow.
-- Run from the repository root with: lua tests/autoeq_test.lua
local SCRIPT = "plugins/AutoEQ/AutoEQ.lua"
local FIXTURES = "tests/fixturesAutoEQ/"
local TMP = os.tmpname() .. "_autoeq"
os.execute("mkdir -p " .. TMP)

local function read(path)
    local f = assert(io.open(path, "rb")); local s = f:read("*a"); f:close(); return s
end
local function write(path, text)
    local f = assert(io.open(path, "wb")); assert(f:write(text)); assert(f:close())
end
local function contains(s, part) return s:find(part, 1, true) ~= nil end
local count = 0
local function check(ok, message)
    if not ok then error(message or "assertion failed", 2) end
    count = count + 1
end
local function eq(actual, expected, message)
    check(actual == expected, (message or "values differ") .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual))
end
local function near(actual, expected, epsilon, message)
    check(math.abs(actual - expected) <= epsilon, (message or "numbers differ") .. ": expected " .. expected .. ", got " .. actual)
end
local function path_hash(path)
    local h = 0
    for i = 1, #path do h = (h * 33 + path:byte(i)) % 4294967296 end
    return string.format("%08x%08x", h, h):sub(1, 10)
end

local function new_app()
    local root = TMP .. "/case" .. tostring(count + 1)
    os.execute("mkdir -p " .. root .. "/.plugins " .. root .. "/PEQ_Profiles")
    local app = { root = root, requests = {}, lists = {}, settings = {}, toasts = {}, cancels = {}, eq_calls = 0 }
    local function forbidden()
        app.eq_calls = app.eq_calls + 1
        error("AutoEQ saving must not load/reset/change audio EQ")
    end
    plugin = {
        define = function() end,
        sd_root = function() return root end,
        mkdir = function(path) os.execute("mkdir -p " .. path); return true end,
        md5 = function(path) return path_hash(path) .. path_hash(path) .. path_hash(path) .. path_hash(path) end,
        register_list_item = function(_, _, callback) app.open_home = callback end,
        show_settings_list = function(title, rows) app.settings[#app.settings + 1] = { title = title, rows = rows }; return #app.settings end,
        show_list = function(title, rows, callback)
            app.lists[#app.lists + 1] = { title = title, rows = rows, callback = callback }
            app.visible_handle = #app.lists
            return #app.lists
        end,
        is_list_showing = function(handle) return app.visible_handle == handle end,
        show_text_input = function(title, value, secret, callback) app.text_input = callback end,
        show_text_view = function(title, text) app.text_view = text end,
        show_toast = function(text) app.toasts[#app.toasts + 1] = text end,
        http_request = function(options, callback)
            local handle = { id = #app.requests + 1 }
            app.requests[#app.requests + 1] = { options = options, callback = callback, handle = handle }
            return handle
        end,
        cancel = function(handle) app.cancels[#app.cancels + 1] = handle; return true end,
        eq_load_profile = forbidden, eq_reset = forbidden, eq_set_preamp = forbidden,
        eq_set_band = forbidden, eq_set_enabled = forbidden,
    }
    dofile(SCRIPT)
    return app
end

local function respond(req, status, body, err)
    req.callback(status, body, err, {})
end
local function start_search(app, query)
    app.open_home()
    app.lists[#app.lists].callback(1)
    app.text_input(query)
    return app.requests[#app.requests]
end
local function current_list(app) return app.lists[#app.lists] end
local function successful_catalog(app, request, body)
    respond(request, 200, body or read(FIXTURES .. "recommended-index.md"))
end
local function begin_profile_download(app, query, catalog_body)
    local request = start_search(app, query)
    successful_catalog(app, request, catalog_body)
    current_list(app).callback(1)
    current_list(app).callback(3)
    return app.requests[#app.requests]
end
local function begin_replace_download(app, query)
    app.open_home()
    current_list(app).callback(1)
    app.text_input(query)
    current_list(app).callback(1) -- result
    current_list(app).callback(3) -- explicitly replace from the existing-profile detail rows
    return app.requests[#app.requests]
end
local function profile_text()
    return read(FIXTURES .. "hd650-oratory.txt")
end
local function saved_profile(app)
    local p = assert(io.popen("find " .. app.root .. "/PEQ_Profiles -maxdepth 1 -type f -name '*.peq' -print -quit", "r"))
    local path = p:read("*l"); p:close()
    return path and read(path), path
end

-- Search operates on actual catalog results, case-insensitively and with every
-- whitespace-separated query term required. Link paths exercise encoded nested
-- parentheses, percent signs, and UTF-8 without shipping the upstream index.
do
    local app = new_app()
    local request = start_search(app, "sEnNhEiSeR  hD 650")
    check(contains(request.options.url, "raw.githubusercontent.com/jaakkopasanen/AutoEq/master/results/README.md"), "catalog source is fixed to official AutoEq host")
    eq(request.options.verify_tls, true, "catalog TLS verification enabled")
    successful_catalog(app, request)
    eq(#app.lists, 2, "search result screen opened")
    eq(#current_list(app).rows, 2, "both HD 650 variants match")
    check(contains(current_list(app).rows[1].label, "Sennheiser HD 650"), "first result label")
    check(not contains(current_list(app).rows[1].label, "Example"), "all terms required")

    local nested = new_app()
    local nested_req = start_search(nested, "STUDIO rev")
    successful_catalog(nested, nested_req)
    eq(#current_list(nested).rows, 1, "UTF-8 nested model found")
    current_list(nested).callback(1)
    local detail = current_list(nested)
    check(contains(detail.rows[2].label, "source (1)/over-ear"), "measurement source directory is decoded")
    detail.callback(3)
    local profile_request = nested.requests[#nested.requests]
    check(profile_request.options.url:match("^https://raw%.githubusercontent%.com/"), "profile URL has fixed trusted host")
    check(contains(profile_request.options.url, "source%20%281%29/over-ear/Model%20%28Studio%20%28Rev.%202%29%29"), "reserved path bytes stay encoded in request URL")
    check(not contains(profile_request.options.url, "../"), "URL contains no traversal")
    eq(nested.eq_calls, 0, "opening download does not touch audio EQ")

    nested.open_home()
    current_list(nested).callback(4)
    check(contains(nested.text_view, "jaakkopasanen/AutoEq"), "source attribution is available in the UI")
end

-- Result pagination exposes every match while keeping each displayed page bounded.
do
    local rows = {}
    for i = 1, 103 do rows[#rows + 1] = string.format("- [Fixture Headphone %03d HD](./source/over-ear/Fixture%%20Headphone%%20%03d)", i, i) end
    local app = new_app()
    local req = start_search(app, "fixture hd")
    successful_catalog(app, req, "# fixture\n" .. table.concat(rows, "\n") .. "\n")
    local picker = current_list(app)
    eq(#picker.rows, 3, "bounded page picker exposes all result pages")
    picker.callback(1)
    eq(#current_list(app).rows, 40, "result page is bounded at 40")
    check(contains(current_list(app).rows[1].label, "001"), "first result accessible")
    picker.callback(2)
    eq(#current_list(app).rows, 40, "middle page has 40 results")
    check(contains(current_list(app).rows[1].label, "041"), "middle page starts at match 41")
    picker.callback(3)
    eq(#current_list(app).rows, 23, "last page has remaining matches")
    check(contains(current_list(app).rows[23].label, "103"), "last match remains accessible")
    current_list(app).callback(23)
    check(contains(current_list(app).rows[1].label, "Model: Fixture Headphone 103"), "last result opens details")
end

-- Oversized catalog rows are rejected before the model pattern can rescan them.
do
    local app = new_app()
    local req = start_search(app, "headphone")
    local malformed = "- [" .. string.rep("x](./", 200000)
    respond(req, 200, malformed)
    check(contains(app.toasts[#app.toasts], "line longer than 4096 bytes"), "delimiter-heavy catalog row rejected")
    eq(#app.lists, 1, "invalid catalog does not open search results")
    eq(saved_profile(app), nil, "invalid catalog saves no profile")
end

-- Cache is persisted atomically and reused after an offline refresh failure;
-- stale callbacks after cancellation or a replacement request do not redraw UI.
do
    local data = read(FIXTURES .. "recommended-index.md")
    local app = new_app()
    local req = start_search(app, "sennheiser hd")
    successful_catalog(app, req, data)
    local cache_path = app.root .. "/.plugins/.autoeq_catalog.md"
    eq(read(cache_path), data, "catalog cache persisted")

    local offline = new_app()
    -- Use the same disk root to model a plugin restart with a previously saved cache.
    offline.root = app.root
    plugin.sd_root = function() return offline.root end
    dofile(SCRIPT)
    offline.open_home()
    offline.lists[#offline.lists].callback(2)
    local refresh = offline.requests[1]
    respond(refresh, nil, nil, "dns_failure")
    offline.open_home()
    offline.lists[#offline.lists].callback(1)
    offline.text_input("Sennheiser HD 650")
    eq(#offline.lists, 3, "cached matches available offline after refresh failure")
    eq(read(cache_path), data, "failed refresh preserves cached bytes")

    local cancel_app = new_app()
    local old = start_search(cancel_app, "sennheiser")
    cancel_app.open_home()
    cancel_app.lists[#cancel_app.lists].callback(3)
    eq(#cancel_app.cancels, 1, "cancel action cancels outstanding request")
    local list_count = #cancel_app.lists
    successful_catalog(cancel_app, old)
    eq(#cancel_app.lists, list_count, "cancelled completion is stale")

    local back = new_app()
    local pending = start_search(back, "sennheiser")
    back.visible_handle = nil -- user leaves the plugin screen while the request is pending
    successful_catalog(back, pending)
    eq(#back.lists, 1, "completion after leaving the screen does not reopen results")

    local race = new_app()
    local prior = start_search(race, "sennheiser")
    race.open_home(); race.lists[#race.lists].callback(2)
    local latest = race.requests[#race.requests]
    successful_catalog(race, prior)
    eq(#race.lists, 2, "superseded request cannot publish")
    successful_catalog(race, latest)
    eq(#race.lists, 2, "refresh callback only reports catalog status")
end

-- A failed atomic rename keeps an existing profile intact and removes its
-- temporary file. A 140-byte title cut never leaves an invalid UTF-8 suffix.
do
    local app = new_app()
    local atomic_index = "- [Atomic](./source/over-ear/atomic)\n"
    local catalog_request = start_search(app, "atomic")
    successful_catalog(app, catalog_request, atomic_index)
    local target = app.root .. "/PEQ_Profiles/AutoEQ - Atomic - " .. path_hash("source/over-ear/atomic") .. ".peq"
    write(target, "keep this profile\n")
    current_list(app).callback(1) -- details sees the existing file
    current_list(app).callback(3) -- replace
    local rename = os.rename
    local rename_attempts = 0
    os.rename = function() rename_attempts = rename_attempts + 1; return nil, "injected rename failure" end
    respond(app.requests[#app.requests], 200, profile_text())
    os.rename = rename
    eq(rename_attempts, 1, "replacement reached the atomic rename operation")
    eq(read(target), "keep this profile\n", "failed atomic replacement keeps prior bytes")
    check(io.open(target .. ".tmp", "rb") == nil, "failed atomic replacement removes temporary file")

    local long_name = "Truncated " .. string.rep("A", 129) .. "é"
    local utf8_index = "- [" .. long_name .. "](./source/over-ear/long-title)\n"
    local utf8_app = new_app()
    begin_profile_download(utf8_app, "truncated", utf8_index)
    respond(utf8_app.requests[#utf8_app.requests], 200, profile_text())
    local _, path = saved_profile(utf8_app)
    local base = assert(path:match("AutoEQ %- (.*) %- [0-9a-f]+%.peq$"))
    eq(utf8.len(base), 139, "filename truncation drops incomplete multibyte suffix")
    eq(base, "Truncated " .. string.rep("A", 129), "filename keeps complete UTF-8 prefix")
end

-- The accepted source row format maps into native PEQ parameters without
-- changing source gain/preamp/peak Q, converts shelf Q using the documented
-- RBJ slope equation, fills absent bands with disabled safe defaults, and never
-- calls an audio-loading or EQ-setting API while saving.
do
    local app = new_app()
    local index = "- [HD 650](./oratory1990/over-ear/HD%20650)\n- [Short Test](./source/over-ear/short)\n"
    local req = begin_profile_download(app, "hd 650", index)
    eq(req.options.max_response_bytes, 65536, "bounded profile response")
    respond(req, 200, profile_text())
    local output = assert(saved_profile(app))
    check(contains(output, "preamp=-6.100000"), "preamp preserved")
    check(contains(output, "band1_gain=5.100000"), "peak gain preserved")
    check(contains(output, "band1_q=1.420000"), "peak Q preserved")
    local A = 10 ^ (6.4 / 40)
    local expected_s = 1 / (1 + (1 / (0.7 * 0.7) - 2) / (A + 1 / A))
    local shelf_q = tonumber(output:match("band0_q=([%d%.]+)"))
    near(shelf_q, expected_s, 0.000001, "AutoEQ shelf Q converted to RBJ slope")
    local omega = 2 * math.pi * 105 / 48000
    local autoeq_alpha = math.sin(omega) / (2 * 0.7)
    local native_alpha = math.sin(omega) / 2 * math.sqrt((A + 1 / A) * (1 / shelf_q - 1) + 2)
    near(native_alpha, autoeq_alpha, 0.000001, "shelf conversion preserves coefficient alpha")
    local high_A = 10 ^ (-2.1 / 40)
    local high_s = 1 / (1 + (1 / (0.7 * 0.7) - 2) / (high_A + 1 / high_A))
    near(tonumber(output:match("band5_q=([%d%.]+)")), high_s, 0.000001, "high shelf Q converted")
    eq(tonumber(output:match("band0_type=(%d+)")), 1, "low shelf native type")
    eq(tonumber(output:match("band5_type=(%d+)")), 2, "high shelf native type")
    eq(tonumber(output:match("band9_enabled=(%d+)")), 1, "all ten source filters retained")
    eq(app.eq_calls, 0, "saving never applies audio")

    local short = "Preamp: +2.25 dB\nFilter 1: OFF PK Fc 20 Hz Gain -12 dB Q 10\n"
    app.open_home()
    current_list(app).callback(1)
    app.text_input("short test")
    current_list(app).callback(1)
    current_list(app).callback(3)
    respond(app.requests[#app.requests], 200, short)
    local short_path = app.root .. "/PEQ_Profiles/AutoEQ - Short Test - " .. path_hash("source/over-ear/short") .. ".peq"
    local short_out = assert(read(short_path))
    eq(tonumber(short_out:match("band0_enabled=(%d+)")), 0, "OFF filter remains disabled")
    eq(tonumber(short_out:match("band0_freq=([%d%.]+)")), 20, "lower frequency boundary accepted")
    eq(tonumber(short_out:match("band0_gain=([%-%d%.]+)")), -12, "lower gain boundary accepted")
    eq(tonumber(short_out:match("band0_q=([%d%.]+)")), 10, "upper Q boundary accepted")
    eq(tonumber(short_out:match("band9_enabled=(%d+)")), 0, "unused default bands disabled")
end

-- Downloads may finish after leaving details, but must not show stale toasts.
do
    local app = new_app()
    local req = begin_profile_download(app, "hd 650", "- [HD 650](./oratory1990/over-ear/HD%20650)\n")
    app.visible_handle = 1
    local toast_count = #app.toasts
    respond(req, 200, profile_text())
    eq(#app.toasts, toast_count, "leaving download details suppresses completion toast")
    check(saved_profile(app) ~= nil, "download still saves after leaving details")
    req = begin_replace_download(app, "hd 650")
    app.visible_handle = 1
    toast_count = #app.toasts
    respond(req, 503, nil, "offline")
    eq(#app.toasts, toast_count, "leaving replacement details suppresses failure toast")
end

-- Malformed, truncated, unsupported, duplicate, and out-of-range input cannot
-- replace a pre-existing profile. Path validation rejects traversal and
-- non-HTTPS destinations before starting a request.
do
    local app = new_app()
    local index = "- [Unsafe model](./safe/over-ear/model)\n"
    local catalog_request = start_search(app, "unsafe model")
    successful_catalog(app, catalog_request, index)
    local profile_hash = path_hash("safe/over-ear/model")
    local destination = app.root .. "/PEQ_Profiles/AutoEQ - Unsafe model - " .. profile_hash .. ".peq"
    local original = "sentinel profile\n"
    write(destination, original)
    current_list(app).callback(1) -- details recognizes existing file
    current_list(app).callback(3) -- replace to exercise parsing of existing-file imports
    eq(#app.requests, 2, "explicit replacement starts profile download")
    local bad = {
        "Preamp: 0 dB\nFilter 1: ON PK Fc 100 Hz Gain 0 dB Q 1\nFilter 1: ON PK Fc 200 Hz Gain 0 dB Q 1\n",
        "Preamp: 0 dB\nPreamp: 1 dB\nFilter 1: ON PK Fc 100 Hz Gain 0 dB Q 1\n",
        "Preamp: 0 dB\nFilter 1: ON PK Fc 100 Hz Gain 0 dB Q 1\nFilter 3: ON PK Fc 300 Hz Gain 0 dB Q 1\n",
        "Preamp: 0 dB\nFilter 1: ON PK Fc 100 Hz Gain 0 dB Q 1\nFilter 2: ON PK Fc 200 Hz Gain 0 dB Q 1\nFilter 2: ON PK Fc 300 Hz Gain 0 dB Q 1\n",
        "Preamp: 0 dB\nFilter 1: ON XYZ Fc 100 Hz Gain 0 dB Q 1\n",
        "Preamp: 13 dB\nFilter 1: ON PK Fc 100 Hz Gain 0 dB Q 1\n",
        "Preamp: 0 dB\nFilter 1: ON PK Fc 20001 Hz Gain 0 dB Q 1\n",
        "Preamp: 0 dB\nFilter 1: ON PK Fc 19 Hz Gain 0 dB Q 1\n",
        "Preamp: 0 dB\nFilter 1: ON PK Fc 100 Hz Gain 12.1 dB Q 1\n",
        "Preamp: 0 dB\nFilter 1: ON PK Fc 100 Hz Gain -12.1 dB Q 1\n",
        "Preamp: 0 dB\nFilter 1: ON PK Fc 100 Hz Gain 0 dB Q 0.09\n",
        "Preamp: 0 dB\nFilter 1: ON PK Fc 100 Hz Gain 0 dB Q 10.1\n",
        "Preamp: 0 dB\nFilter 1: ON PK Fc 100 Hz Gain 0 dB Q \n", -- truncated numeric value
        "Preamp: 0 dB\nFilter 1: ON PK Fc 100 Hz Gain 0 dB Q 1\nnot a row\n",
        string.rep("x", 65537), -- oversized/truncated payload
    }
    for i, text in ipairs(bad) do
        if i > 1 then
            local old_count = #app.requests
            local req = begin_replace_download(app, "unsafe model")
            eq(#app.requests, old_count + 1, "each invalid case starts a real replacement request")
            check(req.options.url:match("^https://raw%.githubusercontent%.com/"), "invalid case requested trusted source")
        end
        respond(app.requests[#app.requests], 200, text)
        eq(read(destination), original, "invalid input preserves existing profile " .. i)
    end
    local invalid_paths = { "../outside", "a/../../outside", "%2e%2e/outside", "a/%2E%2E/outside", "/absolute/path", "https://evil.invalid/path", "a//b", "a\\b", "a?query" }
    local malicious = {}
    for i, path in ipairs(invalid_paths) do malicious[#malicious + 1] = "- [Unsafe " .. i .. "](./" .. path .. ")" end
    local path_app = new_app()
    local malicious_req = start_search(path_app, "unsafe")
    successful_catalog(path_app, malicious_req, table.concat(malicious, "\n") .. "\n")
    eq(#path_app.requests, 1, "only the catalog request ran for rejected source paths")
    check(path_app.requests[2] == nil, "unsafe catalog targets never start a profile request")
    eq(app.eq_calls, 0, "invalid imports do not affect EQ")
end

-- Existing names offer a separate copy target, and generated names are safe
-- for filesystem use even when the catalog model includes punctuation.
do
    local app = new_app()
    local index = "- [Bad / model (é)!](./source/over-ear/Bad%20%25%20model%20%28%C3%A9%29)\n"
    begin_profile_download(app, "bad", index)
    respond(app.requests[#app.requests], 200, profile_text())
    local _, profile_path = saved_profile(app)
    check(profile_path and profile_path:match("AutoEQ %- Bad _ model %(é%)! %- [0-9a-f]+%.peq$"), "sanitized deterministic profile name")
    app.lists = {}; app.settings = {}
    local second = start_search(app, "bad")
    successful_catalog(app, second, index)
    current_list(app).callback(1)
    local replace = current_list(app)
    check(contains(replace.rows[3].label, "Replace existing profile"), "collision offers an explicit replace option")
    check(contains(replace.rows[4].label, "Save as new copy"), "collision offers copy")
    replace.callback(4)
    respond(app.requests[#app.requests], 200, profile_text())
    local p = assert(io.popen("find " .. app.root .. "/PEQ_Profiles -maxdepth 1 -type f -name '*.peq' | wc -l", "r"))
    eq(tonumber(p:read("*l")), 2, "collision creates a separate profile")
    p:close()
end

-- Identical display names from different measurement directories keep
-- distinct deterministic filenames through their catalog-path hashes.
do
    local app = new_app()
    local index = "- [Twin Headphone](./source-a/over-ear/twin)\n- [Twin Headphone](./source-b/over-ear/twin)\n"
    local req = start_search(app, "twin headphone")
    successful_catalog(app, req, index)
    eq(#current_list(app).rows, 2, "both same-named measurements are reachable")
    current_list(app).callback(1)
    current_list(app).callback(3)
    respond(app.requests[#app.requests], 200, profile_text())
    app.open_home()
    current_list(app).callback(1)
    app.text_input("twin headphone")
    current_list(app).callback(2)
    current_list(app).callback(3)
    respond(app.requests[#app.requests], 200, profile_text())
    local p = assert(io.popen("find " .. app.root .. "/PEQ_Profiles -maxdepth 1 -type f -name '*.peq' -print", "r"))
    local first, second = p:read("*l"), p:read("*l")
    p:close()
    check(first and second and first ~= second, "different source paths produce distinct profile files")
end

os.execute("rm -rf " .. TMP)
print("AutoEQ tests passed: " .. count .. " assertions")
