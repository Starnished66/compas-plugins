plugin.define({
    id = "compas.autoeq",
    name = "AutoEQ",
    version = "1.0",
    api_min = 14,
})

-- AutoEQ profile browser for the recommended catalog maintained by jaakkopasanen/AutoEq.
-- Network work starts only after the user opens this screen. Catalog/result sizes,
-- cached bytes, request sizes, and displayed page sizes are all bounded.
local ROOT = plugin.sd_root()
local PLUGIN_DIR = ROOT .. "/.plugins"
local CACHE_PATH = PLUGIN_DIR .. "/.autoeq_catalog.md"
local CATALOG_URL = "https://raw.githubusercontent.com/jaakkopasanen/AutoEq/master/results/README.md"
local RAW_PREFIX = "https://raw.githubusercontent.com/jaakkopasanen/AutoEq/master/results/"
local MAX_CATALOG_BYTES = 1024 * 1024
local MAX_MODELS = 20000
local MAX_CATALOG_LINE_BYTES = 4096
local PAGE_SIZE = 40

local BAND_FREQS = { 31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000 }
local BAND_Q = { 0.2, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.2 }
local BAND_TYPE = { 1, 0, 0, 0, 0, 0, 0, 0, 0, 2 }

local catalog = nil
local catalog_error = nil
local task_handle = nil
local task_generation = 0
local active_screen = nil
local download_profile

local function trim(s)
    return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function read_cache()
    local f = io.open(CACHE_PATH, "rb")
    if not f then return nil end
    local data = f:read(MAX_CATALOG_BYTES + 1)
    f:close()
    if not data or #data == 0 or #data > MAX_CATALOG_BYTES then return nil end
    return data
end

local function write_cache(data)
    if #data == 0 or #data > MAX_CATALOG_BYTES then return false end
    local f = io.open(CACHE_PATH .. ".tmp", "wb")
    if not f then return false end
    local ok = f:write(data)
    local closed = f:close()
    if not ok or not closed or not os.rename(CACHE_PATH .. ".tmp", CACHE_PATH) then
        os.remove(CACHE_PATH .. ".tmp")
        return false
    end
    return true
end

-- Validate each catalog href as a relative path before it can reach the URL builder.
local function valid_catalog_path(path)
    if type(path) ~= "string" or #path == 0 or #path > 1024 then return false end
    if path:find("\\", 1, true) or path:find("?", 1, true) or path:find("#", 1, true) then return false end
    if path:sub(1, 1) == "/" or path:match("^[%a][%w+%.%-]*:") then return false end
    local decoded = path:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)
    if decoded:find("\\", 1, true) or decoded:find("%c") then return false end
    local i = 1
    while true do
        local percent = path:find("%", i, true)
        if not percent then break end
        local escape = path:sub(percent + 1, percent + 2)
        if not escape:match("^%x%x$") then return false end
        local byte = tonumber(escape, 16)
        if not byte or byte == 47 or byte == 92 or byte < 32 or byte == 127 then return false end
        i = percent + 3
    end
    if decoded:sub(1, 1) == "/" or decoded:match("^[%a][%w+%.%-]*:") or decoded:find("//", 1, true) then return false end
    for segment in decoded:gmatch("[^/]+") do
        if segment == "." or segment == ".." or segment == "" then return false end
    end
    if path:find("//", 1, true) then return false end
    return true
end

