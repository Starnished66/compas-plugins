-- The built-in Now Playing screen as a downloadable layout, with waveform bars.

plugin.define({
    id = "org.compas.default_waveform_player",
    name = "Default Waveform Player",
    version = "1.1.0",
    api_min = 19,
})

local T = {
    de = {
        ["Default Waveform Player"] = "Standard-Wellenform-Player",
    },
    es = {
        ["Default Waveform Player"] = "Reproductor con forma de onda predeterminado",
    },
    fi = {
        ["Default Waveform Player"] = "Oletusaaltomuotosoitin",
    },
    fr = {
        ["Default Waveform Player"] = "Lecteur à forme d'onde par défaut",
    },
    it = {
        ["Default Waveform Player"] = "Lettore forma d'onda predefinito",
    },
    ja = {
        ["Default Waveform Player"] = "標準波形プレーヤー",
    },
    nl = {
        ["Default Waveform Player"] = "Standaard golfvormspeler",
    },
    pt = {
        ["Default Waveform Player"] = "Reprodutor com forma de onda padrão",
    },
    ru = {
        ["Default Waveform Player"] = "Стандартный плеер с волной",
    },
    uk = {
        ["Default Waveform Player"] = "Стандартний плеєр із хвилею",
    },
    vi = {
        ["Default Waveform Player"] = "Trình phát dạng sóng mặc định",
    },
    zh_CN = {
        ["Default Waveform Player"] = "默认波形播放器",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({
        id = "plugin.default_waveform_player",
        xml = "DefaultWaveformPlayer/player_layouts/default_waveform_player.xml",
        name = tr("Default Waveform Player"),
    })
end
