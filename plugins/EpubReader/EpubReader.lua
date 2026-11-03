plugin.define({
    id = "example.epub_reader",
    name = "EPUB Reader",
    version = "2.2.0",
    api_min = 19,
})

-- Translations for plugin.tr. Strings the player already knows (Small,
-- Large, Custom) are left out so its own catalog supplies them. pt covers
-- pt_BR and pt_PT.
local T = {
    de = {
        ["Chapters"] = "Kapitel",
        ["Font size"] = "Schriftgröße",
        ["Background colour"] = "Hintergrundfarbe",
        ["Normal"] = "Normal",
        ["Extra large"] = "Extragroß",
        ["Theme"] = "Design",
        ["Sepia"] = "Sepia",
        ["White"] = "Weiß",
        ["Dark"] = "Dunkel",
        ["Black"] = "Schwarz",
        ["Nothing to read"] = "Nichts zu lesen",
        ["End of book"] = "Ende des Buches",
        ["Empty spine"] = "Leere Kapitelliste",
        ["Spine truncated"] = "Kapitelliste gekürzt",
        ["Preparing pictures. This may take a while."] = "Bilder werden vorbereitet. Das kann dauern.",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "Keine EPUB-Bücher gefunden\nKopiere EPUB-Dateien in den Ordner Books auf deiner SD-Karte.",
        ["Refresh library"] = "Bibliothek aktualisieren",
        ["Section %d"] = "Abschnitt %d",
        ["EPUB Reader"] = "EPUB-Leser",
        ["Failed to read container.xml"] = "container.xml konnte nicht gelesen werden",
        ["No OPF in container.xml"] = "Kein OPF in container.xml",
        ["Failed to read OPF"] = "OPF konnte nicht gelesen werden",
        ["Missing manifest item"] = "Manifest-Eintrag fehlt",
        ["Failed to read chapter"] = "Kapitel konnte nicht gelesen werden",
        ["Failed to parse chapter"] = "Kapitel konnte nicht verarbeitet werden",
        ["unavailable"] = "nicht verfügbar",
    },
    es = {
        ["Chapters"] = "Capítulos",
        ["Font size"] = "Tamaño de letra",
        ["Background colour"] = "Color de fondo",
        ["Normal"] = "Normal",
        ["Extra large"] = "Muy grande",
        ["Theme"] = "Tema",
        ["Sepia"] = "Sepia",
        ["White"] = "Blanco",
        ["Dark"] = "Oscuro",
        ["Black"] = "Negro",
        ["Nothing to read"] = "Nada que leer",
        ["End of book"] = "Fin del libro",
        ["Empty spine"] = "Sin capítulos",
        ["Spine truncated"] = "Capítulos truncados",
        ["Preparing pictures. This may take a while."] = "Preparando imágenes. Esto puede tardar.",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "No se encontraron libros EPUB\nCopia archivos EPUB a la carpeta Books de tu tarjeta SD.",
        ["Refresh library"] = "Refrescar biblioteca",
        ["Section %d"] = "Sección %d",
        ["EPUB Reader"] = "Lector EPUB",
        ["Failed to read container.xml"] = "No se pudo leer container.xml",
        ["No OPF in container.xml"] = "No hay OPF en container.xml",
        ["Failed to read OPF"] = "No se pudo leer el OPF",
        ["Missing manifest item"] = "Falta un elemento del manifiesto",
        ["Failed to read chapter"] = "No se pudo leer el capítulo",
        ["Failed to parse chapter"] = "No se pudo procesar el capítulo",
        ["unavailable"] = "no disponible",
    },
    fi = {
        ["Chapters"] = "Luvut",
        ["Font size"] = "Fontin koko",
        ["Background colour"] = "Taustaväri",
        ["Normal"] = "Normaali",
        ["Extra large"] = "Erittäin suuri",
        ["Theme"] = "Teema",
        ["Sepia"] = "Seepia",
        ["White"] = "Valkoinen",
        ["Dark"] = "Tumma",
        ["Black"] = "Musta",
        ["Nothing to read"] = "Ei luettavaa",
        ["End of book"] = "Kirjan loppu",
        ["Empty spine"] = "Tyhjä sisällysluettelo",
        ["Spine truncated"] = "Sisällysluettelo katkaistu",
        ["Preparing pictures. This may take a while."] = "Valmistellaan kuvia. Tämä voi kestää.",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "EPUB-kirjoja ei löytynyt\nKopioi EPUB-tiedostot SD-korttisi Books-kansioon.",
        ["Refresh library"] = "Päivitä kirjasto",
        ["Section %d"] = "Osa %d",
        ["EPUB Reader"] = "EPUB-lukija",
        ["Failed to read container.xml"] = "container.xml-tiedoston luku epäonnistui",
        ["No OPF in container.xml"] = "container.xml:ssä ei ole OPF-tiedostoa",
        ["Failed to read OPF"] = "OPF-tiedoston luku epäonnistui",
        ["Missing manifest item"] = "Manifestin kohde puuttuu",
        ["Failed to read chapter"] = "Luvun lukeminen epäonnistui",
        ["Failed to parse chapter"] = "Luvun jäsentäminen epäonnistui",
        ["unavailable"] = "ei saatavilla",
    },
    fr = {
        ["Chapters"] = "Chapitres",
        ["Font size"] = "Taille de police",
        ["Background colour"] = "Couleur de fond",
        ["Normal"] = "Normale",
        ["Extra large"] = "Très grand",
        ["Theme"] = "Thème",
        ["Sepia"] = "Sépia",
        ["White"] = "Blanc",
        ["Dark"] = "Sombre",
        ["Black"] = "Noir",
        ["Nothing to read"] = "Rien à lire",
        ["End of book"] = "Fin du livre",
        ["Empty spine"] = "Livre sans chapitres",
        ["Spine truncated"] = "Liste des chapitres tronquée",
        ["Preparing pictures. This may take a while."] = "Préparation des images. Cela peut prendre du temps.",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "Aucun livre EPUB trouvé\nCopiez des fichiers EPUB dans le dossier Books de votre carte SD.",
        ["Refresh library"] = "Actualiser la bibliothèque",
        ["Section %d"] = "Section %d",
        ["EPUB Reader"] = "Lecteur EPUB",
        ["Failed to read container.xml"] = "Échec de lecture de container.xml",
        ["No OPF in container.xml"] = "Pas d'OPF dans container.xml",
        ["Failed to read OPF"] = "Échec de lecture de l'OPF",
        ["Missing manifest item"] = "Élément du manifeste manquant",
        ["Failed to read chapter"] = "Échec de lecture du chapitre",
        ["Failed to parse chapter"] = "Échec d'analyse du chapitre",
        ["unavailable"] = "indisponible",
    },
    it = {
        ["Chapters"] = "Capitoli",
        ["Font size"] = "Dimensione carattere",
        ["Background colour"] = "Colore di sfondo",
        ["Normal"] = "Normale",
        ["Extra large"] = "Molto grande",
        ["Theme"] = "Tema",
        ["Sepia"] = "Seppia",
        ["White"] = "Bianco",
        ["Dark"] = "Scuro",
        ["Black"] = "Nero",
        ["Nothing to read"] = "Niente da leggere",
        ["End of book"] = "Fine del libro",
        ["Empty spine"] = "Nessun capitolo",
        ["Spine truncated"] = "Capitoli troncati",
        ["Preparing pictures. This may take a while."] = "Preparazione delle immagini. Potrebbe volerci un po'.",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "Nessun libro EPUB trovato\nCopia i file EPUB nella cartella Books della tua scheda SD.",
        ["Refresh library"] = "Aggiorna libreria",
        ["Section %d"] = "Sezione %d",
        ["EPUB Reader"] = "Lettore EPUB",
        ["Failed to read container.xml"] = "Lettura di container.xml non riuscita",
        ["No OPF in container.xml"] = "Nessun OPF in container.xml",
        ["Failed to read OPF"] = "Lettura dell'OPF non riuscita",
        ["Missing manifest item"] = "Elemento del manifest mancante",
        ["Failed to read chapter"] = "Lettura del capitolo non riuscita",
        ["Failed to parse chapter"] = "Analisi del capitolo non riuscita",
        ["unavailable"] = "non disponibile",
    },
    ja = {
        ["Chapters"] = "章",
        ["Font size"] = "文字サイズ",
        ["Background colour"] = "背景色",
        ["Normal"] = "標準",
        ["Extra large"] = "特大",
        ["Theme"] = "テーマ",
        ["Sepia"] = "セピア",
        ["White"] = "白",
        ["Dark"] = "ダーク",
        ["Black"] = "黒",
        ["Nothing to read"] = "読む内容がありません",
        ["End of book"] = "本の終わり",
        ["Empty spine"] = "章がありません",
        ["Spine truncated"] = "章を一部省略しました",
        ["Preparing pictures. This may take a while."] = "画像を準備中です。時間がかかる場合があります。",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "EPUB の本が見つかりません\nEPUB ファイルを SD カードの Books フォルダにコピーしてください。",
        ["Refresh library"] = "ライブラリを更新",
        ["Section %d"] = "セクション %d",
        ["EPUB Reader"] = "EPUB リーダー",
        ["Failed to read container.xml"] = "container.xml を読み込めませんでした",
        ["No OPF in container.xml"] = "container.xml に OPF がありません",
        ["Failed to read OPF"] = "OPF を読み込めませんでした",
        ["Missing manifest item"] = "マニフェスト項目がありません",
        ["Failed to read chapter"] = "章を読み込めませんでした",
        ["Failed to parse chapter"] = "章を解析できませんでした",
        ["unavailable"] = "利用できません",
    },
    nl = {
        ["Chapters"] = "Hoofdstukken",
        ["Font size"] = "Lettergrootte",
        ["Background colour"] = "Achtergrondkleur",
        ["Normal"] = "Normaal",
        ["Extra large"] = "Extra groot",
        ["Theme"] = "Thema",
        ["Sepia"] = "Sepia",
        ["White"] = "Wit",
        ["Dark"] = "Donker",
        ["Black"] = "Zwart",
        ["Nothing to read"] = "Niets om te lezen",
        ["End of book"] = "Einde van het boek",
        ["Empty spine"] = "Geen hoofdstukken",
        ["Spine truncated"] = "Hoofdstukken ingekort",
        ["Preparing pictures. This may take a while."] = "Afbeeldingen voorbereiden. Dit kan even duren.",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "Geen EPUB-boeken gevonden\nKopieer EPUB-bestanden naar de map Books op je SD-kaart.",
        ["Refresh library"] = "Bibliotheek vernieuwen",
        ["Section %d"] = "Sectie %d",
        ["EPUB Reader"] = "EPUB-lezer",
        ["Failed to read container.xml"] = "container.xml lezen mislukt",
        ["No OPF in container.xml"] = "Geen OPF in container.xml",
        ["Failed to read OPF"] = "OPF lezen mislukt",
        ["Missing manifest item"] = "Manifestitem ontbreekt",
        ["Failed to read chapter"] = "Hoofdstuk lezen mislukt",
        ["Failed to parse chapter"] = "Hoofdstuk verwerken mislukt",
        ["unavailable"] = "niet beschikbaar",
    },
    pt = {
        ["Chapters"] = "Capítulos",
        ["Font size"] = "Tamanho da fonte",
        ["Background colour"] = "Cor de fundo",
        ["Normal"] = "Normal",
        ["Extra large"] = "Extra grande",
        ["Theme"] = "Tema",
        ["Sepia"] = "Sépia",
        ["White"] = "Branco",
        ["Dark"] = "Escuro",
        ["Black"] = "Preto",
        ["Nothing to read"] = "Nada para ler",
        ["End of book"] = "Fim do livro",
        ["Empty spine"] = "Sem capítulos",
        ["Spine truncated"] = "Capítulos truncados",
        ["Preparing pictures. This may take a while."] = "Preparando imagens. Isso pode demorar.",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "Nenhum livro EPUB encontrado\nCopie arquivos EPUB para a pasta Books do seu cartão SD.",
        ["Refresh library"] = "Atualizar biblioteca",
        ["Section %d"] = "Seção %d",
        ["EPUB Reader"] = "Leitor de EPUB",
        ["Failed to read container.xml"] = "Falha ao ler container.xml",
        ["No OPF in container.xml"] = "Sem OPF em container.xml",
        ["Failed to read OPF"] = "Falha ao ler o OPF",
        ["Missing manifest item"] = "Item do manifesto ausente",
        ["Failed to read chapter"] = "Falha ao ler o capítulo",
        ["Failed to parse chapter"] = "Falha ao analisar o capítulo",
        ["unavailable"] = "indisponível",
    },
    ru = {
        ["Chapters"] = "Главы",
        ["Font size"] = "Размер шрифта",
        ["Background colour"] = "Цвет фона",
        ["Normal"] = "Обычный",
        ["Extra large"] = "Очень большой",
        ["Theme"] = "Тема",
        ["Sepia"] = "Сепия",
        ["White"] = "Белый",
        ["Dark"] = "Тёмный",
        ["Black"] = "Чёрный",
        ["Nothing to read"] = "Нечего читать",
        ["End of book"] = "Конец книги",
        ["Empty spine"] = "Нет глав",
        ["Spine truncated"] = "Список глав обрезан",
        ["Preparing pictures. This may take a while."] = "Подготовка изображений. Это может занять время.",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "Книги EPUB не найдены\nСкопируйте файлы EPUB в папку Books на SD-карте.",
        ["Refresh library"] = "Обновить библиотеку",
        ["Section %d"] = "Раздел %d",
        ["EPUB Reader"] = "Читалка EPUB",
        ["Failed to read container.xml"] = "Не удалось прочитать container.xml",
        ["No OPF in container.xml"] = "В container.xml нет OPF",
        ["Failed to read OPF"] = "Не удалось прочитать OPF",
        ["Missing manifest item"] = "Отсутствует элемент манифеста",
        ["Failed to read chapter"] = "Не удалось прочитать главу",
        ["Failed to parse chapter"] = "Не удалось разобрать главу",
        ["unavailable"] = "недоступно",
    },
    uk = {
        ["Chapters"] = "Розділи",
        ["Font size"] = "Розмір шрифту",
        ["Background colour"] = "Колір тла",
        ["Normal"] = "Звичайний",
        ["Extra large"] = "Дуже великий",
        ["Theme"] = "Тема",
        ["Sepia"] = "Сепія",
        ["White"] = "Білий",
        ["Dark"] = "Темний",
        ["Black"] = "Чорний",
        ["Nothing to read"] = "Нічого читати",
        ["End of book"] = "Кінець книги",
        ["Empty spine"] = "Немає розділів",
        ["Spine truncated"] = "Список розділів обрізано",
        ["Preparing pictures. This may take a while."] = "Підготовка зображень. Це може зайняти час.",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "Книги EPUB не знайдено\nСкопіюйте файли EPUB до теки Books на SD-карті.",
        ["Refresh library"] = "Оновити бібліотеку",
        ["Section %d"] = "Розділ %d",
        ["EPUB Reader"] = "Читалка EPUB",
        ["Failed to read container.xml"] = "Не вдалося прочитати container.xml",
        ["No OPF in container.xml"] = "У container.xml немає OPF",
        ["Failed to read OPF"] = "Не вдалося прочитати OPF",
        ["Missing manifest item"] = "Відсутній елемент маніфесту",
        ["Failed to read chapter"] = "Не вдалося прочитати розділ",
        ["Failed to parse chapter"] = "Не вдалося розібрати розділ",
        ["unavailable"] = "недоступно",
    },
    vi = {
        ["Chapters"] = "Chương",
        ["Font size"] = "Cỡ chữ",
        ["Background colour"] = "Màu nền",
        ["Normal"] = "Bình thường",
        ["Extra large"] = "Rất lớn",
        ["Theme"] = "Giao diện",
        ["Sepia"] = "Nâu đỏ",
        ["White"] = "Trắng",
        ["Dark"] = "Tối",
        ["Black"] = "Đen",
        ["Nothing to read"] = "Không có gì để đọc",
        ["End of book"] = "Hết sách",
        ["Empty spine"] = "Không có chương",
        ["Spine truncated"] = "Danh sách chương bị cắt bớt",
        ["Preparing pictures. This may take a while."] = "Đang chuẩn bị hình ảnh. Việc này có thể mất một lúc.",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "Không tìm thấy sách EPUB\nHãy chép tệp EPUB vào thư mục Books trên thẻ SD.",
        ["Refresh library"] = "Làm mới thư viện",
        ["Section %d"] = "Phần %d",
        ["EPUB Reader"] = "Trình đọc EPUB",
        ["Failed to read container.xml"] = "Không đọc được container.xml",
        ["No OPF in container.xml"] = "container.xml không có OPF",
        ["Failed to read OPF"] = "Không đọc được OPF",
        ["Missing manifest item"] = "Thiếu mục trong manifest",
        ["Failed to read chapter"] = "Không đọc được chương",
        ["Failed to parse chapter"] = "Không phân tích được chương",
        ["unavailable"] = "không khả dụng",
    },
    zh_CN = {
        ["Chapters"] = "章节",
        ["Font size"] = "字体大小",
        ["Background colour"] = "背景颜色",
        ["Normal"] = "正常",
        ["Extra large"] = "特大",
        ["Theme"] = "主题",
        ["Sepia"] = "棕褐色",
        ["White"] = "白色",
        ["Dark"] = "深色",
        ["Black"] = "黑色",
        ["Nothing to read"] = "没有可读内容",
        ["End of book"] = "全书完",
        ["Empty spine"] = "没有章节",
        ["Spine truncated"] = "章节已截断",
        ["Preparing pictures. This may take a while."] = "正在准备图片。这可能需要一些时间。",
        ["No EPUB books found\nCopy EPUB files into the Books folder on your SD card."] = "未找到 EPUB 图书\n请将 EPUB 文件复制到 SD 卡的 Books 文件夹。",
        ["Refresh library"] = "刷新书库",
        ["Section %d"] = "第 %d 节",
        ["EPUB Reader"] = "EPUB 阅读器",
        ["Failed to read container.xml"] = "无法读取 container.xml",
        ["No OPF in container.xml"] = "container.xml 中没有 OPF",
        ["Failed to read OPF"] = "无法读取 OPF",
        ["Missing manifest item"] = "缺少清单项",
        ["Failed to read chapter"] = "无法读取章节",
        ["Failed to parse chapter"] = "无法解析章节",
        ["unavailable"] = "不可用",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

-- EPUB reader for unencrypted books stored under <SD card>/Books.
-- Scans Books and immediate subfolders, parses container.xml and the OPF,
-- converts chapters to text blocks, and opens paged text reading straight
-- at the saved position, continuing across chapters. A long press on a book
-- offers its table of contents, the font size and the background colour.

-- Last slash, forward only. Lua's pattern matcher backtracks on [^/]+$.
local function basename(path)
    local slash = string.byte("/")
    local last = 0
    local n = #path
    for i = 1, n do
        if path:byte(i) == slash then
            last = i
        end
    end
    if last == 0 or last == n then
        return path
    end
    return path:sub(last + 1)
end

local function percent_decode(s)
    if not s then
        return ""
    end
    return (s:gsub("%%(%x%x)", function(hex)
        return string.char(tonumber(hex, 16))
    end))
end

local function clip_text(s, max_bytes)
    if not s or #s <= max_bytes then
        return s or ""
    end
    -- Cut on a character boundary.
    local clipped = s:sub(1, max_bytes + 1):gsub("[\192-\255][\128-\191]*$", "")
    return clipped
end

-- show_list copies a row into a 160-byte buffer. Clip before the spine
-- retains the label, or a slash-free href is kept whole for every itemref.
local MAX_LABEL_BYTES = 160
local ICON_EPUB = plugin.sd_root() .. "/.plugin-assets/EpubReader/epub.png"

-- A chapter href names a ZIP entry. The container path, the document
-- directory, and the joined path share this limit. Reject a longer value
-- before it is copied; a repeated spine id or nav label would otherwise
-- keep a copy on every row.
local MAX_HREF_BYTES = 4096

-- Path before '#'. A long fragment is ignored; a path past MAX_HREF_BYTES
-- is rejected. The oversized check reads a short prefix, not the whole value.
local function take_href(href)
    if not href or href == "" then
        return ""
    end
    local hash
    if #href > MAX_HREF_BYTES then
        hash = href:sub(1, MAX_HREF_BYTES + 1):find("#", 1, true)
        if not hash then
            return ""
        end
    else
        hash = href:find("#", 1, true)
    end
    if not hash then
        return href
    end
    if hash == 1 then
        return ""
    end
    return href:sub(1, hash - 1)
end

local function resolve_href(opf_dir, href)
    href = take_href(href)
    if href == "" then
        return ""
    end
    href = percent_decode(href)
    local is_dir = (href:sub(-1) == "/")
    local absolute = (href:sub(1, 1) == "/")
    -- take_href never sees the document directory. Reject a long one
    -- before it is copied onto this relative href.
    if not absolute and opf_dir and #opf_dir > MAX_HREF_BYTES then
        return ""
    end

    local segments = {}
    local function add_segments(p)
        for seg in (p .. "/"):gmatch("([^/]*)/") do
            if seg == "" or seg == "." then
                -- drop
            elseif seg == ".." then
                if #segments > 0 then
                    segments[#segments] = nil
                end
            else
                segments[#segments + 1] = seg
            end
        end
    end

    if absolute then
        add_segments(href:sub(2))
    else
        if opf_dir and opf_dir ~= "" then
            add_segments(opf_dir)
        end
        add_segments(href)
    end

    -- Join only after the normalized length fits. table.concat would copy
    -- a path the limit already rejected.
    local result_len = 0
    for i = 1, #segments do
        result_len = result_len + #segments[i]
        if i > 1 then
            result_len = result_len + 1
        end
        if result_len > MAX_HREF_BYTES then
            return ""
        end
    end
    if is_dir and result_len > 0 and result_len + 1 > MAX_HREF_BYTES then
        return ""
    end

    local result = table.concat(segments, "/")
    if is_dir and result ~= "" then
        result = result .. "/"
    end
    return result
end

-- Cache the resolved path on the manifest item. A repeated spine id
-- reuses it instead of resolving the href again.
local function resolved_href(item, base_dir)
    if not item then
        return nil
    end
    local href = item.resolved
    if href == nil then
        href = resolve_href(base_dir, item.href)
        item.resolved = href
    end
    if href == "" then
        return nil
    end
    return href
end

-- Quoted '>' is attribute data, not the tag terminator. XML has no
-- backslash escapes, so a quote ends only at the same quote. One scan
-- for the next of '>', '"' or "'": separate suffix searches are quadratic.
local GT_OR_QUOTE = "[>\"']"

local function find_unquoted_gt(data, p)
    local n = #data
    while p <= n do
        local i = data:find(GT_OR_QUOTE, p)
        if not i then
            return nil
        end
        local q = data:sub(i, i)
        if q == ">" then
            return i
        end
        local close = data:find(q, i + 1, true)
        if not close then
            return nil
        end
        p = close + 1
    end
    return nil
end

local function collapse_whitespace(s)
    if not s then
        return ""
    end
    -- Forward-only: a lazy "(.-)%s*$" is quadratic on long whitespace runs.
    local first = s:find("%S")
    if not first then
        return ""
    end
    return (s:match("^.*%S", first):gsub("%s+", " "))
end

local ENTITIES = { amp = "&", lt = "<", gt = ">", quot = '"', apos = "'", nbsp = "\194\160" }

-- Markup at lt that is not an element tag: a comment, CDATA section,
-- processing instruction or declaration. Returns the position after it and,
-- for CDATA, the content bounds. Returns false when it is never closed: any
-- later search would scan to the end again, so callers stop there. Returns
-- nil for an element start or end tag.
local function skip_special(data, lt)
    if data:sub(lt, lt + 3) == "<!--" then
        local close = data:find("-->", lt + 4, true)
        return close and (close + 3) or false
    elseif data:sub(lt, lt + 8) == "<![CDATA[" then
        local close = data:find("]]>", lt + 9, true)
        if not close then
            return false
        end
        return close + 3, lt + 9, close - 1
    end
    local c = data:sub(lt + 1, lt + 1)
    if c == "?" then
        local close = data:find("?>", lt + 2, true)
        return close and (close + 2) or false
    elseif c == "!" then
        local gt = find_unquoted_gt(data, lt + 2)
        return gt and (gt + 1) or false
    end
    return nil
end

-- One pass, so "&amp;lt;" stays "&lt;".
local function decode_entities(s)
    if not s or not s:find("&", 1, true) then
        return s or ""
    end
    return (
        s:gsub("&(#?%w+);", function(e)
            local named = ENTITIES[e]
            if named then
                return named
            end
            local cp
            if e:sub(1, 2):lower() == "#x" then
                cp = tonumber(e:sub(3), 16)
            elseif e:sub(1, 1) == "#" then
                cp = tonumber(e:sub(2), 10)
            end
            if cp and cp > 0 and cp <= 0x10FFFF and (cp < 0xD800 or cp > 0xDFFF) then
                return utf8.char(cp)
            end
            return nil
        end)
    )
end

-- Text content of markup: tags and comments dropped, entities decoded,
-- CDATA kept literally (it is not entity-decoded).
local function markup_text(s)
    local parts = {}
    local p = 1
    local len = #s
    while p <= len do
        local lt = s:find("<", p, true)
        if not lt then
            parts[#parts + 1] = decode_entities(s:sub(p))
            break
        end
        if lt > p then
            parts[#parts + 1] = decode_entities(s:sub(p, lt - 1))
        end
        -- Comments, CDATA and processing instructions end at their own
        -- terminator, not at a quote or a '>', so skip them before the
        -- quote-aware scan.
        local after, cdata_s, cdata_e = skip_special(s, lt)
        if after == false then
            break
        elseif after then
            if cdata_s then
                parts[#parts + 1] = s:sub(cdata_s, cdata_e)
            end
            p = after
        else
            local gt = find_unquoted_gt(s, lt + 1)
            if not gt then
                break
            end
            p = gt + 1
        end
    end
    return table.concat(parts)
end

-- XML requires quoted attribute values, so unquoted ones are ignored.
-- Forward-only, so a long run of name characters without "=" stays linear.
local function parse_attributes(s)
    local attrs = {}
    local p = 1
    while true do
        local ns, ne = s:find("[%w_:%.%-]+", p)
        if not ns then
            break
        end
        p = ne + 1
        local _, eq = s:find("^%s*=%s*", p)
        if eq then
            p = eq + 1
            local q = s:sub(p, p)
            if q == '"' or q == "'" then
                local close = s:find(q, p + 1, true)
                if not close then
                    break
                end
                attrs[s:sub(ns, ne):lower()] = decode_entities(s:sub(p + 1, close - 1))
                p = close + 1
            end
        end
    end
    return attrs
end

local function has_property(props, wanted)
    if not props then
        return false
    end
    for word in props:gmatch("%S+") do
        if word == wanted then
            return true
        end
    end
    return false
end

local function dir_of(path)
    return path:match("^(.*)/[^/]+$") or ""
end

-- Directory prepended to relative hrefs. A path past the href limit has
-- no usable directory: dir_of would copy it before every name below.
local function document_dir(path)
    if not path or #path > MAX_HREF_BYTES then
        return nil
    end
    return dir_of(path)
end

local function local_name_of(name)
    return name:match(":([^:]+)$") or name
end

-- Returns lt, gt, name, local_name of the next start tag at or after p, skipping
-- comments, CDATA, doctypes, processing instructions and end tags.
local function next_start_tag(data, p)
    local n = #data
    while p <= n do
        local lt = data:find("<", p, true)
        if not lt then
            return nil
        end
        local after = skip_special(data, lt)
        if after == false then
            return nil
        elseif after then
            p = after
        else
            local c = data:sub(lt + 1, lt + 1)
            local gt = find_unquoted_gt(data, lt + 1)
            if not gt then
                return nil
            end
            p = gt + 1
            if c ~= "/" then
                local name = data:match("^[%w_:%.%-]+", lt + 1)
                if name then
                    name = name:lower()
                    return lt, gt, name, local_name_of(name)
                end
            end
        end
    end
    return nil
end

-- Returns the start and end of the next end tag with this local name.
-- Comments, CDATA, processing instructions and quoted attribute values of
-- nested start tags are skipped, so an end tag inside them is ignored.
local function find_close(data, p, local_name)
    local n = #data
    while p <= n do
        local lt = data:find("<", p, true)
        if not lt then
            return nil
        end
        local after = skip_special(data, lt)
        if after == false then
            return nil
        elseif after then
            p = after
        elseif data:sub(lt + 1, lt + 1) == "/" then
            local name = data:match("^[%w_:%.%-]+", lt + 2)
            if name and local_name_of(name:lower()) == local_name then
                return lt, data:find(">", lt + 2, true)
            end
            p = lt + 2
        elseif data:find("^[%a_:]", lt + 1) then
            -- A nested start tag: a quoted "</a>" in its attributes is data.
            local gt = find_unquoted_gt(data, lt + 1)
            if not gt then
                return nil
            end
            p = gt + 1
        else
            p = lt + 1
        end
    end
    return nil
end

-- Text of the element whose start tag ends at gt, and the position after it.
-- unclosed remembers names with no end tag left, so each is searched for once.
local function element_text(data, gt, local_name, unclosed)
    if data:sub(gt - 1, gt - 1) == "/" or unclosed[local_name] then
        return nil, gt + 1
    end
    local close_lt, close_gt = find_close(data, gt + 1, local_name)
    if not close_lt then
        unclosed[local_name] = true
        return nil, gt + 1
    end
    local text = collapse_whitespace(markup_text(data:sub(gt + 1, close_lt - 1)))
    return text, close_gt and (close_gt + 1) or (close_lt + 2)
end

-- titles holds one "" slot per spine chapter (see parse_book). Only those
-- are filled, so a table of contents with thousands of links retains at
-- most the bounded spine's worth of titles.
local function set_title(titles, key, text)
    if key and text and text ~= "" and titles[key] == "" then
        titles[key] = text
    end
end

-- Resolves a document's links to spine chapters without rebuilding its
-- directory per link. The directory is split once. A path is identified by
-- how many leading directory components it keeps plus its own remaining
-- tail, always taking the longest shared prefix, so every spelling of one
-- file ("../dir/a", "./a", "a") gets the same short key. Spine chapters are
-- keyed the same way up front, so a link costs only its own length and no
-- valid title is ever skipped.
local function new_title_resolver(base_dir, titles)
    local bsegs = {}
    for seg in (base_dir .. "/"):gmatch("([^/]*)/") do
        if seg ~= "" then
            bsegs[#bsegs + 1] = seg
        end
    end
    local nb = #bsegs
    local bnorm = table.concat(bsegs, "/")

    local ids = {}
    for href in pairs(titles) do
        local k, rest = 0, href
        if nb > 0 and href:sub(1, #bnorm + 1) == bnorm .. "/" then
            k, rest = nb, href:sub(#bnorm + 2)
        else
            local pos = 1
            while k < nb do
                local seg = bsegs[k + 1]
                local stop = pos + #seg
                if href:sub(pos, stop - 1) ~= seg or href:sub(stop, stop) ~= "/" then
                    break
                end
                k, pos = k + 1, stop + 1
            end
            rest = href:sub(pos)
        end
        ids[k .. "\0" .. rest] = href
    end

    return function(href)
        local path = take_href(href)
        if path == "" then
            return nil
        end
        path = percent_decode(path)
        if path:sub(-1) == "/" then
            return nil -- a directory, not a chapter file
        end
        local absolute = path:sub(1, 1) == "/"
        local up, hs = 0, {}
        for seg in (path .. "/"):gmatch("([^/]*)/") do
            if seg == "" or seg == "." then
                -- drop
            elseif seg == ".." then
                if #hs > 0 then
                    hs[#hs] = nil
                else
                    up = up + 1
                end
            else
                hs[#hs + 1] = seg
            end
        end
        local k = 0
        if not absolute then
            k = nb - up
            if k < 0 then
                k = 0
            end
        end
        local i = 1
        while i <= #hs and k < nb and hs[i] == bsegs[k + 1] do
            k, i = k + 1, i + 1
        end
        return ids[k .. "\0" .. table.concat(hs, "/", i)]
    end
end

local function scan_epub_files()
    local root = plugin.sd_root() .. "/Books"
    local paths = {}
    local function add(dir, name)
        if #paths < 200 and name:lower():sub(-5) == ".epub" then
            paths[#paths + 1] = dir .. "/" .. name
        end
    end
    for _, e in ipairs(plugin.list_dir(root)) do
        if not e.dir then
            add(root, e.name)
        else
            local sub = root .. "/" .. e.name
            for _, se in ipairs(plugin.list_dir(sub)) do
                if not se.dir then
                    add(sub, se.name)
                end
            end
        end
    end
    table.sort(paths)
    return paths
end

local function find_opf_path(container_xml)
    local p = 1
    while true do
        local lt, gt, _, lname = next_start_tag(container_xml, p)
        if not lt then
            return nil
        end
        p = gt + 1
        if lname == "rootfile" and gt - lt <= MAX_HREF_BYTES * 2 then
            -- Slice the tag only when full-path can still fit. A longer tag
            -- is rejected before the path is copied out of container.xml.
            local raw = parse_attributes(container_xml:sub(lt, gt))["full-path"]
            if raw and #raw <= MAX_HREF_BYTES then
                local val = percent_decode(raw)
                val = val:gsub("^/+", "")
                if val ~= "" then
                    return val
                end
            end
        end
    end
end

local function parse_opf(opf, book_path)
    local unclosed = {}
    local dc_title, fallback_title, creator
    local manifest = {}
    local spine_ids = {}
    local spine_truncated = false
    local ncx_item, nav_item
    local cover_meta_id, cover_property_item, cover_named_item

    local p = 1
    while true do
        local lt, gt, name, lname = next_start_tag(opf, p)
        if not lt then
            break
        end
        p = gt + 1
        if lname == "title" or lname == "creator" then
            local text
            text, p = element_text(opf, gt, lname, unclosed)
            if text and text ~= "" then
                if name == "dc:title" then
                    dc_title = dc_title or text
                elseif lname == "title" then
                    fallback_title = fallback_title or text
                else
                    creator = creator or text
                end
            end
        elseif lname == "item" then
            local attrs = parse_attributes(opf:sub(lt, gt))
            local id = attrs["id"]
            if id and id ~= "" then
                local it = {
                    href = take_href(attrs["href"] or ""),
                    media = attrs["media-type"] or "",
                    properties = attrs["properties"] or "",
                }
                manifest[id] = it
                if it.media:lower() == "application/x-dtbncx+xml" and not ncx_item then
                    ncx_item = it
                end
                if has_property(it.properties, "nav") and not nav_item then
                    nav_item = it
                end
                if it.media:lower():find("^image/") then
                    if has_property(it.properties, "cover-image") then
                        cover_property_item = cover_property_item or it
                    elseif
                        not cover_named_item
                        and (id:lower():find("cover", 1, true) or it.href:lower():find("cover", 1, true))
                    then
                        cover_named_item = it
                    end
                end
            end
        elseif lname == "meta" then
            -- EPUB 2 names its cover image with <meta name="cover" content="id">.
            local attrs = parse_attributes(opf:sub(lt, gt))
            if attrs["name"] == "cover" and attrs["content"] and attrs["content"] ~= "" then
                cover_meta_id = cover_meta_id or attrs["content"]
            end
        elseif lname == "itemref" then
            local idref = parse_attributes(opf:sub(lt, gt))["idref"]
            if idref and idref ~= "" then
                if #spine_ids < 500 then
                    spine_ids[#spine_ids + 1] = idref
                elseif not spine_truncated then
                    plugin.show_toast(tr("Spine truncated"))
                    spine_truncated = true
                end
            end
        end
    end

    local cover_item = cover_property_item
    if not cover_item and cover_meta_id then
        local it = manifest[cover_meta_id]
        if it and it.media:lower():find("^image/") then
            cover_item = it
        end
    end

    return {
        title = dc_title or fallback_title or basename(book_path),
        author = creator,
        manifest = manifest,
        spine_ids = spine_ids,
        ncx_item = ncx_item,
        nav_item = nav_item,
        cover_item = cover_item or cover_named_item,
    }
end

-- The table of contents, flattened in reading order, is capped like the spine.
local MAX_TOC_ENTRIES = 500

-- Adds an entry that points into a spine chapter; links elsewhere are dropped.
-- frag is the link's #id, "" when it has none.
local function add_toc(book, resolve, src, text)
    local href = resolve(src)
    if not href or not text or text == "" then
        return
    end
    text = clip_text(text, MAX_LABEL_BYTES)
    set_title(book.titles, href, text)
    if #book.toc < MAX_TOC_ENTRIES then
        local hash = src:sub(1, MAX_HREF_BYTES + 1):find("#", 1, true)
        book.toc[#book.toc + 1] = {
            title = text,
            href = href,
            frag = hash and src:sub(hash + 1, hash + 128) or "",
        }
    end
end

-- NCX and nav hrefs are relative to their own document, not the OPF.
local function parse_ncx_toc(ncx, resolve, book)
    local unclosed = {}
    local pending
    local p = 1
    while true do
        local lt, gt, _, lname = next_start_tag(ncx, p)
        if not lt then
            break
        end
        p = gt + 1
        if lname == "text" then
            local text
            text, p = element_text(ncx, gt, "text", unclosed)
            if text and text ~= "" then
                pending = text
            end
        elseif lname == "content" and pending then
            local src = parse_attributes(ncx:sub(lt, gt))["src"]
            if src then
                add_toc(book, resolve, src, pending)
                pending = nil
            end
        end
    end
end

local function parse_nav_toc(nav, resolve, book)
    -- Landmarks and page lists link into the book too: read only the toc nav.
    local p = 1
    while true do
        local lt, gt, _, lname = next_start_tag(nav, p)
        if not lt then
            break
        end
        p = gt + 1
        if lname == "nav" and (parse_attributes(nav:sub(lt, gt))["epub:type"] or ""):find("toc", 1, true) then
            local close = find_close(nav, gt + 1, "nav")
            nav = nav:sub(gt + 1, close and close - 1 or #nav)
            break
        end
    end
    local unclosed = {}
    p = 1
    while true do
        local lt, gt, _, lname = next_start_tag(nav, p)
        if not lt then
            break
        end
        p = gt + 1
        if lname == "a" then
            local href = parse_attributes(nav:sub(lt, gt))["href"]
            local text
            text, p = element_text(nav, gt, "a", unclosed)
            if href then
                add_toc(book, resolve, href, text)
            end
        end
    end
end

-- Container and OPF only: title, author, manifest, spine and cover.
-- quiet skips the error toasts (background cover preparation). Returns
-- nil and the reason on failure.
local function read_opf(book_path, quiet)
    local function fail(message)
        if not quiet then
            plugin.show_toast(message)
        end
        return nil, message
    end
    local container_data, err = plugin.zip_read(book_path, "META-INF/container.xml")
    if not container_data then
        return fail(err or tr("Failed to read container.xml"))
    end

    local opf_path = find_opf_path(container_data)
    if not opf_path then
        return fail(tr("No OPF in container.xml"))
    end

    local opf_bytes, opf_err = plugin.zip_read(book_path, opf_path)
    if not opf_bytes then
        return fail(opf_err or tr("Failed to read OPF"))
    end

    local book = parse_opf(opf_bytes, book_path)
    local opf_dir = document_dir(opf_path)
    if opf_dir == nil then
        return fail(tr("No OPF in container.xml"))
    end
    book.opf_dir = opf_dir
    return book
end

local function parse_book(book_path)
    local book = read_opf(book_path)
    if not book then
        return nil
    end

    -- titles holds the first table of contents title of each spine chapter,
    -- toc every entry in order, spine_of the first spine index of a chapter.
    local titles, spine_of = {}, {}
    for i, idref in ipairs(book.spine_ids) do
        local href = resolved_href(book.manifest[idref], book.opf_dir)
        if href then
            titles[href] = ""
            spine_of[href] = spine_of[href] or i
        end
    end
    book.titles = titles
    book.toc = {}
    book.spine_of = spine_of

    local function read_toc(item, parse)
        local path = resolved_href(item, book.opf_dir)
        local data = path and plugin.zip_read(book_path, path)
        local dir = data and document_dir(path)
        if dir then
            parse(data, new_title_resolver(dir, titles), book)
        end
    end
    if book.ncx_item then
        read_toc(book.ncx_item, parse_ncx_toc)
    end
    if #book.toc == 0 and book.nav_item then
        read_toc(book.nav_item, parse_nav_toc)
    end
    return book
end

-- Keys are hashed because storage keys are capped at 128 bytes.
local function pos_key(book_path)
    return "pos:" .. plugin.md5(book_path)
end

local function load_pos(book_path)
    local pos_str = plugin.storage.get(pos_key(book_path))
    if not pos_str then
        return nil, nil
    end
    return tonumber(pos_str:match("^(%d+)")), tonumber(pos_str:match("\n(%d+)$"))
end

local function save_pos(book_path, index, byte_offset)
    plugin.storage.set(pos_key(book_path), tostring(index) .. "\n" .. tostring(byte_offset or 0))
end

local function chapter_href(book, index)
    local idref = book.spine_ids[index]
    return resolved_href(idref and book.manifest[idref], book.opf_dir)
end

-- Covers and chapter pictures are scaled once into LVGL images under
-- .plugins/.epub_cache and reused. The firmware prepares one image at a
-- time for all plugins, so jobs wait in a queue here; chapter pictures go
-- first. A timer runs only while jobs wait.
local CACHE_DIR = plugin.sd_root() .. "/.plugins/.epub_cache"
local COVER_W, COVER_H = 180, 270
local PAGE_W, PAGE_H = 448, 640
local MAX_CHAPTER_IMAGES = 64

local function file_exists(path)
    local f = io.open(path, "rb")
    if f then
        f:close()
        return true
    end
    return false
end

local cache_ready = false
local function ensure_cache()
    if not cache_ready then
        cache_ready = plugin.mkdir(CACHE_DIR) and true or false
    end
    return cache_ready
end

local function cover_file(book_path)
    return CACHE_DIR .. "/" .. plugin.md5(book_path) .. ".cover.bin"
end

local function cached_book_details(book_path)
    local stored = plugin.storage.get("title:" .. plugin.md5(book_path))
    local title, author
    if stored then title, author = stored:match("^([^\n]*)\n(.*)$") end
    if not title then title = stored end
    return title, author or "", stored and stored:find("\n", 1, true) ~= nil
end

local function picture_file(book_path, entry)
    return CACHE_DIR .. "/" .. plugin.md5(book_path .. "\n" .. entry) .. ".bin"
end

local jobs, job_running, job_timer = {}, false, nil
local jobs_held = false -- after a busy decoder, wait for the next tick
local run_jobs

-- Decode failures worth another try: the decoder or its memory was taken by
-- the player's own artwork.
local function is_temporary(err)
    return err == "busy" or err == "nomem"
end
local MAX_ATTEMPTS = 5

local function ensure_timer()
    if #jobs > 0 and not job_timer then
        job_timer = plugin.set_interval(1, function()
            jobs_held = false
            run_jobs(true)
        end)
    end
end

local function stop_timer_if_idle()
    if job_timer and #jobs == 0 and not job_running then
        plugin.clear_interval(job_timer)
        job_timer = nil
    end
end

-- job = { book, entry, dest, w, h, done(path_or_nil, err) } or { prep = fn }.
-- Preparation steps parse a book, so they run only from the timer or an
-- image callback, one at a time; queueing never parses on the caller's tap.
local function queue_job(job, urgent)
    table.insert(jobs, urgent and 1 or (#jobs + 1), job)
    run_jobs(false)
    ensure_timer()
end

local function retry_later(job)
    job.attempts = (job.attempts or 1) + 1
    table.insert(jobs, 1, job)
    jobs_held = true
    ensure_timer()
end

run_jobs = function(allow_prep)
    while not job_running and not jobs_held and #jobs > 0 do
        local job = jobs[1]
        if job.prep then
            if not allow_prep then
                break
            end
            allow_prep = false
            table.remove(jobs, 1)
            job.prep()
        elseif file_exists(job.dest) then
            table.remove(jobs, 1)
            job.done(job.dest)
        else
            local called, ok, err = pcall(
                plugin.zip_image_async,
                job.book,
                job.entry,
                job.dest,
                job.w,
                job.h,
                function(path, reason)
                    job_running = false
                    if not path and is_temporary(reason) and (job.attempts or 1) < MAX_ATTEMPTS then
                        retry_later(job)
                    else
                        job.done(path, reason)
                    end
                    run_jobs(true)
                end
            )
            if called and ok then
                table.remove(jobs, 1)
                job_running = true
            elseif called and err == "busy" then
                break -- another plugin's image; the timer retries
            else
                table.remove(jobs, 1)
                job.done(nil, called and err or "failed")
            end
        end
    end
    stop_timer_if_idle()
end

-- Background: read a book's title and cover once; the grid shows them the
-- next time it opens.
local covers_queued = {}

local function queue_cover(book_path)
    local key = plugin.md5(book_path)
    if covers_queued[key] then
        return
    end
    covers_queued[key] = true
    queue_job({
        prep = function()
            local book, err = read_opf(book_path, true)
            if not book then
                if not is_temporary(err) and err ~= "io_error" then
                    plugin.storage.set("nocover:" .. key, "1")
                end
                covers_queued[key] = nil
                return
            end
            -- Older releases stored only the title. Keep that cached title
            -- authoritative while appending author metadata in the same key.
            local cached_title, cached_author = cached_book_details(book_path)
            local title = cached_title and cached_title ~= "" and cached_title or book.title
            local author = cached_author ~= "" and cached_author or (book.author or "")
            plugin.storage.set("title:" .. key, clip_text(title, MAX_LABEL_BYTES) .. "\n" .. clip_text(author, MAX_LABEL_BYTES))
            local entry = book.cover_item and resolved_href(book.cover_item, book.opf_dir)
            if not entry then
                plugin.storage.set("nocover:" .. key, "1")
                covers_queued[key] = nil
                return
            end
            queue_job({
                book = book_path,
                entry = entry,
                dest = cover_file(book_path),
                w = COVER_W,
                h = COVER_H,
                done = function(path, err)
                    if not path and not is_temporary(err) then
                        plugin.storage.set("nocover:" .. key, "1")
                    end
                    covers_queued[key] = nil -- a temporary failure tries again next time
                end,
            }, true)
        end,
    })
end

-- Reading style, shared by all books and kept in plugin.storage. Normal
-- keeps the player's default size, Theme its default colors.
local FONT_NAMES = { "Small", "Normal", "Large", "Extra large" }
local FONT_SIZES = { "small", false, "medium", "large" }
local BACKGROUNDS = {
    { name = "Theme" },
    { name = "White", background = 0xFAFAF7, text = 0x1A1A1A },
    { name = "Sepia", background = 0xF4ECD8, text = 0x5B4636 },
    { name = "Dark", background = 0x2B2B2B, text = 0xD8D8D8 },
    { name = "Black", background = 0x000000, text = 0xC8C8C8 },
    { name = "Custom" },
}
local CUSTOM = #BACKGROUNDS

local function stored_index(key, count, default)
    local n = math.tointeger(tonumber(plugin.storage.get(key) or ""))
    if n and n >= 1 and n <= count then
        return n
    end
    return default
end

-- A custom background gets dark or light text, whichever reads better.
local function custom_text_color(color)
    local r, g, b = color // 65536, color // 256 % 256, color % 256
    return (r * 299 + g * 587 + b * 114) > 140000 and 0x1A1A1A or 0xE0E0E0
end

-- Returns the text_size and colors options (nil for the defaults).
local function reading_style()
    local size = FONT_SIZES[stored_index("font", #FONT_NAMES, 2)] or nil
    local choice = stored_index("bg", CUSTOM, 1)
    local bg = BACKGROUNDS[choice]
    if bg.background then
        return size, { background = bg.background, text = bg.text }
    end
    local custom = choice == CUSTOM and math.tointeger(tonumber(plugin.storage.get("bg_custom") or ""))
    if custom and custom >= 0 and custom <= 0xFFFFFF then
        return size, { background = custom, text = custom_text_color(custom) }
    end
    return size, nil
end

-- Blocks of one spine item. Returns nil, nil and the reason on failure.
local function read_blocks(book_path, book, index)
    local href = chapter_href(book, index)
    if not href then
        return nil, nil, tr("Missing manifest item")
    end
    local chapter_bytes, err = plugin.zip_read(book_path, href)
    if not chapter_bytes then
        return nil, nil, err or tr("Failed to read chapter")
    end
    local blocks, b_err = plugin.html_to_blocks(chapter_bytes)
    if not blocks then
        return nil, nil, b_err or tr("Failed to parse chapter")
    end
    return blocks, href
end

-- Whether the blocks hold any text, and whether they hold a picture.
local function block_content(blocks)
    local text, pic = false, false
    for i = 1, #blocks do
        local b = blocks[i]
        if b.kind == "img" then
            pic = true
        elseif (b.kind == "h" or b.kind == "p") and b.text and b.text ~= "" then
            text = true
        end
    end
    return text, pic
end

-- First spine item from index on, in direction step, with text or a picture.
-- Returns its index, blocks and href, or nil and the last error.
local function find_chapter(book_path, book, index, step)
    local last_err
    while index >= 1 and index <= #book.spine_ids do
        local blocks, href, err = read_blocks(book_path, book, index)
        if blocks then
            local text, pic = block_content(blocks)
            if text or pic then
                return index, blocks, href
            end
        else
            last_err = err
        end
        index = index + step
    end
    return nil, last_err
end

-- Heading comparison ignores case and whitespace.
local function fold(s)
    return (s:lower():gsub("%s+", ""):gsub("\194\160", ""))
end

local chapter_generation = 0
local LAST_PAGE = 9999 -- the view lands on its last page

-- Opens spine item index, or the next one with content in direction step.
-- start = { offset = bytes } or { page = n } or { title = heading text },
-- or nil for the first page. ctx = { list = handle of the screen it was
-- opened from } or { replace = true } to swap the content of the open view.
local function open_chapter(book_path, book, index, step, start, ctx)
    local found, blocks, href = find_chapter(book_path, book, index, step) -- on failure, blocks is the error
    if not found then
        if not ctx.replace then
            plugin.show_toast(blocks or tr("Nothing to read"))
        elseif step > 0 then
            plugin.show_toast(tr("End of book"))
        end
        return
    end
    if found ~= index and start and start.offset then
        start = nil -- the saved spot belongs to a chapter that was skipped
    end
    index = found

    -- Pictures, in order of first use, up to what the text view accepts.
    local chapter_dir = dir_of(href)
    local entries, entry_index = {}, {}
    for i = 1, #blocks do
        local b = blocks[i]
        if b.kind == "img" and b.text and b.text ~= "" and #entries < MAX_CHAPTER_IMAGES then
            local entry = resolve_href(chapter_dir, b.text)
            if entry ~= "" and not entry_index[entry] then
                entries[#entries + 1] = entry
                entry_index[entry] = #entries
            end
        end
    end

    chapter_generation = chapter_generation + 1
    local generation = chapter_generation
    local ready = {}
    local deferred = false

    local function show()
        if generation ~= chapter_generation then
            return -- another chapter or book was opened meanwhile
        end
        if deferred and not ctx.replace and not (ctx.list and plugin.is_list_showing(ctx.list)) then
            return -- the user left the screen the chapter was opened from
        end
        local images, marker_of = {}, {}
        for i, entry in ipairs(entries) do
            if ready[i] then
                images[#images + 1] = ready[i]
                marker_of[entry] = #images - 1
            end
        end
        local pieces, size = {}, 0
        local function add(s)
            pieces[#pieces + 1] = s
            size = size + #s
        end
        local offset = start and start.offset
        local heading = start and start.title and fold(start.title)
        for i = 1, #blocks do
            local b = blocks[i]
            if b.kind == "h" or b.kind == "p" then
                if heading and b.kind == "h" and fold(b.text or "") == heading then
                    offset, heading = size, nil
                end
                add((b.text or "") .. "\n\n")
            elseif b.kind == "img" then
                local marker = b.text and marker_of[resolve_href(chapter_dir, b.text)]
                add(marker and ("\27" .. marker .. "\27") or "[image]\n\n")
            elseif b.kind == "hr" then
                add("\n")
            end
        end

        local title = book.titles[href]
        if not title or title == "" then
            title = clip_text(book.title, MAX_LABEL_BYTES)
        end
        local opts = {
            images = images,
            page = start and start.page,
            offset = offset,
            on_turn = function(_, _, byte_offset)
                save_pos(book_path, index, byte_offset)
            end,
            on_close = function(_, byte_offset)
                save_pos(book_path, index, byte_offset)
            end,
            replace = ctx.replace,
            on_end = function(direction)
                open_chapter(
                    book_path,
                    book,
                    index + direction,
                    direction,
                    direction < 0 and { page = LAST_PAGE } or nil,
                    { replace = true }
                )
            end,
        }
        opts.text_size, opts.colors = reading_style()

        local ok, tv_err = plugin.show_text_view(title, table.concat(pieces), opts)
        if not ok then
            if not (ctx.replace and tv_err == "not open") then -- the user left the book
                plugin.show_toast(tv_err or tr("unavailable"))
            end
            return
        end
        if plugin.storage.get("continue") ~= book_path then
            plugin.storage.set("continue", book_path)
        end
    end

    if #entries == 0 or not ensure_cache() then
        show()
        return
    end
    local waiting = 0
    for i, entry in ipairs(entries) do
        local dest = picture_file(book_path, entry)
        if file_exists(dest) then
            ready[i] = dest
        else
            waiting = waiting + 1
        end
    end
    if waiting == 0 then
        show()
        return
    end
    plugin.show_toast(tr("Preparing pictures. This may take a while."))
    deferred = true
    -- Queued in reverse at the front, so they run in reading order ahead of
    -- any covers still being prepared.
    for i = #entries, 1, -1 do
        if not ready[i] then
            local entry = entries[i]
            queue_job({
                book = book_path,
                entry = entry,
                dest = picture_file(book_path, entry),
                w = PAGE_W,
                h = PAGE_H,
                done = function(path)
                    ready[i] = path
                    waiting = waiting - 1
                    if waiting == 0 then
                        show()
                    end
                end,
            }, true)
        end
    end
end

-- The table of contents as a list; without one, the spine items that have
-- text, labeled by their first heading.
local function open_chapters(book_path)
    local book = parse_book(book_path)
    if not book then
        return
    end
    if #book.spine_ids == 0 then
        plugin.show_toast(tr("Empty spine"))
        return
    end

    local entries = {}
    if #book.toc > 0 then
        for _, t in ipairs(book.toc) do
            -- A #id is found by its heading; without a match, the file's start.
            local index = book.spine_of[t.href]
            if index then -- an entry outside the spine cannot be opened
                local heading = t.frag ~= "" and t.title or nil
                entries[#entries + 1] = { label = t.title, index = index, heading = heading }
            end
        end
    else
        for i = 1, #book.spine_ids do
            local blocks = read_blocks(book_path, book, i)
            if blocks and block_content(blocks) then
                local label = string.format(tr("Section %d"), i)
                for _, b in ipairs(blocks) do
                    if b.kind == "h" and b.text and b.text ~= "" then
                        label = clip_text(b.text, MAX_LABEL_BYTES)
                        break
                    end
                end
                entries[#entries + 1] = { label = label, index = i }
            end
        end
    end
    if #entries == 0 then
        plugin.show_toast(tr("Nothing to read"))
        return
    end

    -- Long chapter titles wrap instead of scrolling.
    local labels = {}
    for i = 1, #entries do
        labels[i] = { label = entries[i].label, wrap = true }
    end
    local list_title = book.title
    if book.author and book.author ~= "" then
        list_title = list_title .. " - " .. book.author
    end
    list_title = clip_text(list_title, 80)

    chapter_generation = chapter_generation + 1 -- drops a chapter still preparing pictures
    local list_handle
    list_handle = plugin.show_list(list_title, labels, function(i)
        local e = entries[i]
        if e then
            open_chapter(book_path, book, e.index, 1, e.heading and { title = e.heading } or nil, { list = list_handle })
        end
    end)
end

-- Opens the book at the saved spot, or its start.
local function open_book(book_path, list_handle)
    local book = parse_book(book_path)
    if not book then
        return
    end
    if #book.spine_ids == 0 then
        plugin.show_toast(tr("Empty spine"))
        return
    end

    local saved_chap, saved_off = load_pos(book_path)
    if not saved_chap or saved_chap < 1 or saved_chap > #book.spine_ids then
        saved_chap, saved_off = 1, 0
    end
    open_chapter(book_path, book, saved_chap, 1, { offset = saved_off }, { list = list_handle })
end

local function book_details(book_path)
    local title, author = cached_book_details(book_path)
    if not title or title == "" then
        title = clip_text((basename(book_path):gsub("%.[Ee][Pp][Uu][Bb]$", "")), MAX_LABEL_BYTES)
    end
    return title, author or ""
end

local function show_menu(title, items, on_select, selected)
    local ok, err = plugin.show_menu(title, items, on_select, selected and { selected = selected } or nil)
    if not ok then
        plugin.show_toast(err or tr("unavailable"))
    end
end

local function font_labels()
    local names = {}
    for i, name in ipairs(FONT_NAMES) do
        names[i] = tr(name)
    end
    return names
end

local function open_font_menu()
    show_menu(tr("Font size"), font_labels(), function(i)
        plugin.storage.set("font", tostring(i))
    end, stored_index("font", #FONT_NAMES, 2))
end

local function open_background_menu()
    local names = {}
    for i, bg in ipairs(BACKGROUNDS) do
        names[i] = tr(bg.name)
    end
    show_menu(tr("Background colour"), names, function(i)
        if i ~= CUSTOM then
            plugin.storage.set("bg", tostring(i))
            return
        end
        local current = math.tointeger(tonumber(plugin.storage.get("bg_custom") or ""))
        local ok, err = plugin.pick_color(current, nil, function(color)
            if color then
                plugin.storage.set("bg_custom", tostring(color))
                plugin.storage.set("bg", tostring(CUSTOM))
            end
        end)
        if not ok then
            plugin.show_toast(err or tr("unavailable"))
        end
    end, stored_index("bg", #names, 1))
end

-- Long press on a book.
local function open_book_menu(book_path)
    local title = book_details(book_path)
    show_menu(clip_text(title, 80), { tr("Chapters"), tr("Font size"), tr("Background colour") }, function(i)
        if i == 1 then
            open_chapters(book_path)
        elseif i == 2 then
            open_font_menu()
        else
            open_background_menu()
        end
    end)
end

-- Covers and titles not read yet are prepared in the background and appear
-- the next time a list opens.
local function queue_missing_covers(paths)
    if not ensure_cache() then
        return
    end
    for i = 1, #paths do
        local key = plugin.md5(paths[i])
        local _, _, details_cached = cached_book_details(paths[i])
        if (not file_exists(cover_file(paths[i])) and plugin.storage.get("nocover:" .. key) ~= "1")
            or not details_cached
        then
            queue_cover(paths[i])
        end
    end
end

-- The library: a grid of cover cards, the book read last first. Each book
-- opens at its own saved position; a long press offers its menu.
local function open_library()
    local paths = scan_epub_files()
    if #paths == 0 then
        local items = {
            {
                label = tr("No EPUB books found\nCopy EPUB files into the Books folder on your SD card."),
                icon = ICON_EPUB,
                wrap = true,
            },
            { label = tr("Refresh library"), icon = ICON_EPUB },
        }
        plugin.show_list(tr("EPUB Reader"), items, function(index)
            if index == 2 then open_library() end
        end)
        return
    end

    local last = plugin.storage.get("continue")
    for i = 2, #paths do
        if paths[i] == last then
            table.insert(paths, 1, table.remove(paths, i))
            break
        end
    end

    local have_cache = ensure_cache()
    local items = {}
    for i = 1, #paths do
        local title, author = book_details(paths[i])
        local label = title .. (author ~= "" and ("\n" .. author) or "")
        local item = { label = clip_text(label, 511), icon = ICON_EPUB, wrap = true }
        local cover = cover_file(paths[i])
        if have_cache and file_exists(cover) then
            item.icon = cover
        end
        items[i] = item
    end
    queue_missing_covers(paths)

    chapter_generation = chapter_generation + 1 -- drops a chapter still preparing pictures
    local opts = {
        layout = "grid",
        columns = 2,
        on_hold = function(index)
            if paths[index] then
                open_book_menu(paths[index])
            end
        end,
    }
    local grid_handle
    grid_handle = plugin.show_list(tr("EPUB Reader"), items, function(index)
        if paths[index] then
            open_book(paths[index], grid_handle)
        end
    end, opts)
end

plugin.register_list_item("books", "EPUB Reader", open_library, {
    icon = ICON_EPUB,
})
