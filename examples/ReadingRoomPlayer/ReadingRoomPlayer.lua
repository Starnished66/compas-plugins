-- Reading Room Player is an example of a calm, book-focused player layout.
-- It demonstrates session-owned layouts and optional folder-based switching;
-- it does not change the separate Audiobooks plugin.

plugin.define({
    id = "example.reading_room_player",
    name = "Reading Room Player",
    version = "1.0.0",
    api_min = 17,
})

local SD_ROOT = plugin.sd_root()
local AUDIOBOOKS_ROOT = SD_ROOT .. "/Audiobooks"
local PODCASTS_ROOT = SD_ROOT .. "/Podcasts"
local AUDIOBOOKS_KEY = "use_for_audiobooks_folder"
local PODCASTS_KEY = "use_for_podcasts_folder"
local auto_enabled = {
    [AUDIOBOOKS_ROOT] = plugin.storage.get(AUDIOBOOKS_KEY, "0") == "1",
    [PODCASTS_ROOT] = plugin.storage.get(PODCASTS_KEY, "1") ~= "0",
}
local roots = {
    { path = AUDIOBOOKS_ROOT, label = "Audiobooks", key = AUDIOBOOKS_KEY },
    { path = PODCASTS_ROOT, label = "Podcasts", key = PODCASTS_KEY },
}

local layout = {
    id = "example.reading_room_player.paper",
    name = "Reading Room · Paper",
    xml = "ReadingRoomPlayer/player_layouts/reading_room.xml",
}

local function matching_root(path)
    if type(path) ~= "string" then return nil end
    for _, root in ipairs(roots) do
        if path:sub(1, #root.path + 1) == root.path .. "/" then return root end
    end
    return nil
end

local function apply_layout(layout, quiet)
    local ok, err = pcall(plugin.set_player_layout, layout)
    if ok then
        if not quiet then plugin.show_toast(layout.name .. " applied for this session") end
        return true
    end
    if not quiet then plugin.show_toast("Could not apply layout: " .. tostring(err)) end
    return false
end

local function restore_owned_layout()
    local ok, changed = pcall(plugin.restore_player_layout)
    return ok and changed == true
end

local function current_track()
    local title, artist, album = plugin.get_now_playing()
    return title or "Nothing playing", artist or "Unknown artist", album or "Unknown album"
end

local function show_speed_menu()
    local root = matching_root(plugin.get_current_track_path())
    if not root then
        plugin.show_toast("Playback speed is scoped to Audiobooks and Podcasts")
        return
    end
    local speeds = { 0.75, 0.9, 1.0, 1.1, 1.25, 1.5, 1.75, 2.0 }
    local rows = {}
    for _, speed in ipairs(speeds) do rows[#rows + 1] = string.format("%gx", speed) end
    plugin.show_list("Playback speed · " .. root.label, rows, function(index)
        local speed = speeds[index]
        if not speed then return end
        local current_root = matching_root(plugin.get_current_track_path())
        if not current_root or current_root.path ~= root.path then return end
        local ok, accepted = pcall(plugin.set_playback_speed, root.path, speed)
        if ok and accepted ~= false then
            plugin.show_toast(string.format("Playback speed %gx", speed))
        else
            plugin.show_toast("Could not change playback speed")
        end
    end)
end

local function show_reading_menu()
    local title, artist, album = current_track()
    local root = matching_root(plugin.get_current_track_path())
    local author_label, book_label = root and root.path == PODCASTS_ROOT
        and "Host" or "Author", root and root.path == PODCASTS_ROOT and "Show" or "Book"
    local rows = {
        "Now playing · " .. title,
        author_label .. " · " .. artist,
        book_label .. " · " .. album,
        "Return to preferred layout",
    }
    plugin.show_list("Reading Room", rows, function(index)
        if index == 4 then
            plugin.show_toast(restore_owned_layout()
                and "Preferred player layout restored"
                or "No Reading Room layout is active")
        end
    end)
end

local function skip_seconds(delta)
    if not matching_root(plugin.get_current_track_path()) then
        plugin.show_toast("Skip controls are for Audiobooks and Podcasts")
        return
    end
    local position = tonumber(plugin.get_position()) or 0
    local target = math.max(0, position + delta)
    local duration = tonumber(plugin.get_duration()) or 0
    if duration and duration > 0 then target = math.min(target, duration) end
    pcall(plugin.seek, target)
end

plugin.register_player_action("reading_menu", show_reading_menu)
plugin.register_player_action("speed_menu", show_speed_menu)
plugin.register_player_action("rewind_15", function() skip_seconds(-15) end)
plugin.register_player_action("forward_15", function() skip_seconds(15) end)

-- Registration lists the layout but deliberately does not select it.
plugin.set_player_layout(layout)

plugin.register_list_item("display", layout.name, function()
    apply_layout(layout, false)
end, { group = "player_layout" })

for _, root in ipairs(roots) do
    plugin.register_list_item("display", "Use for " .. root.label .. " folder", function()
        auto_enabled[root.path] = not auto_enabled[root.path]
        plugin.storage.set(root.key, auto_enabled[root.path] and "1" or "0")
        if auto_enabled[root.path] then
            if matching_root(plugin.get_current_track_path()) == root then apply_layout(layout, true) end
            plugin.show_toast("Auto-apply enabled for " .. root.label)
        else
            local restored = matching_root(plugin.get_current_track_path()) == root
                and restore_owned_layout()
            plugin.show_toast(restored and "Auto-apply disabled; preferred layout restored"
                or "Auto-apply disabled for " .. root.label)
        end
    end, { group = "player_layout" })
end

plugin.register_list_item("display", "Reading Room · Return to preferred layout", function()
    plugin.show_toast(restore_owned_layout()
        and "Preferred player layout restored"
        or "No Reading Room layout is active")
end, { group = "player_layout" })

plugin.on("track_started", function()
    local path = plugin.get_current_track_path()
    local root = matching_root(path)
    if root then
        if auto_enabled[root.path] then apply_layout(layout, true) end
        if not auto_enabled[root.path] then restore_owned_layout() end
    else
        restore_owned_layout()
    end
end)
