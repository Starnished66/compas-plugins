plugin.define({
    id = "compas.track_inspector",
    name = "Track Inspector",
    version = "1.4",
    api_min = 16,
})

-- Track Inspector
-- Inspects audio playback format snapshots, output route and hardware sink info,
-- parametric EQ and DSP signal chain status, bit-perfect PCM candidate criteria,
-- and local file headers for WAV, FLAC, and AIFF.

local HEADER_READ_LIMIT = 4096
local FLOAT_TOLERANCE = 1e-6

local settings = {
    show_full_path = false,
    show_db_tags = true,
}

local function load_settings()
    if plugin.has_capability("storage.namespaced") and plugin.storage then
        local ok, val = pcall(plugin.storage.get, "show_full_path", "0")
        if ok and val == "1" then settings.show_full_path = true end
        local ok_tags, val_tags = pcall(plugin.storage.get, "show_db_tags", "1")
        if ok_tags and val_tags == "0" then settings.show_db_tags = false end
    end
end

local function save_setting(key, val)
    if plugin.has_capability("storage.namespaced") and plugin.storage then
        pcall(plugin.storage.set, key, val)
    end
end

load_settings()

--------------------------------------------------------------------------------
-- String, Path and Numerical Formatting Helpers
--------------------------------------------------------------------------------

local function is_valid_number(n)
    return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end

local function has_capability(name)
    if type(plugin.has_capability) ~= "function" then return false end
    local ok, supported = pcall(plugin.has_capability, name)
    return ok and supported == true
end

local function format_hz(hz)
    if not is_valid_number(hz) or hz <= 0 then return "Unknown" end
    if hz % 1000 == 0 then
        return string.format("%.1f kHz (%d Hz)", hz / 1000, math.floor(hz))
    elseif hz % 100 == 0 then
        return string.format("%.1f kHz (%d Hz)", hz / 1000, math.floor(hz))
    else
        return string.format("%.2f kHz (%d Hz)", hz / 1000, math.floor(hz))
    end
end

local function format_depth(bits)
    if not is_valid_number(bits) or bits <= 0 then return "Unknown / not reported" end
    return string.format("%d-bit", math.floor(bits))
end

local function format_channels(ch)
    if not is_valid_number(ch) or ch <= 0 then return "Unknown" end
    ch = math.floor(ch)
    if ch == 1 then return "1 (Mono)" end
    if ch == 2 then return "2 (Stereo)" end
    if ch > 2 then return string.format("%d channels", ch) end
    return "Unknown"
end

local function format_bitrate(kbps)
    if not is_valid_number(kbps) or kbps <= 0 then return "Unknown" end
    return string.format("%d kbps", math.floor(kbps))
end

local function format_duration(sec)
    if not is_valid_number(sec) or sec < 0 then return "Unknown" end
    if sec == 0 then return "Live or unknown length" end
    if sec >= 3600 then
        return string.format("%d:%02d:%02d", math.floor(sec / 3600), math.floor(sec / 60) % 60, math.floor(sec) % 60)
    end
    local m = math.floor(sec / 60)
    local s = math.floor(sec % 60)
    return string.format("%d:%02d (%d s)", m, s, math.floor(sec))
end

local function format_gain_db(gain_linear)
    if not is_valid_number(gain_linear) or gain_linear <= 0 then return "-inf dB" end
    local db = 20 * (math.log(gain_linear) / math.log(10))
    return string.format("%+.2f dB", db)
end

local function basename(path)
    if not path or path == "" then return "" end
    return path:match("([^/\\]+)$") or path
end

local function is_remote_url(path)
    if type(path) ~= "string" then return false end
    return path:match("^%a[%w+%.%-]*://") ~= nil
end

local function sanitize_path(path)
    if type(path) ~= "string" or path == "" then return "" end
    if is_remote_url(path) then
        local clean = path:gsub("[?#].*$", "")
        local scheme, authority, suffix = clean:match("^(%a[%w+.-]*://)([^/]*)(.*)$")
        if scheme and authority then
            local last_at = authority:match(".*()@")
            if last_at then authority = authority:sub(last_at + 1) end
            clean = scheme .. authority .. suffix
        end
        return clean
    end
    return path
end

local function safe_display_path(path, show_full)
    if type(path) ~= "string" or path == "" then return "" end
    local clean = sanitize_path(path)
    if not show_full then
        if is_remote_url(clean) then
            local name = clean:match("([^/]+)$")
            return name or clean
        else
            return basename(clean)
        end
    end
    return clean
end

local function is_within_sd(path, sd_root)
    if type(path) ~= "string" or type(sd_root) ~= "string" or path == "" or sd_root == "" then
        return false
    end
    if is_remote_url(path) then return false end
    local clean_root = sd_root:gsub("/+$", "")
    if path ~= clean_root and not path:find("^" .. clean_root:gsub("([^%w])", "%%%1") .. "/") then
        return false
    end
    if path:find("/%.%./") or path:find("/%.%.$") or path:find("^%.%./") then
        return false
    end
    return true
end

--------------------------------------------------------------------------------
-- Binary Header Parsers (Bounded reads: WAV, FLAC, AIFF)
--------------------------------------------------------------------------------

local function read_u16_le(bytes, offset)
    local b1, b2 = bytes:byte(offset, offset + 1)
    if not b1 or not b2 then return nil end
    return b1 | (b2 << 8)
end

local function read_u32_le(bytes, offset)
    local b1, b2, b3, b4 = bytes:byte(offset, offset + 3)
    if not b1 or not b4 then return nil end
    return b1 | (b2 << 8) | (b3 << 16) | (b4 << 24)
end

local function read_u16_be(bytes, offset)
    local b1, b2 = bytes:byte(offset, offset + 1)
    if not b1 or not b2 then return nil end
    return (b1 << 8) | b2
end

local function read_u32_be(bytes, offset)
    local b1, b2, b3, b4 = bytes:byte(offset, offset + 3)
    if not b1 or not b4 then return nil end
    return (b1 << 24) | (b2 << 16) | (b3 << 8) | b4
end

local function decode_ieee_extended(bytes, offset)
    if not bytes or #bytes < offset + 9 then return nil end
    local b1, b2 = bytes:byte(offset, offset + 1)
    local sign = (b1 & 0x80) ~= 0
    local exp = ((b1 & 0x7F) << 8) | b2
    local b3, b4, b5, b6, b7, b8, b9, b10 = bytes:byte(offset + 2, offset + 9)
    if exp == 0 and b3 == 0 and b4 == 0 then return 0 end
    if exp == 0x7FFF then return nil end
    local f_mantissa = (b3 * (2.0 ^ -7))
                     + (b4 * (2.0 ^ -15))
                     + (b5 * (2.0 ^ -23))
                     + (b6 * (2.0 ^ -31))
                     + (b7 * (2.0 ^ -39))
                     + (b8 * (2.0 ^ -47))
                     + (b9 * (2.0 ^ -55))
                     + (b10 * (2.0 ^ -63))
    local rate = (2.0 ^ (exp - 16383)) * f_mantissa
    if sign then rate = -rate end
    return math.floor(rate + 0.5)
end

