plugin.define({
  id = "example.lock_screen",
  name = "Lock Screen",
  version = "1.8.0",
  api_min = 19,
})

local T = {
  de = {
    ["Lock Screen"] = "Sperrbildschirm",
    ["Lock screen"] = "Sperrbildschirm",
    ["Lock Screen Background"] = "Sperrbildschirm-Hintergrund",
    ["Lock Screen needs a newer player build"] = "Sperrbildschirm erfordert eine neuere Player-Version",
    ["Album art"] = "Albumcover",
    ["Photo"] = "Foto",
    ["Clock"] = "Uhr",
    ["Choose a photo for the lock screen first"] = "Wähle zuerst ein Foto für den Sperrbildschirm",
    ["Could not show lock screen. Showing the clock instead."] = "Sperrbildschirm konnte nicht angezeigt werden. Stattdessen wird die Uhr gezeigt.",
    ["That folder path is too long to use for a lock screen photo"] = "Dieser Ordnerpfad ist zu lang für ein Sperrbildschirm-Foto",
    ["Could not read this photo folder"] = "Fotoordner konnte nicht gelesen werden",
    ["Folder: %s"] = "Ordner: %s",
    ["SD Card"] = "SD-Karte",
    ["Photos"] = "Fotos",
    ["No photos or folders here"] = "Keine Fotos oder Ordner hier",
    ["Choose Photo · %s"] = "Foto wählen · %s",
    ["Lock screen photo selected"] = "Sperrbildschirm-Foto ausgewählt",
    ["Framing"] = "Bildausschnitt",
    ["Framing: %s"] = "Bildausschnitt: %s",
    ["Fill screen"] = "Bildschirm füllen",
    ["Keep whole image"] = "Ganzes Bild behalten",
    ["Choose photo"] = "Foto wählen",
    ["Unlock with buttons"] = "Mit Tasten entsperren",
    ["Background"] = "Hintergrund",
    ["Preview lock screen"] = "Sperrbildschirm-Vorschau",
  },
  es = {
    ["Lock Screen"] = "Pantalla de bloqueo",
    ["Lock screen"] = "Pantalla de bloqueo",
    ["Lock Screen Background"] = "Fondo de pantalla de bloqueo",
    ["Lock Screen needs a newer player build"] = "La pantalla de bloqueo requiere una versión más reciente del reproductor",
    ["Album art"] = "Carátula del álbum",
    ["Photo"] = "Foto",
    ["Clock"] = "Reloj",
    ["Choose a photo for the lock screen first"] = "Elige primero una foto para la pantalla de bloqueo",
    ["Could not show lock screen. Showing the clock instead."] = "No se pudo mostrar la pantalla de bloqueo. Mostrando el reloj en su lugar.",
    ["That folder path is too long to use for a lock screen photo"] = "La ruta de esa carpeta es demasiado larga para una foto de bloqueo",
    ["Could not read this photo folder"] = "No se pudo leer esta carpeta de fotos",
    ["Folder: %s"] = "Carpeta: %s",
    ["SD Card"] = "Tarjeta SD",
    ["Photos"] = "Fotos",
    ["No photos or folders here"] = "No hay fotos ni carpetas aquí",
    ["Choose Photo · %s"] = "Elegir foto · %s",
    ["Lock screen photo selected"] = "Foto de pantalla de bloqueo seleccionada",
    ["Framing"] = "Encuadre",
    ["Framing: %s"] = "Encuadre: %s",
    ["Fill screen"] = "Llenar pantalla",
    ["Keep whole image"] = "Mantener imagen completa",
    ["Choose photo"] = "Elegir foto",
    ["Unlock with buttons"] = "Desbloquear con botones",
    ["Background"] = "Fondo",
    ["Preview lock screen"] = "Vista previa de bloqueo",
  },
  fi = {
    ["Lock Screen"] = "Lukitusnäyttö",
    ["Lock screen"] = "Lukitusnäyttö",
    ["Lock Screen Background"] = "Lukitusnäytön tausta",
    ["Lock Screen needs a newer player build"] = "Lukitusnäyttö vaatii uudemman soitinversion",
    ["Album art"] = "Albumin kansi",
    ["Photo"] = "Valokuva",
    ["Clock"] = "Kello",
    ["Choose a photo for the lock screen first"] = "Valitse ensin kuva lukitusnäyttöön",
    ["Could not show lock screen. Showing the clock instead."] = "Lukitusnäyttöä ei voitu näyttää. Näytetään kello sen sijaan.",
    ["That folder path is too long to use for a lock screen photo"] = "Kansiopiste on liian pitkä lukitusnäytön kuvalle",
    ["Could not read this photo folder"] = "Valokuvakansiota ei voitu lukea",
    ["Folder: %s"] = "Kansio: %s",
    ["SD Card"] = "SD-kortti",
    ["Photos"] = "Valokuvat",
    ["No photos or folders here"] = "Täällä ei ole valokuvia tai kansioita",
    ["Choose Photo · %s"] = "Valitse valokuva · %s",
    ["Lock screen photo selected"] = "Lukitusnäytön valokuva valittu",
    ["Framing"] = "Rajaus",
    ["Framing: %s"] = "Rajaus: %s",
    ["Fill screen"] = "Täytä näyttö",
    ["Keep whole image"] = "Säilytä koko kuva",
    ["Choose photo"] = "Valitse valokuva",
    ["Unlock with buttons"] = "Avaa lukitus painikkeilla",
    ["Background"] = "Tausta",
    ["Preview lock screen"] = "Esikatsele lukitusnäyttöä",
  },
  fr = {
    ["Lock Screen"] = "Écran de verrouillage",
    ["Lock screen"] = "Écran de verrouillage",
    ["Lock Screen Background"] = "Fond de l'écran de verrouillage",
    ["Lock Screen needs a newer player build"] = "L'écran de verrouillage nécessite une version plus récente du lecteur",
    ["Album art"] = "Pochette d'album",
    ["Photo"] = "Photo",
    ["Clock"] = "Horloge",
    ["Choose a photo for the lock screen first"] = "Choisissez d'abord une photo pour l'écran de verrouillage",
    ["Could not show lock screen. Showing the clock instead."] = "Impossible d'afficher l'écran de verrouillage. Affichage de l'horloge à la place.",
    ["That folder path is too long to use for a lock screen photo"] = "Ce chemin de dossier est trop long pour une photo de verrouillage",
    ["Could not read this photo folder"] = "Impossible de lire ce dossier de photos",
    ["Folder: %s"] = "Dossier : %s",
    ["SD Card"] = "Carte SD",
    ["Photos"] = "Photos",
    ["No photos or folders here"] = "Aucune photo ni aucun dossier ici",
    ["Choose Photo · %s"] = "Choisir une photo · %s",
    ["Lock screen photo selected"] = "Photo d'écran de verrouillage sélectionnée",
    ["Framing"] = "Cadrage",
    ["Framing: %s"] = "Cadrage : %s",
    ["Fill screen"] = "Remplir l'écran",
    ["Keep whole image"] = "Conserver toute l'image",
    ["Choose photo"] = "Choisir une photo",
    ["Unlock with buttons"] = "Déverrouiller avec les boutons",
    ["Background"] = "Fond",
    ["Preview lock screen"] = "Aperçu de l'écran de verrouillage",
  },
  it = {
    ["Lock Screen"] = "Schermata di blocco",
    ["Lock screen"] = "Schermata di blocco",
    ["Lock Screen Background"] = "Sfondo schermata di blocco",
    ["Lock Screen needs a newer player build"] = "La schermata di blocco richiede una versione più recente del lettore",
    ["Album art"] = "Copertina album",
    ["Photo"] = "Foto",
    ["Clock"] = "Orologio",
    ["Choose a photo for the lock screen first"] = "Scegli prima una foto per la schermata di blocco",
    ["Could not show lock screen. Showing the clock instead."] = "Impossibile mostrare la schermata di blocco. Viene mostrato l'orologio.",
    ["That folder path is too long to use for a lock screen photo"] = "Il percorso della cartella è troppo lungo per una foto di blocco",
    ["Could not read this photo folder"] = "Impossibile leggere questa cartella di foto",
    ["Folder: %s"] = "Cartella: %s",
    ["SD Card"] = "Scheda SD",
    ["Photos"] = "Foto",
    ["No photos or folders here"] = "Nessuna foto o cartella qui",
    ["Choose Photo · %s"] = "Scegli foto · %s",
    ["Lock screen photo selected"] = "Foto della schermata di blocco selezionata",
    ["Framing"] = "Inquadratura",
    ["Framing: %s"] = "Inquadratura: %s",
    ["Fill screen"] = "Riempi schermo",
    ["Keep whole image"] = "Mantieni immagine intera",
    ["Choose photo"] = "Scegli foto",
    ["Unlock with buttons"] = "Sblocca con i pulsanti",
    ["Background"] = "Sfondo",
    ["Preview lock screen"] = "Anteprima schermata di blocco",
  },
  ja = {
    ["Lock Screen"] = "ロック画面",
    ["Lock screen"] = "ロック画面",
    ["Lock Screen Background"] = "ロック画面の背景",
    ["Lock Screen needs a newer player build"] = "ロック画面には新しいプレーヤーが必要です",
    ["Album art"] = "アルバムアート",
    ["Photo"] = "写真",
    ["Clock"] = "時計",
    ["Choose a photo for the lock screen first"] = "先にロック画面用の写真を選択してください",
    ["Could not show lock screen. Showing the clock instead."] = "ロック画面を表示できませんでした。代わりに時計を表示します。",
    ["That folder path is too long to use for a lock screen photo"] = "ロック画面の写真に使用するにはフォルダパスが長すぎます",
    ["Could not read this photo folder"] = "この写真フォルダを読み込めませんでした",
    ["Folder: %s"] = "フォルダ: %s",
    ["SD Card"] = "SD カード",
    ["Photos"] = "写真",
    ["No photos or folders here"] = "写真やフォルダがありません",
    ["Choose Photo · %s"] = "写真を選択 · %s",
    ["Lock screen photo selected"] = "ロック画面の写真を選択しました",
    ["Framing"] = "表示方法",
    ["Framing: %s"] = "表示方法: %s",
    ["Fill screen"] = "画面いっぱいに表示",
    ["Keep whole image"] = "画像全体を表示",
    ["Choose photo"] = "写真を選択",
    ["Unlock with buttons"] = "ボタンでロック解除",
    ["Background"] = "背景",
    ["Preview lock screen"] = "ロック画面をプレビュー",
  },
  nl = {
    ["Lock Screen"] = "Vergrendelscherm",
    ["Lock screen"] = "Vergrendelscherm",
    ["Lock Screen Background"] = "Achtergrond vergrendelscherm",
    ["Lock Screen needs a newer player build"] = "Vergrendelscherm vereist een nieuwere spelerversie",
    ["Album art"] = "Albumhoes",
    ["Photo"] = "Foto",
    ["Clock"] = "Klok",
    ["Choose a photo for the lock screen first"] = "Kies eerst een foto voor het vergrendelscherm",
    ["Could not show lock screen. Showing the clock instead."] = "Kon vergrendelscherm niet tonen. De klok wordt weergegeven.",
    ["That folder path is too long to use for a lock screen photo"] = "Dat mappad is te lang voor een vergrendelschermfoto",
    ["Could not read this photo folder"] = "Kon deze fotomap niet lezen",
    ["Folder: %s"] = "Map: %s",
    ["SD Card"] = "SD-kaart",
    ["Photos"] = "Foto's",
    ["No photos or folders here"] = "Geen foto's of mappen hier",
    ["Choose Photo · %s"] = "Kies foto · %s",
    ["Lock screen photo selected"] = "Vergrendelschermfoto geselecteerd",
    ["Framing"] = "Weergave",
    ["Framing: %s"] = "Weergave: %s",
    ["Fill screen"] = "Scherm vullen",
    ["Keep whole image"] = "Hele afbeelding behouden",
    ["Choose photo"] = "Foto kiezen",
    ["Unlock with buttons"] = "Ontgrendelen met knoppen",
    ["Background"] = "Achtergrond",
    ["Preview lock screen"] = "Voorbeeld van vergrendelscherm",
  },
  pt = {
    ["Lock Screen"] = "Tela de bloqueio",
    ["Lock screen"] = "Tela de bloqueio",
    ["Lock Screen Background"] = "Fundo da tela de bloqueio",
    ["Lock Screen needs a newer player build"] = "A tela de bloqueio requer uma versão mais recente do reprodutor",
    ["Album art"] = "Capa do álbum",
    ["Photo"] = "Foto",
    ["Clock"] = "Relógio",
    ["Choose a photo for the lock screen first"] = "Escolha primeiro uma foto para a tela de bloqueio",
    ["Could not show lock screen. Showing the clock instead."] = "Não foi possível mostrar a tela de bloqueio. Mostrando o relógio.",
    ["That folder path is too long to use for a lock screen photo"] = "O caminho dessa pasta é longo demais para uma foto de bloqueio",
    ["Could not read this photo folder"] = "Não foi possível ler esta pasta de fotos",
    ["Folder: %s"] = "Pasta: %s",
    ["SD Card"] = "Cartão SD",
    ["Photos"] = "Fotos",
    ["No photos or folders here"] = "Nenhuma foto ou pasta aqui",
    ["Choose Photo · %s"] = "Escolher foto · %s",
    ["Lock screen photo selected"] = "Foto da tela de bloqueio selecionada",
    ["Framing"] = "Enquadramento",
    ["Framing: %s"] = "Enquadramento: %s",
    ["Fill screen"] = "Preencher a tela",
    ["Keep whole image"] = "Manter imagem inteira",
    ["Choose photo"] = "Escolher foto",
    ["Unlock with buttons"] = "Desbloquear com botões",
    ["Background"] = "Fundo",
    ["Preview lock screen"] = "Pré-visualizar tela de bloqueio",
  },
  ru = {
    ["Lock Screen"] = "Экран блокировки",
    ["Lock screen"] = "Экран блокировки",
    ["Lock Screen Background"] = "Фон экрана блокировки",
    ["Lock Screen needs a newer player build"] = "Для экрана блокировки требуется более новая версия плеера",
    ["Album art"] = "Обложка альбома",
    ["Photo"] = "Фото",
    ["Clock"] = "Часы",
    ["Choose a photo for the lock screen first"] = "Сначала выберите фото для экрана блокировки",
    ["Could not show lock screen. Showing the clock instead."] = "Не удалось показать экран блокировки. Вместо него показаны часы.",
    ["That folder path is too long to use for a lock screen photo"] = "Путь к папке слишком длинный для фото экрана блокировки",
    ["Could not read this photo folder"] = "Не удалось прочитать эту папку с фото",
    ["Folder: %s"] = "Папка: %s",
    ["SD Card"] = "SD-карта",
    ["Photos"] = "Фото",
    ["No photos or folders here"] = "Здесь нет фото или папок",
    ["Choose Photo · %s"] = "Выбрать фото · %s",
    ["Lock screen photo selected"] = "Фото для экрана блокировки выбрано",
    ["Framing"] = "Кадрирование",
    ["Framing: %s"] = "Кадрирование: %s",
    ["Fill screen"] = "Заполнить экран",
    ["Keep whole image"] = "Вместить целиком",
    ["Choose photo"] = "Выбрать фото",
    ["Unlock with buttons"] = "Разблокировка кнопками",
    ["Background"] = "Фон",
    ["Preview lock screen"] = "Предпросмотр экрана блокировки",
  },
  uk = {
    ["Lock Screen"] = "Екран блокування",
    ["Lock screen"] = "Екран блокування",
    ["Lock Screen Background"] = "Тло екрана блокування",
    ["Lock Screen needs a newer player build"] = "Для екрана блокування потрібна новіша версія плеєра",
    ["Album art"] = "Обкладинка альбому",
    ["Photo"] = "Фото",
    ["Clock"] = "Годинник",
    ["Choose a photo for the lock screen first"] = "Спочатку виберіть фото для екрана блокування",
    ["Could not show lock screen. Showing the clock instead."] = "Не вдалося показати екран блокування. Замість нього показано годинник.",
    ["That folder path is too long to use for a lock screen photo"] = "Шлях до теки занадто довгий для фото екрана блокування",
    ["Could not read this photo folder"] = "Не вдалося прочитати цю теку з фото",
    ["Folder: %s"] = "Тека: %s",
    ["SD Card"] = "SD-карта",
    ["Photos"] = "Фото",
    ["No photos or folders here"] = "Тут немає фото чи тек",
    ["Choose Photo · %s"] = "Вибрати фото · %s",
    ["Lock screen photo selected"] = "Фото для екрана блокування вибрано",
    ["Framing"] = "Кадрування",
    ["Framing: %s"] = "Кадрування: %s",
    ["Fill screen"] = "Заповнити екран",
    ["Keep whole image"] = "Вмістити повністю",
    ["Choose photo"] = "Вибрати фото",
    ["Unlock with buttons"] = "Розблокування кнопками",
    ["Background"] = "Тло",
    ["Preview lock screen"] = "Попередній перегляд екрана блокування",
  },
  vi = {
    ["Lock Screen"] = "Màn hình khóa",
    ["Lock screen"] = "Màn hình khóa",
    ["Lock Screen Background"] = "Nền màn hình khóa",
    ["Lock Screen needs a newer player build"] = "Màn hình khóa cần bản dựng máy phát mới hơn",
    ["Album art"] = "Ảnh bìa album",
    ["Photo"] = "Ảnh",
    ["Clock"] = "Đồng hồ",
    ["Choose a photo for the lock screen first"] = "Hãy chọn ảnh cho màn hình khóa trước",
    ["Could not show lock screen. Showing the clock instead."] = "Không thể hiện màn hình khóa. Đang hiện đồng hồ thay thế.",
    ["That folder path is too long to use for a lock screen photo"] = "Đường dẫn thư mục quá dài để dùng làm ảnh màn hình khóa",
    ["Could not read this photo folder"] = "Không thể đọc thư mục ảnh này",
    ["Folder: %s"] = "Thư mục: %s",
    ["SD Card"] = "Thẻ SD",
    ["Photos"] = "Ảnh",
    ["No photos or folders here"] = "Không có ảnh hoặc thư mục nào ở đây",
    ["Choose Photo · %s"] = "Chọn ảnh · %s",
    ["Lock screen photo selected"] = "Đã chọn ảnh màn hình khóa",
    ["Framing"] = "Khung hình",
    ["Framing: %s"] = "Khung hình: %s",
    ["Fill screen"] = "Lấp đầy màn hình",
    ["Keep whole image"] = "Giữ toàn bộ ảnh",
    ["Choose photo"] = "Chọn ảnh",
    ["Unlock with buttons"] = "Mở khóa bằng nút bấm",
    ["Background"] = "Nền",
    ["Preview lock screen"] = "Xem trước màn hình khóa",
  },
  zh_CN = {
    ["Lock Screen"] = "锁屏",
    ["Lock screen"] = "锁屏",
    ["Lock Screen Background"] = "锁屏背景",
    ["Lock Screen needs a newer player build"] = "锁屏功能需要更新版本的播放器",
    ["Album art"] = "专辑封面",
    ["Photo"] = "照片",
    ["Clock"] = "时钟",
    ["Choose a photo for the lock screen first"] = "请先为锁屏选择一张照片",
    ["Could not show lock screen. Showing the clock instead."] = "无法显示锁屏，已改为显示时钟。",
    ["That folder path is too long to use for a lock screen photo"] = "该文件夹路径过长，无法用作锁屏照片",
    ["Could not read this photo folder"] = "无法读取此照片文件夹",
    ["Folder: %s"] = "文件夹：%s",
    ["SD Card"] = "SD 卡",
    ["Photos"] = "照片",
    ["No photos or folders here"] = "此处没有照片或文件夹",
    ["Choose Photo · %s"] = "选择照片 · %s",
    ["Lock screen photo selected"] = "已选择锁屏照片",
    ["Framing"] = "画面比例",
    ["Framing: %s"] = "画面比例：%s",
    ["Fill screen"] = "填满屏幕",
    ["Keep whole image"] = "保留完整图片",
    ["Choose photo"] = "选择照片",
    ["Unlock with buttons"] = "使用按键解锁",
    ["Background"] = "背景",
    ["Preview lock screen"] = "预览锁屏",
  },
}

