-- Host test for the Cover Art Fetcher Now Playing menu entry.
--
--   lua tools/test_cover_art_player_menu.lua
--
-- Loads the real plugin against a stub API and checks that Settings > Library
-- stays registered, and that Now Playing fetches the current album only when
-- ui.player_menu is present.

local script_dir = (arg and arg[0] or "tools/test_cover_art_player_menu.lua"):match("^(.*)/[^/]*$") or "."
local PLUGIN = script_dir .. "/../plugins/CoverArtFetcher/CoverArtFetcher.lua"

local failures, checks = 0, 0

local function check(cond, message)
    checks = checks + 1
    if not cond then
        failures = failures + 1
        print("FAIL: " .. message)
    end
end

local function load_plugin(player_menu)
    local S = { rows = {}, toasts = {}, settings = nil }
    local caps = { ["ui.player_menu"] = player_menu and true or false }
    local p = {}
    p.define = function(info) S.define = info end
    p.sd_root = function() return "/tmp/compas-cover-art-fetcher-test" end
    p.has_capability = function(name) return caps[name] == true end
    p.on = function() end
    p.set_interval = function() end
    p.register_list_item = function(list, label, cb)
        S.rows[#S.rows + 1] = { list = list, label = label, cb = cb }
    end
    p.show_toast = function(message) S.toasts[#S.toasts + 1] = message end
    p.show_settings_list = function(title, items) S.settings = { title = title, items = items } end
    p.show_list = function() end
    p.storage = {
        list = function() return {} end,
        get = function() return nil end,
    }
    local env = setmetatable({ plugin = p }, { __index = _G })
    local chunk, err = loadfile(PLUGIN, "t", env)
    if not chunk then error(err) end
    chunk()
    return S
end

local function row(S, list)
    for _, item in ipairs(S.rows) do
        if item.list == list then return item end
    end
end

local with_menu = load_plugin(true)
check(with_menu.define and with_menu.define.version == "1.1.6", "version is 1.1.6")
check(#with_menu.rows == 2, "library and player rows are both registered")
local library = row(with_menu, "music_library")
local player = row(with_menu, "player")
check(library and library.label == "Cover Art Fetcher", "library row label is Cover Art Fetcher")
check(player and player.label == "Cover Art Fetcher", "player row label is Cover Art Fetcher")
check(type(library and library.cb) == "function", "library callback is a function")
check(type(player and player.cb) == "function", "player callback is a function")

library.cb()
check(with_menu.settings and with_menu.settings.title == "Cover Art Fetcher", "library menu still opens settings")
local fetch_row
for _, item in ipairs(with_menu.settings and with_menu.settings.items or {}) do
    if item.label == "Fetch cover for current album" then fetch_row = item end
end
check(fetch_row and type(fetch_row.on_select) == "function", "settings still has Fetch cover for current album")

player.cb()
check(with_menu.toasts[#with_menu.toasts] == "This player cannot fetch cover art",
    "player action runs a manual fetch for the current album")

local without_menu = load_plugin(false)
check(#without_menu.rows == 1, "player row is omitted without ui.player_menu")
check(row(without_menu, "music_library") ~= nil, "library row remains without ui.player_menu")
check(row(without_menu, "player") == nil, "no player row without ui.player_menu")

if failures == 0 then
    print("ok " .. checks .. " checks")
else
    print(failures .. " failed, " .. checks .. " checks")
    os.exit(1)
end