local function parse_local_file_header(path)
    if type(path) ~= "string" or path == "" then
        return nil, "Invalid file path"
    end
    if is_remote_url(path) then
        return nil, "Remote streams do not support direct file header inspection; format provided by decoder snapshot"
    end
    if plugin.sd_root and not is_within_sd(path, plugin.sd_root()) then
        return nil, "Path is outside SD root"
    end

    local f, err = io.open(path, "rb")
    if not f then
        return nil, "Could not open file: " .. tostring(err)
    end

    local file_size = f:seek("end") or 0
    f:seek("set", 0)
    local buf = f:read(HEADER_READ_LIMIT)
    f:close()

    if not buf or #buf < 12 then
        return nil, "Truncated file header (less than 12 bytes)"
    end

    -- 1. WAV Detection (RIFF/RIFX .... WAVE)
    local riff_id = buf:sub(1, 4)
    if (riff_id == "RIFF" or riff_id == "RIFX") and buf:sub(9, 12) == "WAVE" then
        local is_be = (riff_id == "RIFX")
        local offset = 13
        local fmt_found = false
        local audio_format, channels, sample_rate, byte_rate, bit_depth, extensible_subfmt
        local data_size = nil

        while offset + 8 <= #buf do
            local chunk_id = buf:sub(offset, offset + 3)
            local chunk_len = is_be and read_u32_be(buf, offset + 4) or read_u32_le(buf, offset + 4)
            if not chunk_len or chunk_len < 0 then break end
            local data_offset = offset + 8

            if chunk_id == "fmt " and chunk_len >= 16 then
                if data_offset + 16 > #buf + 1 then break end
                audio_format = is_be and read_u16_be(buf, data_offset) or read_u16_le(buf, data_offset)
                channels = is_be and read_u16_be(buf, data_offset + 2) or read_u16_le(buf, data_offset + 2)
                sample_rate = is_be and read_u32_be(buf, data_offset + 4) or read_u32_le(buf, data_offset + 4)
                byte_rate = is_be and read_u32_be(buf, data_offset + 8) or read_u32_le(buf, data_offset + 8)
                bit_depth = is_be and read_u16_be(buf, data_offset + 14) or read_u16_le(buf, data_offset + 14)
                if audio_format == 0xFFFE and chunk_len >= 40 and data_offset + 26 <= #buf then
                    extensible_subfmt = is_be and read_u16_be(buf, data_offset + 24) or read_u16_le(buf, data_offset + 24)
                end
                fmt_found = true
            elseif chunk_id == "data" then
                data_size = chunk_len
            end

            offset = data_offset + chunk_len + (chunk_len % 2)
        end

        if not fmt_found or not sample_rate or not channels or not bit_depth then
            return nil, "Malformed WAV: missing or truncated fmt chunk"
        end
        if sample_rate <= 0 or channels <= 0 or bit_depth <= 0 then
            return nil, "Malformed WAV: invalid audio parameters"
        end

        local codec, format_name, is_compressed
        if audio_format == 1 then
            codec = "pcm"
            format_name = "WAV (PCM Integer)"
            is_compressed = false
        elseif audio_format == 3 then
            codec = "wav_float"
            format_name = "WAV (IEEE Float)"
            is_compressed = false
        elseif audio_format == 0xFFFE then
            if extensible_subfmt == 1 then
                codec = "pcm"
                format_name = "WAV (Extensible PCM)"
                is_compressed = false
            elseif extensible_subfmt == 3 then
                codec = "wav_float"
                format_name = "WAV (Extensible Float)"
                is_compressed = false
            else
                codec = "wav_compressed"
                format_name = string.format("WAV (Compressed Extensible: 0x%04X)", extensible_subfmt or 0)
                is_compressed = true
            end
        else
            codec = "wav_compressed"
            format_name = string.format("WAV (Compressed: format 0x%04X)", audio_format)
            is_compressed = true
        end

        local duration = 0
        local bitrate_kbps = 0
        if not is_compressed then
            if data_size and byte_rate and byte_rate > 0 then
                duration = data_size / byte_rate
            elseif file_size > 44 and byte_rate and byte_rate > 0 then
                duration = (file_size - 44) / byte_rate
            end
            bitrate_kbps = math.floor((sample_rate * channels * bit_depth) / 1000)
        else
            if file_size > 0 and duration > 0 then
                bitrate_kbps = math.floor((file_size * 8) / (duration * 1000))
            end
        end

        return {
            codec = codec,
            format_name = format_name,
            sample_rate = sample_rate,
            bit_depth = bit_depth,
            channels = channels,
            duration_seconds = duration,
            bitrate_kbps = bitrate_kbps,
            file_size = file_size,
            is_compressed = is_compressed,
        }
    end

    -- 2. FLAC Detection ("fLaC")
    if buf:sub(1, 4) == "fLaC" then
        if #buf < 42 then
            return nil, "Truncated FLAC STREAMINFO header (less than 42 bytes)"
        end
        local block_header = buf:byte(5)
        local block_type = block_header & 0x7F
        if block_type ~= 0 then
            return nil, "Malformed FLAC: first metadata block must be STREAMINFO"
        end
        local block_len = (buf:byte(6) << 16) | (buf:byte(7) << 8) | buf:byte(8)
        if block_len < 34 then
            return nil, "Malformed FLAC: STREAMINFO block length too small"
        end

        local b1, b2, b3, b4, b5, b6, b7, b8 = buf:byte(19, 26)
        local sample_rate = (b1 << 12) | (b2 << 4) | (b3 >> 4)
        local channels = ((b3 >> 1) & 0x07) + 1
        local bit_depth = (((b3 & 0x01) << 4) | (b4 >> 4)) + 1
        local total_samples = ((b4 & 0x0F) * 4294967296) + (b5 << 24) + (b6 << 16) + (b7 << 8) + b8

        if sample_rate <= 0 or channels <= 0 or bit_depth <= 0 then
            return nil, "Malformed FLAC: invalid audio parameters in STREAMINFO"
        end

        local duration = (sample_rate > 0 and total_samples > 0) and (total_samples / sample_rate) or 0
        local bitrate_kbps = 0
        if file_size > 0 and duration > 0 then
            bitrate_kbps = math.floor((file_size * 8) / (duration * 1000))
        end

        return {
            codec = "flac",
            format_name = "FLAC (Free Lossless Audio Codec)",
            sample_rate = sample_rate,
            bit_depth = bit_depth,
            channels = channels,
            duration_seconds = duration,
            bitrate_kbps = bitrate_kbps,
            file_size = file_size,
            total_samples = total_samples,
            is_compressed = true,
        }
    end

    -- 3. AIFF / AIFC Detection ("FORM" .... "AIFF" or "AIFC")
    if buf:sub(1, 4) == "FORM" and (buf:sub(9, 12) == "AIFF" or buf:sub(9, 12) == "AIFC") then
        local is_aifc = (buf:sub(9, 12) == "AIFC")
        local offset = 13
        local comm_found = false
        local channels, sample_frames, bit_depth, sample_rate
        local compression_type = is_aifc and "NONE" or "NONE"

        while offset + 8 <= #buf do
            local chunk_id = buf:sub(offset, offset + 3)
            local chunk_len = read_u32_be(buf, offset + 4)
            if not chunk_len or chunk_len < 0 then break end
            local data_offset = offset + 8

            if chunk_id == "COMM" and chunk_len >= 18 then
                if data_offset + 18 > #buf + 1 then break end
                channels = read_u16_be(buf, data_offset)
                sample_frames = read_u32_be(buf, data_offset + 2)
                bit_depth = read_u16_be(buf, data_offset + 6)
                sample_rate = decode_ieee_extended(buf, data_offset + 8)
                if is_aifc and chunk_len >= 22 and data_offset + 22 <= #buf + 1 then
                    compression_type = buf:sub(data_offset + 18, data_offset + 21)
                end
                comm_found = true
                break
            end

            offset = data_offset + chunk_len + (chunk_len % 2)
        end

        if not comm_found or not sample_rate or not channels or not bit_depth then
            return nil, "Malformed AIFF: missing or truncated COMM chunk"
        end
        if sample_rate <= 0 or channels <= 0 or bit_depth <= 0 then
            return nil, "Malformed AIFF: invalid audio parameters"
        end

        local codec, format_name, is_compressed
        if not is_aifc then
            codec = "pcm"
            format_name = "AIFF (PCM)"
            is_compressed = false
        else
            if compression_type == "NONE" then
                codec = "pcm"
                format_name = "AIFC (PCM)"
                is_compressed = false
            elseif compression_type == "sowt" then
                codec = "pcm"
                format_name = "AIFC (Little-Endian PCM)"
                is_compressed = false
            elseif compression_type == "fl32" or compression_type == "fl64" then
                codec = "aifc_float"
                format_name = "AIFC (Float)"
                is_compressed = false
            else
                codec = "aifc_compressed"
                format_name = "AIFC (Compressed: " .. compression_type .. ")"
                is_compressed = true
            end
        end

        local duration = (sample_rate > 0 and sample_frames and sample_frames > 0) and (sample_frames / sample_rate) or 0
        local bitrate_kbps = 0
        if not is_compressed then
            bitrate_kbps = math.floor((sample_rate * channels * bit_depth) / 1000)
        else
            if file_size > 0 and duration > 0 then
                bitrate_kbps = math.floor((file_size * 8) / (duration * 1000))
            end
        end

        return {
            codec = codec,
            format_name = format_name,
            sample_rate = sample_rate,
            bit_depth = bit_depth,
            channels = channels,
            duration_seconds = duration,
            bitrate_kbps = bitrate_kbps,
            file_size = file_size,
            is_compressed = is_compressed,
        }
    end

    return nil, "Unknown header format (inspection limited to WAV, FLAC, AIFF headers; formats are not inferred from suffix)"
