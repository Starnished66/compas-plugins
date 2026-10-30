-- W595Blur R1/R3 player layout.
plugin.define({ id = "org.compas.w595_blur_player", name = "W595Blur", version = "1.0.0", api_min = 17 })
if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.w595_blur", xml = "W595Blur/player_layouts/W595Blur.xml", name = "W595Blur" })
end
