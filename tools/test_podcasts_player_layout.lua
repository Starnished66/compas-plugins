-- Mocked player test for the native Podcasts Reading Room integration.
-- Run with: lua tools/test_podcasts_player_layout.lua

local ROOT = "/mock-sd/Podcasts"
local episode = ROOT .. "/Show/episode.mp3"
local original_open, original_rename, original_remove = io.open, os.rename, os.remove
local settings_contents = ""
io.open = function(path, mode)
    if path == ROOT .. "/.progress.tsv" and mode == "r" then
        local first = true
        local body = "P\tkey\t0\t100\t0\t0\t%2Fmock-sd%2FPodcasts%2FShow%2Fepisode.mp3\t0\tEpisode\t\t0\n"
        return {
            read = function(_, amount)
                if first then first = false; return body end
                return nil
            end,
            close = function() end,
        }
    end
    if path == ROOT .. "/.settings" and mode == "r" and settings_contents ~= "" then
        local consumed = false
        return {
            read = function(_, format)
                if consumed then return nil end
                consumed = true
                return settings_contents:match("([^\n]+)")
            end,
            close = function() end,
        }
    end
    if path == ROOT .. "/.settings.tmp" and mode == "w" then
        local chunks = {}
        return {
            write = function(_, value) chunks[#chunks + 1] = value; return true end,
            close = function() settings_contents = table.concat(chunks); return true end,
        }
    end
    return nil
end
os.rename = function(from, to)
    if from == ROOT .. "/.settings.tmp" and to == ROOT .. "/.settings" then return true end
    return original_rename(from, to)
end
os.remove = function(path)
    if path == ROOT .. "/.settings.tmp" then return true end
    return original_remove(path)
end

local function boot(capabilities)
    local state = {
        storage = { reading_room_auto_apply = "0" }, actions = {}, events = {}, layouts = {}, restores = 0,
        settings_calls = 0, speed_calls = {}, seeks = {}, current = episode,
        now_playing = { "Episode", "Host", "Show" },
        position = 20, toasts = {}, minimum_api = nil,
    }
    plugin = {
        define = function(definition) state.minimum_api = definition.api_min end,
        sd_root = function() return "/mock-sd" end,
        has_capability = function(name) return capabilities[name] == true end,
        storage = {
            get = function(key, default)
                local value = state.storage[key]
                if value == nil then return default end
                return value
            end,
            set = function(key, value) state.storage[key] = value end,
        },
        set_player_layout = function(layout) state.layouts[#state.layouts + 1] = layout end,
        restore_player_layout = function() state.restores = state.restores + 1; return true end,
        register_player_action = function(name, callback) state.actions[name] = callback end,
        register_list_item = function(category, name, callback)
            assert(category ~= "display", "Podcasts must not add player-layout configuration rows")
            state.list_items = state.list_items or {}; state.list_items[name] = callback
        end,
        on = function(name, callback) state.events[name] = callback end,
        show_list = function(title, rows, callback)
            state.last_list = { title = title, rows = rows, callback = callback }
        end,
        show_settings_list = function(title, rows)
            state.settings_calls = state.settings_calls + 1
            state.last_settings = { title = title, rows = rows }
        end,
        show_toast = function(message) state.toasts[#state.toasts + 1] = message end,
        get_current_track_path = function() return state.current end,
        get_now_playing = function()
            return state.now_playing[1], state.now_playing[2], state.now_playing[3]
        end,
        get_position = function() return state.position end,
        get_duration = function() return 100 end,
        seek = function(position) state.seeks[#state.seeks + 1] = position end,
        set_playback_speed = function(root, speed)
            state.speed_calls[#state.speed_calls + 1] = { root = root, speed = speed }
            return true
        end,
        set_interval = function() return 1 end,
        mkdir = function() return true end,
        register_stream_media_tile = function(_, callback) state.home = callback end,
        is_playing = function() return false end,
        is_paused = function() return false end,
    }
    dofile("plugins/Podcasts/Podcasts.lua")
    return state
end

local all = {
    ["playback.speed"] = true,
    ["network.http.async"] = true,
    ["network.http.download"] = true,
    ["filesystem.mkdir"] = true,
}
local state = boot(all)
assert(state.minimum_api == 17, "plugin should require firmware API 17")
assert(#state.layouts == 1, "layout should be registered")
assert(state.layouts[1].id == "example.podcasts.reading_room", "layout should use its unique ID")
assert(state.storage.reading_room_auto_apply == "0", "legacy opt-out preference should be ignored")
for _, action in ipairs({ "reading_menu", "speed_menu", "rewind_15", "forward_15" }) do
    assert(type(state.actions[action]) == "function", action .. " should be registered")
end

state.actions.reading_menu()
assert(#state.last_list.rows == 3, "selected episode should show episode, host, and show")
assert(state.last_list.rows[1] == "Episode · Episode", "episode title metadata should be preserved")
assert(state.last_list.rows[2] == "Host · Host" and state.last_list.rows[3] == "Show · Show",
    "host and show metadata should be preserved")
state.now_playing = { "", "   ", nil }
state.actions.reading_menu()
assert(state.last_list.rows[1] == "Episode · Unknown episode", "empty episode title should have a readable fallback")
assert(state.last_list.rows[2] == "Host · Unknown host" and state.last_list.rows[3] == "Show · Unknown show",
    "empty host and show tags should have readable fallbacks")
state.now_playing = { "Episode", "Host", "Show" }

state.events.track_started()
assert(#state.layouts == 2, "Podcast playback should auto-apply despite a legacy opt-out")
state.position = 5
state.actions.rewind_15()
assert(state.seeks[#state.seeks] == 0, "rewind should clamp at zero")
state.position = 95
state.actions.forward_15()
assert(state.seeks[#state.seeks] == 100, "forward should clamp at duration")

local settings_before_speed = state.settings_calls
state.actions.speed_menu()
assert(state.last_list.title == "Playback speed", "speed action should open choices directly")
assert(state.settings_calls == settings_before_speed, "speed action should not open the settings page")
state.last_list.callback(5)
assert(state.speed_calls[#state.speed_calls].root == ROOT, "speed should use the existing Podcasts root")
assert(state.speed_calls[#state.speed_calls].speed == 1.5, "speed choice should reach the existing apply path")
assert(state.settings_calls == settings_before_speed, "direct speed choice should not refresh the settings page")

state.home()
state.last_list.callback(#state.last_list.rows)
local settings_rows = state.last_settings.rows
assert(#settings_rows == 1 and settings_rows[1].label:match("^Playback speed:"),
    "Podcasts settings should retain speed and omit Reading Room configuration rows")
settings_rows[1].on_select()
state.last_list.callback(4)
assert(state.settings_calls == settings_before_speed + 2,
    "the Settings speed row should refresh its open settings page after selection")

state.current = "/mock-sd/Music/song.mp3"
state.actions.reading_menu()
assert(#state.last_list.rows == 2, "non-podcast playback should show only the empty state")
assert(state.last_list.rows[1] == "No podcast episode selected", "empty state should say no podcast episode is selected")
assert(state.last_list.rows[2] == "Choose an episode from Podcasts to see its details",
    "empty state should explain how to select an episode")
local layouts_before_music = #state.layouts
state.events.track_started()
assert(#state.layouts == layouts_before_music, "music should not select the Podcasts layout")
assert(state.restores == 1, "leaving Podcasts should restore the preferred layout")
local seeks_before_music = #state.seeks
state.actions.forward_15()
assert(#state.seeks == seeks_before_music, "skip actions should ignore music")

local ungated = boot({})
assert(#ungated.layouts == 1, "API 17 should register the layout without capability checks")
assert(type(ungated.actions.reading_menu) == "function", "API 17 should register actions without capability checks")

io.open, os.rename, os.remove = original_open, original_rename, original_remove
print("Podcasts Reading Room player tests passed")