end

--------------------------------------------------------------------------------
-- Bit-Perfect Candidate Evaluation
--------------------------------------------------------------------------------

-- audio.crossfeed predates independent bypass behavior. The stock-MSEB
-- capability identifies the first firmware boundary that guarantees it;
-- older API 16 releases still bypass crossfeed with the manual EQ.
local function crossfeed_runs_when_bypassed()
    return has_capability("audio.mseb.stock")
end

local MSEB_FIELDS = {
    "temperature", "bass_ext", "bass_texture", "thickness", "vocal_pos",
    "female_vocal", "sibilance_lf", "sibilance_hf", "impulse_tone", "air",
}

local function get_mseb_snapshot()
    local cap_ok, supported = pcall(plugin.has_capability, "audio.mseb.stock")
    if not cap_ok or not supported or type(plugin.get_mseb_state) ~= "function" then
        return nil, false
    end
    local ok, state = pcall(plugin.get_mseb_state)
    if not ok or type(state) ~= "table" or type(state.enabled) ~= "boolean" then
        return nil, true
    end
    return state, true
end

local function mseb_has_effect(state)
    if type(state) ~= "table" then return nil end
    for _, field in ipairs(MSEB_FIELDS) do
        local value = state[field]
        if not is_valid_number(value) or value < -100 or value > 100 or value % 1 ~= 0 then
            return nil
        end
        if value ~= 0 then return true end
    end
    local width = state.width
    if not is_valid_number(width) or width < 0 or width > 2 then return nil end
    return width ~= 1
end

