-- Host test runner for Jellyfin & Emby plugin.
package.path = "tests/jellyfin_emby/?.lua;" .. package.path

os.execute("mkdir -p build_test/jellyfin_emby_tests")
local log_path = "build_test/jellyfin_emby_tests/results.log"
local log = assert(io.open(log_path, "w"))

local failed = 0
local passed = 0

local function assert_true(cond, msg)
    if cond then
        passed = passed + 1
        log:write("PASS ", msg or "", "\n")
    else
        failed = failed + 1
        local line = "FAIL " .. (msg or "assertion failed")
        log:write(line, "\n")
        print(line)
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

print("=== jellyfin_emby ===")
log:write("=== jellyfin_emby ===\n")

local test_fn = require("test_jellyfin_emby")
local ok, err = xpcall(function()
    test_fn(assert_eq, assert_true, assert_false)
end, function(reason)
    return debug.traceback(tostring(reason), 2)
end)

if not ok then
    failed = failed + 1
    local err_line = "ERROR " .. tostring(err)
    log:write(err_line, "\n")
    print(err_line)
end

local summary = string.format("passed=%d failed=%d", passed, failed)
log:write(summary, "\n")
log:close()
print(summary)
print("log: " .. log_path)

if failed > 0 then os.exit(1) end
