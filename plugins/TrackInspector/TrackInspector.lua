plugin.define({
    id = "compas.track_inspector",
    name = "Track Inspector",
    version = "1.1",
    api_min = 16,
})

-- Track Inspector
-- Inspects audio playback format snapshots, output route and hardware sink info,
-- parametric EQ and DSP signal chain status, bit-perfect PCM candidate criteria,
-- and local file headers for WAV, FLAC, and AIFF.

local MAX_UI_ROWS = 500
local HEADER_READ_LIMIT = 4096
local FLOAT_TOLERANCE = 1e-6

local settings = {
    show_full_path = false,
    show_db_tags = true,
}

local last_output_event = nil

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
    if not is_valid_number(bits) or bits <= 0 then return "Unknown / N/A (lossy source)" end
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
    if not is_valid_number(sec) or sec <= 0 then return "Unknown (Live stream or unparsed)" end
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
    return path:match("^%a+://") ~= nil
end

local function sanitize_path(path)
    if type(path) ~= "string" or path == "" then return "" end
    if is_remote_url(path) then
        local clean = path:gsub("[?#].*$", "")
        clean = clean:gsub("^(%a+://)[^/@]+@", "%1")
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

local function assess_bit_perfect(fmt, out, eq)
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
        table.insert(reasons, "Audio output sink is inactive or unqueried.")
    end

    -- Route check
    local route = out and out.route or "unknown"
    if route == "bluetooth" then
        local bt_codec = (out and out.bluetooth_codec) or "Unknown / Negotiating"
        table.insert(reasons, string.format("Output route is Bluetooth (%s): lossy radio transmission cannot certify end-to-end bit-perfect output.", bt_codec))
    elseif route == "usb_dac" then
        table.insert(reasons, "Output route is USB DAC: external USB endpoint conversion and hardware mixer formats are unverified; matching PCM fields alone cannot prove bit-perfect output.")
    elseif route ~= "wired" then
        table.insert(reasons, string.format("Output route '%s' is not verified wired DAC.", route))
    end

    local hardware_format_known = out and (is_valid_number(out.hardware_sample_rate) and is_valid_number(out.hardware_bit_depth))
    if out then
        if out.resampling_known then
            if out.resampling then
                table.insert(reasons, "Hardware driver indicates resampling is active.")
            end
        else
            table.insert(reasons, "Hardware DAC resampling status is unconfirmed by audio driver.")
        end
        if not hardware_format_known then
            table.insert(reasons, "Hardware DAC sample rate or bit depth is unconfirmed by audio driver.")
        elseif is_valid_number(out_depth) and out.hardware_bit_depth ~= out_depth then
            table.insert(reasons, string.format("Hardware DAC depth mismatch: engine %d-bit -> hardware %d-bit.", out_depth, out.hardware_bit_depth))
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
            table.insert(reasons, string.format("Hardware DAC rate does not match DoP carrier rate: hardware %d Hz vs carrier %.0f Hz.", out.hardware_sample_rate, expected_carrier_rate))
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
            table.insert(reasons, string.format("Hardware DAC rate mismatch: source %d Hz -> hardware %d Hz.", math.floor(src_rate), math.floor(out.hardware_sample_rate)))
        end

        if is_valid_number(src_depth) and is_valid_number(out_depth) and src_depth ~= out_depth then
            if src_depth > out_depth then
                table.insert(reasons, string.format("Bit depth truncation: source %d-bit -> output %d-bit (dithering or precision loss).", math.floor(src_depth), math.floor(out_depth)))
            else
                table.insert(reasons, string.format("Bit depth expanded: source %d-bit -> output %d-bit (possible padding or dither; bit-transparency unverified).", math.floor(src_depth), math.floor(out_depth)))
            end
        end

        -- Parametric EQ & Stereo Width
        if not eq or type(eq.bypass) ~= "boolean" then
            table.insert(reasons, "Equalizer state unavailable or unqueried; cannot verify flat DSP path.")
        elseif eq.bypass == true then
            table.insert(notes, "Parametric EQ is bypassed (preamp, stereo width, and band filters bypassed by native DSP).")
        else
            local preamp = eq.preamp_db
            if not is_valid_number(preamp) then
                table.insert(reasons, "EQ preamp gain is unknown or invalid.")
            elseif math.abs(preamp) > FLOAT_TOLERANCE then
                table.insert(reasons, string.format("EQ digital preamp gain active: %+.2f dB.", preamp))
            end

            local width = eq.stereo_width
            if not is_valid_number(width) then
                table.insert(reasons, "Stereo width is unknown or invalid.")
            elseif math.abs(width - 1.0) > FLOAT_TOLERANCE then
                table.insert(reasons, string.format("Stereo width DSP active: %.4f (crossfeed alters channels).", width))
            end

            local active_bands = 0
            if type(eq.bands) == "table" then
                for _, band in ipairs(eq.bands) do
                    if band.enabled and (not is_valid_number(band.gain_db) or math.abs(band.gain_db) > FLOAT_TOLERANCE) then
                        active_bands = active_bands + 1
                    end
                end
            else
                table.insert(reasons, "EQ bands configuration missing.")
            end
            if active_bands > 0 then
                table.insert(reasons, string.format("Parametric EQ active: %d band(s) modifying frequency response.", active_bands))
            end
        end

        -- Software Volume Gain
        local soft_gain = fmt.software_volume_gain
        if not is_valid_number(soft_gain) then
            table.insert(reasons, "Software volume state unavailable or invalid; cannot verify unity gain.")
        elseif math.abs(soft_gain - 1.0) > FLOAT_TOLERANCE then
            table.insert(reasons, string.format("Software volume scaling active: %.6fx (%s digital modification).", soft_gain, format_gain_db(soft_gain)))
        else
            table.insert(notes, "Software volume at unity gain (1.00 / 0.0 dB - no digital PCM scaling).")
        end

        -- Playback Speed
        local speed = fmt.playback_speed
        if not is_valid_number(speed) then
            table.insert(reasons, "Playback speed state unavailable or invalid.")
        elseif math.abs(speed - 1.0) > FLOAT_TOLERANCE then
            table.insert(reasons, string.format("Playback speed modified: %.4fx (time-stretching DSP active).", speed))
        end

        -- ReplayGain
        if fmt.replaygain_applied == nil then
            table.insert(reasons, "ReplayGain state unavailable.")
        elseif fmt.replaygain_applied == true then
            local rg_db = fmt.replaygain_applied_db or 0
            if not is_valid_number(rg_db) or math.abs(rg_db) > FLOAT_TOLERANCE then
                table.insert(reasons, string.format("ReplayGain scaling applied: %+.2f dB.", rg_db))
            end
        end

        if fmt.crossfade_enabled then
            table.insert(notes, "Crossfade setting is enabled (may blend track boundaries).")
        end
    else
        table.insert(notes, "Native DoP hardware stream bypasses PCM Equalizer, stereo width, and software volume.")
    end

    local status, is_candidate
    if #reasons == 0 and route == "wired" then
        if is_true_dop then
            status = "Bit-Perfect DoP Candidate (Wired)"
        else
            status = "Bit-Perfect PCM Candidate (Wired)"
        end
        is_candidate = true
    elseif route == "bluetooth" or route == "usb_dac" then
        status = string.format("Route Uncertainty: End-to-End Uncertifiable (%s)", route == "bluetooth" and "Bluetooth" or "USB DAC")
        is_candidate = false
    elseif out and out.active ~= true then
        status = "Sink Inactive / Standby"
        is_candidate = false
    else
        status = "Signal Path Modified / Uncertain"
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
    local fmt, err = get_format_snapshot()
    local out = get_output_snapshot()
    local rows = {}

    table.insert(rows, { label = "[Tap to Refresh Format Data]", text_size = "medium" })

    if not fmt then
        table.insert(rows, { label = "Status: Idle / Not Playing", text_size = "medium" })
        table.insert(rows, { label = "Explanation: No active track or stream is playing. Start playback to view real-time format parameters.", wrap = true })
        if err then table.insert(rows, { label = "Detail: " .. err, wrap = true }) end

        local current_handle
        local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
        current_handle = plugin.show_list("Format Snapshot", rows, function(idx)
            if idx == 1 then
                show_format_screen(current_handle)
            end
        end, opts)
        return current_handle
    end

    local disp_path = safe_display_path(fmt.path, settings.show_full_path)
    table.insert(rows, { label = "Source Path: " .. disp_path, wrap = true })

    if settings.show_db_tags and not fmt.is_stream then
        local meta = get_track_metadata(fmt.path)
        if meta then
            if meta.title and meta.title ~= "" then table.insert(rows, { label = "Title: " .. meta.title, wrap = true }) end
            if meta.artist and meta.artist ~= "" then table.insert(rows, { label = "Artist: " .. meta.artist, wrap = true }) end
            if meta.album and meta.album ~= "" then table.insert(rows, { label = "Album: " .. meta.album, wrap = true }) end
            if meta.genre and meta.genre ~= "" then table.insert(rows, { label = "Genre: " .. meta.genre, wrap = true }) end
        end
    end

    table.insert(rows, { label = "Codec: " .. (fmt.codec or "unknown"):upper(), text_size = "medium" })
    table.insert(rows, { label = "Source Sample Rate: " .. format_hz(fmt.sample_rate), text_size = "medium" })
    table.insert(rows, { label = "Source Bit Depth: " .. format_depth(fmt.bit_depth), text_size = "medium" })
    table.insert(rows, { label = "Channels: " .. format_channels(fmt.channels), text_size = "medium" })
    table.insert(rows, { label = "Bitrate: " .. format_bitrate(fmt.bitrate_kbps), text_size = "medium" })
    table.insert(rows, { label = "Duration: " .. format_duration(fmt.duration_seconds), text_size = "medium" })
    table.insert(rows, { label = "Stream Type: " .. (fmt.is_stream and "Remote Network Stream" or "Local File") })
    table.insert(rows, { label = "Seekable: " .. (fmt.seekable and "Yes" or "No (Forward-only)") })

    if fmt.dop then
        table.insert(rows, { label = "DSD Stream: Native DoP (Bypasses PCM DSP)", text_size = "medium" })
    elseif fmt.is_dsd then
        table.insert(rows, { label = "DSD Stream: DSD-to-PCM Decimation", text_size = "medium" })
    end

    table.insert(rows, { label = "--- Output Stream ---", text_size = "small" })
    table.insert(rows, { label = "Output Sample Rate: " .. format_hz(fmt.output_sample_rate), text_size = "medium" })
    table.insert(rows, { label = "Output Bit Depth: " .. format_depth(fmt.output_bit_depth), text_size = "medium" })
    if out then
        table.insert(rows, { label = "Route: " .. (out.route or "unknown"):upper() .. (out.active and " (Active)" or " (Inactive)") })
        if out.resampling_known then
            table.insert(rows, { label = "Resampling: " .. (out.resampling and "Active" or "None (Matched)") })
        else
            table.insert(rows, { label = "Resampling: Unknown (Hardware format unconfirmed)", wrap = true })
        end
    end

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list("Format Snapshot", rows, function(idx)
        if idx == 1 then
            show_format_screen(current_handle)
        end
    end, opts)
    return current_handle
