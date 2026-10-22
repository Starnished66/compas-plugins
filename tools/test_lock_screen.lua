-- Run: lua tools/test_lock_screen.lua
local folder = (arg[0]:match("^(.*)/") or ".")
local values, configure_calls, settings, open_settings = {}, {}, nil, nil
local display_entry, settings_title, settings_rows, settings_options
local list_title, list_items, list_callback
local reject = false
local photo_path = folder .. "/lock_screen_test_photo.jpg"
local photo_file = assert(io.open(photo_path, "wb"))
photo_file:write("test photo")
photo_file:close()
plugin = {
  define = function(info)
    assert(info.api_min == 19)
    assert(info.version == "1.7.1")
  end,
  has_capability = function() return true end,
  sd_root = function() return folder end,
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
  register_list_item = function(section, label, callback, options)
    assert(section == "display" and label == "Lock Screen")
    display_entry = { callback = callback, options = options }
    open_settings = callback
  end,
  show_settings_list = function(title, rows, options)
    settings_title, settings_rows, settings_options = title, rows, options
    if title == "Lock Screen" then settings = rows end
  end,
  list_dir = function(path)
    assert(path == folder)
    return { { name = "lock_screen_test_photo.jpg", dir = false } }
  end,
  show_list = function(title, items, callback)
    list_title, list_items, list_callback = title, items, callback
  end,
  show_toast = function() end,
}
assert(loadfile(folder .. "/../plugins/LockScreen/LockScreen.lua"))()
assert(configure_calls[1] == false)
assert(values.button_lock == nil)
assert(display_entry and display_entry.options.group == nil)
open_settings()
assert(settings_title == "Lock Screen")
assert(settings_options.preview.mode == "album_art")
assert(settings[2].value == false)
assert(settings[2].label == "Unlock with buttons\nHold Power + turn volume up")
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
open_settings()
assert(settings[2].value == true)
assert(settings[2].label == "Unlock with buttons\nHold Power + turn volume up")
values.background = "image"
values.image_path = photo_path
values.image_fit = "contain"
open_settings()
assert(settings_options.preview.mode == "image")
assert(settings_options.preview.image_path == photo_path)
assert(settings_options.preview.image_fit == "contain")
settings[3].on_select()
assert(settings_title == "Lock Screen Background")
assert(settings_options.preview.mode == "image")
assert(#settings_rows == 4)
assert(settings_rows[1].label == "Album art")
assert(settings_rows[2].label:find("Photo", 1, true))
assert(settings_rows[3].label:find("Clock", 1, true))
settings_rows[3].on_select()
assert(values.background == "clock")
assert(values.image_path == photo_path and values.image_fit == "contain")
assert(settings_title == "Lock Screen Background" and settings_options.update == true)
assert(settings_options.preview.mode == "clock")
assert(settings[3].label == "Background\nClock")
settings_rows[1].on_select()
assert(values.background == "album_art")
assert(settings_options.preview.mode == "album_art")
assert(values.image_path == photo_path and values.image_fit == "contain")
settings_rows[2].on_select()
assert(settings_options.preview.mode == "image")
assert(settings_options.preview.image_path == photo_path)
assert(settings_rows[4].label == "Choose photo")
settings_rows[4].on_select()
assert(list_title:match("Choose Photo"))
assert(#list_items == 1 and list_items[1].label == "lock_screen_test_photo.jpg")
list_callback(1)
assert(values.background == "image")
assert(values.image_path == photo_path)
assert(settings_title == "Lock Screen Background" and settings_options.update == true)
assert(settings_options.preview.mode == "image")
assert(settings_options.preview.image_path == photo_path)
assert(settings_options.preview.image_fit == "contain")
assert(settings[3].label == "Background\nPhoto")
os.remove(photo_path)
print("Lock Screen native background preview modes, photo return, and button-unlock option: PASS")
