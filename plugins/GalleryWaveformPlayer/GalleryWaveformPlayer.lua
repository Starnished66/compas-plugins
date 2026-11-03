-- A Gallery-style Now Playing screen with envelope waveform seeking.

plugin.define({
    id = "org.compas.gallery_waveform_player",
    name = "Gallery Waveform Player",
    version = "1.1.0",
    api_min = 19,
})

local T = {
    de = {
        ["Gallery Waveform Player"] = "Galerie-Wellenform-Player",
    },
    es = {
        ["Gallery Waveform Player"] = "Reproductor galería con forma de onda",
    },
    fi = {
        ["Gallery Waveform Player"] = "Galleria-aaltomuotosoitin",
    },
    fr = {
        ["Gallery Waveform Player"] = "Lecteur galerie à forme d'onde",
    },
    it = {
        ["Gallery Waveform Player"] = "Lettore galleria con forma d'onda",
    },
    ja = {
        ["Gallery Waveform Player"] = "ギャラリー波形プレーヤー",
    },
    nl = {
        ["Gallery Waveform Player"] = "Galerie-golfvormspeler",
    },
    pt = {
        ["Gallery Waveform Player"] = "Reprodutor galeria com forma de onda",
    },
    ru = {
        ["Gallery Waveform Player"] = "Галерейный плеер с волной",
    },
    uk = {
        ["Gallery Waveform Player"] = "Галерейний плеєр із хвилею",
    },
    vi = {
        ["Gallery Waveform Player"] = "Trình phát phòng tranh dạng sóng",
    },
    zh_CN = {
        ["Gallery Waveform Player"] = "画廊波形播放器",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({
        id = "plugin.gallery_waveform_player",
        xml = "GalleryWaveformPlayer/player_layouts/gallery_waveform_player.xml",
        name = tr("Gallery Waveform Player"),
    })
end