end

-- 2. Output & Signal Path Screen
show_output_screen = function(replace_handle)
    local out, err = get_output_snapshot()
    local fmt = get_format_snapshot()
    local rows = {}

    table.insert(rows, { label = "[Tap to Refresh Output Data]", text_size = "medium" })

    if not out then
        table.insert(rows, { label = "Output Info Unavailable", text_size = "medium" })
        if err then table.insert(rows, { label = "Detail: " .. err, wrap = true }) end
        local current_handle
        local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
        current_handle = plugin.show_list("Output Route", rows, function(idx)
            if idx == 1 then show_output_screen(current_handle) end
        end, opts)
        return current_handle
    end

    table.insert(rows, { label = "Active Route: " .. (out.route or "unknown"):upper(), text_size = "medium" })
    table.insert(rows, { label = "Sink Active: " .. (out.active and "Yes (Transmitting audio)" or "No (Standby)") })

    if out.route == "bluetooth" then
        local bt_codec = out.bluetooth_codec or "Unknown / Negotiating"
        table.insert(rows, { label = "Bluetooth Codec: " .. bt_codec, text_size = "medium" })
        table.insert(rows, { label = "Notice: Bluetooth transmission uses lossy radio compression; DAC output cannot be verified bit-perfect.", wrap = true })
    elseif out.route == "usb_dac" then
        table.insert(rows, { label = "USB Endpoint: Connected USB Audio DAC", text_size = "medium" })
        table.insert(rows, { label = "Notice: External USB DAC conversion and internal endpoint formats are unverified.", wrap = true })
    elseif out.route == "wired" then
        table.insert(rows, { label = "Wired Port: On-board 3.5mm Headphone / Line-out", text_size = "medium" })
    end

    table.insert(rows, { label = "Output PCM Rate: " .. format_hz(out.sample_rate), text_size = "medium" })
    table.insert(rows, { label = "Output PCM Depth: " .. format_depth(out.bit_depth), text_size = "medium" })

    local hw_known = (is_valid_number(out.hardware_sample_rate) and is_valid_number(out.hardware_bit_depth))
    if hw_known then
        table.insert(rows, { label = "Hardware DAC Rate: " .. format_hz(out.hardware_sample_rate), text_size = "medium" })
        table.insert(rows, { label = "Hardware DAC Depth: " .. format_depth(out.hardware_bit_depth), text_size = "medium" })
        table.insert(rows, { label = "Hardware Resampling: " .. (out.resampling and "Active (Rate mismatch)" or "None (Direct rate)") })
    else
        table.insert(rows, { label = "Hardware DAC Rate: Unknown (Driver hardware register unqueried)", wrap = true })
        table.insert(rows, { label = "Hardware Resampling: " .. (out.resampling_known and (out.resampling and "Active" or "None") or "Unknown"), wrap = true })
    end

    table.insert(rows, { label = "DoP (DSD over PCM): " .. (out.dop and "Active" or "Inactive") })

    if fmt and fmt.sample_rate and out.sample_rate then
        if fmt.sample_rate == out.sample_rate then
            table.insert(rows, { label = "Source vs Output Rate: Matched (" .. format_hz(fmt.sample_rate) .. ")" })
        else
            table.insert(rows, { label = string.format("Source vs Output Rate: Mismatched (%d Hz -> %d Hz)", math.floor(fmt.sample_rate), math.floor(out.sample_rate)) })
        end
    end

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list("Output Route", rows, function(idx)
        if idx == 1 then show_output_screen(current_handle) end
    end, opts)
    return current_handle
