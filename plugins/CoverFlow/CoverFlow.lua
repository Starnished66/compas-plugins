plugin.define({
    id = "example.cover_flow",
    name = "Cover Flow",
    version = "0.1.1",
    api_min = 19,
})

-- Albums as a carousel through plugin.show_cover_flow{} (capability
-- ui.cover_flow). On a player without it the same albums open as a grid.

local PAGE = 200
local MAX_ALBUMS = 5000

local function nonempty(s)
    return type(s) == "string" and s ~= ""
end

-- library_get_albums() groups are {name, count, first_song_id, album_artist}.
local function load_albums()
    local albums = {}
    local offset = 0
    while #albums < MAX_ALBUMS do
        local page = plugin.library_get_albums(offset, PAGE)
        if type(page) ~= "table" or #page == 0 then break end
        for i = 1, #page do
            albums[#albums + 1] = page[i]
        end
        if #page < PAGE then break end
        offset = offset + #page
    end
    return albums
end

-- The track paths of an album group, in album order.
local function album_tracks(group)
    local song = group.first_song_id and plugin.library_get_song(group.first_song_id)
    if not song then return nil end
    local artist = nonempty(group.album_artist) and group.album_artist or song.album_artist
    if not nonempty(artist) then artist = song.artist end
    if not nonempty(artist) or not nonempty(song.album) then return nil end
    local tracks = plugin.get_album_tracks(artist, song.album)
    if type(tracks) ~= "table" or #tracks == 0 then return nil end
    return tracks
end

local function shuffled(paths)
    local out = {}
    for i = 1, #paths do out[i] = paths[i] end
    for i = #out, 2, -1 do
        local j = math.random(i)
        out[i], out[j] = out[j], out[i]
    end
    return out
end

local function play_group(group, shuffle)
    local tracks = album_tracks(group)
    if not tracks then
        plugin.show_toast("No playable tracks in this album")
        return
    end
    plugin.play_list(shuffle and shuffled(tracks) or tracks, 1)
end

local function show_menu_for(group)
    plugin.show_menu(group.name or "Album", { "Play", "Shuffle" }, function(index)
        play_group(group, index == 2)
    end)
end

local function open_cover_flow(albums)
    local items = {}
    for i, group in ipairs(albums) do
        items[i] = {
            title = group.name or "",
            subtitle = group.album_artist or "",
            song_id = group.first_song_id,
        }
    end
    local ok, err = plugin.show_cover_flow({
        title = "Albums",
        items = items,
        selected = 1,
        az_index = true,
        on_select = function(index) play_group(albums[index], false) end,
        on_hold = function(index) show_menu_for(albums[index]) end,
    })
    if not ok then
        plugin.show_toast("Cover Flow: " .. tostring(err))
    end
end

local function open_grid(albums)
    local rows = {}
    for i, group in ipairs(albums) do
        rows[i] = group.name or ""
    end
    plugin.show_list("Albums", rows, function(index)
        play_group(albums[index], false)
    end, {
        layout = "grid",
        on_hold = function(index) show_menu_for(albums[index]) end,
    })
end

local function open()
    if not plugin.has_capability("library.paged") then
        plugin.show_toast("This player cannot list albums for plugins")
        return
    end
    local albums = load_albums()
    if #albums == 0 then
        plugin.show_toast("No albums in the library")
        return
    end
    if plugin.has_capability("ui.cover_flow") then
        open_cover_flow(albums)
    else
        plugin.show_toast("Cover Flow needs a newer player build; showing a grid")
        open_grid(albums)
    end
end

math.randomseed(os.time())

local ICON = plugin.sd_root() .. "/.plugin-assets/CoverFlow/cover_flow.png"
plugin.register_list_item("music", "Cover Flow", open, { icon = ICON })
