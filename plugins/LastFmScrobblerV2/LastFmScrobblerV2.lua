plugin.define({ id = "compas.lastfm_scrobbler_v2", name = "LastFM Scrobbler V2", version = "1.1.0", api_min = 17 })

-- Last.fm scrobbler with guided setup, queue inspection, and bounded offline queue.

local API_URL = "https://ws.audioscrobbler.com/2.0/"
local GATEWAY_URL = "https://lastfm.compasplayer.org"
local LEGACY_STATE_PATH = plugin.sd_root() .. "/.plugins/.lastfm_scrobbler_v2_state"
local LEGACY_QUEUE_PATH = plugin.sd_root() .. "/.plugins/.lastfm_scrobbler_v2_queue"
local QUEUE_MAX_RECORDS = 100
local QUEUE_MAX_BYTES = 65536
local QUEUE_MAX_AGE = 13 * 24 * 60 * 60
local REQUEST_TIMEOUTS = { connect_timeout_ms = 8000, read_timeout_ms = 12000, total_timeout_ms = 20000 }
local TEMPORARY_ERRORS = { ["11"] = true, ["16"] = true, ["29"] = true }
local CREDENTIAL_ERRORS = { ["10"] = true, ["13"] = true, ["26"] = true }

-- Queue sync backoff and status tracking
local sync_failures, next_sync_at = 0, 0
local credentials_rejected = false
local credential_generation = 0
local persistent_error = nil
local login_in_flight = false
local login_progress_handle = nil
local session_expired = false
local next_expiry_clear_at = 0

local function same_account(a, b)
  return type(a) == "string" and type(b) == "string" and a:lower() == b:lower()
end

local function has_secrets()
  return type(plugin.secrets) == "table" and type(plugin.secrets.get) == "function"
    and type(plugin.secrets.set) == "function"
end

local function get_secret(key)
  if has_secrets() then
    local val = plugin.secrets.get(key)
    if val and val ~= "" then return val end
  end
  return plugin.storage.get(key, "")
end

local function set_secret(key, value)
  if has_secrets() then
    local ok = plugin.secrets.set(key, value)
    if ok then
      plugin.storage.delete(key)
      return true
    end
    return false
  end
  return plugin.storage.set(key, value)
end

local function delete_secret(key)
  if has_secrets() then
    pcall(function() plugin.secrets.delete(key) end)
  end
  plugin.storage.delete(key)
end

-- Move stored secret and session into plugin.secrets if available.
-- If migration write fails, retain in storage as fallback.
if has_secrets() then
  local stored_secret = plugin.storage.get("api_secret")
  if stored_secret and stored_secret ~= "" then
    local sec = plugin.secrets.get("api_secret")
    if not sec or sec == "" then
      if plugin.secrets.set("api_secret", stored_secret) then
        plugin.storage.delete("api_secret")
      end
    else
      plugin.storage.delete("api_secret")
    end
  end

  local stored_session = plugin.storage.get("session_key")
  if stored_session and stored_session ~= "" then
    local sess = plugin.secrets.get("session_key")
    if not sess or sess == "" then
      if plugin.secrets.set("session_key", stored_session) then
        plugin.storage.delete("session_key")
      end
    else
      plugin.storage.delete("session_key")
    end
  end
end

local API_KEY = plugin.storage.get("api_key", "")
local API_SECRET = get_secret("api_secret")
local state = {
  enabled = plugin.storage.get("enabled", "0") == "1",
  session_key = get_secret("session_key"),
  username = plugin.storage.get("username"),
}
if state.session_key == "" then state.session_key = nil end
if state.username == "" then state.username = nil end

-- Commit username and session together. A signed-out record takes precedence
-- over legacy copies even if their deletion fails; they cannot revive a login.
local auth_record = get_secret("auth_record")
local auth_record_exists = auth_record ~= ""
if has_secrets() and type(plugin.secrets.exists) == "function" then
  auth_record_exists = auth_record_exists or plugin.secrets.exists("auth_record")
end
local last_username = state.username
if auth_record_exists then
  state.session_key, state.username = nil, nil
  local name, key = auth_record:match("^1\n([^\n]+)\n([^\n]+)$")
  if name and key and #name <= 255 and #key <= 256
      and not name:find("%c") and not key:find("%c") then
    state.username, state.session_key, last_username = name, key, name
  else
    local previous = auth_record:match("^0\n([^\n]*)$")
    if previous and #previous <= 255 and not previous:find("%c") then
      last_username = previous ~= "" and previous or nil
    else
      persistent_error = "Saved account could not be read. Sign in again."
    end
  end
end
local legacy_account_username = nil

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
elseif not state.session_key and not auth_record_exists then
  local f = io.open(LEGACY_STATE_PATH, "r")
  if f then
    local enabled_line = f:read("*l")
    local session_line = f:read("*l")
    local username_line = f:read("*l")
    f:close()
    if session_line and session_line ~= "" and set_secret("session_key", session_line) then
      state.session_key = session_line
      state.username = username_line
      legacy_account_username = username_line
      plugin.storage.set("username", username_line or "")
      plugin.storage.set("enabled", enabled_line == "1" and "1" or "0")
      state.enabled = enabled_line == "1"
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

local had_account = auth_record_exists or state.session_key ~= nil
local enable_pending = false
last_username = state.username or last_username

local function session_record(key, username)
  if type(key) ~= "string" or type(username) ~= "string" or key == "" or username == ""
      or #key > 256 or #username > 255 or key:find("%c") or username:find("%c") then return nil end
  return "1\n" .. username .. "\n" .. key
end

-- Older values remain usable if the atomic migration cannot be saved.
if not auth_record_exists and state.session_key and state.username then
  local record = session_record(state.session_key, state.username)
  if record and set_secret("auth_record", record) then
    auth_record_exists = true
    delete_secret("session_key")
    plugin.storage.delete("username")
  end
end

local function is_gateway_token(token)
  return type(token) == "string" and token:sub(1, 4) == "cg1_"
end

local function get_gateway_url()
  if not GATEWAY_URL:match("^https://[^/]+") or GATEWAY_URL:find("[%s%c?#@]") then return nil end
  local base = GATEWAY_URL:gsub("/+$", "")
  if base:match("/v1/lastfm$") then
    return base
  end
  return base .. "/v1/lastfm"
