-- Accent-led cover art with glass badges and a gradient waveform.
plugin.define({ id = "org.compas.prism_player", name = "Prism Player", version = "0.2.0", api_min = 19 })

local T = {
    de = {
        ["Prism Player"] = "Prisma-Player",
    },
    es = {
        ["Prism Player"] = "Reproductor prisma",
    },
    fi = {
        ["Prism Player"] = "Prismasoitin",
    },
    fr = {
        ["Prism Player"] = "Lecteur prisme",
    },
    it = {
        ["Prism Player"] = "Lettore prisma",
    },
    ja = {
        ["Prism Player"] = "プリズムプレーヤー",
    },
    nl = {
        ["Prism Player"] = "Prismaspeler",
    },
    pt = {
        ["Prism Player"] = "Reprodutor prisma",
    },
    ru = {
        ["Prism Player"] = "Призма-плеер",
    },
    uk = {
        ["Prism Player"] = "Призма-плеєр",
    },
    vi = {
        ["Prism Player"] = "Trình phát lăng kính",
    },
    zh_CN = {
        ["Prism Player"] = "棱镜播放器",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.prism_player", xml = "PrismPlayer/player_layouts/prism_player.xml", name = tr("Prism Player") })
end
