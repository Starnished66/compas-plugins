-- The built-in Now Playing screen as a downloadable layout, with waveform bars.

plugin.define({
    id = "org.compas.default_waveform_player",
    name = "Default Waveform Player",
    version = "1.0.2",
    api_min = 17,
})

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({
        id = "plugin.default_waveform_player",
        xml = "DefaultWaveformPlayer/player_layouts/default_waveform_player.xml",
        name = "Default Waveform Player",
    })
end
