-- Fullbleed R1/R3 player layout.
plugin.define({ id = "org.compas.fullbleed_player", name = "Fullbleed", version = "1.0.0", api_min = 17 })
if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.fullbleed", xml = "Fullbleed/player_layouts/fullbleed.xml", name = "Fullbleed" })
end
