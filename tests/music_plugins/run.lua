-- Host runner for mocked plugin example tests. Logs to build_test/.
package.path = "tests/music_plugins/?.lua;" .. package.path

os.execute("mkdir -p build_test/plugin_example_tests")
local log_path = "build_test/plugin_example_tests/results.log"
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
    { "lyrics", "test_lyrics_fetcher" },
    { "cover", "test_cover_art_fetcher" },
    { "shuffle", "test_album_shuffle" },
}

for _, t in ipairs(tests) do
    log:write("=== ", t[1], " ===\n")
    print("=== " .. t[1] .. " ===")
    local fn = require(t[2])
    local ok, err = pcall(fn, assert_eq, assert_true, assert_false)
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
