-- S736F R1/R3 player layout.
plugin.define({ id = "org.compas.s736f_player", name = "S736F", version = "1.0.0", api_min = 17 })
if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.s736f", xml = "S736F/player_layouts/S736F.xml", name = "S736F" })
end
