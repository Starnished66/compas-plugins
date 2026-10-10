-- Host runner for context plugin test suites.
-- Logs results to build_test/context_plugin_tests/results.log.

package.path = "tests/context_plugins/?.lua;" .. package.path

os.execute("mkdir -p build_test/context_plugin_tests")
local log_path = "build_test/context_plugin_tests/results.log"
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

local suites = {
    { name = "autoeq_context", module = "test_autoeq_context" },
    { name = "output_aware_sound", module = "test_output_aware_sound" },
    { name = "album_playback_rules", module = "test_album_playback_rules" },
    { name = "precedence_and_safeguards", module = "test_precedence_and_safeguards" },
}

for _, s in ipairs(suites) do
    log:write("=== ", s.name, " ===\n")
    print("=== " .. s.name .. " ===")
    local fn = require(s.module)
    local ok, err = pcall(fn, assert_eq, assert_true, assert_false)
    if not ok then
        failed = failed + 1
        local err_line = "ERROR " .. tostring(err)
        log:write(err_line, "\n")
        print(err_line)
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
