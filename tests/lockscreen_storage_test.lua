-- Regression coverage for Lock Screen preferences using the API 15 string storage contract.
local PLUGIN_PATH = "plugins/LockScreen/LockScreen.lua"

local function fail(message)
  error(message, 2)
end

local function equal(actual, expected, message)
  if actual ~= expected then
    fail((message or "values differ") .. ": got " .. tostring(actual) .. ", expected " .. tostring(expected))
  end
end

local function truthy(value, message)
  if not value then fail(message or "expected a truthy value") end
end

local function boot(storage)
  local runtime = { storage = storage, events = {}, toasts = {}, lock_screens = {} }
  local plugin = {
    define = function() end,
    storage = {
      get = function(key, default)
        local value = storage[key]
        if value == nil then return default end
        return value
      end,
      set = function(key, value)
        if type(key) ~= "string" or type(value) ~= "string" then
          error("plugin.storage.set accepts strings only")
        end
        storage[key] = value
        return true
      end,
    },
    has_capability = function(name) return name == "ui.lock_screen" end,
    show_toast = function(message) runtime.toasts[#runtime.toasts + 1] = message end,
    show_lock_screen = function(options)
      runtime.lock_screens[#runtime.lock_screens + 1] = options
      return true
    end,
    on = function(name, callback) runtime.events[name] = callback end,
    register_list_item = function(_, _, callback) runtime.open_settings = callback end,
    show_settings_list = function(title, rows, options)
      runtime.settings = { title = title, rows = rows, options = options }
    end,
    show_list = function(title, items, callback)
      runtime.list = { title = title, items = items, callback = callback }
    end,
    sd_root = function() return "/sdcard" end,
    list_dir = function() return {} end,
  }
  _G.plugin = plugin
  assert(loadfile(PLUGIN_PATH))()
  return runtime
end

local function settings(runtime)
  runtime.open_settings()
  truthy(runtime.settings, "settings screen was not opened")
  return runtime.settings.rows
end

local function row(rows, label)
  for _, item in ipairs(rows) do
    if item.label == label then return item end
  end
  fail("missing settings row: " .. label)
end

local function wake(runtime)
  truthy(runtime.events.screen_woke, "screen_woke handler was not registered")
  runtime.events.screen_woke()
end

-- Enabling persists a string, survives a reload, and disables wake behavior with "0".
do
  local storage = {}
  local first = boot(storage)
  local toggle = row(settings(first), "Lock screen")
  equal(toggle.value, false, "new install should be disabled")
  toggle.on_change(true)
  equal(storage.enabled, "1", "enable should persist string 1")
  equal(storage.mode, "album_art", "enable should maintain the legacy mode")
  wake(first)
  equal(first.lock_screens[1].mode, "album_art", "enabled wake background")

  local reloaded = boot(storage)
  equal(row(settings(reloaded), "Lock screen").value, true, "enabled state should reload")
  wake(reloaded)
  equal(reloaded.lock_screens[1].mode, "album_art", "reloaded wake background")
  row(settings(reloaded), "Lock screen").on_change(false)
  equal(storage.enabled, "0", "disable should persist string 0")
  equal(storage.mode, "off", "disable should preserve legacy off mode")
  wake(reloaded)
  equal(#reloaded.lock_screens, 1, "disabled wake should not show lock screen")
end

-- Background updates persist separately while on and off, including after reload.
do
  local storage = { enabled = "1", mode = "album_art" }
  local runtime = boot(storage)
  row(settings(runtime), "Background\nAlbum art").on_select()
  truthy(runtime.list, "background choices should open")
  runtime.list.callback(3) -- Clock
  equal(storage.background, "clock", "background choice should persist")
  equal(storage.mode, "clock", "enabled background should update legacy mode")

  local reloaded = boot(storage)
  wake(reloaded)
  equal(reloaded.lock_screens[1].mode, "clock", "background should survive reload")
  row(settings(reloaded), "Lock screen").on_change(false)
  row(settings(reloaded), "Background\nClock").on_select()
  reloaded.list.callback(1) -- Album art
  equal(storage.background, "album_art", "background may change while disabled")
  equal(storage.mode, "off", "disabled background update must keep legacy mode off")
  row(settings(reloaded), "Lock screen").on_change(true)
  equal(storage.mode, "album_art", "reenable should restore selected background")
end

-- Old mode-only installations still determine both enabled state and background.
do
  local legacy_on = boot({ mode = "clock" })
  equal(row(settings(legacy_on), "Lock screen").value, true, "legacy background mode means enabled")
  wake(legacy_on)
  equal(legacy_on.lock_screens[1].mode, "clock", "legacy background should remain selected")

  local legacy_off = boot({ mode = "off" })
  equal(row(settings(legacy_off), "Lock screen").value, false, "legacy off mode means disabled")
  local state = settings(legacy_off)
  equal(state[2].label, "Background\nAlbum art", "legacy off defaults to album art background")
  wake(legacy_off)
  equal(#legacy_off.lock_screens, 0, "legacy off must stay disabled on wake")
end

print("Lock Screen string storage tests passed")