end

-- 3. DSP & Equalizer State Screen
show_dsp_screen = function(replace_handle)
    local eq, err = get_live_eq()
    local fmt = get_format_snapshot()
    local rows = {}

    table.insert(rows, { label = "[Tap to Refresh DSP & EQ Data]", text_size = "medium" })

    if not eq then
        table.insert(rows, { label = "EQ State Unavailable", text_size = "medium" })
        if err then table.insert(rows, { label = "Detail: " .. err, wrap = true }) end
        local current_handle
        local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
        current_handle = plugin.show_list("DSP & EQ Status", rows, function(idx)
            if idx == 1 then show_dsp_screen(current_handle) end
        end, opts)
        return current_handle
    end

    local bypass = eq.bypass
    table.insert(rows, { label = "Parametric EQ Bypass: " .. (bypass and "BYPASS ACTIVE" or "IN SERVICE (ACTIVE)"), text_size = "medium" })
    if bypass then
        table.insert(rows, { label = "Bypass Note: Configured preamp, stereo width, and band filters are not applied to audio stream.", wrap = true })
    end
    if fmt and fmt.dop then
        table.insert(rows, { label = "DoP Note: Native DSD bitstream bypasses PCM DSP chain regardless of EQ configuration.", wrap = true })
    elseif fmt and fmt.is_dsd then
        table.insert(rows, { label = "DSD Decimation Note: Stream is converted to PCM; PCM DSP filters apply.", wrap = true })
    end

    table.insert(rows, { label = string.format("Preamp Gain: %+.2f dB %s", eq.preamp_db or 0, bypass and "(bypassed)" or ""), text_size = "medium" })
    local width = eq.stereo_width or 1.0
    local width_desc = math.abs(width - 1.0) <= FLOAT_TOLERANCE and "Normal Stereo" or (width <= FLOAT_TOLERANCE and "Mono" or "Modified Width")
    table.insert(rows, { label = string.format("Stereo Width: %.4f (%s)", width, width_desc), text_size = "medium" })

    if fmt then
        local soft_gain = fmt.software_volume_gain or 1.0
        local soft_desc = math.abs(soft_gain - 1.0) <= FLOAT_TOLERANCE and "Unity Gain (0 dB - unaltered)" or format_gain_db(soft_gain)
        table.insert(rows, { label = string.format("Software Volume: %.6fx (%s)", soft_gain, soft_desc), text_size = "medium", wrap = true })
        table.insert(rows, { label = "Note: Software gain is a linear PCM multiplier, distinct from hardware volume.", wrap = true })

        local speed = fmt.playback_speed or 1.0
        table.insert(rows, { label = string.format("Playback Speed: %.4fx %s", speed, math.abs(speed - 1.0) > FLOAT_TOLERANCE and "(Time-stretch DSP)" or "(Normal)") })

        if fmt.replaygain_applied then
            table.insert(rows, { label = string.format("ReplayGain Applied: %+.2f dB", fmt.replaygain_applied_db or 0) })
        else
            table.insert(rows, { label = "ReplayGain: Inactive (0.0 dB)" })
        end

        table.insert(rows, { label = "Crossfade Setting: " .. (fmt.crossfade_enabled and "Enabled" or "Disabled") })
    end

    local active_count = 0
    if eq.bands then
        for _, b in ipairs(eq.bands) do
            if b.enabled and math.abs(b.gain_db or 0) > FLOAT_TOLERANCE then
                active_count = active_count + 1
            end
        end
    end
    table.insert(rows, { label = string.format("EQ Active Bands: %d / 10", active_count), text_size = "medium" })
    table.insert(rows, { label = "View All 10 EQ Bands Details ->", text_size = "medium" })

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list("DSP & EQ Status", rows, function(idx)
        if idx == 1 then
            show_dsp_screen(current_handle)
        elseif idx == #rows then
            local band_rows = {}
            if eq.bands then
                for i, b in ipairs(eq.bands) do
                    local active_str = (b.enabled and math.abs(b.gain_db or 0) > FLOAT_TOLERANCE) and "ACTIVE" or (b.enabled and "FLAT" or "OFF")
                    local label = string.format("Band %d: %s | %d Hz | %+.2f dB | Q=%.3f [%s]",
                        b.index or i, b.type or "peaking", math.floor(b.freq_hz or 0), b.gain_db or 0, b.q or 0.7, active_str)
                    table.insert(band_rows, { label = label, text_size = "small", wrap = true })
                end
            end
            plugin.show_list("EQ Bands (1-10)", band_rows, function(b_idx) end)
        end
    end, opts)
    return current_handle