local function assess_bit_perfect(fmt, out, eq, mseb, mseb_supported)
    if not fmt then
        return {
            status = "No Active Playback",
            is_candidate = false,
            reasons = { "Audio engine is idle; no active playback stream to inspect." },
            notes = {},
        }
    end

    local reasons = {}
    local notes = {}

    -- Codec validation
    local codec = fmt.codec and tostring(fmt.codec):lower() or "unknown"
    if codec == "" or codec == "unknown" then
        table.insert(reasons, "Source codec is unknown.")
    end
    if codec == "wavpack" then
        table.insert(reasons, "WavPack lossless or hybrid mode and correction-file status are unreported.")
    end

    -- Required source & output format dimensions
    local src_rate = fmt.sample_rate
    local out_rate = fmt.output_sample_rate
    local src_depth = fmt.bit_depth
    local out_depth = fmt.output_bit_depth
    local channels = fmt.channels

    if not is_valid_number(src_rate) or src_rate <= 0 then
        table.insert(reasons, "Source sample rate is unknown or invalid.")
    end
    if not is_valid_number(out_rate) or out_rate <= 0 then
        table.insert(reasons, "Output sample rate is unknown or invalid.")
    end
    if not is_valid_number(channels) or channels <= 0 then
        table.insert(reasons, "Source channels count is unknown or invalid.")
    end

    -- Required sink presence
    if not out or out.active ~= true then
        table.insert(reasons, "Output is inactive or its state is unknown.")
    end

    -- Route check
    local route = out and out.route or "unknown"
    if route == "bluetooth" then
        local bt_codec = (out and out.bluetooth_codec) or "Unknown / Negotiating"
        table.insert(reasons, string.format("Bluetooth encoding can change the audio (%s); the receiving device's final output is not visible here.", bt_codec))
    elseif route == "usb_dac" then
        table.insert(reasons, "Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output.")
    elseif route ~= "wired" then
        table.insert(reasons, "The active output route is unknown.")
    end

    local hardware_format_known = out and (is_valid_number(out.hardware_sample_rate) and out.hardware_sample_rate > 0
        and is_valid_number(out.hardware_bit_depth) and out.hardware_bit_depth > 0)
    if out then
        if out.resampling_known then
            if out.resampling then
                table.insert(reasons, "The player reports different engine and output sample rates.")
            end
        else
            table.insert(reasons, "The player cannot compare the engine and output sample rates.")
        end
        if not hardware_format_known then
            table.insert(reasons, "The local output format is not reported by the player.")
        elseif is_valid_number(out_depth) and out.hardware_bit_depth ~= out_depth then
            table.insert(reasons, string.format("Output depth differs: audio engine %d-bit -> player-reported %d-bit.", out_depth, out.hardware_bit_depth))
        end
    end

    -- Native DoP vs DSD-to-PCM Decimation
    local is_true_dop = (fmt.dop == true)
    if is_true_dop then
        if codec ~= "dsd" then
            table.insert(reasons, "DoP active but codec is not DSD.")
        end
        local expected_carrier_rate = is_valid_number(src_rate) and (src_rate / 16) or 0
        if not is_valid_number(out_rate) or math.abs(out_rate - expected_carrier_rate) > FLOAT_TOLERANCE then
            table.insert(reasons, string.format("DoP carrier rate mismatch: expected %.1f kHz for DSD, got %s.", expected_carrier_rate / 1000, format_hz(out_rate)))
        end
        if not is_valid_number(out_depth) or out_depth < 24 then
            table.insert(reasons, string.format("DoP carrier depth insufficient: got %s (requires 24-bit carrier).", format_depth(out_depth)))
        end
        if not out or out.dop ~= true then
            table.insert(reasons, "Output sink DoP flag is not active.")
        end
        if hardware_format_known and is_valid_number(out.hardware_sample_rate) and math.abs(out.hardware_sample_rate - expected_carrier_rate) > FLOAT_TOLERANCE then
            table.insert(reasons, string.format("Player-reported output rate does not match the DoP carrier: %d Hz vs %.0f Hz.", out.hardware_sample_rate, expected_carrier_rate))
        end

        table.insert(notes, string.format("DoP carrier framing: %s 1-bit DSD stream packaged into %s %s PCM carrier frames; PCM DSP chain bypassed.",
            format_hz(src_rate), format_hz(out_rate), format_depth(out_depth)))
    elseif fmt.is_dsd then
        table.insert(reasons, "DSD stream converted to PCM (decimation active; not native DSD direct passthrough).")
        table.insert(notes, "DSD-to-PCM decimation active: DSD bitstream is converted to PCM and subject to PCM DSP filtering.")
    end

    -- PCM specific validation
    if not is_true_dop then
        if not is_valid_number(src_depth) or src_depth <= 0 then
            table.insert(reasons, "Source bit depth is unknown or lossy (no original PCM depth).")
        end
        if not is_valid_number(out_depth) or out_depth <= 0 then
            table.insert(reasons, "Output bit depth is unknown or invalid.")
        end

        if codec == "mp3" or codec == "aac" or codec == "opus" or codec == "vorbis" or codec == "wma" then
            table.insert(reasons, string.format("Source codec is lossy (%s): lossy decoding cannot certify bit-perfect reproduction of original PCM master.", codec:upper()))
        end

        if is_valid_number(src_rate) and is_valid_number(out_rate) and math.abs(src_rate - out_rate) > FLOAT_TOLERANCE then
            table.insert(reasons, string.format("Resampling active: source %d Hz -> output %d Hz.", math.floor(src_rate), math.floor(out_rate)))
        end

        if hardware_format_known and is_valid_number(out.hardware_sample_rate) and is_valid_number(src_rate) and math.abs(out.hardware_sample_rate - src_rate) > FLOAT_TOLERANCE then
            table.insert(reasons, string.format("Player-reported output rate differs from source: %d Hz -> %d Hz.", math.floor(src_rate), math.floor(out.hardware_sample_rate)))
        end

        if is_valid_number(src_depth) and is_valid_number(out_depth) and src_depth ~= out_depth then
            if src_depth > out_depth then
                table.insert(reasons, string.format("Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss).", math.floor(src_depth), math.floor(out_depth)))
            else
                table.insert(reasons, string.format("Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified).", math.floor(src_depth), math.floor(out_depth)))
            end
        end

        -- Stock MSEB replaces manual EQ, preamp and stereo width while active.
        local mseb_enabled = mseb_supported and mseb and mseb.enabled == true
        if mseb_supported and not mseb then
            table.insert(reasons, "Stock MSEB state is unavailable; cannot verify the PCM processing path.")
        elseif mseb_enabled then
            local mseb_effect = mseb_has_effect(mseb)
            if mseb_effect == true then
                table.insert(reasons, "Stock MSEB processing is enabled with non-neutral settings.")
            elseif mseb_effect == nil then
                table.insert(reasons, "Stock MSEB settings are incomplete or invalid; cannot verify a neutral PCM path.")
            end
        end

        -- Parametric EQ & Stereo Width
        if not eq or type(eq.bypass) ~= "boolean" then
            table.insert(reasons, "Equalizer state unavailable or unqueried; cannot verify flat DSP path.")
        elseif eq.bypass == true then
            local crossfeed_independent = crossfeed_runs_when_bypassed()
            table.insert(notes, crossfeed_independent
                and "Equalizer bypass is active; preamp, stereo width, and band filters are skipped. Crossfeed remains independent."
                or "Equalizer bypass is active; preamp, stereo width, crossfeed, and band filters are skipped.")
            if crossfeed_independent then
                local crossfeed = eq.crossfeed
                if not is_valid_number(crossfeed) and (not is_valid_number(channels) or channels == 2) then
                    table.insert(reasons, "Headphone crossfeed state is unknown.")
                elseif is_valid_number(crossfeed) and (not is_valid_number(channels) or channels == 2) and crossfeed > 0 then
                    table.insert(reasons, string.format("Headphone crossfeed is active at %.2f strength.", crossfeed))
                end
            end
        else
            if mseb_enabled then
                table.insert(notes, "Manual EQ bands, preamp, and stereo width are overridden by stock MSEB while it is enabled.")
            else
                local preamp = eq.preamp_db
                if not is_valid_number(preamp) then
                    table.insert(reasons, "EQ preamp gain is unknown or invalid.")
                elseif preamp ~= 0 then
                    table.insert(reasons, string.format("EQ digital preamp gain active: %+.2f dB.", preamp))
                end
            end

            local width = eq.stereo_width
            if not mseb_enabled then
                if not is_valid_number(width) and (not is_valid_number(channels) or channels == 2) then
                    table.insert(reasons, "Stereo width is unknown or invalid.")
                elseif (not is_valid_number(channels) or channels == 2) and width ~= 1.0 then
                    table.insert(reasons, string.format("Stereo width processing is active: %.4f.", width))
                end
            end

            local crossfeed = eq.crossfeed
            if not is_valid_number(crossfeed) and (not is_valid_number(channels) or channels == 2) then
                table.insert(reasons, "Headphone crossfeed state is unknown.")
            elseif is_valid_number(crossfeed) and (not is_valid_number(channels) or channels == 2) and crossfeed > 0 then
                table.insert(reasons, string.format("Headphone crossfeed is active at %.2f strength.", crossfeed))
            end

            local active_bands = 0
            if mseb_enabled then
                -- The manual bands remain stored but do not affect output.
            elseif type(eq.bands) == "table" then
                if #eq.bands ~= 10 then table.insert(reasons, "The full equalizer band state is unavailable.") end
                for _, band in ipairs(eq.bands) do
                    if band.enabled == nil then
                        table.insert(reasons, "An EQ band's enabled state is unknown.")
                    elseif band.enabled then
                        local band_type = type(band.type) == "string" and band.type:lower() or "unknown"
                        if band_type ~= "peaking" and band_type ~= "low_shelf" and band_type ~= "high_shelf" then
                            table.insert(reasons, "An enabled EQ band has an unrecognized filter type; its effect is unknown.")
                        elseif not is_valid_number(band.gain_db) then
                            table.insert(reasons, "An enabled EQ filter has unknown gain.")
                        else
                            active_bands = active_bands + 1
                        end
                    end
                end
            else
                table.insert(reasons, "EQ bands configuration missing.")
            end
            if active_bands > 0 then
                table.insert(reasons, string.format("Parametric EQ has %d enabled band(s); filter processing and peak protection may affect samples even with a flat response.", active_bands))
            end
        end

        -- Software Volume Gain
        local soft_gain = fmt.software_volume_gain
        if not is_valid_number(soft_gain) then
            table.insert(reasons, "Software volume state unavailable or invalid; cannot verify unity gain.")
        elseif soft_gain ~= 1.0 then
            table.insert(reasons, string.format("Software volume scaling active: %.6fx (%s digital modification).", soft_gain, format_gain_db(soft_gain)))
        else
            table.insert(notes, "Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling).")
        end

        -- Playback Speed
        local speed = fmt.playback_speed
        if not is_valid_number(speed) then
            table.insert(reasons, "Playback speed state unavailable or invalid.")
        elseif speed ~= 1.0 then
            table.insert(reasons, string.format("Playback speed modified: %.4fx (time-stretching DSP active).", speed))
        end

        -- ReplayGain
        if fmt.replaygain_applied == nil then
            table.insert(reasons, "ReplayGain state unavailable.")
        elseif fmt.replaygain_applied == true then
            local rg_db = fmt.replaygain_applied_db
            if not is_valid_number(rg_db) then
                table.insert(reasons, "ReplayGain was reported as applied, but its gain amount is unknown.")
            elseif rg_db ~= 0 then
                table.insert(reasons, string.format("ReplayGain scaling applied: %+.2f dB.", rg_db))
            end
        end

        if fmt.crossfade_enabled then
            table.insert(reasons, "Crossfade is enabled; the player does not report whether tracks are currently being mixed.")
        end
    else
        table.insert(notes, "Native DoP hardware stream bypasses PCM Equalizer, stock MSEB, stereo width, and software volume.")
    end

    local status, is_candidate
    if #reasons == 0 and route == "wired" and hardware_format_known then
        if is_true_dop then
            status = "No changes detected (wired DoP candidate)"
        else
            status = "No changes detected (wired PCM candidate)"
        end
        is_candidate = true
        table.insert(notes, "No changes detected in the observable playback stages. Hardware certification is not available from this snapshot.")
    elseif route == "bluetooth" or route == "usb_dac" then
        status = route == "bluetooth" and "Bluetooth can change audio" or "USB output cannot be fully checked"
        is_candidate = false
    elseif out and out.active ~= true then
        status = "Output is inactive"
        is_candidate = false
    else
        status = "Changes detected or information unavailable"
        is_candidate = false
    end

    return {
        status = status,
        is_candidate = is_candidate,
        reasons = reasons,
        notes = notes,
        route = route,
    }
