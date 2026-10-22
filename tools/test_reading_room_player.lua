-- Host test for examples/ReadingRoomPlayer/ReadingRoomPlayer.lua.
-- Run with: lua tools/test_reading_room_player.lua
local SD = "/sd"
local storage, actions, items, events, layouts = {
    use_for_audiobooks_folder = "0",
    use_for_podcasts_folder = "0",
}, {}, {}, {}, {}
local current, speed_root, restored, position = nil, nil, 0, 20
plugin = {
    define = function(def) assert(def.api_min == 17, "Reading Room requires API 17") end,
    has_capability = function() return true end,
    sd_root = function() return SD end,
    storage = {
        get = function(key, default) local v = storage[key]; if v == nil then return default end; return v end,
        set = function(key, value) storage[key] = value end,
    },
    set_player_layout = function(layout) layouts[#layouts + 1] = layout end,
    restore_player_layout = function() restored = restored + 1; return true end,
    register_player_action = function(name, callback) actions[name] = callback end,
    register_list_item = function(_, name, callback) items[name] = callback end,
    on = function(name, callback) events[name] = callback end,
    get_current_track_path = function() return current end,
    get_now_playing = function() return "Title", "Author", "Album" end,
    show_toast = function() end,
    show_list = function(_, rows, callback) _G.last_list_callback = callback end,
    set_playback_speed = function(root) speed_root = root; return true end,
    get_position = function() return position end,
    get_duration = function() return 100 end,
    seek = function(position) _G.last_seek = position end,
}
dofile("examples/ReadingRoomPlayer/ReadingRoomPlayer.lua")

local function check(value, message) assert(value, message) end
check(storage.use_for_audiobooks_folder == "0" and storage.use_for_podcasts_folder == "0",
    "legacy folder opt-outs remain untouched")
check(next(items) == nil, "Reading Room adds no display configuration rows")

current = "/sd/Podcasts/Show/episode.mp3"
events.track_started()
check(#layouts == 2, "Podcast playback automatically applies the layout")
actions.speed_menu()
last_list_callback(4)
check(speed_root == "/sd/Podcasts", "Podcast speed uses the Podcast root")
local prior_speed_root = speed_root
actions.speed_menu()
current = "/sd/Audiobooks/Book/chapter.mp3"
last_list_callback(5)
check(speed_root == prior_speed_root, "speed callback rejects a switch to another root")

current = "/sd/Podcasts-old/episode.mp3"
events.track_started()
check(restored == 1, "near-match folder restores the preferred layout")
current = "/sd/Music/song.mp3"
events.track_started()
check(restored == 2, "music restores the preferred layout")

current = "/sd/Audiobooks/Book/chapter.mp3"
events.track_started()
check(#layouts == 3, "Audiobook playback automatically applies the layout")
actions.speed_menu()
last_list_callback(4)
check(speed_root == "/sd/Audiobooks", "Audiobook speed uses the Audiobook root")
position = 5
actions.rewind_15()
check(last_seek == 0, "rewind clamps to zero")
position = 95
actions.forward_15()
check(last_seek == 100, "forward clamps to duration")

local seeks_before_music = last_seek
current = "/sd/Music/song.mp3"
actions.forward_15()
check(last_seek == seeks_before_music, "skip actions do nothing for music")
print("Reading Room Player tests passed")