end

-- 4. Bit-Perfect Assessment Screen
show_bitperfect_screen = function(replace_handle)
    local fmt = get_format_snapshot()
    local out = get_output_snapshot()
    local eq = get_live_eq()
    local assess = assess_bit_perfect(fmt, out, eq)

    local rows = {}
    table.insert(rows, { label = "[Tap to Refresh Assessment]", text_size = "medium" })
    table.insert(rows, { label = "Result: " .. assess.status, text_size = "large", wrap = true })

    if assess.is_candidate then
        table.insert(rows, { label = "Verdict: Bit-perfect candidate under all observable native stages.", wrap = true })
    else
        table.insert(rows, { label = "Verdict: Audio stream cannot be certified bit-perfect.", wrap = true })
    end

    if #assess.reasons > 0 then
        table.insert(rows, { label = "--- Disqualifying Factors / DSP ---", text_size = "small" })
        for _, r in ipairs(assess.reasons) do
            table.insert(rows, { label = "* " .. r, wrap = true })
        end
    end

    if #assess.notes > 0 then
        table.insert(rows, { label = "--- Signal Observations ---", text_size = "small" })
        for _, n in ipairs(assess.notes) do
            table.insert(rows, { label = "- " .. n, wrap = true })
        end
    end

    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil
    current_handle = plugin.show_list("Bit-Perfect Check", rows, function(idx)
        if idx == 1 then show_bitperfect_screen(current_handle) end
    end, opts)
    return current_handle
