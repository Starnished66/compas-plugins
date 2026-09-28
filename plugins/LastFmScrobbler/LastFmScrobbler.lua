plugin.define({ id = "example.lastfm_scrobbler", name = "Last.fm Scrobbler", version = "1.6", api_min = 2 })

-- Last.fm scrobbler with a bounded, account-specific offline queue.

local API_URL = "https://ws.audioscrobbler.com/2.0/"
local LEGACY_STATE_PATH = plugin.sd_root() .. "/.plugins/.lastfm_scrobbler_state"
local LEGACY_QUEUE_PATH = plugin.sd_root() .. "/.plugins/.lastfm_scrobbler_queue"
local QUEUE_MAX_RECORDS = 100
local QUEUE_MAX_BYTES = 65536
local QUEUE_MAX_AGE = 13 * 24 * 60 * 60
local REQUEST_TIMEOUTS = { connect_timeout_ms = 8000, read_timeout_ms = 12000, total_timeout_ms = 20000 }
-- Queue sync backoff (see sync_failed()).
local sync_failures, next_sync_at = 0, 0

local API_KEY = plugin.storage.get("api_key", "")
local API_SECRET = plugin.storage.get("api_secret", "")
local state = {
  enabled = plugin.storage.get("enabled", "0") == "1",
  session_key = plugin.storage.get("session_key"),
  username = plugin.storage.get("username"),
}
local legacy_account_username = nil

-- Move the old removable-card session into this plugin's protected storage.
-- A receipt in storage marks the move done, so an old file that cannot be
-- deleted is never read again.
local function remove_legacy_file(path)
  if os.remove(path) then return end
  local f = io.open(path, "r")
  if f then
    f:close()
    plugin.show_toast("Could not remove an old Last.fm file from the SD card")
  end
end
local legacy_state_done = plugin.storage.get("legacy_state_done") == "1"
if legacy_state_done then
  remove_legacy_file(LEGACY_STATE_PATH)
elseif not state.session_key then
  local f = io.open(LEGACY_STATE_PATH, "r")
  if f then
    local enabled_line = f:read("*l")
    local session_line = f:read("*l")
    local username_line = f:read("*l")
    f:close()
    if session_line and session_line ~= "" and plugin.storage.set("session_key", session_line) then
      state.session_key = session_line
      state.username = username_line
      legacy_account_username = username_line
      plugin.storage.set("username", username_line or "")
      plugin.storage.set("enabled", enabled_line == "1" and "1" or "0")
      state.enabled = enabled_line == "1"
      -- The old queue is imported later; remember whose it is first.
      if plugin.storage.set("legacy_queue_account", username_line or "")
          and plugin.storage.set("legacy_state_done", "1") then
        remove_legacy_file(LEGACY_STATE_PATH)
      end
    end
  end
else
  local legacy = io.open(LEGACY_STATE_PATH, "r")
  if legacy then
    legacy:read("*l")
    legacy:read("*l")
    legacy_account_username = legacy:read("*l")
    legacy:close()
    if plugin.storage.set("legacy_queue_account", legacy_account_username or "")
        and plugin.storage.set("legacy_state_done", "1") then
      remove_legacy_file(LEGACY_STATE_PATH)
    end
  end
end

local function save_state()
  plugin.storage.set("enabled", state.enabled and "1" or "0")
  if state.session_key then
    plugin.storage.set("session_key", state.session_key)
    plugin.storage.set("username", state.username or "")
  else
    plugin.storage.delete("session_key")
    plugin.storage.delete("username")
  end
end