local function tr(s)
  return plugin.tr(s, T)
end

-- Lock Screen companion plugin.
-- Configures the screen shown when the display wakes from being off.

if not plugin.has_capability("ui.lock_screen") then
  plugin.show_toast(tr("Lock Screen needs a newer player build"))
  return
end

local KEY_MODE = "mode" -- Kept for migration from versions before 1.3.
local KEY_ENABLED = "enabled"
local KEY_BUTTON_LOCK = "button_lock"
local button_lock_shortcut
local KEY_BACKGROUND = "background"
local KEY_IMAGE = "image_path"
local KEY_IMAGE_FIT = "image_fit"

local BACKGROUNDS = {
  { key = "album_art", label = "Album art" },
  { key = "image", label = "Photo" },
  { key = "clock", label = "Clock" },
}

local function legacy_mode()
  local mode = plugin.storage.get(KEY_MODE, "off")
  if mode == "album_art" or mode == "image" or mode == "clock" then return mode end
  return "off"
end

local get_background

local function is_enabled()
  local saved = plugin.storage.get(KEY_ENABLED)
  if saved == "1" or saved == "true" then return true end
  if saved == "0" or saved == "false" then return false end
  return legacy_mode() ~= "off"
end

local function set_enabled(enabled)
  plugin.storage.set(KEY_ENABLED, enabled and "1" or "0")
  -- Preserve the old on/off representation for older plugin versions.
  plugin.storage.set(KEY_MODE, enabled and get_background() or "off")