end

-- 5. Local File Header Inspector Screen (Replaceable browser, scoped to SD root)
show_file_details = function(file_path)
    local header, err = parse_local_file_header(file_path)
    local detail_rows = {}
    local clean_name = safe_display_path(file_path, false)
    table.insert(detail_rows, { label = "File: " .. clean_name, text_size = "medium", wrap = true })

    if header then
        table.insert(detail_rows, { label = "Format: " .. header.format_name, text_size = "medium" })
        table.insert(detail_rows, { label = "Sample Rate: " .. format_hz(header.sample_rate), text_size = "medium" })
        table.insert(detail_rows, { label = "Bit Depth: " .. format_depth(header.bit_depth), text_size = "medium" })
        table.insert(detail_rows, { label = "Channels: " .. format_channels(header.channels), text_size = "medium" })
        table.insert(detail_rows, { label = "Duration: " .. format_duration(header.duration_seconds), text_size = "medium" })
        if header.is_compressed then
            table.insert(detail_rows, { label = "Estimated Container Bitrate: " .. format_bitrate(header.bitrate_kbps) .. " (includes container/metadata overhead)", wrap = true })
            table.insert(detail_rows, { label = header.codec == "flac" and "Type: Lossless Compressed" or "Type: Encoded Audio (losslessness unverified)", wrap = true })
        else
            table.insert(detail_rows, { label = "Bitrate: " .. format_bitrate(header.bitrate_kbps), text_size = "medium" })
            table.insert(detail_rows, { label = "Type: Uncompressed PCM", wrap = true })
        end
    else
        table.insert(detail_rows, { label = "Header Parsing Status: Unsupported / Malformed", text_size = "medium", wrap = true })
        table.insert(detail_rows, { label = "Detail: " .. (err or "Unknown format"), wrap = true })
        table.insert(detail_rows, { label = "Note: Inspection bounded to local WAV, FLAC, AIFF headers. Other formats report unknown without guessing from file extension.", wrap = true })
    end

    plugin.show_list("File Header Details", detail_rows, function(d_idx) end)
