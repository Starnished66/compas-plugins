-- A classic HiBy-style Now Playing layout.

plugin.define({
    id = "org.compas.hibys_player",
    name = "Hiby's Player",
    version = "1.1.0",
    api_min = 19,
})

local T = {
    de = {
        ["Hiby's Player"] = "Hibys Player",
    },
    es = {
        ["Hiby's Player"] = "Reproductor de Hiby",
    },
    fi = {
        ["Hiby's Player"] = "Hibyn soitin",
    },
    fr = {
        ["Hiby's Player"] = "Lecteur de Hiby",
    },
    it = {
        ["Hiby's Player"] = "Lettore di Hiby",
    },
    ja = {
        ["Hiby's Player"] = "Hiby プレーヤー",
    },
    nl = {
        ["Hiby's Player"] = "Hiby's speler",
    },
    pt = {
        ["Hiby's Player"] = "Reprodutor da Hiby",
    },
    ru = {
        ["Hiby's Player"] = "Плеер Hiby",
    },
    uk = {
        ["Hiby's Player"] = "Плеєр Hiby",
    },
    vi = {
        ["Hiby's Player"] = "Trình phát của Hiby",
    },
    zh_CN = {
        ["Hiby's Player"] = "Hiby 播放器",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({
        id = "plugin.hibys_player",
        xml = "HibysPlayer/player_layouts/hibys_player.xml",
        name = tr("Hiby's Player"),
    })
end
