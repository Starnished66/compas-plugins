-- Focused integration checks for Podcasts' downloaded-only playback speed.
local plugin_file = assert(arg[1], "pass the Podcasts.lua path")
local audiobooks_file = arg[2] or "plugins/Audiobooks/Audiobooks.lua"
local root = os.tmpname()
os.remove(root)
assert(os.execute("mkdir -p '" .. root .. "/Podcasts'"))

local function encode(value)
    return (value:gsub("([^%w%._%- ])", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

local local_path = root .. "/Podcasts/Show/Episode.mp3"
local outside_path = root .. "/Podcasts-extra/Episode.mp3"
assert(os.execute("mkdir -p '" .. root .. "/Podcasts/Show'"))
local media = assert(io.open(local_path, "wb"))
media:write("fixture")
media:close()
local key = "0123456789abcdef|episode-guid"
local progress = assert(io.open(root .. "/Podcasts/.progress.tsv", "w"))
progress:write(table.concat({
    "P", encode(key), "120", "900", "0", "0", encode(local_path), "1000",
    encode("Episode"), "", "0",
}, "\t"), "\n")
progress:write(table.concat({
    "P", encode("abcdef0123456789|outside-guid"), "0", "900", "0", "0",
    encode(outside_path), "0", encode("Outside"), "", "0",
}, "\t"), "\n")
progress:close()

local captured, interval, current_path, current_position = { settings = {}, stack = {}, settings_pushes = 0 }, nil, nil, 0
local plugin = {
    define = function() end,
    sd_root = function() return root end,
    has_capability = function(name)
        return name == "playback.speed" or name == "network.http.async"
            or name == "network.http.download" or name == "filesystem.mkdir"
    end,
    set_playback_speed = function(directory, speed)
        captured[#captured + 1] = { directory = directory, speed = speed }
        return true
    end,
    mkdir = function() return true end,
    show_list = function(title, items, callback)
        captured.last_list = { title = title, items = items, callback = callback }
        captured.stack[#captured.stack + 1] = { title = title, kind = "list", screen = captured.last_list }
    end,
    show_settings_list = function(title, items, options)
        local screen = { title = title, items = items }
        captured.settings[title] = screen
        if options and options.update then
            for _, entry in ipairs(captured.stack) do
                if entry.kind == "settings" and entry.title == title then entry.screen = screen end
            end
        else
            captured.settings_pushes = captured.settings_pushes + 1
            captured.stack[#captured.stack + 1] = { title = title, kind = "settings", screen = screen }
        end
    end,
    show_toast = function(message) captured.last_toast = message end,
    on = function(name, callback) captured[name] = callback end,
    set_interval = function(_, callback) interval = callback; return 1 end,
    register_stream_media_tile = function(_, callback) captured.open_home = callback end,
    get_current_track_path = function() return current_path end,
    get_position = function() return current_position end,
    get_duration = function() return 900 end,
    seek = function(position) current_position = position end,
    is_playing = function() return true end,
    is_paused = function() return false end,
}
_G.plugin = plugin
plugin.md5 = function() return "0123456789abcdef0123456789abcdef" end

local function load_plugin()
    captured.settings, captured.stack, captured.settings_pushes = {}, {}, 0
    assert(loadfile(plugin_file))()
end
local function open_speed_chooser(expected_label)
    captured.open_home()
    local home = captured.last_list
    local settings_index
    for i, row in ipairs(home.items) do
        if (type(row) == "table" and row.label or row) == "Settings" then
            settings_index = i
            break
        end
    end
    assert(settings_index, "Podcasts Home includes Settings")
    home.callback(settings_index)
    local parent = assert(captured.settings["Podcasts settings"])
    assert(parent.items[1].label == expected_label)
    assert(parent.items[1].on_select)
    parent.items[1].on_select()
    assert(captured.last_list.title == "Playback speed")
end

load_plugin()
open_speed_chooser("Playback speed: 1.0x")
-- Selecting a rate from a stream or while no download is active must only
-- persist the preference; it must not replace another plugin's speed scope.
captured.last_list.callback(5) -- 1.5x
assert(#captured == 0, "no native speed scope change without a local download")
assert(captured.settings_pushes == 1, "speed choice updates its covered parent in place")
assert(captured.settings["Podcasts settings"].items[1].label == "Playback speed: 1.5x")
assert(captured.stack[#captured.stack].title == "Playback speed")
table.remove(captured.stack) -- Back returns to the updated Settings parent.
assert(captured.stack[#captured.stack].title == "Podcasts settings")
captured.settings["Podcasts settings"].items[1].on_select()
local list_count = #captured.stack
captured.last_list.callback(5)
assert(captured.settings_pushes == 1 and #captured.stack == list_count,
    "repeated speed choices do not add Settings screens or generic lists")
assert(captured.settings["Podcasts settings"].items[1].label == "Playback speed: 1.5x")
local settings = assert(io.open(root .. "/Podcasts/.settings", "r")):read("*a")
assert(settings:find("playback_speed\t1%.5\n"))

-- Reload proves the selected value is restored in the settings label.
load_plugin()
open_speed_chooser("Playback speed: 1.5x")
assert(captured.last_list.title == "Playback speed")
current_path, current_position = "https://example.test/episode.mp3", 0
captured.track_started()
assert(#captured == 0, "stream playback does not receive Podcasts speed")
current_path = outside_path
captured.track_started()
assert(#captured == 0, "a path sharing a textual prefix is outside the Podcasts root")

-- A downloaded episode with saved progress must finish its resume seek before
-- the speed API is called, avoiding a race between the two audio-thread seeks.
current_path, current_position = local_path, 0
captured.track_started()
assert(#captured == 0, "resume seek is issued before speed change")
assert(current_position == 120, "saved episode position is restored")
interval()
assert(#captured == 1)
assert(captured[1].directory == root .. "/Podcasts")
assert(captured[1].speed == 1.5)

local restored = assert(io.open(root .. "/Podcasts/.settings", "r")):read("*a")
assert(restored:find("playback_speed\t1%.5\n"))

-- API-min-2 players without settings-list support still expose a row that
-- reports the missing speed capability instead of calling a missing API.
plugin.show_settings_list = nil
plugin.has_capability = function(name)
    return name ~= "playback.speed" and (name == "network.http.async"
        or name == "network.http.download" or name == "filesystem.mkdir")
end
local calls_before_fallback = #captured
load_plugin()
captured.open_home()
local fallback_home = captured.last_list
local fallback_index
for i, row in ipairs(fallback_home.items) do
    if (type(row) == "table" and row.label or row) == "Settings" then fallback_index = i end
end
assert(fallback_index)
fallback_home.callback(fallback_index)
assert(captured.last_list.title == "Podcasts settings")
captured.last_list.callback(1)
assert(captured.last_toast == "Playback speed requires a newer player")
assert(#captured == calls_before_fallback, "old-player fallback never calls playback.speed")
os.execute("rm -rf '" .. root .. "'")

-- Broadcast the same track-start event to both real plugins against one
-- native-style shared speed scope. This catches scope handoff regressions.
local shared = os.tmpname()
os.remove(shared)
assert(os.execute("mkdir -p '" .. shared .. "/.plugins' '" .. shared .. "/Audiobooks' '"
    .. shared .. "/Podcasts/Show'"))
local audiobook_path = shared .. "/Audiobooks/Book.mp3"
local episode_path = shared .. "/Podcasts/Show/Episode.mp3"
local function write(path, body)
    local file = assert(io.open(path, "w"))
    file:write(body)
    file:close()
end
local function touch(path)
    local file = assert(io.open(path, "wb"))
    file:write("fixture")
    file:close()
end
touch(audiobook_path)
touch(episode_path)
write(shared .. "/.plugins/.audiobooks_state_v3",
    "P\tBook.mp3\tBook.mp3\t120\t900\t0\t" .. tostring(os.time()) .. "\t0\t0\n")
write(shared .. "/.plugins/.audiobooks_settings", "skip_by_30\t0\nplayback_speed\t1.75\n")
write(shared .. "/Podcasts/.settings", "playback_speed\t1.5\n")
write(shared .. "/Podcasts/.progress.tsv", table.concat({
    "P", encode("0123456789abcdef|episode-guid"), "120", "900", "0", "0",
    encode(episode_path), "1000", encode("Episode"), "", "0",
}, "\t") .. "\n")

local audio = { path = episode_path, position = 0, duration = 900, scope = "/other", rate = 1.0,
    calls = {}, events = { audiobooks = {}, podcasts = {} }, ticks = {}, screens = {}, lists = {},
    stacks = { audiobooks = {}, podcasts = {} }, list_counts = { audiobooks = 0, podcasts = 0 },
    settings_pushes = { audiobooks = 0, podcasts = 0 },
    speed_capability = true, unsupported = false }
local function within(path, directory)
    return path and path:sub(1, #directory + 1) == directory .. "/"
end
local function effective_rate()
    return within(audio.path, audio.scope) and audio.rate or 1.0
end
local function make_plugin(owner)
    return {
        define = function() end,
        sd_root = function() return shared end,
        has_capability = function(name)
            if name == "playback.speed" then return audio.speed_capability end
            return name ~= "playback.transport_skip"
        end,
        set_playback_speed = function(directory, rate)
            audio.calls[#audio.calls + 1] = { directory = directory, rate = rate, path = audio.path }
            if not audio.speed_capability then return false end
            if within(audio.path, directory) and audio.unsupported then return false end
            audio.scope, audio.rate = directory, rate
            return true
        end,
        set_transport_skip = function() return true end,
        mkdir = function() return true end,
        list_dir = function(path)
            if path == shared .. "/Audiobooks" then return { { name = "Book.mp3", dir = false } } end
            return {}
        end,
        md5 = function() return "0123456789abcdef0123456789abcdef" end,
        show_toast = function(message) audio.last_toast = message end,
        show_list = function(title, rows, callback)
            audio.lists[owner] = { title = title, rows = rows, callback = callback }
            audio.list_counts[owner] = audio.list_counts[owner] + 1
            audio.stacks[owner][#audio.stacks[owner] + 1] = {
                title = title, kind = "list", screen = audio.lists[owner],
            }
        end,
        show_settings_list = function(title, rows, options)
            audio.screens[owner] = audio.screens[owner] or {}
            local screen = { title = title, rows = rows }
            audio.screens[owner][title] = screen
            if options and options.update then
                for _, entry in ipairs(audio.stacks[owner]) do
                    if entry.kind == "settings" and entry.title == title then entry.screen = screen end
                end
            else
                audio.settings_pushes[owner] = audio.settings_pushes[owner] + 1
                audio.stacks[owner][#audio.stacks[owner] + 1] = {
                    title = title, kind = "settings", screen = screen,
                }
            end
        end,
        on = function(name, callback) audio.events[owner][name] = callback end,
        set_interval = function(_, callback) audio.ticks[owner] = callback; return 1 end,
        register_list_item = function(_, _, callback) audio.open_audiobooks = callback end,
        register_stream_media_tile = function(_, callback) audio.open_podcasts = callback end,
        get_current_track_path = function() return audio.path end,
        get_position = function() return audio.position end,
        get_duration = function() return audio.duration end,
        get_play_mode = function() return "sequential" end,
        get_playback_progress = function()
            return { terminal = "active", position = audio.position, duration = audio.duration,
                playing = true, paused = false }
        end,
        seek = function(position) audio.position = position end,
        play_list = function(paths, index) audio.path = paths[index]; audio.position = 0 end,
        play_file = function(path) audio.path = path; audio.position = 0 end,
        is_playing = function() return true end,
        is_paused = function() return false end,
        toggle_pause = function() end,
        stop = function() end,
    }
end
local function load_real(path, owner)
    local env = setmetatable({ plugin = make_plugin(owner) }, { __index = _G })
    local chunk, err = loadfile(path, "t", env)
    assert(chunk, err)
    chunk()
end
local function broadcast_track_started()
    for _, owner in ipairs({ "audiobooks", "podcasts" }) do
        local callback = audio.events[owner].track_started
        if callback then callback() end
    end
end
local function tick(owner)
    audio.ticks[owner]()
end
local function find_row(rows, text)
    for i, row in ipairs(rows) do
        local label = type(row) == "table" and row.label or row
        if label and label:find(text, 1, true) then return i, row end
    end
end
local function choose_audiobook_speed(index)
    audio.open_audiobooks()
    local screen = audio.screens.audiobooks["Audiobooks"]
    local _, settings_row = find_row(screen.rows, "Settings")
    assert(settings_row and settings_row.on_select)
    settings_row.on_select()
    local settings = audio.screens.audiobooks["Audiobooks settings"]
    local _, speed_row = find_row(settings.rows, "Playback speed:")
    assert(speed_row and speed_row.on_select)
    speed_row.on_select()
    audio.lists.audiobooks.callback(index)
end
local function choose_podcast_speed(index)
    local list_count = audio.list_counts.podcasts
    local settings_count = audio.settings_pushes.podcasts
    audio.open_podcasts()
    local home = audio.lists.podcasts
    local row_index = assert(find_row(home.rows, "Settings"))
    home.callback(row_index)
    local parent = audio.screens.podcasts["Podcasts settings"]
    assert(parent and parent.rows[1].on_select)
    parent.rows[1].on_select()
    assert(audio.lists.podcasts.title == "Playback speed")
    audio.lists.podcasts.callback(index)
    assert(audio.list_counts.podcasts == list_count + 2,
        "the speed selection updates the covered parent without pushing another list")
    assert(audio.settings_pushes.podcasts == settings_count + 1,
        "the Settings parent is pushed once for a speed selection")
    local stack = audio.stacks.podcasts
    assert(stack[#stack].title == "Playback speed")
    table.remove(stack) -- Back returns to the refreshed Settings parent.
    assert(stack[#stack].title == "Podcasts settings")
    assert(stack[#stack].screen.rows[1].label:find("Playback speed:", 1, true))
    stack[#stack].screen.rows[1].on_select()
    assert(audio.list_counts.podcasts == list_count + 3)
    audio.lists.podcasts.callback(index)
    assert(audio.list_counts.podcasts == list_count + 3
        and audio.settings_pushes.podcasts == settings_count + 1,
        "repeated choices add no parent or generic list screens")
    table.remove(stack)
    assert(stack[#stack].title == "Podcasts settings")
end

load_real(audiobooks_file, "audiobooks")
assert(#audio.calls == 0, "Audiobooks startup must not steal the active Podcasts speed scope")
tick("audiobooks")
assert(#audio.calls == 0 and audio.scope == "/other",
    "pending Audiobooks speed remains idle while a Podcast is active")
load_real(plugin_file, "podcasts")
assert(#audio.calls == 0, "Podcast startup defers its speed change to the tick")
tick("podcasts")
assert(audio.scope == shared .. "/Podcasts" and audio.rate == 1.5)

-- Changing an inactive plugin's preference persists it without changing the
-- shared engine scope currently owned by the other plugin.
local calls_before = #audio.calls
choose_audiobook_speed(4) -- 1.25x
assert(#audio.calls == calls_before and audio.scope == shared .. "/Podcasts" and audio.rate == 1.5,
    "Audiobooks settings must not override active Podcasts playback")

-- Audiobook resume owns the scope only after its resume seek has landed.
audio.open_audiobooks()
local ab_screen = audio.screens.audiobooks["Audiobooks"]
local resume_index = assert(find_row(ab_screen.rows, "Continue listening: Book"))
ab_screen.rows[resume_index].on_select()
broadcast_track_started()
calls_before = #audio.calls
tick("audiobooks")
assert(#audio.calls == calls_before, "Audiobooks speed waits until resume seek settles")
tick("audiobooks")
assert(audio.scope == shared .. "/Audiobooks" and audio.rate == 1.25)

-- Changing Podcast settings while Audiobooks plays also persists only.
calls_before = #audio.calls
choose_podcast_speed(6) -- 1.75x
assert(#audio.calls == calls_before and audio.scope == shared .. "/Audiobooks" and audio.rate == 1.25,
    "Podcast settings must not override active Audiobooks playback")

-- Re-enter the downloaded episode and confirm its independent rate returns.
audio.open_podcasts()
local podcast_home = audio.lists.podcasts
local continue_index = assert(find_row(podcast_home.rows, "Continue: Episode"))
podcast_home.callback(continue_index)
broadcast_track_started()
calls_before = #audio.calls
assert(#audio.calls == calls_before and audio.position == 120,
    "Podcast issues the resume seek before changing speed")
tick("podcasts")
assert(audio.scope == shared .. "/Podcasts" and audio.rate == 1.75)

-- A stale event path (or nil path) keeps Audiobooks pending until its own
-- local path becomes current; it neither steals Podcast speed nor loses the
-- subsequent handoff when the path updates after the notification.
calls_before = #audio.calls
audio.events.audiobooks.track_started()
assert(#audio.calls == calls_before and audio.scope == shared .. "/Podcasts")
audio.path = audiobook_path
tick("audiobooks")
assert(audio.scope == shared .. "/Audiobooks" and audio.rate == 1.25)
audio.path = nil
broadcast_track_started()
calls_before = #audio.calls
tick("audiobooks")
tick("podcasts")
assert(#audio.calls == calls_before, "nil current paths never claim a plugin speed scope")
audio.path, audio.position = audiobook_path, 120
tick("audiobooks")
assert(audio.scope == shared .. "/Audiobooks" and audio.rate == 1.25,
    "pending scope is applied when an audiobook path appears after a nil event")

-- And the audiobook's stored rate is restored after the reverse handoff.
audio.open_audiobooks()
ab_screen = audio.screens.audiobooks["Audiobooks"]
resume_index = assert(find_row(ab_screen.rows, "Continue listening: Book"))
ab_screen.rows[resume_index].on_select()
broadcast_track_started()
tick("audiobooks")
tick("audiobooks")
assert(audio.scope == shared .. "/Audiobooks" and audio.rate == 1.25)

-- Streams remain at 1x and never cause either plugin to claim the scope.
audio.path = "https://example.test/live.mp3"
calls_before = #audio.calls
broadcast_track_started()
tick("audiobooks")
tick("podcasts")
assert(#audio.calls == calls_before and effective_rate() == 1.0)

-- Rejected local formats retain the retry until the native call is accepted.
audio.path, audio.position, audio.unsupported = episode_path, 0, true
broadcast_track_started()
tick("podcasts")
local rejected_calls = #audio.calls
assert(rejected_calls > calls_before and audio.scope == shared .. "/Audiobooks")
tick("podcasts")
assert(#audio.calls > rejected_calls, "rejected speed is retried")
audio.unsupported = false
tick("podcasts")
assert(audio.scope == shared .. "/Podcasts" and audio.rate == 1.75)

-- Missing capability presents the existing message and never calls the API.
audio.speed_capability = false
calls_before = #audio.calls
audio.open_audiobooks()
ab_screen = audio.screens.audiobooks["Audiobooks"]
local _, unavailable_ab_settings = find_row(ab_screen.rows, "Settings")
unavailable_ab_settings.on_select()
local ab_settings = audio.screens.audiobooks["Audiobooks settings"]
local _, unavailable_ab_speed = find_row(ab_settings.rows, "Playback speed:")
unavailable_ab_speed.on_select()
assert(#audio.calls == calls_before and audio.last_toast == "Playback speed requires a newer player")
audio.open_podcasts()
local unavailable_home = audio.lists.podcasts
local unavailable_settings_index = assert(find_row(unavailable_home.rows, "Settings"))
unavailable_home.callback(unavailable_settings_index)
local unavailable_parent = audio.screens.podcasts["Podcasts settings"]
assert(unavailable_parent and unavailable_parent.rows[1].on_select)
unavailable_parent.rows[1].on_select()
assert(#audio.calls == calls_before and audio.last_toast == "Playback speed requires a newer player")
os.execute("rm -rf '" .. shared .. "'")
print("Podcasts speed tests passed")