end

local function uses_gateway()
  if state.session_key and is_gateway_token(state.session_key) then
    return true
  end
  if state.session_key then
    return false
  end
  if API_KEY ~= "" or API_SECRET ~= "" then
    return false
  end
  return GATEWAY_URL ~= ""
end

local function service_ready()
  if uses_gateway() then
    return get_gateway_url() ~= nil
  else
    return API_KEY ~= "" and API_SECRET ~= ""
  end
end


if is_gateway_token(state.session_key) and not get_gateway_url() and not persistent_error then
  persistent_error = "Last.fm service not configured."
end

local function save_enabled()
  return plugin.storage.set("enabled", state.enabled and "1" or "0")
end

local function save_session(session_key, username)
  local record = session_record(session_key, username)
  if not record or not set_secret("auth_record", record) then return false end
  state.session_key, state.username, last_username = session_key, username, username
  session_expired = false
  auth_record_exists = true
  delete_secret("session_key")
  plugin.storage.delete("username")
  return true
end

local function clear_session()
  local name = state.username or last_username or ""
  if #name > 255 or name:find("%c") then name = "" end
  if not set_secret("auth_record", "0\n" .. name) then return false end
  auth_record_exists = true
  last_username = name ~= "" and name or nil
  state.session_key, state.username = nil, nil
  session_expired = false
  delete_secret("session_key")
  plugin.storage.delete("username")
  return true
end

local function invalidate_session()
  session_expired = true
  next_expiry_clear_at = os.time() + 30
  if clear_session() then
    persistent_error = "Session expired. Sign in again."
  else
    -- Keep the same stored/in-memory pair, but never use a revoked token.
    persistent_error = "Session expired; sign-out could not be saved. Sign in again."
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
  return plugin.md5(concat .. (API_SECRET or ""))
end

local function api_call(params, callback)
  local use_gw = false
  if params and params.sk then
    use_gw = is_gateway_token(params.sk)
  else
    use_gw = uses_gateway()
  end

  local url
  local req_params = {}
  if params then
    for k, v in pairs(params) do req_params[k] = v end
  end

  if use_gw then
    url = get_gateway_url()
    if not url then return nil end
    req_params.api_key = nil
    req_params.api_sig = nil
  else
    url = API_URL
    req_params.api_key = API_KEY
    req_params.api_sig = sign(req_params)
  end

  local options = {
    url = url,
    method = "POST",
    headers = { ["User-Agent"] = "Compas-LastFmScrobbler/1.7" },
    body = build_query(req_params),
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
  if handle then
    plugin.cancel(handle)
    active_requests[kind] = nil
  end
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
  login_in_flight = false
  if login_progress_handle and plugin.close_progress then
    plugin.close_progress(login_progress_handle)
    login_progress_handle = nil
  end
end

local function trim(str)
  return str and str:match("^%s*(.-)%s*$") or ""
end

local function truncate(str, max_len)
  str = tostring(str or "")
  str = str:gsub("%c", " ")
  if #str <= max_len then return str end
  local cut = max_len - 1
  while cut > 0 do
    local next_byte = str:byte(cut + 1)
    if not next_byte or next_byte < 128 or next_byte > 191 then break end
    cut = cut - 1
  end
  return str:sub(1, cut) .. "…"
end

local function format_time(seconds)
  seconds = math.max(0, math.floor(seconds or 0))
  local m = math.floor(seconds / 60)
  local s = seconds % 60
  return string.format("%d:%02d", m, s)
end

local function show_input(title, initial, secret, callback)
  local ok = plugin.show_text_input(title, initial, secret, callback)
  if not ok then plugin.show_toast("Could not open text entry. Try again.") end
  return ok
end

-- Queue data is one bounded storage value per account.
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

local function get_queued_count(username)
  if not username or username == "" then return 0 end
  local items = load_queue(queue_key(username))
  return items and #items or nil
end

local LEGACY_QUEUE_READ_BYTES = 262144
local function migrate_legacy_queue()
  if plugin.storage.get("legacy_queue_done") == "1" then
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
    body = body:match("^[^\n]*\n(.*)$") or ""
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
        id = "legacy-" .. tostring(timestamp) .. "-" .. plugin.md5(artist .. "\t" .. title),
        timestamp = timestamp,
        duration = duration or 0,
        artist = queue_decode(artist),
        title = queue_decode(title),
        album = queue_decode(album),
      }
    end
  end
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

local sent_ids = {}

local function enqueue_scrobble(item, username)
  if not item.timestamp or item.timestamp <= 0 or item.artist == "" or item.title == "" then return false end
  local key = queue_key(username)
  local items = load_queue(key)
  if not items then return false end
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

-- Network awareness (player API 18). On older players none of this exists and
-- the plugin behaves as before: no offline detection, backoff only.
local MAX_BACKOFF = 300
local NETWORK_ERROR = "Last.fm not reachable."
local OFFLINE_OFF = "Wi-Fi off \u{2014} will send when connected"
local OFFLINE_NO_LINK = "Wi-Fi not connected \u{2014} will send when connected"

local function network_state()
  if type(plugin.network_status) ~= "function" then return nil end
  if plugin.has_capability and not plugin.has_capability("network.status") then return nil end
  local ok, st = pcall(plugin.network_status)
  if ok and type(st) == "table" then return st end
  return nil
end

-- Wi-Fi switched off: the one state that stays accurate with the screen off,
-- so sends are hard-skipped.
local function wifi_disabled()
  local st = network_state()
  return st ~= nil and st.wifi_enabled == false
end

-- Wi-Fi on but not associated. This can be stale while the screen is off, so
-- it never blocks a send; it only stops failures from growing the backoff.
local function link_down()
  local st = network_state()
  return st ~= nil and st.wifi_enabled ~= false and st.connected == false
end

local function offline_text()
  if wifi_disabled() then return OFFLINE_OFF end
  return OFFLINE_NO_LINK
end

local last_failure_network = false

