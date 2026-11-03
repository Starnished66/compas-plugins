--[[
Qobuz, for a paid account you already have.

Sign in with the account email and password. The password is not saved.
The app id is the one shipped in the stock player, so opening the tile
goes straight to sign-in.

The Stream Media row uses the player's own stream_media/qobuz_row.png, the same
theme-relative icon path Net Radio and Podcasts pass to
plugin.register_stream_media_tile().

Playback uses API 17 native remote queues and resolves fresh stream links on
demand for up to 500 tracks. A selected row starts first, then follows and
wraps through the available collection. Stream format and server support
determine the available quality and seeking behavior.

Copy Qobuz.lua to <SD card>/.plugins/ and restart.
]]

plugin.define({
    id = "community.qobuz",
    name = "Qobuz",
    version = "1.4.0",
    api_min = 19,
})

local T = {
    de = {
        ["Qobuz needs a player build with remote playback"] = "Qobuz erfordert eine Firmware mit Remote-Wiedergabe",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16 Bit / 44,1 kHz)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC bis zu 24/96",
        ["FLAC up to 24/192"] = "FLAC bis zu 24/192",
        ["Logged out of Qobuz"] = "Bei Qobuz abgemeldet",
        ["Nothing in this list can be streamed"] = "Nichts in dieser Liste kann gestreamt werden",
        ["Signed in to Qobuz"] = "Bei Qobuz angemeldet",
        ["Preparing playback"] = "Wiedergabe wird vorbereitet",
        ["No tracks"] = "Keine Titel",
        ["No albums"] = "Keine Alben",
        ["No artists"] = "Keine Künstler",
        ["No playlists"] = "Keine Wiedergabelisten",
        ["Quality updated"] = "Qualität aktualisiert",
        ["This track is unavailable"] = "Dieser Titel ist nicht verfügbar",
        ["Qobuz returned no stream link"] = "Qobuz hat keinen Stream-Link geliefert",
        ["Qobuz returned invalid JSON"] = "Qobuz hat ungültiges JSON geliefert",
        ["Could not complete the request. Try again."] = "Anfrage fehlgeschlagen. Bitte erneut versuchen.",
        ["Qobuz request failed"] = "Qobuz-Anfrage fehlgeschlagen",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401: Sitzung abgelehnt; bitte neu anmelden",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403: Zugriff verweigert; Konto oder Abo prüfen",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429: Zu viele Anfragen; später erneut versuchen",
        ["%s (API code %s)"] = "%s (API-Code %s)",
        ["Qobuz API error (HTTP %s, code %s)"] = "Qobuz-API-Fehler (HTTP %s, Code %s)",
        ["Qobuz API error (HTTP %s)"] = "Qobuz-API-Fehler (HTTP %s)",
        ["Qobuz network: %s"] = "Qobuz-Netzwerk: %s",
        ["Qobuz network: request failed"] = "Qobuz-Netzwerk: Anfrage fehlgeschlagen",
        ["invalid URL"] = "ungültige URL",
        ["invalid request"] = "ungültige Anfrage",
        ["DNS lookup failed"] = "DNS-Auflösung fehlgeschlagen",
        ["connection failed"] = "Verbindung fehlgeschlagen",
        ["connection timed out"] = "Zeitüberschreitung bei Verbindung",
        ["TLS connection failed"] = "TLS-Verbindung fehlgeschlagen",
        ["request timed out"] = "Zeitüberschreitung der Anfrage",
        ["request cancelled"] = "Anfrage abgebrochen",
        ["too many redirects"] = "zu viele Weiterleitungen",
        ["response too large"] = "Antwort zu groß",
        ["malformed HTTP response"] = "ungültige HTTP-Antwort",
        ["network I/O failed"] = "Netzwerk-E/A fehlgeschlagen",
        ["insecure redirect refused"] = "unsichere Weiterleitung abgelehnt",
        ["player HTTP request limit reached"] = "HTTP-Anfragelimit erreicht",
        ["player could not start the request"] = "Anfrage konnte nicht gestartet werden",
        ["Unknown title"] = "Unbekannter Titel",
        ["Unknown artist"] = "Unbekannter Künstler",
        ["Unknown album"] = "Unbekanntes Album",
        ["Playlist"] = "Wiedergabeliste",
        ["Could not load"] = "Laden fehlgeschlagen",
        ["Retry"] = "Wiederholen",
        ["Play these"] = "Diese abspielen",
        ["Albums"] = "Alben",
        ["Tracks"] = "Titel",
        ["Artists"] = "Künstler",
        ["Favorite tracks"] = "Lieblingstitel",
        ["Favorite albums"] = "Lieblingsalben",
        ["Playlists"] = "Wiedergabelisten",
        ["New releases"] = "Neuerscheinungen",
        ["Quality"] = "Qualität",
        ["Search tracks"] = "Titel suchen",
        ["Search albums"] = "Alben suchen",
        ["Search artists"] = "Künstler suchen",
        ["Sign in or log out"] = "An- oder abmelden",
        ["Qobuz email"] = "Qobuz-E-Mail",
        ["Qobuz password"] = "Qobuz-Passwort",
    },
    es = {
        ["Qobuz needs a player build with remote playback"] = "Qobuz necesita una versión con reproducción remota",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16 bits / 44.1 kHz)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC hasta 24/96",
        ["FLAC up to 24/192"] = "FLAC hasta 24/192",
        ["Logged out of Qobuz"] = "Sesión cerrada en Qobuz",
        ["Nothing in this list can be streamed"] = "Nada de esta lista se puede reproducir",
        ["Signed in to Qobuz"] = "Sesión iniciada en Qobuz",
        ["Preparing playback"] = "Preparando reproducción",
        ["No tracks"] = "Sin pistas",
        ["No albums"] = "Sin álbumes",
        ["No artists"] = "Sin artistas",
        ["No playlists"] = "Sin listas",
        ["Quality updated"] = "Calidad actualizada",
        ["This track is unavailable"] = "Esta pista no está disponible",
        ["Qobuz returned no stream link"] = "Qobuz no devolvió enlace de transmisión",
        ["Qobuz returned invalid JSON"] = "Qobuz devolvió JSON no válido",
        ["Could not complete the request. Try again."] = "No se pudo completar la solicitud. Inténtalo de nuevo.",
        ["Qobuz request failed"] = "Falló la solicitud a Qobuz",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401: sesión rechazada; inicia sesión de nuevo",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403: acceso denegado; revisa tu cuenta o suscripción",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429: límite de solicitudes; inténtalo más tarde",
        ["%s (API code %s)"] = "%s (código API %s)",
        ["Qobuz API error (HTTP %s, code %s)"] = "Error de API de Qobuz (HTTP %s, código %s)",
        ["Qobuz API error (HTTP %s)"] = "Error de API de Qobuz (HTTP %s)",
        ["Qobuz network: %s"] = "Red Qobuz: %s",
        ["Qobuz network: request failed"] = "Red Qobuz: falló la solicitud",
        ["invalid URL"] = "URL no válida",
        ["invalid request"] = "solicitud no válida",
        ["DNS lookup failed"] = "falló la búsqueda DNS",
        ["connection failed"] = "falló la conexión",
        ["connection timed out"] = "tiempo de conexión agotado",
        ["TLS connection failed"] = "falló la conexión TLS",
        ["request timed out"] = "tiempo de solicitud agotado",
        ["request cancelled"] = "solicitud cancelada",
        ["too many redirects"] = "demasiadas redirecciones",
        ["response too large"] = "respuesta demasiado grande",
        ["malformed HTTP response"] = "respuesta HTTP mal formada",
        ["network I/O failed"] = "falló la E/S de red",
        ["insecure redirect refused"] = "redirección insegura rechazada",
        ["player HTTP request limit reached"] = "límite de solicitudes HTTP alcanzado",
        ["player could not start the request"] = "no se pudo iniciar la solicitud",
        ["Unknown title"] = "Título desconocido",
        ["Unknown artist"] = "Artista desconocido",
        ["Unknown album"] = "Álbum desconocido",
        ["Playlist"] = "Lista",
        ["Could not load"] = "No se pudo cargar",
        ["Retry"] = "Reintentar",
        ["Play these"] = "Reproducir todo",
        ["Albums"] = "Álbumes",
        ["Tracks"] = "Pistas",
        ["Artists"] = "Artistas",
        ["Favorite tracks"] = "Pistas favoritas",
        ["Favorite albums"] = "Álbumes favoritos",
        ["Playlists"] = "Listas",
        ["New releases"] = "Novedades",
        ["Quality"] = "Calidad",
        ["Search tracks"] = "Buscar pistas",
        ["Search albums"] = "Buscar álbumes",
        ["Search artists"] = "Buscar artistas",
        ["Sign in or log out"] = "Iniciar o cerrar sesión",
        ["Qobuz email"] = "Correo de Qobuz",
        ["Qobuz password"] = "Contraseña de Qobuz",
    },
    fi = {
        ["Qobuz needs a player build with remote playback"] = "Qobuz vaatii ohjelmistoversion etätoistolla",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16-bit / 44,1 kHz)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC enintään 24/96",
        ["FLAC up to 24/192"] = "FLAC enintään 24/192",
        ["Logged out of Qobuz"] = "Kirjauduttu ulos Qobuzista",
        ["Nothing in this list can be streamed"] = "Mitään tältä listalta ei voi suoratoistaa",
        ["Signed in to Qobuz"] = "Kirjauduttu Qobuziin",
        ["Preparing playback"] = "Valmistellaan toistoa",
        ["No tracks"] = "Ei kappaleita",
        ["No albums"] = "Ei albumeita",
        ["No artists"] = "Ei esittäjiä",
        ["No playlists"] = "Ei soittolistoja",
        ["Quality updated"] = "Laatu päivitetty",
        ["This track is unavailable"] = "Tämä kappale ei ole saatavilla",
        ["Qobuz returned no stream link"] = "Qobuz ei palauttanut suoratoistolinkkiä",
        ["Qobuz returned invalid JSON"] = "Qobuz palautti virheellisen JSON-vastauksen",
        ["Could not complete the request. Try again."] = "Pyyntöä ei voitu suorittaa. Yritä uudelleen.",
        ["Qobuz request failed"] = "Qobuz-pyyntö epäonnistui",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401: istunto hylätty; kirjaudu uudelleen",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403: pääsy evätty; tarkista tili tai tilaus",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429: liikaa pyyntöjä; yritä myöhemmin",
        ["%s (API code %s)"] = "%s (API-koodi %s)",
        ["Qobuz API error (HTTP %s, code %s)"] = "Qobuz-API-virhe (HTTP %s, koodi %s)",
        ["Qobuz API error (HTTP %s)"] = "Qobuz-API-virhe (HTTP %s)",
        ["Qobuz network: %s"] = "Qobuz-verkko: %s",
        ["Qobuz network: request failed"] = "Qobuz-verkko: pyyntö epäonnistui",
        ["invalid URL"] = "virheellinen URL",
        ["invalid request"] = "virheellinen pyyntö",
        ["DNS lookup failed"] = "DNS-haku epäonnistui",
        ["connection failed"] = "yhteys epäonnistui",
        ["connection timed out"] = "yhteyden aikakatkaisu",
        ["TLS connection failed"] = "TLS-yhteys epäonnistui",
        ["request timed out"] = "pyynnön aikakatkaisu",
        ["request cancelled"] = "pyyntö peruutettu",
        ["too many redirects"] = "liikaa uudelleenohjauksia",
        ["response too large"] = "vastaus liian suuri",
        ["malformed HTTP response"] = "virheellinen HTTP-vastaus",
        ["network I/O failed"] = "verkon I/O epäonnistui",
        ["insecure redirect refused"] = "suojaamaton uudelleenohjaus estetty",
        ["player HTTP request limit reached"] = "HTTP-pyyntöraja saavutettu",
        ["player could not start the request"] = "pyyntöä ei voitu käynnistää",
        ["Unknown title"] = "Tuntematon kappale",
        ["Unknown artist"] = "Tuntematon esittäjä",
        ["Unknown album"] = "Tuntematon albumi",
        ["Playlist"] = "Soittolista",
        ["Could not load"] = "Lataus epäonnistui",
        ["Retry"] = "Yritä uudelleen",
        ["Play these"] = "Toista nämä",
        ["Albums"] = "Albumit",
        ["Tracks"] = "Kappaleet",
        ["Artists"] = "Esittäjät",
        ["Favorite tracks"] = "Suosikkikappaleet",
        ["Favorite albums"] = "Suosikkialbumit",
        ["Playlists"] = "Soittolistat",
        ["New releases"] = "Uutuudet",
        ["Quality"] = "Laatu",
        ["Search tracks"] = "Hae kappaleita",
        ["Search albums"] = "Hae albumeita",
        ["Search artists"] = "Hae esittäjiä",
        ["Sign in or log out"] = "Kirjaudu sisään tai ulos",
        ["Qobuz email"] = "Qobuz-sähköposti",
        ["Qobuz password"] = "Qobuz-salasana",
    },
    fr = {
        ["Qobuz needs a player build with remote playback"] = "Qobuz nécessite un lecteur avec lecture à distance",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16 bits / 44,1 kHz)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC jusqu'à 24/96",
        ["FLAC up to 24/192"] = "FLAC jusqu'à 24/192",
        ["Logged out of Qobuz"] = "Déconnecté de Qobuz",
        ["Nothing in this list can be streamed"] = "Rien dans cette liste ne peut être lu",
        ["Signed in to Qobuz"] = "Connecté à Qobuz",
        ["Preparing playback"] = "Préparation de la lecture",
        ["No tracks"] = "Aucune piste",
        ["No albums"] = "Aucun album",
        ["No artists"] = "Aucun artiste",
        ["No playlists"] = "Aucune liste de lecture",
        ["Quality updated"] = "Qualité mise à jour",
        ["This track is unavailable"] = "Cette piste est indisponible",
        ["Qobuz returned no stream link"] = "Qobuz n'a renvoyé aucun lien de flux",
        ["Qobuz returned invalid JSON"] = "Qobuz a renvoyé du JSON invalide",
        ["Could not complete the request. Try again."] = "Impossible de terminer la requête. Réessayez.",
        ["Qobuz request failed"] = "Échec de la requête Qobuz",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401 : session rejetée ; reconnectez-vous",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403 : accès refusé ; vérifiez le compte ou l'abonnement",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429 : trop de requêtes ; réessayez plus tard",
        ["%s (API code %s)"] = "%s (code API %s)",
        ["Qobuz API error (HTTP %s, code %s)"] = "Erreur API Qobuz (HTTP %s, code %s)",
        ["Qobuz API error (HTTP %s)"] = "Erreur API Qobuz (HTTP %s)",
        ["Qobuz network: %s"] = "Réseau Qobuz : %s",
        ["Qobuz network: request failed"] = "Réseau Qobuz : échec de la requête",
        ["invalid URL"] = "URL invalide",
        ["invalid request"] = "requête invalide",
        ["DNS lookup failed"] = "échec de la résolution DNS",
        ["connection failed"] = "échec de la connexion",
        ["connection timed out"] = "délai de connexion dépassé",
        ["TLS connection failed"] = "échec de la connexion TLS",
        ["request timed out"] = "délai de la requête dépassé",
        ["request cancelled"] = "requête annulée",
        ["too many redirects"] = "trop de redirections",
        ["response too large"] = "réponse trop volumineuse",
        ["malformed HTTP response"] = "réponse HTTP mal formée",
        ["network I/O failed"] = "erreur d'E/S réseau",
        ["insecure redirect refused"] = "redirection non sécurisée refusée",
        ["player HTTP request limit reached"] = "limite de requêtes HTTP atteinte",
        ["player could not start the request"] = "impossible de lancer la requête",
        ["Unknown title"] = "Titre inconnu",
        ["Unknown artist"] = "Artiste inconnu",
        ["Unknown album"] = "Album inconnu",
        ["Playlist"] = "Liste de lecture",
        ["Could not load"] = "Chargement impossible",
        ["Retry"] = "Réessayer",
        ["Play these"] = "Lire tout",
        ["Albums"] = "Albums",
        ["Tracks"] = "Pistes",
        ["Artists"] = "Artistes",
        ["Favorite tracks"] = "Pistes favorites",
        ["Favorite albums"] = "Albums favoris",
        ["Playlists"] = "Listes de lecture",
        ["New releases"] = "Nouveautés",
        ["Quality"] = "Qualité",
        ["Search tracks"] = "Rechercher des pistes",
        ["Search albums"] = "Rechercher des albums",
        ["Search artists"] = "Rechercher des artistes",
        ["Sign in or log out"] = "Connexion ou déconnexion",
        ["Qobuz email"] = "E-mail Qobuz",
        ["Qobuz password"] = "Mot de passe Qobuz",
    },
    it = {
        ["Qobuz needs a player build with remote playback"] = "Qobuz richiede un firmware con riproduzione remota",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16 bit / 44,1 kHz)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC fino a 24/96",
        ["FLAC up to 24/192"] = "FLAC fino a 24/192",
        ["Logged out of Qobuz"] = "Disconnesso da Qobuz",
        ["Nothing in this list can be streamed"] = "Nessun elemento in questo elenco può essere riprodotto",
        ["Signed in to Qobuz"] = "Accesso a Qobuz effettuato",
        ["Preparing playback"] = "Preparazione riproduzione",
        ["No tracks"] = "Nessun brano",
        ["No albums"] = "Nessun album",
        ["No artists"] = "Nessun artista",
        ["No playlists"] = "Nessuna playlist",
        ["Quality updated"] = "Qualità aggiornata",
        ["This track is unavailable"] = "Questo brano non è disponibile",
        ["Qobuz returned no stream link"] = "Qobuz non ha restituito alcun link di streaming",
        ["Qobuz returned invalid JSON"] = "Qobuz ha restituito JSON non valido",
        ["Could not complete the request. Try again."] = "Impossibile completare la richiesta. Riprova.",
        ["Qobuz request failed"] = "Richiesta Qobuz non riuscita",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401: sessione rifiutata; accedi di nuovo",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403: accesso negato; controlla account o abbonamento",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429: troppe richieste; riprova più tardi",
        ["%s (API code %s)"] = "%s (codice API %s)",
        ["Qobuz API error (HTTP %s, code %s)"] = "Errore API Qobuz (HTTP %s, codice %s)",
        ["Qobuz API error (HTTP %s)"] = "Errore API Qobuz (HTTP %s)",
        ["Qobuz network: %s"] = "Rete Qobuz: %s",
        ["Qobuz network: request failed"] = "Rete Qobuz: richiesta non riuscita",
        ["invalid URL"] = "URL non valido",
        ["invalid request"] = "richiesta non valida",
        ["DNS lookup failed"] = "ricerca DNS non riuscita",
        ["connection failed"] = "connessione non riuscita",
        ["connection timed out"] = "connessione scaduta",
        ["TLS connection failed"] = "connessione TLS non riuscita",
        ["request timed out"] = "richiesta scaduta",
        ["request cancelled"] = "richiesta annullata",
        ["too many redirects"] = "troppi reindirizzamenti",
        ["response too large"] = "risposta troppo grande",
        ["malformed HTTP response"] = "risposta HTTP non valida",
        ["network I/O failed"] = "I/O di rete non riuscito",
        ["insecure redirect refused"] = "reindirizzamento non sicuro rifiutato",
        ["player HTTP request limit reached"] = "limite richieste HTTP raggiunto",
        ["player could not start the request"] = "impossibile avviare la richiesta",
        ["Unknown title"] = "Titolo sconosciuto",
        ["Unknown artist"] = "Artista sconosciuto",
        ["Unknown album"] = "Album sconosciuto",
        ["Playlist"] = "Playlist",
        ["Could not load"] = "Impossibile caricare",
        ["Retry"] = "Riprova",
        ["Play these"] = "Riproduci questi",
        ["Albums"] = "Album",
        ["Tracks"] = "Brani",
        ["Artists"] = "Artisti",
        ["Favorite tracks"] = "Brani preferiti",
        ["Favorite albums"] = "Album preferiti",
        ["Playlists"] = "Playlist",
        ["New releases"] = "Nuove uscite",
        ["Quality"] = "Qualità",
        ["Search tracks"] = "Cerca brani",
        ["Search albums"] = "Cerca album",
        ["Search artists"] = "Cerca artisti",
        ["Sign in or log out"] = "Accedi o esci",
        ["Qobuz email"] = "Email Qobuz",
        ["Qobuz password"] = "Password Qobuz",
    },
    ja = {
        ["Qobuz needs a player build with remote playback"] = "Qobuz にはリモート再生対応のファームウェアが必要です",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16-bit / 44.1 kHz)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC 最大 24/96",
        ["FLAC up to 24/192"] = "FLAC 最大 24/192",
        ["Logged out of Qobuz"] = "Qobuz からログアウトしました",
        ["Nothing in this list can be streamed"] = "このリストには再生可能な曲がありません",
        ["Signed in to Qobuz"] = "Qobuz にログインしました",
        ["Preparing playback"] = "再生を準備中",
        ["No tracks"] = "曲がありません",
        ["No albums"] = "アルバムがありません",
        ["No artists"] = "アーティストがいません",
        ["No playlists"] = "プレイリストがありません",
        ["Quality updated"] = "音質を更新しました",
        ["This track is unavailable"] = "この曲は利用できません",
        ["Qobuz returned no stream link"] = "Qobuz からストリーム URL を取得できませんでした",
        ["Qobuz returned invalid JSON"] = "Qobuz から無効な JSON が返されました",
        ["Could not complete the request. Try again."] = "リクエストを完了できませんでした。再試行してください。",
        ["Qobuz request failed"] = "Qobuz リクエストに失敗しました",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401: セッションが無効です。再ログインしてください",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403: アクセス拒否。アカウントや契約を確認してください",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429: リクエスト制限中です。後で再試行してください",
        ["%s (API code %s)"] = "%s (API コード %s)",
        ["Qobuz API error (HTTP %s, code %s)"] = "Qobuz API エラー (HTTP %s, コード %s)",
        ["Qobuz API error (HTTP %s)"] = "Qobuz API エラー (HTTP %s)",
        ["Qobuz network: %s"] = "Qobuz ネットワーク: %s",
        ["Qobuz network: request failed"] = "Qobuz ネットワーク: リクエスト失敗",
        ["invalid URL"] = "無効な URL",
        ["invalid request"] = "無効なリクエスト",
        ["DNS lookup failed"] = "DNS 解決に失敗しました",
        ["connection failed"] = "接続に失敗しました",
        ["connection timed out"] = "接続がタイムアウトしました",
        ["TLS connection failed"] = "TLS 接続に失敗しました",
        ["request timed out"] = "リクエストがタイムアウトしました",
        ["request cancelled"] = "リクエストがキャンセルされました",
        ["too many redirects"] = "リダイレクトが多すぎます",
        ["response too large"] = "応答が大きすぎます",
        ["malformed HTTP response"] = "不正な HTTP 応答",
        ["network I/O failed"] = "ネットワーク I/O エラー",
        ["insecure redirect refused"] = "安全でないリダイレクトを拒否しました",
        ["player HTTP request limit reached"] = "HTTP リクエスト上限に達しました",
        ["player could not start the request"] = "リクエストを開始できませんでした",
        ["Unknown title"] = "不明なタイトル",
        ["Unknown artist"] = "不明なアーティスト",
        ["Unknown album"] = "不明なアルバム",
        ["Playlist"] = "プレイリスト",
        ["Could not load"] = "読み込めませんでした",
        ["Retry"] = "再試行",
        ["Play these"] = "これらを再生",
        ["Albums"] = "アルバム",
        ["Tracks"] = "曲",
        ["Artists"] = "アーティスト",
        ["Favorite tracks"] = "お気に入りの曲",
        ["Favorite albums"] = "お気に入りのアルバム",
        ["Playlists"] = "プレイリスト",
        ["New releases"] = "ニューリリース",
        ["Quality"] = "音質",
        ["Search tracks"] = "曲を検索",
        ["Search albums"] = "アルバムを検索",
        ["Search artists"] = "アーティストを検索",
        ["Sign in or log out"] = "ログイン / ログアウト",
        ["Qobuz email"] = "Qobuz メールアドレス",
        ["Qobuz password"] = "Qobuz パスワード",
    },
    nl = {
        ["Qobuz needs a player build with remote playback"] = "Qobuz vereist een speler met afspelen op afstand",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16-bit / 44,1 kHz)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC tot 24/96",
        ["FLAC up to 24/192"] = "FLAC tot 24/192",
        ["Logged out of Qobuz"] = "Uitgelogd bij Qobuz",
        ["Nothing in this list can be streamed"] = "Niets in deze lijst kan worden gestreamd",
        ["Signed in to Qobuz"] = "Ingelogd bij Qobuz",
        ["Preparing playback"] = "Afspelen voorbereiden",
        ["No tracks"] = "Geen nummers",
        ["No albums"] = "Geen albums",
        ["No artists"] = "Geen artiesten",
        ["No playlists"] = "Geen afspeellijsten",
        ["Quality updated"] = "Kwaliteit bijgewerkt",
        ["This track is unavailable"] = "Dit nummer is niet beschikbaar",
        ["Qobuz returned no stream link"] = "Qobuz gaf geen streamlink terug",
        ["Qobuz returned invalid JSON"] = "Qobuz gaf ongeldige JSON terug",
        ["Could not complete the request. Try again."] = "Kan verzoek niet voltooien. Probeer het opnieuw.",
        ["Qobuz request failed"] = "Qobuz-verzoek mislukt",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401: sessie geweigerd; log opnieuw in",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403: toegang geweigerd; controleer account of abonnement",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429: te veel verzoeken; probeer later opnieuw",
        ["%s (API code %s)"] = "%s (API-code %s)",
        ["Qobuz API error (HTTP %s, code %s)"] = "Qobuz API-fout (HTTP %s, code %s)",
        ["Qobuz API error (HTTP %s)"] = "Qobuz API-fout (HTTP %s)",
        ["Qobuz network: %s"] = "Qobuz-netwerk: %s",
        ["Qobuz network: request failed"] = "Qobuz-netwerk: verzoek mislukt",
        ["invalid URL"] = "ongeldige URL",
        ["invalid request"] = "ongeldig verzoek",
        ["DNS lookup failed"] = "DNS-zoekopdracht mislukt",
        ["connection failed"] = "verbinding mislukt",
        ["connection timed out"] = "verbinding verlopen",
        ["TLS connection failed"] = "TLS-verbinding mislukt",
        ["request timed out"] = "verzoek verlopen",
        ["request cancelled"] = "verzoek geannuleerd",
        ["too many redirects"] = "te veel omleidingen",
        ["response too large"] = "antwoord te groot",
        ["malformed HTTP response"] = "ongeldig HTTP-antwoord",
        ["network I/O failed"] = "netwerk-I/O mislukt",
        ["insecure redirect refused"] = "onveilige omleiding geweigerd",
        ["player HTTP request limit reached"] = "limiet voor HTTP-verzoeken bereikt",
        ["player could not start the request"] = "kon verzoek niet starten",
        ["Unknown title"] = "Onbekende titel",
        ["Unknown artist"] = "Onbekende artiest",
        ["Unknown album"] = "Onbekend album",
        ["Playlist"] = "Afspeellijst",
        ["Could not load"] = "Kan niet laden",
        ["Retry"] = "Opnieuw",
        ["Play these"] = "Deze afspelen",
        ["Albums"] = "Albums",
        ["Tracks"] = "Nummers",
        ["Artists"] = "Artiesten",
        ["Favorite tracks"] = "Favoriete nummers",
        ["Favorite albums"] = "Favoriete albums",
        ["Playlists"] = "Afspeellijsten",
        ["New releases"] = "Nieuwe releases",
        ["Quality"] = "Kwaliteit",
        ["Search tracks"] = "Nummers zoeken",
        ["Search albums"] = "Albums zoeken",
        ["Search artists"] = "Artiesten zoeken",
        ["Sign in or log out"] = "In- of uitloggen",
        ["Qobuz email"] = "Qobuz e-mail",
        ["Qobuz password"] = "Qobuz wachtwoord",
    },
    pt = {
        ["Qobuz needs a player build with remote playback"] = "O Qobuz requer um firmware com reprodução remota",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16 bits / 44,1 kHz)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC até 24/96",
        ["FLAC up to 24/192"] = "FLAC até 24/192",
        ["Logged out of Qobuz"] = "Sessão encerrada no Qobuz",
        ["Nothing in this list can be streamed"] = "Nada nesta lista pode ser reproduzido",
        ["Signed in to Qobuz"] = "Sessão iniciada no Qobuz",
        ["Preparing playback"] = "Preparando reprodução",
        ["No tracks"] = "Sem faixas",
        ["No albums"] = "Sem álbuns",
        ["No artists"] = "Sem artistas",
        ["No playlists"] = "Sem listas de reprodução",
        ["Quality updated"] = "Qualidade atualizada",
        ["This track is unavailable"] = "Esta faixa está indisponível",
        ["Qobuz returned no stream link"] = "O Qobuz não retornou link de transmissão",
        ["Qobuz returned invalid JSON"] = "O Qobuz retornou JSON inválido",
        ["Could not complete the request. Try again."] = "Não foi possível concluir o pedido. Tente novamente.",
        ["Qobuz request failed"] = "Falha no pedido ao Qobuz",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401: sessão rejeitada; inicie sessão novamente",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403: acesso negado; verifique a conta ou assinatura",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429: limite de pedidos; tente mais tarde",
        ["%s (API code %s)"] = "%s (código API %s)",
        ["Qobuz API error (HTTP %s, code %s)"] = "Erro da API Qobuz (HTTP %s, código %s)",
        ["Qobuz API error (HTTP %s)"] = "Erro da API Qobuz (HTTP %s)",
        ["Qobuz network: %s"] = "Rede Qobuz: %s",
        ["Qobuz network: request failed"] = "Rede Qobuz: falha no pedido",
        ["invalid URL"] = "URL inválido",
        ["invalid request"] = "pedido inválido",
        ["DNS lookup failed"] = "falha na consulta DNS",
        ["connection failed"] = "falha na conexão",
        ["connection timed out"] = "tempo de conexão esgotado",
        ["TLS connection failed"] = "falha na conexão TLS",
        ["request timed out"] = "tempo do pedido esgotado",
        ["request cancelled"] = "pedido cancelado",
        ["too many redirects"] = "muitos redirecionamentos",
        ["response too large"] = "resposta muito grande",
        ["malformed HTTP response"] = "resposta HTTP malformada",
        ["network I/O failed"] = "falha de E/S de rede",
        ["insecure redirect refused"] = "redirecionamento inseguro recusado",
        ["player HTTP request limit reached"] = "limite de pedidos HTTP atingido",
        ["player could not start the request"] = "não foi possível iniciar o pedido",
        ["Unknown title"] = "Título desconhecido",
        ["Unknown artist"] = "Artista desconhecido",
        ["Unknown album"] = "Álbum desconhecido",
        ["Playlist"] = "Lista de reprodução",
        ["Could not load"] = "Não foi possível carregar",
        ["Retry"] = "Tentar novamente",
        ["Play these"] = "Reproduzir tudo",
        ["Albums"] = "Álbuns",
        ["Tracks"] = "Faixas",
        ["Artists"] = "Artistas",
        ["Favorite tracks"] = "Faixas favoritas",
        ["Favorite albums"] = "Álbuns favoritos",
        ["Playlists"] = "Listas de reprodução",
        ["New releases"] = "Lançamentos",
        ["Quality"] = "Qualidade",
        ["Search tracks"] = "Pesquisar faixas",
        ["Search albums"] = "Pesquisar álbuns",
        ["Search artists"] = "Pesquisar artistas",
        ["Sign in or log out"] = "Entrar ou sair",
        ["Qobuz email"] = "E-mail do Qobuz",
        ["Qobuz password"] = "Senha do Qobuz",
    },
    ru = {
        ["Qobuz needs a player build with remote playback"] = "Для Qobuz требуется прошивка с удалённым воспроизведением",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16 бит / 44,1 кГц)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC до 24/96",
        ["FLAC up to 24/192"] = "FLAC до 24/192",
        ["Logged out of Qobuz"] = "Вы вышли из Qobuz",
        ["Nothing in this list can be streamed"] = "Ничего из этого списка нельзя воспроизвести",
        ["Signed in to Qobuz"] = "Выполнен вход в Qobuz",
        ["Preparing playback"] = "Подготовка воспроизведения",
        ["No tracks"] = "Нет треков",
        ["No albums"] = "Нет альбомов",
        ["No artists"] = "Нет исполнителей",
        ["No playlists"] = "Нет плейлистов",
        ["Quality updated"] = "Качество обновлено",
        ["This track is unavailable"] = "Этот трек недоступен",
        ["Qobuz returned no stream link"] = "Qobuz не вернул ссылку на поток",
        ["Qobuz returned invalid JSON"] = "Qobuz вернул некорректный JSON",
        ["Could not complete the request. Try again."] = "Не удалось выполнить запрос. Повторите попытку.",
        ["Qobuz request failed"] = "Ошибка запроса Qobuz",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401: сессия отклонена; войдите снова",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403: доступ запрещён; проверьте аккаунт или подписку",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429: слишком много запросов; повторите позже",
        ["%s (API code %s)"] = "%s (код API %s)",
        ["Qobuz API error (HTTP %s, code %s)"] = "Ошибка API Qobuz (HTTP %s, код %s)",
        ["Qobuz API error (HTTP %s)"] = "Ошибка API Qobuz (HTTP %s)",
        ["Qobuz network: %s"] = "Сеть Qobuz: %s",
        ["Qobuz network: request failed"] = "Сеть Qobuz: сбой запроса",
        ["invalid URL"] = "некорректный URL",
        ["invalid request"] = "некорректный запрос",
        ["DNS lookup failed"] = "ошибка DNS-запроса",
        ["connection failed"] = "ошибка подключения",
        ["connection timed out"] = "тайм-аут подключения",
        ["TLS connection failed"] = "ошибка соединения TLS",
        ["request timed out"] = "тайм-аут запроса",
        ["request cancelled"] = "запрос отменён",
        ["too many redirects"] = "слишком много перенаправлений",
        ["response too large"] = "ответ слишком большой",
        ["malformed HTTP response"] = "некорректный HTTP-ответ",
        ["network I/O failed"] = "ошибка сетевого ввода-вывода",
        ["insecure redirect refused"] = "небезопасное перенаправление отклонено",
        ["player HTTP request limit reached"] = "достигнут лимит HTTP-запросов",
        ["player could not start the request"] = "не удалось запустить запрос",
        ["Unknown title"] = "Неизвестное название",
        ["Unknown artist"] = "Неизвестный исполнитель",
        ["Unknown album"] = "Неизвестный альбом",
        ["Playlist"] = "Плейлист",
        ["Could not load"] = "Не удалось загрузить",
        ["Retry"] = "Повторить",
        ["Play these"] = "Воспроизвести всё",
        ["Albums"] = "Альбомы",
        ["Tracks"] = "Треки",
        ["Artists"] = "Исполнители",
        ["Favorite tracks"] = "Любимые треки",
        ["Favorite albums"] = "Любимые альбомы",
        ["Playlists"] = "Плейлисты",
        ["New releases"] = "Новинки",
        ["Quality"] = "Качество",
        ["Search tracks"] = "Поиск треков",
        ["Search albums"] = "Поиск альбомов",
        ["Search artists"] = "Поиск исполнителей",
        ["Sign in or log out"] = "Войти или выйти",
        ["Qobuz email"] = "Email Qobuz",
        ["Qobuz password"] = "Пароль Qobuz",
    },
    uk = {
        ["Qobuz needs a player build with remote playback"] = "Для Qobuz потрібна прошивка з віддаленим відтворенням",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16 біт / 44,1 кГц)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC до 24/96",
        ["FLAC up to 24/192"] = "FLAC до 24/192",
        ["Logged out of Qobuz"] = "Ви вийшли з Qobuz",
        ["Nothing in this list can be streamed"] = "Нічого з цього списку не можна відтворити",
        ["Signed in to Qobuz"] = "Виконано вхід у Qobuz",
        ["Preparing playback"] = "Підготовка відтворення",
        ["No tracks"] = "Немає треків",
        ["No albums"] = "Немає альбомів",
        ["No artists"] = "Немає виконавців",
        ["No playlists"] = "Немає списків відтворення",
        ["Quality updated"] = "Якість оновлено",
        ["This track is unavailable"] = "Цей трек недоступний",
        ["Qobuz returned no stream link"] = "Qobuz не повернув посилання на потік",
        ["Qobuz returned invalid JSON"] = "Qobuz повернув некоректний JSON",
        ["Could not complete the request. Try again."] = "Не вдалося виконати запит. Спробуйте ще раз.",
        ["Qobuz request failed"] = "Помилка запиту Qobuz",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401: сесію відхилено; увійдіть знову",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403: доступ заборонено; перевірте акаунт або підписку",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429: забагато запитів; спробуйте пізніше",
        ["%s (API code %s)"] = "%s (код API %s)",
        ["Qobuz API error (HTTP %s, code %s)"] = "Помилка API Qobuz (HTTP %s, код %s)",
        ["Qobuz API error (HTTP %s)"] = "Помилка API Qobuz (HTTP %s)",
        ["Qobuz network: %s"] = "Мережа Qobuz: %s",
        ["Qobuz network: request failed"] = "Мережа Qobuz: збій запиту",
        ["invalid URL"] = "некоректний URL",
        ["invalid request"] = "некоректний запит",
        ["DNS lookup failed"] = "помилка DNS-запиту",
        ["connection failed"] = "помилка з'єднання",
        ["connection timed out"] = "час очікування з'єднання минув",
        ["TLS connection failed"] = "помилка з'єднання TLS",
        ["request timed out"] = "час очікування запиту минув",
        ["request cancelled"] = "запит скасовано",
        ["too many redirects"] = "забагато перенаправлень",
        ["response too large"] = "відповідь занадто велика",
        ["malformed HTTP response"] = "некоректна HTTP-відповідь",
        ["network I/O failed"] = "помилка мережевого вводу-виводу",
        ["insecure redirect refused"] = "небезпечне перенаправлення відхилено",
        ["player HTTP request limit reached"] = "досягнуто ліміту HTTP-запитів",
        ["player could not start the request"] = "не вдалося запустити запит",
        ["Unknown title"] = "Невідома назва",
        ["Unknown artist"] = "Невідомий виконавець",
        ["Unknown album"] = "Невідомий альбом",
        ["Playlist"] = "Список відтворення",
        ["Could not load"] = "Не вдалося завантажити",
        ["Retry"] = "Повторити",
        ["Play these"] = "Відтворити все",
        ["Albums"] = "Альбоми",
        ["Tracks"] = "Треки",
        ["Artists"] = "Виконавці",
        ["Favorite tracks"] = "Улюблені треки",
        ["Favorite albums"] = "Улюблені альбоми",
        ["Playlists"] = "Списки відтворення",
        ["New releases"] = "Новинки",
        ["Quality"] = "Якість",
        ["Search tracks"] = "Пошук треків",
        ["Search albums"] = "Пошук альбомів",
        ["Search artists"] = "Пошук виконавців",
        ["Sign in or log out"] = "Увійти або вийти",
        ["Qobuz email"] = "Email Qobuz",
        ["Qobuz password"] = "Пароль Qobuz",
    },
    vi = {
        ["Qobuz needs a player build with remote playback"] = "Qobuz cần bản dựng hỗ trợ phát từ xa",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16-bit / 44.1 kHz)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC tối đa 24/96",
        ["FLAC up to 24/192"] = "FLAC tối đa 24/192",
        ["Logged out of Qobuz"] = "Đã đăng xuất khỏi Qobuz",
        ["Nothing in this list can be streamed"] = "Không thể phát mục nào trong danh sách này",
        ["Signed in to Qobuz"] = "Đã đăng nhập Qobuz",
        ["Preparing playback"] = "Đang chuẩn bị phát",
        ["No tracks"] = "Không có bài hát",
        ["No albums"] = "Không có album",
        ["No artists"] = "Không có nghệ sĩ",
        ["No playlists"] = "Không có danh sách phát",
        ["Quality updated"] = "Đã cập nhật chất lượng",
        ["This track is unavailable"] = "Bài hát này không khả dụng",
        ["Qobuz returned no stream link"] = "Qobuz không trả về liên kết phát",
        ["Qobuz returned invalid JSON"] = "Qobuz trả về JSON không hợp lệ",
        ["Could not complete the request. Try again."] = "Không thể hoàn tất yêu cầu. Hãy thử lại.",
        ["Qobuz request failed"] = "Yêu cầu Qobuz thất bại",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401: phiên bị từ chối; hãy đăng nhập lại",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403: từ chối truy cập; kiểm tra tài khoản hoặc gói thuê bao",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429: quá giới hạn yêu cầu; thử lại sau",
        ["%s (API code %s)"] = "%s (mã API %s)",
        ["Qobuz API error (HTTP %s, code %s)"] = "Lỗi API Qobuz (HTTP %s, mã %s)",
        ["Qobuz API error (HTTP %s)"] = "Lỗi API Qobuz (HTTP %s)",
        ["Qobuz network: %s"] = "Mạng Qobuz: %s",
        ["Qobuz network: request failed"] = "Mạng Qobuz: yêu cầu thất bại",
        ["invalid URL"] = "URL không hợp lệ",
        ["invalid request"] = "yêu cầu không hợp lệ",
        ["DNS lookup failed"] = "tra cứu DNS thất bại",
        ["connection failed"] = "kết nối thất bại",
        ["connection timed out"] = "hết thời gian kết nối",
        ["TLS connection failed"] = "kết nối TLS thất bại",
        ["request timed out"] = "hết thời gian yêu cầu",
        ["request cancelled"] = "đã hủy yêu cầu",
        ["too many redirects"] = "quá nhiều chuyển hướng",
        ["response too large"] = "phản hồi quá lớn",
        ["malformed HTTP response"] = "phản hồi HTTP lỗi định dạng",
        ["network I/O failed"] = "lỗi I/O mạng",
        ["insecure redirect refused"] = "từ chối chuyển hướng không an toàn",
        ["player HTTP request limit reached"] = "đã đạt giới hạn yêu cầu HTTP",
        ["player could not start the request"] = "không thể bắt đầu yêu cầu",
        ["Unknown title"] = "Tiêu đề không rõ",
        ["Unknown artist"] = "Nghệ sĩ không rõ",
        ["Unknown album"] = "Album không rõ",
        ["Playlist"] = "Danh sách phát",
        ["Could not load"] = "Không thể tải",
        ["Retry"] = "Thử lại",
        ["Play these"] = "Phát danh sách này",
        ["Albums"] = "Album",
        ["Tracks"] = "Bài hát",
        ["Artists"] = "Nghệ sĩ",
        ["Favorite tracks"] = "Bài hát yêu thích",
        ["Favorite albums"] = "Album yêu thích",
        ["Playlists"] = "Danh sách phát",
        ["New releases"] = "Mới phát hành",
        ["Quality"] = "Chất lượng",
        ["Search tracks"] = "Tìm bài hát",
        ["Search albums"] = "Tìm album",
        ["Search artists"] = "Tìm nghệ sĩ",
        ["Sign in or log out"] = "Đăng nhập hoặc đăng xuất",
        ["Qobuz email"] = "Email Qobuz",
        ["Qobuz password"] = "Mật khẩu Qobuz",
    },
    zh_CN = {
        ["Qobuz needs a player build with remote playback"] = "Qobuz 需要支持远程播放的固件版本",
        ["FLAC CD (16-bit / 44.1 kHz)"] = "FLAC CD (16-bit / 44.1 kHz)",
        ["MP3 320"] = "MP3 320",
        ["FLAC up to 24/96"] = "FLAC 最高 24/96",
        ["FLAC up to 24/192"] = "FLAC 最高 24/192",
        ["Logged out of Qobuz"] = "已退出 Qobuz",
        ["Nothing in this list can be streamed"] = "此列表中没有可播放的曲目",
        ["Signed in to Qobuz"] = "已登录 Qobuz",
        ["Preparing playback"] = "正在准备播放",
        ["No tracks"] = "没有曲目",
        ["No albums"] = "没有专辑",
        ["No artists"] = "没有艺术家",
        ["No playlists"] = "没有播放列表",
        ["Quality updated"] = "音质已更新",
        ["This track is unavailable"] = "此曲目不可用",
        ["Qobuz returned no stream link"] = "Qobuz 未返回流媒体链接",
        ["Qobuz returned invalid JSON"] = "Qobuz 返回了无效的 JSON",
        ["Could not complete the request. Try again."] = "无法完成请求，请重试。",
        ["Qobuz request failed"] = "Qobuz 请求失败",
        ["Qobuz HTTP 401: session rejected; sign in again"] = "Qobuz HTTP 401：会话被拒绝，请重新登录",
        ["Qobuz HTTP 403: access denied; check account or subscription"] = "Qobuz HTTP 403：访问被拒绝，请检查账户或订阅",
        ["Qobuz HTTP 429: rate limited; retry later"] = "Qobuz HTTP 429：请求过于频繁，请稍后重试",
        ["%s (API code %s)"] = "%s（API 代码 %s）",
        ["Qobuz API error (HTTP %s, code %s)"] = "Qobuz API 错误（HTTP %s，代码 %s）",
        ["Qobuz API error (HTTP %s)"] = "Qobuz API 错误（HTTP %s）",
        ["Qobuz network: %s"] = "Qobuz 网络：%s",
        ["Qobuz network: request failed"] = "Qobuz 网络：请求失败",
        ["invalid URL"] = "无效的 URL",
        ["invalid request"] = "无效的请求",
        ["DNS lookup failed"] = "DNS 解析失败",
        ["connection failed"] = "连接失败",
        ["connection timed out"] = "连接超时",
        ["TLS connection failed"] = "TLS 连接失败",
        ["request timed out"] = "请求超时",
        ["request cancelled"] = "请求已取消",
        ["too many redirects"] = "重定向过多",
        ["response too large"] = "响应过大",
        ["malformed HTTP response"] = "HTTP 响应格式错误",
        ["network I/O failed"] = "网络 I/O 失败",
        ["insecure redirect refused"] = "已拒绝不安全的重定向",
        ["player HTTP request limit reached"] = "已达播放器 HTTP 请求上限",
        ["player could not start the request"] = "播放器无法启动请求",
        ["Unknown title"] = "未知标题",
        ["Unknown artist"] = "未知艺术家",
        ["Unknown album"] = "未知专辑",
        ["Playlist"] = "播放列表",
        ["Could not load"] = "无法加载",
        ["Retry"] = "重试",
        ["Play these"] = "播放全部",
        ["Albums"] = "专辑",
        ["Tracks"] = "曲目",
        ["Artists"] = "艺术家",
        ["Favorite tracks"] = "收藏的曲目",
        ["Favorite albums"] = "收藏的专辑",
        ["Playlists"] = "播放列表",
        ["New releases"] = "新发行",
        ["Quality"] = "音质",
        ["Search tracks"] = "搜索曲目",
        ["Search albums"] = "搜索专辑",
        ["Search artists"] = "搜索艺术家",
        ["Sign in or log out"] = "登录或退出",
        ["Qobuz email"] = "Qobuz 邮箱",
        ["Qobuz password"] = "Qobuz 密码",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if not plugin.has_capability("playback.remote") then
    plugin.show_toast(tr("Qobuz needs a player build with remote playback"))
    return
end

local API = "https://www.qobuz.com/api.json/0.2"
-- The pair from the stock player's Qobuz login. getFileUrl accepts it.
local APP_ID = "575344876"
local APP_SECRET = "6dc277296c6d6dc5627ff8c1c199f1d7"
local PAGE = 25
local BROWSE_CAP = 475 -- plus the "Play these" row, within show_list's 500 rows
local SEARCH_CAP = 100
local REMOTE_QUEUE_CAP = 500
local TRACK_FETCH_CAP = REMOTE_QUEUE_CAP
local remote_tracks = {}
local JSON_LIMIT = 524288
local playback_generation = 0
local browse_generation = 0
local auth_generation = 0
local FORMATS = {
    { id = 6,  label = "FLAC CD (16-bit / 44.1 kHz)" },
    { id = 5,  label = "MP3 320" },
    { id = 7,  label = "FLAC up to 24/96" },
    { id = 27, label = "FLAC up to 24/192" },
}

local function translate_qobuz_error(message)
    if message == "No stream link" then
        return tr("Qobuz returned no stream link")
    end
    if message == "Qobuz returned invalid JSON" or message == "Qobuz request failed" then
        return tr(message)
    end
    local net_desc = message:match("^Qobuz network: (.+)$")
    if net_desc then
        if net_desc == "request failed" then
            return tr("Qobuz network: request failed")
        end
        return string.format(tr("Qobuz network: %s"), tr(net_desc))
    end
    local status, code = message:match("^Qobuz API error %(HTTP (%d+), code (%d+)%)$")
    if status and code then
        return string.format(tr("Qobuz API error (HTTP %s, code %s)"), status, code)
    end
    local status_only = message:match("^Qobuz API error %(HTTP (%d+)%)$")
    if status_only then
        return string.format(tr("Qobuz API error (HTTP %s)"), status_only)
    end
    local base_http, api_code = message:match("^(Qobuz HTTP %d%d%d: [^%(]-) %(API code (%d+)%)$")
    if base_http and api_code then
        return string.format(tr("%s (API code %s)"), tr(base_http), api_code)
    end
    return tr(message)
end

local function toast(message)
    message = tostring(message or "")
    if message == "Logged out of Qobuz" or message == "Nothing in this list can be streamed" then
        plugin.show_toast(tr(message))
    elseif message:match("^Logged in as ") then
        plugin.show_toast(tr("Signed in to Qobuz"))
    elseif message == "Getting stream links" or message == "Preparing playback" then
        plugin.show_toast(tr("Preparing playback"))
    elseif message == "No tracks" or message == "No albums" or message == "No artists" or message == "No playlists" then
        plugin.show_toast(tr(message))
    elseif message == "Quality updated" then
        plugin.show_toast(tr(message))
    elseif message == "Not in this subscription" then
        plugin.show_toast(tr("This track is unavailable"))
    elseif message:match("^Qobuz HTTP %d%d%d") or message:match("^Qobuz API error")
        or message:match("^Qobuz network: ") or message == "Qobuz returned invalid JSON"
        or message == "Qobuz request failed" or message == "No stream link" then
        plugin.show_toast(translate_qobuz_error(message))
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

local function format_id()
    local saved = tonumber(stored("format_id") or "")
    if saved == 5 or saved == 6 or saved == 7 or saved == 27 then return saved end
    return 6
end

local function format_index()
    local current = format_id()
    for i, format in ipairs(FORMATS) do
        if format.id == current then return i end
    end
    return 1
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

local function safe_api_code(data)
    if type(data) ~= "table" then return nil end
    local code = data.code
    if code == nil and type(data.error) == "table" then code = data.error.code end
    if type(code) == "number" and code >= 0 and code <= 999999 and code == math.floor(code) then
        return tostring(code)
    end
    if type(code) == "string" and #code >= 1 and #code <= 6 and code:match("^%d+$") then
        return code
    end
    return nil
end

local function response_api_code(body)
    -- Never display server-provided message text: an error body could echo
    -- request data. Only surface a bounded numeric code from a size-limited decode.
    local data = body and plugin.json_decode(body, { max_input_bytes = JSON_LIMIT })
    return safe_api_code(data)
end

local function api_error(body, status)
    local code = response_api_code(body)
    if code then return "Qobuz API error (HTTP " .. tostring(status) .. ", code " .. code .. ")" end
    return "Qobuz API error (HTTP " .. tostring(status) .. ")"
end

local function http_error(status, body)
    local code = tonumber(status)
    if not code or code ~= math.floor(code) or code < 100 or code > 599 then
        return "Qobuz request failed"
    end
    local api_code = response_api_code(body)
    local code_suffix = api_code and (" (API code " .. api_code .. ")") or ""
    if code == 401 then return "Qobuz HTTP 401: session rejected; sign in again" .. code_suffix end
    if code == 403 then return "Qobuz HTTP 403: access denied; check account or subscription" .. code_suffix end
    if code == 429 then return "Qobuz HTTP 429: rate limited; retry later" .. code_suffix end
    return api_error(body, code)
end

local SAFE_TRANSPORT_ERRORS = {
    invalid_url = "invalid URL",
    invalid_request = "invalid request",
    dns = "DNS lookup failed",
    connect = "connection failed",
    connect_timeout = "connection timed out",
    tls = "TLS connection failed",
    timeout = "request timed out",
    cancelled = "request cancelled",
    too_many_redirects = "too many redirects",
    response_too_large = "response too large",
    malformed = "malformed HTTP response",
    io = "network I/O failed",
    insecure_redirect = "insecure redirect refused",
    ["too many active HTTP requests"] = "player HTTP request limit reached",
    ["could not start HTTP worker"] = "player could not start the request",
    ["request unavailable"] = "player could not start the request",
}

local function safe_transport_error(err)
    local description = SAFE_TRANSPORT_ERRORS[tostring(err or "")]
    if description then return "Qobuz network: " .. description end
    return "Qobuz network: request failed"
end

local function qobuz_get(path, extra_headers, callback)
    local headers = { ["X-App-Id"] = APP_ID }
    local token = stored("auth_token")
    if token then headers["X-User-Auth-Token"] = token end
    if extra_headers then
        for name, value in pairs(extra_headers) do headers[name] = value end
    end

    local handle, start_err = plugin.http_request({
        url = API .. path,
        headers = headers,
        total_timeout_ms = 20000,
        max_response_bytes = JSON_LIMIT,
    }, function(status, body, err)
        if err then
            callback(nil, safe_transport_error(err))
            return
        end
        if status ~= 200 then
            callback(nil, http_error(status, body))
            return
        end
        local data = plugin.json_decode(body, { max_input_bytes = JSON_LIMIT })
        if type(data) ~= "table" then
            callback(nil, "Qobuz returned invalid JSON")
            return
        end
        if data.status == "error" then
            callback(nil, api_error(body, status))
            return
        end
        callback(data)
    end)
    if not handle then callback(nil, safe_transport_error(start_err)) end
end

-- plugin.json_decode() returns every JSON number as a float, so a plain
-- tostring() turns track 5966783 into "5966783.0", which Qobuz rejects
-- with HTTP 400 on getFileUrl, playlist/get and artist/get.
local function id_string(value)
    if type(value) == "number" then
        local whole = math.tointeger(value)
        if whole then return tostring(whole) end
    end
    return tostring(value)
end

local function items_of(node)
    if type(node) ~= "table" then return {} end
    if type(node.items) == "table" then return node.items end
    if node[1] ~= nil then return node end
    return {}
end

local function cover_url(image)
    if type(image) ~= "table" then return "" end
    return image.large or image.extralarge or image.small or image.thumbnail or image.mega or ""
end

local function artist_name(obj)
    if type(obj) ~= "table" then return "" end
    if type(obj.performer) == "table" and obj.performer.name then return obj.performer.name end
    if type(obj.artist) == "table" and obj.artist.name then return obj.artist.name end
    if type(obj.album) == "table" and type(obj.album.artist) == "table" then
        return obj.album.artist.name or ""
    end
    return ""
end

local function known_codec(value)
    if type(value) ~= "string" then return nil end
    value = value:lower()
    if value == "flac" or value == "mp3" or value == "aac" then return value end
    return nil
end

local function track_from(obj, album_hint)
    if type(obj) ~= "table" or obj.id == nil then return nil end
    local album = type(obj.album) == "table" and obj.album or nil
    local hint = album_hint or {}
    local cover = album and cover_url(album.image) or ""
    local rate = tonumber(obj.maximum_sampling_rate or obj.sample_rate) or 0
    if rate > 0 and rate < 1000 then rate = math.floor(rate * 1000 + 0.5) end
    local verify_tls
    if type(obj.verify_tls) == "boolean" then verify_tls = obj.verify_tls end
    return {
        id = id_string(obj.id),
        title = clip_utf8(obj.title or tr("Unknown title"), 127),
        artist = clip_utf8(artist_name(obj) ~= "" and artist_name(obj) or (hint.artist or tr("Unknown artist")), 127),
        album = clip_utf8((album and album.title) or hint.title or "", 127),
        album_id = (album and album.id and id_string(album.id)) or hint.id or "",
        cover = cover ~= "" and cover or (hint.cover or ""),
        duration = tonumber(obj.duration) or 0,
        sample_rate = rate,
        bit_depth = tonumber(obj.maximum_bit_depth or obj.bit_depth) or 0,
        channels = tonumber(obj.channels),
        bitrate_kbps = tonumber(obj.bitrate_kbps or obj.bit_rate),
        replaygain_db = tonumber(obj.replaygain_track_gain or obj.replaygain_db),
        verify_tls = verify_tls,
        codec = known_codec(obj.codec),
        streamable = obj.streamable ~= false,
    }
end

local function album_from(obj)
    if type(obj) ~= "table" or obj.id == nil then return nil end
    local artist = ""
    if type(obj.artist) == "table" then artist = obj.artist.name or "" end
    return {
        id = id_string(obj.id),
        title = obj.title or tr("Unknown album"),
        artist = artist,
        cover = cover_url(obj.image),
        count = tonumber(obj.tracks_count) or 0,
    }
end

local function artist_from(obj)
    if type(obj) ~= "table" or obj.id == nil then return nil end
    return {
        id = id_string(obj.id),
        name = obj.name or tr("Unknown artist"),
        count = tonumber(obj.albums_count) or 0,
    }
end

local function playlist_from(obj)
    if type(obj) ~= "table" or obj.id == nil then return nil end
    local image = ""
    if type(obj.images300) == "table" then image = obj.images300[1] or "" end
    if image == "" and type(obj.images150) == "table" then image = obj.images150[1] or "" end
    return {
        id = id_string(obj.id),
        name = obj.name or tr("Playlist"),
        count = tonumber(obj.tracks_count) or 0,
        cover = image,
    }
end

local show_list

local function show_rows(title, rows, on_pick)
    local labels = {}
    for i, row in ipairs(rows) do
        labels[i] = clip(row.label, 140)
    end
    return show_list(title, labels, function(index, list_handle)
        if rows[index] then on_pick(rows[index], list_handle) end
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

local function file_url(track, callback)
    local ts = tostring(os.time())
    local secret = APP_SECRET
    local signed = "trackgetFileUrlformat_id" .. tostring(format_id())
        .. "intentstreamtrack_id" .. track.id .. ts .. secret
    local path = "/track/getFileUrl?app_id=" .. url_encode(APP_ID)
        .. "&user_auth_token=" .. url_encode(stored("auth_token") or "")
        .. "&request_ts=" .. ts
        .. "&request_sig=" .. plugin.md5(signed)
        .. "&format_id=" .. tostring(format_id())
        .. "&intent=stream&track_id=" .. url_encode(track.id)
    qobuz_get(path, nil, function(data, err)
        if not data then
            callback(nil, err)
            return
        end
        if not data.url or data.url == "" then
            callback(nil, data.streamable == false and "Not in this subscription" or "No stream link")
            return
        end
        local mime = tostring(data.mime_type or "")
        local codec = "flac"
        if mime:find("mpeg") or mime:find("mp3") or format_id() == 5 then codec = "mp3" end
        local rate = tonumber(data.sampling_rate) or track.sample_rate or 0
        if rate > 0 and rate < 1000 then rate = math.floor(rate * 1000 + 0.5) end
        callback({
            provider = "qobuz",
            track_id = track.id,
            stream_url = data.url,
            title = clip_utf8(track.title, 127),
            artist = clip_utf8(track.artist, 127),
            album = clip_utf8(track.album, 127),
            duration_ms = math.floor((tonumber(data.duration) or track.duration or 0) * 1000),
            artwork_url = track.cover,
            codec = codec,
            sample_rate = rate,
            bit_depth = tonumber(data.bit_depth) or track.bit_depth or 16,
            channels = tonumber(data.channels) or track.channels,
            bitrate_kbps = tonumber(data.bitrate_kbps or data.bit_rate) or track.bitrate_kbps,
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
    if provider ~= "qobuz" then return end
    -- After a plugin reload the queue outlives remote_tracks; the id is enough.
    local track = remote_tracks[tostring(track_id)] or { id = track_id }
    local generation = playback_generation
    file_url(track, function(remote, err)
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
        toast("Not in this subscription")
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
            provider = "qobuz",
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

local function play_these(tracks, start_index)
    queue_on_demand(tracks, start_index or 1, start_index ~= nil)
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
    if #rows == 0 then
        toast("No tracks")
        return
    end
    local shown = { { label = tr("Play these"), play_all = true } }
    for i = 1, math.min(#rows, BROWSE_CAP) do shown[#shown + 1] = rows[i] end
    show_rows(title, shown, function(row)
        if row.play_all then
            play_these(rows)
        else
            for i, candidate in ipairs(rows) do
                if candidate == row then
                    play_these(rows, i)
                    break
                end
            end
        end
    end)
end

local function open_album(album, offset, depth, parent)
    offset = offset or 0
    local generation = browse_generation
    local all, hint = {}, album
    local function fetch(page_offset, active_handle)
        qobuz_get("/album/get?app_id=" .. url_encode(APP_ID)
            .. "&album_id=" .. url_encode(album.id) .. "&limit=" .. PAGE .. "&offset=" .. page_offset,
            nil, function(data, err)
            if generation ~= browse_generation or not parent_showing(active_handle or parent) then return end
            if not data then
                toast(err)
                show_browse_retry(active_handle or parent, function(retry_handle) fetch(page_offset, retry_handle) end)
                return
            end
            hint = album_from(data) or hint
            local page = items_of(data.tracks)
            for _, obj in ipairs(page) do all[#all + 1] = obj end
            if #page == PAGE and #all < TRACK_FETCH_CAP
                and ((hint.count or 0) == 0 or page_offset + PAGE < hint.count) then
                fetch(page_offset + PAGE, active_handle)
            else
                show_tracks(hint.title, track_rows(all, hint))
            end
        end)
    end
    fetch(offset)
end

local function open_playlist(playlist, offset, depth, parent)
    offset = offset or 0
    local generation = browse_generation
    local all = {}
    local function fetch(page_offset, active_handle)
        qobuz_get("/playlist/get?app_id=" .. url_encode(APP_ID)
            .. "&playlist_id=" .. url_encode(playlist.id)
            .. "&extra=tracks&limit=" .. PAGE .. "&offset=" .. page_offset, nil, function(data, err)
            if generation ~= browse_generation or not parent_showing(active_handle or parent) then return end
            if not data then
                toast(err)
                show_browse_retry(active_handle or parent, function(retry_handle) fetch(page_offset, retry_handle) end)
                return
            end
            local page = items_of(data.tracks)
            for _, obj in ipairs(page) do all[#all + 1] = obj end
            if #page == PAGE and #all < TRACK_FETCH_CAP then fetch(page_offset + PAGE, active_handle)
            else show_tracks(playlist.name, track_rows(all)) end
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

-- Fetches up to cap items in pages of PAGE into one list, so paging never
-- adds a screen. done(items) runs only while parent is still in front.
local function fetch_pages(path_for, items_of_page, cap, parent, done)
    local generation, all = browse_generation, {}
    local function fetch(offset, active_handle)
        qobuz_get(path_for(offset), nil, function(data, err)
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
    fetch(0)
end

local function albums_from(list)
    local albums = {}
    for _, obj in ipairs(list) do
        local album = album_from(obj)
        if album then albums[#albums + 1] = album end
    end
    return albums
end

local function search_albums(query, depth, parent)
    fetch_pages(function(offset)
        return "/album/search?app_id=" .. url_encode(APP_ID)
            .. "&query=" .. url_encode(query) .. "&limit=" .. PAGE .. "&offset=" .. offset
    end, function(data) return items_of(data.albums) end, SEARCH_CAP, parent, function(list)
        show_albums(tr("Albums"), albums_from(list), depth)
    end)
end

local function search_tracks(query, depth, parent)
    fetch_pages(function(offset)
        return "/track/search?app_id=" .. url_encode(APP_ID)
            .. "&query=" .. url_encode(query) .. "&limit=" .. PAGE .. "&offset=" .. offset
    end, function(data) return items_of(data.tracks) end, SEARCH_CAP, parent, function(list)
        show_tracks(tr("Tracks"), track_rows(list))
    end)
end

local function open_artist(artist, offset, depth, parent)
    depth = depth or 3
    local generation, albums = browse_generation, {}
    local function fetch(page_offset, page_number, active_handle)
        qobuz_get("/artist/get?app_id=" .. url_encode(APP_ID)
            .. "&artist_id=" .. url_encode(artist.id)
            .. "&extra=albums&limit=" .. PAGE .. "&offset=" .. page_offset, nil, function(data, err)
            if generation ~= browse_generation or not parent_showing(active_handle or parent) then return end
            if not data then
                toast(err)
                show_browse_retry(active_handle or parent, function(retry_handle)
                    fetch(page_offset, page_number, retry_handle)
                end)
                return
            end
            local page = items_of(data.albums)
            for _, obj in ipairs(page) do
                local album = album_from(obj)
                if album then albums[#albums + 1] = album end
            end
            if #page == PAGE and page_number < BROWSE_CAP / PAGE then fetch(page_offset + PAGE, page_number + 1, active_handle)
            else show_albums(artist.name, albums, depth) end
        end)
    end
    fetch(offset or 0, 1)
end

local function search_artists(query, depth, parent)
    fetch_pages(function(offset)
        return "/artist/search?app_id=" .. url_encode(APP_ID)
            .. "&query=" .. url_encode(query) .. "&limit=" .. PAGE .. "&offset=" .. offset
    end, function(data) return items_of(data.artists) end, SEARCH_CAP, parent, function(list)
        local rows = {}
        for _, obj in ipairs(list) do
            local artist = artist_from(obj)
            if artist then artist.label = artist.name; rows[#rows + 1] = artist end
        end
        if #rows == 0 then toast("No artists"); return end
        show_rows(tr("Artists"), rows, function(artist, handle)
            if depth < 4 then open_artist(artist, 0, depth + 1, handle) end
        end)
    end)
end

local function ask_query(title, search, parent)
    -- The text input is still in front while this runs; the search checks
    -- parent when its results arrive.
    local ok, err = plugin.show_text_input(title, nil, false, function(query)
        if not query or query == "" then return end
        search(query, 2, parent)
    end)
    if ok == false then toast(err or "Text input is busy") end
end

local function favorite_tracks(depth, parent)
    fetch_pages(function(offset)
        return "/favorite/getUserFavorites?app_id=" .. url_encode(APP_ID)
            .. "&type=tracks&limit=" .. PAGE .. "&offset=" .. offset
    end, function(data) return items_of(data.tracks) end, BROWSE_CAP, parent, function(list)
        show_tracks(tr("Favorite tracks"), track_rows(list))
    end)
end

local function favorite_albums(depth, parent)
    fetch_pages(function(offset)
        return "/favorite/getUserFavorites?app_id=" .. url_encode(APP_ID)
            .. "&type=albums&limit=" .. PAGE .. "&offset=" .. offset
    end, function(data) return items_of(data.albums) end, BROWSE_CAP, parent, function(list)
        show_albums(tr("Favorite albums"), albums_from(list), depth)
    end)
end

local function show_playlists(depth, parent)
    fetch_pages(function(offset)
        return "/playlist/getUserPlaylists?app_id=" .. url_encode(APP_ID)
            .. "&limit=" .. PAGE .. "&offset=" .. offset
    end, function(data) return items_of(data.playlists) end, BROWSE_CAP, parent, function(list)
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

local function show_new(depth, parent)
    fetch_pages(function(offset)
        return "/album/getFeatured?app_id=" .. url_encode(APP_ID)
            .. "&type=new-releases&limit=" .. PAGE .. "&offset=" .. offset
    end, function(data) return items_of(data.albums) end, SEARCH_CAP, parent, function(list)
        show_albums(tr("New releases"), albums_from(list), depth)
    end)
end

local function choose_quality(parent)
    if not parent_showing(parent) then return end
    local labels = {}
    for i, format in ipairs(FORMATS) do labels[i] = tr(format.label) end
    show_list(tr("Quality"), labels, function(index)
        plugin.storage.set("format_id", tostring(FORMATS[index].id))
        toast("Quality updated")
    end, { selected = format_index() })
end

local function logout()
    auth_generation = auth_generation + 1
    playback_generation = playback_generation + 1
    browse_generation = browse_generation + 1
    plugin.storage.delete("auth_token")
    plugin.storage.delete("display_name")
    toast("Logged out of Qobuz")
end

local prompt_login

local function show_home()
    show_list(tr("Qobuz"), {
        tr("Search tracks"),
        tr("Search albums"),
        tr("Search artists"),
        tr("New releases"),
        tr("Favorite tracks"),
        tr("Favorite albums"),
        tr("Playlists"),
        tr("Quality"),
        tr("Sign in or log out"),
    }, function(index, handle)
        if index >= 1 and index <= 7 and not stored("auth_token") then
            prompt_login()
            return
        end
        if index == 1 then ask_query(tr("Search tracks"), search_tracks, handle)
        elseif index == 2 then ask_query(tr("Search albums"), search_albums, handle)
        elseif index == 3 then ask_query(tr("Search artists"), search_artists, handle)
        elseif index == 4 then show_new(2, handle)
        elseif index == 5 then favorite_tracks(2, handle)
        elseif index == 6 then favorite_albums(2, handle)
        elseif index == 7 then show_playlists(2, handle)
        elseif index == 8 then choose_quality(handle)
        else
            if stored("auth_token") then logout() else prompt_login() end
        end
    end)
end

local function finish_login(data, fallback_name)
    if not data.user_auth_token or data.user_auth_token == "" then
        toast("Qobuz did not return a session")
        return
    end
    local name = fallback_name
    if type(data.user) == "table" then
        name = data.user.display_name or data.user.login or data.user.email or name
    end
    browse_generation = browse_generation + 1
    plugin.storage.set("auth_token", data.user_auth_token)
    plugin.storage.set("display_name", name or "Qobuz")
    toast("Logged in as " .. (name or "Qobuz"))
end

local function do_login(email, password)
    -- The password goes in a header, not the query, and is not written down.
    -- device_manufacturer_id carries the app secret.
    auth_generation = auth_generation + 1
    local generation = auth_generation
    qobuz_get("/user/login?app_id=" .. url_encode(APP_ID), {
        username = email,
        password = password,
        device_manufacturer_id = APP_SECRET,
    }, function(data, err)
        if generation ~= auth_generation then return end
        if not data then toast(err) return end
        finish_login(data, email)
    end)
end

prompt_login = function()
    local ok, err = plugin.show_text_input(tr("Qobuz email"), nil, false, function(email)
        if not email or email == "" then return end
        plugin.show_text_input(tr("Qobuz password"), nil, true, function(password)
            if not password or password == "" then return end
            do_login(email, password)
        end)
    end)
    if ok == false then toast(err or "Text input is busy") end
end

local function open_qobuz()
    if not stored("auth_token") then
        show_home()
        prompt_login()
        return
    end
    show_home()
end

plugin.register_stream_media_tile(tr("Qobuz"), open_qobuz, "stream_media/qobuz_row.png")
