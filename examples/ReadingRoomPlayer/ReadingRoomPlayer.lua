-- Reading Room Player is an example of a calm, book-focused player layout.
-- It demonstrates session-owned layouts and optional folder-based switching;
-- it does not change the separate Audiobooks plugin.

plugin.define({
    id = "example.reading_room_player",
    name = "Reading Room Player",
    version = "1.0.0",
    api_min = 1,
})

local has_capability = type(plugin.has_capability) == "function" and plugin.has_capability
if not has_capability or not has_capability("ui.player_layout_xml") then
    return
end
if not has_capability("ui.player_actions") or not has_capability("ui.player_layout_restore") then
    return
end

local ROOT = plugin.sd_root() .. "/Audiobooks"
local AUTO_KEY = "use_for_audiobooks_folder"
local auto_enabled = plugin.storage.get(AUTO_KEY, "0") == "1"

local layout = {
    id = "example.reading_room_player.paper",
    name = "Reading Room · Paper",
    xml = "ReadingRoomPlayer/player_layouts/reading_room.xml",
}

local function in_audiobooks_folder(path)
    return type(path) == "string" and path:sub(1, #ROOT + 1) == ROOT .. "/"
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
    if type(plugin.restore_player_layout) ~= "function" then return false end
    local ok, changed = pcall(plugin.restore_player_layout)
    return ok and changed == true
end

local function current_track()
    local title, artist, album = plugin.get_now_playing()
    return title or "Nothing playing", artist or "Unknown artist", album or "Unknown album"
end

local function show_speed_menu()
    if not in_audiobooks_folder(plugin.get_current_track_path()) then
        plugin.show_toast("Playback speed is scoped to the Audiobooks folder")
        return
    end
    if not has_capability("playback.speed") or type(plugin.set_playback_speed) ~= "function" then
        plugin.show_toast("Playback speed control is unavailable")
        return
    end
    local speeds = { 0.75, 0.9, 1.0, 1.1, 1.25, 1.5, 1.75, 2.0 }
    local rows = {}
    for _, speed in ipairs(speeds) do rows[#rows + 1] = string.format("%gx", speed) end
    plugin.show_list("Playback speed · Audiobooks", rows, function(index)
        local speed = speeds[index]
        if not speed or not in_audiobooks_folder(plugin.get_current_track_path()) then return end
        local ok, accepted = pcall(plugin.set_playback_speed, ROOT, speed)
        if ok and accepted ~= false then
            plugin.show_toast(string.format("Playback speed %gx", speed))
        else
            plugin.show_toast("Could not change playback speed")
        end
    end)
end

local function show_reading_menu()
    local title, artist, album = current_track()
    local rows = {
        "Now playing · " .. title,
        "Author · " .. artist,
        "Book · " .. album,
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
    if not in_audiobooks_folder(plugin.get_current_track_path()) then
        plugin.show_toast("Skip controls are for the Audiobooks folder")
        return
    end
    if type(plugin.get_position) ~= "function" or type(plugin.seek) ~= "function" then return end
    local position = tonumber(plugin.get_position()) or 0
    local target = math.max(0, position + delta)
    local duration = type(plugin.get_duration) == "function" and tonumber(plugin.get_duration()) or 0
    if duration and duration > 0 then target = math.min(target, duration) end
    pcall(plugin.seek, target)
end

if has_capability("ui.player_actions") and type(plugin.register_player_action) == "function" then
    plugin.register_player_action("reading_menu", show_reading_menu)
    plugin.register_player_action("speed_menu", show_speed_menu)
    plugin.register_player_action("rewind_15", function() skip_seconds(-15) end)
    plugin.register_player_action("forward_15", function() skip_seconds(15) end)
end

-- Registration lists the layout but deliberately does not select it.
plugin.set_player_layout(layout)

plugin.register_list_item("display", layout.name, function()
    apply_layout(layout, false)
end, { group = "player_layout" })

plugin.register_list_item("display", "Use for Audiobooks folder", function()
    auto_enabled = not auto_enabled
    plugin.storage.set(AUTO_KEY, auto_enabled and "1" or "0")
    if auto_enabled then
        if in_audiobooks_folder(plugin.get_current_track_path()) then
            apply_layout(layout, true)
        end
        plugin.show_toast("Auto-apply enabled for Audiobooks")
    else
        local restored = restore_owned_layout()
        plugin.show_toast(restored and "Auto-apply disabled; preferred layout restored"
            or "Auto-apply disabled")
    end
end, { group = "player_layout" })

plugin.register_list_item("display", "Reading Room · Return to preferred layout", function()
    plugin.show_toast(restore_owned_layout()
        and "Preferred player layout restored"
        or "No Reading Room layout is active")
end, { group = "player_layout" })

if type(plugin.on) == "function" then
    plugin.on("track_started", function()
        local path = type(plugin.get_current_track_path) == "function" and plugin.get_current_track_path()
        if in_audiobooks_folder(path) then
            if auto_enabled then apply_layout(layout, true) end
        else
            restore_owned_layout()
        end
    end)
end
