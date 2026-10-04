-- A classic HiBy-style Now Playing layout.

plugin.define({
    id = "org.compas.hibys_player",
    name = "Hiby's Player",
    version = "1.0.0",
    api_min = 15,
})

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({
        id = "plugin.hibys_player",
        xml = "HibysPlayer/player_layouts/hibys_player.xml",
        name = "Hiby's Player",
    })
end