local function sync_failed(reason)
  reason = reason or "Waiting list could not be updated."
  last_failure_network = (reason == NETWORK_ERROR)
  -- A stale "not connected" can hold plays back for at most MAX_BACKOFF.
  local delay
  if last_failure_network and link_down() then
    -- No link: network_changed will trigger an immediate send on reconnect,
    -- so just wait out the long fallback without growing the backoff.
    delay = MAX_BACKOFF
  else
    sync_failures = sync_failures + 1
    delay = math.min(15 * 2 ^ (sync_failures - 1), MAX_BACKOFF)
  end
  next_sync_at = os.time() + delay
  -- The delay is shown live on the queue row, never baked into this text.
  persistent_error = reason
end

local function format_last_sent(ts)
  ts = tonumber(ts)
  if not ts or ts <= 0 then return nil end
  local fmt = (os.time() - ts) > 86400 and "%m-%d %H:%M" or "%H:%M"
  local ok, text = pcall(os.date, fmt, ts)
  return ok and text or nil
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

-- UI handle and safe refresh declarations
local current_main_handle = nil
local main_refresh_pending = false
local refresh_main_list
local current_record, current_record_account, current_delivery

local sync_queue
sync_queue = function()
  if session_expired then
    if os.time() >= next_expiry_clear_at then
      next_expiry_clear_at = os.time() + 30
      if clear_session() then
        persistent_error = "Session expired. Sign in again."
        if refresh_main_list then refresh_main_list() end
      end
    end
    return
  end
  if not service_ready() then
    if is_gateway_token(state.session_key) and not get_gateway_url() then
      persistent_error = "Last.fm service not configured."
      if refresh_main_list then refresh_main_list() end
    end
    return
  end
  if queue_sync_token or os.time() < next_sync_at or credentials_rejected
      or not (state.enabled and state.session_key and state.username) then return end
  -- Wi-Fi switched off: nothing to try.
  if wifi_disabled() then return end
  local pending_import = plugin.storage.get("legacy_queue_account")
  if pending_import and pending_import:lower() == state.username:lower()
      and plugin.storage.get("legacy_queue_done") ~= "1" then return end
  local account_name = state.username
  local key = queue_key(account_name)
  local items, dropped = load_queue(key)
  if not items then return end
  if dropped and not save_queue(key, items) then return end
  while items[1] and sent_ids[items[1].id] do
    if not remove_queued(key, items[1].id) then
      sync_failed("Waiting list could not be updated.")
      if refresh_main_list then refresh_main_list() end
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
        if wifi_disabled() then
          -- Wi-Fi was switched off mid-request: wait for network_changed.
          if persistent_error == NETWORK_ERROR then persistent_error = nil end
        else
          sync_failed(NETWORK_ERROR)
        end
        if refresh_main_list then refresh_main_list() end
        return
      end
      if status == 200 and body:match('status="ok"') then
        sync_failures, next_sync_at = 0, 0
        last_failure_network = false
        persistent_error = nil
        plugin.storage.set("last_sent_at", tostring(os.time()))
        sent_ids[item.id] = true
        if current_record and current_record.id == item.id and same_account(current_record_account, account_name) then
          local ignored = body:match('<ignoredMessage[^>]*code="(%d+)"')
          current_delivery = ignored and ignored ~= "0" and "Not counted by Last.fm" or "Sent to Last.fm"
        end
        if remove_queued(key, item.id) then
          if refresh_main_list then refresh_main_list() end
          sync_queue()
        else
          sync_failed("Sent, but waiting-list cleanup could not be saved.")
          if refresh_main_list then refresh_main_list() end
        end
        return
      end
      local code = body:match('<error code="(%d+)"')
      if code and CREDENTIAL_ERRORS[code] then
        if uses_gateway() then
          sync_failed("Last.fm service problem.")
          plugin.show_toast("Last.fm service problem.")
        else
          if sent_with_credentials == credential_generation then
            credentials_rejected = true
            persistent_error = "API key or secret rejected by Last.fm."
            plugin.show_toast(persistent_error .. " Check settings.")
          end
        end
      elseif code == "9" then
        cancel_account_requests()
        invalidate_session()
        plugin.show_toast(persistent_error)
      elseif code and not TEMPORARY_ERRORS[code] then
        if current_record and current_record.id == item.id and same_account(current_record_account, account_name) then
          current_delivery = "Last.fm rejected this play"
        end
        sent_ids[item.id] = true
        if not remove_queued(key, item.id) then sync_failed("Waiting list could not be updated.") end
        if refresh_main_list then refresh_main_list() end
        sync_queue()
        return
      else
        sync_failed("Last.fm temporarily busy.")
      end
      if refresh_main_list then refresh_main_list() end
    end)
  if handle then
    if queue_sync_token == token then
      active_requests.queue = handle
      -- Show "Sending…" on the main screen.
      if refresh_main_list then refresh_main_list() end
    end
  else
    if queue_sync_token == token then queue_sync_token = nil end
    sync_failed("Could not send scrobble request.")
    if refresh_main_list then refresh_main_list() end
  end
end

local function retry_now()
  if not service_ready() then
    if uses_gateway() then
      persistent_error = "Last.fm service not configured."
      plugin.show_toast("Last.fm service not configured.")
      if refresh_main_list then refresh_main_list() end
    else
      plugin.show_toast("Check your API key and shared secret in Account settings.")
    end
    return
  end
  if credentials_rejected then
    plugin.show_toast("Check your API key and shared secret in Account settings.")
    return
  end
  if session_expired or not state.session_key then plugin.show_toast("Sign in before sending waiting plays."); return end
  if not state.enabled then plugin.show_toast("Turn scrobbling on before sending waiting plays."); return end
  local count = get_queued_count(state.username)
  if count == nil then plugin.show_toast("Waiting plays could not be read."); return end
  if count == 0 then plugin.show_toast("No plays are waiting to send."); return end
  if queue_sync_token then plugin.show_toast("Already sending waiting plays."); return end
  if wifi_disabled() then plugin.show_toast(offline_text()); return end
  sync_failures, next_sync_at, persistent_error = 0, 0, nil
  plugin.show_toast("Sending waiting plays…")
  sync_queue()
  if refresh_main_list then refresh_main_list() end
end

