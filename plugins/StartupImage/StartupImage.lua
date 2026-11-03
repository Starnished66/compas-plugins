-- Choose an image for the device's startup splash. The native player prepares
-- a screen-sized RGB565 cache and applies it on the next boot.

plugin.define({
    id = "org.compas.startup_image",
    name = "Startup Image",
    version = "1.1.0",
    api_min = 19,
})

local T = {
    de = {
        ["Startup Image"] = "Startbild",
        ["Player is busy; try again shortly"] = "Player ist beschäftigt; gleich erneut versuchen",
        ["Image dimensions are too large; choose a smaller image"] = "Bildabmessungen sind zu groß; wähle ein kleineres Bild",
        ["Choose an image no larger than 3 MB"] = "Wähle ein Bild mit maximal 3 MB",
        ["Not enough memory to prepare that image"] = "Nicht genügend Speicher, um dieses Bild vorzubereiten",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Bild konnte nicht gelesen werden; wähle ein gültiges JPG, PNG oder BMP",
        ["Could not prepare the startup image"] = "Startbild konnte nicht vorbereitet werden",
        ["Custom image set · applies on next boot"] = "Eigenes Bild festgelegt · gilt beim nächsten Start",
        ["Using the default splash"] = "Standard-Startbild wird verwendet",
        ["Choose image"] = "Bild auswählen",
        ["Restore default splash"] = "Standard-Startbild wiederherstellen",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG, PNG oder BMP · bis zu 3 MB",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "Änderungen gelten beim nächsten Start. Eigene Bilder behalten ihre Originalfarben.",
        ["Startup image preparation is already in progress"] = "Vorbereitung des Startbilds läuft bereits",
        ["Image selection needs a newer player build"] = "Bildauswahl erfordert eine neuere Player-Version",
        ["Startup image support needs a newer player build"] = "Startbild-Unterstützung erfordert eine neuere Player-Version",
        ["Choose a JPG, PNG, or BMP image"] = "Wähle ein JPG-, PNG- oder BMP-Bild",
        ["Could not create the startup image folder on the SD card"] = "Startbild-Ordner auf der SD-Karte konnte nicht erstellt werden",
        ["Preparing image…"] = "Bild wird vorbereitet…",
        ["Startup image saved · applies on next boot"] = "Startbild gespeichert · gilt beim nächsten Start",
        ["Wait for image preparation to finish"] = "Warte, bis die Bildvorbereitung abgeschlossen ist",
        ["Restoring default splash…"] = "Standard-Startbild wird wiederhergestellt…",
        ["Default splash restored · applies on next boot"] = "Standard-Startbild wiederhergestellt · gilt beim nächsten Start",
    },
    es = {
        ["Startup Image"] = "Imagen de inicio",
        ["Player is busy; try again shortly"] = "El reproductor está ocupado; inténtalo en un momento",
        ["Image dimensions are too large; choose a smaller image"] = "Las dimensiones de la imagen son demasiado grandes; elige una más pequeña",
        ["Choose an image no larger than 3 MB"] = "Elige una imagen de no más de 3 MB",
        ["Not enough memory to prepare that image"] = "No hay memoria suficiente para preparar esa imagen",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "No se pudo leer la imagen; elige un JPG, PNG o BMP válido",
        ["Could not prepare the startup image"] = "No se pudo preparar la imagen de inicio",
        ["Custom image set · applies on next boot"] = "Imagen personalizada definida · se aplica en el próximo inicio",
        ["Using the default splash"] = "Usando la pantalla de inicio predeterminada",
        ["Choose image"] = "Elegir imagen",
        ["Restore default splash"] = "Restaurar imagen predeterminada",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG, PNG o BMP · hasta 3 MB",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "Los cambios se aplican en el próximo inicio. Las imágenes personalizadas conservan sus colores originales.",
        ["Startup image preparation is already in progress"] = "La preparación de la imagen de inicio ya está en curso",
        ["Image selection needs a newer player build"] = "La selección de imagen requiere una versión más reciente del reproductor",
        ["Startup image support needs a newer player build"] = "El soporte de imagen de inicio requiere una versión más reciente del reproductor",
        ["Choose a JPG, PNG, or BMP image"] = "Elige una imagen JPG, PNG o BMP",
        ["Could not create the startup image folder on the SD card"] = "No se pudo crear la carpeta de imagen de inicio en la tarjeta SD",
        ["Preparing image…"] = "Preparando imagen…",
        ["Startup image saved · applies on next boot"] = "Imagen de inicio guardada · se aplica en el próximo inicio",
        ["Wait for image preparation to finish"] = "Espera a que termine la preparación de la imagen",
        ["Restoring default splash…"] = "Restaurando imagen predeterminada…",
        ["Default splash restored · applies on next boot"] = "Imagen predeterminada restaurada · se aplica en el próximo inicio",
    },
    fi = {
        ["Startup Image"] = "Käynnistyskuva",
        ["Player is busy; try again shortly"] = "Soitin on varattu; yritä pian uudelleen",
        ["Image dimensions are too large; choose a smaller image"] = "Kuvan mitat ovat liian suuret; valitse pienempi kuva",
        ["Choose an image no larger than 3 MB"] = "Valitse enintään 3 Mt:n kokoinen kuva",
        ["Not enough memory to prepare that image"] = "Muisti ei riitä kuvan valmisteluun",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Kuvaa ei voitu lukea; valitse kelvollinen JPG, PNG tai BMP",
        ["Could not prepare the startup image"] = "Käynnistyskuvan valmistelu epäonnistui",
        ["Custom image set · applies on next boot"] = "Mukautettu kuva asetettu · käytössä seuraavalla käynnistyksellä",
        ["Using the default splash"] = "Käytetään oletuskäynnistyskuvaa",
        ["Choose image"] = "Valitse kuva",
        ["Restore default splash"] = "Palauta oletuskuva",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG, PNG tai BMP · enintään 3 Mt",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "Muutokset tulevat voimaan seuraavalla käynnistyksellä. Mukautetut kuvat säilyttävät alkuperäiset värinsä.",
        ["Startup image preparation is already in progress"] = "Käynnistyskuvan valmistelu on jo käynnissä",
        ["Image selection needs a newer player build"] = "Kuvan valinta vaatii uudemman soitinversion",
        ["Startup image support needs a newer player build"] = "Käynnistyskuvan tuki vaatii uudemman soitinversion",
        ["Choose a JPG, PNG, or BMP image"] = "Valitse JPG-, PNG- tai BMP-kuva",
        ["Could not create the startup image folder on the SD card"] = "Käynnistyskuvakansiota ei voitu luoda SD-kortille",
        ["Preparing image…"] = "Valmistellaan kuvaa…",
        ["Startup image saved · applies on next boot"] = "Käynnistyskuva tallennettu · käytössä seuraavalla käynnistyksellä",
        ["Wait for image preparation to finish"] = "Odota kuvan valmistelun valmistumista",
        ["Restoring default splash…"] = "Palautetaan oletuskuvaa…",
        ["Default splash restored · applies on next boot"] = "Oletuskuva palautettu · käytössä seuraavalla käynnistyksellä",
    },
    fr = {
        ["Startup Image"] = "Image de démarrage",
        ["Player is busy; try again shortly"] = "Le lecteur est occupé ; réessayez dans un instant",
        ["Image dimensions are too large; choose a smaller image"] = "Dimensions de l'image trop grandes ; choisissez une image plus petite",
        ["Choose an image no larger than 3 MB"] = "Choisissez une image de 3 Mo maximum",
        ["Not enough memory to prepare that image"] = "Mémoire insuffisante pour préparer cette image",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Impossible de lire cette image ; choisissez un JPG, PNG ou BMP valide",
        ["Could not prepare the startup image"] = "Impossible de préparer l'image de démarrage",
        ["Custom image set · applies on next boot"] = "Image personnalisée définie · appliquée au prochain démarrage",
        ["Using the default splash"] = "Écran de démarrage par défaut utilisé",
        ["Choose image"] = "Choisir une image",
        ["Restore default splash"] = "Restaurer l'écran par défaut",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG, PNG ou BMP · jusqu'à 3 Mo",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "Les modifications s'appliquent au prochain démarrage. Les images personnalisées gardent leurs couleurs d'origine.",
        ["Startup image preparation is already in progress"] = "La préparation de l'image de démarrage est déjà en cours",
        ["Image selection needs a newer player build"] = "La sélection d'image nécessite une version plus récente du lecteur",
        ["Startup image support needs a newer player build"] = "L'image de démarrage nécessite une version plus récente du lecteur",
        ["Choose a JPG, PNG, or BMP image"] = "Choisissez une image JPG, PNG ou BMP",
        ["Could not create the startup image folder on the SD card"] = "Impossible de créer le dossier d'image de démarrage sur la carte SD",
        ["Preparing image…"] = "Préparation de l'image…",
        ["Startup image saved · applies on next boot"] = "Image de démarrage enregistrée · appliquée au prochain démarrage",
        ["Wait for image preparation to finish"] = "Attendez la fin de la préparation de l'image",
        ["Restoring default splash…"] = "Restauration de l'écran par défaut…",
        ["Default splash restored · applies on next boot"] = "Écran par défaut restauré · appliqué au prochain démarrage",
    },
    it = {
        ["Startup Image"] = "Immagine di avvio",
        ["Player is busy; try again shortly"] = "Il lettore è occupato; riprova tra poco",
        ["Image dimensions are too large; choose a smaller image"] = "Le dimensioni dell'immagine sono troppo grandi; scegli un'immagine più piccola",
        ["Choose an image no larger than 3 MB"] = "Scegli un'immagine non più grande di 3 MB",
        ["Not enough memory to prepare that image"] = "Memoria insufficiente per preparare l'immagine",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Impossibile leggere l'immagine; scegli un file JPG, PNG o BMP valido",
        ["Could not prepare the startup image"] = "Impossibile preparare l'immagine di avvio",
        ["Custom image set · applies on next boot"] = "Immagine personalizzata impostata · attiva al prossimo avvio",
        ["Using the default splash"] = "Schermata di avvio predefinita in uso",
        ["Choose image"] = "Scegli immagine",
        ["Restore default splash"] = "Ripristina schermata predefinita",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG, PNG o BMP · fino a 3 MB",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "Le modifiche si applicano al prossimo avvio. Le immagini personalizzate mantengono i colori originali.",
        ["Startup image preparation is already in progress"] = "Preparazione dell'immagine di avvio già in corso",
        ["Image selection needs a newer player build"] = "La selezione immagine richiede una versione più recente del lettore",
        ["Startup image support needs a newer player build"] = "L'immagine di avvio richiede una versione più recente del lettore",
        ["Choose a JPG, PNG, or BMP image"] = "Scegli un'immagine JPG, PNG o BMP",
        ["Could not create the startup image folder on the SD card"] = "Impossibile creare la cartella dell'immagine di avvio sulla scheda SD",
        ["Preparing image…"] = "Preparazione immagine…",
        ["Startup image saved · applies on next boot"] = "Immagine di avvio salvata · attiva al prossimo avvio",
        ["Wait for image preparation to finish"] = "Attendi il completamento della preparazione dell'immagine",
        ["Restoring default splash…"] = "Ripristino schermata predefinita…",
        ["Default splash restored · applies on next boot"] = "Schermata predefinita ripristinata · attiva al prossimo avvio",
    },
    ja = {
        ["Startup Image"] = "起動画面",
        ["Player is busy; try again shortly"] = "プレイヤーが処理中です。少し待ってから再試行してください",
        ["Image dimensions are too large; choose a smaller image"] = "画像の解像度が大きすぎます。より小さい画像を選択してください",
        ["Choose an image no larger than 3 MB"] = "3 MB 以下の画像を選択してください",
        ["Not enough memory to prepare that image"] = "その画像を準備するためのメモリが不足しています",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "画像を読み込めませんでした。有効な JPG、PNG、または BMP を選択してください",
        ["Could not prepare the startup image"] = "起動画面を準備できませんでした",
        ["Custom image set · applies on next boot"] = "カスタム画像を設定済み · 次回起動時に適用されます",
        ["Using the default splash"] = "標準の起動画面を使用中",
        ["Choose image"] = "画像を選択",
        ["Restore default splash"] = "標準の起動画面に戻す",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG、PNG、BMP · 最大 3 MB",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "変更は次回起動時に適用されます。カスタム画像は元の色を維持します。",
        ["Startup image preparation is already in progress"] = "起動画面の準備がすでに進行中です",
        ["Image selection needs a newer player build"] = "画像の選択には新しいプレイヤービルドが必要です",
        ["Startup image support needs a newer player build"] = "起動画面のサポートには新しいプレイヤービルドが必要です",
        ["Choose a JPG, PNG, or BMP image"] = "JPG、PNG、または BMP 画像を選択してください",
        ["Could not create the startup image folder on the SD card"] = "SD カードに起動画面フォルダを作成できませんでした",
        ["Preparing image…"] = "画像を準備中…",
        ["Startup image saved · applies on next boot"] = "起動画面を保存しました · 次回起動時に適用されます",
        ["Wait for image preparation to finish"] = "画像の準備が完了するまでお待ちください",
        ["Restoring default splash…"] = "標準の起動画面を復元中…",
        ["Default splash restored · applies on next boot"] = "標準の起動画面を復元しました · 次回起動時に適用されます",
    },
    nl = {
        ["Startup Image"] = "Opstartafbeelding",
        ["Player is busy; try again shortly"] = "Speler is bezig; probeer het zo opnieuw",
        ["Image dimensions are too large; choose a smaller image"] = "Afbeeldingsafmetingen zijn te groot; kies een kleinere afbeelding",
        ["Choose an image no larger than 3 MB"] = "Kies een afbeelding van maximaal 3 MB",
        ["Not enough memory to prepare that image"] = "Onvoldoende geheugen om die afbeelding voor te bereiden",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Die afbeelding kon niet worden gelezen; kies een geldige JPG, PNG of BMP",
        ["Could not prepare the startup image"] = "Kan de opstartafbeelding niet voorbereiden",
        ["Custom image set · applies on next boot"] = "Aangepaste afbeelding ingesteld · actief bij volgende start",
        ["Using the default splash"] = "Standaard opstartscherm in gebruik",
        ["Choose image"] = "Afbeelding kiezen",
        ["Restore default splash"] = "Standaard opstartscherm herstellen",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG, PNG of BMP · tot 3 MB",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "Wijzigingen gelden bij de volgende start. Aangepaste afbeeldingen behouden hun originele kleuren.",
        ["Startup image preparation is already in progress"] = "Voorbereiding van opstartafbeelding is al bezig",
        ["Image selection needs a newer player build"] = "Afbeeldingsselectie vereist een nieuwere spelerversie",
        ["Startup image support needs a newer player build"] = "Opstartafbeelding vereist een nieuwere spelerversie",
        ["Choose a JPG, PNG, or BMP image"] = "Kies een JPG-, PNG- of BMP-afbeelding",
        ["Could not create the startup image folder on the SD card"] = "Kan de map voor opstartafbeeldingen niet aanmaken op de SD-kaart",
        ["Preparing image…"] = "Afbeelding voorbereiden…",
        ["Startup image saved · applies on next boot"] = "Opstartafbeelding opgeslagen · actief bij volgende start",
        ["Wait for image preparation to finish"] = "Wacht tot het voorbereiden van de afbeelding klaar is",
        ["Restoring default splash…"] = "Standaard opstartscherm herstellen…",
        ["Default splash restored · applies on next boot"] = "Standaard opstartscherm hersteld · actief bij volgende start",
    },
    pt = {
        ["Startup Image"] = "Imagem de inicialização",
        ["Player is busy; try again shortly"] = "O reprodutor está ocupado; tente novamente em instantes",
        ["Image dimensions are too large; choose a smaller image"] = "As dimensões da imagem são muito grandes; escolha uma imagem menor",
        ["Choose an image no larger than 3 MB"] = "Escolha uma imagem de no máximo 3 MB",
        ["Not enough memory to prepare that image"] = "Memória insuficiente para preparar essa imagem",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Não foi possível ler a imagem; escolha um JPG, PNG ou BMP válido",
        ["Could not prepare the startup image"] = "Não foi possível preparar a imagem de inicialização",
        ["Custom image set · applies on next boot"] = "Imagem personalizada definida · aplica-se na próxima inicialização",
        ["Using the default splash"] = "Usando a tela de inicialização padrão",
        ["Choose image"] = "Escolher imagem",
        ["Restore default splash"] = "Restaurar tela padrão",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG, PNG ou BMP · até 3 MB",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "As alterações aplicam-se na próxima inicialização. Imagens personalizadas mantêm as cores originais.",
        ["Startup image preparation is already in progress"] = "A preparação da imagem de inicialização já está em andamento",
        ["Image selection needs a newer player build"] = "A seleção de imagem requer uma versão mais recente do reprodutor",
        ["Startup image support needs a newer player build"] = "O suporte a imagem de inicialização requer uma versão mais recente do reprodutor",
        ["Choose a JPG, PNG, or BMP image"] = "Escolha uma imagem JPG, PNG ou BMP",
        ["Could not create the startup image folder on the SD card"] = "Não foi possível criar a pasta de imagem de inicialização no cartão SD",
        ["Preparing image…"] = "Preparando imagem…",
        ["Startup image saved · applies on next boot"] = "Imagem de inicialização salva · aplica-se na próxima inicialização",
        ["Wait for image preparation to finish"] = "Aguarde o término da preparação da imagem",
        ["Restoring default splash…"] = "Restaurando tela padrão…",
        ["Default splash restored · applies on next boot"] = "Tela padrão restaurada · aplica-se na próxima inicialização",
    },
    ru = {
        ["Startup Image"] = "Заставка при включении",
        ["Player is busy; try again shortly"] = "Плеер занят; повторите попытку чуть позже",
        ["Image dimensions are too large; choose a smaller image"] = "Разрешение изображения слишком велико; выберите изображение поменьше",
        ["Choose an image no larger than 3 MB"] = "Выберите изображение размером не более 3 МБ",
        ["Not enough memory to prepare that image"] = "Недостаточно памяти для подготовки этого изображения",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Не удалось прочитать изображение; выберите корректный файл JPG, PNG или BMP",
        ["Could not prepare the startup image"] = "Не удалось подготовить заставку",
        ["Custom image set · applies on next boot"] = "Своя заставка установлена · применится при следующем включении",
        ["Using the default splash"] = "Используется стандартная заставка",
        ["Choose image"] = "Выбрать изображение",
        ["Restore default splash"] = "Восстановить стандартную заставку",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG, PNG или BMP · до 3 МБ",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "Изменения применятся при следующем включении. Пользовательские изображения сохраняют исходные цвета.",
        ["Startup image preparation is already in progress"] = "Подготовка заставки уже выполняется",
        ["Image selection needs a newer player build"] = "Для выбора изображения требуется более новая сборка плеера",
        ["Startup image support needs a newer player build"] = "Для поддержки заставки требуется более новая сборка плеера",
        ["Choose a JPG, PNG, or BMP image"] = "Выберите изображение JPG, PNG или BMP",
        ["Could not create the startup image folder on the SD card"] = "Не удалось создать папку заставки на SD-карте",
        ["Preparing image…"] = "Подготовка изображения…",
        ["Startup image saved · applies on next boot"] = "Заставка сохранена · применится при следующем включении",
        ["Wait for image preparation to finish"] = "Дождитесь завершения подготовки изображения",
        ["Restoring default splash…"] = "Восстановление стандартной заставки…",
        ["Default splash restored · applies on next boot"] = "Стандартная заставка восстановлена · применится при следующем включении",
    },
    uk = {
        ["Startup Image"] = "Заставка під час увімкнення",
        ["Player is busy; try again shortly"] = "Плеєр зайнятий; спробуйте ще раз трохи згодом",
        ["Image dimensions are too large; choose a smaller image"] = "Розміри зображення завеликі; виберіть менше зображення",
        ["Choose an image no larger than 3 MB"] = "Виберіть зображення розміром не більше 3 МБ",
        ["Not enough memory to prepare that image"] = "Недостатньо пам'яті для підготовки цього зображення",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Не вдалося прочитати зображення; виберіть коректний файл JPG, PNG або BMP",
        ["Could not prepare the startup image"] = "Не вдалося підготувати заставку",
        ["Custom image set · applies on next boot"] = "Власну заставку встановлено · застосується під час наступного запуску",
        ["Using the default splash"] = "Використовується стандартна заставка",
        ["Choose image"] = "Вибрати зображення",
        ["Restore default splash"] = "Відновити стандартну заставку",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG, PNG або BMP · до 3 МБ",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "Зміни застосуються під час наступного запуску. Власні зображення зберігають початкові кольори.",
        ["Startup image preparation is already in progress"] = "Підготовка заставки вже триває",
        ["Image selection needs a newer player build"] = "Для вибору зображення потрібна новіша збірка плеєра",
        ["Startup image support needs a newer player build"] = "Для підтримки заставки потрібна новіша збірка плеєра",
        ["Choose a JPG, PNG, or BMP image"] = "Виберіть зображення JPG, PNG або BMP",
        ["Could not create the startup image folder on the SD card"] = "Не вдалося створити теку заставки на SD-карті",
        ["Preparing image…"] = "Підготовка зображення…",
        ["Startup image saved · applies on next boot"] = "Заставку збережено · застосується під час наступного запуску",
        ["Wait for image preparation to finish"] = "Зачекайте завершення підготовки зображення",
        ["Restoring default splash…"] = "Відновлення стандартної заставки…",
        ["Default splash restored · applies on next boot"] = "Стандартну заставку відновлено · застосується під час наступного запуску",
    },
    vi = {
        ["Startup Image"] = "Ảnh khởi động",
        ["Player is busy; try again shortly"] = "Trình phát đang bận; hãy thử lại sau ít phút",
        ["Image dimensions are too large; choose a smaller image"] = "Kích thước ảnh quá lớn; hãy chọn ảnh nhỏ hơn",
        ["Choose an image no larger than 3 MB"] = "Hãy chọn ảnh không quá 3 MB",
        ["Not enough memory to prepare that image"] = "Không đủ bộ nhớ để chuẩn bị ảnh đó",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "Không đọc được ảnh; hãy chọn tệp JPG, PNG hoặc BMP hợp lệ",
        ["Could not prepare the startup image"] = "Không thể chuẩn bị ảnh khởi động",
        ["Custom image set · applies on next boot"] = "Đã đặt ảnh tùy chỉnh · áp dụng ở lần khởi động tiếp theo",
        ["Using the default splash"] = "Đang dùng màn hình khởi động mặc định",
        ["Choose image"] = "Chọn ảnh",
        ["Restore default splash"] = "Khôi phục màn hình mặc định",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG, PNG hoặc BMP · tối đa 3 MB",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "Thay đổi có hiệu lực ở lần khởi động tiếp theo. Ảnh tùy chỉnh giữ nguyên màu gốc.",
        ["Startup image preparation is already in progress"] = "Đang chuẩn bị ảnh khởi động",
        ["Image selection needs a newer player build"] = "Chọn ảnh cần bản dựng trình phát mới hơn",
        ["Startup image support needs a newer player build"] = "Ảnh khởi động cần bản dựng trình phát mới hơn",
        ["Choose a JPG, PNG, or BMP image"] = "Hãy chọn ảnh JPG, PNG hoặc BMP",
        ["Could not create the startup image folder on the SD card"] = "Không thể tạo thư mục ảnh khởi động trên thẻ SD",
        ["Preparing image…"] = "Đang chuẩn bị ảnh…",
        ["Startup image saved · applies on next boot"] = "Đã lưu ảnh khởi động · áp dụng ở lần khởi động tiếp theo",
        ["Wait for image preparation to finish"] = "Hãy đợi quá trình chuẩn bị ảnh hoàn tất",
        ["Restoring default splash…"] = "Đang khôi phục màn hình mặc định…",
        ["Default splash restored · applies on next boot"] = "Đã khôi phục màn hình mặc định · áp dụng ở lần khởi động tiếp theo",
    },
    zh_CN = {
        ["Startup Image"] = "开机画面",
        ["Player is busy; try again shortly"] = "播放器正忙，请稍后重试",
        ["Image dimensions are too large; choose a smaller image"] = "图片尺寸过大，请选择较小的图片",
        ["Choose an image no larger than 3 MB"] = "请选择不超过 3 MB 的图片",
        ["Not enough memory to prepare that image"] = "内存不足，无法准备该图片",
        ["That image could not be read; choose a valid JPG, PNG, or BMP"] = "无法读取该图片，请选择有效的 JPG、PNG 或 BMP",
        ["Could not prepare the startup image"] = "无法准备开机画面",
        ["Custom image set · applies on next boot"] = "已设置自定义图片 · 下次开机生效",
        ["Using the default splash"] = "正在使用默认开机画面",
        ["Choose image"] = "选择图片",
        ["Restore default splash"] = "恢复默认开机画面",
        ["JPG, PNG, or BMP · up to 3 MB"] = "JPG、PNG 或 BMP · 最大 3 MB",
        ["Changes apply on the next boot. Custom images keep their original colors."] = "更改将在下次开机时生效。自定义图片保留原始色彩。",
        ["Startup image preparation is already in progress"] = "开机画面准备已在运行中",
        ["Image selection needs a newer player build"] = "选择图片需要更新的播放器版本",
        ["Startup image support needs a newer player build"] = "开机画面支持需要更新的播放器版本",
        ["Choose a JPG, PNG, or BMP image"] = "请选择 JPG、PNG 或 BMP 图片",
        ["Could not create the startup image folder on the SD card"] = "无法在 SD 卡上创建开机画面文件夹",
        ["Preparing image…"] = "正在准备图片…",
        ["Startup image saved · applies on next boot"] = "开机画面已保存 · 下次开机生效",
        ["Wait for image preparation to finish"] = "请等待图片准备完成",
        ["Restoring default splash…"] = "正在恢复默认开机画面…",
        ["Default splash restored · applies on next boot"] = "已恢复默认开机画面 · 下次开机生效",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

local plugin_dir = plugin.sd_root() .. "/.plugins/StartupImage"
-- Write to a new candidate so a failed conversion never damages the image
-- currently selected for the next boot.
local prepared_path = plugin_dir .. "/startup-next.bin"
local picker_busy = false
local preparing = false

local function friendly_error(err)
    local message = string.lower(tostring(err or ""))
    if message:find("busy", 1, true) or message:find("already", 1, true) then
        return tr("Player is busy; try again shortly")
    elseif message:find("dimension", 1, true) or message:find("resolution", 1, true)
        or message:find("pixel", 1, true) then
        return tr("Image dimensions are too large; choose a smaller image")
    elseif message:find("3mb", 1, true) or message:find("size", 1, true)
        or message:find("large", 1, true) then
        return tr("Choose an image no larger than 3 MB")
    elseif message:find("memory", 1, true) or message:find("nomem", 1, true) then
        return tr("Not enough memory to prepare that image")
    elseif message:find("corrupt", 1, true) or message:find("invalid", 1, true)
        or message:find("decode", 1, true) or message:find("format", 1, true)
        or message:find("unsupported", 1, true) then
        return tr("That image could not be read; choose a valid JPG, PNG, or BMP")
    end
    return tr("Could not prepare the startup image")
end

local function current_status()
    local ok, has_image = pcall(plugin.has_startup_image)
    if ok and has_image then
        return tr("Custom image set · applies on next boot")
    end
    return tr("Using the default splash")
end

local menu_handle
local open_menu
local choose_image
local restore_default

local function menu_items()
    local function info_row(label)
        if plugin.has_capability("ui.list_wrap") then
            return { label = label, wrap = true }
        end
        return label
    end
    return {
        info_row(current_status()),
        tr("Choose image"),
        tr("Restore default splash"),
        info_row(tr("JPG, PNG, or BMP · up to 3 MB")),
        info_row(tr("Changes apply on the next boot. Custom images keep their original colors.")),
    }
end

local function on_menu_select(index)
    if index == 2 then
        choose_image()
    elseif index == 3 then
        restore_default()
    end
end

local function refresh_menu_status()
    if not menu_handle or not plugin.has_capability("ui.list_update")
        or not plugin.has_capability("ui.list_showing")
        or type(plugin.is_list_showing) ~= "function"
        or not plugin.is_list_showing(menu_handle) then
        return
    end
    local replacement = plugin.show_list(tr("Startup Image"), menu_items(), on_menu_select,
        { replace = menu_handle })
    if replacement then menu_handle = replacement end
end

local function supported_image(path)
    if type(path) ~= "string" then return false end
    local ext = string.lower(path:match("%.([^./]+)$") or "")
    return ext == "png" or ext == "jpg" or ext == "jpeg" or ext == "bmp"
end

choose_image = function()
    if picker_busy or preparing then
        plugin.show_toast(tr("Startup image preparation is already in progress"))
        return
    end
    if not plugin.has_capability("ui.file_picker") then
        plugin.show_toast(tr("Image selection needs a newer player build"))
        return
    end
    if not plugin.has_capability("ui.startup_image") then
        plugin.show_toast(tr("Startup image support needs a newer player build"))
        return
    end

    local function on_picked(source)
        picker_busy = false
        if not source then return end -- Cancellation leaves the current image unchanged.
        if not supported_image(source) then
            plugin.show_toast(tr("Choose a JPG, PNG, or BMP image"))
            return
        end
        if not plugin.mkdir(plugin_dir) then
            plugin.show_toast(tr("Could not create the startup image folder on the SD card"))
            return
        end

        preparing = true
        local progress
        if plugin.has_capability("ui.progress") then
            progress = plugin.show_progress(tr("Startup Image"), tr("Preparing image…"), nil)
        end
        local completed = false
        local function finish(ok, reason)
            if completed then return end
            completed = true
            preparing = false
            if progress then plugin.close_progress(progress); progress = nil end
            if not ok then
                plugin.show_toast(friendly_error(reason))
                return
            end
            plugin.show_toast(tr("Startup image saved · applies on next boot"))
            refresh_menu_status()
        end

        local started, start_err = plugin.image_startup_async(source, prepared_path,
            function(path, reason)
                if not path then
                    finish(false, reason)
                    return
                end

                local call_ok, install_started, install_err = pcall(
                    plugin.set_startup_image_async, path, function(ok, err)
                        finish(ok == true, err)
                    end)
                if not call_ok then
                    finish(false, install_started)
                elseif install_started ~= true then
                    finish(false, install_err or install_started)
                end
                if not call_ok or install_started ~= true then
                    return
                end
            end)

        if not started then
            finish(false, start_err)
        end
    end

    picker_busy = true
    local ok, result, open_err = pcall(plugin.pick_file, nil, on_picked)
    if not ok or result ~= true then
        picker_busy = false
        plugin.show_toast(friendly_error(open_err or (not ok and result) or result))
    end
end

restore_default = function()
    if preparing then
        plugin.show_toast(tr("Wait for image preparation to finish"))
        return
    end
    preparing = true
    local progress
    if plugin.has_capability("ui.progress") then
        progress = plugin.show_progress(tr("Startup Image"), tr("Restoring default splash…"), nil)
    end
    local completed = false
    local function finish(ok, err)
        if completed then return end
        completed = true
        preparing = false
        if progress then plugin.close_progress(progress); progress = nil end
        if not ok then
            plugin.show_toast(friendly_error(err))
            return
        end
        plugin.show_toast(tr("Default splash restored · applies on next boot"))
        refresh_menu_status()
    end
    local call_ok, started, err = pcall(plugin.set_startup_image_async, nil, finish)
    if not call_ok then
        finish(false, started)
    elseif started ~= true then
        finish(false, err or started)
    end
    if not call_ok or started ~= true then
        return
    end
end

open_menu = function()
    if not plugin.has_capability("ui.startup_image") then
        plugin.show_toast(tr("Startup image support needs a newer player build"))
        return
    end
    menu_handle = plugin.show_list(tr("Startup Image"), menu_items(), on_menu_select)
end

plugin.register_list_item("display", tr("Startup Image"), open_menu, {
    group = "appearance",
})