end

local function is_button_lock_enabled()
  local saved = plugin.storage.get(KEY_BUTTON_LOCK)
  return saved == "1" or saved == "true"
end

local function set_button_lock_enabled(enabled)
  button_lock_shortcut = plugin.configure_button_lock(enabled)
  plugin.storage.set(KEY_BUTTON_LOCK, enabled and "1" or "0")
end

button_lock_shortcut = plugin.configure_button_lock(is_button_lock_enabled())

get_background = function()
  local saved = plugin.storage.get(KEY_BACKGROUND)
  if saved == "album_art" or saved == "image" or saved == "clock" then return saved end
  local old = legacy_mode()
  return old == "off" and "album_art" or old
end

local function set_background(background)
  plugin.storage.set(KEY_BACKGROUND, background)
  plugin.storage.set(KEY_MODE, is_enabled() and background or "off")
end

local function get_custom_image_path()
  return plugin.storage.get(KEY_IMAGE, "")
end

local function has_readable_photo(path)
  if not path or path == "" then return false end
  local file = io.open(path, "rb")
  if not file then return false end
  file:close()
  return true
end

local function get_custom_image_fit()
  local fit = plugin.storage.get(KEY_IMAGE_FIT)
  if fit == "contain" then return "contain" end
  -- Make new and migrated photo backgrounds fill the display by default.
  return "cover"