local function encode_path(path)
    local out = {}
    local i = 1
    while i <= #path do
        local c = path:sub(i, i)
        if c == "/" or c:match("[A-Za-z0-9%-%._~]") then
            out[#out + 1] = c
        elseif c == "%" and path:sub(i + 1, i + 2):match("^%x%x$") then
            out[#out + 1] = path:sub(i, i + 2)
            i = i + 2
        else
            out[#out + 1] = string.format("%%%02X", string.byte(c))
        end
        i = i + 1
    end
    return table.concat(out)
end

local function parse_catalog(data)
    if type(data) ~= "string" or #data == 0 or #data > MAX_CATALOG_BYTES then
        return nil, "Catalog is empty or too large"
    end
    local models = {}
    for line in (data .. "\n"):gmatch("(.-)\n") do
        if #line > MAX_CATALOG_LINE_BYTES then
            return nil, "Catalog has a line longer than " .. MAX_CATALOG_LINE_BYTES .. " bytes"
        end
        -- Greedy href capture intentionally takes the final ')' so model names and
        -- nested path segments containing parentheses remain intact.
        local name, path = line:match("^%- %[(.-)%]%(%./(.+)%)%s*$")
        if name and valid_catalog_path(path) then
            if #models >= MAX_MODELS then return nil, "Catalog has too many models" end
            models[#models + 1] = { name = name, path = path }
        end
    end
    if #models == 0 then return nil, "No model entries found in catalog" end
    return models
end

local function ensure_catalog()
    if catalog then return true end
    local raw = read_cache()
    if raw then
        local parsed, err = parse_catalog(raw)
        if parsed then catalog = parsed; return true end
        catalog_error = err
    end
    return false
end

local function cancel_task()
    task_generation = task_generation + 1
    if task_handle then plugin.cancel(task_handle); task_handle = nil end
end

local function begin_catalog_request(on_ready, screen_handle)
    cancel_task()
    local generation = task_generation
    plugin.show_toast("Loading AutoEQ catalog…")
    local handle, err = plugin.http_request({
        url = CATALOG_URL, method = "GET", verify_tls = true,
        max_response_bytes = MAX_CATALOG_BYTES,
        connect_timeout_ms = 10000, read_timeout_ms = 15000, total_timeout_ms = 30000,
        redirect_limit = 3,
    }, function(status, body, request_error)
        if generation ~= task_generation then return end
        task_handle = nil
        local screen_is_active = not screen_handle or plugin.is_list_showing(screen_handle)
        if request_error or not status or status < 200 or status >= 300 then
            catalog_error = request_error or ("HTTP " .. tostring(status or "error"))
            if ensure_catalog() then
                if screen_is_active then plugin.show_toast("Offline: using saved AutoEQ catalog") end
                if on_ready and screen_is_active then on_ready(true) end
            else
                if screen_is_active then plugin.show_toast("AutoEQ catalog failed: " .. tostring(catalog_error)) end
            end
            return
        end
        local parsed, parse_error = parse_catalog(body)
        if not parsed then
            catalog_error = parse_error
            if screen_is_active then plugin.show_toast("AutoEQ catalog invalid: " .. parse_error) end
            return
        end
        catalog = parsed
        catalog_error = nil
        if screen_is_active then
            if not write_cache(body) then plugin.show_toast("Catalog loaded; cache could not be saved")
            else plugin.show_toast("AutoEQ catalog ready") end
        end
        if on_ready and screen_is_active then on_ready(false) end
    end)
    if not handle then
        catalog_error = err or "request could not start"
        local screen_is_active = not screen_handle or plugin.is_list_showing(screen_handle)
        if ensure_catalog() then
            if screen_is_active then plugin.show_toast("Offline: using saved AutoEQ catalog") end
            if on_ready and screen_is_active then on_ready(true) end
        elseif screen_is_active then plugin.show_toast("AutoEQ catalog failed: " .. tostring(catalog_error)) end
        return false
    end
    task_handle = handle
    return true
end

local function matching_models(query)
    local terms = {}
    for term in string.lower(query):gmatch("%S+") do terms[#terms + 1] = term end
    local matches = {}
    for _, model in ipairs(catalog or {}) do
        local candidate = string.lower(model.name)
        local all = true
        for _, term in ipairs(terms) do
            if not candidate:find(term, 1, true) then all = false; break end
        end
        if all then matches[#matches + 1] = model end
    end
    return matches
end

local function show_model_details(model)
    local parent = model.path:match("^(.*)/[^/]+$") or model.path
    local source = parent:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)
    -- The local profile path is deterministic and unique per catalog model.
    local safe = model.name:gsub("[/\\:*?\"<>|%c]", "_"):gsub("^%.*", ""):gsub("^%s+", ""):gsub("%s+$", "")
    safe = safe:sub(1, 140)
    -- If a byte limit split a UTF-8 sequence, drop its incomplete suffix.
    local last = #safe
    local first = last
    while first > 0 and safe:byte(first) >= 128 and safe:byte(first) < 192 do first = first - 1 end
    local lead = first > 0 and safe:byte(first) or 0
    local need = (lead >= 240 and 4) or (lead >= 224 and 3) or (lead >= 192 and 2) or 1
    if last - first + 1 < need then safe = safe:sub(1, first - 1) end
    if safe == "" then safe = "model" end
    local hash = plugin.md5(model.path):sub(1, 10)
    local base_name = "AutoEQ - " .. safe .. " - " .. hash .. ".peq"
    local target_path = ROOT .. "/PEQ_Profiles/" .. base_name
    local rows = {
        { label = "Model: " .. model.name, wrap = true },
        { label = "Measurement: " .. source, wrap = true },
    }
    local existing = io.open(target_path, "r")
    if existing then
        existing:close()
        rows[#rows + 1] = { label = "Replace existing profile: " .. base_name, wrap = true }
        local alt = target_path:gsub("%.peq$", " - copy.peq")
        local n = 2
        while true do
            local probe = io.open(alt, "r")
            if not probe then break end
            probe:close()
            alt = target_path:gsub("%.peq$", " - copy " .. n .. ".peq")
            n = n + 1
            if n > 99 then alt = nil; break end
        end
        if alt then rows[#rows + 1] = { label = "Save as new copy" } end
        local replace_index = 3
        local copy_index = alt and 4 or nil
        local handle
        handle = plugin.show_list(model.name, rows, function(index)
            if index == replace_index then download_profile(model, target_path, handle, true)
            elseif copy_index and index == copy_index then download_profile(model, alt, handle, false) end
        end)
        active_screen = handle
    else
        rows[#rows + 1] = { label = "Download profile" }
        local handle
        handle = plugin.show_list(model.name, rows, function(index)
            if index == 3 then download_profile(model, target_path, handle, false) end
        end)
        active_screen = handle
    end
end

-- Strictly validates all source rows and converts AutoEQ shelf-Q into the
-- native peq.c shelf slope S because the native shelf formula uses RBJ's
-- slope expression even though the settings screen calls the field Q.
local function parse_parametric(text)
    if type(text) ~= "string" or #text == 0 or #text > 65536 then return nil, "Profile is empty or too large" end
    local preamp, filters = nil, {}
    for raw_line in (text .. "\n"):gmatch("(.-)\n") do
        local line = trim(raw_line:gsub("\r$", ""))
        if line:match("^[#;]") or line == "" then
            -- comments and blank lines are permitted
        elseif line:lower():match("^preamp%s*:") then
            local value = line:match("^[Pp][Rr][Ee][Aa][Mm][Pp]%s*:%s*([%+%-]?[%d%.]+[eE]?[%+%-]?%d*)%s*[dD][bB]%s*$")
            value = value and tonumber(value)
            if preamp ~= nil or not value or value ~= value or value == math.huge or value == -math.huge then return nil, "Invalid or duplicate preamp row" end
            if value < -12 or value > 12 then return nil, "Preamp is outside the player range (-12 to +12 dB)" end
            preamp = value
        elseif line:lower():match("^filter") then
            local n, enabled, kind, freq_s, gain_s, q_s = line:match("^[Ff]ilter%s+(%d+)%s*:%s*(%u+)%s+(%u+)%s+[Ff][Cc]%s+([%+%-]?[%d%.]+[eE]?[%+%-]?%d*)%s*[Hh][Zz]%s+[Gg]ain%s+([%+%-]?[%d%.]+[eE]?[%+%-]?%d*)%s*[dD][bB]%s+[Qq]%s+([%+%-]?[%d%.]+[eE]?[%+%-]?%d*)%s*$")
            n, freq_s, gain_s, q_s = tonumber(n), freq_s, gain_s, q_s
            local freq, gain, q = tonumber(freq_s), tonumber(gain_s), tonumber(q_s)
            if not n or not enabled or not kind or filters[n] then return nil, "Malformed or duplicate filter row" end
            if n < 1 or n > 10 or (enabled ~= "ON" and enabled ~= "OFF") then return nil, "Filter count or enable state is invalid" end
            if not freq or not gain or not q or freq ~= freq or gain ~= gain or q ~= q or freq == math.huge or gain == math.huge or q == math.huge or freq == -math.huge or gain == -math.huge or q == -math.huge then return nil, "Filter has a non-finite number" end
            if freq < 20 or freq > 20000 then return nil, "Filter frequency is outside 20–20000 Hz" end
            if gain < -12 or gain > 12 then return nil, "Filter gain is outside -12 to +12 dB" end
            if q <= 0 or q < 0.1 or q > 10 then return nil, "Filter Q is outside 0.1–10" end
            local band_type
            if kind == "PK" then band_type = 0
            elseif kind == "LSC" or kind == "LS" then band_type = 1
            elseif kind == "HSC" or kind == "HS" then band_type = 2
            else return nil, "Unsupported filter type: " .. kind end
            local native_q = q
            if band_type == 1 or band_type == 2 then
                local A = 10 ^ (gain / 40)
                local slope = 1 / (1 + (1 / (q * q) - 2) / (A + 1 / A))
                if slope ~= slope or slope == math.huge or slope < 0.1 or slope > 10 then return nil, "Converted shelf slope is outside the player range (0.1–10)" end
                native_q = slope
            end
            filters[n] = { enabled = enabled == "ON", kind = band_type, freq = freq, gain = gain, q = native_q }
        else
            return nil, "Unrecognized profile row: " .. line:sub(1, 72)
        end
    end
    if preamp == nil then return nil, "Profile has no Preamp row" end
    local highest = 0
    for n in pairs(filters) do if n > highest then highest = n end end
    if highest == 0 then return nil, "Profile has no filter rows" end
    for n = 1, highest do if not filters[n] then return nil, "Filter numbering has a gap" end end
    return { preamp = preamp, filters = filters }
end

local function write_profile(model, destination, text, allow_replace)
    local parsed, err = parse_parametric(text)
    if not parsed then return false, err end
    local current = io.open(destination, "r")
    if current then
        current:close()
        if not allow_replace then return false, "Profile now exists; choose Replace explicitly" end
    end
    local dir_ok = plugin.mkdir(ROOT .. "/PEQ_Profiles")
    if not dir_ok then return false, "Could not create PEQ_Profiles" end
    local temp = destination .. ".tmp"
    local f = io.open(temp, "w")
    if not f then return false, "Could not open temporary profile" end
    local ok = f:write("bypass=0\npreamp=" .. string.format("%.6f", parsed.preamp) .. "\n")
    for i = 1, 10 do
        local spec = parsed.filters[i]
        local freq, gain, q, kind, enabled
        if spec then
            freq, gain, q, kind, enabled = spec.freq, spec.gain, spec.q, spec.kind, spec.enabled and 1 or 0
        else
            freq, gain, q, kind, enabled = BAND_FREQS[i], 0, BAND_Q[i], BAND_TYPE[i], 0
        end
        if ok then
            ok = f:write(string.format("band%d_freq=%.6f\nband%d_gain=%.6f\nband%d_q=%.6f\nband%d_type=%d\nband%d_enabled=%d\n",
                i - 1, freq, i - 1, gain, i - 1, q, i - 1, kind, i - 1, enabled))
        end
    end
    local closed = f:close()
    if not ok or not closed or not os.rename(temp, destination) then
        os.remove(temp)
        return false, "Could not save profile; existing file was kept"
    end
    return true
end

download_profile = function(model, destination, detail_handle, allow_replace)
    cancel_task()
    local generation = task_generation
    local path = model.path
    if not valid_catalog_path(path) then plugin.show_toast("Invalid AutoEQ catalog path"); return end
    -- Profile files are in each linked model directory and share its final path segment.
    local url = RAW_PREFIX .. encode_path(path .. "/" .. path:match("([^/]+)$") .. "%20ParametricEQ.txt")
    local handle, err = plugin.http_request({
        url = url, method = "GET", verify_tls = true,
        max_response_bytes = 65536,
        connect_timeout_ms = 10000, read_timeout_ms = 15000, total_timeout_ms = 30000,
        redirect_limit = 3,
    }, function(status, body, request_error)
        if generation ~= task_generation then return end
        task_handle = nil
        if request_error or not status or status < 200 or status >= 300 then
            if not detail_handle or plugin.is_list_showing(detail_handle) then plugin.show_toast("Profile download failed: " .. tostring(request_error or status)) end
            return
        end
        local ok, save_error = write_profile(model, destination, body, allow_replace)
        if not ok then
            if not detail_handle or plugin.is_list_showing(detail_handle) then plugin.show_toast("Profile not saved: " .. tostring(save_error)) end
            return
        end
        if not detail_handle or plugin.is_list_showing(detail_handle) then plugin.show_toast("Saved. Select it in Equalizer → Profiles") end
    end)
    if not handle then plugin.show_toast("Profile download could not start: " .. tostring(err)); return end
    task_handle = handle
    plugin.show_toast("Downloading AutoEQ profile…")
end

local function show_results(query, matches, page)
    local total = #matches
    local pages = math.max(1, math.ceil(total / PAGE_SIZE))
    page = math.max(1, math.min(page, pages))
    local rows, first = {}, (page - 1) * PAGE_SIZE + 1
    for i = first, math.min(total, first + PAGE_SIZE - 1) do
        local model = matches[i]
        rows[#rows + 1] = { label = model.name, wrap = true }
    end
    if #rows == 0 then rows[1] = "No models matched" end
    local handle
    handle = plugin.show_list("AutoEQ " .. page .. "/" .. pages .. " · " .. total .. " matches", rows, function(index)
        if index <= math.min(total - first + 1, PAGE_SIZE) then show_model_details(matches[first + index - 1]) end
    end)
    active_screen = handle
end

local function run_search(query)
    query = trim(query or "")
    if #query < 2 then plugin.show_toast("Enter at least 2 characters"); return end
    if not ensure_catalog() then
        local prior_screen = active_screen
        begin_catalog_request(function()
            if not prior_screen or plugin.is_list_showing(prior_screen) then
                run_search(query)
            end
        end, prior_screen)
        return
    end
    local matches = matching_models(query)
    if #matches <= PAGE_SIZE then show_results(query, matches, 1); return end
    local page_count = math.ceil(#matches / PAGE_SIZE)
    local rows = {}
    for p = 1, page_count do
        local lo = (p - 1) * PAGE_SIZE + 1
        local hi = math.min(#matches, lo + PAGE_SIZE - 1)
        rows[#rows + 1] = { label = "Models " .. lo .. "–" .. hi, wrap = true }
    end
    local handle
    handle = plugin.show_list("AutoEQ pages · " .. #matches .. " matches", rows, function(index)
        show_results(query, matches, index)
    end)
    active_screen = handle
end

local function show_home()
    local cached = ensure_catalog()
    local items = {
        { label = cached and ("Search AutoEQ models (" .. #catalog .. ")") or "Search AutoEQ models" },
        { label = "Refresh catalog" },
        { label = "Cancel current task" },
        { label = "About and sources" },
    }
    local handle
    handle = plugin.show_list("AutoEQ", items, function(index)
        if index == 1 then
            plugin.show_text_input("Search AutoEQ", nil, false, function(query) run_search(query) end)
        elseif index == 2 then
            begin_catalog_request(function(offline)
                plugin.show_toast((offline and "Using saved catalog: " or "Catalog updated: ") .. #catalog .. " models")
            end, handle)
        elseif index == 3 then
            if task_handle then cancel_task(); plugin.show_toast("AutoEQ task cancelled")
            else plugin.show_toast("No AutoEQ task is running") end
        elseif index == 4 then
            plugin.show_text_view("AutoEQ sources", "AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it.")
        end
    end)
    active_screen = handle
end

plugin.register_list_item("music_audio", "AutoEQ", show_home)
