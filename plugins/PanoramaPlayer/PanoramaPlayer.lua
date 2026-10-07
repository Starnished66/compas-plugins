-- A panoramic Now Playing screen with animated lyrics, waveform seeking, and artwork fade.

plugin.define({
    id = "org.compas.panorama_player",
    name = "Panorama Player",
    version = "1.1.2",
    api_min = 15,
})

local LAYOUT = {
    id = "plugin.panorama_player",
    xml = "PanoramaPlayer/player_layouts/panorama_player.xml",
    name = "Panorama Player",
}

local LAYOUT_DIR = plugin.sd_root() .. "/.plugins/PanoramaPlayer/player_layouts/"
local MIGRATION_KEY = "generated_at_variants_migrated_v1"

local function remove_legacy_variant(size)
    local old_path = LAYOUT_DIR .. "panorama_player@" .. size .. ".xml"
    local old_file = io.open(old_path, "rb")
    if not old_file then return true end
    old_file:close()

    local new_file = io.open(LAYOUT_DIR .. "panorama_player_" .. size .. ".xml", "rb")
    if not new_file then return false end
    new_file:close()

    if os.remove(old_path) then return true end
    old_file = io.open(old_path, "rb")
    if old_file then old_file:close(); return false end
    return true
end

local function migrate_legacy_variants()
    if plugin.storage.get(MIGRATION_KEY) == "1" then return end
    if remove_legacy_variant("320x480") and remove_legacy_variant("480x720") then
        plugin.storage.set(MIGRATION_KEY, "1")
    end
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    migrate_legacy_variants()
    -- Keep the historical layout ID and label for saved selections. The
    -- layout picker discovers the XML and its board variants automatically.
    plugin.set_player_layout(LAYOUT)
end
