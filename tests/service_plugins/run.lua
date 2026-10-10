-- Host runner for mocked ListenBrainz and Net Radio tests.
package.path = "tests/service_plugins/?.lua;tests/music_plugins/?.lua;" .. package.path

os.execute("mkdir -p build_test/service_plugin_tests")
local log_path = "build_test/service_plugin_tests/results.log"
local log = assert(io.open(log_path, "w"))

local failed = 0
local passed = 0

local function assert_true(cond, msg)
    if cond then
        passed = passed + 1
        log:write("PASS ", msg or "", "\n")
    else
        failed = failed + 1
        log:write("FAIL ", msg or "assertion failed", "\n")
        print("FAIL " .. (msg or "assertion failed"))
    end
end

local function assert_false(cond, msg)
    assert_true(not cond, msg)
end

local function assert_eq(a, b, msg)
    if a == b then
        assert_true(true, msg)
    else
        failed = failed + 1
        local line = string.format("FAIL %s: got %s expected %s", msg or "eq", tostring(a), tostring(b))
        log:write(line, "\n")
        print(line)
    end
end

local tests = {
    { "listenbrainz", "test_listenbrainz" },
    { "netradio", "test_net_radio" },
}

for _, entry in ipairs(tests) do
    log:write("=== ", entry[1], " ===\n")
    print("=== " .. entry[1] .. " ===")
    local fn = require(entry[2])
    local ok, err = xpcall(function()
        fn(assert_eq, assert_true, assert_false)
    end, function(reason)
        return debug.traceback(tostring(reason), 2)
    end)
    if not ok then
        failed = failed + 1
        log:write("ERROR ", err, "\n")
        print("ERROR " .. err)
    end
end

local summary = string.format("passed=%d failed=%d", passed, failed)
log:write(summary, "\n")
log:close()
print(summary)
print("log: " .. log_path)
if failed > 0 then os.exit(1) end
