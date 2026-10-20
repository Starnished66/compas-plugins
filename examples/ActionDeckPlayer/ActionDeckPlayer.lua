-- Action Deck Player demonstrates XML player actions and layout-local
-- interaction settings. Copy this file and its player_layouts folder into
-- <SD card>/.plugins, refresh plugins, then choose a layout in Player Layout.

plugin.define({
    id = "example.action_deck_player",
    name = "Action Deck Player",
    version = "1.0.0",
    api_min = 1,
})

local has_capability = type(plugin.has_capability) == "function"
    and plugin.has_capability

if not has_capability or not has_capability("ui.player_layout_xml") or
    not has_capability("ui.player_actions") then
    return
end

local function current_track()
    local title, artist, album, duration = plugin.get_now_playing()
    local path = plugin.get_current_track_path()
    return {
        title = title or "Nothing playing",
        artist = artist or "Unknown artist",
        album = album or "Unknown album",
        duration = duration,
        path = path or "No current file path",
    }
end

local function show_track_menu(kind)
    local track = current_track()
    local heading
    local items
    if kind == "artist" then
        heading = track.artist
        items = {
            "Artist · " .. track.artist,
            "Now playing · " .. track.title,
            "Show current file",
            "Play / pause",
            "Next track",
            "Previous track",
            "Close",
        }
    elseif kind == "album" then
        heading = track.album
        items = {
            "Album · " .. track.album,
            "Now playing · " .. track.title,
            "Show current file",
            "Play / pause",
            "Next track",
            "Previous track",
            "Close",
        }
    else
        heading = "Track actions"
        items = {
            "Track · " .. track.title,
            "Artist · " .. track.artist,
            "Album · " .. track.album,
            "Show current file",
            "Play / pause",
            "Next track",
            "Previous track",
            "Close",
        }
    end

    plugin.show_list(heading, items, function(index)
        local offset = kind == "track" and 1 or 0
        if index == 3 + offset then
            plugin.show_toast(track.path)
        elseif index == 4 + offset then
            plugin.toggle_pause()
        elseif index == 5 + offset then
            plugin.next_track()
        elseif index == 6 + offset then
            plugin.prev_track()
        end
    end)
end

plugin.register_player_action("artist_menu", function()
    show_track_menu("artist")
end)
plugin.register_player_action("album_menu", function()
    show_track_menu("album")
end)
plugin.register_player_action("track_menu", function()
    show_track_menu("track")
end)

local layouts = {
    {
        id = "example.action_deck_player.stage",
        name = "Action Deck · Stage",
        xml = "ActionDeckPlayer/player_layouts/stage.xml",
    },
}

-- Registration at load time lists the layout without selecting it.
for _, layout in ipairs(layouts) do
    plugin.set_player_layout(layout)
end

local function apply_layout(layout)
    local ok, err = pcall(plugin.set_player_layout, layout)
    if ok then
        plugin.show_toast(layout.name .. " applied for this session")
    else
        plugin.show_toast("Could not apply layout: " .. tostring(err))
    end
end

for _, layout in ipairs(layouts) do
    local selected_layout = layout
    plugin.register_list_item("display", selected_layout.name, function()
        apply_layout(selected_layout)
    end, { group = "player_layout" })
end

if type(plugin.has_capability) == "function" and plugin.has_capability("ui.player_layout_restore")
    and type(plugin.restore_player_layout) == "function" then
    plugin.register_list_item("display", "Action Deck · Restore saved layout", function()
        local ok, changed = pcall(plugin.restore_player_layout)
        if ok then
            plugin.show_toast(changed and "Saved player layout restored" or "No Action Deck layout override to restore")
        else
            plugin.show_toast("Could not restore layout: " .. tostring(changed))
        end
    end, { group = "player_layout" })
end
