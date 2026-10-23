-- Host test of the native Audiobooks ReadingRoom registration and reused
-- speed-choice callback. The tested blocks are loaded from Audiobooks.lua.
-- Run with: lua tools/test_audiobooks_player_layout.lua
local function source_between(source, start_marker, end_marker)
    local first = assert(source:find(start_marker, 1, true), "missing source marker: " .. start_marker)
    local last = assert(source:find(end_marker, first + #start_marker, true), "missing source marker: " .. end_marker)
    return source:sub(first, last - 1)
end

local file = assert(io.open("plugins/Audiobooks/Audiobooks.lua", "r"))
local source = file:read("*a")
file:close()
assert(source:match('plugin%.define%(%{.-api_min = 17'), "Audiobooks requires API 17")
local speed_block = source_between(source, "open_speed_menu = function(refresh_settings)", "\n\nlocal function cap")
local registration_start = assert(source:find("-- The Reading Room is registered", 1, true))
local registration_block = source:sub(registration_start)

local current, position, duration = nil, 9, 100
local storage, layouts, actions, items, events = { reading_room_auto_apply = "0" }, {}, {}, {}, {}
local restored, seeks, applied_speeds = 0, {}, {}
local save_fails, saved_speed, settings_refreshes = false, nil, 0
local last_title, last_choices, last_choice_callback
local capable = false
local owned_layout
local ROOT = "/sd/Audiobooks"

local env
env = {
    ROOT = ROOT,
    READING_ROOM_AUTO_KEY = "reading_room_auto_apply",
    plugin = {
        has_capability = function() return capable end,
        storage = {
            get = function(key, default) local value = storage[key]; if value == nil then return default end; return value end,
            set = function(key, value) storage[key] = value end,
        },
        set_player_layout = function(layout)
            layouts[#layouts + 1] = layout
            owned_layout = layout.id
        end,
        restore_player_layout = function()
            if owned_layout ~= "example.audiobooks.reading_room" then return false end
            restored = restored + 1
            owned_layout = nil
            return true
        end,
        register_player_action = function(name, callback) actions[name] = callback end,
        register_list_item = function(_, name, callback) items[name] = callback end,
        on = function(name, callback) events[name] = callback end,
        get_current_track_path = function() return current end,
        get_position = function() return position end,
        get_duration = function() return duration end,
        seek = function(value) seeks[#seeks + 1] = value end,
        set_playback_speed = function(root, speed) applied_speeds[#applied_speeds + 1] = { root, speed }; return true end,
        show_list = function(title, choices, callback)
            last_title, last_choices, last_choice_callback = title, choices, callback
        end,
        show_toast = function() end,
    },
    open_library = function() end,
    open_book = function(book) env.opened_book = book end,
    book_for_path = function(path)
        if type(path) == "string" and path:sub(1, #ROOT + 1) == ROOT .. "/" then return { path = path } end
    end,
    current_audiobook_path = function()
        if type(current) == "string" and current:sub(1, #ROOT + 1) == ROOT .. "/" then return current end
    end,
    finite = function(value, lo, hi)
        return type(value) == "number" and value == value and value ~= math.huge
            and value ~= -math.huge and value >= lo and value <= hi
    end,
    speed_supported = function() return true end,
    speed_waiting_for_resume = function() return false end,
    apply_speed = function(value) applied_speeds[#applied_speeds + 1] = { ROOT, value }; return true end,
    save_settings = function()
        if save_fails then return false end
        saved_speed = env.get_playback_speed()
        return true
    end,
    open_settings = function(update)
        assert(update == true)
        settings_refreshes = settings_refreshes + 1
    end,
}
setmetatable(env, { __index = _G })

local chunk = "local open_speed_menu\n"
    .. "local playback_speed, speed_retry_pending = 1.0, false\n"
    .. "local SPEEDS = { 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0 }\n"
    .. "get_playback_speed = function() return playback_speed end\n"
    .. speed_block .. "\n"
    .. registration_block
local loaded, err = load(chunk, "Audiobooks player layout test", "t", env)
assert(loaded, err)
loaded()

local function check(value, message) assert(value, message) end
check(actions.speed_menu ~= nil and events.track_started ~= nil, "native actions and event register")
check(actions.reading_menu and actions.rewind_15 and actions.forward_15,
    "player actions register when the runtime capability API reports false")
check(layouts[1].id == "example.audiobooks.reading_room", "native layout identity")
check(storage.reading_room_auto_apply == "0", "legacy opt-out preference remains untouched")
check(next(items) == nil, "Audiobooks adds no Reading Room display configuration rows")

current = "/sd/Audiobooks/Book/chapter.m4b"
events.track_started()
check(#layouts == 2, "Audiobook descendant auto-applies even with a legacy opt-out")
actions.speed_menu()
check(last_title == "Playback speed" and #last_choices == 7, "speed action opens the existing choices directly")
last_choice_callback(6)
check(applied_speeds[#applied_speeds][1] == ROOT and applied_speeds[#applied_speeds][2] == 1.75,
    "speed selection uses the existing apply path and Audiobooks root")
check(saved_speed == 1.75, "speed selection persists")

local before_failure = env.get_playback_speed()
actions.speed_menu()
save_fails = true
last_choice_callback(7)
check(env.get_playback_speed() == before_failure, "failed persistence rolls speed back")
save_fails = false
actions.speed_menu()
local speed_before_music_switch = env.get_playback_speed()
current = "/sd/Music/song.mp3"
last_choice_callback(1)
check(env.get_playback_speed() == speed_before_music_switch,
    "direct speed chooser ignores a selection after playback leaves Audiobooks")

current = "/sd/Audiobooks-old/Book/chapter.m4b"
local before_near_match = #layouts
events.track_started()
check(#layouts == before_near_match, "near-match folder does not auto-apply")
check(restored == 1, "leaving Audiobooks for a near-match restores the owned layout")
current = "/sd/Music/song.mp3"
events.track_started()
check(restored == 1, "music playback does not restore a layout the plugin no longer owns")

current = "/sd/Audiobooks/Book/chapter.m4b"
events.track_started()
position = 4
actions.rewind_15()
check(seeks[#seeks] == 0, "rewind clamps at zero")
position = 95
actions.forward_15()
check(seeks[#seeks] == duration, "forward clamps at duration")

events.track_started()
owned_layout = "native.user.layout"
local before_user_layout_leave = restored
current = "/sd/Music/song.mp3"
events.track_started()
check(owned_layout == "native.user.layout" and restored == before_user_layout_leave,
    "leaving playback preserves a native user layout")

print("Audiobooks ReadingRoom tests passed")