local current_title, current_artist, current_album, current_duration = nil, nil, nil, 0
local track_start_time = 0
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
current_record = nil
local current_account = nil

local function save_current_play()
  local account = current_account
  if scrobbled_this_track or not state.enabled or not account or not current_title or not current_artist
      or current_duration < 30 or listened_now() < math.min(current_duration / 2, 240) then return end
  current_record = current_record or { timestamp = track_start_time, artist = current_artist,
    title = current_title, album = current_album or "", duration = current_duration }
  if enqueue_scrobble(current_record, account) then
    scrobbled_this_track = true
    current_record_account, current_delivery = account, "Waiting to send"
    if persistent_error == "Waiting list is full or unavailable. Play not saved yet." then persistent_error = nil end
    if refresh_main_list then refresh_main_list() end
    sync_queue()
  else
    current_delivery = "Not saved yet"
    persistent_error = "Waiting list is full or unavailable. Play not saved yet."
    if refresh_main_list then refresh_main_list() end
  end
end

local function update_now_playing()
  if not service_ready() then
    if is_gateway_token(state.session_key) and not get_gateway_url() then
      persistent_error = "Last.fm service not configured."
    end
    return
  end
  if credentials_rejected or session_expired or not (state.enabled and state.session_key and current_title and current_artist) then return end
  local generation = account_generation
  local sent_with_credentials = credential_generation
  tracked_api_call("now_playing", { method = "track.updateNowPlaying", sk = state.session_key,
    track = current_title, artist = current_artist, album = current_album ~= "" and current_album or nil,
    duration = tostring(math.floor(current_duration)) }, function(status, body, request_error)
      if generation ~= account_generation then return end
      if not request_error and status == 200 and body then
        local code = body:match('<error code="(%d+)"')
        if code == "9" then
          cancel_account_requests()
          invalidate_session()
          plugin.show_toast(persistent_error)
          if refresh_main_list then refresh_main_list() end
        elseif code and CREDENTIAL_ERRORS[code] then
          if uses_gateway() then
            persistent_error = "Last.fm service problem."
            plugin.show_toast(persistent_error)
            if refresh_main_list then refresh_main_list() end
          else
            if sent_with_credentials == credential_generation then
              credentials_rejected = true
              persistent_error = "API key or secret rejected by Last.fm."
              plugin.show_toast(persistent_error .. " Check settings.")
              if refresh_main_list then refresh_main_list() end
            end
          end
        end
      end
    end)
end

plugin.on("track_started", function(title, artist, album, duration_seconds)
  close_stretch()
  save_current_play()
  current_title, current_artist, current_album, current_duration = title, artist, album, duration_seconds or 0
  current_account = not session_expired and state.session_key and state.username or nil
  track_start_time = os.time()
  listened_seconds = 0
  playing_since = state.enabled and plugin.is_playing() and os.time() or nil
  scrobbled_this_track, current_record = false, nil
  current_record_account, current_delivery = nil, nil
  update_now_playing()
  sync_queue()
  if refresh_main_list then refresh_main_list() end
end)

local last_backoff_refresh = 0

plugin.set_interval(5, function()
  -- A real change while a child was open is rendered once after returning.
  -- This is not a periodic redraw of the dashboard or a ticking countdown.
  if main_refresh_pending and refresh_main_list then refresh_main_list() end
  if plugin.is_playing() and state.enabled then
    if not playing_since then playing_since = os.time() end
  elseif playing_since then
    close_stretch()
  end
  if not state.enabled then
    return
  end
  sync_queue()
  -- The queue row shows "next try Nm": redraw at most once a minute while
  -- backing off (the fingerprint check skips it if nothing changed).
  if next_sync_at > os.time() and os.time() - last_backoff_refresh >= 60 then
    last_backoff_refresh = os.time()
    if refresh_main_list then refresh_main_list() end
  end
  if not current_title or not current_artist or scrobbled_this_track then
    return
  end
  if current_duration <= 0 then
    current_duration = plugin.get_duration() or 0
    if current_duration > 0 then main_refresh_pending = true end
  end
  if current_duration < 30 then
    return
  end
  if listened_now() >= math.min(current_duration / 2, 240) then
    save_current_play()
  end
end)

-- Connectivity came back (or may have, after sleep): send promptly. The
-- backoff is dropped only if the last failure was a network one; rate-limit,
-- service and storage backoffs stay, and sync_queue() still honours them.
local function network_back()
  if wifi_disabled() then return end
  if last_failure_network then
    sync_failures, next_sync_at = 0, 0
    if persistent_error == NETWORK_ERROR then persistent_error = nil end
  end
  if state.enabled then sync_queue() end
  if refresh_main_list then refresh_main_list() end
end

if type(plugin.network_status) == "function" then
  pcall(plugin.on, "network_changed", function(info)
    if type(info) == "table" and info.connected then
      network_back()
    elseif refresh_main_list then
      refresh_main_list()
    end
  end)
end
-- Fallbacks for players without network_changed, and for Wi-Fi that stayed
-- up across sleep while the old backoff was still ticking.
pcall(plugin.on, "system_resumed", network_back)
pcall(plugin.on, "screen_woke", function()
  if next_sync_at > 0 then network_back() end
end)

local function set_scrobbling(value)
  if not plugin.storage.set("enabled", value and "1" or "0") then
    plugin.show_toast("Could not save scrobbling preference. Try again.")
    return false
  end
  state.enabled = value
  enable_pending = false
  if not value then
    close_stretch()
    scrobbled_this_track = true
  else
    listened_seconds = 0
    playing_since = plugin.is_playing() and os.time() or nil
    sync_failures, next_sync_at = 0, 0
    sync_queue()
  end
  if refresh_main_list then refresh_main_list() end
  return true
end

local function playback_paused()
  close_stretch()
  if refresh_main_list then refresh_main_list() end
end
plugin.on("paused", playback_paused)
plugin.on("stopped", playback_paused)
plugin.on("resumed", function()
  if state.enabled and not playing_since then playing_since = os.time() end
  if refresh_main_list then refresh_main_list() end
end)

