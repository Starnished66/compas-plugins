plugin.define({
    id = "example.album_shuffle",
    name = "Album Shuffle",
    version = "1.0.0",
    api_min = 15,
})

-- Plays a random album with tracks in album order, then another when the
-- queue is exhausted forward. library_get_albums() rows are {name, count,
-- first_song_id, album_artist}. Identity prefers group.album_artist or
-- song.album_artist so compilations keep every track, then song.artist.
-- There is no plugin.set_play_mode: native shuffle would scramble track
-- order, so this plugin only runs while the player is already sequential.

local PAGE = 50
local MAX_SKIP = 8

local session = {
    active = false,
    last_id = nil,
    last_artist = nil,
    last_album = nil,
    paths = {},
    continuing = false,
    idle_polls = 0,
}

local function toast(msg)
    plugin.show_toast(msg)
end

local function is_remote_path(path)
    return type(path) == "string" and path:match("^[Hh][Tt][Tt][Pp][Ss]?://") ~= nil
end

local function playable_paths(paths)
    if type(paths) ~= "table" then return nil end
    local out = {}
    for i = 1, #paths do
        local p = paths[i]
        if type(p) == "string" and p ~= "" and not is_remote_path(p) then
            out[#out + 1] = p
        end
    end
    if #out == 0 then return nil end
    return out
end

local function path_set(paths)
    local t = {}
    for i = 1, #paths do t[paths[i]] = true end
    return t
end

local function nonempty(s)
    return type(s) == "string" and s ~= ""
end

local function identity_from_group(group)
    if type(group) ~= "table" or not group.first_song_id then return nil end
    local song = plugin.library_get_song(group.first_song_id)
    if not song then return nil end
    local album_artist = ""
    if nonempty(group.album_artist) then
        album_artist = group.album_artist
    elseif nonempty(song.album_artist) then
        album_artist = song.album_artist
    end
    local artist = nonempty(album_artist) and album_artist or song.artist
    local album = song.album
    if not nonempty(artist) or not nonempty(album) then return nil end
    return {
        artist = artist,
        album = album,
        album_artist = album_artist,
        id = song.id,
        name = group.name or album,
    }
end

-- Reservoir-sample one album group across paged library_get_albums() calls.
local function pick_album_group()
    local offset = 0
    local n = 0
    local chosen, alt
    while true do
        local page = plugin.library_get_albums(offset, PAGE)
        if type(page) ~= "table" or #page == 0 then break end
        for i = 1, #page do
            n = n + 1
            local r = math.random(n)
            if r == 1 then
                alt = chosen
                chosen = page[i]
            elseif r == 2 then
                alt = page[i]
            end
        end
        if #page < PAGE then break end
        offset = offset + #page
        if offset > 100000 then break end
    end
    return chosen, alt, n
end

local function tracks_for(ident)
    if not ident then return nil end
    return playable_paths(plugin.get_album_tracks(ident.artist, ident.album))
end

local function stop_session()
    session.active = false
    session.paths = {}
    session.continuing = false
    session.idle_polls = 0
end

local function start_album(ident)
    local tracks = tracks_for(ident)
    if not tracks then return false end
    session.active = true
    session.continuing = true
    session.last_id = ident.id
    session.last_artist = ident.artist
    session.last_album = ident.album
    session.paths = path_set(tracks)
    plugin.play_list(tracks, 1)
    session.continuing = false
    toast("Album: " .. ident.album)
    return true
end

local function sequential_ok()
    return plugin.get_play_mode() == "sequential"
end

local function play_random_album()
    if not sequential_ok() then
        toast("Set play mode to sequential first (plugin cannot change it)")
        stop_session()
        return false
    end
    local chosen, alt, n = pick_album_group()
    if n == 0 or not chosen then
        toast("No albums in the library")
        stop_session()
        return false
    end
    local ident = identity_from_group(chosen)
    local alt_ident = identity_from_group(alt)
    if ident and n > 1 and ident.id == session.last_id and alt_ident then
        ident = alt_ident
    elseif ident and n > 1 and ident.artist == session.last_artist and ident.album == session.last_album and alt_ident then
        ident = alt_ident
    end

    local tries = 0
    while ident and tries < MAX_SKIP do
        tries = tries + 1
        if start_album(ident) then return true end
        chosen, alt, n = pick_album_group()
        ident = identity_from_group(chosen)
        if ident and session.last_id and ident.id == session.last_id then
            ident = identity_from_group(alt)
        end
    end
    toast("No playable album tracks")
    stop_session()
    return false
end

local function continue_next()
    if not session.active then return end
    if not sequential_ok() then
        stop_session()
        return
    end
    if session.continuing then return end
    session.continuing = true
    local ok = play_random_album()
    if not ok then session.continuing = false end
end

math.randomseed(os.time())

local function start_from_ui()
    session.last_id = nil
    session.last_artist = nil
    session.last_album = nil
    session.active = true
    play_random_album()
end

local function stop_from_ui()
    stop_session()
    toast("Album shuffle stopped")
end

plugin.on("stopped", function()
    if session.active then stop_session() end
end)

plugin.on("track_started", function(_, _, _, _, provider)
    if not session.active then return end
    if session.continuing then return end
    if provider and provider ~= "" then
        stop_session()
        return
    end
    local path = plugin.get_current_track_path()
    if not path or not session.paths[path] then
        stop_session()
    end
end)

plugin.on("queue_exhausted", function(direction)
    if direction ~= 1 then return end
    if not session.active then return end
    continue_next()
end)

-- Natural end of the last track does not fire queue_exhausted (only Next with
-- nothing left does). Same two-poll idle confirmation as Play Through.
plugin.set_interval(1, function()
    if not session.active then return end
    if not sequential_ok() then
        stop_session()
        return
    end
    if plugin.is_playing() or plugin.is_paused() then
        session.idle_polls = 0
        return
    end
    session.idle_polls = session.idle_polls + 1
    if session.idle_polls < 2 then return end
    session.idle_polls = 0
    continue_next()
end)

local function open_settings()
    local status = session.active and "Album shuffle is on" or "Album shuffle is off"
    plugin.show_settings_list("Album Shuffle", {
        {
            type = "row",
            label = session.active and "Stop album shuffle" or "Start album shuffle",
            on_select = function()
                if session.active then stop_from_ui() else start_from_ui() end
            end,
        },
        {
            type = "row",
            label = status,
            on_select = function() end,
        },
        {
            type = "row",
            label = "How it works",
            on_select = function()
                plugin.show_list("About Album Shuffle", {
                    "Picks a random album, plays its tracks in order, then another when it ends or you press Next at the end.",
                    "Select sequential playback mode before starting to keep tracks in album order.",
                    "Stop, picking another queue, or turning this off ends the session so playback is not taken over.",
                }, function() end)
            end,
        },
    })
end

plugin.register_list_item("playback", "Album Shuffle", open_settings)

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        session = session,
        identity_from_group = identity_from_group,
        pick_album_group = pick_album_group,
        play_random_album = play_random_album,
        start_from_ui = start_from_ui,
        stop_from_ui = stop_from_ui,
        continue_next = continue_next,
        playable_paths = playable_paths,
        stop_session = stop_session,
    }
end
