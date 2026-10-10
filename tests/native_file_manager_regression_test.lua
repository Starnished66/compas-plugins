-- Regression suite for native API 16 File Manager integration in Audiobooks and Podcasts.
local audiobook_file = arg[1] or "plugins/Audiobooks/Audiobooks.lua"
local podcast_file = arg[2] or "plugins/Podcasts/Podcasts.lua"

local root = os.tmpname(); os.remove(root)
assert(os.execute("mkdir -p '" .. root .. "/.plugins' '" .. root .. "/Audiobooks' '" .. root .. "/Podcasts'"))

local dirs, screens, lists, events, toasts = {}, {}, {}, {}, {}
local home, tick, current, position, duration = nil, nil, nil, 0, 900
local speed_scope, speed_rate = nil, 1.0
local skip_dir, skip_seconds = nil, 0
local opened_manager_folder = nil
local file_manager_enabled = true
local file_manager_error = nil
local file_manager_throw = false
local current_audiobook_book = nil

local function fixture(relative, contents)
    local path = root .. "/" .. relative
    local dir = path:match("^(.*)/[^/]+$")
    if dir then assert(os.execute("mkdir -p '" .. dir .. "'")) end
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
    define = function() end,
    sd_root = function() return root end,
    has_capability = function(name)
        if name == "ui.file_manager" then return file_manager_enabled end
        return name == "playback.progress" or name == "playback.speed"
            or name == "playback.transport_skip" or name == "filesystem.mkdir"
            or name == "ui.settings_list_wrap" or name == "ui.list_wrap"
            or name == "network.http.async" or name == "network.http.download"
    end,
    list_dir = function(path) return dirs[path] or {} end,
    mkdir = function(path)
        dirs[path] = dirs[path] or {}
        return true
    end,
    open_file_manager = function(folder)
        if file_manager_throw then error("simulated file manager failure") end
        if file_manager_error then return nil, file_manager_error end
        opened_manager_folder = folder
        return true
    end,
    show_toast = function(msg) toasts[#toasts + 1] = msg end,
    register_list_item = function(_, _, cb) home = cb end,
    register_stream_media_tile = function(_, cb) home = cb end,
    show_settings_list = function(title, rows) screens[title] = rows end,
    show_list = function(title, rows, cb) lists[#lists + 1] = { title = title, rows = rows, callback = cb } end,
    on = function(name, cb) events[name] = cb end,
    set_interval = function(_, cb) tick = cb; return 1 end,
    get_current_track_path = function() return current end,
    get_position = function() return position end,
    get_duration = function() return duration end,
    is_playing = function() return true end,
    is_paused = function() return false end,
    toggle_pause = function() end,
    stop = function() end,
    seek = function(target) position = target end,
    get_playback_progress = function(path)
        return { position = position, duration = duration, playing = true, paused = false, terminal = "active" }
    end,
    play_file = function(path)
        current, position = path, 0
        if events.track_started then events.track_started() end
    end,
    get_play_mode = function() return "sequential" end,
    play_list = function(paths, index)
        current, position = paths[index], 0
        if events.track_started then events.track_started() end
    end,
    set_playback_speed = function(dir, speed)
        speed_scope, speed_rate = dir, speed
        return true
    end,
    set_transport_skip = function(dir, seconds)
        skip_dir, skip_seconds = dir, seconds
        return true
    end,
    md5 = function() return "0123456789abcdef0123456789abcdef" end,
}

local function load_plugin(path)
    screens, lists, events, toasts = {}, {}, {}, {}
    local env = setmetatable({ plugin = plugin }, { __index = _G })
    assert(loadfile(path, "t", env))()
end

local function find_row(rows, prefix)
    for _, r in ipairs(rows) do
        local label = type(r) == "table" and r.label or r
        if label and label:sub(1, #prefix) == prefix then return r end
    end
    error("Missing row with prefix: " .. prefix)
end

local function select_list_item(prefix)
    local list = assert(lists[#lists], "No list on screen")
    for i, r in ipairs(list.rows) do
        local label = type(r) == "table" and r.label or r
        if label and label:sub(1, #prefix) == prefix then
            list.callback(i)
            return
        end
    end
    error("Missing list item with prefix: " .. prefix)
end

print("--- Testing Audiobooks Native File Manager Integration ---")
load_plugin(audiobook_file)
home()

-- 1. Main home screen "Browse folders" opens sd_root()/Audiobooks
opened_manager_folder = nil
find_row(screens.Audiobooks, "Browse folders").on_select()
assert(opened_manager_folder == root .. "/Audiobooks",
    "Audiobooks Browse folders opens native File Manager at sd_root()/Audiobooks")

-- 2. Missing capability handling
file_manager_enabled = false
toasts = {}
opened_manager_folder = nil
find_row(screens.Audiobooks, "Browse folders").on_select()
assert(opened_manager_folder == nil, "File Manager must not be called when capability is absent")
assert(#toasts > 0 and toasts[#toasts]:find("not supported"), "Toast warns missing capability")
file_manager_enabled = true

-- 3. Error returned by open_file_manager
file_manager_error = "folder does not exist"
toasts = {}
find_row(screens.Audiobooks, "Browse folders").on_select()
assert(#toasts > 0 and toasts[#toasts]:find("folder does not exist"), "Toast reports File Manager error")
file_manager_error = nil

-- 4. Lua error raised by open_file_manager
file_manager_throw = true
toasts = {}
find_row(screens.Audiobooks, "Browse folders").on_select()
assert(#toasts > 0 and toasts[#toasts]:find("Could not open File Manager"), "Toast catches thrown error")
file_manager_throw = false

-- 5. Nested Audiobook Playback via native File Manager (without prior library scan)
-- Nested file: Audiobooks/Brandon Sanderson/Mistborn/The Final Empire/CD1/track01.mp3
local disc_track1 = fixture("Audiobooks/Brandon Sanderson/Mistborn/The Final Empire/CD1/track01.mp3")
local disc_track2 = fixture("Audiobooks/Brandon Sanderson/Mistborn/The Final Empire/CD1/track02.mp3")

current = disc_track1
position = 0
events.track_started()

-- Let tick advance and save progress
for _ = 1, 3 do tick() end
position = 210
for _ = 1, 15 do tick() end

-- Verify state file persisted the correct book identity and relative file
local state_file = assert(io.open(root .. "/.plugins/.audiobooks_state_v3"))
local raw_state = state_file:read("*a"); state_file:close()
local expected_key = encode("Brandon Sanderson/Mistborn/The Final Empire")
local expected_file = encode("CD1/track01.mp3")
assert(raw_state:find("P\t" .. expected_key .. "\t" .. expected_file .. "\t210", 1, true),
    "Playing nested audiobook file via native manager saves state with correct book key and disc-relative file")

-- Verify Home screen shows Continue listening for this book
home()
local continue_row = find_row(screens.Audiobooks, "Continue listening:")
assert(continue_row.label:find("The Final Empire"), "Continue listening shows book title")
assert(continue_row.label:find("Brandon Sanderson"), "Continue listening shows author")

-- Resuming sets current to the tracked track and position
current, position = nil, 0
continue_row.on_select()
assert(current == disc_track1, "Continue listening resumes the nested file")

-- 6. Open Book controls for the book and verify "Open folder in File Manager"
home()
find_row(screens.Audiobooks, "Authors").on_select()
select_list_item("Brandon Sanderson")
select_list_item("The Final Empire")
local book_controls = assert(screens["Book controls"], "Book controls opened")
local open_folder_row = find_row(book_controls, "Open folder in File Manager")
opened_manager_folder = nil
open_folder_row.on_select()
local expected_dir = root .. "/Audiobooks/Brandon Sanderson/Mistborn/The Final Empire"
assert(opened_manager_folder == expected_dir,
    "Book controls opens the audiobook's folder in native File Manager")

-- 7. Transport skip and playback speed configured on Audiobooks root
assert(speed_scope == root .. "/Audiobooks", "Audiobooks speed scope set on Audiobooks root")
assert(skip_dir == root .. "/Audiobooks", "Audiobooks transport skip set on Audiobooks root")

print("--- Audiobooks Native File Manager tests passed ---")

print("--- Testing Podcasts Native File Manager Integration ---")
load_plugin(podcast_file)
home()

-- 1. Main home screen "Downloads" action opens native File Manager at sd_root()/Podcasts
opened_manager_folder = nil
select_list_item("Downloads")
assert(opened_manager_folder == root .. "/Podcasts",
    "Podcasts main Downloads opens native File Manager at sd_root()/Podcasts")

-- 2. Missing capability handling
file_manager_enabled = false
toasts = {}
opened_manager_folder = nil
home()
select_list_item("Downloads")
assert(opened_manager_folder == nil, "Podcasts File Manager not called without capability")
assert(#toasts > 0 and toasts[#toasts]:find("not supported"), "Toast warns missing capability")
file_manager_enabled = true

-- 3. Error handling from open_file_manager
file_manager_error = "File Manager busy"
toasts = {}
home()
select_list_item("Downloads")
assert(#toasts > 0 and toasts[#toasts]:find("File Manager busy"), "Toast reports manager error")
file_manager_error = nil

-- 4. Manage downloads business view preserves offline workflows and provides native folder entry
home()
select_list_item("Manage downloads")
local manager = screens["Manage downloads"]
assert(manager, "Manage downloads screen opened")
assert(find_row(manager, "All downloads"), "All downloads metadata view preserved")
assert(find_row(manager, "Not played"), "Not played shelf preserved")
assert(find_row(manager, "Played"), "Played shelf preserved")
assert(find_row(manager, "Delete played downloads"), "Delete played downloads cleanup preserved")

opened_manager_folder = nil
find_row(manager, "Downloads folder (File Manager)").on_select()
assert(opened_manager_folder == root .. "/Podcasts",
    "Manage downloads row opens native File Manager at sd_root()/Podcasts")

-- 5. Downloaded episode played from native File Manager uses resume and downloaded-only speed
local ep_file = fixture("Podcasts/Science Hour/Episode 42 [12345678].mp3")
local ep_key = "science-hour|guid-42"
local progress_line = table.concat({
    "P", encode(ep_key), "150", "900", "0", "0", encode(ep_file), "1000", encode("Episode 42"), "", "0"
}, "\t") .. "\n"
fixture("Podcasts/.progress.tsv", progress_line)
fixture("Podcasts/.settings", "playback_speed\t1.5\n")

-- Reload Podcasts so it reads the progress and settings
load_plugin(podcast_file)

-- Native File Manager triggers track_started for the downloaded episode
current = ep_file
position = 0
events.track_started()

-- Pending seek should restore saved position (150s)
for _ = 1, 5 do tick() end
assert(position == 150, "Downloaded episode played from manager resumes at saved position")

-- While playing, position advances and is saved
position = 220
for _ = 1, 10 do tick() end
local saved_progress = assert(io.open(root .. "/Podcasts/.progress.tsv")):read("*a")
assert(saved_progress:find("\t220\t900\t0\t", 1, true), "Playback position is updated and saved")

-- Speed scope is applied to Podcasts root
assert(speed_scope == root .. "/Podcasts" and speed_rate == 1.5,
    "Playback speed is applied to Podcasts folder")

-- Non-downloaded/external file playback does NOT apply podcast speed
current = "https://example.test/stream.mp3"
position = 0
events.track_started()
for _ = 1, 5 do tick() end
-- When playing stream, speed scope was not set to stream
assert(speed_scope == root .. "/Podcasts", "Stream playback does not steal or reapply speed scope")

print("--- Podcasts Native File Manager tests passed ---")

assert(os.execute("rm -rf '" .. root .. "'"))
print("All Native File Manager regression tests passed successfully!")
