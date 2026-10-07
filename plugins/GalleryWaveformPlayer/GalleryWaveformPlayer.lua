-- A Gallery-style Now Playing screen with envelope waveform seeking.

plugin.define({
    id = "org.compas.gallery_waveform_player",
    name = "Gallery Waveform Player",
    version = "1.0.0",
    api_min = 15,
})

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({
        id = "plugin.gallery_waveform_player",
        xml = "GalleryWaveformPlayer/player_layouts/gallery_waveform_player.xml",
        name = "Gallery Waveform Player",
    })
end
