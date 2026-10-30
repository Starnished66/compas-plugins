-- FullbleedPano R1/R3 player layout.
plugin.define({ id = "org.compas.fullbleed_pano_player", name = "FullbleedPano", version = "1.0.0", api_min = 17 })
if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.fullbleed_pano", xml = "FullbleedPano/player_layouts/FullbleedPano.xml", name = "FullbleedPano" })
end
