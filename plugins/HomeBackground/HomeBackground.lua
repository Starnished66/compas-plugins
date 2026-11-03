-- Choose a photo for the Home screen background.
-- The player prepares an exact-screen RGB565 image asynchronously so the
-- Home layout can use it directly at startup.

plugin.define({
    id = "org.example.home_background",
    name = "Home Background",
    version = "1.3.0",
    api_min = 19,
})

local T = {
    de = {
        ["Wallpaper"] = "Hintergrundbild",
        ["Wallpaper is off"] = "Hintergrundbild ist aus",
        ["Using previous wallpaper; choose a new image"] = "Vorheriges Hintergrundbild aktiv; wähle ein neues Bild",
        ["Saved image unusable; choose another"] = "Gespeichertes Bild unbrauchbar; wähle ein anderes",
        ["Wallpaper is set"] = "Hintergrundbild ist festgelegt",
        ["Using existing wallpaper"] = "Vorhandenes Hintergrundbild wird verwendet",
        ["No wallpaper set"] = "Kein Hintergrundbild festgelegt",
        ["Player is busy; try again shortly"] = "Player ist beschäftigt; versuche es gleich erneut",
        ["That image's resolution is too large"] = "Die Auflösung dieses Bildes ist zu groß",
        ["Choose an image no larger than 3 MB"] = "Wähle ein Bild mit maximal 3 MB",
        ["Not enough memory to prepare that image"] = "Nicht genug Speicher, um dieses Bild vorzubereiten",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Bild konnte nicht gelesen werden; wähle ein gültiges JPG, PNG oder BMP",
        ["Could not open that folder; choose another location"] = "Ordner konnte nicht geöffnet werden; wähle einen anderen Ort",
        ["Could not create the wallpaper folder on the SD card"] = "Hintergrundbild-Ordner auf der SD-Karte konnte nicht erstellt werden",
        ["Could not prepare the wallpaper"] = "Hintergrundbild konnte nicht vorbereitet werden",
        ["Wallpaper preparation is already in progress"] = "Hintergrundbild wird bereits vorbereitet",
        ["Wallpaper selection needs a newer player build"] = "Hintergrundbild-Auswahl erfordert eine neuere Player-Version",
        ["Wallpaper preparation needs a newer player build"] = "Hintergrundbild-Vorbereitung erfordert eine neuere Player-Version",
        ["Preparing image…"] = "Bild wird vorbereitet…",
        ["Wallpaper saved"] = "Hintergrundbild gespeichert",
        ["Wait for wallpaper preparation to finish"] = "Warte, bis die Vorbereitung abgeschlossen ist",
        ["Could not remove the saved wallpaper"] = "Gespeichertes Hintergrundbild konnte nicht entfernt werden",
        ["Wallpaper removed"] = "Hintergrundbild entfernt",
        ["Choose background"] = "Hintergrund auswählen",
        ["Remove background"] = "Hintergrund entfernen",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG, PNG oder BMP · bis zu 3 MB",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "PNG/BMP darf evtl. maximal 1200 px pro Seite haben.",
        ["Fills the screen; edges may be cropped."] = "Füllt den Bildschirm; Ränder werden evtl. beschnitten.",
    },
    es = {
        ["Wallpaper"] = "Fondo de pantalla",
        ["Wallpaper is off"] = "El fondo de pantalla está desactivado",
        ["Using previous wallpaper; choose a new image"] = "Usando el fondo anterior; elige una imagen nueva",
        ["Saved image unusable; choose another"] = "La imagen guardada no se puede usar; elige otra",
        ["Wallpaper is set"] = "Fondo de pantalla configurado",
        ["Using existing wallpaper"] = "Usando el fondo de pantalla actual",
        ["No wallpaper set"] = "Sin fondo de pantalla",
        ["Player is busy; try again shortly"] = "El reproductor está ocupado; inténtalo en un momento",
        ["That image's resolution is too large"] = "La resolución de esa imagen es demasiado grande",
        ["Choose an image no larger than 3 MB"] = "Elige una imagen de no más de 3 MB",
        ["Not enough memory to prepare that image"] = "No hay memoria suficiente para preparar esa imagen",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "No se pudo leer la imagen; elige un JPG, PNG o BMP válido",
        ["Could not open that folder; choose another location"] = "No se pudo abrir esa carpeta; elige otra ubicación",
        ["Could not create the wallpaper folder on the SD card"] = "No se pudo crear la carpeta del fondo en la tarjeta SD",
        ["Could not prepare the wallpaper"] = "No se pudo preparar el fondo de pantalla",
        ["Wallpaper preparation is already in progress"] = "Ya se está preparando un fondo de pantalla",
        ["Wallpaper selection needs a newer player build"] = "La selección de fondo requiere una versión más reciente del reproductor",
        ["Wallpaper preparation needs a newer player build"] = "La preparación de fondo requiere una versión más reciente del reproductor",
        ["Preparing image…"] = "Preparando imagen…",
        ["Wallpaper saved"] = "Fondo de pantalla guardado",
        ["Wait for wallpaper preparation to finish"] = "Espera a que termine de prepararse el fondo",
        ["Could not remove the saved wallpaper"] = "No se pudo eliminar el fondo de pantalla guardado",
        ["Wallpaper removed"] = "Fondo de pantalla eliminado",
        ["Choose background"] = "Elegir fondo",
        ["Remove background"] = "Quitar fondo",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG, PNG o BMP · hasta 3 MB",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "PNG/BMP puede requerir 1200 px o menos por lado.",
        ["Fills the screen; edges may be cropped."] = "Llena la pantalla; los bordes pueden recortarse.",
    },
    fi = {
        ["Wallpaper"] = "Taustakuva",
        ["Wallpaper is off"] = "Taustakuva on pois käytöstä",
        ["Using previous wallpaper; choose a new image"] = "Käytetään aiempaa taustakuvaa; valitse uusi kuva",
        ["Saved image unusable; choose another"] = "Tallennettu kuva ei kelpaa; valitse toinen",
        ["Wallpaper is set"] = "Taustakuva on asetettu",
        ["Using existing wallpaper"] = "Käytetään nykyistä taustakuvaa",
        ["No wallpaper set"] = "Ei taustakuvaa",
        ["Player is busy; try again shortly"] = "Soitin on varattu; yritä pian uudelleen",
        ["That image's resolution is too large"] = "Kuvan tarkkuus on liian suuri",
        ["Choose an image no larger than 3 MB"] = "Valitse enintään 3 MB:n kuva",
        ["Not enough memory to prepare that image"] = "Muisti ei riitä kuvan valmisteluun",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Kuvaa ei voitu lukea; valitse kelvollinen JPG, PNG tai BMP",
        ["Could not open that folder; choose another location"] = "Kansiota ei voitu avata; valitse toinen sijainti",
        ["Could not create the wallpaper folder on the SD card"] = "Taustakuvakansiota ei voitu luoda SD-kortille",
        ["Could not prepare the wallpaper"] = "Taustakuvan valmistelu epäonnistui",
        ["Wallpaper preparation is already in progress"] = "Taustakuvan valmistelu on jo käynnissä",
        ["Wallpaper selection needs a newer player build"] = "Taustakuvan valinta vaatii uudemman soitinversion",
        ["Wallpaper preparation needs a newer player build"] = "Taustakuvan valmistelu vaatii uudemman soitinversion",
        ["Preparing image…"] = "Valmistellaan kuvaa…",
        ["Wallpaper saved"] = "Taustakuva tallennettu",
        ["Wait for wallpaper preparation to finish"] = "Odota taustakuvan valmistelun valmistumista",
        ["Could not remove the saved wallpaper"] = "Tallennettua taustakuvaa ei voitu poistaa",
        ["Wallpaper removed"] = "Taustakuva poistettu",
        ["Choose background"] = "Valitse tausta",
        ["Remove background"] = "Poista tausta",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG, PNG tai BMP · enintään 3 MB",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "PNG/BMP-kuvan sivun on ehkä oltava enintään 1200 px.",
        ["Fills the screen; edges may be cropped."] = "Täyttää näytön; reunoja voidaan rajata.",
    },
    fr = {
        ["Wallpaper"] = "Fond d'écran",
        ["Wallpaper is off"] = "Le fond d'écran est désactivé",
        ["Using previous wallpaper; choose a new image"] = "Fond précédent utilisé ; choisissez une nouvelle image",
        ["Saved image unusable; choose another"] = "Image enregistrée inutilisable ; choisissez-en une autre",
        ["Wallpaper is set"] = "Fond d'écran défini",
        ["Using existing wallpaper"] = "Fond d'écran existant utilisé",
        ["No wallpaper set"] = "Aucun fond d'écran défini",
        ["Player is busy; try again shortly"] = "Le lecteur est occupé ; réessayez dans un instant",
        ["That image's resolution is too large"] = "La résolution de cette image est trop grande",
        ["Choose an image no larger than 3 MB"] = "Choisissez une image de 3 Mo maximum",
        ["Not enough memory to prepare that image"] = "Mémoire insuffisante pour préparer cette image",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Impossible de lire cette image ; choisissez un JPG, PNG ou BMP valide",
        ["Could not open that folder; choose another location"] = "Impossible d'ouvrir ce dossier ; choisissez un autre emplacement",
        ["Could not create the wallpaper folder on the SD card"] = "Impossible de créer le dossier du fond d'écran sur la carte SD",
        ["Could not prepare the wallpaper"] = "Impossible de préparer le fond d'écran",
        ["Wallpaper preparation is already in progress"] = "La préparation du fond d'écran est déjà en cours",
        ["Wallpaper selection needs a newer player build"] = "Le choix du fond d'écran nécessite une version plus récente du lecteur",
        ["Wallpaper preparation needs a newer player build"] = "La préparation du fond d'écran nécessite une version plus récente du lecteur",
        ["Preparing image…"] = "Préparation de l'image…",
        ["Wallpaper saved"] = "Fond d'écran enregistré",
        ["Wait for wallpaper preparation to finish"] = "Attendez la fin de la préparation du fond d'écran",
        ["Could not remove the saved wallpaper"] = "Impossible de supprimer le fond d'écran enregistré",
        ["Wallpaper removed"] = "Fond d'écran supprimé",
        ["Choose background"] = "Choisir le fond",
        ["Remove background"] = "Supprimer le fond",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG, PNG ou BMP · jusqu'à 3 Mo",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "Les PNG/BMP doivent parfois faire 1200 px ou moins par côté.",
        ["Fills the screen; edges may be cropped."] = "Remplit l'écran ; les bords peuvent être rognés.",
    },
    it = {
        ["Wallpaper"] = "Sfondo",
        ["Wallpaper is off"] = "Lo sfondo è disattivato",
        ["Using previous wallpaper; choose a new image"] = "In uso lo sfondo precedente; scegli una nuova immagine",
        ["Saved image unusable; choose another"] = "Immagine salvata non utilizzabile; scegline un'altra",
        ["Wallpaper is set"] = "Sfondo impostato",
        ["Using existing wallpaper"] = "In uso lo sfondo esistente",
        ["No wallpaper set"] = "Nessuno sfondo impostato",
        ["Player is busy; try again shortly"] = "Il lettore è occupato; riprova tra poco",
        ["That image's resolution is too large"] = "La risoluzione dell'immagine è troppo grande",
        ["Choose an image no larger than 3 MB"] = "Scegli un'immagine non più grande di 3 MB",
        ["Not enough memory to prepare that image"] = "Memoria insufficiente per preparare l'immagine",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Impossibile leggere l'immagine; scegli un JPG, PNG o BMP valido",
        ["Could not open that folder; choose another location"] = "Impossibile aprire la cartella; scegli un'altra posizione",
        ["Could not create the wallpaper folder on the SD card"] = "Impossibile creare la cartella dello sfondo sulla scheda SD",
        ["Could not prepare the wallpaper"] = "Impossibile preparare lo sfondo",
        ["Wallpaper preparation is already in progress"] = "Preparazione dello sfondo già in corso",
        ["Wallpaper selection needs a newer player build"] = "La selezione dello sfondo richiede una versione più recente del lettore",
        ["Wallpaper preparation needs a newer player build"] = "La preparazione dello sfondo richiede una versione più recente del lettore",
        ["Preparing image…"] = "Preparazione immagine…",
        ["Wallpaper saved"] = "Sfondo salvato",
        ["Wait for wallpaper preparation to finish"] = "Attendi il termine della preparazione dello sfondo",
        ["Could not remove the saved wallpaper"] = "Impossibile rimuovere lo sfondo salvato",
        ["Wallpaper removed"] = "Sfondo rimosso",
        ["Choose background"] = "Scegli sfondo",
        ["Remove background"] = "Rimuovi sfondo",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG, PNG o BMP · fino a 3 MB",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "PNG/BMP potrebbe dover essere di 1200 px o meno per lato.",
        ["Fills the screen; edges may be cropped."] = "Riempie lo schermo; i bordi possono essere ritagliati.",
    },
    ja = {
        ["Wallpaper"] = "壁紙",
        ["Wallpaper is off"] = "壁紙はオフです",
        ["Using previous wallpaper; choose a new image"] = "前の壁紙を使用中です。新しい画像を選択してください",
        ["Saved image unusable; choose another"] = "保存された画像は使用できません。別の画像を選択してください",
        ["Wallpaper is set"] = "壁紙が設定されています",
        ["Using existing wallpaper"] = "既存の壁紙を使用中",
        ["No wallpaper set"] = "壁紙が設定されていません",
        ["Player is busy; try again shortly"] = "プレーヤーが処理中です。しばらくしてから再試行してください",
        ["That image's resolution is too large"] = "画像の解像度が大きすぎます",
        ["Choose an image no larger than 3 MB"] = "3 MB 以下の画像を選択してください",
        ["Not enough memory to prepare that image"] = "メモリ不足のため画像を準備できません",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "画像を読み込めませんでした。有効な JPG、PNG、または BMP を選択してください",
        ["Could not open that folder; choose another location"] = "フォルダを開けませんでした。別の場所を選択してください",
        ["Could not create the wallpaper folder on the SD card"] = "SD カードに壁紙フォルダを作成できませんでした",
        ["Could not prepare the wallpaper"] = "壁紙を準備できませんでした",
        ["Wallpaper preparation is already in progress"] = "壁紙の準備が進行中です",
        ["Wallpaper selection needs a newer player build"] = "壁紙の選択には新しいプレーヤーが必要です",
        ["Wallpaper preparation needs a newer player build"] = "壁紙の準備には新しいプレーヤーが必要です",
        ["Preparing image…"] = "画像を準備中…",
        ["Wallpaper saved"] = "壁紙を保存しました",
        ["Wait for wallpaper preparation to finish"] = "壁紙の準備が終わるまでお待ちください",
        ["Could not remove the saved wallpaper"] = "保存された壁紙を削除できませんでした",
        ["Wallpaper removed"] = "壁紙を削除しました",
        ["Choose background"] = "背景を選択",
        ["Remove background"] = "背景を削除",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG、PNG、BMP · 最大 3 MB",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "PNG/BMP は1辺 1200 px 以下にする必要がある場合があります。",
        ["Fills the screen; edges may be cropped."] = "画面全体に表示されます（端が切り取られる場合があります）。",
    },
    nl = {
        ["Wallpaper"] = "Achtergrond",
        ["Wallpaper is off"] = "Achtergrond is uit",
        ["Using previous wallpaper; choose a new image"] = "Vorige achtergrond in gebruik; kies een nieuwe afbeelding",
        ["Saved image unusable; choose another"] = "Opgeslagen afbeelding onbruikbaar; kies een andere",
        ["Wallpaper is set"] = "Achtergrond is ingesteld",
        ["Using existing wallpaper"] = "Bestaande achtergrond in gebruik",
        ["No wallpaper set"] = "Geen achtergrond ingesteld",
        ["Player is busy; try again shortly"] = "Speler is bezig; probeer het zo opnieuw",
        ["That image's resolution is too large"] = "De resolutie van die afbeelding is te groot",
        ["Choose an image no larger than 3 MB"] = "Kies een afbeelding van maximaal 3 MB",
        ["Not enough memory to prepare that image"] = "Onvoldoende geheugen om die afbeelding voor te bereiden",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Afbeelding kon niet worden gelezen; kies een geldige JPG, PNG of BMP",
        ["Could not open that folder; choose another location"] = "Kon die map niet openen; kies een andere locatie",
        ["Could not create the wallpaper folder on the SD card"] = "Kon de achtergrondmap niet aanmaken op de SD-kaart",
        ["Could not prepare the wallpaper"] = "Kon de achtergrond niet voorbereiden",
        ["Wallpaper preparation is already in progress"] = "Voorbereiden van achtergrond is al bezig",
        ["Wallpaper selection needs a newer player build"] = "Achtergrondselectie vereist een nieuwere spelerversie",
        ["Wallpaper preparation needs a newer player build"] = "Achtergrondvoorbereiding vereist een nieuwere spelerversie",
        ["Preparing image…"] = "Afbeelding voorbereiden…",
        ["Wallpaper saved"] = "Achtergrond opgeslagen",
        ["Wait for wallpaper preparation to finish"] = "Wacht tot het voorbereiden van de achtergrond klaar is",
        ["Could not remove the saved wallpaper"] = "Kon de opgeslagen achtergrond niet verwijderen",
        ["Wallpaper removed"] = "Achtergrond verwijderd",
        ["Choose background"] = "Achtergrond kiezen",
        ["Remove background"] = "Achtergrond verwijderen",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG, PNG of BMP · tot 3 MB",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "PNG/BMP moet mogelijk ook 1200 px of kleiner per zijde zijn.",
        ["Fills the screen; edges may be cropped."] = "Vult het scherm; randen kunnen worden bijgesneden.",
    },
    pt = {
        ["Wallpaper"] = "Papel de parede",
        ["Wallpaper is off"] = "O papel de parede está desativado",
        ["Using previous wallpaper; choose a new image"] = "Usando o papel de parede anterior; escolha uma nova imagem",
        ["Saved image unusable; choose another"] = "Imagem salva inutilizável; escolha outra",
        ["Wallpaper is set"] = "Papel de parede definido",
        ["Using existing wallpaper"] = "Usando o papel de parede existente",
        ["No wallpaper set"] = "Nenhum papel de parede definido",
        ["Player is busy; try again shortly"] = "O reprodutor está ocupado; tente novamente em instantes",
        ["That image's resolution is too large"] = "A resolução dessa imagem é muito grande",
        ["Choose an image no larger than 3 MB"] = "Escolha uma imagem de no máximo 3 MB",
        ["Not enough memory to prepare that image"] = "Memória insuficiente para preparar essa imagem",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Não foi possível ler a imagem; escolha um JPG, PNG ou BMP válido",
        ["Could not open that folder; choose another location"] = "Não foi possível abrir essa pasta; escolha outro local",
        ["Could not create the wallpaper folder on the SD card"] = "Não foi possível criar a pasta do papel de parede no cartão SD",
        ["Could not prepare the wallpaper"] = "Não foi possível preparar o papel de parede",
        ["Wallpaper preparation is already in progress"] = "A preparação do papel de parede já está em andamento",
        ["Wallpaper selection needs a newer player build"] = "A seleção de papel de parede requer uma versão mais recente do reprodutor",
        ["Wallpaper preparation needs a newer player build"] = "A preparação do papel de parede requer uma versão mais recente do reprodutor",
        ["Preparing image…"] = "Preparando imagem…",
        ["Wallpaper saved"] = "Papel de parede salvo",
        ["Wait for wallpaper preparation to finish"] = "Aguarde o término da preparação do papel de parede",
        ["Could not remove the saved wallpaper"] = "Não foi possível remover o papel de parede salvo",
        ["Wallpaper removed"] = "Papel de parede removido",
        ["Choose background"] = "Escolher fundo",
        ["Remove background"] = "Remover fundo",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG, PNG ou BMP · até 3 MB",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "PNG/BMP também pode precisar ter 1200 px ou menos por lado.",
        ["Fills the screen; edges may be cropped."] = "Preenche a tela; as bordas podem ser cortadas.",
    },
    ru = {
        ["Wallpaper"] = "Обои",
        ["Wallpaper is off"] = "Обои отключены",
        ["Using previous wallpaper; choose a new image"] = "Используются прежние обои; выберите новое изображение",
        ["Saved image unusable; choose another"] = "Сохранённое изображение непригодно; выберите другое",
        ["Wallpaper is set"] = "Обои установлены",
        ["Using existing wallpaper"] = "Используются текущие обои",
        ["No wallpaper set"] = "Обои не установлены",
        ["Player is busy; try again shortly"] = "Плеер занят; повторите попытку чуть позже",
        ["That image's resolution is too large"] = "Слишком большое разрешение изображения",
        ["Choose an image no larger than 3 MB"] = "Выберите изображение размером не более 3 МБ",
        ["Not enough memory to prepare that image"] = "Недостаточно памяти для подготовки изображения",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Не удалось прочитать изображение; выберите корректный JPG, PNG или BMP",
        ["Could not open that folder; choose another location"] = "Не удалось открыть папку; выберите другое место",
        ["Could not create the wallpaper folder on the SD card"] = "Не удалось создать папку для обоев на SD-карте",
        ["Could not prepare the wallpaper"] = "Не удалось подготовить обои",
        ["Wallpaper preparation is already in progress"] = "Подготовка обоев уже выполняется",
        ["Wallpaper selection needs a newer player build"] = "Для выбора обоев требуется более новая версия плеера",
        ["Wallpaper preparation needs a newer player build"] = "Для подготовки обоев требуется более новая версия плеера",
        ["Preparing image…"] = "Подготовка изображения…",
        ["Wallpaper saved"] = "Обои сохранены",
        ["Wait for wallpaper preparation to finish"] = "Дождитесь завершения подготовки обоев",
        ["Could not remove the saved wallpaper"] = "Не удалось удалить сохранённые обои",
        ["Wallpaper removed"] = "Обои удалены",
        ["Choose background"] = "Выбрать фон",
        ["Remove background"] = "Удалить фон",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG, PNG или BMP · до 3 МБ",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "Для PNG/BMP может требоваться не более 1200 пикс. по стороне.",
        ["Fills the screen; edges may be cropped."] = "Заполняет экран; края могут быть обрезаны.",
    },
    uk = {
        ["Wallpaper"] = "Шпалери",
        ["Wallpaper is off"] = "Шпалери вимкнено",
        ["Using previous wallpaper; choose a new image"] = "Використовуються попередні шпалери; виберіть нове зображення",
        ["Saved image unusable; choose another"] = "Збережене зображення непридатне; виберіть інше",
        ["Wallpaper is set"] = "Шпалери встановлено",
        ["Using existing wallpaper"] = "Використовуються наявні шпалери",
        ["No wallpaper set"] = "Шпалери не встановлено",
        ["Player is busy; try again shortly"] = "Плеєр зайнятий; спробуйте ще раз за мить",
        ["That image's resolution is too large"] = "Роздільна здатність цього зображення завелика",
        ["Choose an image no larger than 3 MB"] = "Виберіть зображення розміром не більше 3 МБ",
        ["Not enough memory to prepare that image"] = "Недостатньо пам'яті для підготовки зображення",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Не вдалося прочитати зображення; виберіть коректний JPG, PNG або BMP",
        ["Could not open that folder; choose another location"] = "Не вдалося відкрити теку; виберіть інше розташування",
        ["Could not create the wallpaper folder on the SD card"] = "Не вдалося створити теку для шпалер на SD-карті",
        ["Could not prepare the wallpaper"] = "Не вдалося підготувати шпалери",
        ["Wallpaper preparation is already in progress"] = "Підготовка шпалер уже триває",
        ["Wallpaper selection needs a newer player build"] = "Для вибору шпалер потрібна новіша версія плеєра",
        ["Wallpaper preparation needs a newer player build"] = "Для підготовки шпалер потрібна новіша версія плеєра",
        ["Preparing image…"] = "Підготовка зображення…",
        ["Wallpaper saved"] = "Шпалери збережено",
        ["Wait for wallpaper preparation to finish"] = "Зачекайте завершення підготовки шпалер",
        ["Could not remove the saved wallpaper"] = "Не вдалося видалити збережені шпалери",
        ["Wallpaper removed"] = "Шпалери видалено",
        ["Choose background"] = "Вибрати тло",
        ["Remove background"] = "Видалити тло",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG, PNG або BMP · до 3 МБ",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "Для PNG/BMP може знадобитися розмір до 1200 пікс. по стороні.",
        ["Fills the screen; edges may be cropped."] = "Заповнює екран; краї можуть бути обрізані.",
    },
    vi = {
        ["Wallpaper"] = "Hình nền",
        ["Wallpaper is off"] = "Hình nền đang tắt",
        ["Using previous wallpaper; choose a new image"] = "Đang dùng hình nền trước; hãy chọn ảnh mới",
        ["Saved image unusable; choose another"] = "Ảnh đã lưu không dùng được; hãy chọn ảnh khác",
        ["Wallpaper is set"] = "Đã đặt hình nền",
        ["Using existing wallpaper"] = "Đang dùng hình nền hiện có",
        ["No wallpaper set"] = "Chưa đặt hình nền",
        ["Player is busy; try again shortly"] = "Máy phát đang bận; hãy thử lại sau ít phút",
        ["That image's resolution is too large"] = "Độ phân giải của ảnh quá lớn",
        ["Choose an image no larger than 3 MB"] = "Hãy chọn ảnh không quá 3 MB",
        ["Not enough memory to prepare that image"] = "Không đủ bộ nhớ để chuẩn bị ảnh này",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Không đọc được ảnh; hãy chọn tệp JPG, PNG hoặc BMP hợp lệ",
        ["Could not open that folder; choose another location"] = "Không mở được thư mục đó; hãy chọn vị trí khác",
        ["Could not create the wallpaper folder on the SD card"] = "Không thể tạo thư mục hình nền trên thẻ SD",
        ["Could not prepare the wallpaper"] = "Không thể chuẩn bị hình nền",
        ["Wallpaper preparation is already in progress"] = "Đang chuẩn bị hình nền rồi",
        ["Wallpaper selection needs a newer player build"] = "Chọn hình nền cần bản dựng máy phát mới hơn",
        ["Wallpaper preparation needs a newer player build"] = "Chuẩn bị hình nền cần bản dựng máy phát mới hơn",
        ["Preparing image…"] = "Đang chuẩn bị ảnh…",
        ["Wallpaper saved"] = "Đã lưu hình nền",
        ["Wait for wallpaper preparation to finish"] = "Hãy đợi chuẩn bị xong hình nền",
        ["Could not remove the saved wallpaper"] = "Không thể xóa hình nền đã lưu",
        ["Wallpaper removed"] = "Đã xóa hình nền",
        ["Choose background"] = "Chọn hình nền",
        ["Remove background"] = "Xóa hình nền",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG, PNG hoặc BMP · tối đa 3 MB",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "PNG/BMP cũng có thể cần từ 1200 px trở xuống mỗi cạnh.",
        ["Fills the screen; edges may be cropped."] = "Lấp đầy màn hình; các cạnh có thể bị cắt.",
    },
    zh_CN = {
        ["Wallpaper"] = "壁纸",
        ["Wallpaper is off"] = "壁纸已关闭",
        ["Using previous wallpaper; choose a new image"] = "正在使用之前的壁纸；请选择新图片",
        ["Saved image unusable; choose another"] = "已保存的图片不可用；请选择其他图片",
        ["Wallpaper is set"] = "壁纸已设置",
        ["Using existing wallpaper"] = "正在使用现有壁纸",
        ["No wallpaper set"] = "未设置壁纸",
        ["Player is busy; try again shortly"] = "播放器正忙，请稍后重试",
        ["That image's resolution is too large"] = "该图片分辨率过大",
        ["Choose an image no larger than 3 MB"] = "请选择不超过 3 MB 的图片",
        ["Not enough memory to prepare that image"] = "内存不足，无法准备该图片",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "无法读取该图片；请选择有效的 JPG、PNG 或 BMP",
        ["Could not open that folder; choose another location"] = "无法打开该文件夹；请选择其他位置",
        ["Could not create the wallpaper folder on the SD card"] = "无法在 SD 卡上创建壁纸文件夹",
        ["Could not prepare the wallpaper"] = "无法准备壁纸",
        ["Wallpaper preparation is already in progress"] = "壁纸准备已在运行中",
        ["Wallpaper selection needs a newer player build"] = "选择壁纸需要更新版本的播放器",
        ["Wallpaper preparation needs a newer player build"] = "准备壁纸需要更新版本的播放器",
        ["Preparing image…"] = "正在准备图片…",
        ["Wallpaper saved"] = "壁纸已保存",
        ["Wait for wallpaper preparation to finish"] = "请等待壁纸准备完成",
        ["Could not remove the saved wallpaper"] = "无法移除已保存的壁纸",
        ["Wallpaper removed"] = "壁纸已移除",
        ["Choose background"] = "选择背景",
        ["Remove background"] = "移除背景",
        ["JPG, PNG or BMP · up to 3 MB"] = "JPG、PNG 或 BMP · 最大 3 MB",
        ["PNG/BMP may also need to be 1200 px or smaller per side."] = "PNG/BMP 每边可能还需不超过 1200 像素。",
        ["Fills the screen; edges may be cropped."] = "填满屏幕；边缘可能会被裁剪。",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

local sd_root = plugin.sd_root()
local plugins_dir = sd_root .. "/.plugins"
local plugin_dir = plugins_dir .. "/HomeBackground"
local wallpaper_path = plugin_dir .. "/wallpaper.bin"
local legacy_path = plugins_dir .. "/home_bg.jpg"
local is_busy = false
local picker_busy = false
local unusable_background = false
local legacy_background_applied = false

local function file_exists(path)
    local file = io.open(path, "rb")
    if not file then return false end
    file:close()
    return true
end

local function apply_background()
    if not plugin.has_capability("ui.home_background") then return end
    if plugin.storage.get("disabled", "0") == "1" then return end

    -- The canonical file is managed by this plugin. Keep the old image as a
    -- fallback so existing installations retain their current background.
    if file_exists(wallpaper_path) then
        local ok = pcall(plugin.set_home_layout, {}, { background_image = wallpaper_path })
        if ok then return end
        unusable_background = true
    end
    if file_exists(legacy_path) then
        local ok = pcall(plugin.set_home_layout, {}, { background_image = legacy_path })
        if ok then
            legacy_background_applied = true
        else
            unusable_background = true
        end
    end
end

-- Layout options are applied during plugin loading, before Home is built.
apply_background()

local function current_background()
    if plugin.storage.get("disabled", "0") == "1" then return tr("Wallpaper is off") end
    if unusable_background then
        if legacy_background_applied then return tr("Using previous wallpaper; choose a new image") end
        return tr("Saved image unusable; choose another")
    end
    if file_exists(wallpaper_path) then return tr("Wallpaper is set") end
    if file_exists(legacy_path) then return tr("Using existing wallpaper") end
    return tr("No wallpaper set")
end

local function parent_folder(path)
    if type(path) ~= "string" then return nil end
    return path:match("^(.*)/[^/]+$")
end

local function picker_start_folder()
    local last_folder = plugin.storage.get("last_folder", "")
    if last_folder ~= "" then
        local ok, entries = pcall(plugin.list_dir, last_folder)
        if ok and type(entries) == "table" then return last_folder end
    end
    return nil -- Native picker opens at the SD root.
end

local function friendly_error(err)
    local message = string.lower(tostring(err or ""))
    if message:find("busy", 1, true) or message:find("already", 1, true) then
        return tr("Player is busy; try again shortly")
    elseif message:find("dimension", 1, true) then
        return tr("That image's resolution is too large")
    elseif message:find("3mb", 1, true) or message:find("size", 1, true)
        or message:find("large", 1, true) then
        return tr("Choose an image no larger than 3 MB")
    elseif message:find("memory", 1, true) or message:find("nomem", 1, true) then
        return tr("Not enough memory to prepare that image")
    elseif message:find("corrupt", 1, true) or message:find("invalid", 1, true)
        or message:find("decode", 1, true) or message:find("format", 1, true)
        or message:find("unsupported", 1, true) or message:find("pattern", 1, true) then
        return tr("That image could not be read; choose a valid JPG, PNG, or BMP")
    elseif message:find("open", 1, true) and message:find("folder", 1, true) then
        return tr("Could not open that folder; choose another location")
    elseif message:find("mkdir", 1, true) or message:find("create", 1, true) then
        return tr("Could not create the wallpaper folder on the SD card")
    end
    return tr("Could not prepare the wallpaper")
end

local function choose_wallpaper()
    if is_busy or picker_busy then
        plugin.show_toast(tr("Wallpaper preparation is already in progress"))
        return
    end
    if not plugin.has_capability("ui.file_picker") then
        plugin.show_toast(tr("Wallpaper selection needs a newer player build"))
        return
    end
    if not plugin.has_capability("data.wallpaper") then
        plugin.show_toast(tr("Wallpaper preparation needs a newer player build"))
        return
    end

    local function on_picked(source)
        picker_busy = false
        if not source then return end -- Cancel leaves the current image alone.

        local folder = parent_folder(source)
        if folder then plugin.storage.set("last_folder", folder) end

        if is_busy then
            plugin.show_toast(tr("Wallpaper preparation is already in progress"))
            return
        end
        if not plugin.mkdir(plugin_dir) then
            plugin.show_toast(tr("Could not create the wallpaper folder on the SD card"))
            return
        end

        is_busy = true
        local progress = nil
        if plugin.has_capability("ui.progress") then
            progress = plugin.show_progress(tr("Wallpaper"), tr("Preparing image…"), nil)
        end

        local started, start_err = plugin.image_wallpaper_async(source, wallpaper_path,
            function(dest_path, reason)
                is_busy = false
                if progress then plugin.close_progress(progress) end
                if dest_path then
                    plugin.storage.set("disabled", "0")
                    plugin.show_toast(tr("Wallpaper saved"))
                    if plugin.has_capability("ui.reload") then plugin.reload_ui() end
                else
                    plugin.show_toast(friendly_error(reason))
                end
            end)

        if not started then
            is_busy = false
            if progress then plugin.close_progress(progress) end
            plugin.show_toast(friendly_error(start_err))
        end
    end

    local folder = picker_start_folder()
    picker_busy = true
    local ok, result, open_err = pcall(plugin.pick_file, folder, on_picked)
    if (not ok or result ~= true) and folder then
        -- The remembered folder may disappear between validation and open.
        ok, result, open_err = pcall(plugin.pick_file, nil, on_picked)
    end
    if not ok or result ~= true then
        picker_busy = false
        plugin.show_toast(friendly_error(open_err or (not ok and result) or result))
    end
end

local function remove_wallpaper()
    if is_busy then
        plugin.show_toast(tr("Wait for wallpaper preparation to finish"))
        return
    end
    -- Remove our own converted file, then suppress both sources. The legacy
    -- image belongs to the user and must remain untouched.
    if file_exists(wallpaper_path) then
        local removed, err = os.remove(wallpaper_path)
        if not removed then
            plugin.show_toast(tr("Could not remove the saved wallpaper"))
            return
        end
    end
    plugin.storage.set("disabled", "1")
    plugin.show_toast(tr("Wallpaper removed"))
    if plugin.has_capability("ui.reload") then plugin.reload_ui() end
end

local function open_wallpaper_menu()
    if not plugin.has_capability("data.wallpaper") then
        plugin.show_toast(tr("Wallpaper selection needs a newer player build"))
        return
    end
    local function info_row(label)
        if plugin.has_capability("ui.list_wrap") then
            return { label = label, wrap = true }
        end
        return label
    end
    local items = {
        info_row(current_background()),
        tr("Choose background"),
        tr("Remove background"),
        info_row(tr("JPG, PNG or BMP · up to 3 MB")),
        info_row(tr("PNG/BMP may also need to be 1200 px or smaller per side.")),
        info_row(tr("Fills the screen; edges may be cropped.")),
    }
    plugin.show_list(tr("Wallpaper"), items, function(index)
        if index == 2 then
            choose_wallpaper()
        elseif index == 3 then
            remove_wallpaper()
        end
    end)
end

plugin.register_list_item("display", tr("Wallpaper"), open_wallpaper_menu, {
    group = "appearance",
})
