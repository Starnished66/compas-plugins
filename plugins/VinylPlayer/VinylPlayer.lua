-- A vinyl-inspired Now Playing screen with an envelope waveform seek bar and standard playback controls.

plugin.define({
    id = "org.compas.vinyl_player",
    name = "Vinyl Player",
    version = "1.1.0",
    api_min = 19,
})

local T = {
    de = {
        ["Vinyl Player"] = "Plattenspieler",
    },
    es = {
        ["Vinyl Player"] = "Tocadiscos",
    },
    fi = {
        ["Vinyl Player"] = "Levysoitin",
    },
    fr = {
        ["Vinyl Player"] = "Platine vinyle",
    },
    it = {
        ["Vinyl Player"] = "Giradischi",
    },
    ja = {
        ["Vinyl Player"] = "レコードプレーヤー",
    },
    nl = {
        ["Vinyl Player"] = "Platenspeler",
    },
    pt = {
        ["Vinyl Player"] = "Toca-discos",
    },
    ru = {
        ["Vinyl Player"] = "Виниловый проигрыватель",
    },
    uk = {
        ["Vinyl Player"] = "Вініловий програвач",
    },
    vi = {
        ["Vinyl Player"] = "Đầu đĩa than",
    },
    zh_CN = {
        ["Vinyl Player"] = "黑胶唱片机",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

local LAYOUT = {
    id = "plugin.vinyl_player",
    xml = "VinylPlayer/player_layouts/vinyl_player.xml",
    name = tr("Vinyl Player"),
}

local LAYOUT_DIR = plugin.sd_root() .. "/.plugins/VinylPlayer/player_layouts/"
local MIGRATION_KEY = "generated_at_variants_migrated_v1"

local function remove_legacy_variant(size)
    local old_path = LAYOUT_DIR .. "vinyl_player@" .. size .. ".xml"
    local old_file = io.open(old_path, "rb")
    if not old_file then return true end
    old_file:close()

    local new_file = io.open(LAYOUT_DIR .. "vinyl_player_" .. size .. ".xml", "rb")
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
