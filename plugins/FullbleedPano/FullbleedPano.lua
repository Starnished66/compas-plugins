-- FullbleedPano player layout.
plugin.define({ id = "org.compas.fullbleed_pano_player", name = "FullbleedPano", version = "1.1.0", api_min = 19 })

local T = {
    de = {
        ["FullbleedPano"] = "Randlos-Panorama",
    },
    es = {
        ["FullbleedPano"] = "Panorámico sin bordes",
    },
    fi = {
        ["FullbleedPano"] = "Panoraama reunasta reunaan",
    },
    fr = {
        ["FullbleedPano"] = "Panorama plein bord",
    },
    it = {
        ["FullbleedPano"] = "Panorama a tutto schermo",
    },
    ja = {
        ["FullbleedPano"] = "フルブリードパノラマ",
    },
    nl = {
        ["FullbleedPano"] = "Aflopend panorama",
    },
    pt = {
        ["FullbleedPano"] = "Panorâmico sem bordas",
    },
    ru = {
        ["FullbleedPano"] = "Панорама на весь экран",
    },
    uk = {
        ["FullbleedPano"] = "Панорама на весь екран",
    },
    vi = {
        ["FullbleedPano"] = "Toàn cảnh tràn viền",
    },
    zh_CN = {
        ["FullbleedPano"] = "全景全面屏",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.fullbleed_pano", xml = "FullbleedPano/player_layouts/FullbleedPano.xml", name = tr("FullbleedPano") })
end