end

local function get_preview_options()
  local preview = {
    mode = get_background(),
    image_fit = get_custom_image_fit(),
  }
  if preview.mode == "image" then
    local image_path = get_custom_image_path()
    if has_readable_photo(image_path) then
      preview.image_path = image_path
    else
      preview.mode = "clock"
    end
  end
  return preview
end

local function trigger_lock_screen(preview)
  if not preview and not is_enabled() then return end

  local mode = get_background()
  local opts = { mode = mode, image_fit = get_custom_image_fit() }
  if mode == "image" then
    local image_path = get_custom_image_path()
    if not image_path or image_path == "" then
      plugin.show_toast(tr("Choose a photo for the lock screen first"))
      return
    end
    opts.image_path = image_path
  end

  local shown = plugin.show_lock_screen(opts)
  if not shown then
    plugin.show_toast(tr("Could not show lock screen. Showing the clock instead."))
    plugin.show_lock_screen({ mode = "clock" })
  end
end

plugin.on("screen_woke", trigger_lock_screen)

local function is_photo(name)
  local lower = name:lower()
  return lower:match("%.png$") or lower:match("%.jpg$") or lower:match("%.jpeg$")
end

local open_lock_settings
local open_background_settings

local function open_photo_picker(dir_path)
  dir_path = dir_path or plugin.sd_root()
  if #dir_path >= 256 then
    plugin.show_toast(tr("That folder path is too long to use for a lock screen photo"))
    return
  end

  local ok, files = pcall(plugin.list_dir, dir_path)
  if not ok then
    plugin.show_toast(tr("Could not read this photo folder"))
    return
  end
  if type(files) ~= "table" then
    plugin.show_toast(tr("Could not read this photo folder"))
    return
  end

  local folders, photos = {}, {}
  for i = 1, math.min(#files, 500) do
    local entry = files[i]
    if type(entry.name) == "string" then
      local full_path = dir_path .. "/" .. entry.name
      if #full_path < 256 then
        if entry.dir then
          folders[#folders + 1] = entry.name
        elseif is_photo(entry.name) then
          photos[#photos + 1] = entry.name
        end
      end
    end
  end
  table.sort(folders)
  table.sort(photos)

  local items, destinations = {}, {}
  local parent = nil
  local root = plugin.sd_root()
  if dir_path ~= root then
    local trimmed = dir_path:gsub("/+$", "")
    local parent_path = trimmed:match("^(.*)/[^/]+$")
    if parent_path and #parent_path >= #root then parent = parent_path end
  end
  if parent then
    items[#items + 1] = { label = ".." }
    destinations[#destinations + 1] = { path = parent }
  end

  local limit = 500 - #items
  for _, name in ipairs(folders) do
    if #items >= limit then break end
    items[#items + 1] = { label = string.format(tr("Folder: %s"), name) }
    destinations[#destinations + 1] = { path = dir_path .. "/" .. name }
  end
  for _, name in ipairs(photos) do
    if #items >= limit then break end
    local path = dir_path .. "/" .. name
    items[#items + 1] = { label = name }
    destinations[#destinations + 1] = { photo = path }
  end

  local folder_name = dir_path == root and tr("SD Card") or dir_path:match("([^/]+)/*$") or tr("Photos")
  if #items == 0 then
    plugin.show_toast(tr("No photos or folders here"))
    return
  end

  plugin.show_list(string.format(tr("Choose Photo · %s"), folder_name), items, function(index)
    local destination = destinations[index]
    if not destination then return end
    if destination.path then
      open_photo_picker(destination.path)
    elseif destination.photo then
      plugin.storage.set(KEY_IMAGE, destination.photo)
      set_background("image")
      plugin.show_toast(tr("Lock screen photo selected"))
      open_lock_settings(true)
      open_background_settings(true)
    end
  end)
end

-- Choices use native switches as the selection marker: exactly one is on,
-- and every tap rebuilds the screen in place so the marking stays exact.
local function open_framing_settings(update)
  local function choose(fit, name)
    plugin.storage.set(KEY_IMAGE_FIT, fit)
    plugin.show_toast(string.format(tr("Framing: %s"), tr(name)))
    open_lock_settings(true)
    open_framing_settings(true)
  end
  plugin.show_settings_list(tr("Framing"), {
    {
      type = "toggle",
      label = tr("Fill screen"),
      value = get_custom_image_fit() == "cover",
      on_change = function() choose("cover", "Fill screen") end,
    },
    {
      type = "toggle",
      label = tr("Keep whole image"),
      value = get_custom_image_fit() == "contain",
      on_change = function() choose("contain", "Keep whole image") end,
    },
  }, { update = update == true })
end

open_background_settings = function(update)
  local rows = {}
  for _, background in ipairs(BACKGROUNDS) do
    local selected_background = background.key
    local background_label = tr(background.label)
    rows[#rows + 1] = {
      type = "toggle",
      label = background_label,
      value = get_background() == selected_background,
      on_change = function()
        if selected_background == "image" and not has_readable_photo(get_custom_image_path()) then
          -- Nothing is chosen yet: put the switches back before the picker opens.
          open_background_settings(true)
          open_photo_picker()
        else
          set_background(selected_background)
          open_lock_settings(true)
          open_background_settings(true)
        end
      end,
    }
  end

  if get_background() == "image" then
    rows[#rows + 1] = {
      type = "row", label = tr("Choose photo"),
      on_select = function() open_photo_picker() end,
    }
  end

  plugin.show_settings_list(tr("Lock Screen Background"), rows, {
    update = update == true,
    preview = get_preview_options(),
  })
end

open_lock_settings = function(update)
  local background = get_background()
  local background_label = "Album art"
  for _, choice in ipairs(BACKGROUNDS) do
    if choice.key == background then background_label = choice.label end
  end

  local rows = {
    {
      type = "toggle",
      label = tr("Lock screen"),
      value = is_enabled(),
      on_change = function(value) set_enabled(value) end,
    },
    {
      type = "toggle",
      label = tr("Unlock with buttons") .. "\n" .. button_lock_shortcut,
      value = is_button_lock_enabled(),
      wrap = true,
      on_change = function(value) set_button_lock_enabled(value) end,
    },
    {
      type = "row",
      label = tr("Background") .. "\n" .. tr(background_label),
      wrap = true,
      on_select = open_background_settings,
    },
  }

  if background == "image" or background == "album_art" then
    rows[#rows + 1] = {
      type = "row",
      wrap = true,
      label = tr("Framing") .. "\n" .. tr(get_custom_image_fit() == "cover" and "Fill screen" or "Keep whole image"),
      on_select = function() open_framing_settings() end,
    }
  end

  rows[#rows + 1] = {
    type = "row",
    label = tr("Preview lock screen"),
    on_select = function() trigger_lock_screen(true) end,
  }

  plugin.show_settings_list(tr("Lock Screen"), rows, {
    update = update == true,
    preview = get_preview_options(),
  })
end

plugin.register_list_item("display", tr("Lock Screen"), open_lock_settings, {})