end

--------------------------------------------------------------------------------
-- Live State Snapshot Providers
--------------------------------------------------------------------------------

local function get_format_snapshot()
    if not plugin.has_capability("playback.format") or not plugin.get_playback_format then
        return nil, "playback.format capability not available"
    end
    local f = plugin.get_playback_format()
    if not f then return nil, "Audio engine is idle" end
    return f
end

local function get_output_snapshot()
    if not plugin.has_capability("playback.output_info") or not plugin.get_output_info then
        return nil, "playback.output_info capability not available"
    end
    return plugin.get_output_info()
end

local function get_live_eq()
    if not plugin.has_capability("audio.peq.state") or not plugin.get_eq_state then
        return nil, "audio.peq.state capability not available"
    end
    return plugin.get_eq_state()
end
local get_eq_snapshot = get_live_eq

local function get_track_metadata(path)
    if not path or is_remote_url(path) then return nil end
    if not plugin.has_capability("library.track_metadata") or not plugin.get_track_metadata then
        return nil
    end
    return plugin.get_track_metadata(path)
end

local CODEC_NAMES = {
    flac = "FLAC (Free Lossless Audio Codec)", mp3 = "MP3", pcm = "PCM audio",
    dsd = "DSD audio", aac = "AAC", alac = "ALAC (Apple Lossless)",
    ape = "Monkey's Audio", wma = "Windows Media Audio", opus = "Opus",
    vorbis = "Vorbis", wavpack = "WavPack", unknown = "Unknown codec",
}

local function codec_name(codec)
    local key = type(codec) == "string" and codec:lower() or "unknown"
    return CODEC_NAMES[key] or key
end

local function source_quality(codec)
    codec = type(codec) == "string" and codec:lower() or "unknown"
    if codec == "flac" or codec == "alac" or codec == "ape" then return "Lossless compression" end
    if codec == "pcm" then return "Uncompressed PCM" end
    if codec == "dsd" then return "One-bit DSD audio" end
    if codec == "mp3" or codec == "aac" or codec == "opus" or codec == "vorbis" or codec == "wma" then return "Lossy" end
    if codec == "wavpack" or codec == "unknown" or codec == "" then return "Unknown (mode not reported)" end
    return "Not classified by this inspector"
end

local function safe_call(name, ...)
    local fn = plugin[name]
    if type(fn) ~= "function" then return nil end
    local ok, value = pcall(fn, ...)
    if ok then return value end
    return nil
end

local function safe_call_all(name, ...)
    local fn = plugin[name]
    if type(fn) ~= "function" then return nil end
    local result = table.pack(pcall(fn, ...))
    if not result[1] then return nil end
    local values = { n = result.n - 1 }
    for i = 2, result.n do values[i - 1] = result[i] end
    return values
end

local function first_text(...)
    for i = 1, select("#", ...) do
        local value = select(i, ...)
        if type(value) == "string" and value ~= "" then return value end
    end
    return nil
end

local function yes_no_unknown(value)
    if value == true then return "Yes" end
    if value == false then return "No" end
    return "Unknown"
end

local function playback_position()
    local pos = safe_call("get_position")
    local duration = safe_call("get_duration")
    if not is_valid_number(pos) or pos < 0 then return "Unknown" end
    local function clock(sec)
        sec = math.floor(sec)
        if sec >= 3600 then return string.format("%d:%02d:%02d", math.floor(sec / 3600), math.floor(sec / 60) % 60, sec % 60) end
        return string.format("%d:%02d", math.floor(sec / 60), sec % 60)
    end
    if is_valid_number(duration) and duration > 0 then return clock(pos) .. " / " .. clock(duration) end
    return clock(pos) .. " elapsed"
end

local function playback_state()
    local playing, paused = safe_call("is_playing"), safe_call("is_paused")
    if playing == true then return "Playing" end
    if paused == true then return "Paused" end
    if playing == false and paused == false then return "Stopped" end
    return "Unknown"
end

local function file_size(path)
    if type(path) ~= "string" or path == "" or is_remote_url(path) then return nil end
    local f = io.open(path, "rb")
    if not f then return nil end
    local size = f:seek("end")
    f:close()
    if is_valid_number(size) and size >= 0 then return size end
    return nil
end

local function format_file_size(size)
    if not is_valid_number(size) then return "Unknown" end
    if size < 1024 then return string.format("%d bytes", size) end
    if size < 1024 * 1024 then return string.format("%.1f KiB", size / 1024) end
    if size < 1024 * 1024 * 1024 then return string.format("%.2f MiB", size / (1024 * 1024)) end
    return string.format("%.2f GiB", size / (1024 * 1024 * 1024))
end

--------------------------------------------------------------------------------
-- UI Screens and Navigation (In-place replacement via ui.list_update)
--------------------------------------------------------------------------------

local show_format_screen
local show_output_screen
local show_dsp_screen
local show_bitperfect_screen
local show_file_inspector
local show_file_details
local show_settings_screen

