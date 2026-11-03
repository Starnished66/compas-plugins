--[[
Tidal, for a paid account you already have.

Tidal does not take a password from a third-party player. Sign-in is the
device-code flow: this screen shows a short code, a phone opens
link.tidal.com and enters it, and the player polls until that succeeds.
The device-flow client is the one from the stock player, so opening the
tile shows the code. Tidal revokes client pairs; when sign-in starts
failing, that pair is the first thing to replace.

The access token is a JWT, renewed from the refresh token about a minute
before it expires. Catalogue calls send it as a bearer token.

The Stream Media row uses the player's own stream_media/tidal_row.png, the same
theme-relative icon path Net Radio and Podcasts pass to
plugin.register_stream_media_tile().

Lossless is the quality that comes back as one FLAC file, which
plugin.play_remote() can stream. Tapping a track starts it first, then the
queue wraps through the available collection up to 500 tracks. Low and High are offered
too; if the manifest is an MP4 rather than a bare FLAC or ADTS AAC, playback
stops with an explanation. Hi-res arrives as DASH segments, and this player
cannot reassemble those, so that quality is not listed.

Stream links expire within minutes. API 17 playback resolves fresh links on
demand for up to 500 tracks. Stream format and server support determine
quality and seeking behavior. Copy Tidal.lua to <SD card>/.plugins/ and
restart.
]]

plugin.define({
    id = "community.tidal",
    name = "Tidal",
    version = "1.4.0",
    api_min = 19,
})

