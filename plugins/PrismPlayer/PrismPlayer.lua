-- Accent-led cover art with glass badges and a gradient waveform.
plugin.define({ id = "org.compas.prism_player", name = "Prism Player", version = "0.1.0", api_min = 17 })
if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.prism_player", xml = "PrismPlayer/player_layouts/prism_player.xml", name = "Prism Player" })
end
