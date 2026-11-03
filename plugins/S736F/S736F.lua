-- S736F R1/R3 player layout.
plugin.define({ id = "org.compas.s736f_player", name = "S736F", version = "1.1.0", api_min = 19 })

local T = {
    de = {
        ["S736F"] = "S736F",
    },
    es = {
        ["S736F"] = "S736F",
    },
    fi = {
        ["S736F"] = "S736F",
    },
    fr = {
        ["S736F"] = "S736F",
    },
    it = {
        ["S736F"] = "S736F",
    },
    ja = {
        ["S736F"] = "S736F",
    },
    nl = {
        ["S736F"] = "S736F",
    },
    pt = {
        ["S736F"] = "S736F",
    },
    ru = {
        ["S736F"] = "S736F",
    },
    uk = {
        ["S736F"] = "S736F",
    },
    vi = {
        ["S736F"] = "S736F",
    },
    zh_CN = {
        ["S736F"] = "S736F",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if plugin.has_capability and plugin.has_capability("ui.player_layout_xml") then
    plugin.set_player_layout({ id = "plugin.s736f", xml = "S736F/player_layouts/S736F.xml", name = tr("S736F") })
end
