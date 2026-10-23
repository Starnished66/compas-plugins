-- Host test for plugins/LyricsFetcher/LyricsFetcher.lua
--
--   lua tools/test_lyrics_fetcher.lua
--
-- Loads the real plugin against a stub API and checks sidecar naming, skip
-- vs replace rules, unread backups, stale-fetch refusal, rollback, Now
-- Playing registration, native refresh_lyrics(track_path), and sidecar
-- open/read error handling.

local script_dir = (arg and arg[0] or "tools/test_lyrics_fetcher.lua"):match("^(.*)/[^/]*$") or "."
local PLUGIN = script_dir .. "/../plugins/LyricsFetcher/LyricsFetcher.lua"

local function shell(cmd)
    local p = assert(io.popen(cmd))
    local out = p:read("a")
    p:close()
    return out
end

local SD = shell("mktemp -d"):gsub("%s+$", "")
local MUSIC = SD .. "/music"
assert(os.execute("mkdir -p '" .. MUSIC .. "'") == true or os.execute("mkdir -p '" .. MUSIC .. "'") == 0)

local failures, checks = 0, 0

local function check(cond, message)
    checks = checks + 1
    if not cond then
        failures = failures + 1
        print("FAIL: " .. message)
    end
end

local function write_file(path, text)
    local f = assert(io.open(path, "wb"))
    f:write(text)
    f:close()
end

local function read_file(path)
    local f = io.open(path, "rb")
    if not f then return nil end
    local text = f:read("a")
    f:close()
    return text
end

local function exists(path)
    local f = io.open(path, "rb")
    if f then f:close() return true end
    return false
end

local SYNCED = "[00:01.00] Hello\n[00:02.00] World\n"
local UNSYNCED = "Hello\nWorld\n"

