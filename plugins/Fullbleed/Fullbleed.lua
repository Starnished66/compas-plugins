-- Fullbleed player layout.
plugin.define({ id = "org.compas.fullbleed_player", name = "Fullbleed", version = "1.1.0", api_min = 19 })

local T = {
    de = {
        ["Fullbleed"] = "Randlos",
    },
    es = {
        ["Fullbleed"] = "Sin bordes",
    },
    fi = {
        ["Fullbleed"] = "Reunasta reunaan",
    },
    fr = {
        ["Fullbleed"] = "Plein bord",
    },
    it = {
        ["Fullbleed"] = "A tutto schermo",
    },
    ja = {
        ["Fullbleed"] = "フルブリード",
    },
    nl = {
        ["Fullbleed"] = "Aflopend",
    },
    pt = {
        ["Fullbleed"] = "Sem bordas",
    },
    ru = {
        ["Fullbleed"] = "На весь экран",
    },
    uk = {
        ["Fullbleed"] = "На весь екран",
    },
    vi = {
        ["Fullbleed"] = "Tràn viền",
    },
    zh_CN = {
        ["Fullbleed"] = "全面屏",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.fullbleed", xml = "Fullbleed/player_layouts/fullbleed.xml", name = tr("Fullbleed") })
end
