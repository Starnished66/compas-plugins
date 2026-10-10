-- Test runner for ABRepeat and ABXBlindTest plugins (API 16).
-- Logs output to build_test/ab_plugins/results.log.

package.path = "?.lua;" .. package.path

os.execute("mkdir -p build_test/ab_plugins")
local log_path = "build_test/ab_plugins/results.log"
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
        local line = string.format("FAIL %s: got %s, expected %s", msg or "eq", tostring(a), tostring(b))
        log:write(line, "\n")
        print(line)
    end
end

local suites = {
    { "ab_repeat", "tests.ab_plugins.test_ab_repeat" },
    { "abx_blind_test", "tests.ab_plugins.test_abx_blind_test" },
}

for _, suite in ipairs(suites) do
    local name = suite[1]
    local mod_name = suite[2]
    log:write("=== " .. name .. " ===\n")
    print("=== " .. name .. " ===")
    local test_fn = require(mod_name)
    local ok, err = pcall(test_fn, assert_eq, assert_true, assert_false)
    if not ok then
        failed = failed + 1
        local line = "ERROR in " .. name .. ": " .. tostring(err)
        log:write(line, "\n")
        print(line)
    end
end

local summary = string.format("passed=%d failed=%d", passed, failed)
log:write(summary, "\n")
log:close()
print(summary)
print("log: " .. log_path)

if failed > 0 then
    os.exit(1)
end