end

show_file_inspector = function(current_dir, replace_handle)
    local sd_root = plugin.sd_root()
    current_dir = current_dir or sd_root
    if not is_within_sd(current_dir, sd_root) then
        current_dir = sd_root
    end

    local clean_root = sd_root:gsub("/+$", "")
    local entries = plugin.list_dir(current_dir) or {}

    table.sort(entries, function(a, b)
        if a.dir ~= b.dir then return a.dir end
        return (a.name or "") < (b.name or "")
    end)

    local rows = {}
    local actions = {}

    -- Parent Folder row confined within SD root
    if current_dir ~= clean_root then
        local parent = current_dir:match("^(.*)/[^/]+$") or clean_root
        if not is_within_sd(parent, clean_root) then
            parent = clean_root
        end
        table.insert(rows, { label = ".. (Parent Folder)", text_size = "medium" })
        table.insert(actions, { type = "dir", path = parent })
    end

    for _, entry in ipairs(entries) do
        if #rows >= MAX_UI_ROWS - 2 then break end
        if entry.name and not entry.name:find("/") and not entry.name:find("\\") then
            local full_path = current_dir .. "/" .. entry.name
            if entry.dir then
                if is_within_sd(full_path, clean_root) then
                    table.insert(rows, { label = "[DIR] " .. entry.name, text_size = "medium" })
                    table.insert(actions, { type = "dir", path = full_path })
                end
            else
                local lower = entry.name:lower()
                if lower:match("%.wav$") or lower:match("%.flac$") or lower:match("%.aiff?$") or lower:match("%.mp3$") or lower:match("%.m4a$") or lower:match("%.ogg$") then
                    table.insert(rows, { label = entry.name, text_size = "small" })
                    table.insert(actions, { type = "file", path = full_path })
                end
            end
        end
    end

    local title = "Inspect File (" .. basename(current_dir) .. ")"
    local current_handle
    local opts = replace_handle and { replace = replace_handle, selected = 1 } or nil

    current_handle = plugin.show_list(title, rows, function(idx)
        local act = actions[idx]
        if not act then return end
        if act.type == "dir" then
            show_file_inspector(act.path, current_handle)
        elseif act.type == "file" then
            show_file_details(act.path)
        end
    end, opts)
    return current_handle
