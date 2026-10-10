-- Exercise the real plugin entry points; keep saved paths and state intact.
local audiobook_file = assert(arg[1])
local podcast_file = assert(arg[2])
local root = os.tmpname(); os.remove(root)
assert(os.execute("mkdir -p '" .. root .. "/.plugins'"))
local dirs, screens, lists, events = {}, {}, {}, {}
local home, tick, current, position = nil, nil, nil, 0
local audiobook_mode, refuse_play, opened_folder = true, false, nil
local function fixture(relative, contents)
    local path = root .. "/" .. relative
    assert(os.execute("mkdir -p '" .. path:match("^(.*)/[^/]+$") .. "'"))
    local f = assert(io.open(path, "w")); f:write(contents or "audio"); f:close()
    local parent = root
    local parts = {}; for part in relative:gmatch("[^/]+") do parts[#parts + 1] = part end
    for i, part in ipairs(parts) do
        dirs[parent] = dirs[parent] or {}
        local exists = false
        for _, e in ipairs(dirs[parent]) do if e.name == part then exists = true end end
        if not exists then dirs[parent][#dirs[parent] + 1] = { name = part, dir = i < #parts } end
        parent = parent .. "/" .. part
    end
    return path
end
local function encode(value)
    return (value:gsub("([^%w%._%- ])", function(c) return string.format("%%%02X", c:byte()) end))
end
local plugin = {
    define = function() end, sd_root = function() return root end,
    has_capability = function(name) return (audiobook_mode and name == "playback.progress") or name == "network.http.async" or name == "network.http.download"
        or name == "filesystem.mkdir" or name == "ui.file_manager" end,
    list_dir = function(path) return dirs[path] or {} end,
    mkdir = function() return true end,
    open_file_manager = function(folder) opened_folder = folder; return true end,
    register_list_item = function(_, _, cb) home = cb end,
    register_stream_media_tile = function(_, cb) home = cb end,
    show_settings_list = function(title, rows) screens[title] = rows end,
    show_list = function(title, rows, cb) lists[#lists + 1] = { title = title, rows = rows, callback = cb } end,
    show_toast = function(message) plugin_toast = message end,
    on = function(name, cb) events[name] = cb end,
    set_interval = function(_, cb) tick = cb; return 1 end,
    get_current_track_path = function() return current end,
    get_position = function() return position end, get_duration = function() return 900 end,
    is_playing = function() return true end, is_paused = function() return false end,
    seek = function(target) if audiobook_mode then position = target end end,
    get_playback_progress = function(path) return { position = position, duration = 900, playing = true, paused = false, terminal = "active" } end,
    play_file = function(path) if not refuse_play then current = path; events.track_started() end end,
    get_play_mode = function() return "sequential" end,
    play_list = function(paths, index) current = paths[index]; events.track_started() end,
    set_transport_skip = function() return true end,
    md5 = function() return "0123456789abcdef0123456789abcdef" end,
}
local function load_plugin(path)
    local env = setmetatable({ plugin = plugin }, { __index = _G })
    assert(loadfile(path, "t", env))()
end
local function row(rows, prefix)
    for _, r in ipairs(rows) do if r.label:sub(1, #prefix) == prefix then return r end end
    error("Missing row " .. prefix)
end
local function select_list(prefix)
    local list = assert(lists[#lists])
    for i, r in ipairs(list.rows) do
        if r.label:sub(1, #prefix) == prefix then list.callback(i); return end
    end
    error("Missing list row " .. prefix)
end
fixture("Audiobooks/Standalone/CD1/01.mp3")
fixture("Audiobooks/Writer/Single/01.mp3")
fixture("Audiobooks/Writer/cover.jpg") -- sidecars do not hide Author folders
fixture("Audiobooks/Writer/Saga/Book 10/01.mp3")
local resume_path = fixture("Audiobooks/Writer/Saga/Book 2/CD1/01.mp3")
fixture("Audiobooks/Other/Saga/Book A/01.mp3")
fixture("Audiobooks/Loose.mp3")
local state = "P\tWriter/Saga\tBook 2/CD1/01.mp3\t120\t900\t0\t1000\nB\tWriter/Saga\tBook 2/CD1/01.mp3\t125\tbookmark\n"
fixture(".plugins/.audiobooks_state_v3", state)
load_plugin(audiobook_file); home()
opened_folder = nil
row(screens.Audiobooks, "Browse folders").on_select()
assert(opened_folder == root .. "/Audiobooks", "Audiobooks Browse folders opens native File Manager at sd_root()/Audiobooks")
row(screens.Audiobooks, "Authors").on_select()
select_list("Writer")
local list = lists[#lists]
assert(row(list.rows, "Book 2")); assert(row(list.rows, "Book 10")); assert(row(list.rows, "Single"))
local second, tenth
for i, r in ipairs(list.rows) do
    if r.label:sub(1,6) == "Book 2" then second = i end
    if r.label:sub(1,7) == "Book 10" then tenth = i end
end
assert(second < tenth, "natural series ordering")
row(screens.Audiobooks, "Series").on_select()
assert(row(lists[#lists].rows, "Writer / Saga")); assert(row(lists[#lists].rows, "Other / Saga"))
select_list("Writer / Saga")
assert(row(lists[#lists].rows, "Book 2")); assert(row(lists[#lists].rows, "Saga (saved collection)"))
home()
row(screens.Audiobooks, "Continue listening:").on_select()
assert(current == resume_path, "legacy aggregate resume path is preserved")
for _ = 1, 3 do tick() end
position = 133
for _ = 1, 12 do tick() end
local f = assert(io.open(root .. "/.plugins/.audiobooks_state_v3")); local raw = f:read("*a"); f:close()
assert(raw:find("P\t" .. encode("Writer/Saga") .. "\t" .. encode("Book 2/CD1/01.mp3") .. "\t133", 1, true),
    "legacy collection keeps ownership while listening")
assert(not raw:find("P\t" .. encode("Writer/Saga/Book 2") .. "\t", 1, true), "split shelf must not steal progress")

local f = assert(io.open(root .. "/.plugins/.audiobooks_state_v3")); local saved = f:read("*a"); f:close()
assert(saved:find("B\t" .. encode("Writer/Saga") .. "\t" .. encode("Book 2/CD1/01.mp3") .. "\t125\tbookmark", 1, true), "legacy bookmark preserved")

-- Large shelves stay inside the four plain-list slots even when one author
-- needs several book pages and the author list itself needs ranges.
local lib = root .. "/Audiobooks"
for i = 1, 510 do
    local author = "Writer " .. i
    dirs[lib][#dirs[lib] + 1] = { name = author, dir = true }
    dirs[lib .. "/" .. author] = { { name = "Book", dir = true } }
    dirs[lib .. "/" .. author .. "/Book"] = { { name = "01.mp3", dir = false } }
end
dirs[lib][#dirs[lib] + 1] = { name = "Big Writer", dir = true }
dirs[lib .. "/Big Writer"] = {}
for i = 1, 550 do
    dirs[lib .. "/Big Writer"][i] = { name = "Book " .. i, dir = true }
    dirs[lib .. "/Big Writer/Book " .. i] = { { name = "01.mp3", dir = false } }
end
current, events, lists = nil, {}, {}
load_plugin(audiobook_file); home()
row(screens.Audiobooks, "Authors").on_select()
assert(#lists[#lists].rows <= 500)
lists[#lists].callback(1) -- first author range
select_list("Big Writer")
assert(#lists[#lists].rows == 500, "large author is split before opening its books")
assert(#lists == 3, "range, shelf, books leave room for chapters")

-- Podcast cleanup retains the active file and all unplayed downloads.
local played = fixture("Podcasts/Show/Played.mp3")
local active = fixture("Podcasts/Show/Active.mp3")
local unplayed = fixture("Podcasts/Show/Unplayed.mp3")
local lines = {}
for i, path in ipairs({ played, active, unplayed }) do
    lines[#lines + 1] = table.concat({ "P", encode("0123456789abcdef|" .. i), "120", "900",
        i < 3 and "1" or "0", "0", encode(path), "1000", encode("Episode " .. i), "", "0" }, "\t")
end
fixture("Podcasts/.progress.tsv", table.concat(lines, "\n") .. "\n")
audiobook_mode = false
current, position, events, lists = active, 0, {}, {}
load_plugin(podcast_file); home()
opened_folder = nil
select_list("Downloads")
assert(opened_folder == root .. "/Podcasts", "Podcasts main Downloads opens native File Manager at sd_root()/Podcasts")
home()
select_list("Manage downloads")
local manager = screens["Manage downloads"]
opened_folder = nil
row(manager, "Downloads folder (File Manager)").on_select()
assert(opened_folder == root .. "/Podcasts", "Manage downloads row opens native File Manager at sd_root()/Podcasts")
assert(row(manager, "Played (2)")); assert(row(manager, "Not played (1)"))
local cleanup = row(manager, "Delete played downloads").on_select
cleanup(); local f = assert(io.open(played)); f:close() -- first tap does not delete
cleanup()
assert(not io.open(played), "confirmed cleanup deletes played file")
for _, path in ipairs({ active, unplayed }) do local f = assert(io.open(path)); f:close() end
assert(row(screens["Manage downloads"], "Played (1)"))
row(screens["Manage downloads"], "Not played (1)").on_select()
select_list("Unsubscribed")
select_list("Resume")
for _ = 1, 25 do tick() end
local f = assert(io.open(root .. "/Podcasts/.progress.tsv")); local raw = f:read("*a"); f:close()
assert(raw:find("\t120\t900\t0\t", 1, true), "failed seek never overwrites saved resume")
select_list("Resume") -- explicitly retry the guarded resume
position = 120; tick()
assert(current == unplayed)
-- A listener who continues after failed resume can still advance safely.
current, position = unplayed, 0; events.track_started()
for _ = 1, 25 do tick() end
position = 150
for _ = 1, 10 do tick() end
local f = assert(io.open(root .. "/Podcasts/.progress.tsv")); local raw = f:read("*a"); f:close()
assert(raw:find("\t150\t900\t0\t", 1, true), "forward listening advances after failed resume")
refuse_play, position = true, 0
select_list("Resume")
for _ = 1, 25 do tick() end
local f = assert(io.open(root .. "/Podcasts/.progress.tsv")); local raw = f:read("*a"); f:close()
assert(raw:find("\t150\t900\t0\t", 1, true), "refused Resume retry also preserves the saved point")
assert(os.execute("rm -rf '" .. root .. "'"))
print("Audiobook shelves and podcast offline workflow tests passed")