-- 1. Format Snapshot Screen
show_format_screen = function(replace_handle)
    local fmt = get_format_snapshot()
    local out = get_output_snapshot()
    local rows = {}

    table.insert(rows, { label = "Refresh playback details", text_size = "medium" })
    table.insert(rows, { label = "Playback: " .. playback_state() .. " · " .. playback_position(), wrap = true })
    local now = safe_call_all("get_now_playing") or {}
    local now_title, now_artist, now_album, now_duration = now[1], now[2], now[3], now[4]
    local source_path = first_text(fmt and fmt.path, safe_call("get_current_track_path"))
    local source_is_stream = (fmt and fmt.is_stream == true) or is_remote_url(source_path)
    local meta = source_path and settings.show_db_tags and not source_is_stream and get_track_metadata(source_path) or nil
    local title = first_text(meta and meta.title, now_title)
    if title and is_remote_url(title) then title = sanitize_path(title) end
    local artist = first_text(meta and meta.artist, now_artist)
    local album = first_text(meta and meta.album, now_album)
    if title and title ~= "" then table.insert(rows, { label = "Title: " .. title, text_size = "medium", wrap = true }) end
    if artist and artist ~= "" then table.insert(rows, { label = "Artist: " .. artist, wrap = true }) end
    if meta and meta.album_artist and meta.album_artist ~= "" then table.insert(rows, { label = "Album artist: " .. meta.album_artist, wrap = true }) end
    if album and album ~= "" then table.insert(rows, { label = "Album: " .. album, wrap = true }) end
    if meta and meta.genre and meta.genre ~= "" then table.insert(rows, { label = "Genre: " .. meta.genre, wrap = true }) end
    if source_path then
        table.insert(rows, { label = "Source: " .. (source_is_stream and "Network stream" or "Local file") .. " · " .. safe_display_path(source_path, settings.show_full_path), wrap = true })
        if not source_is_stream then
            table.insert(rows, { label = "File size: " .. format_file_size(file_size(source_path)), wrap = true })
            local header = parse_local_file_header(source_path)
            if header then
                table.insert(rows, { label = "File header: " .. header.format_name .. " · " .. format_hz(header.sample_rate) .. " · " .. format_depth(header.bit_depth), wrap = true })
            end
        end
    end

    if not fmt then
        table.insert(rows, { label = "Audio format: Unknown (no active decoder snapshot)", wrap = true })
        table.insert(rows, { label = "Start or resume playback to inspect the decoder's live format.", wrap = true })
    else
        table.insert(rows, { label = "Codec: " .. codec_name(fmt.codec), text_size = "medium", wrap = true })
        table.insert(rows, { label = "Source quality: " .. source_quality(fmt.codec), wrap = true })
        table.insert(rows, { label = "Source audio: " .. format_hz(fmt.sample_rate) .. " · " .. format_depth(fmt.bit_depth) .. " · " .. format_channels(fmt.channels), wrap = true })
        table.insert(rows, { label = "Bitrate: " .. format_bitrate(fmt.bitrate_kbps), wrap = true })
        local duration = is_valid_number(fmt.duration_seconds) and fmt.duration_seconds > 0 and fmt.duration_seconds or now_duration
        table.insert(rows, { label = "Length: " .. format_duration(duration) .. " · " .. (fmt.seekable == true and "seekable" or fmt.seekable == false and "forward-only" or "seek status unknown"), wrap = true })
        if fmt.dop then
            table.insert(rows, { label = "DSD-over-PCM carrier is active; PCM processing is bypassed", wrap = true })
        elseif fmt.is_dsd then
            table.insert(rows, { label = "DSD playback: converted to PCM", wrap = true })
        end
        if fmt.is_stream then table.insert(rows, { label = "Stream name or endpoint: " .. safe_display_path(fmt.path, settings.show_full_path), wrap = true }) end
        table.insert(rows, { label = "Audio engine output: " .. format_hz(fmt.output_sample_rate) .. " · " .. format_depth(fmt.output_bit_depth), wrap = true })
    end
    if out then
        local route = ({ wired = "Wired output", bluetooth = "Bluetooth", usb_dac = "USB audio" })[out.route] or "Unknown route"
        table.insert(rows, { label = "Output route: " .. route .. " · " .. (out.active == true and "active" or out.active == false and "standby" or "status unknown"), wrap = true })
        if out.route == "bluetooth" then table.insert(rows, { label = "Bluetooth codec: " .. (out.bluetooth_codec or "Not reported"), wrap = true }) end
        if out.resampling_known then
            table.insert(rows, { label = "Player output rate: " .. format_hz(out.sample_rate) .. " · " .. (out.resampling and "differs from the engine" or "matches the engine"), wrap = true })
        else
            table.insert(rows, { label = "Final device format: Not available from the player", wrap = true })
        end
    end

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list("Playback details", rows, function(idx)
        if idx == 1 then show_format_screen(current_handle) end
    end, opts)
    return current_handle
end

-- 2. Output & Signal Path Screen
show_output_screen = function(replace_handle)
    local out = get_output_snapshot()
    local fmt = get_format_snapshot()
    local rows = {}

    table.insert(rows, { label = "Refresh output details", text_size = "medium" })

    if not out then
        table.insert(rows, { label = "Output details unavailable", text_size = "medium" })
        table.insert(rows, { label = "This firmware does not expose a live output snapshot.", wrap = true })
        local current_handle
        local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
        current_handle = plugin.show_list("Output details", rows, function(idx)
            if idx == 1 then show_output_screen(current_handle) end
        end, opts)
        return current_handle
    end

    local route_names = { wired = "Wired output", bluetooth = "Bluetooth", usb_dac = "USB audio" }
    table.insert(rows, { label = "Route: " .. (route_names[out.route] or "Unknown"), text_size = "medium" })
    table.insert(rows, { label = "Output active: " .. yes_no_unknown(out.active) })

    if out.route == "bluetooth" then
        local bt_codec = out.bluetooth_codec or "Not reported"
        table.insert(rows, { label = "Bluetooth codec: " .. bt_codec, text_size = "medium", wrap = true })
        table.insert(rows, { label = "The remote device's final output format is not visible here.", wrap = true })
    elseif out.route == "usb_dac" then
        table.insert(rows, { label = "USB audio output is selected", text_size = "medium" })
        table.insert(rows, { label = "The external device's final conversion and output format are not visible here.", wrap = true })
    elseif out.route == "wired" then
        table.insert(rows, { label = "Wired output is selected", text_size = "medium" })
    end

    if fmt then
        table.insert(rows, { label = "Audio engine format: " .. format_hz(fmt.output_sample_rate) .. " · " .. format_depth(fmt.output_bit_depth), text_size = "medium", wrap = true })
    else
        table.insert(rows, { label = "Audio engine format: Unknown", text_size = "medium" })
    end
    if out.active == true then
        table.insert(rows, { label = "Active output format: " .. format_hz(out.sample_rate) .. " · " .. format_depth(out.bit_depth), text_size = "medium", wrap = true })
    else
        table.insert(rows, { label = "Active output format: Not available while output is inactive", wrap = true })
    end

    local hw_known = (is_valid_number(out.hardware_sample_rate) and out.hardware_sample_rate > 0
        and is_valid_number(out.hardware_bit_depth) and out.hardware_bit_depth > 0)
    if hw_known then
        table.insert(rows, { label = "Local output format: " .. format_hz(out.hardware_sample_rate) .. " · " .. format_depth(out.hardware_bit_depth), text_size = "medium", wrap = true })
        table.insert(rows, { label = "Output rate matches engine: " .. (out.resampling_known and (out.resampling and "No" or "Yes") or "Unknown"), wrap = true })
    else
        table.insert(rows, { label = "Final device format: Not reported by the player", wrap = true })
        table.insert(rows, { label = "Output rate matches engine: " .. (out.resampling_known and (out.resampling and "No" or "Yes") or "Unknown"), wrap = true })
    end

    table.insert(rows, { label = "DSD-over-PCM carrier: " .. yes_no_unknown(out.dop) })

    if fmt and is_valid_number(fmt.sample_rate) and fmt.sample_rate > 0
        and is_valid_number(fmt.output_sample_rate) and fmt.output_sample_rate > 0 then
        if fmt.dop then
            local expected = fmt.sample_rate / 16
            table.insert(rows, { label = "DSD carrier rate: " .. format_hz(fmt.output_sample_rate) .. " · expected " .. format_hz(expected), wrap = true })
        elseif fmt.is_dsd then
            table.insert(rows, { label = "DSD converted to PCM at " .. format_hz(fmt.output_sample_rate), wrap = true })
        elseif fmt.sample_rate == fmt.output_sample_rate then
            table.insert(rows, { label = "Source and audio engine rates match: " .. format_hz(fmt.sample_rate), wrap = true })
        else
            table.insert(rows, { label = "Audio engine resampling: " .. format_hz(fmt.sample_rate) .. " source to " .. format_hz(fmt.output_sample_rate), wrap = true })
        end
    end

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list("Output details", rows, function(idx)
        if idx == 1 then show_output_screen(current_handle) end
    end, opts)
    return current_handle
end

