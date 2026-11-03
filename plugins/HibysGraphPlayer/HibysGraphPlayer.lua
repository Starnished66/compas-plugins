-- A HiBy-style Now Playing layout with a filled-envelope waveform seek bar.

plugin.define({
    id = "org.compas.hibys_graph_player",
    name = "Hiby's Graph Player",
    version = "1.1.0",
    api_min = 19,
})

local T = {
    de = {
        ["Hiby's Graph Player"] = "Hibys Grafik-Player",
    },
    es = {
        ["Hiby's Graph Player"] = "Reproductor gráfico de Hiby",
    },
    fi = {
        ["Hiby's Graph Player"] = "Hibyn graafisoitin",
    },
    fr = {
        ["Hiby's Graph Player"] = "Lecteur graphique de Hiby",
    },
    it = {
        ["Hiby's Graph Player"] = "Lettore grafico di Hiby",
    },
    ja = {
        ["Hiby's Graph Player"] = "Hiby グラフプレーヤー",
    },
    nl = {
        ["Hiby's Graph Player"] = "Hiby's grafiekspeler",
    },
    pt = {
        ["Hiby's Graph Player"] = "Reprodutor gráfico da Hiby",
    },
    ru = {
        ["Hiby's Graph Player"] = "Графический плеер Hiby",
    },
    uk = {
        ["Hiby's Graph Player"] = "Графічний плеєр Hiby",
    },
    vi = {
        ["Hiby's Graph Player"] = "Trình phát đồ thị của Hiby",
    },
    zh_CN = {
        ["Hiby's Graph Player"] = "Hiby 图形播放器",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({
        id = "plugin.hibys_graph_player",
        xml = "HibysGraphPlayer/player_layouts/hibys_graph_player.xml",
        name = tr("Hiby's Graph Player"),
    })
end
