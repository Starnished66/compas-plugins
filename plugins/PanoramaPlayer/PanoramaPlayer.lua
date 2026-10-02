-- A panoramic Now Playing screen with animated lyrics, a waveform seek bar, and artwork fade.
-- The board-sized XML variants keep the artwork and transport controls fitted
-- on all three supported player displays.

plugin.define({
    id = "org.compas.panorama_player",
    name = "Panorama Player",
    version = "1.0.0",
    -- Lyrics, seek_style, waveform_bars, and cover_fade need current player builds.
    api_min = 14,
})

local LAYOUT = {
    id = "plugin.panorama_player",
    xml = "PanoramaPlayer/player_layouts/panorama_player.xml",
    name = "Panorama Player",
}

local LAYOUT_DIR = plugin.sd_root() .. "/.plugins/PanoramaPlayer/player_layouts/"
local MAX_LAYOUT_BYTES = 65536

-- The Store format accepts only plain path characters, while the player's
-- layout resolver expects an `@WIDTHxHEIGHT` sibling name. Keep downloaded
-- assets under plain names and materialize those siblings locally.
local function copy_board_variant(size)
    local source = io.open(LAYOUT_DIR .. "panorama_player_" .. size .. ".xml", "rb")
    if not source then return false end
    local data = source:read(MAX_LAYOUT_BYTES + 1)
    local source_closed = source:close()
    if not data or #data == 0 or #data > MAX_LAYOUT_BYTES or not source_closed then return false end

    local destination = LAYOUT_DIR .. "panorama_player@" .. size .. ".xml"
    local existing = io.open(destination, "rb")
    if existing then
        local current = existing:read(MAX_LAYOUT_BYTES + 1)
        existing:close()
        if current == data then return true end
    end
    local temporary = destination .. ".tmp"
    local output = io.open(temporary, "wb")
    if not output then return false end
    local wrote = output:write(data)
    local output_closed = output:close()
    if not wrote or not output_closed then
        os.remove(temporary)
        return false
    end
    if not os.rename(temporary, destination) then
        os.remove(temporary)
        return false
    end
    return true
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    -- The variant copies stay inside this nested folder, which the player's
    -- layout discovery does not scan. Register only when both are ready.
    if copy_board_variant("320x480") and copy_board_variant("480x720") then
        -- Top-level registration makes the layout selectable in Display
        -- settings; it does not switch the active screen during startup.
        plugin.set_player_layout(LAYOUT)

        plugin.register_list_item("display", "Panorama Player", function()
            local ok, err = pcall(plugin.set_player_layout, LAYOUT)
            if ok then
                plugin.show_toast("Panorama Player applied")
            else
                plugin.show_toast("Could not apply Panorama Player: " .. tostring(err))
            end
        end, { group = "player_layout" })
    end
end
