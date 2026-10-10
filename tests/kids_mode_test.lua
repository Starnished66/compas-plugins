local plugin_path = arg[1] or "plugins/KidsMode/KidsMode.lua"

local function reset(enabled, pin)
    local state = {
        enabled = enabled or "0",
        pin = pin or "1234",
        storage_write_ok = true,
        secret_write_ok = true,
        layouts = {},
        reloads = 0,
        toasts = {},
    }
    local parent_tile, settings_row
    local prompt
    plugin = {
        define = function(def) assert(def.api_min == 7); state.id = def.id end,
        storage = {
            get = function(key, default)
                if key == "enabled" then return state.enabled or default end
                error("unexpected storage key " .. key)
            end,
            set = function(key, value)
                assert(key == "enabled" and (value == "0" or value == "1"))
                if not state.storage_write_ok then return false end
                state.enabled = value
                return true
            end,
        },
        secrets = {
            get = function(key) assert(key == "pin"); return state.pin end,
            set = function(key, value)
                assert(key == "pin" and type(value) == "string")
                if not state.secret_write_ok then return false end
                state.pin = value
                return true
            end,
        },
        register_home_tile = function(id, label, callback, icon)
            assert(id == "kids_parent" and label == "Parent Mode" and icon ~= "")
            parent_tile = callback
        end,
        set_home_layout = function(tiles, options)
            state.layouts[#state.layouts + 1] = { tiles = tiles, options = options }
        end,
        register_list_item = function(target, label, callback)
            assert(target == "settings" and label == "Kids Mode")
            settings_row = callback
        end,
        show_settings_list = function(title, items)
            assert(title == "Kids Mode")
            state.settings = items
        end,
        show_text_input = function(title, initial, password, callback)
            prompt = { title = title, password = password, submit = callback }
        end,
        show_toast = function(message) state.toasts[#state.toasts + 1] = message end,
        reload_ui = function() state.reloads = state.reloads + 1 end,
    }
    dofile(plugin_path)
    return state, function() return parent_tile, settings_row, prompt end
end

-- Disabled startup must leave another plugin/theme's Home layout alone.
local state, ui = reset("0")
assert(state.id == "example.kidsmode")
assert(#state.layouts == 0 and state.reloads == 0)
local parent, open_settings = ui()
parent()
local _, _, prompt = ui()
prompt.submit("0000")
assert(state.enabled == "0" and state.reloads == 0)
assert(state.toasts[#state.toasts] == "Incorrect PIN")
prompt.submit("1234")
assert(state.enabled == "0" and state.reloads == 1) -- default PIN is accepted, but storage mock still begins off
assert(state.reloads == 1)

-- Settings save failure leaves memory and persisted state off; success asks for
-- a native plugin reload, whose top-level run applies the enabled layout.
open_settings()
local toggle = state.settings[1]
state.storage_write_ok = false
toggle.on_change(true)
assert(state.enabled == "0" and state.reloads == 1 and #state.layouts == 0)
assert(state.toasts[#state.toasts] == "Unable to save Kids Mode setting")
state.storage_write_ok = true
toggle.on_change(true)
assert(state.enabled == "1" and state.reloads == 2 and #state.layouts == 0)
local enabled_state, enabled_ui = reset(state.enabled, state.pin)
assert(#enabled_state.layouts == 1)
assert(enabled_state.layouts[1].options.mode == "tile")
assert(enabled_state.layouts[1].options.order[1] == "music")
assert(enabled_state.layouts[1].options.order[2] == "books")
assert(enabled_state.layouts[1].options.order[3] == "kids_parent")

-- PIN changes only take effect when secrets storage confirms the write.
local parent2, open_settings2 = enabled_ui()
enabled_state.storage_write_ok = false
parent2()
local _, _, disable_failed = enabled_ui()
disable_failed.submit("1234")
assert(enabled_state.enabled == "1" and enabled_state.reloads == 0)
assert(enabled_state.toasts[#enabled_state.toasts] == "Unable to save Kids Mode setting")
enabled_state.storage_write_ok = true
parent2()
local _, _, disable_ok = enabled_ui()
disable_ok.submit("1234")
assert(enabled_state.enabled == "0" and enabled_state.reloads == 1)

open_settings2()
local change_pin = enabled_state.settings[2]
enabled_state.secret_write_ok = false
change_pin.on_select()
local _, _, prompt2 = enabled_ui()
prompt2.submit("9876")
assert(enabled_state.pin == "1234")
assert(enabled_state.toasts[#enabled_state.toasts] == "Unable to save PIN")
parent2()
local _, _, old_pin_prompt = enabled_ui()
old_pin_prompt.submit("1234")
assert(enabled_state.reloads == 2)
enabled_state.secret_write_ok = true
change_pin.on_select()
local _, _, prompt3 = enabled_ui()
prompt3.submit("9876")
assert(enabled_state.pin == "9876")
assert(enabled_state.toasts[#enabled_state.toasts] == "PIN updated")
parent2()
local _, _, new_pin_prompt = enabled_ui()
new_pin_prompt.submit("1234")
assert(enabled_state.reloads == 2)
new_pin_prompt.submit("9876")
assert(enabled_state.reloads == 3)

print("KidsMode API 15 compatibility checks passed")
