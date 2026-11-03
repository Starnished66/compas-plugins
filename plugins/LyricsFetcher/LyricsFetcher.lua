plugin.define({
    id = "example.lyrics_fetcher",
    name = "Lyrics Fetcher",
    version = "1.5.0",
    api_min = 19,
})

local T = {
    de = {
        ["Lyrics Fetcher"] = "Liedtext-Abruf",
        ["Fetching lyrics"] = "Liedtext wird abgerufen",
        ["Looking up lyrics…"] = "Suche Liedtext…",
        ["Track path is not supported"] = "Titelpfad wird nicht unterstützt",
        ["Pending lyrics queue could not be read"] = "Warteschlange für Liedtexte konnte nicht gelesen werden",
        ["Lyrics already present"] = "Liedtext bereits vorhanden",
        ["Could not read existing lyrics"] = "Vorhandener Liedtext konnte nicht gelesen werden",
        ["Could not update pending lyrics request"] = "Ausstehende Liedtextanfrage konnte nicht aktualisiert werden",
        ["Pending lyrics queue is full"] = "Warteschlange für Liedtexte ist voll",
        ["Track tags or path are not supported"] = "Tags oder Pfad des Titels werden nicht unterstützt",
        ["Could not save pending lyrics request"] = "Ausstehende Liedtextanfrage konnte nicht gespeichert werden",
        ["Lyrics request queued for retry"] = "Liedtextanfrage für erneuten Versuch eingereiht",
        ["Lyrics response was too large"] = "Liedtext-Antwort war zu groß",
        ["No synced lyrics found"] = "Kein synchronisierter Liedtext gefunden",
        ["Lyrics fetch failed (HTTP %s)"] = "Liedtext-Abruf fehlgeschlagen (HTTP %s)",
        ["Lyrics response was not JSON"] = "Liedtext-Antwort war kein JSON",
        ["Track is instrumental"] = "Titel ist instrumental",
        ["No synced lyrics in result"] = "Kein synchronisierter Liedtext im Ergebnis",
        ["Saved lyrics"] = "Liedtext gespeichert",
        ["This player cannot fetch lyrics"] = "Dieser Player kann keine Liedtexte abrufen",
        ["Play a local track with title and artist tags"] = "Spiele einen lokalen Titel mit Titel- und Künstler-Tags ab",
        ["Lyrics request added to pending queue"] = "Liedtextanfrage zur Warteschlange hinzugefügt",
        ["Could not update pending queue"] = "Warteschlange konnte nicht aktualisiert werden",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "Liedtext-Warteschlange nicht lesbar; prüfe die Einstellungen",
        ["About Lyrics Fetcher"] = "Über Liedtext-Abruf",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "Sucht auf LRCLIB anhand von Titel, Künstler, Album und Dauer nach synchronisierten Liedtexten. Kein API-Schlüssel nötig.",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "Schreibt eine .lrc-Begleitdatei im selben Ordner (Audio-Endung durch .lrc ersetzt), passend zum Player.",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "Überspringt Dateien mit Zeitstempeln. Eine unsynchronisierte .lrc wird zuvor in .compas-backup umbenannt, damit der Player die neue Datei liest. Synchronisierte Texte werden nie ersetzt.",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "Eingebettete Liedtexte sind aus Lua nicht sichtbar; solche Titel erhalten ggf. trotzdem eine .lrc-Datei.",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "Anfragen werden vor dem Download gespeichert und bei WLAN-Verbindung fortgesetzt, auch nach einem Neustart. Unter Ausstehende Anfragen kannst du sie wiederholen oder leeren.",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "Der Automatikmodus ist standardmäßig aus. Nur lokale Dateien werden genutzt; Streams und remote://-Titel werden übersprungen.",
        ["Fetch lyrics for current track"] = "Liedtext für aktuellen Titel abrufen",
        ["Pending lyrics requests: %s"] = "Ausstehende Liedtextanfragen: %s",
        ["unavailable"] = "nicht verfügbar",
        ["Pending lyrics"] = "Ausstehende Liedtexte",
        ["Retry pending downloads"] = "Ausstehende Downloads wiederholen",
        ["Clear pending queue"] = "Warteschlange leeren",
        ["Clear pending queue?"] = "Warteschlange leeren?",
        ["Keep queue"] = "Warteschlange behalten",
        ["Clear queue"] = "Warteschlange leeren",
        ["Could not clear pending queue"] = "Warteschlange konnte nicht geleert werden",
        ["Automatic fetch"] = "Automatischer Abruf",
        ["How it works"] = "Funktionsweise",
    },
    es = {
        ["Lyrics Fetcher"] = "Buscador de letras",
        ["Fetching lyrics"] = "Buscando letra",
        ["Looking up lyrics…"] = "Buscando letra…",
        ["Track path is not supported"] = "La ruta de la pista no es compatible",
        ["Pending lyrics queue could not be read"] = "No se pudo leer la cola de letras pendientes",
        ["Lyrics already present"] = "La letra ya existe",
        ["Could not read existing lyrics"] = "No se pudo leer la letra existente",
        ["Could not update pending lyrics request"] = "No se pudo actualizar la solicitud de letra pendiente",
        ["Pending lyrics queue is full"] = "La cola de letras pendientes está llena",
        ["Track tags or path are not supported"] = "Las etiquetas o la ruta de la pista no son compatibles",
        ["Could not save pending lyrics request"] = "No se pudo guardar la solicitud de letra pendiente",
        ["Lyrics request queued for retry"] = "Solicitud de letra en cola para reintentar",
        ["Lyrics response was too large"] = "La respuesta de la letra fue demasiado grande",
        ["No synced lyrics found"] = "No se encontró letra sincronizada",
        ["Lyrics fetch failed (HTTP %s)"] = "Error al obtener la letra (HTTP %s)",
        ["Lyrics response was not JSON"] = "La respuesta de la letra no era JSON",
        ["Track is instrumental"] = "La pista es instrumental",
        ["No synced lyrics in result"] = "El resultado no incluye letra sincronizada",
        ["Saved lyrics"] = "Letra guardada",
        ["This player cannot fetch lyrics"] = "Este reproductor no puede descargar letras",
        ["Play a local track with title and artist tags"] = "Reproduce una pista local con etiquetas de título y artista",
        ["Lyrics request added to pending queue"] = "Solicitud de letra añadida a la cola pendiente",
        ["Could not update pending queue"] = "No se pudo actualizar la cola pendiente",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "No se pudo leer la cola de letras pendientes; revisa los Ajustes",
        ["About Lyrics Fetcher"] = "Acerca de Buscador de letras",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "Busca letras sincronizadas en LRCLIB usando título, artista, álbum y duración. Sin clave API.",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "Guarda un archivo .lrc en la misma carpeta (cambiando la extensión de audio por .lrc), igual que el reproductor.",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "Omite archivos .lrc que ya tienen marcas de tiempo. Un .lrc sin sincronizar se renombra antes a .compas-backup para que el reproductor lea el nuevo archivo. Las letras sincronizadas nunca se reemplazan.",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "Las letras incrustadas en etiquetas no son visibles desde Lua, por lo que esas pistas aún pueden recibir un archivo .lrc.",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "Las solicitudes pendientes se guardan antes de descargar y continúan cuando vuelve el Wi-Fi, incluso tras reiniciar. Puedes reintentarlas o vaciarlas en Solicitudes de letras pendientes.",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "El modo automático está desactivado hasta que lo actives. Solo se usan archivos locales; las transmisiones y pistas remote:// se omiten.",
        ["Fetch lyrics for current track"] = "Buscar letra de la pista actual",
        ["Pending lyrics requests: %s"] = "Solicitudes de letras pendientes: %s",
        ["unavailable"] = "no disponible",
        ["Pending lyrics"] = "Letras pendientes",
        ["Retry pending downloads"] = "Reintentar descargas pendientes",
        ["Clear pending queue"] = "Vaciar cola pendiente",
        ["Clear pending queue?"] = "¿Vaciar cola pendiente?",
        ["Keep queue"] = "Conservar cola",
        ["Clear queue"] = "Vaciar cola",
        ["Could not clear pending queue"] = "No se pudo vaciar la cola pendiente",
        ["Automatic fetch"] = "Búsqueda automática",
        ["How it works"] = "Cómo funciona",
    },
    fi = {
        ["Lyrics Fetcher"] = "Sanoitushaku",
        ["Fetching lyrics"] = "Haetaan sanoituksia",
        ["Looking up lyrics…"] = "Etsitään sanoituksia…",
        ["Track path is not supported"] = "Kappaleen polkua ei tueta",
        ["Pending lyrics queue could not be read"] = "Odottavien sanoitusten jonoa ei voitu lukea",
        ["Lyrics already present"] = "Sanoitukset ovat jo olemassa",
        ["Could not read existing lyrics"] = "Olemassa olevia sanoituksia ei voitu lukea",
        ["Could not update pending lyrics request"] = "Odottavaa sanoituspyyntöä ei voitu päivittää",
        ["Pending lyrics queue is full"] = "Odottavien sanoitusten jono on täynnä",
        ["Track tags or path are not supported"] = "Kappaleen tunnisteita tai polkua ei tueta",
        ["Could not save pending lyrics request"] = "Odottavaa sanoituspyyntöä ei voitu tallentaa",
        ["Lyrics request queued for retry"] = "Sanoituspyyntö lisättiin jonoon uudelleenyritystä varten",
        ["Lyrics response was too large"] = "Sanoitusvastaus oli liian suuri",
        ["No synced lyrics found"] = "Synkronoituja sanoituksia ei löytynyt",
        ["Lyrics fetch failed (HTTP %s)"] = "Sanoitusten haku epäonnistui (HTTP %s)",
        ["Lyrics response was not JSON"] = "Sanoitusvastaus ei ollut JSON-muodossa",
        ["Track is instrumental"] = "Kappale on instrumentaali",
        ["No synced lyrics in result"] = "Tuloksessa ei ole synkronoituja sanoituksia",
        ["Saved lyrics"] = "Sanoitukset tallennettu",
        ["This player cannot fetch lyrics"] = "Tämä soitin ei voi hakea sanoituksia",
        ["Play a local track with title and artist tags"] = "Toista paikallinen kappale, jossa on nimi- ja esittäjätunnisteet",
        ["Lyrics request added to pending queue"] = "Sanoituspyyntö lisättiin odottavaan jonoon",
        ["Could not update pending queue"] = "Odottavaa jonoa ei voitu päivittää",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "Odottavien sanoitusten jonoa ei voitu lukea; tarkista asetukset",
        ["About Lyrics Fetcher"] = "Tietoja Sanoitushausta",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "Etsii ajastettuja sanoituksia LRCLIB-palvelusta kappaleen nimen, esittäjän, albumin ja keston perusteella. Ei vaadi API-avainta.",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "Kirjoittaa samaan kansioon .lrc-tiedoston (äänitiedoston pääte korvataan .lrc-päätteellä) soittimen tapaan.",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "Ohittaa .lrc-tiedoston, jossa on jo aikaleimat. Synkronoimaton .lrc nimetään ensin .compas-backup-tiedostoksi. Synkronoituja sanoituksia ei koskaan korvata.",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "Tunnisteisiin upotettuja sanoituksia ei näy Luasta, joten ne kappaleet voivat silti saada .lrc-tiedoston.",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "Puuttuvien sanoitusten pyynnöt tallennetaan ennen latausta ja jatkuvat Wi-Fi-yhteyden palatessa, myös uudelleenkäynnistyksen jälkeen. Voit yrittää niitä uudelleen tai tyhjentää jonon.",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "Automaattinen tila on pois päältä, kunnes otat sen käyttöön. Vain paikallisia tiedostoja käytetään; suoratoistot ja remote://-kappaleet ohitetaan.",
        ["Fetch lyrics for current track"] = "Hae nykyisen kappaleen sanoitukset",
        ["Pending lyrics requests: %s"] = "Odottavat sanoituspyynnöt: %s",
        ["unavailable"] = "ei saatavilla",
        ["Pending lyrics"] = "Odottavat sanoitukset",
        ["Retry pending downloads"] = "Yritä odottavia latauksia uudelleen",
        ["Clear pending queue"] = "Tyhjennä odottava jono",
        ["Clear pending queue?"] = "Tyhjennetäänkö odottava jono?",
        ["Keep queue"] = "Säilytä jono",
        ["Clear queue"] = "Tyhjennä jono",
        ["Could not clear pending queue"] = "Odottavaa jonoa ei voitu tyhjentää",
        ["Automatic fetch"] = "Automaattinen haku",
        ["How it works"] = "Näin se toimii",
    },
    fr = {
        ["Lyrics Fetcher"] = "Chercheur de paroles",
        ["Fetching lyrics"] = "Récupération des paroles",
        ["Looking up lyrics…"] = "Recherche des paroles…",
        ["Track path is not supported"] = "Chemin de piste non pris en charge",
        ["Pending lyrics queue could not be read"] = "Impossible de lire la file d'attente des paroles",
        ["Lyrics already present"] = "Paroles déjà présentes",
        ["Could not read existing lyrics"] = "Impossible de lire les paroles existantes",
        ["Could not update pending lyrics request"] = "Impossible de mettre à jour la demande en attente",
        ["Pending lyrics queue is full"] = "La file d'attente des paroles est pleine",
        ["Track tags or path are not supported"] = "Tags ou chemin de piste non pris en charge",
        ["Could not save pending lyrics request"] = "Impossible d'enregistrer la demande de paroles",
        ["Lyrics request queued for retry"] = "Demande de paroles mise en file d'attente",
        ["Lyrics response was too large"] = "La réponse des paroles était trop volumineuse",
        ["No synced lyrics found"] = "Aucune parole synchronisée trouvée",
        ["Lyrics fetch failed (HTTP %s)"] = "Échec de récupération des paroles (HTTP %s)",
        ["Lyrics response was not JSON"] = "La réponse des paroles n'était pas en JSON",
        ["Track is instrumental"] = "La piste est instrumentale",
        ["No synced lyrics in result"] = "Aucune parole synchronisée dans le résultat",
        ["Saved lyrics"] = "Paroles enregistrées",
        ["This player cannot fetch lyrics"] = "Ce lecteur ne peut pas récupérer de paroles",
        ["Play a local track with title and artist tags"] = "Lisez une piste locale avec des tags de titre et d'artiste",
        ["Lyrics request added to pending queue"] = "Demande ajoutée à la file d'attente",
        ["Could not update pending queue"] = "Impossible de mettre à jour la file d'attente",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "Impossible de lire la file d'attente ; vérifiez les paramètres",
        ["About Lyrics Fetcher"] = "À propos du Chercheur de paroles",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "Recherche des paroles synchronisées sur LRCLIB avec le titre, l'artiste, l'album et la durée. Sans clé API.",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "Écrit un fichier .lrc dans le même dossier (extension audio remplacée par .lrc), comme le lecteur.",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "Ignore un fichier .lrc déjà horodaté. Un .lrc non synchronisé est d'abord renommé en .compas-backup. Les paroles synchronisées ne sont jamais remplacées.",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "Les paroles intégrées aux tags ne sont pas visibles depuis Lua ; ces pistes peuvent donc recevoir un fichier .lrc.",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "Les demandes sont enregistrées avant téléchargement et reprennent au retour du Wi-Fi, même après redémarrage. Vous pouvez les relancer ou les vider.",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "Le mode automatique est désactivé par défaut. Seuls les fichiers locaux sont utilisés ; les flux et pistes remote:// sont ignorés.",
        ["Fetch lyrics for current track"] = "Chercher les paroles du titre actuel",
        ["Pending lyrics requests: %s"] = "Demandes de paroles en attente : %s",
        ["unavailable"] = "indisponible",
        ["Pending lyrics"] = "Paroles en attente",
        ["Retry pending downloads"] = "Relancer les téléchargements en attente",
        ["Clear pending queue"] = "Vider la file d'attente",
        ["Clear pending queue?"] = "Vider la file d'attente ?",
        ["Keep queue"] = "Garder la file",
        ["Clear queue"] = "Vider la file",
        ["Could not clear pending queue"] = "Impossible de vider la file d'attente",
        ["Automatic fetch"] = "Recherche automatique",
        ["How it works"] = "Fonctionnement",
    },
    it = {
        ["Lyrics Fetcher"] = "Ricerca testi",
        ["Fetching lyrics"] = "Recupero testo",
        ["Looking up lyrics…"] = "Ricerca testo…",
        ["Track path is not supported"] = "Percorso del brano non supportato",
        ["Pending lyrics queue could not be read"] = "Impossibile leggere la coda dei testi in sospeso",
        ["Lyrics already present"] = "Testo già presente",
        ["Could not read existing lyrics"] = "Impossibile leggere il testo esistente",
        ["Could not update pending lyrics request"] = "Impossibile aggiornare la richiesta di testo in sospeso",
        ["Pending lyrics queue is full"] = "La coda dei testi in sospeso è piena",
        ["Track tags or path are not supported"] = "Tag o percorso del brano non supportati",
        ["Could not save pending lyrics request"] = "Impossibile salvare la richiesta di testo in sospeso",
        ["Lyrics request queued for retry"] = "Richiesta di testo in coda per nuovo tentativo",
        ["Lyrics response was too large"] = "La risposta del testo era troppo grande",
        ["No synced lyrics found"] = "Nessun testo sincronizzato trovato",
        ["Lyrics fetch failed (HTTP %s)"] = "Recupero testo non riuscito (HTTP %s)",
        ["Lyrics response was not JSON"] = "La risposta del testo non era in formato JSON",
        ["Track is instrumental"] = "Il brano è strumentale",
        ["No synced lyrics in result"] = "Nessun testo sincronizzato nel risultato",
        ["Saved lyrics"] = "Testo salvato",
        ["This player cannot fetch lyrics"] = "Questo lettore non può scaricare i testi",
        ["Play a local track with title and artist tags"] = "Riproduci un brano locale con tag titolo e artista",
        ["Lyrics request added to pending queue"] = "Richiesta di testo aggiunta alla coda",
        ["Could not update pending queue"] = "Impossibile aggiornare la coda in sospeso",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "Impossibile leggere la coda dei testi; controlla le impostazioni",
        ["About Lyrics Fetcher"] = "Informazioni su Ricerca testi",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "Cerca testi sincronizzati su LRCLIB usando titolo, artista, album e durata. Nessuna chiave API richiesta.",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "Scrive un file .lrc nella stessa cartella (sostituendo l'estensione audio con .lrc), come fa il lettore.",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "Salta i file .lrc già sincronizzati. Un .lrc non sincronizzato viene prima rinominato in .compas-backup. I testi sincronizzati non vengono mai sostituiti.",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "I testi incorporati nei tag non sono visibili da Lua, quindi quei brani potrebbero comunque ricevere un file .lrc.",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "Le richieste vengono salvate prima del download e riprendono quando torna il Wi-Fi, anche dopo il riavvio. Puoi riprovarle o svuotarle.",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "La modalità automatica è disattivata finché non la attivi. Vengono usati solo file locali; flussi e brani remote:// vengono saltati.",
        ["Fetch lyrics for current track"] = "Cerca testo per il brano attuale",
        ["Pending lyrics requests: %s"] = "Richieste di testi in sospeso: %s",
        ["unavailable"] = "non disponibile",
        ["Pending lyrics"] = "Testi in sospeso",
        ["Retry pending downloads"] = "Riprova download in sospeso",
        ["Clear pending queue"] = "Svuota coda in sospeso",
        ["Clear pending queue?"] = "Svuotare la coda in sospeso?",
        ["Keep queue"] = "Mantieni coda",
        ["Clear queue"] = "Svuota coda",
        ["Could not clear pending queue"] = "Impossibile svuotare la coda in sospeso",
        ["Automatic fetch"] = "Ricerca automatica",
        ["How it works"] = "Come funziona",
    },
    ja = {
        ["Lyrics Fetcher"] = "歌詞取得",
        ["Fetching lyrics"] = "歌詞を取得中",
        ["Looking up lyrics…"] = "歌詞を検索中…",
        ["Track path is not supported"] = "トラックのパスがサポートされていません",
        ["Pending lyrics queue could not be read"] = "保留中の歌詞キューを読み込めませんでした",
        ["Lyrics already present"] = "歌詞は既に存在します",
        ["Could not read existing lyrics"] = "既存の歌詞を読み込めませんでした",
        ["Could not update pending lyrics request"] = "保留中の歌詞リクエストを更新できませんでした",
        ["Pending lyrics queue is full"] = "保留中の歌詞キューがいっぱいです",
        ["Track tags or path are not supported"] = "トラックのタグまたはパスがサポートされていません",
        ["Could not save pending lyrics request"] = "保留中の歌詞リクエストを保存できませんでした",
        ["Lyrics request queued for retry"] = "歌詞リクエストを再試行キューに入れました",
        ["Lyrics response was too large"] = "歌詞の応答が大きすぎます",
        ["No synced lyrics found"] = "同期歌詞が見つかりませんでした",
        ["Lyrics fetch failed (HTTP %s)"] = "歌詞の取得に失敗しました (HTTP %s)",
        ["Lyrics response was not JSON"] = "歌詞の応答が JSON ではありませんでした",
        ["Track is instrumental"] = "インストゥルメンタル曲です",
        ["No synced lyrics in result"] = "結果に同期歌詞がありません",
        ["Saved lyrics"] = "歌詞を保存しました",
        ["This player cannot fetch lyrics"] = "このプレーヤーでは歌詞を取得できません",
        ["Play a local track with title and artist tags"] = "タイトルとアーティストタグのあるローカル曲を再生してください",
        ["Lyrics request added to pending queue"] = "歌詞リクエストを保留キューに追加しました",
        ["Could not update pending queue"] = "保留キューを更新できませんでした",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "保留中の歌詞キューを読み込めません。設定を確認してください",
        ["About Lyrics Fetcher"] = "歌詞取得について",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "タイトル・アーティスト・アルバム・再生時間を使って LRCLIB から同期歌詞を検索します。API キーは不要です。",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "同じフォルダに .lrc ファイル（音声ファイルの拡張子を .lrc に置き換えたもの）を保存します。",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "タイムスタンプ付きの .lrc はスキップします。非同期の .lrc は先に .compas-backup に名前変更されます。同期歌詞は上書きされません。",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "タグに埋め込まれた歌詞は Lua から見えないため、その場合も .lrc が作成されることがあります。",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "リクエストはダウンロード前に保存され、再起動後でも Wi-Fi 接続時に再開されます。保留リストから再試行や消去が可能です。",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "自動モードは有効にするまでオフです。ローカルファイルのみが対象で、ストリームや remote:// の曲はスキップされます。",
        ["Fetch lyrics for current track"] = "現在の曲の歌詞を取得",
        ["Pending lyrics requests: %s"] = "保留中の歌詞リクエスト: %s",
        ["unavailable"] = "利用できません",
        ["Pending lyrics"] = "保留中の歌詞",
        ["Retry pending downloads"] = "保留中のダウンロードを再試行",
        ["Clear pending queue"] = "保留キューを消去",
        ["Clear pending queue?"] = "保留キューを消去しますか？",
        ["Keep queue"] = "キューを保持",
        ["Clear queue"] = "キューを消去",
        ["Could not clear pending queue"] = "保留キューを消去できませんでした",
        ["Automatic fetch"] = "自動取得",
        ["How it works"] = "仕組み",
    },
    nl = {
        ["Lyrics Fetcher"] = "Songtekstzoeker",
        ["Fetching lyrics"] = "Songtekst ophalen",
        ["Looking up lyrics…"] = "Songtekst zoeken…",
        ["Track path is not supported"] = "Trackpad wordt niet ondersteund",
        ["Pending lyrics queue could not be read"] = "Wachtrij voor songteksten kon niet worden gelezen",
        ["Lyrics already present"] = "Songtekst al aanwezig",
        ["Could not read existing lyrics"] = "Bestaande songtekst kon niet worden gelezen",
        ["Could not update pending lyrics request"] = "Openstaand songtekstvenzoek kon niet worden bijgewerkt",
        ["Pending lyrics queue is full"] = "Wachtrij voor songteksten is vol",
        ["Track tags or path are not supported"] = "Tracktags of pad worden niet ondersteund",
        ["Could not save pending lyrics request"] = "Openstaand songtekstverzoek kon niet worden opgeslagen",
        ["Lyrics request queued for retry"] = "Songtekstverzoek in wachtrij voor nieuwe poging",
        ["Lyrics response was too large"] = "Songtekstantwoord was te groot",
        ["No synced lyrics found"] = "Geen gesynchroniseerde songtekst gevonden",
        ["Lyrics fetch failed (HTTP %s)"] = "Songtekst ophalen mislukt (HTTP %s)",
        ["Lyrics response was not JSON"] = "Songtekstantwoord was geen JSON",
        ["Track is instrumental"] = "Nummer is instrumentaal",
        ["No synced lyrics in result"] = "Geen gesynchroniseerde songtekst in resultaat",
        ["Saved lyrics"] = "Songtekst opgeslagen",
        ["This player cannot fetch lyrics"] = "Deze speler kan geen songteksten ophalen",
        ["Play a local track with title and artist tags"] = "Speel een lokaal nummer met titel- en artiesttags af",
        ["Lyrics request added to pending queue"] = "Songtekstverzoek toegevoegd aan wachtrij",
        ["Could not update pending queue"] = "Wachtrij kon niet worden bijgewerkt",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "Wachtrij niet leesbaar; controleer de instellingen van Songtekstzoeker",
        ["About Lyrics Fetcher"] = "Over Songtekstzoeker",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "Zoekt gesynchroniseerde songteksten op LRCLIB met titel, artiest, album en duur. Geen API-sleutel nodig.",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "Schrijft een .lrc-bestand in dezelfde map (audio-extensie vervangen door .lrc), net als de speler.",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "Slaat een .lrc met tijdstempels over. Een ongesynchroniseerde .lrc wordt eerst hernoemd naar .compas-backup. Gesynchroniseerde songteksten worden nooit vervangen.",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "Ingesloten songteksten zijn niet zichtbaar vanuit Lua, dus die nummers kunnen alsnog een .lrc-bestand krijgen.",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "Verzoeken worden vóór het downloaden opgeslagen en hervat zodra Wi-Fi terugkeert, zelfs na herstarten. Je kunt ze opnieuw proberen of wissen.",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "De automatische modus staat uit tot je deze inschakelt. Alleen lokale bestanden worden gebruikt; streams en remote://-nummers worden overgeslagen.",
        ["Fetch lyrics for current track"] = "Songtekst voor huidig nummer ophalen",
        ["Pending lyrics requests: %s"] = "Openstaande songtekstverzoeken: %s",
        ["unavailable"] = "niet beschikbaar",
        ["Pending lyrics"] = "Openstaande songteksten",
        ["Retry pending downloads"] = "Openstaande downloads opnieuw proberen",
        ["Clear pending queue"] = "Wachtrij wissen",
        ["Clear pending queue?"] = "Wachtrij wissen?",
        ["Keep queue"] = "Wachtrij behouden",
        ["Clear queue"] = "Wachtrij wissen",
        ["Could not clear pending queue"] = "Wachtrij kon niet worden gewist",
        ["Automatic fetch"] = "Automatisch ophalen",
        ["How it works"] = "Hoe het werkt",
    },
    pt = {
        ["Lyrics Fetcher"] = "Buscador de letras",
        ["Fetching lyrics"] = "Buscando letra",
        ["Looking up lyrics…"] = "Procurando letra…",
        ["Track path is not supported"] = "Caminho da faixa não suportado",
        ["Pending lyrics queue could not be read"] = "Não foi possível ler a fila de letras pendentes",
        ["Lyrics already present"] = "A letra já existe",
        ["Could not read existing lyrics"] = "Não foi possível ler a letra existente",
        ["Could not update pending lyrics request"] = "Não foi possível atualizar o pedido de letra pendente",
        ["Pending lyrics queue is full"] = "A fila de letras pendentes está cheia",
        ["Track tags or path are not supported"] = "Tags ou caminho da faixa não suportados",
        ["Could not save pending lyrics request"] = "Não foi possível salvar o pedido de letra pendente",
        ["Lyrics request queued for retry"] = "Pedido de letra colocado na fila para nova tentativa",
        ["Lyrics response was too large"] = "A resposta da letra era muito grande",
        ["No synced lyrics found"] = "Nenhuma letra sincronizada encontrada",
        ["Lyrics fetch failed (HTTP %s)"] = "Falha ao buscar letra (HTTP %s)",
        ["Lyrics response was not JSON"] = "A resposta da letra não era JSON",
        ["Track is instrumental"] = "A faixa é instrumental",
        ["No synced lyrics in result"] = "Nenhuma letra sincronizada no resultado",
        ["Saved lyrics"] = "Letra salva",
        ["This player cannot fetch lyrics"] = "Este reprodutor não pode buscar letras",
        ["Play a local track with title and artist tags"] = "Reproduza uma faixa local com tags de título e artista",
        ["Lyrics request added to pending queue"] = "Pedido de letra adicionado à fila pendente",
        ["Could not update pending queue"] = "Não foi possível atualizar a fila pendente",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "Não foi possível ler a fila de letras; verifique as configurações",
        ["About Lyrics Fetcher"] = "Sobre o Buscador de letras",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "Busca letras sincronizadas no LRCLIB usando título, artista, álbum e duração. Sem chave de API.",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "Grava um arquivo .lrc na mesma pasta (trocando a extensão de áudio por .lrc), igual ao reprodutor.",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "Ignora arquivos .lrc que já têm marcações de tempo. Um .lrc não sincronizado é renomeado antes para .compas-backup. Letras sincronizadas nunca são substituídas.",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "Letras embutidas nas tags não são visíveis pelo Lua, então essas faixas ainda podem receber um arquivo .lrc.",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "Os pedidos são salvos antes de baixar e retomam quando o Wi-Fi volta, mesmo após reiniciar. Você pode tentar novamente ou limpar a fila.",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "O modo automático fica desativado até você ativá-lo. Apenas arquivos locais são usados; streams e faixas remote:// são ignorados.",
        ["Fetch lyrics for current track"] = "Buscar letra da faixa atual",
        ["Pending lyrics requests: %s"] = "Pedidos de letras pendentes: %s",
        ["unavailable"] = "indisponível",
        ["Pending lyrics"] = "Letras pendentes",
        ["Retry pending downloads"] = "Tentar novamente downloads pendentes",
        ["Clear pending queue"] = "Limpar fila pendente",
        ["Clear pending queue?"] = "Limpar fila pendente?",
        ["Keep queue"] = "Manter fila",
        ["Clear queue"] = "Limpar fila",
        ["Could not clear pending queue"] = "Não foi possível limpar a fila pendente",
        ["Automatic fetch"] = "Busca automática",
        ["How it works"] = "Como funciona",
    },
    ru = {
        ["Lyrics Fetcher"] = "Поиск текстов песен",
        ["Fetching lyrics"] = "Загрузка текста",
        ["Looking up lyrics…"] = "Поиск текста…",
        ["Track path is not supported"] = "Путь к треку не поддерживается",
        ["Pending lyrics queue could not be read"] = "Не удалось прочитать очередь ожидающих текстов",
        ["Lyrics already present"] = "Текст уже есть",
        ["Could not read existing lyrics"] = "Не удалось прочитать существующий текст",
        ["Could not update pending lyrics request"] = "Не удалось обновить ожидающий запрос текста",
        ["Pending lyrics queue is full"] = "Очередь ожидающих текстов полна",
        ["Track tags or path are not supported"] = "Теги или путь к треку не поддерживаются",
        ["Could not save pending lyrics request"] = "Не удалось сохранить ожидающий запрос текста",
        ["Lyrics request queued for retry"] = "Запрос текста поставлен в очередь на повтор",
        ["Lyrics response was too large"] = "Ответ с текстом слишком большой",
        ["No synced lyrics found"] = "Синхронизированный текст не найден",
        ["Lyrics fetch failed (HTTP %s)"] = "Ошибка загрузки текста (HTTP %s)",
        ["Lyrics response was not JSON"] = "Ответ с текстом не в формате JSON",
        ["Track is instrumental"] = "Инструментальный трек",
        ["No synced lyrics in result"] = "В результате нет синхронизированного текста",
        ["Saved lyrics"] = "Текст сохранён",
        ["This player cannot fetch lyrics"] = "Этот плеер не может загружать тексты",
        ["Play a local track with title and artist tags"] = "Воспроизведите локальный трек с тегами названия и исполнителя",
        ["Lyrics request added to pending queue"] = "Запрос текста добавлен в очередь",
        ["Could not update pending queue"] = "Не удалось обновить очередь ожидания",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "Не удалось прочитать очередь текстов; проверьте настройки",
        ["About Lyrics Fetcher"] = "О поиске текстов",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "Ищет синхронизированные тексты на LRCLIB по названию, исполнителю, альбому и длительности. Без API-ключа.",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "Записывает файл .lrc в ту же папку (заменяя расширение аудио на .lrc), как и плеер.",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "Пропускает .lrc с метками времени. Несинхронизированный .lrc сначала переименовывается в .compas-backup. Синхронизированные тексты не заменяются.",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "Встроенные в теги тексты не видны из Lua, поэтому для таких треков тоже может быть создан .lrc.",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "Запросы сохраняются перед загрузкой и возобновляются при появлении Wi-Fi даже после перезапуска. Их можно повторить или очистить.",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "Автоматический режим выключен, пока вы его не включите. Используются только локальные файлы; потоки и треки remote:// пропускаются.",
        ["Fetch lyrics for current track"] = "Найти текст для текущего трека",
        ["Pending lyrics requests: %s"] = "Ожидающие запросы текстов: %s",
        ["unavailable"] = "недоступно",
        ["Pending lyrics"] = "Ожидающие тексты",
        ["Retry pending downloads"] = "Повторить ожидающие загрузки",
        ["Clear pending queue"] = "Очистить очередь ожидания",
        ["Clear pending queue?"] = "Очистить очередь ожидания?",
        ["Keep queue"] = "Оставить очередь",
        ["Clear queue"] = "Очистить очередь",
        ["Could not clear pending queue"] = "Не удалось очистить очередь ожидания",
        ["Automatic fetch"] = "Автоматический поиск",
        ["How it works"] = "Как это работает",
    },
    uk = {
        ["Lyrics Fetcher"] = "Пошук текстів пісень",
        ["Fetching lyrics"] = "Завантаження тексту",
        ["Looking up lyrics…"] = "Пошук тексту…",
        ["Track path is not supported"] = "Шлях до треку не підтримується",
        ["Pending lyrics queue could not be read"] = "Не вдалося прочитати чергу очікуваних текстів",
        ["Lyrics already present"] = "Текст уже є",
        ["Could not read existing lyrics"] = "Не вдалося прочитати наявний текст",
        ["Could not update pending lyrics request"] = "Не вдалося оновити очікуваний запит тексту",
        ["Pending lyrics queue is full"] = "Черга очікуваних текстів переповнена",
        ["Track tags or path are not supported"] = "Теги або шлях до треку не підтримуються",
        ["Could not save pending lyrics request"] = "Не вдалося зберегти очікуваний запит тексту",
        ["Lyrics request queued for retry"] = "Запит тексту поставлено в чергу на повтор",
        ["Lyrics response was too large"] = "Відповідь із текстом занадто велика",
        ["No synced lyrics found"] = "Синхронізований текст не знайдено",
        ["Lyrics fetch failed (HTTP %s)"] = "Помилка завантаження тексту (HTTP %s)",
        ["Lyrics response was not JSON"] = "Відповідь із текстом не у форматі JSON",
        ["Track is instrumental"] = "Інструментальний трек",
        ["No synced lyrics in result"] = "У результаті немає синхронізованого тексту",
        ["Saved lyrics"] = "Текст збережено",
        ["This player cannot fetch lyrics"] = "Цей плеєр не може завантажувати тексти",
        ["Play a local track with title and artist tags"] = "Відтворіть локальний трек із тегами назви та виконавця",
        ["Lyrics request added to pending queue"] = "Запит тексту додано до черги",
        ["Could not update pending queue"] = "Не вдалося оновити чергу очікування",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "Не вдалося прочитати чергу текстів; перевірте налаштування",
        ["About Lyrics Fetcher"] = "Про пошук текстів",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "Шукає синхронізовані тексти на LRCLIB за назвою, виконавцем, альбомом і тривалістю. Без API-ключа.",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "Записує файл .lrc у ту саму теку (замінюючи розширення аудіо на .lrc), як і плеєр.",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "Пропускає .lrc із мітками часу. Несинхронізований .lrc спочатку перейменовується на .compas-backup. Синхронізовані тексти ніколи не замінюються.",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "Вбудовані в теги тексти не видно з Lua, тому такі треки все одно можуть отримати файл .lrc.",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "Запити зберігаються перед завантаженням і відновлюються після появи Wi-Fi навіть після перезапуску. Їх можна повторити або очистити.",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "Автоматичний режим вимкнено, доки ви його не увімкнете. Використовуються лише локальні файли; потоки та треки remote:// пропускаються.",
        ["Fetch lyrics for current track"] = "Знайти текст для поточного треку",
        ["Pending lyrics requests: %s"] = "Очікувані запити текстів: %s",
        ["unavailable"] = "недоступно",
        ["Pending lyrics"] = "Очікувані тексти",
        ["Retry pending downloads"] = "Повторити очікувані завантаження",
        ["Clear pending queue"] = "Очистити чергу очікування",
        ["Clear pending queue?"] = "Очистити чергу очікування?",
        ["Keep queue"] = "Залишити чергу",
        ["Clear queue"] = "Очистити чергу",
        ["Could not clear pending queue"] = "Не вдалося очистити чергу очікування",
        ["Automatic fetch"] = "Автоматичний пошук",
        ["How it works"] = "Як це працює",
    },
    vi = {
        ["Lyrics Fetcher"] = "Tìm lời bài hát",
        ["Fetching lyrics"] = "Đang tải lời bài hát",
        ["Looking up lyrics…"] = "Đang tìm lời bài hát…",
        ["Track path is not supported"] = "Đường dẫn bài hát không được hỗ trợ",
        ["Pending lyrics queue could not be read"] = "Không đọc được hàng đợi lời bài hát đang chờ",
        ["Lyrics already present"] = "Đã có lời bài hát",
        ["Could not read existing lyrics"] = "Không đọc được lời bài hát hiện có",
        ["Could not update pending lyrics request"] = "Không cập nhật được yêu cầu lời bài hát đang chờ",
        ["Pending lyrics queue is full"] = "Hàng đợi lời bài hát đã đầy",
        ["Track tags or path are not supported"] = "Thẻ hoặc đường dẫn bài hát không được hỗ trợ",
        ["Could not save pending lyrics request"] = "Không lưu được yêu cầu lời bài hát đang chờ",
        ["Lyrics request queued for retry"] = "Đã đưa yêu cầu lời bài hát vào hàng đợi thử lại",
        ["Lyrics response was too large"] = "Phản hồi lời bài hát quá lớn",
        ["No synced lyrics found"] = "Không tìm thấy lời bài hát đồng bộ",
        ["Lyrics fetch failed (HTTP %s)"] = "Tải lời bài hát thất bại (HTTP %s)",
        ["Lyrics response was not JSON"] = "Phản hồi lời bài hát không phải JSON",
        ["Track is instrumental"] = "Bài nhạc không lời",
        ["No synced lyrics in result"] = "Không có lời đồng bộ trong kết quả",
        ["Saved lyrics"] = "Đã lưu lời bài hát",
        ["This player cannot fetch lyrics"] = "Máy nghe nhạc này không thể tải lời bài hát",
        ["Play a local track with title and artist tags"] = "Hãy phát một bài nhạc nội bộ có thẻ tiêu đề và nghệ sĩ",
        ["Lyrics request added to pending queue"] = "Đã thêm yêu cầu lời bài hát vào hàng đợi",
        ["Could not update pending queue"] = "Không cập nhật được hàng đợi đang chờ",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "Không đọc được hàng đợi lời bài hát; hãy kiểm tra cài đặt",
        ["About Lyrics Fetcher"] = "Giới thiệu Tìm lời bài hát",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "Tra cứu lời bài hát đồng bộ trên LRCLIB bằng tiêu đề, nghệ sĩ, album và thời lượng. Không cần khóa API.",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "Ghi tệp .lrc cùng thư mục (thay phần mở rộng âm thanh bằng .lrc), khớp với trình phát.",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "Bỏ qua tệp .lrc đã có mốc thời gian. Tệp .lrc chưa đồng bộ sẽ được đổi tên thành .compas-backup trước. Lời bài hát đã đồng bộ không bao giờ bị ghi đè.",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "Lời bài hát nhúng trong thẻ không hiển thị với Lua, nên các bài đó vẫn có thể được tạo tệp .lrc.",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "Yêu cầu được lưu trước khi tải và tiếp tục khi có Wi-Fi trở lại, kể cả sau khi khởi động lại. Bạn có thể thử lại hoặc xóa chúng.",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "Chế độ tự động tắt cho đến khi bạn bật. Chỉ dùng tệp nội bộ; các luồng phát và bài remote:// sẽ được bỏ qua.",
        ["Fetch lyrics for current track"] = "Tải lời cho bài đang phát",
        ["Pending lyrics requests: %s"] = "Yêu cầu lời bài hát đang chờ: %s",
        ["unavailable"] = "không khả dụng",
        ["Pending lyrics"] = "Lời bài hát đang chờ",
        ["Retry pending downloads"] = "Thử lại các lượt tải đang chờ",
        ["Clear pending queue"] = "Xóa hàng đợi đang chờ",
        ["Clear pending queue?"] = "Xóa hàng đợi đang chờ?",
        ["Keep queue"] = "Giữ hàng đợi",
        ["Clear queue"] = "Xóa hàng đợi",
        ["Could not clear pending queue"] = "Không xóa được hàng đợi đang chờ",
        ["Automatic fetch"] = "Tự động tải",
        ["How it works"] = "Cách hoạt động",
    },
    zh_CN = {
        ["Lyrics Fetcher"] = "歌词获取器",
        ["Fetching lyrics"] = "正在获取歌词",
        ["Looking up lyrics…"] = "正在查找歌词…",
        ["Track path is not supported"] = "不支持曲目路径",
        ["Pending lyrics queue could not be read"] = "无法读取待处理歌词队列",
        ["Lyrics already present"] = "歌词已存在",
        ["Could not read existing lyrics"] = "无法读取现有歌词",
        ["Could not update pending lyrics request"] = "无法更新待处理歌词请求",
        ["Pending lyrics queue is full"] = "待处理歌词队列已满",
        ["Track tags or path are not supported"] = "不支持曲目标签或路径",
        ["Could not save pending lyrics request"] = "无法保存待处理歌词请求",
        ["Lyrics request queued for retry"] = "歌词请求已加入重试队列",
        ["Lyrics response was too large"] = "歌词响应过大",
        ["No synced lyrics found"] = "未找到同步歌词",
        ["Lyrics fetch failed (HTTP %s)"] = "歌词获取失败 (HTTP %s)",
        ["Lyrics response was not JSON"] = "歌词响应不是 JSON",
        ["Track is instrumental"] = "曲目为纯音乐",
        ["No synced lyrics in result"] = "结果中没有同步歌词",
        ["Saved lyrics"] = "已保存歌词",
        ["This player cannot fetch lyrics"] = "此播放器无法获取歌词",
        ["Play a local track with title and artist tags"] = "请播放带有标题和艺术家标签的本地曲目",
        ["Lyrics request added to pending queue"] = "歌词请求已添加到待处理队列",
        ["Could not update pending queue"] = "无法更新待处理队列",
        ["Pending lyrics queue could not be read; check Lyrics Fetcher settings"] = "无法读取待处理歌词队列；请检查歌词获取器设置",
        ["About Lyrics Fetcher"] = "关于歌词获取器",
        ["Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."] = "使用标题、艺术家、专辑和时长在 LRCLIB 上查找同步歌词。无需 API 密钥。",
        ["Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."] = "在同文件夹下写入 .lrc 伴随文件（将音频扩展名替换为 .lrc），与播放器一致。",
        ["Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."] = "跳过已有时间戳的 .lrc 文件。未同步的 .lrc 会先重命名为 .compas-backup，以便播放器读取新的同步文件。同步歌词绝不会被替换。",
        ["Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."] = "Lua 无法读取内嵌标签歌词，因此这些曲目仍可能生成 .lrc 文件。",
        ["Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."] = "缺失歌词请求会在下载前保存，并在 Wi-Fi 恢复时继续，即使重启后也是如此。你可以重试或清空待处理请求。",
        ["Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."] = "自动模式默认关闭，需手动开启。仅处理本地文件，跳过流媒体和 remote:// 曲目。",
        ["Fetch lyrics for current track"] = "获取当前曲目的歌词",
        ["Pending lyrics requests: %s"] = "待处理歌词请求：%s",
        ["unavailable"] = "不可用",
        ["Pending lyrics"] = "待处理歌词",
        ["Retry pending downloads"] = "重试待处理下载",
        ["Clear pending queue"] = "清空待处理队列",
        ["Clear pending queue?"] = "清空待处理队列？",
        ["Keep queue"] = "保留队列",
        ["Clear queue"] = "清空队列",
        ["Could not clear pending queue"] = "无法清空待处理队列",
        ["Automatic fetch"] = "自动获取",
        ["How it works"] = "工作原理",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

-- Fetches synced LRC lyrics from LRCLIB (no API key) for local tracks.
-- Native lyrics_load_sidecar() swaps the audio filename's extension for
-- ".lrc" in the same folder and reads only that path; this plugin writes
-- only that sidecar. A sidecar that already has timestamps is left alone.
-- An unsynchronized .lrc is renamed to .compas-backup (or -2..-9) before
-- the synced file is written, matching Cover Art Fetcher's unread backup
-- suffix. filename_sync.lrc is not a native lookup name. Embedded tag
-- lyrics are not exposed to Lua, so they cannot be detected here.

local USER_AGENT = "CompasPlayer-LyricsFetcher/1.4 (https://github.com/Starnished66/compas-player)"
local STATE_PATH = plugin.sd_root() .. "/.plugins/.lyrics_fetcher_state"
local MAX_LRC_BYTES = 512 * 1024
local MAX_PATH_BYTES = 4095
local MAX_FILENAME_BYTES = 255
local MAX_METADATA_BYTES = 128
local MAX_URL_BYTES = 2047
local TEMP_SUFFIX = ".compas-fetch"
local BACKUP_SUFFIX = ".compas-backup"
local MAX_BACKUP_SLOTS = 9
-- Longest extra name this plugin appends: ".compas-backup-9".
local MAX_SIDECAR_EXTRA = math.max(#TEMP_SUFFIX, #BACKUP_SUFFIX + 2)
local QUEUE_PATH = plugin.sd_root() .. "/.plugins/.lyrics_fetcher_pending"
local QUEUE_MAX_ENTRIES = 500
local QUEUE_MAX_BYTES = 2 * 1024 * 1024
local RETRY_BASE_SEC = 60
local RETRY_JITTER_SEC = 5

local state = { auto = false }
local in_flight = nil -- the sole native HTTP request/retry owner
local generation = 0
local last_auto_toast_at = 0

local function trim(s)
    return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function load_state()
    local f = io.open(STATE_PATH, "r")
    if not f then return end
    local line = f:read(2)
    f:close()
    state.auto = line == "1" or line == "1\n"
end

local function save_state()
    local tmp = STATE_PATH .. ".tmp"
    local f = io.open(tmp, "w")
    if not f then return end
    f:write(state.auto and "1" or "0", "\n")
    f:close()
    os.remove(STATE_PATH)
    os.rename(tmp, STATE_PATH)
end

local function url_encode(value)
    return (tostring(value):gsub("([^%w%-%.%_%~])", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

local function header(headers, name)
    if type(headers) ~= "table" then return nil end
    local want = name:lower()
    for k, v in pairs(headers) do
        if type(k) == "string" and k:lower() == want then return v end
    end
    return nil
end

local function is_absolute_local_path(path)
    return type(path) == "string" and path:sub(1, 1) == "/" and not path:find("://", 1, true)
end

-- Same rule as lyrics_load_sidecar(): strip the last "." after the last "/",
-- then append ".lrc". A file with no extension gets ".lrc" appended.
local function sidecar_path(audio_path)
    if not is_absolute_local_path(audio_path) then return nil end
    local slash = audio_path:match("^.*()/")
    local base = audio_path
    local dir = ""
    if slash then
        dir = audio_path:sub(1, slash)
        base = audio_path:sub(slash + 1)
    end
    local dot = base:match("^.*()%.")
    if dot and dot > 1 then
        base = base:sub(1, dot - 1)
    end
    if base == "" then return nil end
    return dir .. base .. ".lrc"
end

local function file_exists(path)
    if not path then return false end
    local f = io.open(path, "rb")
    if not f then return false end
    f:close()
    return true
end

-- True when inner is a complete native [mm:ss] / [mm:ss.xx] timestamp:
-- digits, colon, digits, and an optional fraction of digits only. Trailing
-- junk such as [12:34broken] does not count (native requires the whole
-- bracket contents to be consumed).
local function is_timestamp_inner(inner)
    if type(inner) ~= "string" or inner == "" then return false end
    local minutes, rest = inner:match("^(%d+):(.*)$")
    if not minutes or rest == nil then return false end
    if rest:match("^%d+$") then return true end
    local seconds, frac = rest:match("^(%d+)%.(%d+)$")
    return seconds ~= nil and frac ~= nil
end

local function line_has_leading_timestamp(line)
    if type(line) ~= "string" or line == "" then return false end
    if line:sub(-1) == "\r" then line = line:sub(1, -2) end
    local i = 1
    local found = false
    while line:sub(i, i) == "[" do
        local close = line:find("]", i, true)
        if not close then break end
        local inner = line:sub(i + 1, close - 1)
        local lower = inner:lower()
        if inner:sub(1, 1):match("%d") and is_timestamp_inner(inner) then
            found = true
            i = close + 1
        elseif lower:sub(1, 7) == "offset:" then
            i = close + 1
        elseif inner:match("^[A-Za-z][A-Za-z]?[A-Za-z]?[A-Za-z]?[A-Za-z]?[A-Za-z]?:") then
            i = close + 1
        else
            break
        end
    end
    return found
end

-- Native lyrics_parse_buffer() is sync-only: a line counts only when it
-- has at least one complete leading timestamp tag. Metadata ([ti:], [ar:],
-- 1-6 letters then ':') and [offset:] are skipped. A UTF-8 BOM at the
-- start of the file is ignored. A timestamp inside ordinary text, or a
-- malformed bracket, does not make the sidecar synchronized.
local function has_sync_line(text)
    if type(text) ~= "string" or text == "" then return false end
    if text:sub(1, 3) == "\239\187\191" then text = text:sub(4) end
    for line in (text .. "\n"):gmatch("(.-)\n") do
        if line_has_leading_timestamp(line) then return true end
    end
    return false
end

local function notify(message, is_auto)
    if is_auto then
        local now = os.time()
        if now - last_auto_toast_at < 30 then return end
        last_auto_toast_at = now
        return
    end
    plugin.show_toast(message)
end

local function show_progress(job, message, fraction, reopen)
    if not job or not job.manual_requested or not plugin.has_capability("ui.progress") then return false end
    if job.progress_handle and plugin.update_progress(job.progress_handle, message, fraction) then return true end
    if job.progress_handle then job.progress_handle = nil end
    if job.progress_attempted and not reopen then return false end
    job.progress_attempted = true
    job.progress_handle = plugin.show_progress(tr("Fetching lyrics"), message, fraction)
    return job.progress_handle ~= nil
end

local function close_progress(job)
    if job and job.progress_handle then
        plugin.close_progress(job.progress_handle)
        job.progress_handle = nil
    end
end

local function notify_job(job, message)
    if not job or not job.manual_requested then return end
    plugin.show_toast(message)
end

local function read_sidecar(path)
    if not path then return nil, "missing" end
    local f, _, code = io.open(path, "rb")
    if not f then
        -- ENOENT is absence; any other open error must block a replace.
        if code == 2 then return nil, "missing" end
        return nil, "unreadable"
    end
    local text, read_err = f:read(MAX_LRC_BYTES + 1)
    local closed = f:close()
    if not closed then return nil, "unreadable" end
    if text == nil then
        if read_err then return nil, "unreadable" end
        text = ""
    end
    if type(text) ~= "string" then return nil, "unreadable" end
    if #text > MAX_LRC_BYTES then return nil, "too-large" end
    return text, "ok"
end

local function sidecar_kind(text)
    if type(text) ~= "string" then return "missing" end
    if has_sync_line(text) then return "synced" end
    return "unsynced"
end

local function snapshot_sidecar(path)
    local text, status = read_sidecar(path)
    if status == "missing" then return { kind = "missing" } end
    if status ~= "ok" then return { kind = "blocked", reason = status } end
    return { kind = sidecar_kind(text), text = text }
end

local function snapshot_allows_fetch(snap)
    return snap ~= nil and (snap.kind == "missing" or snap.kind == "unsynced")
end

local function snapshot_still_valid(path, snap)
    if not snap or not snapshot_allows_fetch(snap) then return false end
    local now = snapshot_sidecar(path)
    if snap.kind == "missing" then return now.kind == "missing" end
    return now.kind == "unsynced" and now.text == snap.text
end

-- First free unread backup name; an existing backup is never reused.
local function backup_path(path)
    for slot = 1, MAX_BACKUP_SLOTS do
        local candidate = path .. BACKUP_SUFFIX .. (slot == 1 and "" or ("-" .. slot))
        if #candidate > MAX_PATH_BYTES then return nil end
        local basename = candidate:match("([^/]+)$")
        if not basename or #basename > MAX_FILENAME_BYTES then return nil end
        if not file_exists(candidate) then return candidate end
    end
    return nil
end

local function write_temp_lrc(tmp, text)
    os.remove(tmp)
    local f = io.open(tmp, "wb")
    if not f then return false, "write" end
    local ok, err = f:write(text)
    local closed = f:close()
    if not ok or not closed then
        os.remove(tmp)
        return false, err or "write"
    end
    return true
end

-- Writes synced lyrics to the native sidecar path. Missing dest is created.
-- An unsynchronized dest matching snap is renamed to .compas-backup first.
-- Synchronized dest, a changed dest, or a path/content race is refused.
-- If the final rename fails after backup, the unsynchronized file is restored.
local function install_synced_lrc(dest, text, snap)
    if type(text) ~= "string" or #text == 0 or #text > MAX_LRC_BYTES then
        return false, "invalid"
    end
    if not has_sync_line(text) then return false, "no-sync" end
    if not snapshot_still_valid(dest, snap) then
        local now = snapshot_sidecar(dest)
        if now.kind == "synced" then return false, "exists" end
        return false, "stale"
    end
    local tmp = dest .. TEMP_SUFFIX
    local wrote, write_err = write_temp_lrc(tmp, text)
    if not wrote then return false, write_err end
    if not snapshot_still_valid(dest, snap) then
        os.remove(tmp)
        local now = snapshot_sidecar(dest)
        if now.kind == "synced" then return false, "exists" end
        return false, "stale"
    end
    if snap.kind == "unsynced" then
        local backup = backup_path(dest)
        if not backup or file_exists(backup) then
            os.remove(tmp)
            return false, "backup"
        end
        if not os.rename(dest, backup) or file_exists(dest) or not file_exists(backup) then
            os.remove(tmp)
            return false, "backup"
        end
        if not os.rename(tmp, dest) or not file_exists(dest) then
            os.rename(backup, dest)
            os.remove(tmp)
            return false, "rename"
        end
        return true
    end
    if file_exists(dest) then
        os.remove(tmp)
        return false, "exists"
    end
    if not os.rename(tmp, dest) then
        os.remove(tmp)
        return false, "rename"
    end
    return true
end

local function atomic_write_lrc(dest, text)
    return install_synced_lrc(dest, text, snapshot_sidecar(dest))
end

local function refresh_current_lyrics_display(track_path)
    if type(track_path) ~= "string" or track_path == "" then return false end
    local ok, refreshed = pcall(plugin.refresh_lyrics, track_path)
    return ok == true and refreshed == true
end

local function path_is_bounded_under_root(path)
    if type(path) ~= "string" or #path == 0 or #path > MAX_PATH_BYTES or path:find("\0", 1, true) then return false end
    if path:find("//", 1, true) or path:match("/%.%.?/") or path:match("/%.%.?$") then return false end
    local root = plugin.sd_root()
    if type(root) ~= "string" or root == "" or root:find("\0", 1, true) or root:find("//", 1, true) then return false end
    if root ~= "/" then
        root = root:gsub("/+$", "")
        if path == root or path:sub(1, #root + 1) ~= root .. "/" then return false end
    elseif path:sub(1, 2) == "//" then
        return false
    end
    return true
end

local function destination_is_bounded(dest)
    if not path_is_bounded_under_root(dest) then return false end
    local basename = dest:match("([^/]+)$")
    return basename ~= nil and #basename + MAX_SIDECAR_EXTRA <= MAX_FILENAME_BYTES and
        #dest + MAX_SIDECAR_EXTRA <= MAX_PATH_BYTES
end

local function current_local_track()
    local path = plugin.get_current_track_path()
    if not is_absolute_local_path(path) then return nil end
    local title, artist, album, duration = plugin.get_now_playing()
    if type(title) ~= "string" or type(artist) ~= "string" or (album ~= nil and type(album) ~= "string") then return nil end
    if #title > MAX_METADATA_BYTES or #artist > MAX_METADATA_BYTES or (album and #album > MAX_METADATA_BYTES) then return nil end
    if plugin.get_current_track_path() ~= path then return nil end
    title, artist, album = trim(title), trim(artist), trim(album)
    if title == "" or artist == "" then return nil end
    if not path_is_bounded_under_root(path) then return nil end
    duration = tonumber(duration) or 0
    if duration ~= duration or duration == math.huge or duration == -math.huge then duration = 0 end
    local dest = sidecar_path(path)
    if not destination_is_bounded(dest) then return nil end
    return {
        path = path,
        title = title,
        artist = artist,
        album = album,
        duration = duration > 3600 and 0 or math.max(0, duration),
        dest = dest,
    }
end

local function extract_synced(record)
    if type(record) ~= "table" then return nil, "no-json" end
    if record.instrumental == true then return nil, "instrumental" end
    local synced = record.syncedLyrics
    if type(synced) ~= "string" or #synced == 0 or #synced > MAX_LRC_BYTES then return nil, "no-sync" end
    if trim(synced) == "" then return nil, "no-sync" end
    if not has_sync_line(synced) then return nil, "no-sync" end
    return synced
end

local function build_url(track)
    local q = "track_name=" .. url_encode(track.title) .. "&artist_name=" .. url_encode(track.artist)
    if track.album ~= "" then
        q = q .. "&album_name=" .. url_encode(track.album)
    end
    local dur = math.floor(track.duration + 0.5)
    if dur >= 1 and dur <= 3600 then
        q = q .. "&duration=" .. tostring(dur)
    end
    local url = "https://lrclib.net/api/get?" .. q
    if #url > MAX_URL_BYTES then return nil end
    return url
end

local finish_fetch
local drain_queue
local start_http
local pending = {}
local request_order = 0
local next_drain_at = 0
local queue_paused_until = 0
local rate_limited_until = 0
local network_backoff_until = 0
local network_failures = 0
local queue_corrupt = false

local function safe_number(n, min, max)
    n = tonumber(n)
    if not n or n ~= n or n == math.huge or n == -math.huge or n < min or n > max then return nil end
    return n
end

local function field_escape(s)
    return (tostring(s or ""):gsub("([^%w%-%.%_%~])", function(c) return string.format("%%%02X", string.byte(c)) end))
end
local function field_unescape(s)
    if type(s) ~= "string" or s:gsub("%%[%x][%x]", ""):find("%", 1, true) then return nil end
    local bad = false
    local out = s:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)
    if out:find("[%z\1-\8\11\12\14-\31\127]") then bad = true end
    if bad then return nil end
    return out
end
local function serialize_queue(items)
    if #items > QUEUE_MAX_ENTRIES then return nil end
    local lines = { "LFQ1\t" .. string.format("%.0f", math.ceil(rate_limited_until)) }
    for _, e in ipairs(items) do
        lines[#lines + 1] = table.concat({ tostring(e.order), tostring(e.requested), tostring(e.retry_at or 0),
            field_escape(e.path), field_escape(e.title), field_escape(e.artist), field_escape(e.album), tostring(e.duration or 0), e.settled and "1" or "0", tostring(e.attempts or 0) }, "\t")
    end
    local data = table.concat(lines, "\n") .. (#lines > 0 and "\n" or "")
    if #data > QUEUE_MAX_BYTES then return nil end
    return data
end
local function persist_queue(items)
    local data = serialize_queue(items)
    if not data then return false end
    local tmp = QUEUE_PATH .. ".tmp"
    local f = io.open(tmp, "wb")
    if not f then return false end
    local ok = f:write(data)
    local closed = f:close()
    if not ok or not closed then os.remove(tmp); return false end
    if not os.rename(tmp, QUEUE_PATH) then os.remove(tmp); return false end
    return true
end
local function valid_queue_entry(fields)
    local order = safe_number(fields[1], 1, 9e15)
    local requested = safe_number(fields[2], 1, 9e15)
    local retry_at = safe_number(fields[3], 0, 9e15)
    local path, title, artist, album = field_unescape(fields[4]), field_unescape(fields[5]), field_unescape(fields[6]), field_unescape(fields[7])
    local duration = safe_number(fields[8], 0, 3600)
    local attempts = safe_number(fields[10], 0, 30)
    if not attempts or attempts % 1 ~= 0 then return nil end
    local settled = fields[9] == "1"
    if fields[9] ~= "1" and fields[9] ~= "0" then return nil end
    if not order or not requested or not retry_at or not path or not title or not artist or not album or not duration then return nil end
    if #path > MAX_PATH_BYTES or #title > MAX_METADATA_BYTES or #artist > MAX_METADATA_BYTES or #album > MAX_METADATA_BYTES then return nil end
    if not is_absolute_local_path(path) or not path_is_bounded_under_root(path) or trim(title) == "" or trim(artist) == "" then return nil end
    local dest = sidecar_path(path)
    if not destination_is_bounded(dest) then return nil end
    return { order=order, requested=requested, retry_at=retry_at, path=path, title=trim(title), artist=trim(artist), album=trim(album), duration=duration, dest=dest, settled=settled, attempts=attempts }
end
local function load_queue()
    local f, _, code = io.open(QUEUE_PATH, "rb")
    if not f then
        if code == 2 then pending = {}; queue_corrupt = false; return true end
        queue_corrupt = true
        return false
    end
    local data, read_err = f:read(QUEUE_MAX_BYTES + 1)
    local closed = f:close()
    if read_err or not closed then queue_corrupt = true; return false end
    if type(data) ~= "string" or #data > QUEUE_MAX_BYTES then queue_corrupt = true; return false end
    local loaded, seen = {}, {}
    local header_line, rest = data:match("^([^\n]*)\n(.*)$")
    local persisted_rate = header_line and header_line:match("^LFQ1\t([%d%.]+)$")
    persisted_rate = safe_number(persisted_rate, 0, 9e15)
    if not persisted_rate then queue_corrupt = true; return false end
    rate_limited_until = math.max(rate_limited_until, persisted_rate)
    for line in (rest .. "\n"):gmatch("(.-)\n") do
        if line ~= "" then
            local fields = {}
            for part in (line .. "\t"):gmatch("(.-)\t") do
                if #fields == 10 then queue_corrupt = true; return false end
                fields[#fields + 1] = part
            end
            if #fields ~= 10 then queue_corrupt = true; return false end
            local e = valid_queue_entry(fields)
            if not e or seen[e.dest] or #loaded >= QUEUE_MAX_ENTRIES then queue_corrupt = true; return false end
            seen[e.dest] = true; loaded[#loaded + 1] = e
            request_order = math.max(request_order, e.order)
        end
    end
    pending = loaded
    queue_corrupt = false
    return true
end
local function replace_queue(items)
    if not persist_queue(items) then return false end
    pending = items
    return true
end
local function remove_entry(entry)
    local next_items = {}
    for _, e in ipairs(pending) do if e ~= entry then next_items[#next_items + 1] = e end end
    local ok = replace_queue(next_items)
    if not ok then entry.settled = true; queue_paused_until = os.time() + RETRY_BASE_SEC end
    return ok
end
local function enqueue_track(track, manual)
    track.dest = track.dest or sidecar_path(track.path)
    if not destination_is_bounded(track.dest) then if manual then plugin.show_toast(tr("Track path is not supported")) end; return false end
    if queue_corrupt then if manual then plugin.show_toast(tr("Pending lyrics queue could not be read")) end; return false end
    local snap = snapshot_sidecar(track.dest)
    if snap.kind == "synced" then if manual then plugin.show_toast(tr("Lyrics already present")) end; return false end
    if snap.kind == "blocked" then if manual then plugin.show_toast(tr("Could not read existing lyrics")) end; return false end
    for _, entry in ipairs(pending) do
        if entry.dest == track.dest then
            if manual then
                local old_order, old_retry, old_attempts, old_manual, old_settled = entry.order, entry.retry_at, entry.attempts, entry.manual, entry.settled
                request_order = request_order + 1
                entry.order, entry.retry_at, entry.attempts, entry.manual, entry.settled = request_order, 0, 0, true, false
                if not persist_queue(pending) then
                    entry.order, entry.retry_at, entry.attempts, entry.manual, entry.settled = old_order, old_retry, old_attempts, old_manual, old_settled
                    plugin.show_toast(tr("Could not update pending lyrics request"))
                    return false
                end
                network_backoff_until, network_failures, next_drain_at = 0, 0, 0
                if in_flight and in_flight.entry == entry then
                    in_flight.manual_requested = true
                    show_progress(in_flight, in_flight.stage or tr("Looking up lyrics…"), nil, true)
                end
            end
            return true
        end
    end
    if #pending >= QUEUE_MAX_ENTRIES then if manual then plugin.show_toast(tr("Pending lyrics queue is full")) end; return false end
    request_order = request_order + 1
    local duration = math.max(0, tonumber(track.duration) or 0)
    if duration > 3600 then duration = 0 end
    local e = valid_queue_entry({tostring(request_order), tostring(os.time()), "0",
        field_escape(track.path), field_escape(track.title), field_escape(track.artist),
        field_escape(track.album or ""), tostring(duration), "0", "0"})
    if not e then
        if manual then plugin.show_toast(tr("Track tags or path are not supported")) end
        return false
    end
    e.manual = manual
    local items = {}; for _, old in ipairs(pending) do items[#items + 1] = old end; items[#items + 1] = e
    if not replace_queue(items) then if manual then plugin.show_toast(tr("Could not save pending lyrics request")) end; return false end
    return true
end
local function queue_count() return #pending end
local function is_online()
    if plugin.has_capability("network.status") and type(plugin.network_status) == "function" then
        local ok, st = pcall(plugin.network_status)
        if ok and type(st) == "table" then return st.wifi_enabled ~= false and st.connected ~= false end
    end
    return true
end
local function retry_after_seconds(value)
    local seconds = tonumber(value)
    if seconds and seconds == seconds and seconds > 0 and seconds < math.huge then return math.min(seconds, 24 * 60 * 60) end
    if type(value) ~= "string" then return nil end
    local day, mon, year, hour, minute, second = value:match("%a+, (%d%d) (%a+) (%d%d%d%d) (%d%d):(%d%d):(%d%d) GMT")
    local months = {Jan=1,Feb=2,Mar=3,Apr=4,May=5,Jun=6,Jul=7,Aug=8,Sep=9,Oct=10,Nov=11,Dec=12}
    if not day or not months[mon] then return nil end
    local ok, utc = pcall(os.time, {year=tonumber(year),month=months[mon],day=tonumber(day),hour=tonumber(hour),min=tonumber(minute),sec=tonumber(second),isdst=false})
    if not ok or type(utc) ~= "number" then return nil end
    local offset = os.difftime(os.time(os.date("!*t", utc)), utc)
    return math.min(24 * 60 * 60, math.max(0, utc - offset - os.time()))
end
local function retry_delay(entry, headers)
    local delay = math.min(3600, RETRY_BASE_SEC * 2 ^ math.min((entry.attempts or 1) - 1, 6))
    local ra = retry_after_seconds(header(headers, "Retry-After"))
    if ra and ra > 0 then delay = math.max(delay, ra) end
    return delay + math.random() * RETRY_JITTER_SEC
end
local function defer_entry(entry, headers, status)
    entry.attempts = math.min(30, (entry.attempts or 0) + 1)
    entry.retry_at = os.time() + retry_delay(entry, headers)
    entry.manual = false
    if status == 429 or retry_after_seconds(header(headers, "Retry-After")) then
        rate_limited_until = math.max(rate_limited_until, entry.retry_at)
        for _, other in ipairs(pending) do other.retry_at = math.max(other.retry_at, rate_limited_until) end
    end
    if not persist_queue(pending) then queue_paused_until = os.time() + RETRY_BASE_SEC end
    next_drain_at = os.time() + 1
end
local function job_track(entry)
    return { path=entry.path, title=entry.title, artist=entry.artist, album=entry.album, duration=entry.duration, dest=entry.dest }
end

local function clear_in_flight(job)
    if in_flight == job then in_flight = nil end
end

drain_queue = function()
    if queue_corrupt then return end
    if in_flight or os.time() < next_drain_at or os.time() < queue_paused_until or os.time() < rate_limited_until or os.time() < network_backoff_until then return end
    if not is_online() then return end
    for _, entry in ipairs(pending) do
        if entry.settled then
            local keep = {}; for _, other in ipairs(pending) do if not other.settled then keep[#keep + 1] = other end end
            if not replace_queue(keep) then queue_paused_until = os.time() + RETRY_BASE_SEC; return end
            break
        end
    end
    table.sort(pending, function(a,b) return a.order > b.order end)
    for _, entry in ipairs(pending) do
        if entry.retry_at <= os.time() then
            local track = job_track(entry)
            local snap = snapshot_sidecar(track.dest)
            if snap.kind == "synced" then
                remove_entry(entry)
                return
            elseif snap.kind == "blocked" then
                entry.retry_at = os.time() + RETRY_BASE_SEC
                if not persist_queue(pending) then queue_paused_until = entry.retry_at end
                return
            else
                start_http(track, entry)
                return
            end
        end
    end
end

local function queue_failure(job, headers, status, network_failure)
    local entry = job.entry
    if entry.manual then notify_job(job, tr("Lyrics request queued for retry")) end
    close_progress(job)
    clear_in_flight(job)
    defer_entry(entry, headers, status)
    if network_failure then
        network_failures = math.min(7, network_failures + 1)
        network_backoff_until = os.time() + math.min(3600, RETRY_BASE_SEC * 2 ^ (network_failures - 1))
    end
end

start_http = function(track, entry)

    local snap = snapshot_sidecar(track.dest)
    if snap.kind == "synced" then
        remove_entry(entry)
        return false
    end
    if snap.kind == "blocked" then
        defer_entry(entry)
        return false
    end
    local url = build_url(track)
    if not url then defer_entry(entry); return false end
    generation = generation + 1
    local gen = generation
    local is_auto = not entry.manual
    local job = { path=track.path, dest=track.dest, is_auto=is_auto, entry=entry, manual_requested=entry.manual == true }
    job.gen, job.track, job.snapshot = gen, track, snap
    job.stage = tr("Looking up lyrics…")
    in_flight = job
    show_progress(job, job.stage, nil, false)
    local ok, handle = pcall(plugin.http_request, {
        url=url, method="GET", headers={ ["User-Agent"]=USER_AGENT }, verify_tls=true,
        max_response_bytes=MAX_LRC_BYTES, connect_timeout_ms=10000, read_timeout_ms=15000, total_timeout_ms=30000, redirect_limit=3,
    }, function(status, body, err, headers) finish_fetch(track, is_auto, gen, status, body, err, headers) end)
    if not ok or not handle then
        queue_failure(job, nil, nil, true)
        return false
    end
    return true
end

finish_fetch = function(track, is_auto, gen, status, body, err, headers)
    local job = in_flight
    if not job or job.gen ~= gen then return end
    local entry = job.entry
    local function terminal()
        clear_in_flight(job)
        remove_entry(entry); next_drain_at = os.time() + 1
    end
    local transient = err ~= nil or status == 429 or status == 408 or status == 425 or status == 401 or status == 403
        or (status and status >= 500 and status <= 599)
    if err == "response_too_large" then close_progress(job); notify_job(job, tr("Lyrics response was too large")); terminal(); return end
    if transient then queue_failure(job, headers, status, true); return end
    network_failures, network_backoff_until = 0, 0
    local snap = snapshot_sidecar(track.dest)
    if snap.kind == "blocked" then queue_failure(job); return end
    if not snapshot_still_valid(track.dest, job.snapshot) then
        if snap.kind == "synced" then close_progress(job); terminal()
        else queue_failure(job) end
        return
    end
    if status == 404 then close_progress(job); notify_job(job, tr("No synced lyrics found")); terminal(); return end
    if status ~= 200 or type(body) ~= "string" or #body > MAX_LRC_BYTES then
        close_progress(job); notify_job(job, string.format(tr("Lyrics fetch failed (HTTP %s)"), tostring(status))); terminal(); return
    end
    local decoded, record = pcall(plugin.json_decode, body, { max_input_bytes=MAX_LRC_BYTES, max_nesting=8, max_entries=64 })
    if not decoded or not record then close_progress(job); notify_job(job, tr("Lyrics response was not JSON")); terminal(); return end
    local lrc, why = extract_synced(record)
    if not lrc then close_progress(job); notify_job(job, why == "instrumental" and tr("Track is instrumental") or tr("No synced lyrics in result")); terminal(); return end
    if not snapshot_still_valid(track.dest, job.snapshot) then close_progress(job); queue_failure(job); return end
    local ok, write_err = install_synced_lrc(track.dest, lrc, job.snapshot)
    close_progress(job)
    if ok then
        notify_job(job, tr("Saved lyrics"))
        if plugin.get_current_track_path() == track.path then refresh_current_lyrics_display(track.path) end
        terminal()
    elseif write_err == "exists" then terminal()
    else queue_failure(job) end
end

local function fetch_current(is_auto)
    if not plugin.has_capability("network.http.async") or not plugin.has_capability("data.json") then
        if not is_auto then plugin.show_toast(tr("This player cannot fetch lyrics")) end; return
    end
    local track = current_local_track()
    if not track then notify(tr("Play a local track with title and artist tags"), is_auto); return end
    if not enqueue_track(track, not is_auto) then return end
    if not is_auto then
        for _, e in ipairs(pending) do if e.dest == track.dest then e.manual = true end end
        if not is_online() then plugin.show_toast(tr("Lyrics request added to pending queue")) end
    end
    drain_queue()
    if not is_auto then
        for _, entry in ipairs(pending) do
            if entry.dest == track.dest and (not in_flight or in_flight.entry ~= entry) then
                if not is_online() or os.time() < rate_limited_until or os.time() < network_backoff_until
                    or os.time() < queue_paused_until or entry.retry_at > os.time() then entry.manual = false end
            end
        end
    end
end

-- Keep entry identities: an in-flight response owns the same entry that
-- it must retire after completion, even if Retry is tapped meanwhile.
local function retry_pending()
    if queue_corrupt and not load_queue() then
        plugin.show_toast(tr("Pending lyrics queue could not be read"))
        return false
    end
    local previous = {}
    for i, entry in ipairs(pending) do
        previous[i] = entry.retry_at
        entry.retry_at = 0
    end
    if not persist_queue(pending) then
        for i, entry in ipairs(pending) do entry.retry_at = previous[i] end
        plugin.show_toast(tr("Could not update pending queue"))
        return false
    end
    next_drain_at, network_backoff_until, network_failures = 0, 0, 0
    drain_queue()
    return true
end

local function clear_pending()
    if not persist_queue({}) then return false end
    generation = generation + 1
    if in_flight then close_progress(in_flight); in_flight = nil end
    pending = {}; next_drain_at = 0; queue_paused_until = 0; queue_corrupt = false
    network_backoff_until, network_failures = 0, 0
    return true
end

plugin.on("track_started", function(_, _, _, _, provider)
    if state.auto and not (provider and provider ~= "") then fetch_current(true) end
end)

plugin.set_interval(1, function() drain_queue() end)
if plugin.has_capability("network.status") and type(plugin.network_status) == "function" then
    pcall(plugin.on, "network_changed", function(info)
        if type(info) == "table" and info.connected then
            network_backoff_until, network_failures = 0, 0
        end
        next_drain_at = 0
        drain_queue()
    end)
end
if not load_queue() then plugin.show_toast(tr("Pending lyrics queue could not be read; check Lyrics Fetcher settings")) end
drain_queue()

local function open_about()
    plugin.show_list(tr("About Lyrics Fetcher"), {
        tr("Looks up synced lyrics on LRCLIB using title, artist, album and duration. No API key."),
        tr("Writes a same-folder .lrc sidecar (audio extension replaced with .lrc), matching the player."),
        tr("Skips a sidecar that already has timestamps. An unsynchronized .lrc is renamed to .compas-backup first so the player can read the new synced file. Synchronized lyrics are never replaced."),
        tr("Embedded tag lyrics cannot be seen from Lua, so those tracks may still get a sidecar."),
        tr("Missing-lyrics requests are saved before downloading and resume when Wi-Fi returns, even after a restart. Pending lyrics requests lets you retry or clear them."),
        tr("Automatic mode is off until you enable it. Only absolute local files are used; streams and remote:// tracks are skipped."),
    }, function() end)
end

local function open_settings()
    plugin.show_settings_list(tr("Lyrics Fetcher"), {
        {
            type = "row",
            label = tr("Fetch lyrics for current track"),
            on_select = function() fetch_current(false) end,
        },
        {
            type = "row",
            label = string.format(tr("Pending lyrics requests: %s"), queue_corrupt and tr("unavailable") or tostring(queue_count())),
            on_select = function()
                plugin.show_list(tr("Pending lyrics"), {
                    tr("Retry pending downloads"), tr("Clear pending queue"),
                }, function(index)
                    if index == 1 then
                        retry_pending()
                    elseif index == 2 then
                        plugin.show_list(tr("Clear pending queue?"), {tr("Keep queue"), tr("Clear queue")}, function(choice)
                            if choice == 2 and not clear_pending() then
                                plugin.show_toast(tr("Could not clear pending queue"))
                            end
                        end)
                    end
                end)
            end,
        },
        {
            type = "toggle",
            label = tr("Automatic fetch"),
            value = state.auto,
            on_change = function(on)
                state.auto = on
                save_state()
            end,
        },
        {
            type = "row",
            label = tr("How it works"),
            on_select = open_about,
        },
    })
end

load_state()
plugin.register_list_item("music_library", tr("Lyrics Fetcher"), open_settings)
-- Older firmware keeps Settings > Library until it supports player menu rows.
if plugin.has_capability("ui.player_menu") then
    plugin.register_list_item("player", tr("Lyrics Fetcher"), function()
        fetch_current(false)
    end)
end

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        sidecar_path = sidecar_path,
        is_absolute_local_path = is_absolute_local_path,
        extract_synced = extract_synced,
        has_sync_line = has_sync_line,
        sidecar_kind = sidecar_kind,
        read_sidecar = read_sidecar,
        snapshot_sidecar = snapshot_sidecar,
        snapshot_allows_fetch = snapshot_allows_fetch,
        snapshot_still_valid = snapshot_still_valid,
        backup_path = backup_path,
        install_synced_lrc = install_synced_lrc,
        atomic_write_lrc = atomic_write_lrc,
        refresh_current_lyrics_display = refresh_current_lyrics_display,
        build_url = build_url,
        enqueue_track = enqueue_track,
        drain_queue = drain_queue,
        get_pending = function() return pending end,
        persist_queue = persist_queue,
        load_queue = load_queue,
        clear_pending = clear_pending,
        retry_pending = retry_pending,
        fetch_current = fetch_current,
        get_queue_state = function() return in_flight, nil end,
        state = state,
        BACKUP_SUFFIX = BACKUP_SUFFIX,
        TEMP_SUFFIX = TEMP_SUFFIX,
    }
end
