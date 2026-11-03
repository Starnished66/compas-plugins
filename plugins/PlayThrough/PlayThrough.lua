plugin.define({
    id = "example.play_through",
    name = "Play Through",
    version = "1.2.0",
    api_min = 19,
})

local T = {
    de = {
        ["Play Through"] = "Weiterwiedergabe",
        ["Play Through Folders"] = "Ordner weiter abspielen",
        ["Play Through Albums"] = "Alben weiter abspielen",
        ["How It Works"] = "Funktionsweise",
        ["About Play Through"] = "Über Weiterwiedergabe",
        ["Albums continue in the artist's alphabetical album order."] = "Alben werden in alphabetischer Reihenfolge des Künstlers fortgesetzt.",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "Ordner werden in alphabetischer Reihenfolge der Nachbarordner fortgesetzt.",
        ["Album mode has priority when both options are enabled."] = "Der Albummodus hat Vorrang, wenn beide Optionen aktiviert sind.",
        ["Shuffle and repeat modes are left unchanged."] = "Zufalls- und Wiederholungsmodus bleiben unverändert.",
        ["Continuing playback"] = "Wiedergabe wird fortgesetzt",
        ["Could not save Play Through settings"] = "Einstellungen für Weiterwiedergabe konnten nicht gespeichert werden",
    },
    es = {
        ["Play Through"] = "Reproducción continua",
        ["Play Through Folders"] = "Continuar entre carpetas",
        ["Play Through Albums"] = "Continuar entre álbumes",
        ["How It Works"] = "Cómo funciona",
        ["About Play Through"] = "Acerca de Reproducción continua",
        ["Albums continue in the artist's alphabetical album order."] = "Los álbumes continúan en el orden alfabético del artista.",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "Las carpetas continúan en orden alfabético (sin distinguir mayúsculas) entre carpetas vecinas.",
        ["Album mode has priority when both options are enabled."] = "El modo de álbum tiene prioridad cuando ambas opciones están activadas.",
        ["Shuffle and repeat modes are left unchanged."] = "Los modos aleatorio y de repetición no cambian.",
        ["Continuing playback"] = "Continuando la reproducción",
        ["Could not save Play Through settings"] = "No se pudieron guardar los ajustes de Reproducción continua",
    },
    fi = {
        ["Play Through"] = "Jatkuva toisto",
        ["Play Through Folders"] = "Jatka kansioiden läpi",
        ["Play Through Albums"] = "Jatka albumien läpi",
        ["How It Works"] = "Miten se toimii",
        ["About Play Through"] = "Tietoja jatkuvasta toistosta",
        ["Albums continue in the artist's alphabetical album order."] = "Albumit jatkuvat esittäjän aakkosjärjestyksessä.",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "Kansiot jatkuvat rinnakkaiskansioiden aakkosjärjestyksessä.",
        ["Album mode has priority when both options are enabled."] = "Albumitila on ensisijainen, kun molemmat valinnat ovat käytössä.",
        ["Shuffle and repeat modes are left unchanged."] = "Satunnais- ja kertaustiloja ei muuteta.",
        ["Continuing playback"] = "Jatketaan toistoa",
        ["Could not save Play Through settings"] = "Jatkuvan toiston asetuksia ei voitu tallentaa",
    },
    fr = {
        ["Play Through"] = "Lecture enchaînée",
        ["Play Through Folders"] = "Enchaîner les dossiers",
        ["Play Through Albums"] = "Enchaîner les albums",
        ["How It Works"] = "Fonctionnement",
        ["About Play Through"] = "À propos de Lecture enchaînée",
        ["Albums continue in the artist's alphabetical album order."] = "Les albums s'enchaînent dans l'ordre alphabétique des albums de l'artiste.",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "Les dossiers s'enchaînent dans l'ordre alphabétique des dossiers voisins.",
        ["Album mode has priority when both options are enabled."] = "Le mode album est prioritaire lorsque les deux options sont activées.",
        ["Shuffle and repeat modes are left unchanged."] = "Les modes aléatoire et répétition restent inchangés.",
        ["Continuing playback"] = "Poursuite de la lecture",
        ["Could not save Play Through settings"] = "Impossible d'enregistrer les paramètres de Lecture enchaînée",
    },
    it = {
        ["Play Through"] = "Riproduzione continua",
        ["Play Through Folders"] = "Continua tra le cartelle",
        ["Play Through Albums"] = "Continua tra gli album",
        ["How It Works"] = "Come funziona",
        ["About Play Through"] = "Informazioni su Riproduzione continua",
        ["Albums continue in the artist's alphabetical album order."] = "Gli album proseguono nell'ordine alfabetico dell'artista.",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "Le cartelle proseguono in ordine alfabetico tra le cartelle adiacenti.",
        ["Album mode has priority when both options are enabled."] = "La modalità album ha la priorità quando entrambe le opzioni sono attive.",
        ["Shuffle and repeat modes are left unchanged."] = "Le modalità casuale e ripetizione restano invariate.",
        ["Continuing playback"] = "Proseguimento della riproduzione",
        ["Could not save Play Through settings"] = "Impossibile salvare le impostazioni di Riproduzione continua",
    },
    ja = {
        ["Play Through"] = "連続再生",
        ["Play Through Folders"] = "フォルダを連続再生",
        ["Play Through Albums"] = "アルバムを連続再生",
        ["How It Works"] = "仕組み",
        ["About Play Through"] = "連続再生について",
        ["Albums continue in the artist's alphabetical album order."] = "アルバムはアーティストのアルバム名順（アルファベット順）で続きます。",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "フォルダは大文字小文字を区別しない名前順で次のフォルダへ続きます。",
        ["Album mode has priority when both options are enabled."] = "両方有効な場合はアルバムモードが優先されます。",
        ["Shuffle and repeat modes are left unchanged."] = "シャッフルとリピートモードは変更されません。",
        ["Continuing playback"] = "再生を継続中",
        ["Could not save Play Through settings"] = "連続再生の設定を保存できませんでした",
    },
    nl = {
        ["Play Through"] = "Doorblijven spelen",
        ["Play Through Folders"] = "Mappen doorspelen",
        ["Play Through Albums"] = "Albums doorspelen",
        ["How It Works"] = "Hoe het werkt",
        ["About Play Through"] = "Over Doorblijven spelen",
        ["Albums continue in the artist's alphabetical album order."] = "Albums gaan verder in alfabetische albumvolgorde van de artiest.",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "Mappen gaan verder in alfabetische volgorde van naastgelegen mappen.",
        ["Album mode has priority when both options are enabled."] = "Albummodus heeft voorrang wanneer beide opties zijn ingeschakeld.",
        ["Shuffle and repeat modes are left unchanged."] = "Shuffle- en herhaalmodi blijven ongewijzigd.",
        ["Continuing playback"] = "Afspelen wordt voortgezet",
        ["Could not save Play Through settings"] = "Kon instellingen voor Doorblijven spelen niet opslaan",
    },
    pt = {
        ["Play Through"] = "Reprodução contínua",
        ["Play Through Folders"] = "Continuar pelas pastas",
        ["Play Through Albums"] = "Continuar pelos álbuns",
        ["How It Works"] = "Como funciona",
        ["About Play Through"] = "Sobre a Reprodução contínua",
        ["Albums continue in the artist's alphabetical album order."] = "Os álbuns continuam na ordem alfabética dos álbuns do artista.",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "As pastas continuam em ordem alfabética entre pastas vizinhas.",
        ["Album mode has priority when both options are enabled."] = "O modo de álbum tem prioridade quando ambas as opções estão ativadas.",
        ["Shuffle and repeat modes are left unchanged."] = "Os modos aleatório e de repetição permanecem inalterados.",
        ["Continuing playback"] = "Continuando a reprodução",
        ["Could not save Play Through settings"] = "Não foi possível salvar as configurações de Reprodução contínua",
    },
    ru = {
        ["Play Through"] = "Сквозное воспроизведение",
        ["Play Through Folders"] = "Переходить к следующей папке",
        ["Play Through Albums"] = "Переходить к следующему альбому",
        ["How It Works"] = "Как это работает",
        ["About Play Through"] = "О сквозном воспроизведении",
        ["Albums continue in the artist's alphabetical album order."] = "Альбомы продолжаются в алфавитном порядке альбомов исполнителя.",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "Папки продолжаются в алфавитном порядке соседних папок (без учёта регистра).",
        ["Album mode has priority when both options are enabled."] = "Режим альбомов имеет приоритет, когда включены оба параметра.",
        ["Shuffle and repeat modes are left unchanged."] = "Режимы перемешивания и повтора не изменяются.",
        ["Continuing playback"] = "Продолжение воспроизведения",
        ["Could not save Play Through settings"] = "Не удалось сохранить настройки сквозного воспроизведения",
    },
    uk = {
        ["Play Through"] = "Наскрізне відтворення",
        ["Play Through Folders"] = "Переходити до наступної теки",
        ["Play Through Albums"] = "Переходити до наступного альбому",
        ["How It Works"] = "Як це працює",
        ["About Play Through"] = "Про наскрізне відтворення",
        ["Albums continue in the artist's alphabetical album order."] = "Альбоми продовжуються в алфавітному порядку альбомів виконавця.",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "Теки продовжуються в алфавітному порядку сусідніх тек (без урахування регістру).",
        ["Album mode has priority when both options are enabled."] = "Режим альбомів має пріоритет, коли увімкнено обидва параметри.",
        ["Shuffle and repeat modes are left unchanged."] = "Режими перемішування та повтору залишаються без змін.",
        ["Continuing playback"] = "Продовження відтворення",
        ["Could not save Play Through settings"] = "Не вдалося зберегти налаштування наскрізного відтворення",
    },
    vi = {
        ["Play Through"] = "Phát nối tiếp",
        ["Play Through Folders"] = "Phát tiếp qua các thư mục",
        ["Play Through Albums"] = "Phát tiếp qua các album",
        ["How It Works"] = "Cách hoạt động",
        ["About Play Through"] = "Giới thiệu Phát nối tiếp",
        ["Albums continue in the artist's alphabetical album order."] = "Các album tiếp tục theo thứ tự bảng chữ cái của nghệ sĩ.",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "Các thư mục tiếp tục theo thứ tự bảng chữ cái của thư mục cùng cấp.",
        ["Album mode has priority when both options are enabled."] = "Chế độ album được ưu tiên khi bật cả hai tùy chọn.",
        ["Shuffle and repeat modes are left unchanged."] = "Chế độ phát ngẫu nhiên và lặp lại được giữ nguyên.",
        ["Continuing playback"] = "Đang tiếp tục phát",
        ["Could not save Play Through settings"] = "Không thể lưu cài đặt Phát nối tiếp",
    },
    zh_CN = {
        ["Play Through"] = "连续播放",
        ["Play Through Folders"] = "跨文件夹连续播放",
        ["Play Through Albums"] = "跨专辑连续播放",
        ["How It Works"] = "工作原理",
        ["About Play Through"] = "关于连续播放",
        ["Albums continue in the artist's alphabetical album order."] = "专辑按艺人专辑名称的字母顺序继续播放。",
        ["Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."] = "文件夹按同级文件夹的字母顺序（不区分大小写）继续播放。",
        ["Album mode has priority when both options are enabled."] = "同时启用两个选项时，专辑模式优先。",
        ["Shuffle and repeat modes are left unchanged."] = "随机播放和重复模式保持不变。",
        ["Continuing playback"] = "正在继续播放",
        ["Could not save Play Through settings"] = "无法保存连续播放设置",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

-- Continues playback after a playlist reaches its natural end:
--   * Play Through Albums starts the artist's next album.
--   * Play Through Folders starts the next sibling folder.
--
-- Both may be enabled. Album continuation takes priority when the current
-- file is the final track of a tagged album; folder continuation is the
-- fallback. An explicit Stop cancels the pending continuation. The two-poll
-- idle confirmation avoids racing the player's normal gapless/playlist
-- auto-advance, which can briefly report a transition between tracks.

local STATE_PATH = plugin.sd_root() .. "/.plugins/.play_through_state"
local state = { folders = false, albums = false }

local candidate_paths = nil
local candidate_index = 1
local continuation_batch = nil
local stopped_polls = 0

local function load_state()
    local f = io.open(STATE_PATH, "r")
    if not f then return end
    for line in f:lines() do
        local key, value = line:match("^([%a_]+)=(%d)$")
        if key == "folders" then state.folders = value == "1" end
        if key == "albums" then state.albums = value == "1" end
    end
    f:close()
end

local function save_state()
    local tmp = STATE_PATH .. ".tmp"
    local f = io.open(tmp, "w")
    if not f then
        plugin.show_toast(tr("Could not save Play Through settings"))
        return
    end
    local wrote = f:write("folders=", state.folders and "1" or "0", "\n",
        "albums=", state.albums and "1" or "0", "\n")
    local closed = f:close()
    if not wrote or not closed or not os.rename(tmp, STATE_PATH) then
        plugin.show_toast(tr("Could not save Play Through settings"))
    end
end

local function lexical_key(value)
    return tostring(value or ""):lower()
end

local function lexical_less(a, b)
    return lexical_key(a.name or a) < lexical_key(b.name or b)
end

local function is_audio(name)
    local extension = tostring(name or ""):match("%.([%a%d]+)$")
    if not extension then return false end
    extension = extension:lower()
    local supported = {
        mp3 = true, flac = true, wav = true, aif = true, aiff = true,
        aifc = true, dsf = true, dff = true, aac = true, m4a = true,
        m4b = true, alac = true, ape = true, opus = true, ogg = true,
        wma = true,
    }
    return supported[extension] == true
end

local function split_path(path)
    if not path then return nil end
    local directory, name = path:match("^(.*)/([^/]+)$")
    if not directory or directory == "" then return nil end
    return directory, name
end

local function folder_tracks(directory)
    local tracks = {}
    for _, entry in ipairs(plugin.list_dir(directory)) do
        if not entry.dir and is_audio(entry.name) then
            tracks[#tracks + 1] = { name = entry.name, path = directory .. "/" .. entry.name }
        end
    end
    table.sort(tracks, lexical_less)
    return tracks
end

local function next_folder_tracks(current_path)
    local current_directory, current_name = split_path(current_path)
    if not current_directory then return nil end

    local current_tracks = folder_tracks(current_directory)
    if #current_tracks == 0 or current_tracks[#current_tracks].name ~= current_name then return nil end

    local parent, folder_name = split_path(current_directory)
    if not parent then return nil end

    local folders = {}
    for _, entry in ipairs(plugin.list_dir(parent)) do
        if entry.dir then folders[#folders + 1] = entry end
    end
    table.sort(folders, lexical_less)

    local found_current = false
    for _, folder in ipairs(folders) do
        if found_current then
            local tracks = folder_tracks(parent .. "/" .. folder.name)
            if #tracks > 0 then
                local paths = {}
                for i, track in ipairs(tracks) do paths[i] = track.path end
                return paths
            end
        elseif folder.name == folder_name then
            found_current = true
        end
    end
    return nil
end

local function same_path(a, b)
    return a ~= nil and b ~= nil and a == b
end

local function album_continuation(path, artist, album)
    if not state.albums or not artist or artist == "" or not album or album == "" then return nil end
    local current_tracks = plugin.get_album_tracks(artist, album)
    if not current_tracks or #current_tracks == 0 or not same_path(path, current_tracks[#current_tracks]) then
        return nil
    end
    return plugin.get_next_album_tracks(artist, album)
end

local function arm_continuation(_, artist, album)
    local path = plugin.get_current_track_path()
    -- Inside a batch with more batches still to come, the pending remainder
    -- is the continuation. In the final batch, arm normally so its last
    -- track continues to the next folder or album.
    if continuation_batch and candidate_paths and path then
        for _, batch_path in ipairs(continuation_batch) do
            if path == batch_path then return end
        end
    end
    continuation_batch = nil
    candidate_paths = nil
    candidate_index = 1
    stopped_polls = 0
    if plugin.get_play_mode() ~= "sequential" then return end

    if not path or path:match("^https?://") then return end

    candidate_paths = album_continuation(path, artist, album)
    if not candidate_paths and state.folders then
        candidate_paths = next_folder_tracks(path)
    end
end

local function rearm_current_track()
    -- A settings change drops any pending batches and starts over.
    continuation_batch = nil
    candidate_paths = nil
    candidate_index = 1
    local _, artist, album = plugin.get_now_playing()
    if not artist then
        candidate_paths = nil
        candidate_index = 1
        continuation_batch = nil
        stopped_polls = 0
        return
    end
    arm_continuation(nil, artist, album)
end

plugin.on("track_started", arm_continuation)

plugin.on("stopped", function()
    -- Explicit player/DAC/remote stops arrive here. Natural playlist-end is
    -- the documented event gap and is intentionally detected by the timer.
    candidate_paths = nil
    candidate_index = 1
    continuation_batch = nil
    stopped_polls = 0
end)

plugin.on("resumed", function() stopped_polls = 0 end)

local function continue_now()
    local first = candidate_index
    local last = math.min(#candidate_paths, first + 499)
    local paths = {}
    for i = first, last do paths[#paths + 1] = candidate_paths[i] end
    candidate_index = last + 1
    continuation_batch = paths
    if candidate_index > #candidate_paths then candidate_paths = nil end
    stopped_polls = 0
    plugin.play_list(paths, 1)
    plugin.show_toast(tr("Continuing playback"))
end

plugin.on("queue_exhausted", function(direction)
    if direction ~= 1 then return end
    if not candidate_paths or plugin.get_play_mode() ~= "sequential" then return end
    continue_now()
end)

plugin.set_interval(1, function()
    if not candidate_paths or plugin.get_play_mode() ~= "sequential" then
        stopped_polls = 0
        return
    end
    if plugin.is_playing() or plugin.is_paused() then
        stopped_polls = 0
        return
    end

    stopped_polls = stopped_polls + 1
    if stopped_polls < 2 then return end

    continue_now()
end)

local function open_about()
    plugin.show_list(tr("About Play Through"), {
        tr("Albums continue in the artist's alphabetical album order."),
        tr("Folders continue in lexical (alphabetical, case-insensitive) sibling-folder order."),
        tr("Album mode has priority when both options are enabled."),
        tr("Shuffle and repeat modes are left unchanged."),
    }, function() end)
end

local function open_settings()
    plugin.show_settings_list(tr("Play Through"), {
        {
            type = "toggle",
            label = tr("Play Through Folders"),
            value = state.folders,
            on_change = function(value)
                state.folders = value
                save_state()
                rearm_current_track()
            end,
        },
        {
            type = "toggle",
            label = tr("Play Through Albums"),
            value = state.albums,
            on_change = function(value)
                state.albums = value
                save_state()
                rearm_current_track()
            end,
        },
        {
            type = "row",
            label = tr("How It Works"),
            on_select = open_about,
        },
    })
end

load_state()
plugin.register_list_item("playback", tr("Play Through"), open_settings)
