plugin.define({ id = "example.net_radio", name = "Net Radio", version = "1.7.0", api_min = 19 })

local T = {
    de = {
        ["Net Radio"] = "Internetradio",
        ["Saved stations"] = "Gespeicherte Sender",
        ["Search stations"] = "Sender suchen",
        ["Station name"] = "Sendername",
        ["Could not open text entry. Try again."] = "Texteingabe konnte nicht geöffnet werden. Erneut versuchen.",
        ["Enter a station name"] = "Sendernamen eingeben",
        ["No more stations"] = "Keine weiteren Sender",
        ["Could not reach Radio Browser"] = "Radio Browser nicht erreichbar",
        ["Could not read station results"] = "Senderergebnisse konnten nicht gelesen werden",
        ["No playable stations found"] = "Keine abspielbaren Sender gefunden",
        ["Previous page"] = "Vorherige Seite",
        ["Next page"] = "Nächste Seite",
        ["Stations"] = "Sender",
        ["Play"] = "Abspielen",
        ["Save favorite"] = "Favorit speichern",
        ["No playable stations on this page"] = "Keine abspielbaren Sender auf dieser Seite",
        ["This station cannot be played"] = "Dieser Sender kann nicht abgespielt werden",
        ["No stations found in Radio.txt"] = "Keine Sender in Radio.txt gefunden",
        ["No playable stations in Radio.txt"] = "Keine abspielbaren Sender in Radio.txt",
        ["Some stations could not be listed"] = "Einige Sender konnten nicht aufgelistet werden",
        ["Check again"] = "Erneut prüfen",
        ["Radio.txt is too large to update"] = "Radio.txt ist zum Aktualisieren zu groß",
        ["Could not save that station"] = "Sender konnte nicht gespeichert werden",
        ["Already in Radio.txt"] = "Bereits in Radio.txt",
        ["Saved to Radio.txt"] = "In Radio.txt gespeichert",
    },
    es = {
        ["Net Radio"] = "Radio por internet",
        ["Saved stations"] = "Emisoras guardadas",
        ["Search stations"] = "Buscar emisoras",
        ["Station name"] = "Nombre de la emisora",
        ["Could not open text entry. Try again."] = "No se pudo abrir la entrada de texto. Inténtalo de nuevo.",
        ["Enter a station name"] = "Introduce el nombre de una emisora",
        ["No more stations"] = "No hay más emisoras",
        ["Could not reach Radio Browser"] = "No se pudo conectar con Radio Browser",
        ["Could not read station results"] = "No se pudieron leer los resultados de emisoras",
        ["No playable stations found"] = "No se encontraron emisoras reproducibles",
        ["Previous page"] = "Página anterior",
        ["Next page"] = "Página siguiente",
        ["Stations"] = "Emisoras",
        ["Play"] = "Reproducir",
        ["Save favorite"] = "Guardar favorita",
        ["No playable stations on this page"] = "No hay emisoras reproducibles en esta página",
        ["This station cannot be played"] = "Esta emisora no se puede reproducir",
        ["No stations found in Radio.txt"] = "No se encontraron emisoras en Radio.txt",
        ["No playable stations in Radio.txt"] = "No hay emisoras reproducibles en Radio.txt",
        ["Some stations could not be listed"] = "Algunas emisoras no se pudieron mostrar",
        ["Check again"] = "Comprobar de nuevo",
        ["Radio.txt is too large to update"] = "Radio.txt es demasiado grande para actualizar",
        ["Could not save that station"] = "No se pudo guardar esa emisora",
        ["Already in Radio.txt"] = "Ya está en Radio.txt",
        ["Saved to Radio.txt"] = "Guardada en Radio.txt",
    },
    fi = {
        ["Net Radio"] = "Nettiradio",
        ["Saved stations"] = "Tallennetut asemat",
        ["Search stations"] = "Hae asemia",
        ["Station name"] = "Aseman nimi",
        ["Could not open text entry. Try again."] = "Tekstinsyöttöä ei voitu avata. Yritä uudelleen.",
        ["Enter a station name"] = "Anna aseman nimi",
        ["No more stations"] = "Ei enempää asemia",
        ["Could not reach Radio Browser"] = "Radio Browseriin ei saatu yhteyttä",
        ["Could not read station results"] = "Asematuloksia ei voitu lukea",
        ["No playable stations found"] = "Toistettavia asemia ei löytynyt",
        ["Previous page"] = "Edellinen sivu",
        ["Next page"] = "Seuraava sivu",
        ["Stations"] = "Asemat",
        ["Play"] = "Toista",
        ["Save favorite"] = "Tallenna suosikki",
        ["No playable stations on this page"] = "Tällä sivulla ei ole toistettavia asemia",
        ["This station cannot be played"] = "Tätä asemaa ei voi toistaa",
        ["No stations found in Radio.txt"] = "Tiedostosta Radio.txt ei löytynyt asemia",
        ["No playable stations in Radio.txt"] = "Tiedostossa Radio.txt ei ole toistettavia asemia",
        ["Some stations could not be listed"] = "Joitakin asemia ei voitu näyttää",
        ["Check again"] = "Tarkista uudelleen",
        ["Radio.txt is too large to update"] = "Radio.txt on liian suuri päivitettäväksi",
        ["Could not save that station"] = "Asemaa ei voitu tallentaa",
        ["Already in Radio.txt"] = "Jo tiedostossa Radio.txt",
        ["Saved to Radio.txt"] = "Tallennettu tiedostoon Radio.txt",
    },
    fr = {
        ["Net Radio"] = "Radio Internet",
        ["Saved stations"] = "Stations enregistrées",
        ["Search stations"] = "Rechercher des stations",
        ["Station name"] = "Nom de la station",
        ["Could not open text entry. Try again."] = "Impossible d'ouvrir la saisie de texte. Réessayez.",
        ["Enter a station name"] = "Saisissez un nom de station",
        ["No more stations"] = "Plus aucune station",
        ["Could not reach Radio Browser"] = "Impossible de joindre Radio Browser",
        ["Could not read station results"] = "Impossible de lire les résultats des stations",
        ["No playable stations found"] = "Aucune station lisible trouvée",
        ["Previous page"] = "Page précédente",
        ["Next page"] = "Page suivante",
        ["Stations"] = "Stations",
        ["Play"] = "Lire",
        ["Save favorite"] = "Enregistrer en favori",
        ["No playable stations on this page"] = "Aucune station lisible sur cette page",
        ["This station cannot be played"] = "Cette station ne peut pas être lue",
        ["No stations found in Radio.txt"] = "Aucune station trouvée dans Radio.txt",
        ["No playable stations in Radio.txt"] = "Aucune station lisible dans Radio.txt",
        ["Some stations could not be listed"] = "Certaines stations n'ont pas pu être affichées",
        ["Check again"] = "Vérifier à nouveau",
        ["Radio.txt is too large to update"] = "Radio.txt est trop volumineux pour être mis à jour",
        ["Could not save that station"] = "Impossible d'enregistrer cette station",
        ["Already in Radio.txt"] = "Déjà dans Radio.txt",
        ["Saved to Radio.txt"] = "Enregistré dans Radio.txt",
    },
    it = {
        ["Net Radio"] = "Radio internet",
        ["Saved stations"] = "Stazioni salvate",
        ["Search stations"] = "Cerca stazioni",
        ["Station name"] = "Nome stazione",
        ["Could not open text entry. Try again."] = "Impossibile aprire l'inserimento testo. Riprova.",
        ["Enter a station name"] = "Inserisci il nome di una stazione",
        ["No more stations"] = "Nessun'altra stazione",
        ["Could not reach Radio Browser"] = "Impossibile raggiungere Radio Browser",
        ["Could not read station results"] = "Impossibile leggere i risultati delle stazioni",
        ["No playable stations found"] = "Nessuna stazione riproducibile trovata",
        ["Previous page"] = "Pagina precedente",
        ["Next page"] = "Pagina successiva",
        ["Stations"] = "Stazioni",
        ["Play"] = "Riproduci",
        ["Save favorite"] = "Salva nei preferiti",
        ["No playable stations on this page"] = "Nessuna stazione riproducibile in questa pagina",
        ["This station cannot be played"] = "Questa stazione non può essere riprodotta",
        ["No stations found in Radio.txt"] = "Nessuna stazione trovata in Radio.txt",
        ["No playable stations in Radio.txt"] = "Nessuna stazione riproducibile in Radio.txt",
        ["Some stations could not be listed"] = "Alcune stazioni non possono essere elencate",
        ["Check again"] = "Controlla di nuovo",
        ["Radio.txt is too large to update"] = "Radio.txt è troppo grande per essere aggiornato",
        ["Could not save that station"] = "Impossibile salvare questa stazione",
        ["Already in Radio.txt"] = "Già presente in Radio.txt",
        ["Saved to Radio.txt"] = "Salvata in Radio.txt",
    },
    ja = {
        ["Net Radio"] = "ネットラジオ",
        ["Saved stations"] = "保存済みの放送局",
        ["Search stations"] = "放送局を検索",
        ["Station name"] = "放送局名",
        ["Could not open text entry. Try again."] = "テキスト入力を開けませんでした。もう一度お試しください。",
        ["Enter a station name"] = "放送局名を入力してください",
        ["No more stations"] = "これ以上放送局はありません",
        ["Could not reach Radio Browser"] = "Radio Browser に接続できませんでした",
        ["Could not read station results"] = "検索結果を読み込めませんでした",
        ["No playable stations found"] = "再生可能な放送局が見つかりません",
        ["Previous page"] = "前のページ",
        ["Next page"] = "次のページ",
        ["Stations"] = "放送局",
        ["Play"] = "再生",
        ["Save favorite"] = "お気に入りに保存",
        ["No playable stations on this page"] = "このページに再生可能な放送局はありません",
        ["This station cannot be played"] = "この放送局は再生できません",
        ["No stations found in Radio.txt"] = "Radio.txt に放送局が見つかりません",
        ["No playable stations in Radio.txt"] = "Radio.txt に再生可能な放送局がありません",
        ["Some stations could not be listed"] = "一部の放送局を表示できませんでした",
        ["Check again"] = "再確認",
        ["Radio.txt is too large to update"] = "Radio.txt が大きすぎて更新できません",
        ["Could not save that station"] = "その放送局を保存できませんでした",
        ["Already in Radio.txt"] = "すでに Radio.txt にあります",
        ["Saved to Radio.txt"] = "Radio.txt に保存しました",
    },
    nl = {
        ["Net Radio"] = "Internetradio",
        ["Saved stations"] = "Opgeslagen zenders",
        ["Search stations"] = "Zenders zoeken",
        ["Station name"] = "Zendernaam",
        ["Could not open text entry. Try again."] = "Kon tekstinvoer niet openen. Probeer het opnieuw.",
        ["Enter a station name"] = "Voer een zendernaam in",
        ["No more stations"] = "Geen zenders meer",
        ["Could not reach Radio Browser"] = "Kon Radio Browser niet bereiken",
        ["Could not read station results"] = "Kon zenderresultaten niet lezen",
        ["No playable stations found"] = "Geen afspeelbare zenders gevonden",
        ["Previous page"] = "Vorige pagina",
        ["Next page"] = "Volgende pagina",
        ["Stations"] = "Zenders",
        ["Play"] = "Afspelen",
        ["Save favorite"] = "Favoriet opslaan",
        ["No playable stations on this page"] = "Geen afspeelbare zenders op deze pagina",
        ["This station cannot be played"] = "Deze zender kan niet worden afgespeeld",
        ["No stations found in Radio.txt"] = "Geen zenders gevonden in Radio.txt",
        ["No playable stations in Radio.txt"] = "Geen afspeelbare zenders in Radio.txt",
        ["Some stations could not be listed"] = "Sommige zenders konden niet worden getoond",
        ["Check again"] = "Opnieuw controleren",
        ["Radio.txt is too large to update"] = "Radio.txt is te groot om bij te werken",
        ["Could not save that station"] = "Kon die zender niet opslaan",
        ["Already in Radio.txt"] = "Staat al in Radio.txt",
        ["Saved to Radio.txt"] = "Opgeslagen in Radio.txt",
    },
    pt = {
        ["Net Radio"] = "Rádio na Internet",
        ["Saved stations"] = "Estações salvas",
        ["Search stations"] = "Pesquisar estações",
        ["Station name"] = "Nome da estação",
        ["Could not open text entry. Try again."] = "Não foi possível abrir a entrada de texto. Tente novamente.",
        ["Enter a station name"] = "Digite o nome de uma estação",
        ["No more stations"] = "Não há mais estações",
        ["Could not reach Radio Browser"] = "Não foi possível conectar ao Radio Browser",
        ["Could not read station results"] = "Não foi possível ler os resultados das estações",
        ["No playable stations found"] = "Nenhuma estação reproduzível encontrada",
        ["Previous page"] = "Página anterior",
        ["Next page"] = "Próxima página",
        ["Stations"] = "Estações",
        ["Play"] = "Reproduzir",
        ["Save favorite"] = "Salvar favorita",
        ["No playable stations on this page"] = "Nenhuma estação reproduzível nesta página",
        ["This station cannot be played"] = "Esta estação não pode ser reproduzida",
        ["No stations found in Radio.txt"] = "Nenhuma estação encontrada em Radio.txt",
        ["No playable stations in Radio.txt"] = "Nenhuma estação reproduzível em Radio.txt",
        ["Some stations could not be listed"] = "Algumas estações não puderam ser listadas",
        ["Check again"] = "Verificar novamente",
        ["Radio.txt is too large to update"] = "Radio.txt é grande demais para atualizar",
        ["Could not save that station"] = "Não foi possível salvar essa estação",
        ["Already in Radio.txt"] = "Já está em Radio.txt",
        ["Saved to Radio.txt"] = "Salva em Radio.txt",
    },
    ru = {
        ["Net Radio"] = "Интернет-радио",
        ["Saved stations"] = "Сохранённые станции",
        ["Search stations"] = "Поиск станций",
        ["Station name"] = "Название станции",
        ["Could not open text entry. Try again."] = "Не удалось открыть ввод текста. Повторите попытку.",
        ["Enter a station name"] = "Введите название станции",
        ["No more stations"] = "Больше станций нет",
        ["Could not reach Radio Browser"] = "Не удалось подключиться к Radio Browser",
        ["Could not read station results"] = "Не удалось прочитать список станций",
        ["No playable stations found"] = "Доступных для воспроизведения станций не найдено",
        ["Previous page"] = "Предыдущая страница",
        ["Next page"] = "Следующая страница",
        ["Stations"] = "Станции",
        ["Play"] = "Воспроизвести",
        ["Save favorite"] = "В избранное",
        ["No playable stations on this page"] = "На этой странице нет доступных станций",
        ["This station cannot be played"] = "Эту станцию нельзя воспроизвести",
        ["No stations found in Radio.txt"] = "В Radio.txt станции не найдены",
        ["No playable stations in Radio.txt"] = "В Radio.txt нет доступных станций",
        ["Some stations could not be listed"] = "Некоторые станции не удалось показать",
        ["Check again"] = "Проверить снова",
        ["Radio.txt is too large to update"] = "Radio.txt слишком велик для обновления",
        ["Could not save that station"] = "Не удалось сохранить станцию",
        ["Already in Radio.txt"] = "Уже есть в Radio.txt",
        ["Saved to Radio.txt"] = "Сохранено в Radio.txt",
    },
    uk = {
        ["Net Radio"] = "Інтернет-радіо",
        ["Saved stations"] = "Збережені станції",
        ["Search stations"] = "Пошук станцій",
        ["Station name"] = "Назва станції",
        ["Could not open text entry. Try again."] = "Не вдалося відкрити введення тексту. Спробуйте знову.",
        ["Enter a station name"] = "Введіть назву станції",
        ["No more stations"] = "Більше станцій немає",
        ["Could not reach Radio Browser"] = "Не вдалося підключитися до Radio Browser",
        ["Could not read station results"] = "Не вдалося прочитати результати пошуку станцій",
        ["No playable stations found"] = "Придатних до відтворення станцій не знайдено",
        ["Previous page"] = "Попередня сторінка",
        ["Next page"] = "Наступна сторінка",
        ["Stations"] = "Станції",
        ["Play"] = "Відтворити",
        ["Save favorite"] = "До вибраного",
        ["No playable stations on this page"] = "На цій сторінці немає придатних станцій",
        ["This station cannot be played"] = "Цю станцію неможливо відтворити",
        ["No stations found in Radio.txt"] = "У Radio.txt станцій не знайдено",
        ["No playable stations in Radio.txt"] = "У Radio.txt немає придатних станцій",
        ["Some stations could not be listed"] = "Деякі станції не вдалося показати",
        ["Check again"] = "Перевірити знову",
        ["Radio.txt is too large to update"] = "Radio.txt завеликий для оновлення",
        ["Could not save that station"] = "Не вдалося зберегти цю станцію",
        ["Already in Radio.txt"] = "Вже є в Radio.txt",
        ["Saved to Radio.txt"] = "Збережено до Radio.txt",
    },
    vi = {
        ["Net Radio"] = "Radio trực tuyến",
        ["Saved stations"] = "Đài đã lưu",
        ["Search stations"] = "Tìm đài phát",
        ["Station name"] = "Tên đài phát",
        ["Could not open text entry. Try again."] = "Không mở được ô nhập văn bản. Hãy thử lại.",
        ["Enter a station name"] = "Nhập tên đài phát",
        ["No more stations"] = "Không còn đài nào nữa",
        ["Could not reach Radio Browser"] = "Không kết nối được Radio Browser",
        ["Could not read station results"] = "Không đọc được kết quả đài phát",
        ["No playable stations found"] = "Không tìm thấy đài nào phát được",
        ["Previous page"] = "Trang trước",
        ["Next page"] = "Trang sau",
        ["Stations"] = "Đài phát",
        ["Play"] = "Phát",
        ["Save favorite"] = "Lưu yêu thích",
        ["No playable stations on this page"] = "Không có đài nào phát được trên trang này",
        ["This station cannot be played"] = "Không thể phát đài này",
        ["No stations found in Radio.txt"] = "Không tìm thấy đài nào trong Radio.txt",
        ["No playable stations in Radio.txt"] = "Không có đài nào phát được trong Radio.txt",
        ["Some stations could not be listed"] = "Không thể hiển thị một số đài",
        ["Check again"] = "Kiểm tra lại",
        ["Radio.txt is too large to update"] = "Radio.txt quá lớn để cập nhật",
        ["Could not save that station"] = "Không thể lưu đài đó",
        ["Already in Radio.txt"] = "Đã có trong Radio.txt",
        ["Saved to Radio.txt"] = "Đã lưu vào Radio.txt",
    },
    zh_CN = {
        ["Net Radio"] = "网络电台",
        ["Saved stations"] = "已保存的电台",
        ["Search stations"] = "搜索电台",
        ["Station name"] = "电台名称",
        ["Could not open text entry. Try again."] = "无法打开文本输入。请重试。",
        ["Enter a station name"] = "请输入电台名称",
        ["No more stations"] = "没有更多电台",
        ["Could not reach Radio Browser"] = "无法连接到 Radio Browser",
        ["Could not read station results"] = "无法读取电台搜索结果",
        ["No playable stations found"] = "未找到可播放的电台",
        ["Previous page"] = "上一页",
        ["Next page"] = "下一页",
        ["Stations"] = "电台",
        ["Play"] = "播放",
        ["Save favorite"] = "保存收藏",
        ["No playable stations on this page"] = "此页没有可播放的电台",
        ["This station cannot be played"] = "无法播放此电台",
        ["No stations found in Radio.txt"] = "Radio.txt 中未找到电台",
        ["No playable stations in Radio.txt"] = "Radio.txt 中没有可播放的电台",
        ["Some stations could not be listed"] = "部分电台无法列出",
        ["Check again"] = "重新检查",
        ["Radio.txt is too large to update"] = "Radio.txt 过大，无法更新",
        ["Could not save that station"] = "无法保存该电台",
        ["Already in Radio.txt"] = "已在 Radio.txt 中",
        ["Saved to Radio.txt"] = "已保存到 Radio.txt",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

-- Searches the Radio Browser directory and appends favorites to Radio.txt
-- in the same "Name | http(s)://direct-stream" form Net Radio already reads.
-- Existing Radio.txt bytes are only extended, never rewritten.

local RADIO_FILE = plugin.sd_root() .. "/Radio.txt"
local USER_AGENT = "Compas/1.0"
local PAGE_SIZE = 20
local MAX_SERVER_ATTEMPTS = 4
local MAX_OFFSET = 480
local MAX_FILE_BYTES, MAX_LINE_BYTES, MAX_STATIONS = 65536, 1024, 500
-- plugin.play_list copies each path into char[512], so 511 bytes is the limit.
local MAX_PLAY_URL = 511
local FALLBACK_SERVERS = {
    "https://de1.api.radio-browser.info",
    "https://all.api.radio-browser.info",
}

local servers = { FALLBACK_SERVERS[1], FALLBACK_SERVERS[2] }
local discovery_started = false
local search_generation = 0

local function trim(value)
    return (tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function url_encode(value)
    return (tostring(value):gsub("([^%w%-%.%_%~])", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

local function lower_scheme(url)
    return (url:gsub("^([Hh][Tt][Tt][Pp][Ss]?)://", function(scheme)
        return scheme:lower() .. "://"
    end))
end

local function sanitize_name(name)
    local text = tostring(name or ""):gsub("[%c|]", " ")
    text = trim(text:gsub("%s+", " "))
    if text == "" then text = "Station" end
    if #text > 120 then text = text:sub(1, 120) end
    return text
end

local function sanitize_query(query)
    local text = tostring(query or ""):gsub("%c", " ")
    text = trim(text:gsub("%s+", " "))
    if #text > 80 then text = text:sub(1, 80) end
    return text
end

local function unsupported_path(url)
    local path = url:match("^https?://[^/%?#]+([^?#]*)") or ""
    path = path:lower()
    return path:match("%.m3u8?$") ~= nil
        or path:match("%.pls$") ~= nil
        or path:match("%.asx$") ~= nil
        or path:match("%.xspf$") ~= nil
        or path:match("%.ogg$") ~= nil
        or path:match("%.oga$") ~= nil
        or path:match("%.opus$") ~= nil
        or path:match("%.wav$") ~= nil
        or path:match("%.wma$") ~= nil
end

local function valid_authority(authority)
    if type(authority) ~= "string" or authority == "" then return false end
    if authority:find("@", 1, true) or authority:find("?", 1, true) or authority:find("#", 1, true) then
        return false
    end
    local host, port = authority:match("^([%w%-%.]+):(%d+)$")
    if not host then host = authority:match("^([%w%-%.]+)$") end
    if not host or host == "" or port == "" then return false end
    if host:sub(1, 1) == "." or host:sub(-1) == "." then return false end
    return true
end

local function normalized_base(url)
    if type(url) ~= "string" then return nil end
    if url:find("%c") or url:find("%s") or url:find("|", 1, true) then return nil end
    local base = lower_scheme(url:gsub("#.*$", ""))
    local scheme, authority = base:match("^(https?)://([^/%?#]*)")
    if not scheme or not valid_authority(authority) then return nil end
    if #base > MAX_PLAY_URL or unsupported_path(base) then return nil end
    return base
end

local function canonical_url(url)
    local base = normalized_base(url)
    if not base then return nil end
    local scheme, host, rest = base:match("^(https?)://([^/%?#]+)(.*)$")
    if not scheme or not host then return nil end
    host = host:lower()
    if scheme == "http" then host = host:gsub(":80$", "") end
    if scheme == "https" then host = host:gsub(":443$", "") end
    return scheme .. "://" .. host .. (rest or "")
end

local function codec_kind(codec)
    local kind = tostring(codec or ""):lower():gsub("%s+", "")
    if kind == "mp3" then return "mp3" end
    if kind == "flac" then return "flac" end
    if kind == "aac" then return "aac" end
    if kind == "aac+" or kind == "aacp" or kind == "aacplus" then return "aacp" end
    return nil
end

local function is_hls(value)
    if value == true then return true end
    return tonumber(value) == 1
end

local function apply_hint(base, kind)
    if kind == "flac" then return base .. "#.flac" end
    if kind == "aac" then return base .. "#.aac" end
    if kind == "aacp" then return base .. "#.aacp" end
    return base
end

local function playable_url(station)
    if type(station) ~= "table" or is_hls(station.hls) then return nil end
    local kind = codec_kind(station.codec)
    if not kind then return nil end
    local base = normalized_base(station.url_resolved)
    if not base then base = normalized_base(station.url) end
    if not base then return nil end
    local hinted = apply_hint(base, kind)
    if #hinted > MAX_PLAY_URL then return nil end
    return hinted
end

local function clean_uuid(value)
    if type(value) ~= "string" then return nil end
    local uuid = value:lower()
    if not uuid:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
        return nil
    end
    return uuid
end

local function backend_url(name)
    if type(name) ~= "string" then return nil end
    local host = name:lower()
    if host:find("..", 1, true) then return nil end
    if not host:match("^[a-z0-9%-%.]+%.api%.radio%-browser%.info$") then return nil end
    return "https://" .. host
end

local function is_list(value)
    if type(value) ~= "table" then return false end
    local count = 0
    for key in pairs(value) do
        if type(key) ~= "number" then return false end
        count = count + 1
    end
    return count == #value
end

local function http_json(method, url, body, limit, callback)
    local options = {
        url = url,
        method = method,
        headers = { ["User-Agent"] = USER_AGENT },
        verify_tls = true,
        max_response_bytes = limit,
        connect_timeout_ms = 8000,
        read_timeout_ms = 12000,
        total_timeout_ms = 20000,
        redirect_limit = 0,
    }
    if body then
        options.body = body
        options.content_type = "application/x-www-form-urlencoded"
    end
    return plugin.http_request(options, callback)
end

local function form_body(query, offset)
    return "name=" .. url_encode(query)
        .. "&limit=" .. tostring(PAGE_SIZE)
        .. "&offset=" .. tostring(offset)
        .. "&hidebroken=true&order=name"
end

-- Same line rules as Net Radio: comments and blanks ignored, "Name | URL"
-- or a bare http(s) URL. `limit` caps the list used by the screen. Dedupe
-- passes no limit so a duplicate past the first 500 still matches.
local function scan_stations(body, limit)
    local labels, urls = {}, {}
    local truncated = false
    if type(body) ~= "string" then return labels, urls, truncated end
    if #body > MAX_FILE_BYTES then
        body = body:sub(1, MAX_FILE_BYTES):match("^(.*)\n") or ""
        truncated = true
    end
    for line in (body .. "\n"):gmatch("(.-)\n") do
        if #line > MAX_LINE_BYTES then
            truncated = true
        else
            local text = trim(line:gsub("\r$", ""))
            if text ~= "" and text:sub(1, 1) ~= "#" then
                local name, url = text:match("^(.-)%s*|%s*(https?://.+)$")
                if not url and text:match("^https?://") then
                    name, url = text, text
                end
                if url and limit and #urls >= limit then
                    truncated = true
                    break
                end
                if url then
                    name, url = trim(name), trim(url)
                    if name == "" then name = url end
                    labels[#labels + 1] = name
                    urls[#urls + 1] = url
                end
            end
        end
    end
    return labels, urls, truncated
end

local function parse_stations(body)
    return scan_stations(body, MAX_STATIONS)
end

local function read_radio()
    local file = io.open(RADIO_FILE, "rb")
    if not file then return nil end
    local body = file:read(MAX_FILE_BYTES + 1) or ""
    file:close()
    return body
end

local function already_saved(play_url)
    local body = read_radio()
    if not body then return false end
    if #body > MAX_FILE_BYTES then return nil end
    local want = canonical_url(play_url)
    if not want then return nil end
    local _, urls = scan_stations(body)
    for i = 1, #urls do
        if canonical_url(urls[i]) == want then return true end
    end
    return false
end

local function append_line(line)
    local file, _, open_error = io.open(RADIO_FILE, "r+b")
    if not file then
        -- Only ENOENT proves the path is missing. Permission and other
        -- errors must preserve the file, even if write-only access works.
        if open_error ~= 2 or #line > MAX_FILE_BYTES then return false end
        file = io.open(RADIO_FILE, "ab")
        if not file then return false end
        -- Append mode also protects a file created between the two opens.
        if file:seek("end") ~= 0 then
            file:close()
            return false
        end
        local ok = file:write(line)
        local closed = file:close()
        return ok and closed and true
    end
    local size = file:seek("end")
    if type(size) ~= "number" then
        file:close()
        return false
    end
    local extra = #line
    if size > 0 then
        if not file:seek("set", size - 1) then
            file:close()
            return false
        end
        local last = file:read(1)
        if not file:seek("end") then
            file:close()
            return false
        end
        if last ~= "\n" then extra = extra + 1 end
    end
    if size + extra > MAX_FILE_BYTES then
        file:close()
        plugin.show_toast(tr("Radio.txt is too large to update"))
        return false
    end
    if extra ~= #line and not file:write("\n") then
        file:close()
        return false
    end
    local ok = file:write(line)
    local closed = file:close()
    return ok and closed and true
end

local function append_favorite(name, play_url)
    if type(play_url) ~= "string" or #play_url > MAX_PLAY_URL or not normalized_base(play_url) then
        plugin.show_toast(tr("Could not save that station"))
        return false
    end
    if play_url:find("%c") or play_url:find("%s") or play_url:find("|", 1, true) then
        plugin.show_toast(tr("Could not save that station"))
        return false
    end
    local hint = play_url:match("#(%.flac)$") or play_url:match("#(%.aacp)$") or play_url:match("#(%.aac)$")
    if play_url:find("#", 1, true) and not hint then
        plugin.show_toast(tr("Could not save that station"))
        return false
    end
    local safe_name = sanitize_name(name)
    local line = safe_name .. " | " .. play_url .. "\n"
    if #line > MAX_LINE_BYTES then
        plugin.show_toast(tr("Could not save that station"))
        return false
    end
    local saved = already_saved(play_url)
    if saved == nil then
        plugin.show_toast(tr("Radio.txt is too large to update"))
        return false
    end
    if saved then
        plugin.show_toast(tr("Already in Radio.txt"))
        return true
    end
    if not append_line(line) then
        plugin.show_toast(tr("Could not save that station"))
        return false
    end
    plugin.show_toast(tr("Saved to Radio.txt"))
    return true
end

local function open_favorites()
    local body = read_radio()
    if not body or body == "" then
        plugin.show_list(tr("No stations found in Radio.txt"), { tr("Check again") }, function(index)
            if index == 1 then open_favorites() end
        end)
        return
    end
    if #body > MAX_FILE_BYTES then
        plugin.show_toast(tr("Some stations could not be listed"))
    end
    local labels, urls, truncated = parse_stations(body)
    if #urls == 0 then
        plugin.show_list(tr("No stations found in Radio.txt"), { tr("Check again") }, function(index)
            if index == 1 then open_favorites() end
        end)
        return
    end
    local safe_labels, safe_urls = {}, {}
    local skipped = false
    for i, url in ipairs(urls) do
        if #url <= MAX_PLAY_URL and normalized_base(url) then
            safe_labels[#safe_labels + 1] = labels[i]
            safe_urls[#safe_urls + 1] = url
        else
            skipped = true
        end
    end
    if #safe_urls == 0 then
        plugin.show_list(tr("No playable stations in Radio.txt"), { tr("Check again") }, function(index)
            if index == 1 then open_favorites() end
        end)
        return
    end
    plugin.show_list(tr("Saved stations"), safe_labels, function(index)
        if safe_urls[index] then plugin.play_list(safe_urls, index) end
    end)
    if truncated or skipped then plugin.show_toast(tr("Some stations could not be listed")) end
end

local function report_click(server, uuid)
    if not server or not uuid then return end
    http_json("GET", server .. "/json/url/" .. uuid, nil, 8192, function() end)
end

local function play_station(station)
    if not station or not station.play_url then
        plugin.show_toast(tr("This station cannot be played"))
        return
    end
    plugin.play_list({ station.play_url }, 1)
    report_click(station.server, station.uuid)
end

local begin_search

local function show_page(data, server, query, offset, generation)
    if generation ~= search_generation then return end
    local raw_count = math.min(#data, PAGE_SIZE)
    local visible = {}
    for i = 1, raw_count do
        local row = data[i]
        if type(row) == "table" then
            local play_url = playable_url(row)
            if play_url then
                visible[#visible + 1] = {
                    name = sanitize_name(row.name),
                    play_url = play_url,
                    uuid = clean_uuid(row.stationuuid),
                    server = server,
                }
            end
        end
    end
    if generation ~= search_generation then return end
    if #visible == 0 and raw_count < PAGE_SIZE then
        plugin.show_toast(tr("No playable stations found"))
        return
    end
    local items = {}
    for i = 1, #visible do items[i] = visible[i].name end
    local previous_at, next_at = nil, nil
    if offset > 0 then
        items[#items + 1] = tr("Previous page")
        previous_at = #items
    end
    if raw_count >= PAGE_SIZE and offset + PAGE_SIZE <= MAX_OFFSET then
        items[#items + 1] = tr("Next page")
        next_at = #items
    end
    if #items == 0 then
        plugin.show_toast(tr("No playable stations found"))
        return
    end
    plugin.show_list(tr("Stations"), items, function(index)
        if index == previous_at then
            begin_search(query, offset - PAGE_SIZE)
            return
        end
        if index == next_at then
            begin_search(query, offset + PAGE_SIZE)
            return
        end
        local station = visible[index]
        if not station then return end
        plugin.show_list(station.name, { tr("Play"), tr("Save favorite") }, function(action)
            if action == 1 then play_station(station)
            elseif action == 2 then append_favorite(station.name, station.play_url) end
        end)
    end)
    if #visible == 0 then
        plugin.show_toast(tr("No playable stations on this page"))
    end
end

local function ensure_discovery()
    if discovery_started then return end
    discovery_started = true
    http_json("GET", FALLBACK_SERVERS[1] .. "/json/servers", nil, 16384, function(status, body, err)
        if err or status ~= 200 or type(body) ~= "string" then return end
        local data = plugin.json_decode(body)
        if not is_list(data) then return end
        local found = {}
        local function add(url)
            if not url or #found >= 4 then return end
            for i = 1, #found do
                if found[i] == url then return end
            end
            found[#found + 1] = url
        end
        for i = 1, math.min(#data, 8) do
            if #found >= 2 then break end
            local row = data[i]
            if type(row) == "table" then add(backend_url(row.name)) end
        end
        if #found > 0 then
            for _, fallback in ipairs(FALLBACK_SERVERS) do add(fallback) end
            servers = found
        end
    end)
end

local function failover(status, err)
    if err or type(status) ~= "number" then return true end
    if status == 408 or status == 429 or status >= 500 then return true end
    if status >= 300 and status < 400 then return true end
    return false
end

begin_search = function(query, offset)
    query = sanitize_query(query)
    if query == "" then
        plugin.show_toast(tr("Enter a station name"))
        return
    end
    offset = math.floor(tonumber(offset) or 0)
    if offset < 0 then offset = 0 end
    if offset > MAX_OFFSET then
        plugin.show_toast(tr("No more stations"))
        return
    end
    search_generation = search_generation + 1
    local generation = search_generation
    ensure_discovery()
    -- Discovery updates later searches without reshuffling an active retry.
    local search_servers = {}
    for i, server in ipairs(servers) do search_servers[i] = server end
    local tries = 0
    local function attempt(index)
        if generation ~= search_generation then return end
        tries = tries + 1
        if tries > MAX_SERVER_ATTEMPTS or not search_servers[index] then
            plugin.show_toast(tr("Could not reach Radio Browser"))
            return
        end
        local server = search_servers[index]
        local handle = http_json("POST", server .. "/json/stations/search", form_body(query, offset), 65536,
            function(status, body, err)
                if generation ~= search_generation then return end
                if failover(status, err) then
                    attempt(index + 1)
                    return
                end
                local data = type(body) == "string" and plugin.json_decode(body) or nil
                if status ~= 200 or not is_list(data) then
                    if tries < MAX_SERVER_ATTEMPTS and search_servers[index + 1] then
                        attempt(index + 1)
                    else
                        plugin.show_toast(tr("Could not read station results"))
                    end
                    return
                end
                show_page(data, server, query, offset, generation)
            end)
        if not handle then attempt(index + 1) end
    end
    attempt(1)
end

local function prompt_search()
    local ok = plugin.show_text_input(tr("Station name"), nil, false, function(text)
        if text == nil or trim(text) == "" then return end
        begin_search(text, 0)
    end)
    if not ok then plugin.show_toast(tr("Could not open text entry. Try again.")) end
end

local function open_browser()
    plugin.show_list(tr("Net Radio"), { tr("Saved stations"), tr("Search stations") }, function(index)
        if index == 1 then open_favorites()
        elseif index == 2 then prompt_search() end
    end)
end

plugin.register_stream_media_tile(tr("Net Radio"), open_browser, "stream_media/radio_row.png")

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        open_browser = open_browser,
        open_favorites = open_favorites,
        playable_url = playable_url,
        canonical_url = canonical_url,
        sanitize_name = sanitize_name,
        parse_stations = parse_stations,
        append_favorite = append_favorite,
        search = begin_search,
    }
end