-- 3. DSP & Equalizer State Screen
show_dsp_screen = function(replace_handle)
    local eq = get_live_eq()
    local fmt = get_format_snapshot()
    local mseb, mseb_supported = get_mseb_snapshot()
    local rows = {}

    table.insert(rows, { label = "Refresh sound details", text_size = "medium" })

    if mseb_supported then
        local status = mseb and (mseb.enabled and "Enabled" or "Disabled") or "State unknown"
        table.insert(rows, { label = "Stock MSEB: " .. status, text_size = "medium" })
        if mseb and mseb.enabled then
            table.insert(rows, { label = fmt and fmt.dop == true
                and "Native DoP bypasses stock MSEB during playback."
                or "Stock MSEB overrides the stored manual EQ bands, preamp, and stereo width; crossfeed remains independent.", wrap = true })
        end
    end

    if not eq then
        table.insert(rows, { label = "Equalizer details unavailable", text_size = "medium" })
        table.insert(rows, { label = "This firmware does not expose a live equalizer snapshot.", wrap = true })
        local current_handle
        local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
        current_handle = plugin.show_list("Sound processing", rows, function(idx)
            if idx == 1 then show_dsp_screen(current_handle) end
        end, opts)
        return current_handle
    end

    local bypass = eq.bypass
    table.insert(rows, { label = "Equalizer: " .. (bypass == true and "Bypassed" or bypass == false and "Enabled" or "State unknown"), text_size = "medium" })
    if bypass == true then
        table.insert(rows, { label = crossfeed_runs_when_bypassed()
            and "Equalizer bypass skips preamp, stereo width, and filters; crossfeed remains independent."
            or "Equalizer bypass also skips preamp, stereo width, crossfeed, and filters.", wrap = true })
    end
    if fmt and fmt.dop then
        table.insert(rows, { label = "DSD-over-PCM playback bypasses the equalizer and other PCM processing.", wrap = true })
    elseif fmt and fmt.is_dsd then
        table.insert(rows, { label = "DSD is converted to PCM; the sound settings below can affect playback.", wrap = true })
    end

    local mseb_override = mseb and mseb.enabled == true and not (fmt and fmt.dop == true)
    table.insert(rows, { label = "Preamp gain: " .. (is_valid_number(eq.preamp_db) and string.format("%+.2f dB", eq.preamp_db) or "Unknown") .. (bypass == true and " · bypassed" or mseb_override and " · stored; overridden by MSEB" or ""), text_size = "medium", wrap = true })
    local width = eq.stereo_width
    local width_desc = not is_valid_number(width) and "Unknown" or (width == 1.0 and "Neutral" or width == 0 and "Mono" or "Wider or narrower stereo")
    table.insert(rows, { label = "Stereo width: " .. (is_valid_number(width) and string.format("%.3f · %s", width, width_desc) or width_desc) .. (mseb_override and " · stored; overridden by MSEB" or ""), text_size = "medium", wrap = true })
    local crossfeed = eq.crossfeed
    local angle = safe_call("eq_get_crossfeed_angle")
    if not is_valid_number(angle) then angle = eq.crossfeed_angle end
    table.insert(rows, { label = "Headphone crossfeed: " .. (is_valid_number(crossfeed) and string.format("%d%% strength", math.floor(crossfeed * 100 + 0.5)) or "Unknown") .. (bypass == true and not crossfeed_runs_when_bypassed() and " · bypassed" or ""), wrap = true })
    if is_valid_number(angle) then
        table.insert(rows, { label = angle == 0 and "Crossfeed delay: none" or string.format("Crossfeed angle: %.1f°", angle), wrap = true })
    end

    if fmt then
        local soft_gain = fmt.software_volume_gain
        local soft_desc = is_valid_number(soft_gain) and (soft_gain == 1.0 and "unity (0 dB)" or format_gain_db(soft_gain)) or "Unknown"
        table.insert(rows, { label = "Software audio gain: " .. (is_valid_number(soft_gain) and string.format("%.4fx · %s", soft_gain, soft_desc) or soft_desc), text_size = "medium", wrap = true })
        local volume = safe_call("get_volume")
        table.insert(rows, { label = "Player volume: " .. (is_valid_number(volume) and string.format("%d%%", math.floor(volume + 0.5)) or "Unknown") .. " · separate from software audio gain", wrap = true })

        local speed = fmt.playback_speed
        table.insert(rows, { label = "Playback speed: " .. (is_valid_number(speed) and string.format("%.3fx%s", speed, speed ~= 1.0 and " · time stretch active" or " · normal") or "Unknown"), wrap = true })

        local rg_mode = safe_call("get_replaygain_mode")
        local replaygain_names = { off = "Off", track = "Per track", album = "Per album" }
        table.insert(rows, { label = "ReplayGain (loudness matching): " .. (replaygain_names[rg_mode] or "Unknown") .. " · current track applied: " .. yes_no_unknown(fmt.replaygain_applied), wrap = true })
        if rg_mode then table.insert(rows, { label = "Changes to this setting take effect with the next track.", wrap = true }) end
        if fmt.replaygain_applied == true then table.insert(rows, { label = "Applied ReplayGain: " .. (is_valid_number(fmt.replaygain_applied_db) and string.format("%+.2f dB", fmt.replaygain_applied_db) or "amount unknown"), wrap = true }) end

        table.insert(rows, { label = "Crossfade setting: " .. yes_no_unknown(fmt.crossfade_enabled) .. " · current mixing state is not exposed", wrap = true })
        local gapless = safe_call("get_gapless")
        table.insert(rows, { label = "Gapless playback: " .. yes_no_unknown(gapless), wrap = true })
        local play_mode = safe_call("get_play_mode")
        local mode_names = { sequential = "In order", repeat_all = "Repeat all", repeat_one = "Repeat one", shuffle = "Shuffle" }
        table.insert(rows, { label = "Play mode: " .. (mode_names[play_mode] or "Unknown") })
    end

    local active_count = 0
    local band_states_known = type(eq.bands) == "table" and #eq.bands == 10
    if type(eq.bands) == "table" then
        for _, b in ipairs(eq.bands) do
            if type(b.enabled) ~= "boolean" then band_states_known = false end
            if b.enabled == true then
                active_count = active_count + 1
            end
        end
    end
    table.insert(rows, { label = (band_states_known and string.format("Enabled equalizer bands: %d / 10", active_count) or "Enabled equalizer bands: Not fully reported") .. (mseb_override and " · stored; overridden by MSEB" or ""), text_size = "medium" })
    table.insert(rows, { label = "View all equalizer bands", text_size = "medium" })

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list("Sound processing", rows, function(idx)
        if idx == 1 then
            show_dsp_screen(current_handle)
        elseif idx == #rows then
            local band_rows = {}
            if eq.bands then
                for i, b in ipairs(eq.bands) do
                    local filter_names = { peaking = "Peaking", low_shelf = "Low shelf", high_shelf = "High shelf" }
                    local filter = filter_names[b.type] or (b.type or "Unknown filter")
                    local gain = is_valid_number(b.gain_db) and string.format("%+.2f dB", b.gain_db) or "gain unknown"
                    local state = b.enabled == true and "Enabled" or b.enabled == false and "Disabled" or "State unknown"
                    table.insert(band_rows, { label = string.format("Band %d · %s · %s Hz · %s · Q %s · %s", b.index or i, filter, is_valid_number(b.freq_hz) and tostring(math.floor(b.freq_hz)) or "?", gain, is_valid_number(b.q) and string.format("%.2f", b.q) or "?", state), text_size = "small", wrap = true })
                end
            end
            plugin.show_list("Equalizer bands", band_rows, function(b_idx) end)
        end
    end, opts)
    return current_handle
end

