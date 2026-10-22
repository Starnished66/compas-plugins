-- Run: lua tools/test_lock_screen.lua
local folder = (arg[0]:match("^(.*)/") or ".")
local values, configure_calls, settings, open_settings = {}, {}, nil, nil
local reject = false
plugin = {
  define = function(info) assert(info.api_min == 18) end,
  has_capability = function() return true end,
  storage = {
    get = function(key, fallback) return values[key] or fallback end,
    set = function(key, value) values[key] = value end,
  },
  configure_button_lock = function(enabled)
    if reject then error("native configuration rejected") end
    configure_calls[#configure_calls + 1] = enabled
    return "Hold Power + turn volume up"
  end,
  on = function() end,
  register_list_item = function(_, _, callback) open_settings = callback end,
  show_settings_list = function(_, rows) settings = rows end,
}
assert(loadfile(folder .. "/../plugins/LockScreen/LockScreen.lua"))()
assert(configure_calls[1] == false)
assert(values.button_lock == nil)
open_settings()
assert(settings[2].value == false)
assert(settings[2].label:find("Hold Power + turn volume up", 1, true))
settings[2].on_change(true)
assert(configure_calls[#configure_calls] == true and values.button_lock == "1")
settings[2].on_change(false)
assert(configure_calls[#configure_calls] == false and values.button_lock == "0")
reject = true
assert(not pcall(settings[2].on_change, true))
assert(values.button_lock == "0")
reject = false
values.button_lock = "1"
assert(loadfile(folder .. "/../plugins/LockScreen/LockScreen.lua"))()
assert(configure_calls[#configure_calls] == true)
print("Lock Screen button-lock option: PASS")