local T = {
    de = {
        ["Tidal needs a player build with remote playback"] = "Tidal benötigt eine Player-Version mit Remote-Wiedergabe",
        ["Lossless FLAC (CD)"] = "Verlustfrei FLAC (CD)",
        ["High (AAC 320)"] = "Hoch (AAC 320)",
        ["Low (AAC 96)"] = "Niedrig (AAC 96)",
        ["Logged out of Tidal"] = "Von Tidal abgemeldet",
        ["Nothing in this list can be streamed"] = "Nichts in dieser Liste kann gestreamt werden",
        ["No tracks"] = "Keine Titel",
        ["No albums"] = "Keine Alben",
        ["No artists"] = "Keine Künstler",
        ["No playlists"] = "Keine Wiedergabelisten",
        ["No results"] = "Keine Ergebnisse",
        ["Not available to stream"] = "Nicht zum Streamen verfügbar",
        ["No stream link"] = "Kein Stream-Link",
        ["Still waiting for the phone"] = "Warte weiterhin auf das Telefon",
        ["Quality updated"] = "Qualität aktualisiert",
        ["This quality is unavailable. Choose Lossless."] = "Diese Qualität ist nicht verfügbar. Wähle Verlustfrei.",
        ["Sign-in expired. Open the tile to try again."] = "Anmeldung abgelaufen. Öffne die Kachel erneut.",
        ["Code: %s"] = "Code: %s",
        ["Signed in to Tidal"] = "Bei Tidal angemeldet",
        ["Preparing playback"] = "Wiedergabe wird vorbereitet",
        ["Could not complete the request. Try again."] = "Anfrage fehlgeschlagen. Versuche es erneut.",
        ["Unknown album"] = "Unbekanntes Album",
        ["Unknown title"] = "Unbekannter Titel",
        ["Unknown artist"] = "Unbekannter Künstler",
        ["Playlist"] = "Wiedergabeliste",
        ["Could not load"] = "Laden fehlgeschlagen",
        ["Retry"] = "Wiederholen",
        ["Play these"] = "Diese abspielen",
        ["Favorite tracks"] = "Lieblingstitel",
        ["Favorite albums"] = "Lieblingsalben",
        ["Playlists"] = "Wiedergabelisten",
        ["Quality"] = "Qualität",
        ["Sign in to Tidal"] = "Bei Tidal anmelden",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "Code: %s\n\nÖffne %s auf einem Telefon und gib diesen Code ein.\n\nWarte auf das Telefon.",
        ["Search tracks"] = "Titel suchen",
        ["Search albums"] = "Alben suchen",
        ["Search artists"] = "Künstler suchen",
        ["Sign in or log out"] = "An- oder abmelden",
        ["Tracks"] = "Titel",
        ["Albums"] = "Alben",
        ["Artists"] = "Künstler",
    },
    es = {
        ["Tidal needs a player build with remote playback"] = "Tidal necesita una versión del reproductor con reproducción remota",
        ["Lossless FLAC (CD)"] = "FLAC sin pérdida (CD)",
        ["High (AAC 320)"] = "Alta (AAC 320)",
        ["Low (AAC 96)"] = "Baja (AAC 96)",
        ["Logged out of Tidal"] = "Sesión cerrada en Tidal",
        ["Nothing in this list can be streamed"] = "Nada de esta lista se puede reproducir",
        ["No tracks"] = "Sin pistas",
        ["No albums"] = "Sin álbumes",
        ["No artists"] = "Sin artistas",
        ["No playlists"] = "Sin listas de reproducción",
        ["No results"] = "Sin resultados",
        ["Not available to stream"] = "No disponible para transmitir",
        ["No stream link"] = "Sin enlace de transmisión",
        ["Still waiting for the phone"] = "Aún esperando al teléfono",
        ["Quality updated"] = "Calidad actualizada",
        ["This quality is unavailable. Choose Lossless."] = "Esta calidad no está disponible. Elige Sin pérdida.",
        ["Sign-in expired. Open the tile to try again."] = "El inicio de sesión expiró. Abre el mosaico para intentarlo de nuevo.",
        ["Code: %s"] = "Código: %s",
        ["Signed in to Tidal"] = "Sesión iniciada en Tidal",
        ["Preparing playback"] = "Preparando reproducción",
        ["Could not complete the request. Try again."] = "No se pudo completar la solicitud. Inténtalo de nuevo.",
        ["Unknown album"] = "Álbum desconocido",
        ["Unknown title"] = "Título desconocido",
        ["Unknown artist"] = "Artista desconocido",
        ["Playlist"] = "Lista de reproducción",
        ["Could not load"] = "No se pudo cargar",
        ["Retry"] = "Reintentar",
        ["Play these"] = "Reproducir todo",
        ["Favorite tracks"] = "Pistas favoritas",
        ["Favorite albums"] = "Álbumes favoritos",
        ["Playlists"] = "Listas de reproducción",
        ["Quality"] = "Calidad",
        ["Sign in to Tidal"] = "Iniciar sesión en Tidal",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "Código: %s\n\nEn un teléfono, abre %s e introduce este código.\n\nEsperando al teléfono.",
        ["Search tracks"] = "Buscar pistas",
        ["Search albums"] = "Buscar álbumes",
        ["Search artists"] = "Buscar artistas",
        ["Sign in or log out"] = "Iniciar o cerrar sesión",
        ["Tracks"] = "Pistas",
        ["Albums"] = "Álbumes",
        ["Artists"] = "Artistas",
    },
    fi = {
        ["Tidal needs a player build with remote playback"] = "Tidal vaatii soitinversion, jossa on etätoisto",
        ["Lossless FLAC (CD)"] = "Häviötön FLAC (CD)",
        ["High (AAC 320)"] = "Korkea (AAC 320)",
        ["Low (AAC 96)"] = "Matala (AAC 96)",
        ["Logged out of Tidal"] = "Kirjauduttu ulos Tidalista",
        ["Nothing in this list can be streamed"] = "Mitään tällä listalla ei voi suoratoistaa",
        ["No tracks"] = "Ei kappaleita",
        ["No albums"] = "Ei albumeita",
        ["No artists"] = "Ei esittäjiä",
        ["No playlists"] = "Ei soittolistoja",
        ["No results"] = "Ei tuloksia",
        ["Not available to stream"] = "Ei saatavilla suoratoistoon",
        ["No stream link"] = "Ei suoratoistolinkkiä",
        ["Still waiting for the phone"] = "Odotetaan yhä puhelinta",
        ["Quality updated"] = "Laatu päivitetty",
        ["This quality is unavailable. Choose Lossless."] = "Tämä laatu ei ole saatavilla. Valitse Häviötön.",
        ["Sign-in expired. Open the tile to try again."] = "Kirjautuminen vanheni. Yritä uudelleen avaamalla kuvake.",
        ["Code: %s"] = "Koodi: %s",
        ["Signed in to Tidal"] = "Kirjauduttu Tidaliin",
        ["Preparing playback"] = "Valmistellaan toistoa",
        ["Could not complete the request. Try again."] = "Pyyntöä ei voitu suorittaa. Yritä uudelleen.",
        ["Unknown album"] = "Tuntematon albumi",
        ["Unknown title"] = "Tuntematon kappale",
        ["Unknown artist"] = "Tuntematon esittäjä",
        ["Playlist"] = "Soittolista",
        ["Could not load"] = "Lataus epäonnistui",
        ["Retry"] = "Yritä uudelleen",
        ["Play these"] = "Toista nämä",
        ["Favorite tracks"] = "Suosikkikappaleet",
        ["Favorite albums"] = "Suosikkialbumit",
        ["Playlists"] = "Soittolistat",
        ["Quality"] = "Laatu",
        ["Sign in to Tidal"] = "Kirjaudu Tidaliin",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "Koodi: %s\n\nAvaa puhelimella %s ja syötä tämä koodi.\n\nOdotetaan puhelinta.",
        ["Search tracks"] = "Etsi kappaleita",
        ["Search albums"] = "Etsi albumeita",
        ["Search artists"] = "Etsi esittäjiä",
        ["Sign in or log out"] = "Kirjaudu sisään tai ulos",
        ["Tracks"] = "Kappaleet",
        ["Albums"] = "Albumit",
        ["Artists"] = "Esittäjät",
    },
    fr = {
        ["Tidal needs a player build with remote playback"] = "Tidal nécessite une version du lecteur avec lecture à distance",
        ["Lossless FLAC (CD)"] = "FLAC sans perte (CD)",
        ["High (AAC 320)"] = "Haute (AAC 320)",
        ["Low (AAC 96)"] = "Basse (AAC 96)",
        ["Logged out of Tidal"] = "Déconnecté de Tidal",
        ["Nothing in this list can be streamed"] = "Rien dans cette liste ne peut être diffusé",
        ["No tracks"] = "Aucun titre",
        ["No albums"] = "Aucun album",
        ["No artists"] = "Aucun artiste",
        ["No playlists"] = "Aucune playlist",
        ["No results"] = "Aucun résultat",
        ["Not available to stream"] = "Indisponible en streaming",
        ["No stream link"] = "Aucun lien de flux",
        ["Still waiting for the phone"] = "Toujours en attente du téléphone",
        ["Quality updated"] = "Qualité mise à jour",
        ["This quality is unavailable. Choose Lossless."] = "Cette qualité est indisponible. Choisissez Sans perte.",
        ["Sign-in expired. Open the tile to try again."] = "Connexion expirée. Ouvrez la tuile pour réessayer.",
        ["Code: %s"] = "Code : %s",
        ["Signed in to Tidal"] = "Connecté à Tidal",
        ["Preparing playback"] = "Préparation de la lecture",
        ["Could not complete the request. Try again."] = "Impossible de terminer la requête. Réessayez.",
        ["Unknown album"] = "Album inconnu",
        ["Unknown title"] = "Titre inconnu",
        ["Unknown artist"] = "Artiste inconnu",
        ["Playlist"] = "Playlist",
        ["Could not load"] = "Chargement impossible",
        ["Retry"] = "Réessayer",
        ["Play these"] = "Lire ces titres",
        ["Favorite tracks"] = "Titres favoris",
        ["Favorite albums"] = "Albums favoris",
        ["Playlists"] = "Playlists",
        ["Quality"] = "Qualité",
        ["Sign in to Tidal"] = "Se connecter à Tidal",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "Code : %s\n\nSur un téléphone, ouvrez %s et saisissez ce code.\n\nEn attente du téléphone.",
        ["Search tracks"] = "Rechercher des titres",
        ["Search albums"] = "Rechercher des albums",
        ["Search artists"] = "Rechercher des artistes",
        ["Sign in or log out"] = "Connexion ou déconnexion",
        ["Tracks"] = "Titres",
        ["Albums"] = "Albums",
        ["Artists"] = "Artistes",
    },
    it = {
        ["Tidal needs a player build with remote playback"] = "Tidal richiede una versione del lettore con riproduzione remota",
        ["Lossless FLAC (CD)"] = "FLAC senza perdita (CD)",
        ["High (AAC 320)"] = "Alta (AAC 320)",
        ["Low (AAC 96)"] = "Bassa (AAC 96)",
        ["Logged out of Tidal"] = "Disconnesso da Tidal",
        ["Nothing in this list can be streamed"] = "Nulla in questo elenco può essere riprodotto",
        ["No tracks"] = "Nessun brano",
        ["No albums"] = "Nessun album",
        ["No artists"] = "Nessun artista",
        ["No playlists"] = "Nessuna playlist",
        ["No results"] = "Nessun risultato",
        ["Not available to stream"] = "Non disponibile per lo streaming",
        ["No stream link"] = "Nessun link di streaming",
        ["Still waiting for the phone"] = "Ancora in attesa del telefono",
        ["Quality updated"] = "Qualità aggiornata",
        ["This quality is unavailable. Choose Lossless."] = "Questa qualità non è disponibile. Scegli Senza perdita.",
        ["Sign-in expired. Open the tile to try again."] = "Accesso scaduto. Apri il riquadro per riprovare.",
        ["Code: %s"] = "Codice: %s",
        ["Signed in to Tidal"] = "Accesso a Tidal effettuato",
        ["Preparing playback"] = "Preparazione della riproduzione",
        ["Could not complete the request. Try again."] = "Impossibile completare la richiesta. Riprova.",
        ["Unknown album"] = "Album sconosciuto",
        ["Unknown title"] = "Titolo sconosciuto",
        ["Unknown artist"] = "Artista sconosciuto",
        ["Playlist"] = "Playlist",
        ["Could not load"] = "Impossibile caricare",
        ["Retry"] = "Riprova",
        ["Play these"] = "Riproduci questi",
        ["Favorite tracks"] = "Brani preferiti",
        ["Favorite albums"] = "Album preferiti",
        ["Playlists"] = "Playlist",
        ["Quality"] = "Qualità",
        ["Sign in to Tidal"] = "Accedi a Tidal",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "Codice: %s\n\nSu un telefono, apri %s e inserisci questo codice.\n\nIn attesa del telefono.",
        ["Search tracks"] = "Cerca brani",
        ["Search albums"] = "Cerca album",
        ["Search artists"] = "Cerca artisti",
        ["Sign in or log out"] = "Accedi o esci",
        ["Tracks"] = "Brani",
        ["Albums"] = "Album",
        ["Artists"] = "Artisti",
    },
    ja = {
        ["Tidal needs a player build with remote playback"] = "Tidal にはリモート再生対応のプレーヤーが必要です",
        ["Lossless FLAC (CD)"] = "ロスレス FLAC (CD)",
        ["High (AAC 320)"] = "高音質 (AAC 320)",
        ["Low (AAC 96)"] = "低音質 (AAC 96)",
        ["Logged out of Tidal"] = "Tidal からログアウトしました",
        ["Nothing in this list can be streamed"] = "このリストには再生できる曲がありません",
        ["No tracks"] = "曲がありません",
        ["No albums"] = "アルバムがありません",
        ["No artists"] = "アーティストがいません",
        ["No playlists"] = "プレイリストがありません",
        ["No results"] = "結果がありません",
        ["Not available to stream"] = "ストリーミングできません",
        ["No stream link"] = "ストリームリンクがありません",
        ["Still waiting for the phone"] = "スマートフォンの入力を待っています",
        ["Quality updated"] = "音質を更新しました",
        ["This quality is unavailable. Choose Lossless."] = "この音質は利用できません。ロスレスを選択してください。",
        ["Sign-in expired. Open the tile to try again."] = "ログインの有効期限が切れました。タイルを開いて再試行してください。",
        ["Code: %s"] = "コード: %s",
        ["Signed in to Tidal"] = "Tidal にログインしました",
        ["Preparing playback"] = "再生を準備中",
        ["Could not complete the request. Try again."] = "リクエストを完了できませんでした。再試行してください。",
        ["Unknown album"] = "不明なアルバム",
        ["Unknown title"] = "不明なタイトル",
        ["Unknown artist"] = "不明なアーティスト",
        ["Playlist"] = "プレイリスト",
        ["Could not load"] = "読み込めませんでした",
        ["Retry"] = "再試行",
        ["Play these"] = "これらを再生",
        ["Favorite tracks"] = "お気に入りの曲",
        ["Favorite albums"] = "お気に入りのアルバム",
        ["Playlists"] = "プレイリスト",
        ["Quality"] = "音質",
        ["Sign in to Tidal"] = "Tidal にログイン",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "コード: %s\n\nスマートフォンで %s を開き、このコードを入力してください。\n\n入力を待っています。",
        ["Search tracks"] = "曲を検索",
        ["Search albums"] = "アルバムを検索",
        ["Search artists"] = "アーティストを検索",
        ["Sign in or log out"] = "ログイン / ログアウト",
        ["Tracks"] = "曲",
        ["Albums"] = "アルバム",
        ["Artists"] = "アーティスト",
    },
    nl = {
        ["Tidal needs a player build with remote playback"] = "Tidal vereist een spelerversie met afspelen op afstand",
        ["Lossless FLAC (CD)"] = "Lossless FLAC (CD)",
        ["High (AAC 320)"] = "Hoog (AAC 320)",
        ["Low (AAC 96)"] = "Laag (AAC 96)",
        ["Logged out of Tidal"] = "Uitgelogd bij Tidal",
        ["Nothing in this list can be streamed"] = "Niets in deze lijst kan worden gestreamd",
        ["No tracks"] = "Geen nummers",
        ["No albums"] = "Geen albums",
        ["No artists"] = "Geen artiesten",
        ["No playlists"] = "Geen afspeellijsten",
        ["No results"] = "Geen resultaten",
        ["Not available to stream"] = "Niet beschikbaar om te streamen",
        ["No stream link"] = "Geen streamlink",
        ["Still waiting for the phone"] = "Nog steeds wachten op de telefoon",
        ["Quality updated"] = "Kwaliteit bijgewerkt",
        ["This quality is unavailable. Choose Lossless."] = "Deze kwaliteit is niet beschikbaar. Kies Lossless.",
        ["Sign-in expired. Open the tile to try again."] = "Aanmelding verlopen. Open de tegel om opnieuw te proberen.",
        ["Code: %s"] = "Code: %s",
        ["Signed in to Tidal"] = "Aangemeld bij Tidal",
        ["Preparing playback"] = "Afspelen voorbereiden",
        ["Could not complete the request. Try again."] = "Verzoek mislukt. Probeer het opnieuw.",
        ["Unknown album"] = "Onbekend album",
        ["Unknown title"] = "Onbekende titel",
        ["Unknown artist"] = "Onbekende artiest",
        ["Playlist"] = "Afspeellijst",
        ["Could not load"] = "Laden mislukt",
        ["Retry"] = "Opnieuw proberen",
        ["Play these"] = "Deze afspelen",
        ["Favorite tracks"] = "Favoriete nummers",
        ["Favorite albums"] = "Favoriete albums",
        ["Playlists"] = "Afspeellijsten",
        ["Quality"] = "Kwaliteit",
        ["Sign in to Tidal"] = "Aanmelden bij Tidal",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "Code: %s\n\nOpen %s op een telefoon en voer deze code in.\n\nWachten op de telefoon.",
        ["Search tracks"] = "Nummers zoeken",
        ["Search albums"] = "Albums zoeken",
        ["Search artists"] = "Artiesten zoeken",
        ["Sign in or log out"] = "In- of uitloggen",
        ["Tracks"] = "Nummers",
        ["Albums"] = "Albums",
        ["Artists"] = "Artiesten",
    },
    pt = {
        ["Tidal needs a player build with remote playback"] = "O Tidal precisa de uma versão do reprodutor com reprodução remota",
        ["Lossless FLAC (CD)"] = "FLAC sem perdas (CD)",
        ["High (AAC 320)"] = "Alta (AAC 320)",
        ["Low (AAC 96)"] = "Baixa (AAC 96)",
        ["Logged out of Tidal"] = "Sessão encerrada no Tidal",
        ["Nothing in this list can be streamed"] = "Nada nesta lista pode ser reproduzido",
        ["No tracks"] = "Sem faixas",
        ["No albums"] = "Sem álbuns",
        ["No artists"] = "Sem artistas",
        ["No playlists"] = "Sem playlists",
        ["No results"] = "Sem resultados",
        ["Not available to stream"] = "Indisponível para streaming",
        ["No stream link"] = "Sem link de streaming",
        ["Still waiting for the phone"] = "Ainda aguardando o telefone",
        ["Quality updated"] = "Qualidade atualizada",
        ["This quality is unavailable. Choose Lossless."] = "Esta qualidade não está disponível. Escolha Sem perdas.",
        ["Sign-in expired. Open the tile to try again."] = "O login expirou. Abra o bloco para tentar novamente.",
        ["Code: %s"] = "Código: %s",
        ["Signed in to Tidal"] = "Conectado ao Tidal",
        ["Preparing playback"] = "Preparando reprodução",
        ["Could not complete the request. Try again."] = "Não foi possível concluir o pedido. Tente novamente.",
        ["Unknown album"] = "Álbum desconhecido",
        ["Unknown title"] = "Título desconhecido",
        ["Unknown artist"] = "Artista desconhecido",
        ["Playlist"] = "Playlist",
        ["Could not load"] = "Não foi possível carregar",
        ["Retry"] = "Tentar novamente",
        ["Play these"] = "Reproduzir estes",
        ["Favorite tracks"] = "Faixas favoritas",
        ["Favorite albums"] = "Álbuns favoritos",
        ["Playlists"] = "Playlists",
        ["Quality"] = "Qualidade",
        ["Sign in to Tidal"] = "Entrar no Tidal",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "Código: %s\n\nEm um telefone, abra %s e digite este código.\n\nAguardando o telefone.",
        ["Search tracks"] = "Buscar faixas",
        ["Search albums"] = "Buscar álbuns",
        ["Search artists"] = "Buscar artistas",
        ["Sign in or log out"] = "Entrar ou sair",
        ["Tracks"] = "Faixas",
        ["Albums"] = "Álbuns",
        ["Artists"] = "Artistas",
    },
    ru = {
        ["Tidal needs a player build with remote playback"] = "Для Tidal требуется сборка плеера с удалённым воспроизведением",
        ["Lossless FLAC (CD)"] = "FLAC без потерь (CD)",
        ["High (AAC 320)"] = "Высокое (AAC 320)",
        ["Low (AAC 96)"] = "Низкое (AAC 96)",
        ["Logged out of Tidal"] = "Вы вышли из Tidal",
        ["Nothing in this list can be streamed"] = "Ничего из этого списка нельзя воспроизвести",
        ["No tracks"] = "Нет треков",
        ["No albums"] = "Нет альбомов",
        ["No artists"] = "Нет исполнителей",
        ["No playlists"] = "Нет плейлистов",
        ["No results"] = "Нет результатов",
        ["Not available to stream"] = "Недоступно для потокового воспроизведения",
        ["No stream link"] = "Нет ссылки на поток",
        ["Still waiting for the phone"] = "Ожидание подтверждения с телефона",
        ["Quality updated"] = "Качество обновлено",
        ["This quality is unavailable. Choose Lossless."] = "Это качество недоступно. Выберите Без потерь.",
        ["Sign-in expired. Open the tile to try again."] = "Время входа истекло. Откройте плитку, чтобы повторить.",
        ["Code: %s"] = "Код: %s",
        ["Signed in to Tidal"] = "Вход в Tidal выполнен",
        ["Preparing playback"] = "Подготовка воспроизведения",
        ["Could not complete the request. Try again."] = "Не удалось выполнить запрос. Повторите попытку.",
        ["Unknown album"] = "Неизвестный альбом",
        ["Unknown title"] = "Неизвестное название",
        ["Unknown artist"] = "Неизвестный исполнитель",
        ["Playlist"] = "Плейлист",
        ["Could not load"] = "Не удалось загрузить",
        ["Retry"] = "Повторить",
        ["Play these"] = "Воспроизвести это",
        ["Favorite tracks"] = "Любимые треки",
        ["Favorite albums"] = "Любимые альбомы",
        ["Playlists"] = "Плейлисты",
        ["Quality"] = "Качество",
        ["Sign in to Tidal"] = "Войти в Tidal",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "Код: %s\n\nОткройте %s на телефоне и введите этот код.\n\nОжидание телефона.",
        ["Search tracks"] = "Поиск треков",
        ["Search albums"] = "Поиск альбомов",
        ["Search artists"] = "Поиск исполнителей",
        ["Sign in or log out"] = "Войти или выйти",
        ["Tracks"] = "Треки",
        ["Albums"] = "Альбомы",
        ["Artists"] = "Исполнители",
    },
    uk = {
        ["Tidal needs a player build with remote playback"] = "Для Tidal потрібна збірка плеєра з віддаленим відтворенням",
        ["Lossless FLAC (CD)"] = "FLAC без втрат (CD)",
        ["High (AAC 320)"] = "Висока (AAC 320)",
        ["Low (AAC 96)"] = "Низька (AAC 96)",
        ["Logged out of Tidal"] = "Ви вийшли з Tidal",
        ["Nothing in this list can be streamed"] = "Нічого з цього списку не можна відтворити",
        ["No tracks"] = "Немає треків",
        ["No albums"] = "Немає альбомів",
        ["No artists"] = "Немає виконавців",
        ["No playlists"] = "Немає списків відтворення",
        ["No results"] = "Немає результатів",
        ["Not available to stream"] = "Недоступно для потокового відтворення",
        ["No stream link"] = "Немає посилання на потік",
        ["Still waiting for the phone"] = "Очікування підтвердження з телефона",
        ["Quality updated"] = "Якість оновлено",
        ["This quality is unavailable. Choose Lossless."] = "Ця якість недоступна. Оберіть Без втрат.",
        ["Sign-in expired. Open the tile to try again."] = "Час входу минув. Відкрийте плитку, щоб повторити.",
        ["Code: %s"] = "Код: %s",
        ["Signed in to Tidal"] = "Вхід у Tidal виконано",
        ["Preparing playback"] = "Підготовка відтворення",
        ["Could not complete the request. Try again."] = "Не вдалося виконати запит. Спробуйте ще раз.",
        ["Unknown album"] = "Невідомий альбом",
        ["Unknown title"] = "Невідома назва",
        ["Unknown artist"] = "Невідомий виконавець",
        ["Playlist"] = "Список відтворення",
        ["Could not load"] = "Не вдалося завантажити",
        ["Retry"] = "Повторити",
        ["Play these"] = "Відтворити це",
        ["Favorite tracks"] = "Улюблені треки",
        ["Favorite albums"] = "Улюблені альбоми",
        ["Playlists"] = "Списки відтворення",
        ["Quality"] = "Якість",
        ["Sign in to Tidal"] = "Увійти в Tidal",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "Код: %s\n\nВідкрийте %s на телефоні та введіть цей код.\n\nОчікування телефона.",
        ["Search tracks"] = "Пошук треків",
        ["Search albums"] = "Пошук альбомів",
        ["Search artists"] = "Пошук виконавців",
        ["Sign in or log out"] = "Увійти або вийти",
        ["Tracks"] = "Треки",
        ["Albums"] = "Альбоми",
        ["Artists"] = "Виконавці",
    },
    vi = {
        ["Tidal needs a player build with remote playback"] = "Tidal cần bản dựng trình phát hỗ trợ phát từ xa",
        ["Lossless FLAC (CD)"] = "FLAC không nén (CD)",
        ["High (AAC 320)"] = "Cao (AAC 320)",
        ["Low (AAC 96)"] = "Thấp (AAC 96)",
        ["Logged out of Tidal"] = "Đã đăng xuất khỏi Tidal",
        ["Nothing in this list can be streamed"] = "Không thể phát mục nào trong danh sách này",
        ["No tracks"] = "Không có bài hát",
        ["No albums"] = "Không có album",
        ["No artists"] = "Không có nghệ sĩ",
        ["No playlists"] = "Không có danh sách phát",
        ["No results"] = "Không có kết quả",
        ["Not available to stream"] = "Không khả dụng để phát trực tuyến",
        ["No stream link"] = "Không có liên kết phát",
        ["Still waiting for the phone"] = "Vẫn đang chờ điện thoại",
        ["Quality updated"] = "Đã cập nhật chất lượng",
        ["This quality is unavailable. Choose Lossless."] = "Chất lượng này không khả dụng. Hãy chọn Không nén.",
        ["Sign-in expired. Open the tile to try again."] = "Đăng nhập đã hết hạn. Mở lại ô để thử lại.",
        ["Code: %s"] = "Mã: %s",
        ["Signed in to Tidal"] = "Đã đăng nhập vào Tidal",
        ["Preparing playback"] = "Đang chuẩn bị phát",
        ["Could not complete the request. Try again."] = "Không thể hoàn tất yêu cầu. Hãy thử lại.",
        ["Unknown album"] = "Album không rõ",
        ["Unknown title"] = "Tiêu đề không rõ",
        ["Unknown artist"] = "Nghệ sĩ không rõ",
        ["Playlist"] = "Danh sách phát",
        ["Could not load"] = "Không thể tải",
        ["Retry"] = "Thử lại",
        ["Play these"] = "Phát danh sách này",
        ["Favorite tracks"] = "Bài hát yêu thích",
        ["Favorite albums"] = "Album yêu thích",
        ["Playlists"] = "Danh sách phát",
        ["Quality"] = "Chất lượng",
        ["Sign in to Tidal"] = "Đăng nhập vào Tidal",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "Mã: %s\n\nTrên điện thoại, hãy mở %s và nhập mã này.\n\nĐang chờ điện thoại.",
        ["Search tracks"] = "Tìm bài hát",
        ["Search albums"] = "Tìm album",
        ["Search artists"] = "Tìm nghệ sĩ",
        ["Sign in or log out"] = "Đăng nhập hoặc đăng xuất",
        ["Tracks"] = "Bài hát",
        ["Albums"] = "Album",
        ["Artists"] = "Nghệ sĩ",
    },
    zh_CN = {
        ["Tidal needs a player build with remote playback"] = "Tidal 需要支持远程播放的播放器版本",
        ["Lossless FLAC (CD)"] = "无损 FLAC (CD)",
        ["High (AAC 320)"] = "高音质 (AAC 320)",
        ["Low (AAC 96)"] = "低音质 (AAC 96)",
        ["Logged out of Tidal"] = "已退出 Tidal",
        ["Nothing in this list can be streamed"] = "此列表中没有可播放的内容",
        ["No tracks"] = "没有曲目",
        ["No albums"] = "没有专辑",
        ["No artists"] = "没有艺术家",
        ["No playlists"] = "没有播放列表",
        ["No results"] = "没有结果",
        ["Not available to stream"] = "无法流式播放",
        ["No stream link"] = "没有流媒体链接",
        ["Still waiting for the phone"] = "仍在等待手机确认",
        ["Quality updated"] = "音质已更新",
        ["This quality is unavailable. Choose Lossless."] = "此音质不可用。请选择无损。",
        ["Sign-in expired. Open the tile to try again."] = "登录已过期。请重新打开磁贴重试。",
        ["Code: %s"] = "代码：%s",
        ["Signed in to Tidal"] = "已登录 Tidal",
        ["Preparing playback"] = "正在准备播放",
        ["Could not complete the request. Try again."] = "无法完成请求。请重试。",
        ["Unknown album"] = "未知专辑",
        ["Unknown title"] = "未知标题",
        ["Unknown artist"] = "未知艺术家",
        ["Playlist"] = "播放列表",
        ["Could not load"] = "无法加载",
        ["Retry"] = "重试",
        ["Play these"] = "播放这些",
        ["Favorite tracks"] = "喜爱的曲目",
        ["Favorite albums"] = "喜爱的专辑",
        ["Playlists"] = "播放列表",
        ["Quality"] = "音质",
        ["Sign in to Tidal"] = "登录 Tidal",
        ["Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."] = "代码：%s\n\n请在手机上打开 %s 并输入此代码。\n\n正在等待手机。",
        ["Search tracks"] = "搜索曲目",
        ["Search albums"] = "搜索专辑",
        ["Search artists"] = "搜索艺术家",
        ["Sign in or log out"] = "登录或退出",
        ["Tracks"] = "曲目",
        ["Albums"] = "专辑",
        ["Artists"] = "艺术家",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if not plugin.has_capability("playback.remote") then
    plugin.show_toast(tr("Tidal needs a player build with remote playback"))
    return
end

local API = "https://api.tidal.com/v1"
local AUTH = "https://auth.tidal.com/v1/oauth2"
-- The pair from the stock player's device login.
local CLIENT_ID = "8Ky7IQAz2AVnuy4x"
local CLIENT_SECRET = "TX6C2zpsS4JnmduzltEYEXnpM4NO8VrIuBCnhMHIHpo="
local IMAGES = "https://resources.tidal.com/images"
local SCOPE = "r_usr w_usr"
local CLIENT_VERSION = "2025.7.16"
local PAGE = 25
local BROWSE_CAP = 475 -- plus the "Play these" row, within show_list's 500 rows
local SEARCH_CAP = 100
local REMOTE_QUEUE_CAP = 500
local TRACK_FETCH_CAP = REMOTE_QUEUE_CAP
local remote_tracks = {}
local JSON_LIMIT = 524288
local QUALITIES = {
    { id = "LOSSLESS", label = "Lossless FLAC (CD)" },
    { id = "HIGH", label = "High (AAC 320)" },
    { id = "LOW", label = "Low (AAC 96)" },
}

local login = nil
local login_timer = nil
local login_busy = false
local login_starting = false
local login_generation = 0
local session_generation = 0
local playback_generation = 0
local browse_generation = 0

local B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function toast(message)
    message = tostring(message or "")
    if message == "Logged out of Tidal" or message == "Nothing in this list can be streamed"
        or message == "No tracks" or message == "No albums" or message == "No artists"
        or message == "No playlists" or message == "No results"
        or message == "Not available to stream" or message == "No stream link"
        or message == "Still waiting for the phone"
        or message == "Quality updated" or message == "This quality is unavailable. Choose Lossless."
        or message == "Sign-in expired. Open the tile to try again." then
        plugin.show_toast(tr(message))
    elseif message:match("^Code: ") then
        plugin.show_toast(string.format(tr("Code: %s"), message:sub(7)))
    elseif message:match("^Logged in as ") then
        plugin.show_toast(tr("Signed in to Tidal"))
    elseif message == "Preparing playback" then
        plugin.show_toast(tr(message))
    else
        plugin.show_toast(tr("Could not complete the request. Try again."))
    end
end

local function url_encode(text)
    return (tostring(text):gsub("[^%w%-%.%_%~]", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

local function stored(key)
    local value = plugin.storage.get(key)
    if value == nil or value == "" then return nil end
    return value
end

local function quality()
    local saved = stored("quality")
    for _, item in ipairs(QUALITIES) do
        if item.id == saved then return saved end
    end
    return "LOSSLESS"
end

local function quality_index()
    local current = quality()
    for i, item in ipairs(QUALITIES) do
        if item.id == current then return i end
    end
    return 1
end

local function country()
    return stored("country") or "US"
end

local function clip(text, limit)
    text = tostring(text or "")
    if #text > limit then return text:sub(1, limit - 3) .. "..." end
    return text
end

local function clip_utf8(text, limit)
    text = tostring(text or "")
    if #text <= limit then return text end
    local cut = limit - 3
    while cut > 0 do
        local next_byte = text:byte(cut + 1)
        if not next_byte or next_byte < 128 or next_byte >= 192 then break end
        cut = cut - 1
    end
    return text:sub(1, cut) .. "..."
end

local function b64decode(data)
    data = tostring(data or ""):gsub("%s", ""):gsub("=", "")
    if data == "" then return nil end
    local map = {}
    for i = 1, #B64 do map[B64:sub(i, i)] = i - 1 end
    local out = {}
    local acc = 0
    local bits = 0
    for i = 1, #data do
        local value = map[data:sub(i, i)]
        if not value then return nil end
        acc = acc * 64 + value
        bits = bits + 6
        if bits >= 8 then
            bits = bits - 8
            local weight = 2 ^ bits
            out[#out + 1] = string.char(math.floor(acc / weight) % 256)
            acc = acc % weight
        end
    end
    return table.concat(out)
end

local function image_url(uuid, pixels)
    if not uuid or uuid == "" then return "" end
    local slashed = {}
    for piece in tostring(uuid):gmatch("[^-]+") do slashed[#slashed + 1] = piece end
    if #slashed == 0 then return "" end
    return IMAGES .. "/" .. table.concat(slashed, "/") .. "/" .. pixels .. "x" .. pixels .. ".jpg"
end

local function api_message(body, status)
    local data = body and select(1, plugin.json_decode(body))
    if type(data) == "table" then
        if data.userMessage and data.userMessage ~= "" then return tostring(data.userMessage) end
        if data.error_description and data.error_description ~= "" then return tostring(data.error_description) end
        if data.error and data.error ~= "" then return tostring(data.error) end
    end
    return "Tidal answered HTTP " .. tostring(status)
end

local function form_post(url, form, callback)
    local handle = plugin.http_request({
        url = url,
        method = "POST",
        body = form,
        content_type = "application/x-www-form-urlencoded",
        total_timeout_ms = 20000,
        max_response_bytes = 262144,
    }, function(status, body, err)
        if err then
            callback(nil, nil, err)
            return
        end
        local data = nil
        if body and body ~= "" then data = select(1, plugin.json_decode(body)) end
        callback(status, data, nil, body)
    end)
    if not handle then callback(nil, nil, "request unavailable") end
end

local function save_tokens(data, keep_refresh)
    if not data or not data.access_token or data.access_token == "" then return false end
    plugin.storage.set("access_token", data.access_token)
    if data.refresh_token and data.refresh_token ~= "" then
        plugin.storage.set("refresh_token", data.refresh_token)
    elseif not keep_refresh then
        return false
    end
    local expires = tonumber(data.expires_in) or 0
    plugin.storage.set("expires_at", tostring(expires > 0 and (os.time() + expires) or 0))
    return true
end

-- plugin.json_decode() returns every JSON number as a float, so a plain
-- tostring() turns id 123 into "123.0", which breaks Tidal API paths.
local function id_string(value)
    if type(value) == "number" then
        local whole = math.tointeger(value)
        if whole then return tostring(whole) end
    end
    return tostring(value)
end

-- Sessions saved by 1.3.2 and earlier hold user_id as "123.0".
do
    local saved = stored("user_id")
    local whole = saved and saved:match("^(%d+)%.0$")
    if whole then plugin.storage.set("user_id", whole) end
end

local function save_user(user)
    if type(user) ~= "table" then return false end
    local id = user.userId or user.user_id
    if id == nil or id_string(id) == "" or id_string(id) == "0" then return false end
    plugin.storage.set("user_id", id_string(id))
    if user.countryCode and user.countryCode ~= "" then
        plugin.storage.set("country", tostring(user.countryCode))
    end
    local name = user.username or user.nickname or user.email or "Tidal"
    plugin.storage.set("display_name", tostring(name))
    return true
end

local function clear_session()
    session_generation = session_generation + 1
    browse_generation = browse_generation + 1
    plugin.storage.delete("access_token")
    plugin.storage.delete("refresh_token")
    plugin.storage.delete("expires_at")
    plugin.storage.delete("user_id")
    plugin.storage.delete("display_name")
end

local function token_fresh()
    local token = stored("access_token")
    if not token then return false end
    local expires = tonumber(stored("expires_at") or "0") or 0
    if expires == 0 then return true end
    return os.time() + 60 < expires
end

local function auth_headers()
    return {
        Authorization = "Bearer " .. (stored("access_token") or ""),
        ["x-tidal-client-version"] = CLIENT_VERSION,
    }
end

local refresh_token
local tidal_get

refresh_token = function(callback)
    local refresh = stored("refresh_token")
    local client_id = CLIENT_ID
    local client_secret = CLIENT_SECRET
    if not refresh or not client_id or not client_secret then
        callback(false, "Not signed in")
        return
    end
    local generation = session_generation
    local form = "grant_type=refresh_token&refresh_token=" .. url_encode(refresh)
        .. "&client_id=" .. url_encode(client_id)
        .. "&client_secret=" .. url_encode(client_secret)
    form_post(AUTH .. "/token", form, function(status, data, err, body)
        if generation ~= session_generation then return end
        if err then callback(false, err) return end
        if status ~= 200 or not save_tokens(data, true) then
            local oauth_error = type(data) == "table" and data.error or ""
            if status == 400 or status == 401 or status == 403 then
                if oauth_error == "invalid_grant" or status == 401 or status == 403 then clear_session() end
            end
            callback(false, api_message(body, status))
            return
        end
        callback(true)
    end)
end

tidal_get = function(path, callback, refreshed)
    local generation = session_generation
    local function send()
        local handle = plugin.http_request({
            url = API .. path,
            headers = auth_headers(),
            total_timeout_ms = 20000,
            max_response_bytes = JSON_LIMIT,
        }, function(status, body, err)
            if generation ~= session_generation then return end
            if err then callback(nil, err) return end
            if status == 401 and not refreshed then
                refresh_token(function(ok, why)
                    if generation ~= session_generation then return end
                    if not ok then callback(nil, why or "Session expired") return end
                    tidal_get(path, callback, true)
                end)
                return
            end
            if status ~= 200 then
                callback(nil, api_message(body, status))
                return
            end
            local data, decode_err = plugin.json_decode(body, { max_input_bytes = JSON_LIMIT })
            if type(data) ~= "table" then
                callback(nil, decode_err or "Tidal sent an unreadable reply")
                return
            end
            callback(data)
        end)
        if not handle then callback(nil, "request unavailable") end
    end

    if token_fresh() then
        send()
    else
        refresh_token(function(ok, why)
            if not ok then callback(nil, why or "Session expired") return end
            send()
        end)
    end
end

local function unwrap(entry)
    if type(entry) == "table" and type(entry.item) == "table" then return entry.item end
    return entry
end

local function items_of(node)
    if type(node) ~= "table" then return {} end
    local source = node.items or node
    if type(source) ~= "table" then return {} end
    local out = {}
    for _, entry in ipairs(source) do out[#out + 1] = unwrap(entry) end
    return out
end

local function person_name(obj)
    if type(obj) ~= "table" then return "" end
    if type(obj.artist) == "table" and obj.artist.name then return obj.artist.name end
    if type(obj.artists) == "table" and type(obj.artists[1]) == "table" then
        return obj.artists[1].name or ""
    end
    return ""
end

local function album_from(obj)
    if type(obj) ~= "table" or obj.id == nil then return nil end
    return {
        id = id_string(obj.id),
        title = obj.title or tr("Unknown album"),
        artist = person_name(obj),
        cover = image_url(obj.cover, 320),
        count = tonumber(obj.numberOfTracks) or 0,
    }
end

local function known_codec(value)
    if type(value) ~= "string" then return nil end
    value = value:lower()
    if value == "flac" or value == "mp3" or value == "aac" then return value end
    return nil
end

local function track_from(obj, album_hint)
    if type(obj) ~= "table" or obj.id == nil then return nil end
    local hint = album_hint or {}
    local album = type(obj.album) == "table" and obj.album or nil
    local album_id = ""
    if album and album.id ~= nil then album_id = id_string(album.id) end
    if album_id == "" then album_id = hint.id or "" end
    local cover = ""
    if album and album.cover then cover = image_url(album.cover, 320) end
    if cover == "" then cover = hint.cover or "" end
    local verify_tls
    if type(obj.verify_tls) == "boolean" then verify_tls = obj.verify_tls end
    local streamable = true
    if obj.allowStreaming == false or obj.streamReady == false then streamable = false end
    return {
        id = id_string(obj.id),
        title = obj.title or tr("Unknown title"),
        artist = person_name(obj) ~= "" and person_name(obj) or (hint.artist or tr("Unknown artist")),
        album = (album and album.title) or hint.title or "",
        album_id = album_id,
        cover = cover,
        duration = tonumber(obj.duration) or 0,
        sample_rate = tonumber(obj.sampleRate or obj.sample_rate),
        bit_depth = tonumber(obj.bitDepth or obj.bit_depth),
        channels = tonumber(obj.channels),
        bitrate_kbps = tonumber(obj.bitrateKbps or obj.bitrate_kbps),
        replaygain_db = tonumber(obj.replayGainDb or obj.replaygain_db),
        verify_tls = verify_tls,
        codec = known_codec(obj.codec),
        streamable = streamable,
    }
end

local function playlist_from(obj)
    if type(obj) ~= "table" or not obj.uuid then return nil end
    local cover = ""
    if type(obj.squareImage) == "string" then cover = image_url(obj.squareImage, 320) end
    return {
        id = tostring(obj.uuid),
        name = obj.title or tr("Playlist"),
        count = tonumber(obj.numberOfTracks) or 0,
        cover = cover,
    }
end

local show_list

local function show_rows(title, rows, on_pick)
    local labels = {}
    for i, row in ipairs(rows) do
        labels[i] = clip(row.label, 140)
    end
    return show_list(title, labels, function(index, handle)
        if rows[index] then on_pick(rows[index], handle) end
    end)
end

local function parent_showing(parent)
    return parent == nil or plugin.is_list_showing(parent)
end

local function show_browse_retry(parent, retry)
    if not parent_showing(parent) then return end
    local handle
    handle = plugin.show_list(tr("Could not load"), { tr("Retry") }, function(index)
        if index == 1 then retry(handle) end
    end)
    return handle
end

show_list = function(title, labels, on_select, options)
    local handle
    handle = plugin.show_list(title, labels, function(index)
        on_select(index, handle)
    end, options)
    return handle
end

local function codec_for(mime, codecs)
    mime = tostring(mime or ""):lower()
    codecs = tostring(codecs or ""):lower()
    if mime:find("flac") or codecs:find("flac") then return "flac" end
    if mime:find("aac") or codecs:find("aac") then return "aac" end
    if mime:find("mpeg") or mime:find("mp3") then return "mp3" end
    if mime:find("mp4") then return nil end
    return nil
end

local function stream_for(track, callback)
    local path = "/tracks/" .. url_encode(track.id)
        .. "/playbackinfopostpaywall?countryCode=" .. url_encode(country())
        .. "&audioquality=" .. quality()
        .. "&playbackmode=STREAM&assetpresentation=FULL"
    tidal_get(path, function(data, err)
        if not data then callback(nil, err) return end
        local manifest_mime = tostring(data.manifestMimeType or "")
        if manifest_mime:find("dash") then
            callback(nil, "This quality is unavailable. Choose Lossless.")
            return
        end
        local decoded = b64decode(data.manifest or "")
        local manifest = decoded and select(1, plugin.json_decode(decoded))
        if type(manifest) ~= "table" then
            callback(nil, "Tidal sent an unreadable manifest")
            return
        end
        if manifest.encryptionType and manifest.encryptionType ~= "" and manifest.encryptionType ~= "NONE" then
            callback(nil, "This track is encrypted")
            return
        end
        local url = type(manifest.urls) == "table" and manifest.urls[1] or nil
        if not url or url == "" then
            callback(nil, "No stream link")
            return
        end
        local stream_mime = tostring(manifest.mimeType or manifest_mime):lower()
        if stream_mime:find("mp4") then
            callback(nil, "This quality is unavailable. Choose Lossless.")
            return
        end
        local codec = codec_for(stream_mime, manifest.codecs)
        if not codec then
            callback(nil, "This quality is unavailable. Choose Lossless.")
            return
        end
        callback({
            provider = "tidal",
            track_id = track.id,
            stream_url = url,
            title = clip_utf8(track.title, 127),
            artist = clip_utf8(track.artist, 127),
            album = clip_utf8(track.album, 127),
            duration_ms = math.floor((track.duration or 0) * 1000),
            artwork_url = track.cover,
            codec = codec,
            sample_rate = tonumber(data.sampleRate) or track.sample_rate or 0,
            bit_depth = tonumber(data.bitDepth) or track.bit_depth or 16,
            channels = tonumber(data.channels) or track.channels,
            bitrate_kbps = tonumber(data.bitrateKbps or data.bitrate_kbps) or track.bitrate_kbps,
        })
    end)
end

-- Maps this plugin's English errors to player reason codes, which the
-- player shows translated.
local function error_reason(err)
    err = tostring(err or "")
    if err:find("subscription") then return "subscription" end
    if err:find("quality") then return "quality" end
    if err:find("encrypted") then return "protected" end
    if err:find("unavailable") or err:find("no longer available") then return "unavailable" end
    if err:find("[Ss]ign") or err:find("[Ss]ession") or err:find("[Ll]og") then return "auth" end
    return nil
end

local function on_remote_stream_needed(provider, track_id, request_id)
    if provider ~= "tidal" then return end
    -- After a plugin reload the queue outlives remote_tracks; the id is enough.
    local track = remote_tracks[tostring(track_id)] or { id = track_id }
    local generation = playback_generation
    stream_for(track, function(remote, err)
        if generation ~= playback_generation then
            plugin.provide_remote_stream(request_id, { error = "Playback request was replaced" })
            return
        end
        if not remote then
            plugin.provide_remote_stream(request_id, { error = err or "No stream link", reason = error_reason(err) })
            return
        end
        plugin.provide_remote_stream(request_id, {
            stream_url = remote.stream_url,
            codec = remote.codec,
            sample_rate = remote.sample_rate,
            bit_depth = remote.bit_depth,
            channels = remote.channels,
            bitrate_kbps = remote.bitrate_kbps,
            url_ttl_s = 60,
        })
    end)
end
plugin.on("remote_stream_needed", on_remote_stream_needed)

local function queue_on_demand(tracks, start_index, require_selected)
    playback_generation = playback_generation + 1
    local generation = playback_generation
    local start = start_index or 1
    local first = tracks[start]
    if require_selected and first and first.streamable == false then
        toast("Not available to stream")
        return
    end
    local ordered = {}
    local function append_range(from, to)
        for i = from, to do
            local track = tracks[i]
            if track.streamable ~= false then ordered[#ordered + 1] = track end
            if #ordered >= REMOTE_QUEUE_CAP then return true end
        end
        return false
    end
    if append_range(start, #tracks) then
        -- The queue cap was reached after the selected track.
    elseif start > 1 then
        append_range(1, start - 1)
    end
    if #ordered == 0 then
        toast("Nothing in this list can be streamed")
        return
    end
    remote_tracks = {}
    local queue = {}
    for _, track in ipairs(ordered) do
        local id = tostring(track.id)
        remote_tracks[id] = {
            id = track.id,
            title = clip_utf8(track.title, 127),
            artist = clip_utf8(track.artist, 127),
            album = clip_utf8(track.album, 127),
            duration = track.duration,
            cover = track.cover,
            sample_rate = track.sample_rate,
            bit_depth = track.bit_depth,
            channels = track.channels,
            bitrate_kbps = track.bitrate_kbps,
        }
        queue[#queue + 1] = {
            provider = "tidal",
            track_id = id,
            title = track.title,
            artist = track.artist,
            album = track.album,
            duration_ms = math.floor((tonumber(track.duration) or 0) * 1000),
            artwork_url = track.cover,
            sample_rate = track.sample_rate,
            bit_depth = track.bit_depth,
            channels = track.channels,
            bitrate_kbps = track.bitrate_kbps,
            replaygain_db = track.replaygain_db,
            verify_tls = track.verify_tls,
            codec = track.codec,
        }
    end
    if generation ~= playback_generation then return end
    plugin.queue_remote_list(queue, 1)
end

local function play_these(tracks, require_selected, start_index)
    queue_on_demand(tracks, start_index or 1, require_selected)
end

local function track_rows(list, album_hint)
    local rows = {}
    for _, obj in ipairs(list) do
        local track = track_from(obj, album_hint)
        if track then
            track.label = track.title .. " - " .. track.artist
            rows[#rows + 1] = track
        end
    end
    return rows
end

local function show_tracks(title, rows)
    if #rows == 0 then toast("No tracks") return end
    local shown = { { label = tr("Play these"), play_all = true } }
    for i = 1, math.min(#rows, BROWSE_CAP) do shown[#shown + 1] = rows[i] end
    show_rows(title, shown, function(row)
        if row.play_all then
            play_these(rows)
        else
            local selected_index
            for i, candidate in ipairs(rows) do
                if candidate == row then selected_index = i; break end
            end
            if selected_index then
                play_these(rows, true, selected_index)
            end
        end
    end)
end

local function open_album(album, offset, depth, parent)
    offset = offset or 0
    local generation, all = browse_generation, {}
    local function fetch(page_offset, active_handle)
        tidal_get("/albums/" .. url_encode(album.id) .. "/tracks?countryCode=" .. url_encode(country())
            .. "&limit=" .. PAGE .. "&offset=" .. page_offset, function(data, err)
            if generation ~= browse_generation or not parent_showing(active_handle or parent) then return end
            if not data then
                toast(err)
                show_browse_retry(active_handle or parent, function(retry_handle) fetch(page_offset, retry_handle) end)
                return
            end
            local page = items_of(data)
            for _, obj in ipairs(page) do all[#all + 1] = obj end
            if #page == PAGE and #all < TRACK_FETCH_CAP then fetch(page_offset + PAGE, active_handle)
            else show_tracks(album.title, track_rows(all, album)) end
        end)
    end
    fetch(offset)
end

local function show_albums(title, albums, depth)
    if #albums == 0 then toast("No albums") return end
    local rows = {}
    for _, album in ipairs(albums) do
        album.label = album.title .. (album.artist ~= "" and (" - " .. album.artist) or "")
        rows[#rows + 1] = album
    end
    show_rows(title, rows, function(album, parent)
        if (depth or 2) < 4 then open_album(album, 0, (depth or 2) + 1, parent) end
    end)
end

local function open_playlist(playlist, offset, depth, parent)
    offset = offset or 0
    local generation, all = browse_generation, {}
    local function fetch(page_offset, active_handle)
        tidal_get("/playlists/" .. url_encode(playlist.id) .. "/tracks?countryCode=" .. url_encode(country())
            .. "&limit=" .. PAGE .. "&offset=" .. page_offset, function(data, err)
            if generation ~= browse_generation or not parent_showing(active_handle or parent) then return end
            if not data then
                toast(err)
                show_browse_retry(active_handle or parent, function(retry_handle) fetch(page_offset, retry_handle) end)
                return
            end
            local page = items_of(data)
            for _, obj in ipairs(page) do all[#all + 1] = obj end
            if #page == PAGE and #all < TRACK_FETCH_CAP then fetch(page_offset + PAGE, active_handle)
            else show_tracks(playlist.name, track_rows(all)) end
        end)
    end
    fetch(offset)
end

-- Fetches up to cap items in pages of PAGE into one list, so paging never
-- adds a screen. done(items, data) runs only while parent is still in front.
local function fetch_pages(path_for, items_of_page, start, cap, parent, done)
    local generation, all = browse_generation, {}
    local function fetch(offset, active_handle)
        tidal_get(path_for(offset), function(data, err)
            if generation ~= browse_generation or not parent_showing(active_handle or parent) then return end
            if not data then
                toast(err)
                show_browse_retry(active_handle or parent, function(retry_handle) fetch(offset, retry_handle) end)
                return
            end
            local page = items_of_page(data)
            for _, obj in ipairs(page) do all[#all + 1] = obj end
            if #page == PAGE and #all < cap then fetch(offset + PAGE, active_handle) else done(all) end
        end)
    end
    fetch(start)
end

local function search_kind(kind, query, offset, build, title, open, depth, parent)
    depth = depth or 2
    fetch_pages(function(page_offset)
        return "/search/" .. kind .. "?countryCode=" .. url_encode(country())
            .. "&query=" .. url_encode(query) .. "&limit=" .. PAGE .. "&offset=" .. page_offset
    end, function(data)
        return items_of(type(data[kind]) == "table" and data[kind] or data)
    end, offset, SEARCH_CAP, parent, function(list)
        local rows = build(list)
        if #rows == 0 then toast("No results"); return end
        if open then
            show_rows(title, rows, function(row, handle)
                if depth < 4 then open(row, depth + 1, handle) end
            end)
        else
            show_tracks(title, rows)
        end
    end)
end

local function ask_query(title, go, parent)
    -- The text input is still in front while this runs; the search checks
    -- parent when its results arrive.
    local ok, err = plugin.show_text_input(title, nil, false, function(query)
        if not query or query == "" then return end
        go(query, 0, parent)
    end)
    if ok == false then toast(err or "Text input is busy") end
end

local function favorites_path(kind)
    return function(offset)
        return "/users/" .. url_encode(stored("user_id")) .. "/favorites/" .. kind .. "?countryCode="
            .. url_encode(country()) .. "&limit=" .. PAGE .. "&offset=" .. offset
            .. "&order=DATE&orderDirection=DESC"
    end
end

local function favorite_tracks(depth, parent)
    if not stored("user_id") then toast("This account has no user id"); return end
    fetch_pages(favorites_path("tracks"), items_of, 0, BROWSE_CAP, parent, function(list)
        show_tracks(tr("Favorite tracks"), track_rows(list))
    end)
end

local function favorite_albums(depth, parent)
    if not stored("user_id") then toast("This account has no user id"); return end
    fetch_pages(favorites_path("albums"), items_of, 0, BROWSE_CAP, parent, function(list)
        local albums = {}
        for _, obj in ipairs(list) do
            local album = album_from(obj)
            if album then albums[#albums + 1] = album end
        end
        show_albums(tr("Favorite albums"), albums, depth)
    end)
end

local function show_playlists(depth, parent)
    local user = stored("user_id")
    if not user then toast("This account has no user id"); return end
    fetch_pages(function(offset)
        return "/users/" .. url_encode(user) .. "/playlists?countryCode=" .. url_encode(country())
            .. "&limit=" .. PAGE .. "&offset=" .. offset
    end, items_of, 0, BROWSE_CAP, parent, function(list)
        local rows = {}
        for _, obj in ipairs(list) do
            local playlist = playlist_from(obj)
            if playlist then playlist.label = playlist.name; rows[#rows + 1] = playlist end
        end
        if #rows == 0 then toast("No playlists"); return end
        show_rows(tr("Playlists"), rows, function(playlist, handle)
            if depth < 4 then open_playlist(playlist, 0, depth + 1, handle) end
        end)
    end)
end

local function open_artist(artist, offset, depth, parent)
    depth = depth or 3
    local generation, albums = browse_generation, {}
    local function fetch(page_offset, active_handle)
        tidal_get("/artists/" .. url_encode(artist.id) .. "/albums?countryCode="
            .. url_encode(country()) .. "&limit=" .. PAGE .. "&offset=" .. page_offset, function(data, err)
            if generation ~= browse_generation or not parent_showing(active_handle or parent) then return end
            if not data then
                toast(err)
                show_browse_retry(active_handle or parent, function(retry_handle) fetch(page_offset, retry_handle) end)
                return
            end
            local page = items_of(data)
            for _, obj in ipairs(page) do
                local album = album_from(obj)
                if album then albums[#albums + 1] = album end
            end
            if #page == PAGE and #albums < BROWSE_CAP then fetch(page_offset + PAGE, active_handle)
            else show_albums(artist.name, albums, depth) end
        end)
    end
    fetch(offset or 0)
end

local function choose_quality(parent)
    if not parent_showing(parent) then return end
    local labels = {}
    for i, item in ipairs(QUALITIES) do labels[i] = tr(item.label) end
    show_list(tr("Quality"), labels, function(index)
        plugin.storage.set("quality", QUALITIES[index].id)
        toast("Quality updated")
    end, { selected = quality_index() })
end

local function stop_login(message)
    login_generation = login_generation + 1
    login_starting = false
    if login_timer then
        plugin.clear_interval(login_timer)
        login_timer = nil
    end
    login = nil
    login_busy = false
    if message then toast(message) end
end

local function poll_login()
    if not login or login_busy then return end
    if os.time() > login.deadline then
        stop_login("Sign-in expired. Open the tile to try again.")
        return
    end
    login_busy = true
    local generation = login_generation
    local form = "client_id=" .. url_encode(CLIENT_ID)
        .. "&client_secret=" .. url_encode(CLIENT_SECRET)
        .. "&device_code=" .. url_encode(login.device_code)
        .. "&grant_type=" .. url_encode("urn:ietf:params:oauth:grant-type:device_code")
        .. "&scope=" .. url_encode(SCOPE)
    form_post(AUTH .. "/token", form, function(status, data, err, body)
        if generation ~= login_generation then return end
        login_busy = false
        if not login then return end
        if err then
            stop_login(err)
            return
        end
        if status == 200 and type(data) == "table" then
            if not save_tokens(data, false) or not save_user(data.user) then
                stop_login("Tidal signed in, but the account id was missing")
                return
            end
            session_generation = session_generation + 1
            browse_generation = browse_generation + 1
            local name = stored("display_name") or "Tidal"
            stop_login("Logged in as " .. name)
            return
        end
        local reason = type(data) == "table" and data.error or ""
        local sub = type(data) == "table" and tonumber(data.sub_status or data.subStatus) or 0
        if reason == "authorization_pending" or sub == 1002 then return end
        if reason == "expired_token" or reason == "expired" then
            stop_login("Sign-in expired. Open the tile to try again.")
            return
        end
        stop_login(api_message(body, status))
    end)
end

local show_home -- defined below, used by earlier screens

local function begin_login()
    if login_timer or login_starting then
        toast("Still waiting for the phone")
        return
    end
    stop_login()
    login_starting = true
    login_generation = login_generation + 1
    local generation = login_generation
    local form = "client_id=" .. url_encode(CLIENT_ID) .. "&scope=" .. url_encode(SCOPE)
    form_post(AUTH .. "/device_authorization", form, function(status, data, err)
        if generation ~= login_generation then return end
        login_starting = false
        if err then toast(err) return end
        if status ~= 200 or type(data) ~= "table" or not data.deviceCode or not data.userCode then
            toast(type(data) == "table" and (data.error_description or data.error) or "Tidal did not give a code")
            return
        end
        local where = data.verificationUriComplete or data.verificationUri or "link.tidal.com"
        if where:sub(1, 4) ~= "http" then where = "https://" .. where end
        local interval = tonumber(data.interval) or 2
        if interval < 2 then interval = 2 end
        login = {
            device_code = data.deviceCode,
            deadline = os.time() + (tonumber(data.expiresIn) or 300),
        }
        local shown = plugin.show_text_view(tr("Sign in to Tidal"),
            string.format(tr("Code: %s\n\nOn a phone, open %s and enter this code.\n\nWaiting for the phone."),
                tostring(data.userCode), where))
        if shown == false then
            stop_login("Could not show sign-in instructions. Try again.")
            return
        end
        login_timer = plugin.set_interval(interval, poll_login)
    end)
end

show_home = function()
    show_list(tr("Tidal"), {
        tr("Search tracks"),
        tr("Search albums"),
        tr("Search artists"),
        tr("Favorite tracks"),
        tr("Favorite albums"),
        tr("Playlists"),
        tr("Quality"),
        tr("Sign in or log out"),
    }, function(index, handle)
        if index >= 1 and index <= 6 and not stored("refresh_token") then
            begin_login()
            return
        end
        if index == 1 then
            ask_query(tr("Search tracks"), function(query, offset, parent)
                search_kind("tracks", query, offset, function(list) return track_rows(list) end, tr("Tracks"), nil, 2, parent)
            end, handle)
        elseif index == 2 then
            ask_query(tr("Search albums"), function(query, offset, parent)
                search_kind("albums", query, offset, function(list)
                    local rows = {}
                    for _, obj in ipairs(list) do
                        local album = album_from(obj)
                        if album then
                            album.label = album.title .. (album.artist ~= "" and (" - " .. album.artist) or "")
                            rows[#rows + 1] = album
                        end
                    end
                    return rows
                end, tr("Albums"), function(album, depth, list_handle) open_album(album, 0, depth, list_handle) end, 2, parent)
            end, handle)
        elseif index == 3 then
            ask_query(tr("Search artists"), function(query, offset, parent)
                search_kind("artists", query, offset, function(list)
                    local rows = {}
                    for _, obj in ipairs(list) do
                        if type(obj) == "table" and obj.id ~= nil then
                            rows[#rows + 1] = {
                                id = id_string(obj.id),
                                name = obj.name or tr("Unknown artist"),
                                label = obj.name or tr("Unknown artist"),
                            }
                        end
                    end
                    return rows
                end, tr("Artists"), function(artist, depth, list_handle) open_artist(artist, 0, depth, list_handle) end, 2, parent)
            end, handle)
        elseif index == 4 then favorite_tracks(2, handle)
        elseif index == 5 then favorite_albums(2, handle)
        elseif index == 6 then show_playlists(2, handle)
        elseif index == 7 then choose_quality(handle)
        else
            if stored("refresh_token") then
                login_generation = login_generation + 1
                login_starting = false
                playback_generation = playback_generation + 1
                clear_session()
                toast("Logged out of Tidal")
            else
                begin_login()
            end
        end
    end)
end

local function open_tidal()
    if login_timer or login_starting then
        toast("Still waiting for the phone")
        return
    end
    if not stored("refresh_token") then
        show_home()
        begin_login()
        return
    end
    show_home()
end

plugin.register_stream_media_tile(tr("Tidal"), open_tidal, "stream_media/tidal_row.png")