local function prompt_api_key(on_success)
  show_input("Last.fm API key", nil, false, function(value)
    if value == nil or value == "" then return end
    local trimmed = trim(value)
    if trimmed == "" or trimmed:find("%c") then
      plugin.show_toast("API key cannot contain control characters.")
      return
    end
    if #trimmed ~= 32 or trimmed:find("%s") then
      plugin.show_toast("Use the 32-character API key without spaces.")
      return
    end
    if plugin.storage.set("api_key", trimmed) then
      API_KEY = trimmed
      credentials_rejected = false
      credential_generation = credential_generation + 1
      cancel_account_requests()
      plugin.show_toast("API key saved.")
      if refresh_main_list then refresh_main_list() end
      if on_success then on_success() end
    else
      plugin.show_toast("Could not save API key. Try again.")
    end
  end)
end

local function prompt_api_secret(on_success)
  show_input("Last.fm Shared Secret", nil, true, function(value)
    if value == nil or value == "" then return end
    local trimmed = trim(value)
    if trimmed == "" or trimmed:find("%c") then
      plugin.show_toast("API secret cannot contain control characters.")
      return
    end
    if set_secret("api_secret", trimmed) then
      API_SECRET = trimmed
      credentials_rejected = false
      credential_generation = credential_generation + 1
      cancel_account_requests()
      plugin.show_toast("Shared secret saved.")
      if refresh_main_list then refresh_main_list() end
      if on_success then on_success() end
    else
      plugin.show_toast("Could not save shared secret. Try again.")
    end
  end)
end

local function cancel_login()
  if not login_in_flight then return end
  cancel_request("login")
  account_generation = account_generation + 1
  login_in_flight = false
  if login_progress_handle and plugin.close_progress then
    plugin.close_progress(login_progress_handle)
    login_progress_handle = nil
  end
  plugin.show_toast("Sign-in cancelled.")
  if refresh_main_list then refresh_main_list() end
end

local function do_login(username, password)
  cancel_account_requests()
  local generation = account_generation
  local route_is_gateway = uses_gateway()
  login_in_flight = true

  local progress_handle = nil
  if plugin.has_capability and plugin.has_capability("ui.progress") and plugin.show_progress then
    progress_handle = plugin.show_progress("Last.fm", "Signing in…")
  end
  login_progress_handle = progress_handle

  plugin.show_toast("Logging in to Last.fm…")
  if refresh_main_list then refresh_main_list() end

  local handle = tracked_api_call("login", {
    method = "auth.getMobileSession",
    username = username,
    password = password
  }, function(status, body, request_error)
    if login_progress_handle and plugin.close_progress then
      plugin.close_progress(login_progress_handle)
      login_progress_handle = nil
    end
    login_in_flight = false

    if generation ~= account_generation then
      if refresh_main_list then refresh_main_list() end
      return
    end

    if not request_error and status == 200 and body and body:match('status="ok"') then
      local key = body:match("<key>([^<]+)</key>")
      local canon_name = body:match("<name>([^<]+)</name>")
      if canon_name then
        canon_name = trim(canon_name)
        if canon_name == "" or #canon_name > 255 or canon_name:find("%c") then
          canon_name = username
        end
      else
        canon_name = username
      end

      local valid_key = false
      if route_is_gateway then
        valid_key = key and #key == 47 and key:match("^cg1_[A-Za-z0-9_%-]+$") ~= nil
      else
        valid_key = key ~= nil and #key <= 256 and not key:find("%c")
      end

      local switching_account = current_account and current_account:lower() ~= canon_name:lower()
      if valid_key and save_session(key, canon_name) then
        if switching_account then
          scrobbled_this_track = true
          current_record, current_record_account, current_delivery = nil, nil, nil
        end
        if not had_account or enable_pending then
          state.enabled = true
          if not save_enabled() then
            state.enabled, enable_pending = false, true
            plugin.show_toast("Account saved. Tap Scrobbling to turn it on.")
          else
            enable_pending = false
          end
          listened_seconds = 0
          playing_since = plugin.is_playing() and os.time() or nil
        end
        had_account = true
        sync_failures, next_sync_at = 0, 0
        credentials_rejected = false
        persistent_error = nil
        plugin.show_toast("Logged in to Last.fm as " .. canon_name)
        sync_queue()
        if refresh_main_list then refresh_main_list() end
        return
      else
        persistent_error = route_is_gateway and not valid_key and "Last.fm service problem. Sign in again." or "Could not save session."
        plugin.show_toast(persistent_error)
        if refresh_main_list then refresh_main_list() end
        return
      end
    end

    local code = body and body:match('<error code="(%d+)"')
    if code == "4" then
      persistent_error = "Username or password incorrect."
      plugin.show_toast(persistent_error)
    elseif code and CREDENTIAL_ERRORS[code] or code == "26" then
      if route_is_gateway then
        persistent_error = "Last.fm service problem."
        plugin.show_toast(persistent_error)
      else
        credentials_rejected = true
        if code == "26" then
          persistent_error = "API key suspended by Last.fm."
        else
          persistent_error = "API key or secret rejected by Last.fm."
        end
        plugin.show_toast(persistent_error)
      end
    elseif request_error or not status or status == 0 or status >= 500 then
      persistent_error = "Last.fm is not reachable. Check network."
      plugin.show_toast(persistent_error)
    else
      persistent_error = "Could not log in to Last.fm. Check details."
      plugin.show_toast(persistent_error)
    end
    if refresh_main_list then refresh_main_list() end
  end)

  if not handle then
    if login_progress_handle and plugin.close_progress then
      plugin.close_progress(login_progress_handle)
      login_progress_handle = nil
    end
    login_in_flight = false
    persistent_error = route_is_gateway and not get_gateway_url() and "Last.fm service not configured." or "Could not start login request."
    plugin.show_toast(persistent_error)
    if refresh_main_list then refresh_main_list() end
  end
end

local setup_generation = 0

local start_login

