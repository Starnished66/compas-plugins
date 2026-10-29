-- Run: lua tools/test_lastfm_network.lua
-- Exercises the Last.fm scrobbler's network awareness against a stub player.
local folder = (arg[0]:match("^(.*)/") or ".")
local clock = os.time()
os.time = function() return clock end

local values, handlers, requests, net, list_items
local function load_plugin(new_player)
  values = {
    enabled = "1", api_key = string.rep("a", 32), api_secret = "s", session_key = "sk",
    username = "tester", legacy_queue_done = "1", legacy_state_done = "1",
  }
  handlers, requests, list_items = {}, {}, nil
  net = { connected = true, wifi_enabled = true }
  local function queue(id) values.queue_tester = id .. "\t" .. (clock - 100) .. "\t200\tArtist\t" .. id .. "\t" end
  queue("id1")
  plugin = {
    define = function(info) assert(info.api_min == 17 and info.version == "1.1.0") end,
    has_capability = function(name) if name == "network.status" then return new_player end return true end,
    sd_root = function() return folder end,
    md5 = function(s) return s end,
    storage = {
      get = function(k, d) if values[k] ~= nil then return values[k] end return d end,
      set = function(k, v) values[k] = v return true end,
      delete = function(k) values[k] = nil end,
    },
    on = function(ev, fn) handlers[ev] = fn end,
    set_interval = function(_, fn) handlers.interval = fn end,
    is_playing = function() return false end,
    is_list_showing = function() return true end,
    show_toast = function() end,
    register_list_item = function(_, _, fn) handlers.open = fn end,
    show_list = function(_, items) list_items = items; return 1 end,
    http_request = function(opts, cb) requests[#requests + 1] = { opts = opts, cb = cb }; return #requests end,
  }
  if new_player then plugin.network_status = function() return net end end
  dofile(folder .. "/../plugins/LastFmScrobblerV2/LastFmScrobblerV2.lua")
  return queue
end
local function label(i) local it = list_items[i]; return type(it) == "table" and it.label or it end
local function find(pat)
  for i = 1, #list_items do if label(i):find(pat) then return label(i) end end
end
local function tick(seconds)
  clock = clock + (seconds or 5)
  requests = {}
  handlers.interval()
  return requests[1]
end

-- ===== New player =====
local queue = load_plugin(true)
assert(handlers.network_changed, "subscribed to network_changed")
-- The load-time attempt fails (connected): backoff starts at 15 s.
assert(#requests == 1)
requests[1].cb(0, nil, "timeout")

-- Wi-Fi switched off: no attempt even after the backoff has long expired.
net.connected, net.wifi_enabled = false, false
assert(tick(400) == nil, "no send attempt while Wi-Fi is off")
handlers.open()
assert(find("Wi%-Fi off"), "offline status row: " .. tostring(find("Status") or label(1)))
assert(find("waiting for Wi%-Fi"), "queue row while Wi-Fi off")

-- Turning it back on sends at once and records the time.
net.connected, net.wifi_enabled = true, true
requests = {}
handlers.network_changed({ connected = true, wifi_enabled = true })
assert(#requests == 1, "send on reconnect")
requests[1].cb(200, '<lfm status="ok"></lfm>')
assert(values.last_sent_at, "last_sent_at stored")

-- Backoff cap: connected but Last.fm unreachable, driven by interval ticks.
queue("id2")
local failures = 0
for _ = 1, 12 do
  local r = tick(2000)
  if r then r.cb(0, nil, "timeout"); failures = failures + 1 end
end
assert(failures >= 8, "retries kept happening: " .. failures)
handlers.open()
assert(find("1 play waiting"), tostring(find("waiting")))
assert(find("sent %d"), "last sent folded into queue row")
assert(find("Sync now"), "sync now row")
local m = tonumber(find("next try (%d+)m"):match("next try (%d+)m"))
assert(m <= 5, "backoff capped at 5 minutes, got " .. m)

-- Link drops right after a success (no failures so far): one failed send must
-- push the next try out to the 5 minute fallback, without growing the backoff.
net.connected = true
local r0 = tick(400)
r0.cb(200, '<lfm status="ok"></lfm>')
queue("id3")
net.connected = false
local r1 = tick(5)
assert(r1, "attempt is still made with Wi-Fi on and connected=false")
r1.cb(0, nil, "timeout")
for _ = 1, 10 do
  assert(tick(15) == nil, "no retry within the 5 minute fallback")
end
assert(tick(150) ~= nil, "retries after the fallback")
requests[1].cb(0, nil, "timeout")
assert(tick(100) == nil, "fallback again, not growth or a quick retry")
assert(tick(200) ~= nil, "retry exactly on the 5 minute cadence")
requests[1].cb(0, nil, "timeout")
handlers.open()
local m2 = tonumber(find("next try (%d+)m"):match("next try (%d+)m"))
assert(m2 == 5, "fallback stays at 5 minutes, got " .. m2)

-- A non-network backoff survives a reconnect.
net.connected = true
local r = tick(400)
r.cb(200, '<lfm status="failed"><error code="29">limit</error></lfm>')
requests = {}
handlers.network_changed({ connected = true, wifi_enabled = true })
assert(#requests == 0, "rate-limit backoff kept on reconnect")

-- ===== Old player: no network API and no capability =====
load_plugin(false)
assert(handlers.network_changed == nil, "no network_changed subscription")
assert(handlers.system_resumed, "resume fallback still registered")
requests[1].cb(0, nil, "timeout")
requests = {}
handlers.system_resumed()
assert(#requests == 1, "old player retries after resume")
handlers.open()
assert(find("1 play waiting"), "old player main screen renders")
print("ok")
