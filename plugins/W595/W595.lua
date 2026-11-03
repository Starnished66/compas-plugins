-- W595 R1/R3 player layout.
plugin.define({ id = "org.compas.w595_player", name = "W595", version = "1.1.0", api_min = 19 })

local T = {
    de = {
        ["W595"] = "W595",
    },
    es = {
        ["W595"] = "W595",
    },
    fi = {
        ["W595"] = "W595",
    },
    fr = {
        ["W595"] = "W595",
    },
    it = {
        ["W595"] = "W595",
    },
    ja = {
        ["W595"] = "W595",
    },
    nl = {
        ["W595"] = "W595",
    },
    pt = {
        ["W595"] = "W595",
    },
    ru = {
        ["W595"] = "W595",
    },
    uk = {
        ["W595"] = "W595",
    },
    vi = {
        ["W595"] = "W595",
    },
    zh_CN = {
        ["W595"] = "W595",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.w595", xml = "W595/player_layouts/W595.xml", name = tr("W595") })
end
