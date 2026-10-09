plugin.define({ id = "compas.listenbrainz_scrobbler", name = "ListenBrainz Scrobbler", version = "1.0", api_min = 15 })

-- ListenBrainz scrobbler. The user token lives only in plugin.secrets.
-- Playback state and the offline queue live in plugin.storage.
-- Listens follow ListenBrainz's rule: at least 30 seconds long, and played
-- for half the track or 4 minutes, whichever is less. Pauses and forward
-- seeks do not count. Unknown-duration streams (typical radio) are skipped.

local VALIDATE_URL = "https://api.listenbrainz.org/1/validate-token"
local SUBMIT_URL = "https://api.listenbrainz.org/1/submit-listens"
local CLIENT_NAME = "Compas"
local CLIENT_VERSION = "1.0"
local QUEUE_MAX_RECORDS = 40
local QUEUE_MAX_BYTES = 32768
local USER_AGENT = "Compas/1.0"
local REQUEST_TIMEOUTS = { connect_timeout_ms = 8000, read_timeout_ms = 12000, total_timeout_ms = 20000 }

local can_secrets = plugin.has_capability("storage.secrets") and plugin.has_capability("storage.secrets_get")
local can_http = plugin.has_capability("network.http.async")
local can_json = plugin.has_capability("data.json")

local state = {
  enabled = plugin.storage.get("enabled", "0") == "1",
  user_name = plugin.storage.get("user_name"),
}
if state.user_name == "" then state.user_name = nil end

local auth_hold = plugin.storage.get("auth_hold") == "1"
local account_generation = 1
local validation_generation = 0
local failures, next_sync_at = 0, 0
local inflight = nil
local current = nil
local queue_full_told = false
local queue_write_told = false
local missing_api_told = false

