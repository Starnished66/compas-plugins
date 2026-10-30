-- W595 R1/R3 player layout.
plugin.define({ id = "org.compas.w595_player", name = "W595", version = "1.0.0", api_min = 17 })
if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.w595", xml = "W595/player_layouts/W595.xml", name = "W595" })
end