local function url_encode(value)
  return (tostring(value):gsub("([^%w%-%.%_%~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end))
end

local function build_query(params)
  local parts = {}
  for k, v in pairs(params) do
    if v ~= nil then table.insert(parts, url_encode(k) .. "=" .. url_encode(v)) end
  end
  return table.concat(parts, "&")
end

local function sign(params)
  local keys = {}
  for k in pairs(params) do table.insert(keys, k) end
  table.sort(keys)
  local concat = ""
  for _, k in ipairs(keys) do concat = concat .. k .. tostring(params[k]) end
  return plugin.md5(concat .. API_SECRET)
end

local function api_call(params, callback)
  params.api_key = API_KEY
  params.api_sig = sign(params)
  local options = {
    url = API_URL,
    method = "POST",
    body = build_query(params),
    content_type = "application/x-www-form-urlencoded",
    verify_tls = true,
    max_response_bytes = 262144,
    connect_timeout_ms = REQUEST_TIMEOUTS.connect_timeout_ms,
    read_timeout_ms = REQUEST_TIMEOUTS.read_timeout_ms,
    total_timeout_ms = REQUEST_TIMEOUTS.total_timeout_ms,
  }
  return plugin.http_request(options, callback)
end

local active_requests = {}
local active_request_tokens = {}
local account_generation = 0
local queue_sync_token = nil
local function cancel_request(kind)
  local handle = active_requests[kind]
  if handle then plugin.cancel(handle); active_requests[kind] = nil end
  active_request_tokens[kind] = nil
end
local function tracked_api_call(kind, params, callback)
  cancel_request(kind)
  local token = {}
  active_request_tokens[kind] = token
  local handle = api_call(params, function(...)
    if active_request_tokens[kind] ~= token then return end
    active_request_tokens[kind] = nil
    active_requests[kind] = nil
    callback(...)
  end)
  if handle and active_request_tokens[kind] == token then
    active_requests[kind] = handle
  elseif not handle and active_request_tokens[kind] == token then
    active_request_tokens[kind] = nil
  end
  return handle
end
local function cancel_account_requests()
  account_generation = account_generation + 1
  for kind in pairs(active_requests) do cancel_request(kind) end
  queue_sync_token = nil
end

local function show_input(title, initial, secret, callback)
  local ok = plugin.show_text_input(title, initial, secret, callback)
  if not ok then plugin.show_toast("Could not open text entry. Try again.") end
  return ok
end

local function do_login(username, password)
  local generation = account_generation
  plugin.show_toast("Logging in to Last.fm...")
  local handle = tracked_api_call("login", { method = "auth.getMobileSession", username = username, password = password },
    function(status, body, request_error)
      if generation ~= account_generation then return end
      if not request_error and status == 200 and body and body:match('status="ok"') then
        local key = body:match("<key>([^<]+)</key>")
        if key and plugin.storage.set("session_key", key) then
          state.session_key, state.username = key, username
          save_state()
          sync_failures, next_sync_at = 0, 0
          plugin.show_toast("Logged in to Last.fm")
          return
        end
      end
      plugin.show_toast("Could not log in to Last.fm. Check your details and try again.")
    end)
  if not handle then plugin.show_toast("Could not start Last.fm login. Try again.") end
end

local function start_login()
  if API_KEY == "" or API_SECRET == "" then
    plugin.show_toast("Add your Last.fm API credentials in settings first.")
    return
  end
  show_input("Last.fm Username", state.username, false, function(username)
    if not username or username == "" then return end
    show_input("Last.fm Password", nil, true, function(password)
      if password and password ~= "" then do_login(username, password) end
    end)
  end)
end

-- Queue data is one bounded storage value per account. Replacing one value is
-- atomic in plugin.storage, so a failed update always leaves the prior queue.
local function queue_key(username)
  return "queue_" .. plugin.md5((username or ""):lower())
end

local function queue_encode(value)
  return url_encode(value or "")
end

local function queue_decode(value)
  return (value or ""):gsub("%%(%x%x)", function(hex) return string.char(tonumber(hex, 16)) end)
end

local function parse_queue_line(line)
  local id, timestamp, duration, artist, title, album = line:match("^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t(.*)$")
  if not id then return nil end
  timestamp, duration = tonumber(timestamp), tonumber(duration)
  if not timestamp or timestamp <= 0 then return nil end
  return { id = id, timestamp = timestamp, duration = duration or 0,
    artist = queue_decode(artist), title = queue_decode(title), album = queue_decode(album) }
end

local function queue_line(item)
  return table.concat({ item.id, tostring(item.timestamp), tostring(item.duration),
    queue_encode(item.artist), queue_encode(item.title), queue_encode(item.album) }, "\t")
end

-- Returns the queue and whether expired or unreadable records were left out,
-- so callers only write it back when something actually changed.
local function load_queue(key)
  local raw = plugin.storage.get(key, "")
  if #raw > QUEUE_MAX_BYTES then return nil end
  local items, dropped = {}, false
  for line in raw:gmatch("([^\n]+)") do
    local item = parse_queue_line(line)
    if item and item.timestamp >= os.time() - QUEUE_MAX_AGE then
      items[#items + 1] = item
      if #items > QUEUE_MAX_RECORDS then return nil end
    else
      dropped = true
    end
  end
  return items, dropped
end

local function save_queue(key, items)
  local lines = {}
  for i = 1, #items do lines[i] = queue_line(items[i]) end
  local raw = table.concat(lines, "\n")
  if #items > QUEUE_MAX_RECORDS or #raw > QUEUE_MAX_BYTES then return false end
  return plugin.storage.set(key, raw)
end

-- Import the old SD-card queue into the account its saved state named. The
-- account is kept in storage until the import succeeds, so a failed write is
-- retried on the next start. The old queue is oldest first, so its last
-- LEGACY_QUEUE_READ_BYTES hold the newest plays; the newest ones that fit the
-- bounded queue are kept, older or expired ones are left out.
local LEGACY_QUEUE_READ_BYTES = 262144
local function migrate_legacy_queue()
  if plugin.storage.get("legacy_queue_done") == "1" then
    -- A finished import must not leave syncing blocked by its marker.
    plugin.storage.delete("legacy_queue_account")
    remove_legacy_file(LEGACY_QUEUE_PATH)
    return
  end
  local account = legacy_account_username or plugin.storage.get("legacy_queue_account")
  local f = io.open(LEGACY_QUEUE_PATH, "r")
  if not f then
    if account then plugin.storage.delete("legacy_queue_account") end
    return
  end
  if not account or account == "" then f:close(); return end
  local size = f:seek("end") or 0
  local start = math.max(0, size - LEGACY_QUEUE_READ_BYTES)
  f:seek("set", start)
  local body = f:read(LEGACY_QUEUE_READ_BYTES) or ""
  f:close()
  if start > 0 then
    body = body:match("^[^\n]*\n(.*)$") or "" -- drop the partial first record
  end

  local key = queue_key(account)
  local items = load_queue(key)
  if not items then return end
  local legacy = {}
  for line in body:gmatch("([^\n]+)") do
    local timestamp, duration, artist, title, album = line:match("^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t(.*)$")
    timestamp, duration = tonumber(timestamp), tonumber(duration)
    if timestamp and timestamp >= os.time() - QUEUE_MAX_AGE and artist and title and album then
      legacy[#legacy + 1] = {
        -- Stable identity, so a retried import skips plays already written.
        id = "legacy-" .. tostring(timestamp) .. "-" .. plugin.md5(artist .. "\t" .. title),
        timestamp = timestamp,
        duration = duration or 0,
        artist = queue_decode(artist),
        title = queue_decode(title),
        album = queue_decode(album),
      }
    end
  end
  -- Take the newest legacy plays that fit both queue bounds, measured
  -- before saving so a storage failure is never mistaken for "too big".
  local bytes = 0
  local present = {}
  for _, item in ipairs(items) do
    bytes = bytes + #queue_line(item) + 1
    present[item.id] = true
  end
  local take = {}
  for i = #legacy, 1, -1 do
    if present[legacy[i].id] then goto continue end
    local line_bytes = #queue_line(legacy[i]) + 1
    if #items + #take >= QUEUE_MAX_RECORDS or bytes + line_bytes > QUEUE_MAX_BYTES then break end
    bytes = bytes + line_bytes
    table.insert(take, 1, legacy[i])
    ::continue::
  end
  for _, item in ipairs(take) do items[#items + 1] = item end
  if save_queue(key, items) and plugin.storage.set("legacy_queue_done", "1") then
    plugin.storage.delete("legacy_queue_account")
    remove_legacy_file(LEGACY_QUEUE_PATH)
  end
end

migrate_legacy_queue()

-- Ids Last.fm accepted this session: a retry after a save that stored the
-- play but reported failure must not queue it again once it was sent.
local sent_ids = {}

local function enqueue_scrobble(item, username)
  if not item.timestamp or item.timestamp <= 0 or item.artist == "" or item.title == "" then return false end
  local key = queue_key(username)
  local items = load_queue(key)
  if not items then return false end
  -- One identity per play, kept across retries: a write that stored the
  -- queue but reported failure must not add the same play again.
  if item.id and sent_ids[item.id] then return true end
  if item.id then
    for _, queued in ipairs(items) do
      if queued.id == item.id then return true end
    end
  end
  if #items >= QUEUE_MAX_RECORDS then return false end
  if not item.id then
    local sequence_key = key .. "_sequence"
    local sequence = (tonumber(plugin.storage.get(sequence_key, "0")) or 0) + 1
    if not plugin.storage.set(sequence_key, tostring(sequence)) then return false end
    item.id = tostring(item.timestamp) .. "-" .. tostring(sequence)
  end
  items[#items + 1] = item
  return save_queue(key, items)
end

-- Offline or failing: wait longer between attempts (up to 30 minutes)
-- instead of retrying every tick.
local function sync_failed()
  sync_failures = sync_failures + 1
  next_sync_at = os.time() + math.min(15 * 2 ^ (sync_failures - 1), 1800)
end

local function remove_queued(key, id)
  local latest = load_queue(key)
  if not latest then return false end
  for i, queued in ipairs(latest) do
    if queued.id == id then
      table.remove(latest, i)
      return save_queue(key, latest)
    end
  end
  return true
end

-- Last.fm error codes 11, 16 and 29 are temporary (service offline,
-- temporarily unavailable, rate limited); 9 is an expired session; 10, 13
-- and 26 mean the API key or secret is wrong or suspended: the queue is
-- kept and syncing waits until the credentials are changed.
local TEMPORARY_ERRORS = { ["11"] = true, ["16"] = true, ["29"] = true }
local CREDENTIAL_ERRORS = { ["10"] = true, ["13"] = true, ["26"] = true }
local credentials_rejected = false
-- Bumped when a credential is saved: a key or signature error for a request
-- sent before the change says nothing about the new credentials.
local credential_generation = 0

local sync_queue
sync_queue = function()
  if queue_sync_token or os.time() < next_sync_at or credentials_rejected
      or API_KEY == "" or API_SECRET == ""
      or not (state.enabled and state.session_key and state.username) then return end
  -- Until an old-version queue import is committed, a sent play could be
  -- imported again from the old file; wait for the import first.
  local pending_import = plugin.storage.get("legacy_queue_account")
  if pending_import and pending_import:lower() == state.username:lower()
      and plugin.storage.get("legacy_queue_done") ~= "1" then return end
  local key = queue_key(state.username)
  local items, dropped = load_queue(key)
  if not items then return end
  if dropped and not save_queue(key, items) then return end
  -- Plays Last.fm already accepted whose removal did not stick are removed
  -- again, never uploaded twice.
  while items[1] and sent_ids[items[1].id] do
    if not remove_queued(key, items[1].id) then
      sync_failed()
      return
    end
    table.remove(items, 1)
  end
  local item = items[1]
  if not item then return end

  local token = {}
  queue_sync_token = token
  local generation = account_generation
  local sent_with_credentials = credential_generation
  local handle = api_call({ method = "track.scrobble", sk = state.session_key, track = item.title,
    artist = item.artist, album = item.album ~= "" and item.album or nil,
    timestamp = tostring(item.timestamp), duration = tostring(math.floor(item.duration)) },
    function(status, body, request_error)
      if queue_sync_token == token then
        queue_sync_token = nil
        active_requests.queue = nil
      end
      if generation ~= account_generation then return end
      if request_error or not body then
        sync_failed()
        return
      end
      if status == 200 and body:match('status="ok"') then
        sync_failures, next_sync_at = 0, 0
        sent_ids[item.id] = true
        if remove_queued(key, item.id) then
          sync_queue()
        else
          sync_failed()
        end
        return
      end
      local code = body:match('<error code="(%d+)"')
      if code and CREDENTIAL_ERRORS[code] then
        if sent_with_credentials == credential_generation then
          credentials_rejected = true
          plugin.show_toast("Last.fm did not accept your API key or secret. Check them in settings.")
        end
      elseif code == "9" then
        cancel_account_requests()
        state.session_key, state.username = nil, nil
        save_state()
        plugin.show_toast("Last.fm login expired. Log in again to keep scrobbling.")
      elseif code and not TEMPORARY_ERRORS[code] then
        -- Rejected for good (bad track data); keep the rest of the queue
        -- moving, and never send it again even if the removal fails.
        sent_ids[item.id] = true
        if not remove_queued(key, item.id) then sync_failed() end
      else
        sync_failed()
      end
    end)
  if handle then
    if queue_sync_token == token then active_requests.queue = handle end
  else
    if queue_sync_token == token then queue_sync_token = nil end
    sync_failed()
  end
end

local current_title, current_artist, current_album, current_duration = nil, nil, nil, 0
local track_start_time = 0
-- Listening time is wall-clock time spent playing (Last.fm's definition):
-- paused, resumed and stopped close and open the current stretch, so
-- neither pauses nor seeking add time.
local listened_seconds = 0
local playing_since = nil

local function listened_now()
  local open = playing_since and math.max(0, os.time() - playing_since) or 0
  return listened_seconds + open
end

local function close_stretch()
  listened_seconds = listened_now()
  playing_since = nil
end
local scrobbled_this_track = false
local current_record = nil
local current_account = nil

-- Last.fm's rule: the track is longer than 30 seconds and was played for
-- half its length or 4 minutes, whichever comes first.
local function save_current_play()
  if scrobbled_this_track or not state.enabled or not current_account or not current_title or not current_artist
      or current_duration < 30 or listened_now() < math.min(current_duration / 2, 240) then return end
  -- Kept after a failed save, so the retry reuses the same record and id.
  current_record = current_record or { timestamp = track_start_time, artist = current_artist,
    title = current_title, album = current_album or "", duration = current_duration }
  if enqueue_scrobble(current_record, current_account) then
    scrobbled_this_track = true
    sync_queue()
  end
end

local function update_now_playing()
  if not (state.enabled and state.session_key and current_title and current_artist) then return end
  local generation = account_generation
  tracked_api_call("now_playing", { method = "track.updateNowPlaying", sk = state.session_key,
    track = current_title, artist = current_artist, album = current_album ~= "" and current_album or nil,
    duration = tostring(math.floor(current_duration)) }, function()
      if generation ~= account_generation then return end
    end)
end

plugin.on("track_started", function(title, artist, album, duration_seconds)
  close_stretch()
  save_current_play()
  current_title, current_artist, current_album, current_duration = title, artist, album, duration_seconds or 0
  current_account = state.session_key and state.username or nil
  track_start_time = os.time()
  listened_seconds = 0
  playing_since = plugin.is_playing() and os.time() or nil
  scrobbled_this_track, current_record = false, nil
  update_now_playing()
  sync_queue()
end)

plugin.set_interval(5, function()
  -- Events do not cover every change: a natural end sends no "stopped", and
  -- a track can report started just before audio begins. Reconcile with the
  -- real state every tick (at most one tick of error), enabled or not.
  if plugin.is_playing() then
    if not playing_since then playing_since = os.time() end
  elseif playing_since then
    close_stretch()
  end
  if not state.enabled then return end
  sync_queue()
  if not current_title or not current_artist or scrobbled_this_track then return end
  if current_duration <= 0 then
    current_duration = plugin.get_duration() or 0
  end
  if current_duration < 30 then return end
  if listened_now() >= math.min(current_duration / 2, 240) then save_current_play() end
end)

plugin.on("paused", close_stretch)
plugin.on("stopped", close_stretch)
plugin.on("resumed", function()
  if not playing_since then playing_since = os.time() end
end)

local function save_credential(storage_key, title, current, secret)
  show_input(title, current ~= "" and current or nil, secret, function(value)
    if value == nil or value == "" then return end
    if plugin.storage.set(storage_key, value) then
      if storage_key == "api_key" then API_KEY = value else API_SECRET = value end
      credentials_rejected = false
      credential_generation = credential_generation + 1
      sync_failures, next_sync_at = 0, 0
      plugin.show_toast("Credential saved")
    else
      plugin.show_toast("Could not save that credential. Try again.")
    end
  end)
end

local function open_menu()
  local rows = {
    { type = "row", label = "Set Last.fm API key", on_select = function() save_credential("api_key", "Last.fm API key", API_KEY, false) end },
    { type = "row", label = "Set Last.fm API secret", on_select = function() save_credential("api_secret", "Last.fm API secret", API_SECRET, true) end },
    { type = "toggle", label = "Enabled", value = state.enabled, on_change = function(value)
      state.enabled = value
      save_state()
      if not value then
        -- The track playing now was not fully heard while enabled.
        close_stretch()
        scrobbled_this_track = true
      end
      if value then
        sync_failures, next_sync_at = 0, 0
        sync_queue()
      end
    end },
  }

  if state.session_key then
    table.insert(rows, { type = "row", label = "Log Out", on_select = function()
      cancel_account_requests()
      state.session_key, state.username = nil, nil
      save_state()
    end })
  else
    table.insert(rows, { type = "row", label = "Log In", on_select = start_login })
  end
  plugin.show_settings_list("Last.fm Scrobbler", rows)
end

plugin.register_list_item("playback", "Last.fm Scrobbler", open_menu)
