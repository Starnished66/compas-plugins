plugin.define({ id = "example.kidsmode", name = "Kids Mode", version = "3.0.0", api_min = 7 })

-- Not a full lockdown: the Quick Drawer (swipe down from the top edge) is
-- native UI this plugin API has no hook to hide, and its Wi-Fi/Bluetooth
-- icons long-press straight into their own native settings screens
-- regardless of Home's layout.

local enabled = plugin.storage.get("enabled", "0") == "1" -- off by default
local pin = plugin.secrets.get("pin") or "1234" -- default pin

local function show_parent_pin_prompt()
    plugin.show_text_input("Parent PIN", "", true, function(text)
        if text == pin then
            if not plugin.storage.set("enabled", "0") then
                plugin.show_toast("Unable to save Kids Mode setting")
                return
            end
            enabled = false
            plugin.reload_ui() -- user action -> native reload resets the Home layout
        else
            plugin.show_toast("Incorrect PIN")
        end
    end)
end

plugin.register_home_tile("kids_parent", "Parent Mode", show_parent_pin_prompt, "launcher/sys_set.png")

local function apply_layout()
    if not enabled then return end
    plugin.set_home_layout({
        { key = "kids_parent", bg_color = 0x3a3a3a, text_color = 0xcccccc, radius = 24, text_size = "small" },
    }, { mode = "tile", tile_gap = 24, order = { "music", "books", "kids_parent" } })
end

apply_layout()

-- Settings > System > Additional Tools row: only reachable once Kids Mode
-- is off (Settings itself isn't in Home's order while it's on), for
-- turning it back on or changing the PIN.
plugin.register_list_item("settings", "Kids Mode", function()
    plugin.show_settings_list("Kids Mode", {
        { type = "toggle", label = "Enable Kids Mode", value = enabled, on_change = function(new_value)
            if not plugin.storage.set("enabled", new_value and "1" or "0") then
                plugin.show_toast("Unable to save Kids Mode setting")
                return
            end
            enabled = new_value
            plugin.reload_ui()
        end },
        { type = "row", label = "Change Parent PIN", on_select = function()
            plugin.show_text_input("New Parent PIN (4+ digits only)", "", true, function(text)
                if text:match("^%d%d%d%d+$") then
                    if plugin.secrets.set("pin", text) then
                        pin = text
                        plugin.show_toast("PIN updated")
                    else
                        plugin.show_toast("Unable to save PIN")
                    end
                else
                    plugin.show_toast("PIN must be at least 4 digits")
                end
            end)
        end },
    })
end)