-- 4. Bit-Perfect Assessment Screen
show_bitperfect_screen = function(replace_handle)
    local fmt = get_format_snapshot()
    local out = get_output_snapshot()
    local eq = get_live_eq()
    local mseb, mseb_supported = get_mseb_snapshot()
    local assess = assess_bit_perfect(fmt, out, eq, mseb, mseb_supported)

    local rows = {}
    table.insert(rows, { label = "Refresh signal path check", text_size = "medium" })
    table.insert(rows, { label = "Result: " .. assess.status, text_size = "large", wrap = true })

    if assess.is_candidate then
        table.insert(rows, { label = "No changes detected in the observable playback stages. This is a candidate, not proof of the physical hardware output.", wrap = true })
    else
        table.insert(rows, { label = "The snapshot shows a change or lacks enough information to verify an unchanged signal path.", wrap = true })
    end

    if #assess.reasons > 0 then
        table.insert(rows, { label = "Changes or unknown details", text_size = "small" })
        for _, r in ipairs(assess.reasons) do
            table.insert(rows, { label = "* " .. r, wrap = true })
        end
    end

    if #assess.notes > 0 then
        table.insert(rows, { label = "Other observations", text_size = "small" })
        for _, n in ipairs(assess.notes) do
            table.insert(rows, { label = "- " .. n, wrap = true })
        end
    end

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list("Signal check", rows, function(idx)
        if idx == 1 then show_bitperfect_screen(current_handle) end
    end, opts)
    return current_handle
end

-- 5. Local File Header Inspector Screen
show_file_details = function(file_path)
    local header, err = parse_local_file_header(file_path)
    local detail_rows = {}
    local clean_name = safe_display_path(file_path, false)
    table.insert(detail_rows, { label = "File: " .. clean_name, text_size = "medium", wrap = true })

    if header then
        table.insert(detail_rows, { label = "Format: " .. header.format_name, text_size = "medium", wrap = true })
        table.insert(detail_rows, { label = "Sample Rate: " .. format_hz(header.sample_rate), text_size = "medium", wrap = true })
        table.insert(detail_rows, { label = "Bit Depth: " .. format_depth(header.bit_depth), text_size = "medium", wrap = true })
        table.insert(detail_rows, { label = "Channels: " .. format_channels(header.channels), text_size = "medium", wrap = true })
        table.insert(detail_rows, { label = "Duration: " .. format_duration(header.duration_seconds), text_size = "medium", wrap = true })
        if header.is_compressed then
            table.insert(detail_rows, { label = "Estimated Container Bitrate: " .. format_bitrate(header.bitrate_kbps) .. " (includes container/metadata overhead)", wrap = true })
            table.insert(detail_rows, { label = header.codec == "flac" and "Encoding: Lossless compressed audio" or "Encoding: Compressed audio · losslessness not confirmed by this header", wrap = true })
        else
            table.insert(detail_rows, { label = "Bitrate: " .. format_bitrate(header.bitrate_kbps), text_size = "medium", wrap = true })
            table.insert(detail_rows, { label = "Type: Uncompressed PCM", wrap = true })
        end
    else
        table.insert(detail_rows, { label = "Header Parsing Status: Unsupported / Malformed", text_size = "medium", wrap = true })
        table.insert(detail_rows, { label = "Detail: " .. (err or "Unknown format"), wrap = true })
        table.insert(detail_rows, { label = "Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension.", wrap = true })
    end

    plugin.show_list("Local file details", detail_rows, function(d_idx) end)
end

show_file_inspector = function()
    if not plugin.has_capability("ui.file_picker") or type(plugin.pick_file) ~= "function" then
        plugin.show_toast("File picker unavailable. Update firmware to inspect a local file.")
        return
    end

    local ok, result, err = pcall(plugin.pick_file, nil, function(path)
        if path ~= nil then
            show_file_details(path)
        end
    end)
    if not ok then
        plugin.show_toast("Could not open file picker. Please try again.")
    elseif result ~= true then
        if err == "busy" then
            plugin.show_toast("Please close the other file picker and try again.")
        else
            local reason = tostring(err or "unknown error")
            if #reason > 120 then reason = reason:sub(1, 117) .. "..." end
            plugin.show_toast("Could not open file picker: " .. reason)
        end
    end
end

-- 6. Settings Screen
show_settings_screen = function()
    local items = {
        {
            type = "toggle",
            label = "Show full file paths",
            value = settings.show_full_path,
            on_change = function(val)
                settings.show_full_path = val
                save_setting("show_full_path", val and "1" or "0")
            end,
        },
        {
            type = "toggle",
            label = "Show music library tags",
            value = settings.show_db_tags,
            on_change = function(val)
                settings.show_db_tags = val
                save_setting("show_db_tags", val and "1" or "0")
            end,
        },
    }
    plugin.show_settings_list("Inspector settings", items)
end

-- Main Menu Navigation
local function show_main_menu()
    local fmt = get_format_snapshot()
    local short_codec = fmt and codec_name(fmt.codec):gsub("%s*%b()", "")
    local status_line = fmt and string.format("%s · %s · %s · %s", playback_state(), short_codec, format_depth(fmt.bit_depth), format_hz(fmt.sample_rate)) or (playback_state() .. " · format unavailable")

    local rows = {
        { label = status_line, text_size = "small", wrap = true },
        { label = "Track and file details", text_size = "medium", wrap = true },
        { label = "Output device", text_size = "medium", wrap = true },
        { label = "Sound processing", text_size = "medium", wrap = true },
        { label = "Signal check", text_size = "medium", wrap = true },
        { label = "Inspect a file", text_size = "medium", wrap = true },
        { label = "Settings", text_size = "medium", wrap = true },
    }

    plugin.show_list("Track Inspector", rows, function(index)
        index = index - 1 -- the first row is the playback overview
        if index == 1 then
            show_format_screen()
        elseif index == 2 then
            show_output_screen()
        elseif index == 3 then
            show_dsp_screen()
        elseif index == 4 then
            show_bitperfect_screen()
        elseif index == 5 then
            show_file_inspector()
        elseif index == 6 then
            show_settings_screen()
        end
    end)
end

--------------------------------------------------------------------------------
-- Registration and Event Handlers
--------------------------------------------------------------------------------

-- Older firmware keeps the Playback entry until it supports player menu rows.
local entry_location = plugin.has_capability("ui.player_menu") and "player" or "playback"
plugin.register_list_item(entry_location, "Track Inspector", function()
    show_main_menu()
end)

--------------------------------------------------------------------------------
-- Test Exposure for Unit & Regression Tests
--------------------------------------------------------------------------------

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        parse_local_file_header = parse_local_file_header,
        assess_bit_perfect = assess_bit_perfect,
        get_mseb_snapshot = get_mseb_snapshot,
        mseb_has_effect = mseb_has_effect,
        decode_ieee_extended = decode_ieee_extended,
        format_hz = format_hz,
        format_depth = format_depth,
        format_channels = format_channels,
        format_bitrate = format_bitrate,
        format_duration = format_duration,
        format_gain_db = format_gain_db,
        is_remote_url = is_remote_url,
        sanitize_path = sanitize_path,
        safe_display_path = safe_display_path,
        is_within_sd = is_within_sd,
        is_valid_number = is_valid_number,
        show_main_menu = show_main_menu,
        show_format_screen = show_format_screen,
        show_output_screen = show_output_screen,
        show_dsp_screen = show_dsp_screen,
        show_bitperfect_screen = show_bitperfect_screen,
        show_file_inspector = show_file_inspector,
        show_file_details = show_file_details,
        show_settings_screen = show_settings_screen,
        settings = settings,
    }
end