local function start_guided_setup()
  if uses_gateway() then
    start_login()
    return
  end
  setup_generation = setup_generation + 1
  local my_generation = setup_generation
  local owner_handle = current_main_handle

  local function step_login()
    if session_expired or not state.session_key then
      show_input("Last.fm Username", nil, false, function(username)
        if not username or username == "" then return end
        local trimmed_user = trim(username)
        if trimmed_user == "" or trimmed_user:find("%c") then
          plugin.show_toast("Invalid username.")
          return
        end
        show_input("Last.fm Password", nil, true, function(password)
          if not password or password == "" then return end
          if password:find("%c") then
            plugin.show_toast("Password cannot contain control characters.")
            return
          end
          do_login(trimmed_user, password)
        end)
      end)
    else
      plugin.show_toast("Last.fm setup is already complete.")
      if refresh_main_list then refresh_main_list() end
    end
  end

  local function step_secret()
    if API_SECRET == "" then
      prompt_api_secret(step_login)
    else
      step_login()
    end
  end

  local function step_key()
    if API_KEY == "" then
      prompt_api_key(step_secret)
    else
      step_secret()
    end
  end

  if API_KEY == "" and API_SECRET == "" then
    local setup_text = "To scrobble music to Last.fm:\n\n"
      .. "1. On a phone or computer, sign in to Last.fm.\n\n"
      .. "2. Open this address:\nlast.fm/api/account/create\n\n"
      .. "3. Create an application (any name is fine).\n\n"
      .. "4. If asked for callback URL, enter http://localhost\n\n"
      .. "5. Obtain your API Key and Shared Secret.\n\n"
      .. "Close this page to enter them."

    if owner_handle and plugin.has_capability and plugin.has_capability("ui.text_view")
        and plugin.has_capability("ui.list_showing") and plugin.is_list_showing and plugin.show_text_view then
      local shown = plugin.show_text_view("Set up Last.fm", setup_text, {
        on_close = function()
          if my_generation ~= setup_generation then return end
          if owner_handle and plugin.has_capability and plugin.has_capability("ui.list_showing") and plugin.is_list_showing then
            if not plugin.is_list_showing(owner_handle) then return end
          end
          step_key()
        end
      })
      if shown == false then
        plugin.show_toast("Could not open setup guide.")
        return
      end
    else
      plugin.show_toast("Create an app at last.fm/api/account/create")
      step_key()
    end
  else
    step_key()
  end
end

start_login = function()
  if uses_gateway() then
    if not get_gateway_url() then
      persistent_error = "Last.fm service not configured."
      plugin.show_toast("Last.fm service not configured.")
      if refresh_main_list then refresh_main_list() end
      return
    end
  else
    if API_KEY == "" or API_SECRET == "" then
      plugin.show_toast("Add your Last.fm API credentials first.")
      start_guided_setup()
      return
    end
  end
  if state.session_key and not session_expired then
    plugin.show_toast("Already signed in to Last.fm.")
    if refresh_main_list then refresh_main_list() end
    return
  end
  if login_in_flight then
    plugin.show_toast("Sign-in already in progress.")
    return
  end
  show_input("Last.fm Username", nil, false, function(username)
    if not username or username == "" then return end
    local trimmed_user = trim(username)
    if trimmed_user == "" or trimmed_user:find("%c") then
      plugin.show_toast("Invalid username.")
      return
    end
    show_input("Last.fm Password", nil, true, function(password)
      if not password or password == "" then return end
      if password:find("%c") then
        plugin.show_toast("Password cannot contain control characters.")
        return
      end
      do_login(trimmed_user, password)
    end)
  end)
end

local function finish_confirmation(handle, title, message)
  plugin.show_toast(message)
  if handle and plugin.has_capability and plugin.has_capability("ui.list_update")
      and plugin.is_list_showing and plugin.is_list_showing(handle) then
    plugin.show_list(title, { message .. " Press Back." }, function() end, { replace = handle })
  end
end

local function confirm_sign_out()
  if not state.session_key then return end
  local username, generation = state.username, account_generation
  local done, handle = false, nil
  handle = plugin.show_list("Sign out?", { "Keep signed in", "Sign out " .. truncate(username, 20) }, function(idx)
    if done or (idx ~= 1 and idx ~= 2) then return end
    done = true
    if idx == 1 then finish_confirmation(handle, "Sign out?", "Kept signed in."); return end
    if generation ~= account_generation or username ~= state.username then
      finish_confirmation(handle, "Sign out?", "Account changed. Nothing changed."); return
    end
    cancel_account_requests()
    if not clear_session() then
      finish_confirmation(handle, "Sign out?", "Could not save sign-out. Try again.")
      return
    end
    close_stretch()
    scrobbled_this_track = true
    finish_confirmation(handle, "Sign out?", "Signed out. Waiting plays are kept for this account.")
    if refresh_main_list then refresh_main_list() end
  end)
end

local function confirm_discard_queue()
  local username = state.username or last_username
  if not username or username == "" then return end
  local count = get_queued_count(username)
  if count == nil then plugin.show_toast("Waiting plays could not be read. Nothing discarded."); return end
  if count == 0 then plugin.show_toast("No waiting plays to discard."); return end
  local generation, done, handle = account_generation, false, nil
  local title = "Discard " .. count .. " plays?"
  handle = plugin.show_list(title, { "Keep waiting plays", "Discard " .. count .. " plays" }, function(idx)
    if done or (idx ~= 1 and idx ~= 2) then return end
    done = true
    if idx == 1 then finish_confirmation(handle, title, "Kept waiting plays."); return end
    if generation ~= account_generation or not same_account(username, state.username or last_username) then
      finish_confirmation(handle, title, "Account changed. Nothing discarded."); return
    end
    -- Cancel and invalidate every reply before replacing the current account's queue.
    cancel_account_requests()
    if save_queue(queue_key(username), {}) then
      if current_record_account == username and current_record then current_delivery = "Discarded by you" end
      finish_confirmation(handle, title, "Waiting plays discarded.")
      if refresh_main_list then refresh_main_list() end
    else
      finish_confirmation(handle, title, "Could not discard plays. Try again.")
    end
  end)
end

