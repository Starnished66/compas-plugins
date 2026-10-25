-- Focused tests for ABX file browser empty-state copy and selection indices.
-- Run with: lua tools/test_abx_empty_state.lua
local function read(path)
    local file = assert(io.open(path, "rb"))
    local source = file:read("*a")
    file:close()
    return source
end

local function between(source, first, after)
    local start = assert(source:find(first, 1, true), "missing " .. first)
    local finish = assert(source:find(after, start + #first, true), "missing " .. after)
    return source:sub(start, finish - 1)
end

local source = read("plugins/ABXBlindTest/ABXBlindTest.lua")
local browser = between(source, "local file_browser_handle = nil", "-- Virtual Views for unified Settings Screen")
local state = { entries = {}, picks = {}, shown = nil }
plugin = {
    sd_root = function() return "/mock-sd" end,
    list_dir = function(path)
        assert(path == "/mock-sd")
        return state.entries
    end,
    show_list = function(title, rows, callback, options)
        state.shown = { title = title, rows = rows, callback = callback, options = options }
        return { handle = true }
    end,
}
local chunk = assert(load(browser .. "\nreturn browse_files", "ABX browse_files", "t", {
    plugin = plugin,
    ipairs = ipairs,
    pairs = pairs,
    table = table,
    string = string,
    type = type,
}))
local browse_files = chunk()

local function check_empty(filter, expected)
    state.entries = {}
    browse_files(filter, function(path) state.picks[#state.picks + 1] = path end)
    assert(state.shown.title == "Select File")
    assert(#state.shown.rows == 1 and state.shown.rows[1] == expected,
        "empty state should list the active file filter")
    local before = #state.picks
    state.shown.callback(1)
    assert(#state.picks == before, "choosing the empty-state row must do nothing")
end

check_empty({ ".flac", ".wav", ".aiff", ".caf", ".mp3" },
    "No matching files here (FLAC, WAV, AIFF, CAF, MP3)")
check_empty({ ".peq" }, "No matching files here (PEQ)")

state.entries = { { name = "keep.peq", dir = false }, { name = "skip.flac", dir = false } }
browse_files({ ".peq" }, function(path) state.picks[#state.picks + 1] = path end)
assert(#state.shown.rows == 1 and state.shown.rows[1] == "keep.peq",
    "the active filter should still control visible rows")
state.shown.callback(1)
assert(state.picks[#state.picks] == "/mock-sd/keep.peq",
    "file selection callback index should remain unchanged")

print("ABX file browser empty-state tests passed")