end

-- 6. Settings Screen
show_settings_screen = function()
    local items = {
        {
            type = "toggle",
            label = "Show Full File Paths",
            value = settings.show_full_path,
            on_change = function(val)
                settings.show_full_path = val
                save_setting("show_full_path", val and "1" or "0")
            end,
        },
        {
            type = "toggle",
            label = "Lookup Database Tags",
            value = settings.show_db_tags,
            on_change = function(val)
                settings.show_db_tags = val
                save_setting("show_db_tags", val and "1" or "0")
            end,
        },
    }
    plugin.show_settings_list("Inspector Settings", items)
end

-- Main Menu Navigation
local function show_main_menu()
    local fmt = get_format_snapshot()
    local status_line = fmt and string.format("Playing: %s (%s)", (fmt.codec or ""):upper(), format_hz(fmt.sample_rate)) or "Audio Idle"

    local rows = {
        { label = "1. Current Playback Format", text_size = "medium" },
        { label = "2. Output & Hardware", text_size = "medium" },
        { label = "3. DSP & Equalizer Status", text_size = "medium" },
        { label = "4. Bit-Perfect Assessment", text_size = "medium" },
        { label = "5. Inspect Local Audio File", text_size = "medium" },
        { label = "6. Settings", text_size = "medium" },
        { label = "Status: " .. status_line, text_size = "small", wrap = true },
    }

    plugin.show_list("Track Inspector", rows, function(index)
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

plugin.register_list_item("playback", "Track Inspector", function()
    show_main_menu()
end)

if plugin.has_capability("playback.output_events") then
    plugin.on("output_changed", function(current, previous)
        last_output_event = current
    end)
end

--------------------------------------------------------------------------------
-- Test Exposure for Unit & Regression Tests
--------------------------------------------------------------------------------

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        parse_local_file_header = parse_local_file_header,
        assess_bit_perfect = assess_bit_perfect,
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
