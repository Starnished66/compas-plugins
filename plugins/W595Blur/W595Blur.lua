-- W595Blur R1/R3 player layout.
plugin.define({ id = "org.compas.w595_blur_player", name = "W595Blur", version = "1.1.0", api_min = 19 })

local T = {
    de = {
        ["W595Blur"] = "W595 Unschärfe",
    },
    es = {
        ["W595Blur"] = "W595 desenfocado",
    },
    fi = {
        ["W595Blur"] = "W595 sumennus",
    },
    fr = {
        ["W595Blur"] = "W595 flou",
    },
    it = {
        ["W595Blur"] = "W595 sfocato",
    },
    ja = {
        ["W595Blur"] = "W595 ブラー",
    },
    nl = {
        ["W595Blur"] = "W595 vervaagd",
    },
    pt = {
        ["W595Blur"] = "W595 desfocado",
    },
    ru = {
        ["W595Blur"] = "W595 с размытием",
    },
    uk = {
        ["W595Blur"] = "W595 із розмиттям",
    },
    vi = {
        ["W595Blur"] = "W595 làm mờ",
    },
    zh_CN = {
        ["W595Blur"] = "W595 模糊",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.w595_blur", xml = "W595Blur/player_layouts/W595Blur.xml", name = tr("W595Blur") })
end