local function trim(value)
  return (tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function clip(value)
  local text = trim(value)
  if #text > 200 then text = text:sub(1, 200) end
  return text
end

local function url_encode(value)
  return (tostring(value):gsub("([^%w%-%.%_%~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end))
end

local function url_decode(value)
  return (value or ""):gsub("%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end)
end

local function current_token()
  if not can_secrets then return nil end
  local token = plugin.secrets.get("user_token")
  if type(token) ~= "string" or token == "" then return nil end
  return token
end

local function account_key(prefix, token)
  return prefix .. plugin.md5(token)
end

local function queue_key(token)
  return account_key("queue_", token)
end

local function sent_key(token)
  return account_key("sent_", token)
end

local function token_shape_ok(token)
  return type(token) == "string" and #token >= 10 and #token <= 200 and token:match("^[%w%-%.%_%~]+$") ~= nil
end

local function save_enabled()
  return plugin.storage.set("enabled", state.enabled and "1" or "0") == true
end

local function show_input(title, callback)
  local ok = plugin.show_text_input(title, nil, true, callback)
  if not ok then plugin.show_toast("Could not open text entry. Try again.") end
  return ok
end

local function encode_json(value)
  if not can_json then return nil, "json" end
  return plugin.json_encode(value)
end

local function decode_json(text)
  if not can_json or type(text) ~= "string" then return nil, "json" end
  return plugin.json_decode(text)
end

local function format_line(item)
  return table.concat({
    item.id,
    tostring(item.listened_at),
    tostring(item.duration_ms),
    item.hold == 1 and "1" or "0",
    url_encode(item.artist),
    url_encode(item.track),
    url_encode(item.release or ""),
  }, "\t")
end

local function parse_line(line)
  local id, timestamp, duration, hold, artist, track, release =
    line:match("^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t(.*)$")
  timestamp, duration = tonumber(timestamp), tonumber(duration)
  if not id or id == "" or not timestamp or timestamp <= 0 or not duration or duration <= 0 then
    return nil
  end
  artist, track, release = url_decode(artist), url_decode(track), url_decode(release)
  if artist == "" or track == "" then return nil end
  return {
    id = id,
    listened_at = timestamp,
    duration_ms = duration,
    hold = hold == "1" and 1 or 0,
    artist = artist,
    track = track,
    release = release,
  }
end

-- A line that does not parse is kept verbatim. Saving never drops those bytes.
local function load_queue(key)
  local raw = plugin.storage.get(key, "")
  if type(raw) ~= "string" or #raw > QUEUE_MAX_BYTES then return nil end
  local items, kept = {}, {}
  if raw == "" then return items, kept end
  for line in raw:gmatch("([^\n]+)") do
    local item = parse_line(line)
    if item then
      items[#items + 1] = item
      if #items > QUEUE_MAX_RECORDS then return nil end
    else
      kept[#kept + 1] = line
    end
  end
  return items, kept
end

local function save_queue(key, items, kept)
  if #items > QUEUE_MAX_RECORDS then return false end
  local lines = {}
  for i = 1, #kept do lines[#lines + 1] = kept[i] end
  for i = 1, #items do lines[#lines + 1] = format_line(items[i]) end
  local raw = table.concat(lines, "\n")
  if raw == "" then
    plugin.storage.delete(key)
    return true
  end
  if #raw > QUEUE_MAX_BYTES then return false end
  return plugin.storage.set(key, raw) == true
end

local function load_sent(token)
  local set = {}
  local raw = plugin.storage.get(sent_key(token), "")
  if type(raw) ~= "string" then return set end
  for line in raw:gmatch("([^\n]+)") do set[line] = true end
  return set
end

local function save_sent(token, set)
  local ids = {}
  for id in pairs(set) do ids[#ids + 1] = id end
  table.sort(ids)
  if #ids > QUEUE_MAX_RECORDS then
    local trimmed = {}
    for i = #ids - QUEUE_MAX_RECORDS + 1, #ids do trimmed[#trimmed + 1] = ids[i] end
    ids = trimmed
  end
  return plugin.storage.set(sent_key(token), table.concat(ids, "\n")) == true
end

local function request(method, url, token, body, callback)
  local headers = { ["User-Agent"] = USER_AGENT }
  if token then headers.Authorization = "Token " .. token end
  local options = {
    url = url,
    method = method,
    headers = headers,
    verify_tls = true,
    max_response_bytes = 16384,
    connect_timeout_ms = REQUEST_TIMEOUTS.connect_timeout_ms,
    read_timeout_ms = REQUEST_TIMEOUTS.read_timeout_ms,
    total_timeout_ms = REQUEST_TIMEOUTS.total_timeout_ms,
    redirect_limit = 0,
  }
  if body then
    options.body = body
    options.content_type = "application/json"
  end
  return plugin.http_request(options, callback)
end

local function hold_auth()
  if auth_hold then return end
  auth_hold = true
  plugin.storage.set("auth_hold", "1")
  plugin.show_toast("ListenBrainz did not accept the user token. Saved listens are kept.")
end

local function header_value(headers, name)
  if type(headers) ~= "table" then return nil end
  local want = name:lower()
  for key, value in pairs(headers) do
    if type(key) == "string" and key:lower() == want then return value end
  end
  return nil
end

-- Retry-After is honored only as a numeric delay. HTTP dates fall back to
-- the normal backoff. The wait stays inside 1..3600 seconds.
local function retry_after_seconds(headers)
  local raw = header_value(headers, "Retry-After")
  local seconds = nil
  if type(raw) == "number" then
    seconds = raw
  elseif type(raw) == "string" and raw:match("^%d+$") then
    seconds = tonumber(raw)
  end
  if not seconds then return nil end
  if seconds < 1 then seconds = 1 end
  if seconds > 3600 then seconds = 3600 end
  return seconds
end

local function sync_failed(retry_after)
  failures = failures + 1
  local delay = retry_after
  if not delay then
    delay = 15
    local step = 1
    while step < failures do
      delay = delay * 2
      if delay >= 1800 then delay = 1800 break end
      step = step + 1
    end
  end
  next_sync_at = os.time() + delay
end

local function tell_queue_full()
  if queue_full_told then return end
  queue_full_told = true
  plugin.show_toast("ListenBrainz queue is full. The oldest saved listens were kept.")
end

local function tell_queue_write()
  if queue_write_told then return end
  queue_write_told = true
  plugin.show_toast("Could not save that ListenBrainz listen. Saved listens were kept.")
end

local function payload_for(item, kind)
  local metadata = {
    artist_name = item.artist,
    track_name = item.track,
    additional_info = {
      duration_ms = item.duration_ms,
      submission_client = CLIENT_NAME,
      submission_client_version = CLIENT_VERSION,
    },
  }
  if item.release and item.release ~= "" then metadata.release_name = item.release end
  local entry = { track_metadata = metadata }
  if kind ~= "playing_now" then entry.listened_at = item.listened_at end
  return { listen_type = kind, payload = { entry } }
end

local function forget_queue(token)
  if not token or token == "" then return end
  plugin.storage.delete(queue_key(token))
  plugin.storage.delete(sent_key(token))
end

local function cancel_inflight()
  if inflight and inflight.handle then plugin.cancel(inflight.handle) end
  inflight = nil
end

-- Drop the previous account's queue before any later request can read it.
local function switch_account(new_token, user_name)
  local old = current_token()
  if old == new_token then
    auth_hold = false
    plugin.storage.delete("auth_hold")
    failures, next_sync_at = 0, 0
    if user_name and user_name ~= "" then
      state.user_name = user_name
      plugin.storage.set("user_name", user_name)
    end
    return true
  end
  if new_token then
    if not plugin.secrets.set("user_token", new_token) then
      plugin.show_toast("Could not save the ListenBrainz token. Try again.")
      return false
    end
  elseif can_secrets then
    if not plugin.secrets.delete("user_token") then
      plugin.show_toast("Could not log out of ListenBrainz. Try again.")
      return false
    end
  end
  validation_generation = validation_generation + 1
  account_generation = account_generation + 1
  cancel_inflight()
  if old and old ~= new_token then forget_queue(old) end
  auth_hold = false
  failures, next_sync_at = 0, 0
  plugin.storage.delete("auth_hold")
  if current then current.submitted = true end
  if user_name and user_name ~= "" then
    state.user_name = user_name
    plugin.storage.set("user_name", user_name)
  else
    state.user_name = nil
    plugin.storage.delete("user_name")
  end
  return true
end

local sync_queue

local function apply_submit_result(item_id, key, token_used, generation, status, err, headers)
  if inflight and inflight.id == item_id and inflight.generation == generation then
    inflight = nil
  end
  if generation ~= account_generation or current_token() ~= token_used then return end
  if status == 200 and not err then
    local sent = load_sent(token_used)
    sent[item_id] = true
    if not save_sent(token_used, sent) then
      sync_failed()
      return
    end
    local items, kept = load_queue(key)
    if not items then
      sync_failed()
      return
    end
    local remain = {}
    for i = 1, #items do
      if items[i].id ~= item_id then remain[#remain + 1] = items[i] end
    end
    if save_queue(key, remain, kept) then
      failures, next_sync_at = 0, 0
      sync_queue()
    else
      sync_failed()
    end
    return
  end
  if status == 401 and not err then
    hold_auth()
    return
  end
  if status == 429 and not err then
    sync_failed(retry_after_seconds(headers))
    return
  end
  if err or status == nil or status >= 500 then
    sync_failed()
    return
  end
  local items, kept = load_queue(key)
  if not items then return end
  for i = 1, #items do
    if items[i].id == item_id then items[i].hold = 1 end
  end
  save_queue(key, items, kept)
end

sync_queue = function()
  if inflight or auth_hold or os.time() < next_sync_at or not state.enabled then return end
  if not can_http or not can_json then
    if not missing_api_told then
      missing_api_told = true
      plugin.show_toast("This player cannot send ListenBrainz listens. Saved listens are kept.")
    end
    return
  end
  local token = current_token()
  if not token then return end
  local key = queue_key(token)
  local items, kept = load_queue(key)
  if not items then return end
  local sent = load_sent(token)
  local remain, changed = {}, false
  for i = 1, #items do
    if sent[items[i].id] then changed = true else remain[#remain + 1] = items[i] end
  end
  if changed then
    if not save_queue(key, remain, kept) then return end
    items = remain
  end
  local item = nil
  for i = 1, #items do
    if items[i].hold ~= 1 then item = items[i] break end
  end
  if not item then return end
  local body = encode_json(payload_for(item, "single"))
  if not body then
    sync_failed()
    return
  end
  local generation = account_generation
  local token_used = token
  local item_id = item.id
  inflight = { id = item_id, generation = generation, key = key }
  local handle = request("POST", SUBMIT_URL, token_used, body, function(status, _, err, headers)
    apply_submit_result(item_id, key, token_used, generation, status, err, headers)
  end)
  if inflight and inflight.id == item_id and inflight.generation == generation then
    inflight.handle = handle
  end
  if not handle and inflight and inflight.id == item_id and inflight.generation == generation then
    inflight = nil
    sync_failed()
  end
end

local function enqueue(record, token)
  if record.artist == "" or record.track == "" or not record.listened_at or record.listened_at <= 0 then
    return false
  end
  local key = queue_key(token)
  local items, kept = load_queue(key)
  if not items then return false end
  if record.id then
    for i = 1, #items do
      if items[i].id == record.id then return true end
    end
  else
    local sequence = (tonumber(plugin.storage.get("sequence", "0")) or 0) + 1
    if sequence > 1000000 then sequence = 1 end
    if not plugin.storage.set("sequence", tostring(sequence)) then
      tell_queue_write()
      return false
    end
    record.id = tostring(record.listened_at) .. "-" .. tostring(sequence)
  end
  if #items >= QUEUE_MAX_RECORDS then
    tell_queue_full()
    return false
  end
  items[#items + 1] = {
    id = record.id,
    listened_at = record.listened_at,
    duration_ms = record.duration_ms,
    hold = 0,
    artist = record.artist,
    track = record.track,
    release = record.release or "",
  }
  if not save_queue(key, items, kept) then
    tell_queue_write()
    return false
  end
  return true
end

local function threshold(duration)
  local half = duration / 2
  if half < 240 then return half end
  return 240
end

local function metadata_ok(artist, track)
  return artist ~= "" and track ~= ""
end

local function consider(snap)
  if not snap or snap.submitted or not state.enabled then return end
  if not metadata_ok(snap.artist, snap.track) or snap.duration < 30 then return end
  if snap.listened < threshold(snap.duration) then return end
  local token = current_token()
  if not token then return end
  local duration_ms = math.floor(snap.duration * 1000)
  if duration_ms <= 0 or duration_ms > 2073600000 then return end
  snap.record = snap.record or {
    listened_at = snap.started,
    artist = snap.artist,
    track = snap.track,
    release = snap.release,
    duration_ms = duration_ms,
  }
  if enqueue(snap.record, token) then
    snap.submitted = true
    if not auth_hold then sync_queue() end
  end
end

-- Credit the position change since the last sample, never more than the
-- seconds that actually passed, and never a backward or forward jump.
local function rebase(snap, count_previous)
  if not snap then return end
  local now = os.time()
  local pos = tonumber(plugin.get_position()) or 0
  if count_previous and state.enabled then
    local elapsed = now - (snap.last_poll or now)
    if elapsed > 0 and elapsed <= 30 then
      local delta = pos - (snap.last_pos or pos)
      if delta < 0 then delta = 0 end
      if delta > elapsed then delta = elapsed end
      snap.listened = snap.listened + delta
    end
  end
  snap.last_poll = now
  snap.last_pos = pos
end

local function send_playing_now(snap)
  if snap.now_sent or not state.enabled or auth_hold or not can_http or not can_json then return end
  if os.time() < next_sync_at then return end
  if not metadata_ok(snap.artist, snap.track) or snap.duration < 30 then return end
  local token = current_token()
  if not token then return end
  local duration_ms = math.floor(snap.duration * 1000)
  local body = encode_json(payload_for({
    artist = snap.artist,
    track = snap.track,
    release = snap.release,
    duration_ms = duration_ms,
  }, "playing_now"))
  if not body then return end
  snap.now_sent = true
  local generation = account_generation
  local token_used = token
  local handle = request("POST", SUBMIT_URL, token_used, body, function(status, _, err, headers)
    if generation ~= account_generation or current_token() ~= token_used then return end
    if status == 401 and not err then
      hold_auth()
    elseif status == 429 and not err then
      sync_failed(retry_after_seconds(headers))
    elseif err or status == nil or (status and status >= 500) then
      sync_failed()
    end
  end)
  if not handle then snap.now_sent = false end
end

local function refresh_duration(snap)
  if snap.duration >= 30 or snap.record then return end
  local duration = tonumber(plugin.get_duration()) or 0
  if duration >= 30 then snap.duration = duration end
end

plugin.on("track_started", function(title, artist, album, duration_seconds)
  if current then
    rebase(current, current.active)
    current.active = false
    consider(current)
  end
  current = {
    artist = clip(artist),
    track = clip(title),
    release = clip(album),
    duration = tonumber(duration_seconds) or 0,
    started = os.time(),
    listened = 0,
    active = plugin.is_playing() and not plugin.is_paused(),
    last_poll = os.time(),
    last_pos = tonumber(plugin.get_position()) or 0,
    submitted = false,
  }
  send_playing_now(current)
  sync_queue()
end)

local function finish_stretch()
  if not current then return end
  rebase(current, current.active)
  current.active = false
  consider(current)
end

plugin.on("paused", finish_stretch)
plugin.on("stopped", finish_stretch)
plugin.on("suspending", finish_stretch)

plugin.on("resumed", function()
  if not current then return end
  rebase(current, false)
  current.active = true
end)

plugin.on("system_resumed", function()
  if not current then return end
  rebase(current, false)
  current.active = plugin.is_playing() and not plugin.is_paused()
end)

plugin.set_interval(5, function()
  if current then
    -- `was_active` is the stretch since the previous sample. Pause, stop and
    -- a new track sample that stretch themselves and clear `active`, so a
    -- later poll does not add it again.
    local was_active = current.active
    current.active = plugin.is_playing() and not plugin.is_paused()
    rebase(current, was_active)
    refresh_duration(current)
    if current.duration >= 30 and not current.now_sent then send_playing_now(current) end
    consider(current)
  end
  sync_queue()
end)

local function validate_token(token)
  if not can_secrets then
    plugin.show_toast("This player cannot store a ListenBrainz token.")
    return
  end
  if not token_shape_ok(token) then
    plugin.show_toast("That token cannot be used.")
    return
  end
  if not can_http or not can_json then
    plugin.show_toast("This player cannot check a ListenBrainz token.")
    return
  end
  validation_generation = validation_generation + 1
  local validation_id = validation_generation
  local generation = account_generation
  plugin.show_toast("Checking ListenBrainz token...")
  local handle = request("GET", VALIDATE_URL, token, nil, function(status, body, err)
    if validation_id ~= validation_generation or generation ~= account_generation then return end
    if err or status ~= 200 or type(body) ~= "string" then
      plugin.show_toast("Could not reach ListenBrainz.")
      return
    end
    local data = decode_json(body)
    -- Invalid tokens are often HTTP 200 with valid=false.
    if type(data) ~= "table" or data.valid ~= true then
      plugin.show_toast("ListenBrainz did not accept that token.")
      return
    end
    local user_name = nil
    if type(data.user_name) == "string" then
      user_name = clip(data.user_name)
      if user_name == token or user_name:find("%c") then user_name = nil end
    end
    if switch_account(token, user_name) then
      plugin.show_toast("ListenBrainz token saved.")
      sync_queue()
    end
  end)
  if not handle then plugin.show_toast("Could not reach ListenBrainz.") end
end

local function open_menu()
  local rows = {
    {
      type = "row",
      label = "Set ListenBrainz user token",
      on_select = function()
        show_input("ListenBrainz user token", function(value)
          if value == nil or trim(value) == "" then return end
          validate_token(trim(value))
        end)
      end,
    },
    {
      type = "toggle",
      label = "Enabled",
      value = state.enabled,
      on_change = function(value)
        if value then
          state.enabled = true
          if not save_enabled() then
            state.enabled = false
            plugin.show_toast("Could not save that setting. Try again.")
            return
          end
          if current then
            rebase(current, false)
            current.active = plugin.is_playing() and not plugin.is_paused()
          end
          failures, next_sync_at = 0, 0
          sync_queue()
        else
          if current then
            rebase(current, current.active)
            consider(current)
            current.submitted = true
            current.active = false
          end
          state.enabled = false
          if not save_enabled() then
            plugin.show_toast("Could not save that setting. Try again.")
          end
        end
      end,
    },
  }
  if current_token() then
    local label = "Log out"
    if state.user_name and state.user_name ~= "" then
      label = "Log out (" .. state.user_name .. ")"
    end
    rows[#rows + 1] = {
      type = "row",
      label = label,
      on_select = function()
        if switch_account(nil, nil) then
          plugin.show_toast("Logged out of ListenBrainz.")
        end
      end,
    }
  end
  plugin.show_settings_list("ListenBrainz Scrobbler", rows)
end

plugin.register_list_item("playback", "ListenBrainz Scrobbler", open_menu)

if not auth_hold then sync_queue() end

if rawget(_G, "COMPAS_PLUGIN_TEST") then
  _G.COMPAS_PLUGIN_UNDER_TEST = {
    open_menu = open_menu,
    listened = function() return current and current.listened or 0 end,
    submitted = function() return current and current.submitted == true end,
    generation = function() return account_generation end,
  }
end
