-- A HiBy-style Now Playing layout with a filled-envelope waveform seek bar.

plugin.define({
    id = "org.compas.hibys_graph_player",
    name = "Hiby's Graph Player",
    version = "1.0.0",
    api_min = 15,
})

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({
        id = "plugin.hibys_graph_player",
        xml = "HibysGraphPlayer/player_layouts/hibys_graph_player.xml",
        name = "Hiby's Graph Player",
    })
end