local function load_plugin(opts)
    opts = opts or {}
    local S = {
        rows = {},
        toasts = {},
        settings = nil,
        http = nil,
        refresh_calls = 0,
        refresh_args = {},
        refresh_throw = nil,
        refresh_false = false,
        path = opts.path or (MUSIC .. "/song.flac"),
        title = opts.title or "Song",
        artist = opts.artist or "Artist",
        album = opts.album or "Album",
        duration = opts.duration or 180,
        caps = opts.caps or {
            ["ui.player_menu"] = true,
            ["network.http.async"] = true,
            ["data.json"] = true,
        },
    }
    local p = {}
    p.define = function(info) S.define = info end
    p.sd_root = function() return SD end
    p.has_capability = function(name) return S.caps[name] == true end
    p.on = function() end
    p.set_interval = function() end
    p.register_list_item = function(list, label, cb)
        S.rows[#S.rows + 1] = { list = list, label = label, cb = cb }
    end
    p.show_toast = function(message) S.toasts[#S.toasts + 1] = message end
    p.show_settings_list = function(title, items) S.settings = { title = title, items = items } end
    p.show_list = function() end
    p.show_progress = function() return nil end
    p.update_progress = function() return false end
    p.close_progress = function() end
    p.get_current_track_path = function() return S.path end
    p.get_now_playing = function() return S.title, S.artist, S.album, S.duration end
    p.http_request = function(req, cb)
        S.http = { req = req, cb = cb }
        return "handle"
    end
    p.json_decode = function()
        return { syncedLyrics = SYNCED }
    end
    p.refresh_lyrics = function(path)
        if path == nil then error("plugin.refresh_lyrics: invalid track path") end
        S.refresh_args[#S.refresh_args + 1] = path
        S.refresh_calls = S.refresh_calls + 1
        if S.refresh_throw then error(S.refresh_throw) end
        if S.refresh_false or path ~= S.path then return false, "track_changed" end
        return true
    end
    local env = setmetatable({ plugin = p }, { __index = _G })
    _G.COMPAS_PLUGIN_TEST = true
    local chunk, err = loadfile(PLUGIN, "t", env)
    if not chunk then error(err) end
    chunk()
    S.plugin = p
    S.T = _G.COMPAS_PLUGIN_UNDER_TEST
    return S
end

local function row(S, list)
    for _, item in ipairs(S.rows) do
        if item.list == list then return item end
    end
end

local function complete_http(S, status, body, err)
    check(S.http ~= nil and type(S.http.cb) == "function", "HTTP request started")
    if S.http then S.http.cb(status or 200, body or "{}", err, {}) end
end

------------------------------------------------------------------------
-- Identity and sidecar naming

local S = load_plugin()
local T = S.T
check(S.define and S.define.version == "1.3.0", "version is 1.3.0")
check(S.define.api_min == 17, "api_min is 17")
check(T.sidecar_path(MUSIC .. "/song.flac") == MUSIC .. "/song.lrc", "flac sidecar replaces extension")
check(T.sidecar_path(MUSIC .. "/song") == MUSIC .. "/song.lrc", "extensionless file gets .lrc appended")
check(T.sidecar_path("relative/song.flac") == nil, "relative paths are refused")
check(T.has_sync_line(SYNCED) == true, "timestamped LRC is synchronized")
check(T.has_sync_line("[00:01] Hello\n") == true, "timestamp without fraction is synchronized")
check(T.has_sync_line("[00:01.5] Hello\n") == true, "single-digit fraction is synchronized")
check(T.has_sync_line("[ti:Song]\n[00:01.00] Hello\n") == true, "metadata prefix then timestamp is synchronized")
check(T.has_sync_line("\239\187\191[00:01.00] Hello\n") == true, "BOM then timestamp is synchronized")
check(T.has_sync_line("[offset:+10]\n[00:01.00] Hello\n") == true, "offset then timestamp is synchronized")
check(T.has_sync_line(UNSYNCED) == false, "plain text is unsynchronized")
check(T.has_sync_line("[ti:Song]\nHello\n") == false, "metadata tags are not timestamps")
check(T.has_sync_line("") == false, "empty text is unsynchronized")
check(T.has_sync_line("[12:34broken] Hello\n") == false, "malformed timestamp prefix is unsynchronized")
check(T.has_sync_line("[00:01.] Hello\n") == false, "fraction without digits is unsynchronized")
check(T.has_sync_line("Hello [00:01.00] inside\n") == false, "in-text timestamp is unsynchronized")
check(T.sidecar_kind(SYNCED) == "synced", "sidecar_kind synced")
check(T.sidecar_kind(UNSYNCED) == "unsynced", "sidecar_kind unsynced")
check(select(1, T.extract_synced({ syncedLyrics = SYNCED })) == SYNCED, "extract_synced returns LRC")
check(select(1, T.extract_synced({ instrumental = true, syncedLyrics = SYNCED })) == nil, "instrumental is refused")

------------------------------------------------------------------------
-- Player menu registration

check(#S.rows == 2, "library and player rows are both registered")
local library = row(S, "music_library")
local player = row(S, "player")
check(library and library.label == "Lyrics Fetcher", "library row label is Lyrics Fetcher")
check(player and player.label == "Lyrics Fetcher", "player row label is Lyrics Fetcher")
library.cb()
check(S.settings and S.settings.title == "Lyrics Fetcher", "library menu still opens settings")
local fetch_row
for _, item in ipairs(S.settings and S.settings.items or {}) do
    if item.label == "Fetch lyrics for current track" then fetch_row = item end
end
check(fetch_row and type(fetch_row.on_select) == "function", "settings still has Fetch lyrics for current track")

local without_menu = load_plugin({
    caps = { ["network.http.async"] = true, ["data.json"] = true },
})
check(#without_menu.rows == 1, "player row is omitted without ui.player_menu")
check(row(without_menu, "music_library") ~= nil, "library row remains without ui.player_menu")
check(row(without_menu, "player") == nil, "no player row without ui.player_menu")

local menu_only = load_plugin({
    caps = { ["ui.player_menu"] = true },
})
row(menu_only, "player").cb()
check(menu_only.toasts[#menu_only.toasts] == "This player cannot fetch lyrics",
    "player action runs a manual fetch for the current track")

------------------------------------------------------------------------
-- Install: missing dest

local dest = MUSIC .. "/song.lrc"
os.remove(dest)
os.remove(dest .. T.BACKUP_SUFFIX)
os.remove(dest .. T.TEMP_SUFFIX)
local ok, err = T.install_synced_lrc(dest, SYNCED, T.snapshot_sidecar(dest))
check(ok == true and err == nil, "missing sidecar can be written")
check(read_file(dest) == SYNCED, "native .lrc path received synced lyrics")
check(not exists(dest .. T.BACKUP_SUFFIX), "no backup when dest was missing")
check(not exists(MUSIC .. "/song_sync.lrc"), "no unreadable _sync sidecar")

------------------------------------------------------------------------
-- Install: synchronized dest is preserved

ok, err = T.install_synced_lrc(dest, "[00:03.00] Other\n", T.snapshot_sidecar(dest))
check(ok == false and err == "exists", "synchronized sidecar is not replaced")
check(read_file(dest) == SYNCED, "synchronized lyrics stay in place")

------------------------------------------------------------------------
-- Fetch is suppressed when synchronized lyrics already exist

S.http = nil
S.toasts = {}
T.fetch_current(false)
check(S.http == nil, "HTTP is not started for synchronized lyrics")
check(S.toasts[#S.toasts] == "Lyrics already present", "manual fetch reports lyrics already present")

------------------------------------------------------------------------
-- Empty sidecar is unsynchronized and may be replaced
write_file(dest, "")
check(T.snapshot_allows_fetch(T.snapshot_sidecar(dest)) == true, "empty sidecar permits fetch")
ok, err = T.install_synced_lrc(dest, SYNCED, T.snapshot_sidecar(dest))
check(ok == true, "empty sidecar can be replaced")
check(read_file(dest) == SYNCED, "empty sidecar now has synced lyrics")
check(read_file(dest .. T.BACKUP_SUFFIX) == "", "empty sidecar was backed up")
os.remove(dest .. T.BACKUP_SUFFIX)

-- Install: unsynchronized dest is backed up then replaced

write_file(dest, UNSYNCED)
local snap = T.snapshot_sidecar(dest)
check(T.snapshot_allows_fetch(snap) == true, "unsynchronized sidecar permits fetch")
ok, err = T.install_synced_lrc(dest, SYNCED, snap)
check(ok == true, "unsynchronized sidecar can be replaced")
check(read_file(dest) == SYNCED, "native sidecar now has synced lyrics")
check(read_file(dest .. T.BACKUP_SUFFIX) == UNSYNCED, "unsynchronized lyrics were backed up")
check(not exists(MUSIC .. "/song_sync.lrc"), "backup strategy does not invent _sync.lrc")

------------------------------------------------------------------------
-- Occupied first backup slot uses -2

write_file(dest, UNSYNCED)
ok = T.install_synced_lrc(dest, SYNCED, T.snapshot_sidecar(dest))
check(ok == true, "second replace still succeeds")
check(read_file(dest .. T.BACKUP_SUFFIX) == UNSYNCED, "slot 1 backup is left in place")
check(read_file(dest .. T.BACKUP_SUFFIX .. "-2") == UNSYNCED, "next free backup is -2")

------------------------------------------------------------------------
-- Stale content: dest edited mid-request is not overwritten

write_file(dest, UNSYNCED)
snap = T.snapshot_sidecar(dest)
write_file(dest, "Changed lyrics\n")
ok, err = T.install_synced_lrc(dest, SYNCED, snap)
check(ok == false and err == "stale", "changed unsynchronized content is refused")
check(read_file(dest) == "Changed lyrics\n", "edited lyrics remain")

------------------------------------------------------------------------
-- Rollback restores unsynchronized lyrics if the final rename fails

os.remove(dest .. T.BACKUP_SUFFIX)
os.remove(dest .. T.BACKUP_SUFFIX .. "-2")
os.remove(dest .. T.BACKUP_SUFFIX .. "-3")
write_file(dest, UNSYNCED)
snap = T.snapshot_sidecar(dest)
local orig_rename = os.rename
local rename_calls = 0
os.rename = function(a, b)
    rename_calls = rename_calls + 1
    if rename_calls == 2 then return false end
    return orig_rename(a, b)
end
ok, err = T.install_synced_lrc(dest, SYNCED, snap)
os.rename = orig_rename
check(ok == false and err == "rename", "failed promote reports rename")
check(read_file(dest) == UNSYNCED, "unsynchronized lyrics were restored after save failure")
check(not exists(dest .. T.TEMP_SUFFIX), "staging file is removed after rollback")

------------------------------------------------------------------------
-- Fetch unsynchronized sidecar over HTTP, then refresh display

os.remove(dest)
os.remove(dest .. T.BACKUP_SUFFIX)
write_file(dest, UNSYNCED)
S.http = nil
S.refresh_calls = 0
S.refresh_args = {}
S.toasts = {}
T.fetch_current(false)
complete_http(S)
check(read_file(dest) == SYNCED, "HTTP fetch wrote synced lyrics over unsynchronized sidecar")
check(read_file(dest .. T.BACKUP_SUFFIX) == UNSYNCED, "HTTP fetch backed up unsynchronized lyrics")
check(S.refresh_calls == 1, "refresh_lyrics is called after a successful save")
check(S.refresh_args[1] == S.path, "refresh_lyrics received the exact current-track path")
check(S.toasts[#S.toasts] == "Saved lyrics", "manual fetch reports save")

------------------------------------------------------------------------
-- Stale path: song change mid-request does not write

os.remove(dest)
os.remove(dest .. T.BACKUP_SUFFIX)
S.http = nil
S.refresh_calls = 0
S.refresh_args = {}
T.fetch_current(false)
S.path = MUSIC .. "/other.flac"
complete_http(S)
check(not exists(dest), "stale path does not create a sidecar")
check(S.refresh_calls == 0, "stale path does not refresh lyrics")

------------------------------------------------------------------------
-- Missing sidecar fetch writes only the native name

S.path = MUSIC .. "/song.flac"
S.http = nil
S.refresh_calls = 0
S.refresh_args = {}
T.fetch_current(false)
complete_http(S)
check(read_file(dest) == SYNCED, "missing sidecar fetch writes native .lrc")
check(not exists(MUSIC .. "/song_sync.lrc"), "missing sidecar fetch does not write _sync.lrc")
check(S.refresh_calls == 1, "refresh_lyrics runs after writing a missing sidecar")
check(S.refresh_args[1] == S.path, "missing sidecar refresh uses the exact track path")

------------------------------------------------------------------------
-- refresh_lyrics: no argument, native false, throw, stale path

S.refresh_calls = 0
S.refresh_args = {}
check(T.refresh_current_lyrics_display() == false, "helper without a path returns false")
check(T.refresh_current_lyrics_display("") == false, "helper with an empty path returns false")
check(S.refresh_calls == 0, "native refresh is not called without a track path")
check(T.refresh_current_lyrics_display(S.path) == true, "matching path refreshes")
check(S.refresh_args[1] == S.path, "helper passes the exact track path")
check(T.refresh_current_lyrics_display(MUSIC .. "/other.flac") == false, "stale path is not treated as success")
check(S.refresh_args[2] == MUSIC .. "/other.flac", "stale refresh still names the expected path")

os.remove(dest)
os.remove(dest .. T.BACKUP_SUFFIX)
S.http = nil
S.refresh_calls = 0
S.refresh_args = {}
S.refresh_false = true
T.fetch_current(false)
complete_http(S)
check(read_file(dest) == SYNCED, "save is kept when native refresh returns false")
check(S.refresh_args[1] == S.path, "false refresh still received the exact track path")
S.refresh_false = false

os.remove(dest)
S.http = nil
S.refresh_calls = 0
S.refresh_args = {}
S.refresh_throw = "plugin.refresh_lyrics: invalid track path"
T.fetch_current(false)
complete_http(S)
check(read_file(dest) == SYNCED, "save is kept when native refresh throws")
check(S.refresh_calls == 1, "throwing refresh was invoked with a path")
S.refresh_throw = nil

------------------------------------------------------------------------
-- Open/read errors other than ENOENT block fetch and preserve the file

write_file(dest, UNSYNCED)
local orig_open = io.open
io.open = function(path, mode)
    if path == dest then return nil, "Permission denied", 13 end
    return orig_open(path, mode)
end
local _, open_status = T.read_sidecar(dest)
local blocked_snap = T.snapshot_sidecar(dest)
S.http = nil
S.toasts = {}
T.fetch_current(false)
io.open = orig_open
check(open_status == "unreadable", "non-ENOENT open is unreadable")
check(blocked_snap.kind == "blocked", "non-ENOENT open blocks the snapshot")
check(S.http == nil, "non-ENOENT open does not start a fetch")
check(read_file(dest) == UNSYNCED, "existing file is preserved on open error")

write_file(dest, UNSYNCED)
io.open = function(path, mode)
    local f, err, code = orig_open(path, mode)
    if path == dest and f then
        f:close()
        return {
            read = function() return nil, "Input/output error" end,
            close = function() return true end,
        }
    end
    return f, err, code
end
local read_text, read_status = T.read_sidecar(dest)
S.http = nil
T.fetch_current(false)
io.open = orig_open
check(read_text == nil and read_status == "unreadable", "read nil,error is unreadable")
check(S.http == nil, "read error does not start a fetch")
check(read_file(dest) == UNSYNCED, "existing file is preserved on read error")

os.remove(dest)
local missing_text, missing_status = T.read_sidecar(dest)
check(missing_text == nil and missing_status == "missing", "ENOENT is missing")
write_file(dest, "")
local empty_text, empty_status = T.read_sidecar(dest)
check(empty_text == "" and empty_status == "ok", "nil read without error is empty EOF")

------------------------------------------------------------------------
os.execute("rm -rf '" .. SD .. "'")
_G.COMPAS_PLUGIN_TEST = nil
_G.COMPAS_PLUGIN_UNDER_TEST = nil

if failures == 0 then
    print("ok " .. checks .. " checks")
else
    print(failures .. " failed, " .. checks .. " checks")
    os.exit(1)
end