local function open_queue_list()
  local username = state.username or last_username
  if not username then plugin.show_toast("No account has waiting plays yet."); return end
  local items = load_queue(queue_key(username))
  if not items then plugin.show_toast("Waiting plays could not be read. Nothing removed."); return end
  local labels, actions = {}, {}
  local function add(label, action)
    labels[#labels + 1], actions[#actions + 1] = label, action
  end
  if #items == 0 then
    add("No plays are waiting to send", function() plugin.show_toast("Qualified plays send automatically.") end)
  else
    add(#items .. " plays kept for " .. truncate(username, 20), function() plugin.show_toast("Oldest plays are sent first.") end)
    if same_account(state.username, username) and not session_expired and state.session_key and state.enabled and not credentials_rejected then
      add("Send waiting plays now", retry_now)
    end
    for i, item in ipairs(items) do
      local title, artist, timestamp = item.title, item.artist, item.timestamp
      add(string.format("%d. %s - %s", i, truncate(artist, 20), truncate(title, 20)), function()
        local ok, time_text = pcall(os.date, "!%Y-%m-%d %H:%M UTC", timestamp)
        plugin.show_toast(ok and time_text and ("Saved: " .. time_text) or "Saved time unavailable")
      end)
    end
    add("Discard waiting plays…", confirm_discard_queue)
  end
  plugin.show_list("Waiting plays", labels, function(idx)
    if not same_account(username, state.username or last_username) then plugin.show_toast("Account changed. Open waiting plays again."); return end
    if actions[idx] then actions[idx]() end
  end)
end

local function open_how_it_works()
  local text = "How Last.fm Scrobbling Works:\n\n"
    .. "1. 30-Second Rule: Tracks under 30 seconds are not scrobbled.\n\n"
    .. "2. Listening Threshold: A play qualifies after half its length or 4 minutes, whichever comes first.\n\n"
    .. "3. Pauses & Seeking: Time spent paused or seeking does not count toward the threshold.\n\n"
    .. "4. Offline Queue: Up to 100 plays (64 KB) are saved offline and sent automatically when connected.\n\n"
    .. "5. Local Expiry: This player keeps waiting plays for up to 13 days.\n\n"
    .. "6. Account Separation: Offline queues are stored separately per Last.fm username."

  if uses_gateway() then
    text = text .. "\n\n7. Sign-in: Compás forwards your credentials to Last.fm over HTTPS; your password is never stored."
  end

  if plugin.has_capability and plugin.has_capability("ui.text_view") and plugin.show_text_view then
    local shown = plugin.show_text_view("How Scrobbling Works", text)
    if shown ~= false then return end
  end

  if plugin.show_list then
    local lines = {
      "Tracks >= 30s only",
      "Listened 50% or 4 min",
      "Pauses do not count",
      "Up to 100 offline plays",
      "13-day age limit",
      "Separate queue per user"
    }
    if uses_gateway() then
      lines[#lines + 1] = "Credentials forwarded; password never stored"
    end
    plugin.show_list("How Scrobbling Works", lines, function() end)
  else
    if uses_gateway() then
      plugin.show_toast("Compás sign-in service forwards credentials to Last.fm; password never stored.")
    else
      plugin.show_toast("Tracks >= 30s scrobble after 50% or 4 min. 100 plays queued offline.")
    end
  end
end

local function open_settings_screen()
  local rows = {}
  if not uses_gateway() then
    rows[#rows + 1] = {
      type = "row",
      label = "API Key: " .. (API_KEY ~= "" and "Configured" or "Not configured"),
      on_select = function()
        prompt_api_key(function()
          if plugin.has_capability and plugin.has_capability("ui.list_update") then
            open_settings_screen()
          end
        end)
      end
    }
    rows[#rows + 1] = {
      type = "row",
      label = "API Secret: " .. (API_SECRET ~= "" and "Configured" or "Not configured"),
      on_select = function()
        prompt_api_secret(function()
          if plugin.has_capability and plugin.has_capability("ui.list_update") then
            open_settings_screen()
          end
        end)
      end
    }
  end

  if state.session_key then
    if session_expired then
      rows[#rows + 1] = { type = "row", label = "Sign In to Last.fm", on_select = start_login }
    end
    rows[#rows + 1] = {
      type = "row",
      label = "Sign Out (" .. truncate(state.username or "", 18) .. ")",
      on_select = function()
        confirm_sign_out()
      end
    }
  else
    rows[#rows + 1] = {
      type = "row",
      label = "Sign In to Last.fm",
      on_select = function()
        start_login()
      end
    }
  end

  local count = get_queued_count(state.username)
  if count and count > 0 then
    rows[#rows + 1] = {
      type = "row",
      label = "Discard waiting plays (" .. count .. ")",
      on_select = function()
        confirm_discard_queue()
      end
    }
  end

  rows[#rows + 1] = {
    type = "row",
    label = "How Scrobbling Works",
    on_select = function()
      open_how_it_works()
    end
  }

  plugin.show_settings_list("LastFM Scrobbler V2 Settings", rows, { update = true })
end

local function is_main_showing()
  if not current_main_handle then return false end
  if plugin.has_capability and plugin.has_capability("ui.list_showing") and plugin.is_list_showing then
    return plugin.is_list_showing(current_main_handle)
  end
  return false
end

local function build_main_menu()
  local items = {}
  local actions = {}

  local function add_row(label, action)
    items[#items + 1] = label
    actions[#actions + 1] = action
  end

  -- 1. Busy Status + Cancel (<= 3 rows)
  if login_in_flight then
    add_row("Status: Signing in…", function()
      plugin.show_toast("Sign-in is currently in progress.")
    end)
    add_row("Cancel sign-in", function()
      cancel_login()
    end)
    add_row("Account & settings", function()
      open_settings_screen()
    end)
    return items, actions
  end

  -- 2. First use / Missing credentials (<= 3 rows)
  if not uses_gateway() and (API_KEY == "" or API_SECRET == "") then
    if API_KEY == "" and API_SECRET == "" then
      add_row("Set up Last.fm", function()
        start_guided_setup()
      end)
      add_row("How Scrobbling Works", function()
        open_how_it_works()
      end)
    else
      add_row("Continue setup", function()
        start_guided_setup()
      end)
      add_row("Account & settings", function()
        open_settings_screen()
      end)
      add_row("How Scrobbling Works", function()
        open_how_it_works()
      end)
    end
    return items, actions
  end

  -- 3. Configured signed out (<= 3 rows)
  if session_expired or not state.session_key then
    if credentials_rejected then
      add_row("Status: API key/secret rejected", function()
        plugin.show_toast("API key or secret rejected by Last.fm. Check settings.")
      end)
    elseif persistent_error and persistent_error ~= "" then
      add_row("Status: " .. truncate(persistent_error, 40), function()
        start_login()
      end)
    else
      add_row("Sign In to Last.fm", function()
        start_login()
      end)
    end
    add_row("Account & settings", function()
      open_settings_screen()
    end)
    add_row("How Scrobbling Works", function()
      open_how_it_works()
    end)
    return items, actions
  end

  -- 4. Connected daily (5 rows; a 6th, "Sync now", only while plays wait)
  local count = get_queued_count(state.username)
  local offline_waiting = state.enabled and count and count > 0 and (wifi_disabled() or link_down())
  local status_label, status_toast
  if credentials_rejected then
    status_label = "Status: API key/secret rejected"
    status_toast = "API key or secret rejected by Last.fm."
  elseif persistent_error and persistent_error ~= "" and persistent_error ~= NETWORK_ERROR then
    status_label = "Status: " .. truncate(persistent_error, 45)
    status_toast = persistent_error
  elseif offline_waiting then
    status_label = offline_text()
    status_toast = offline_text()
  elseif persistent_error and persistent_error ~= "" then
    status_label = "Status: " .. truncate(persistent_error, 45)
    status_toast = persistent_error
  else
    status_label = "Signed in as " .. truncate(state.username or "", 20)
    status_toast = "Signed in as " .. (state.username or "unknown")
  end
  add_row(status_label, function() plugin.show_toast(status_toast) end)

  local track_label
  if not current_title or current_title == "" then
    track_label = "This track: No music playing"
  elseif not state.enabled then
    track_label = "This track: Scrobbling off"
  elseif current_duration <= 0 then
    track_label = "This track: Reading length"
  elseif current_duration < 30 then
    track_label = "This track: Too short (<30s)"
  elseif not same_account(current_account, state.username) then
    track_label = "This track: Starts counting next song"
  elseif current_delivery then
    track_label = "This track: " .. current_delivery
  elseif scrobbled_this_track then
    track_label = "This track: This listen not counted"
  elseif not plugin.is_playing() then
    track_label = "This track: Playback paused"
  else
    local thresh = math.min(current_duration / 2, 240)
    track_label = "This track: Counts after " .. format_time(thresh)
  end
  add_row(track_label, function()
    if current_title and current_title ~= "" then
      local thresh = math.min(current_duration / 2, 240)
      plugin.show_toast(string.format("%s - %s (%s / %s)",
        truncate(current_artist or "", 25), truncate(current_title or "", 25),
        format_time(listened_now()), format_time(thresh)))
    else
      plugin.show_toast("No track playing.")
    end
  end)

  -- The main screen is a live-updating show_list (handle + replace), which
  -- has no switch row; on wrapped lists the state is the row's native muted
  -- secondary line, as in the player's own Settings rows.
  local scrobbling_state = state.enabled and "On" or "Off"
  local wrapped = plugin.has_capability and plugin.has_capability("ui.list_wrap")
  add_row(wrapped and ("Scrobbling\n" .. scrobbling_state) or ("Scrobbling: " .. scrobbling_state), function()
    local desired = not state.enabled
    if set_scrobbling(desired) then
      plugin.show_toast(desired and "Scrobbling turned on." or "Scrobbling turned off.")
      refresh_main_list()
    end
  end)

  local queue_label
  if count == nil then
    queue_label = "Waiting plays could not be read"
  else
    queue_label = count .. (count == 1 and " play waiting" or " plays waiting")
    local remaining = next_sync_at - os.time()
    if count > 0 then
      if queue_sync_token then
        queue_label = queue_label .. " \u{b7} Sending\u{2026}"
      elseif state.enabled and wifi_disabled() then
        queue_label = queue_label .. " \u{b7} waiting for Wi-Fi"
      elseif remaining > 0 and not credentials_rejected then
        queue_label = queue_label .. " \u{b7} next try " .. math.max(1, math.ceil(remaining / 60)) .. "m"
      end
    end
    local last_sent = format_last_sent(plugin.storage.get("last_sent_at", ""))
    if last_sent then queue_label = queue_label .. " \u{b7} sent " .. last_sent end
  end
  add_row(queue_label, open_queue_list)

  if count and count > 0 and state.enabled and state.session_key and not session_expired
      and not credentials_rejected then
    add_row("Sync now", retry_now)
  end

  add_row("Account & settings", function()
    open_settings_screen()
  end)

  return items, actions
end

local current_main_actions = nil
local last_menu_fingerprint = nil

local function render_main_items(items)
  if not (plugin.has_capability and plugin.has_capability("ui.list_wrap")) then return items end
  local rows = {}
  for i, label in ipairs(items) do
    rows[i] = { label = label, wrap = true }
  end
  return rows
end

local function on_main_select(index)
  if current_main_actions and current_main_actions[index] then
    current_main_actions[index]()
  end
end

refresh_main_list = function()
  main_refresh_pending = true
  if not current_main_handle then return end
  if plugin.has_capability and plugin.has_capability("ui.list_update") and is_main_showing() then
    local items, actions = build_main_menu()
    local fingerprint = table.concat(items, "\31")
    if fingerprint == last_menu_fingerprint then
      main_refresh_pending = false
      current_main_actions = actions
      return
    end
    local new_handle = plugin.show_list("LastFM Scrobbler V2", render_main_items(items), on_main_select, { replace = current_main_handle })
    if new_handle then
      main_refresh_pending = false
      last_menu_fingerprint = fingerprint
      current_main_actions = actions
      current_main_handle = new_handle
    end
  end
end

local function open_main_list()
  local items, actions = build_main_menu()
  last_menu_fingerprint = table.concat(items, "\31")
  current_main_actions = actions
  current_main_handle = plugin.show_list("LastFM Scrobbler V2", render_main_items(items), on_main_select)
  main_refresh_pending = false
end

plugin.register_list_item("playback", "LastFM Scrobbler V2", open_main_list)

if not credentials_rejected and state.enabled and state.session_key then
  sync_queue()
end
