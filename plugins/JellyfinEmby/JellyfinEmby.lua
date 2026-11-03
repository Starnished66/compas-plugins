plugin.define({
    id = "compas.jellyfin_emby",
    name = "Jellyfin & Emby",
    version = "1.3.0",
    api_min = 19,
})

local T = {
    de = {
        ["Jellyfin & Emby"] = "Jellyfin & Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Jellyfin & Emby erfordert Remote-Wiedergabe",
        ["Missing or invalid server URL"] = "Fehlende oder ungültige Server-URL",
        ["Server URL contains control characters"] = "Server-URL enthält Steuerzeichen",
        ["Server URL cannot contain whitespace"] = "Server-URL darf keine Leerzeichen enthalten",
        ["Credentials (userinfo) not allowed in server URL"] = "Zugangsdaten in der Server-URL nicht erlaubt",
        ["Query string not allowed in base server URL"] = "Abfrageparameter in der Basis-Server-URL nicht erlaubt",
        ["Fragment not allowed in base server URL"] = "Fragment in der Basis-Server-URL nicht erlaubt",
        ["Unsupported URL scheme; must be http or https"] = "Nicht unterstütztes URL-Schema; muss http oder https sein",
        ["Missing host in server URL"] = "Host fehlt in der Server-URL",
        ["Invalid IPv6 address in server URL"] = "Ungültige IPv6-Adresse in der Server-URL",
        ["Invalid host in server URL"] = "Ungültiger Host in der Server-URL",
        ["Invalid port number; must be 1-65535"] = "Ungültiger Port; muss 1-65535 sein",
        ["Invalid IPv4 address in server URL"] = "Ungültige IPv4-Adresse in der Server-URL",
        ["Host name exceeds 253 characters"] = "Hostname überschreitet 253 Zeichen",
        ["Host label must be between 1 and 63 characters"] = "Host-Abschnitt muss 1 bis 63 Zeichen lang sein",
        ["Host domain label cannot start or end with hyphen"] = "Host-Abschnitt darf nicht mit Bindestrich beginnen oder enden",
        ["Invalid characters in host name"] = "Ungültige Zeichen im Hostnamen",
        ["Request failed"] = "Anfrage fehlgeschlagen",
        ["Unknown Artist"] = "Unbekannter Künstler",
        ["Unknown Album"] = "Unbekanntes Album",
        ["Unknown Track"] = "Unbekannter Titel",
        ["HTTP request threw an error"] = "HTTP-Anfrage hat einen Fehler ausgelöst",
        ["Failed to start HTTP request"] = "HTTP-Anfrage konnte nicht gestartet werden",
        ["Not logged in"] = "Nicht angemeldet",
        ["Server URL not configured"] = "Server-URL nicht konfiguriert",
        ["Signed out"] = "Abgemeldet",
        ["Network error: %s"] = "Netzwerkfehler: %s",
        ["Session expired - please log in again"] = "Sitzung abgelaufen – bitte erneut anmelden",
        ["Unauthorized (401)"] = "Nicht autorisiert (401)",
        ["HTTP error %s"] = "HTTP-Fehler %s",
        ["JSON decode error: %s"] = "JSON-Dekodierfehler: %s",
        ["Invalid server URL"] = "Ungültige Server-URL",
        ["Please enter a username"] = "Bitte Benutzernamen eingeben",
        ["Failed to save server URL"] = "Server-URL konnte nicht gespeichert werden",
        ["Failed to save username"] = "Benutzername konnte nicht gespeichert werden",
        ["Login failed: %s"] = "Anmeldung fehlgeschlagen: %s",
        ["Invalid username or password"] = "Ungültiger Benutzername oder Passwort",
        ["Login failed (HTTP %s)"] = "Anmeldung fehlgeschlagen (HTTP %s)",
        ["Invalid server response"] = "Ungültige Serverantwort",
        ["Login failed: missing access token or user ID"] = "Anmeldung fehlgeschlagen: Token oder Benutzer-ID fehlt",
        ["Secure storage unavailable"] = "Sicherer Speicher nicht verfügbar",
        ["Failed to store access token safely"] = "Zugriffstoken konnte nicht sicher gespeichert werden",
        ["Failed to save user profile"] = "Benutzerprofil konnte nicht gespeichert werden",
        ["Logged in as %s"] = "Angemeldet als %s",
        ["Logged out"] = "Abgemeldet",
        ["Invalid track item"] = "Ungültiges Titelelement",
        ["Unsupported stream protocol: %s"] = "Nicht unterstütztes Stream-Protokoll: %s",
        ["HLS streams not supported for direct playback"] = "HLS-Streams für direkte Wiedergabe nicht unterstützt",
        ["Live streams not supported for direct playback"] = "Livestreams für direkte Wiedergabe nicht unterstützt",
        ["DRM or protected media not supported"] = "DRM-geschützte Medien nicht unterstützt",
        ["Incompatible codec: %s"] = "Inkompatibler Codec: %s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "FLAC in Nicht-FLAC-Container (%s) nicht unterstützt",
        ["MP3 in non-MP3 container (%s) unsupported"] = "MP3 in Nicht-MP3-Container (%s) nicht unterstützt",
        ["AAC in unsupported container (%s)"] = "AAC in nicht unterstütztem Container (%s)",
        ["No compatible audio stream found"] = "Kein kompatibler Audiostream gefunden",
        ["Failed to resolve track details: %s"] = "Titeldetails konnten nicht geladen werden: %s",
        ["Unsupported audio format"] = "Nicht unterstütztes Audioformat",
        ["No stream link"] = "Kein Stream-Link",
        ["Unsupported format"] = "Nicht unterstütztes Format",
        ["Please log in first"] = "Bitte zuerst anmelden",
        ["Playing: %s"] = "Spielt: %s",
        ["track"] = "Titel",
        ["No tracks to play"] = "Keine Titel zum Abspielen",
        ["Selected track not found in list"] = "Ausgewählter Titel nicht in der Liste gefunden",
        ["Queued %d tracks"] = "%d Titel eingereiht",
        ["Preparing playback"] = "Wiedergabe wird vorbereitet",
        ["No compatible playable tracks found"] = "Keine kompatiblen abspielbaren Titel gefunden",
        ["Queued %d tracks (%d unsupported skipped)"] = "%d Titel eingereiht (%d nicht unterstützte übersprungen)",
        ["Selected track is unsupported: %s"] = "Ausgewählter Titel nicht unterstützt: %s",
        ["format"] = "Format",
        ["Format inspection unsupported on this build"] = "Formatprüfung in dieser Version nicht unterstützt",
        ["No active track is currently playing"] = "Derzeit wird kein aktiver Titel abgespielt",
        ["N/A (compressed)"] = "k. A. (komprimiert)",
        ["%d bit"] = "%d Bit",
        ["Forward-only (Not seekable)"] = "Nur vorwärts (nicht spulbar)",
        ["Seekable (Confirmed by player Range)"] = "Spulbar (durch Player-Range bestätigt)",
        ["unknown"] = "unbekannt",
        ["Codec: %s"] = "Codec: %s",
        ["Sample Rate: %d Hz"] = "Abtastrate: %d Hz",
        ["Bit Depth: %s"] = "Bittiefe: %s",
        ["Channels: %d"] = "Kanäle: %d",
        ["Bitrate: %d kbps"] = "Bitrate: %d kbit/s",
        ["Stream Source: %s"] = "Stream-Quelle: %s",
        ["Yes (HTTP)"] = "Ja (HTTP)",
        ["No (Local)"] = "Nein (Lokal)",
        ["Native Range Seeking: %s"] = "Natives Range-Spulen: %s",
        ["Volume Gain: %.2f"] = "Lautstärkeverstärkung: %.2f",
        ["Playback Format"] = "Wiedergabeformat",
        ["Password"] = "Passwort",
        ["Saved Servers"] = "Gespeicherte Server",
        ["No saved servers"] = "Keine gespeicherten Server",
        ["Add one in Settings."] = "Füge einen in den Einstellungen hinzu.",
        ["Server URL"] = "Server-URL",
        ["Username"] = "Benutzername",
        ["Remove %s?"] = "%s entfernen?",
        ["Remove"] = "Entfernen",
        ["Server removed"] = "Server entfernt",
        ["Remove Server"] = "Server entfernen",
        ["Add Server"] = "Server hinzufügen",
        ["New server type: %s"] = "Neuer Servertyp: %s",
        ["Failed to save server type"] = "Servertyp konnte nicht gespeichert werden",
        ["Verify HTTPS TLS"] = "HTTPS-TLS prüfen",
        ["Failed to save TLS setting"] = "TLS-Einstellung konnte nicht gespeichert werden",
        ["Page Size: %s items"] = "Seitengröße: %s Einträge",
        ["Failed to save page size"] = "Seitengröße konnte nicht gespeichert werden",
        ["Music"] = "Musik",
        ["Search %s"] = "%s durchsuchen",
        ["Back"] = "Zurück",
        ["Unnamed Library"] = "Unbenannte Bibliothek",
        ["Search Music"] = "Musik durchsuchen",
        ["Settings"] = "Einstellungen",
        ["Music Libraries"] = "Musikbibliotheken",
        ["Library"] = "Bibliothek",
        ["Artists"] = "Künstler",
        ["Albums"] = "Alben",
        ["Songs"] = "Titel",
        ["Search in Library"] = "In Bibliothek suchen",
        ["Previous page"] = "Vorherige Seite",
        ["Next page"] = "Nächste Seite",
        ["Artists (%d-%d / %d)"] = "Künstler (%d-%d / %d)",
        ["Artist"] = "Künstler",
        ["%s Albums (%d-%d / %d)"] = "%s – Alben (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "Alben (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "Seite abspielen (%d von %d Titeln)",
        ["Play album (%d tracks)"] = "Album abspielen (%d Titel)",
        ["Album Tracks"] = "Albumtitel",
        ["Songs (%d-%d / %d)"] = "Titel (%d-%d / %d)",
        ["Item"] = "Eintrag",
        ["Song"] = "Titel",
        ["Album"] = "Album",
        ["(No results found)"] = "(Keine Ergebnisse gefunden)",
        ["Search: %s"] = "Suche: %s",
    },
    es = {
        ["Jellyfin & Emby"] = "Jellyfin y Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Jellyfin y Emby requiere reproducción remota",
        ["Missing or invalid server URL"] = "URL del servidor ausente o no válida",
        ["Server URL contains control characters"] = "La URL del servidor contiene caracteres de control",
        ["Server URL cannot contain whitespace"] = "La URL del servidor no puede contener espacios",
        ["Credentials (userinfo) not allowed in server URL"] = "No se permiten credenciales en la URL del servidor",
        ["Query string not allowed in base server URL"] = "No se permiten parámetros de consulta en la URL base",
        ["Fragment not allowed in base server URL"] = "No se permiten fragmentos en la URL base",
        ["Unsupported URL scheme; must be http or https"] = "Esquema de URL no soportado; debe ser http o https",
        ["Missing host in server URL"] = "Falta el host en la URL del servidor",
        ["Invalid IPv6 address in server URL"] = "Dirección IPv6 no válida en la URL del servidor",
        ["Invalid host in server URL"] = "Host no válido en la URL del servidor",
        ["Invalid port number; must be 1-65535"] = "Puerto no válido; debe ser 1-65535",
        ["Invalid IPv4 address in server URL"] = "Dirección IPv4 no válida en la URL del servidor",
        ["Host name exceeds 253 characters"] = "El nombre del host supera los 253 caracteres",
        ["Host label must be between 1 and 63 characters"] = "La etiqueta del host debe tener entre 1 y 63 caracteres",
        ["Host domain label cannot start or end with hyphen"] = "El dominio no puede empezar ni terminar con guion",
        ["Invalid characters in host name"] = "Caracteres no válidos en el nombre del host",
        ["Request failed"] = "Error en la solicitud",
        ["Unknown Artist"] = "Artista desconocido",
        ["Unknown Album"] = "Álbum desconocido",
        ["Unknown Track"] = "Pista desconocida",
        ["HTTP request threw an error"] = "La solicitud HTTP produjo un error",
        ["Failed to start HTTP request"] = "No se pudo iniciar la solicitud HTTP",
        ["Not logged in"] = "Sesión no iniciada",
        ["Server URL not configured"] = "URL del servidor no configurada",
        ["Signed out"] = "Sesión cerrada",
        ["Network error: %s"] = "Error de red: %s",
        ["Session expired - please log in again"] = "Sesión caducada; vuelve a iniciar sesión",
        ["Unauthorized (401)"] = "No autorizado (401)",
        ["HTTP error %s"] = "Error HTTP %s",
        ["JSON decode error: %s"] = "Error al decodificar JSON: %s",
        ["Invalid server URL"] = "URL del servidor no válida",
        ["Please enter a username"] = "Introduce un nombre de usuario",
        ["Failed to save server URL"] = "No se pudo guardar la URL del servidor",
        ["Failed to save username"] = "No se pudo guardar el nombre de usuario",
        ["Login failed: %s"] = "Error al iniciar sesión: %s",
        ["Invalid username or password"] = "Usuario o contraseña no válidos",
        ["Login failed (HTTP %s)"] = "Error al iniciar sesión (HTTP %s)",
        ["Invalid server response"] = "Respuesta del servidor no válida",
        ["Login failed: missing access token or user ID"] = "Error al iniciar sesión: falta token o ID de usuario",
        ["Secure storage unavailable"] = "Almacenamiento seguro no disponible",
        ["Failed to store access token safely"] = "No se pudo guardar el token de forma segura",
        ["Failed to save user profile"] = "No se pudo guardar el perfil de usuario",
        ["Logged in as %s"] = "Sesión iniciada como %s",
        ["Logged out"] = "Sesión cerrada",
        ["Invalid track item"] = "Elemento de pista no válido",
        ["Unsupported stream protocol: %s"] = "Protocolo de transmisión no soportado: %s",
        ["HLS streams not supported for direct playback"] = "Transmisiones HLS no soportadas para reproducción directa",
        ["Live streams not supported for direct playback"] = "Transmisiones en vivo no soportadas para reproducción directa",
        ["DRM or protected media not supported"] = "Medios con DRM o protegidos no soportados",
        ["Incompatible codec: %s"] = "Códec incompatible: %s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "FLAC en contenedor no FLAC (%s) no soportado",
        ["MP3 in non-MP3 container (%s) unsupported"] = "MP3 en contenedor no MP3 (%s) no soportado",
        ["AAC in unsupported container (%s)"] = "AAC en contenedor no soportado (%s)",
        ["No compatible audio stream found"] = "No se encontró flujo de audio compatible",
        ["Failed to resolve track details: %s"] = "No se pudieron obtener los detalles de la pista: %s",
        ["Unsupported audio format"] = "Formato de audio no soportado",
        ["No stream link"] = "Sin enlace de reproducción",
        ["Unsupported format"] = "Formato no soportado",
        ["Please log in first"] = "Inicia sesión primero",
        ["Playing: %s"] = "Reproduciendo: %s",
        ["track"] = "pista",
        ["No tracks to play"] = "No hay pistas para reproducir",
        ["Selected track not found in list"] = "Pista seleccionada no encontrada en la lista",
        ["Queued %d tracks"] = "%d pistas en cola",
        ["Preparing playback"] = "Preparando reproducción",
        ["No compatible playable tracks found"] = "No se encontraron pistas compatibles reproducibles",
        ["Queued %d tracks (%d unsupported skipped)"] = "%d pistas en cola (%d no soportadas omitidas)",
        ["Selected track is unsupported: %s"] = "La pista seleccionada no está soportada: %s",
        ["format"] = "formato",
        ["Format inspection unsupported on this build"] = "Inspección de formato no soportada en esta versión",
        ["No active track is currently playing"] = "No hay ninguna pista activa reproduciéndose",
        ["N/A (compressed)"] = "N/D (comprimido)",
        ["%d bit"] = "%d bits",
        ["Forward-only (Not seekable)"] = "Solo avance (sin búsqueda)",
        ["Seekable (Confirmed by player Range)"] = "Con búsqueda (confirmado por Range)",
        ["unknown"] = "desconocido",
        ["Codec: %s"] = "Códec: %s",
        ["Sample Rate: %d Hz"] = "Frecuencia de muestreo: %d Hz",
        ["Bit Depth: %s"] = "Profundidad de bits: %s",
        ["Channels: %d"] = "Canales: %d",
        ["Bitrate: %d kbps"] = "Tasa de bits: %d kbps",
        ["Stream Source: %s"] = "Origen del flujo: %s",
        ["Yes (HTTP)"] = "Sí (HTTP)",
        ["No (Local)"] = "No (Local)",
        ["Native Range Seeking: %s"] = "Búsqueda por rango nativa: %s",
        ["Volume Gain: %.2f"] = "Ganancia de volumen: %.2f",
        ["Playback Format"] = "Formato de reproducción",
        ["Password"] = "Contraseña",
        ["Saved Servers"] = "Servidores guardados",
        ["No saved servers"] = "No hay servidores guardados",
        ["Add one in Settings."] = "Añade uno en Ajustes.",
        ["Server URL"] = "URL del servidor",
        ["Username"] = "Usuario",
        ["Remove %s?"] = "¿Eliminar %s?",
        ["Remove"] = "Eliminar",
        ["Server removed"] = "Servidor eliminado",
        ["Remove Server"] = "Eliminar servidor",
        ["Add Server"] = "Añadir servidor",
        ["New server type: %s"] = "Tipo de servidor nuevo: %s",
        ["Failed to save server type"] = "No se pudo guardar el tipo de servidor",
        ["Verify HTTPS TLS"] = "Verificar HTTPS TLS",
        ["Failed to save TLS setting"] = "No se pudo guardar el ajuste TLS",
        ["Page Size: %s items"] = "Tamaño de página: %s elementos",
        ["Failed to save page size"] = "No se pudo guardar el tamaño de página",
        ["Music"] = "Música",
        ["Search %s"] = "Buscar en %s",
        ["Back"] = "Atrás",
        ["Unnamed Library"] = "Biblioteca sin nombre",
        ["Search Music"] = "Buscar música",
        ["Settings"] = "Ajustes",
        ["Music Libraries"] = "Bibliotecas de música",
        ["Library"] = "Biblioteca",
        ["Artists"] = "Artistas",
        ["Albums"] = "Álbumes",
        ["Songs"] = "Canciones",
        ["Search in Library"] = "Buscar en la biblioteca",
        ["Previous page"] = "Página anterior",
        ["Next page"] = "Página siguiente",
        ["Artists (%d-%d / %d)"] = "Artistas (%d-%d / %d)",
        ["Artist"] = "Artista",
        ["%s Albums (%d-%d / %d)"] = "Álbumes de %s (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "Álbumes (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "Reproducir página (%d de %d pistas)",
        ["Play album (%d tracks)"] = "Reproducir álbum (%d pistas)",
        ["Album Tracks"] = "Pistas del álbum",
        ["Songs (%d-%d / %d)"] = "Canciones (%d-%d / %d)",
        ["Item"] = "Elemento",
        ["Song"] = "Canción",
        ["Album"] = "Álbum",
        ["(No results found)"] = "(No se encontraron resultados)",
        ["Search: %s"] = "Búsqueda: %s",
    },
    fi = {
        ["Jellyfin & Emby"] = "Jellyfin & Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Jellyfin & Emby vaatii etätoiston",
        ["Missing or invalid server URL"] = "Puuttuva tai virheellinen palvelimen URL",
        ["Server URL contains control characters"] = "Palvelimen URL sisältää ohjausmerkkejä",
        ["Server URL cannot contain whitespace"] = "Palvelimen URL ei saa sisältää välilyöntejä",
        ["Credentials (userinfo) not allowed in server URL"] = "Tunnistetiedot eivät ole sallittuja palvelimen URL:ssa",
        ["Query string not allowed in base server URL"] = "Kyselymerkkijono ei ole sallittu palvelimen perus-URL:ssa",
        ["Fragment not allowed in base server URL"] = "Fragmentti ei ole sallittu palvelimen perus-URL:ssa",
        ["Unsupported URL scheme; must be http or https"] = "URL-skeemaa ei tueta; oltava http tai https",
        ["Missing host in server URL"] = "Palvelimen URL:sta puuttuu isäntänimi",
        ["Invalid IPv6 address in server URL"] = "Virheellinen IPv6-osoite palvelimen URL:ssa",
        ["Invalid host in server URL"] = "Virheellinen isäntänimi palvelimen URL:ssa",
        ["Invalid port number; must be 1-65535"] = "Virheellinen porttinumero; oltava 1-65535",
        ["Invalid IPv4 address in server URL"] = "Virheellinen IPv4-osoite palvelimen URL:ssa",
        ["Host name exceeds 253 characters"] = "Isäntänimi ylittää 253 merkkiä",
        ["Host label must be between 1 and 63 characters"] = "Isäntänimen osan on oltava 1–63 merkkiä",
        ["Host domain label cannot start or end with hyphen"] = "Verkkotunnuksen osa ei voi alkaa tai päättyä yhdysviivaan",
        ["Invalid characters in host name"] = "Virheellisiä merkkejä isäntänimessä",
        ["Request failed"] = "Pyyntö epäonnistui",
        ["Unknown Artist"] = "Tuntematon artisti",
        ["Unknown Album"] = "Tuntematon albumi",
        ["Unknown Track"] = "Tuntematon kappale",
        ["HTTP request threw an error"] = "HTTP-pyyntö aiheutti virheen",
        ["Failed to start HTTP request"] = "HTTP-pyynnön aloitus epäonnistui",
        ["Not logged in"] = "Ei kirjautuneena",
        ["Server URL not configured"] = "Palvelimen URL-osoitetta ei ole määritetty",
        ["Signed out"] = "Kirjauduttu ulos",
        ["Network error: %s"] = "Verkkovirhe: %s",
        ["Session expired - please log in again"] = "Istunto vanhentui – kirjaudu uudelleen",
        ["Unauthorized (401)"] = "Ei oikeuksia (401)",
        ["HTTP error %s"] = "HTTP-virhe %s",
        ["JSON decode error: %s"] = "JSON-purkuvirhe: %s",
        ["Invalid server URL"] = "Virheellinen palvelimen URL",
        ["Please enter a username"] = "Anna käyttäjätunnus",
        ["Failed to save server URL"] = "Palvelimen URL:n tallennus epäonnistui",
        ["Failed to save username"] = "Käyttäjätunnuksen tallennus epäonnistui",
        ["Login failed: %s"] = "Kirjautuminen epäonnistui: %s",
        ["Invalid username or password"] = "Virheellinen käyttäjätunnus tai salasana",
        ["Login failed (HTTP %s)"] = "Kirjautuminen epäonnistui (HTTP %s)",
        ["Invalid server response"] = "Virheellinen vastaus palvelimelta",
        ["Login failed: missing access token or user ID"] = "Kirjautuminen epäonnistui: istuntotunniste tai käyttäjä-ID puuttuu",
        ["Secure storage unavailable"] = "Suojattu tallennustila ei ole käytettävissä",
        ["Failed to store access token safely"] = "Istuntotunnisteen turvallinen tallennus epäonnistui",
        ["Failed to save user profile"] = "Käyttäjäprofiilin tallennus epäonnistui",
        ["Logged in as %s"] = "Kirjauduttu käyttäjänä %s",
        ["Logged out"] = "Kirjauduttu ulos",
        ["Invalid track item"] = "Virheellinen kappalekohde",
        ["Unsupported stream protocol: %s"] = "Suoratoistoprotokollaa ei tueta: %s",
        ["HLS streams not supported for direct playback"] = "HLS-virtoja ei tueta suorassa toistossa",
        ["Live streams not supported for direct playback"] = "Live-lähetyksiä ei tueta suorassa toistossa",
        ["DRM or protected media not supported"] = "DRM-suojattua mediaa ei tueta",
        ["Incompatible codec: %s"] = "Yhteensopimaton koodekki: %s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "FLAC muussa kuin FLAC-säiliössä (%s) ei tuettu",
        ["MP3 in non-MP3 container (%s) unsupported"] = "MP3 muussa kuin MP3-säiliössä (%s) ei tuettu",
        ["AAC in unsupported container (%s)"] = "AAC ei-tuetussa säiliössä (%s)",
        ["No compatible audio stream found"] = "Yhteensopivaa äänivirtaa ei löytynyt",
        ["Failed to resolve track details: %s"] = "Kappaleen tietojen haku epäonnistui: %s",
        ["Unsupported audio format"] = "Äänimuotoa ei tueta",
        ["No stream link"] = "Ei suoratoistolinkkiä",
        ["Unsupported format"] = "Muotoa ei tueta",
        ["Please log in first"] = "Kirjaudu ensin sisään",
        ["Playing: %s"] = "Toistetaan: %s",
        ["track"] = "kappale",
        ["No tracks to play"] = "Ei toistettavia kappaleita",
        ["Selected track not found in list"] = "Valittua kappaletta ei löytynyt listalta",
        ["Queued %d tracks"] = "%d kappaletta jonossa",
        ["Preparing playback"] = "Valmistellaan toistoa",
        ["No compatible playable tracks found"] = "Yhteensopivia toistettavia kappaleita ei löytynyt",
        ["Queued %d tracks (%d unsupported skipped)"] = "%d kappaletta jonossa (%d ei-tuettua ohitettu)",
        ["Selected track is unsupported: %s"] = "Valittua kappaletta ei tueta: %s",
        ["format"] = "muoto",
        ["Format inspection unsupported on this build"] = "Muodon tarkastelu ei ole tuettu tässä versiossa",
        ["No active track is currently playing"] = "Mikään kappale ei soi tällä hetkellä",
        ["N/A (compressed)"] = "Ei saatavilla (pakattu)",
        ["%d bit"] = "%d bit",
        ["Forward-only (Not seekable)"] = "Vain eteenpäin (ei kelattavissa)",
        ["Seekable (Confirmed by player Range)"] = "Kelattavissa (Range vahvistettu)",
        ["unknown"] = "tuntematon",
        ["Codec: %s"] = "Koodekki: %s",
        ["Sample Rate: %d Hz"] = "Näytteenottotaajuus: %d Hz",
        ["Bit Depth: %s"] = "Bittisyvyys: %s",
        ["Channels: %d"] = "Kanavat: %d",
        ["Bitrate: %d kbps"] = "Bittinopeus: %d kbps",
        ["Stream Source: %s"] = "Lähde: %s",
        ["Yes (HTTP)"] = "Kyllä (HTTP)",
        ["No (Local)"] = "Ei (Paikallinen)",
        ["Native Range Seeking: %s"] = "Natiivi Range-kelaus: %s",
        ["Volume Gain: %.2f"] = "Äänenvoimakkuuden vahvistus: %.2f",
        ["Playback Format"] = "Toistomuoto",
        ["Password"] = "Salasana",
        ["Saved Servers"] = "Tallennetut palvelimet",
        ["No saved servers"] = "Ei tallennettuja palvelimia",
        ["Add one in Settings."] = "Lisää palvelin asetuksissa.",
        ["Server URL"] = "Palvelimen URL",
        ["Username"] = "Käyttäjätunnus",
        ["Remove %s?"] = "Poistetaanko %s?",
        ["Remove"] = "Poista",
        ["Server removed"] = "Palvelin poistettu",
        ["Remove Server"] = "Poista palvelin",
        ["Add Server"] = "Lisää palvelin",
        ["New server type: %s"] = "Uuden palvelimen tyyppi: %s",
        ["Failed to save server type"] = "Palvelintyypin tallennus epäonnistui",
        ["Verify HTTPS TLS"] = "Varmenna HTTPS TLS",
        ["Failed to save TLS setting"] = "TLS-asetuksen tallennus epäonnistui",
        ["Page Size: %s items"] = "Sivukoko: %s kohdetta",
        ["Failed to save page size"] = "Sivukoon tallennus epäonnistui",
        ["Music"] = "Musiikki",
        ["Search %s"] = "Hae kohteesta %s",
        ["Back"] = "Takaisin",
        ["Unnamed Library"] = "Nimetön kirjasto",
        ["Search Music"] = "Hae musiikkia",
        ["Settings"] = "Asetukset",
        ["Music Libraries"] = "Musiikkikirjastot",
        ["Library"] = "Kirjasto",
        ["Artists"] = "Artistit",
        ["Albums"] = "Albumit",
        ["Songs"] = "Kappaleet",
        ["Search in Library"] = "Hae kirjastosta",
        ["Previous page"] = "Edellinen sivu",
        ["Next page"] = "Seuraava sivu",
        ["Artists (%d-%d / %d)"] = "Artistit (%d-%d / %d)",
        ["Artist"] = "Artisti",
        ["%s Albums (%d-%d / %d)"] = "%s – Albumit (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "Albumit (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "Toista sivu (%d / %d kappaletta)",
        ["Play album (%d tracks)"] = "Toista albumi (%d kappaletta)",
        ["Album Tracks"] = "Albumin kappaleet",
        ["Songs (%d-%d / %d)"] = "Kappaleet (%d-%d / %d)",
        ["Item"] = "Kohde",
        ["Song"] = "Kappale",
        ["Album"] = "Albumi",
        ["(No results found)"] = "(Ei tuloksia)",
        ["Search: %s"] = "Haku: %s",
    },
    fr = {
        ["Jellyfin & Emby"] = "Jellyfin & Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Jellyfin & Emby nécessite la lecture à distance",
        ["Missing or invalid server URL"] = "URL du serveur manquante ou invalide",
        ["Server URL contains control characters"] = "L'URL du serveur contient des caractères de contrôle",
        ["Server URL cannot contain whitespace"] = "L'URL du serveur ne peut pas contenir d'espaces",
        ["Credentials (userinfo) not allowed in server URL"] = "Identifiants non autorisés dans l'URL du serveur",
        ["Query string not allowed in base server URL"] = "Paramètres de requête non autorisés dans l'URL de base",
        ["Fragment not allowed in base server URL"] = "Fragment non autorisé dans l'URL de base",
        ["Unsupported URL scheme; must be http or https"] = "Schéma d'URL non pris en charge ; doit être http ou https",
        ["Missing host in server URL"] = "Hôte manquant dans l'URL du serveur",
        ["Invalid IPv6 address in server URL"] = "Adresse IPv6 invalide dans l'URL du serveur",
        ["Invalid host in server URL"] = "Hôte invalide dans l'URL du serveur",
        ["Invalid port number; must be 1-65535"] = "Numéro de port invalide ; doit être 1-65535",
        ["Invalid IPv4 address in server URL"] = "Adresse IPv4 invalide dans l'URL du serveur",
        ["Host name exceeds 253 characters"] = "Le nom d'hôte dépasse 253 caractères",
        ["Host label must be between 1 and 63 characters"] = "Le segment d'hôte doit contenir entre 1 et 63 caractères",
        ["Host domain label cannot start or end with hyphen"] = "Un segment de domaine ne peut ni commencer ni finir par un tiret",
        ["Invalid characters in host name"] = "Caractères invalides dans le nom d'hôte",
        ["Request failed"] = "Échec de la requête",
        ["Unknown Artist"] = "Artiste inconnu",
        ["Unknown Album"] = "Album inconnu",
        ["Unknown Track"] = "Titre inconnu",
        ["HTTP request threw an error"] = "La requête HTTP a généré une erreur",
        ["Failed to start HTTP request"] = "Impossible de lancer la requête HTTP",
        ["Not logged in"] = "Non connecté",
        ["Server URL not configured"] = "URL du serveur non configurée",
        ["Signed out"] = "Déconnecté",
        ["Network error: %s"] = "Erreur réseau : %s",
        ["Session expired - please log in again"] = "Session expirée – veuillez vous reconnecter",
        ["Unauthorized (401)"] = "Non autorisé (401)",
        ["HTTP error %s"] = "Erreur HTTP %s",
        ["JSON decode error: %s"] = "Erreur de décodage JSON : %s",
        ["Invalid server URL"] = "URL du serveur invalide",
        ["Please enter a username"] = "Veuillez entrer un nom d'utilisateur",
        ["Failed to save server URL"] = "Échec d'enregistrement de l'URL du serveur",
        ["Failed to save username"] = "Échec d'enregistrement du nom d'utilisateur",
        ["Login failed: %s"] = "Échec de connexion : %s",
        ["Invalid username or password"] = "Nom d'utilisateur ou mot de passe invalide",
        ["Login failed (HTTP %s)"] = "Échec de connexion (HTTP %s)",
        ["Invalid server response"] = "Réponse du serveur invalide",
        ["Login failed: missing access token or user ID"] = "Échec de connexion : jeton ou ID utilisateur manquant",
        ["Secure storage unavailable"] = "Stockage sécurisé indisponible",
        ["Failed to store access token safely"] = "Échec d'enregistrement sécurisé du jeton d'accès",
        ["Failed to save user profile"] = "Échec d'enregistrement du profil utilisateur",
        ["Logged in as %s"] = "Connecté en tant que %s",
        ["Logged out"] = "Déconnecté",
        ["Invalid track item"] = "Élément de piste invalide",
        ["Unsupported stream protocol: %s"] = "Protocole de flux non pris en charge : %s",
        ["HLS streams not supported for direct playback"] = "Flux HLS non pris en charge en lecture directe",
        ["Live streams not supported for direct playback"] = "Flux en direct non pris en charge en lecture directe",
        ["DRM or protected media not supported"] = "Médias protégés ou avec DRM non pris en charge",
        ["Incompatible codec: %s"] = "Codec incompatible : %s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "FLAC dans un conteneur non FLAC (%s) non pris en charge",
        ["MP3 in non-MP3 container (%s) unsupported"] = "MP3 dans un conteneur non MP3 (%s) non pris en charge",
        ["AAC in unsupported container (%s)"] = "AAC dans un conteneur non pris en charge (%s)",
        ["No compatible audio stream found"] = "Aucun flux audio compatible trouvé",
        ["Failed to resolve track details: %s"] = "Impossible d'obtenir les détails du titre : %s",
        ["Unsupported audio format"] = "Format audio non pris en charge",
        ["No stream link"] = "Aucun lien de flux",
        ["Unsupported format"] = "Format non pris en charge",
        ["Please log in first"] = "Veuillez d'abord vous connecter",
        ["Playing: %s"] = "Lecture : %s",
        ["track"] = "titre",
        ["No tracks to play"] = "Aucun titre à lire",
        ["Selected track not found in list"] = "Titre sélectionné introuvable dans la liste",
        ["Queued %d tracks"] = "%d titres mis en file d'attente",
        ["Preparing playback"] = "Préparation de la lecture",
        ["No compatible playable tracks found"] = "Aucun titre compatible lisible trouvé",
        ["Queued %d tracks (%d unsupported skipped)"] = "%d titres en file (%d non pris en charge ignorés)",
        ["Selected track is unsupported: %s"] = "Le titre sélectionné n'est pas pris en charge : %s",
        ["format"] = "format",
        ["Format inspection unsupported on this build"] = "Inspection du format non prise en charge sur cette version",
        ["No active track is currently playing"] = "Aucun titre actif en cours de lecture",
        ["N/A (compressed)"] = "N/D (compressé)",
        ["%d bit"] = "%d bits",
        ["Forward-only (Not seekable)"] = "Avance seule (non navigable)",
        ["Seekable (Confirmed by player Range)"] = "Navigable (confirmé par Range)",
        ["unknown"] = "inconnu",
        ["Codec: %s"] = "Codec : %s",
        ["Sample Rate: %d Hz"] = "Fréquence d'échantillonnage : %d Hz",
        ["Bit Depth: %s"] = "Profondeur de bits : %s",
        ["Channels: %d"] = "Canaux : %d",
        ["Bitrate: %d kbps"] = "Débit : %d kbps",
        ["Stream Source: %s"] = "Source du flux : %s",
        ["Yes (HTTP)"] = "Oui (HTTP)",
        ["No (Local)"] = "Non (Local)",
        ["Native Range Seeking: %s"] = "Recherche Range native : %s",
        ["Volume Gain: %.2f"] = "Gain de volume : %.2f",
        ["Playback Format"] = "Format de lecture",
        ["Password"] = "Mot de passe",
        ["Saved Servers"] = "Serveurs enregistrés",
        ["No saved servers"] = "Aucun serveur enregistré",
        ["Add one in Settings."] = "Ajoutez-en un dans Paramètres.",
        ["Server URL"] = "URL du serveur",
        ["Username"] = "Nom d'utilisateur",
        ["Remove %s?"] = "Supprimer %s ?",
        ["Remove"] = "Supprimer",
        ["Server removed"] = "Serveur supprimé",
        ["Remove Server"] = "Supprimer un serveur",
        ["Add Server"] = "Ajouter un serveur",
        ["New server type: %s"] = "Type du nouveau serveur : %s",
        ["Failed to save server type"] = "Échec d'enregistrement du type de serveur",
        ["Verify HTTPS TLS"] = "Vérifier HTTPS TLS",
        ["Failed to save TLS setting"] = "Échec d'enregistrement du réglage TLS",
        ["Page Size: %s items"] = "Taille de page : %s éléments",
        ["Failed to save page size"] = "Échec d'enregistrement de la taille de page",
        ["Music"] = "Musique",
        ["Search %s"] = "Rechercher dans %s",
        ["Back"] = "Retour",
        ["Unnamed Library"] = "Bibliothèque sans nom",
        ["Search Music"] = "Rechercher de la musique",
        ["Settings"] = "Paramètres",
        ["Music Libraries"] = "Bibliothèques musicales",
        ["Library"] = "Bibliothèque",
        ["Artists"] = "Artistes",
        ["Albums"] = "Albums",
        ["Songs"] = "Titres",
        ["Search in Library"] = "Rechercher dans la bibliothèque",
        ["Previous page"] = "Page précédente",
        ["Next page"] = "Page suivante",
        ["Artists (%d-%d / %d)"] = "Artistes (%d-%d / %d)",
        ["Artist"] = "Artiste",
        ["%s Albums (%d-%d / %d)"] = "Albums de %s (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "Albums (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "Lire la page (%d sur %d titres)",
        ["Play album (%d tracks)"] = "Lire l'album (%d titres)",
        ["Album Tracks"] = "Titres de l'album",
        ["Songs (%d-%d / %d)"] = "Titres (%d-%d / %d)",
        ["Item"] = "Élément",
        ["Song"] = "Titre",
        ["Album"] = "Album",
        ["(No results found)"] = "(Aucun résultat trouvé)",
        ["Search: %s"] = "Recherche : %s",
    },
    it = {
        ["Jellyfin & Emby"] = "Jellyfin & Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Jellyfin & Emby richiede la riproduzione remota",
        ["Missing or invalid server URL"] = "URL del server mancante o non valido",
        ["Server URL contains control characters"] = "L'URL del server contiene caratteri di controllo",
        ["Server URL cannot contain whitespace"] = "L'URL del server non può contenere spazi",
        ["Credentials (userinfo) not allowed in server URL"] = "Credenziali non consentite nell'URL del server",
        ["Query string not allowed in base server URL"] = "Stringa di query non consentita nell'URL base",
        ["Fragment not allowed in base server URL"] = "Frammento non consentito nell'URL base",
        ["Unsupported URL scheme; must be http or https"] = "Schema URL non supportato; deve essere http o https",
        ["Missing host in server URL"] = "Host mancante nell'URL del server",
        ["Invalid IPv6 address in server URL"] = "Indirizzo IPv6 non valido nell'URL del server",
        ["Invalid host in server URL"] = "Host non valido nell'URL del server",
        ["Invalid port number; must be 1-65535"] = "Numero di porta non valido; deve essere 1-65535",
        ["Invalid IPv4 address in server URL"] = "Indirizzo IPv4 non valido nell'URL del server",
        ["Host name exceeds 253 characters"] = "Il nome host supera 253 caratteri",
        ["Host label must be between 1 and 63 characters"] = "L'etichetta host deve avere tra 1 e 63 caratteri",
        ["Host domain label cannot start or end with hyphen"] = "L'etichetta di dominio non può iniziare o finire con un trattino",
        ["Invalid characters in host name"] = "Caratteri non validi nel nome host",
        ["Request failed"] = "Richiesta non riuscita",
        ["Unknown Artist"] = "Artista sconosciuto",
        ["Unknown Album"] = "Album sconosciuto",
        ["Unknown Track"] = "Brano sconosciuto",
        ["HTTP request threw an error"] = "La richiesta HTTP ha generato un errore",
        ["Failed to start HTTP request"] = "Impossibile avviare la richiesta HTTP",
        ["Not logged in"] = "Accesso non effettuato",
        ["Server URL not configured"] = "URL del server non configurato",
        ["Signed out"] = "Disconnesso",
        ["Network error: %s"] = "Errore di rete: %s",
        ["Session expired - please log in again"] = "Sessione scaduta - effettua di nuovo l'accesso",
        ["Unauthorized (401)"] = "Non autorizzato (401)",
        ["HTTP error %s"] = "Errore HTTP %s",
        ["JSON decode error: %s"] = "Errore di decodifica JSON: %s",
        ["Invalid server URL"] = "URL del server non valido",
        ["Please enter a username"] = "Inserisci un nome utente",
        ["Failed to save server URL"] = "Impossibile salvare l'URL del server",
        ["Failed to save username"] = "Impossibile salvare il nome utente",
        ["Login failed: %s"] = "Accesso non riuscito: %s",
        ["Invalid username or password"] = "Nome utente o password non validi",
        ["Login failed (HTTP %s)"] = "Accesso non riuscito (HTTP %s)",
        ["Invalid server response"] = "Risposta del server non valida",
        ["Login failed: missing access token or user ID"] = "Accesso non riuscito: token o ID utente mancante",
        ["Secure storage unavailable"] = "Archiviazione sicura non disponibile",
        ["Failed to store access token safely"] = "Impossibile salvare il token di accesso in modo sicuro",
        ["Failed to save user profile"] = "Impossibile salvare il profilo utente",
        ["Logged in as %s"] = "Accesso effettuato come %s",
        ["Logged out"] = "Disconnesso",
        ["Invalid track item"] = "Elemento brano non valido",
        ["Unsupported stream protocol: %s"] = "Protocollo di streaming non supportato: %s",
        ["HLS streams not supported for direct playback"] = "Stream HLS non supportati per la riproduzione diretta",
        ["Live streams not supported for direct playback"] = "Stream live non supportati per la riproduzione diretta",
        ["DRM or protected media not supported"] = "Contenuti protetti o con DRM non supportati",
        ["Incompatible codec: %s"] = "Codec incompatibile: %s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "FLAC in contenitore non FLAC (%s) non supportato",
        ["MP3 in non-MP3 container (%s) unsupported"] = "MP3 in contenitore non MP3 (%s) non supportato",
        ["AAC in unsupported container (%s)"] = "AAC in contenitore non supportato (%s)",
        ["No compatible audio stream found"] = "Nessuno stream audio compatibile trovato",
        ["Failed to resolve track details: %s"] = "Impossibile ottenere i dettagli del brano: %s",
        ["Unsupported audio format"] = "Formato audio non supportato",
        ["No stream link"] = "Nessun link di streaming",
        ["Unsupported format"] = "Formato non supportato",
        ["Please log in first"] = "Effettua prima l'accesso",
        ["Playing: %s"] = "In riproduzione: %s",
        ["track"] = "brano",
        ["No tracks to play"] = "Nessun brano da riprodurre",
        ["Selected track not found in list"] = "Brano selezionato non trovato nell'elenco",
        ["Queued %d tracks"] = "%d brani in coda",
        ["Preparing playback"] = "Preparazione della riproduzione",
        ["No compatible playable tracks found"] = "Nessun brano compatibile riproducibile trovato",
        ["Queued %d tracks (%d unsupported skipped)"] = "%d brani in coda (%d non supportati saltati)",
        ["Selected track is unsupported: %s"] = "Il brano selezionato non è supportato: %s",
        ["format"] = "formato",
        ["Format inspection unsupported on this build"] = "Ispezione formato non supportata su questa versione",
        ["No active track is currently playing"] = "Nessun brano attivo in riproduzione",
        ["N/A (compressed)"] = "N/D (compresso)",
        ["%d bit"] = "%d bit",
        ["Forward-only (Not seekable)"] = "Solo avanzamento (non ricercabile)",
        ["Seekable (Confirmed by player Range)"] = "Ricercabile (confermato da Range)",
        ["unknown"] = "sconosciuto",
        ["Codec: %s"] = "Codec: %s",
        ["Sample Rate: %d Hz"] = "Frequenza di campionamento: %d Hz",
        ["Bit Depth: %s"] = "Profondità in bit: %s",
        ["Channels: %d"] = "Canali: %d",
        ["Bitrate: %d kbps"] = "Bitrate: %d kbps",
        ["Stream Source: %s"] = "Sorgente stream: %s",
        ["Yes (HTTP)"] = "Sì (HTTP)",
        ["No (Local)"] = "No (Locale)",
        ["Native Range Seeking: %s"] = "Ricerca Range nativa: %s",
        ["Volume Gain: %.2f"] = "Guadagno volume: %.2f",
        ["Playback Format"] = "Formato di riproduzione",
        ["Password"] = "Password",
        ["Saved Servers"] = "Server salvati",
        ["No saved servers"] = "Nessun server salvato",
        ["Add one in Settings."] = "Aggiungine uno in Impostazioni.",
        ["Server URL"] = "URL del server",
        ["Username"] = "Nome utente",
        ["Remove %s?"] = "Rimuovere %s?",
        ["Remove"] = "Rimuovi",
        ["Server removed"] = "Server rimosso",
        ["Remove Server"] = "Rimuovi server",
        ["Add Server"] = "Aggiungi server",
        ["New server type: %s"] = "Tipo nuovo server: %s",
        ["Failed to save server type"] = "Impossibile salvare il tipo di server",
        ["Verify HTTPS TLS"] = "Verifica HTTPS TLS",
        ["Failed to save TLS setting"] = "Impossibile salvare l'impostazione TLS",
        ["Page Size: %s items"] = "Dimensione pagina: %s elementi",
        ["Failed to save page size"] = "Impossibile salvare la dimensione pagina",
        ["Music"] = "Musica",
        ["Search %s"] = "Cerca in %s",
        ["Back"] = "Indietro",
        ["Unnamed Library"] = "Libreria senza nome",
        ["Search Music"] = "Cerca musica",
        ["Settings"] = "Impostazioni",
        ["Music Libraries"] = "Librerie musicali",
        ["Library"] = "Libreria",
        ["Artists"] = "Artisti",
        ["Albums"] = "Album",
        ["Songs"] = "Brani",
        ["Search in Library"] = "Cerca nella libreria",
        ["Previous page"] = "Pagina precedente",
        ["Next page"] = "Pagina successiva",
        ["Artists (%d-%d / %d)"] = "Artisti (%d-%d / %d)",
        ["Artist"] = "Artista",
        ["%s Albums (%d-%d / %d)"] = "Album di %s (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "Album (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "Riproduci pagina (%d di %d brani)",
        ["Play album (%d tracks)"] = "Riproduci album (%d brani)",
        ["Album Tracks"] = "Brani dell'album",
        ["Songs (%d-%d / %d)"] = "Brani (%d-%d / %d)",
        ["Item"] = "Elemento",
        ["Song"] = "Brano",
        ["Album"] = "Album",
        ["(No results found)"] = "(Nessun risultato trovato)",
        ["Search: %s"] = "Ricerca: %s",
    },
    ja = {
        ["Jellyfin & Emby"] = "Jellyfin & Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Jellyfin & Emby にはリモート再生機能が必要です",
        ["Missing or invalid server URL"] = "サーバー URL が未入力または無効です",
        ["Server URL contains control characters"] = "サーバー URL に制御文字が含まれています",
        ["Server URL cannot contain whitespace"] = "サーバー URL に空白は使用できません",
        ["Credentials (userinfo) not allowed in server URL"] = "サーバー URL に認証情報は含められません",
        ["Query string not allowed in base server URL"] = "ベース URL にクエリ文字列は使用できません",
        ["Fragment not allowed in base server URL"] = "ベース URL にフラグメントは使用できません",
        ["Unsupported URL scheme; must be http or https"] = "非対応の URL スキームです (http または https)",
        ["Missing host in server URL"] = "サーバー URL にホスト名がありません",
        ["Invalid IPv6 address in server URL"] = "サーバー URL の IPv6 アドレスが無効です",
        ["Invalid host in server URL"] = "サーバー URL のホスト名が無効です",
        ["Invalid port number; must be 1-65535"] = "ポート番号が無効です (1〜65535)",
        ["Invalid IPv4 address in server URL"] = "サーバー URL の IPv4 アドレスが無効です",
        ["Host name exceeds 253 characters"] = "ホスト名が 253 文字を超えています",
        ["Host label must be between 1 and 63 characters"] = "ホストラベルは 1〜63 文字である必要があります",
        ["Host domain label cannot start or end with hyphen"] = "ドメインラベルの先頭・末尾にハイフンは使えません",
        ["Invalid characters in host name"] = "ホスト名に無効な文字が含まれています",
        ["Request failed"] = "リクエストに失敗しました",
        ["Unknown Artist"] = "不明なアーティスト",
        ["Unknown Album"] = "不明なアルバム",
        ["Unknown Track"] = "不明なトラック",
        ["HTTP request threw an error"] = "HTTP リクエストでエラーが発生しました",
        ["Failed to start HTTP request"] = "HTTP リクエストを開始できませんでした",
        ["Not logged in"] = "ログインしていません",
        ["Server URL not configured"] = "サーバー URL が設定されていません",
        ["Signed out"] = "サインアウトしました",
        ["Network error: %s"] = "ネットワークエラー: %s",
        ["Session expired - please log in again"] = "セッションの有効期限が切れました。再ログインしてください",
        ["Unauthorized (401)"] = "認証エラー (401)",
        ["HTTP error %s"] = "HTTP エラー %s",
        ["JSON decode error: %s"] = "JSON デコードエラー: %s",
        ["Invalid server URL"] = "無効なサーバー URL です",
        ["Please enter a username"] = "ユーザー名を入力してください",
        ["Failed to save server URL"] = "サーバー URL を保存できませんでした",
        ["Failed to save username"] = "ユーザー名を保存できませんでした",
        ["Login failed: %s"] = "ログイン失敗: %s",
        ["Invalid username or password"] = "ユーザー名またはパスワードが正しくありません",
        ["Login failed (HTTP %s)"] = "ログイン失敗 (HTTP %s)",
        ["Invalid server response"] = "無効なサーバー応答です",
        ["Login failed: missing access token or user ID"] = "ログイン失敗: トークンまたはユーザー ID がありません",
        ["Secure storage unavailable"] = "セキュアストレージを利用できません",
        ["Failed to store access token safely"] = "アクセストークンを安全に保存できませんでした",
        ["Failed to save user profile"] = "ユーザープロファイルを保存できませんでした",
        ["Logged in as %s"] = "%s としてログインしました",
        ["Logged out"] = "ログアウトしました",
        ["Invalid track item"] = "無効なトラック項目です",
        ["Unsupported stream protocol: %s"] = "非対応のストリームプロトコル: %s",
        ["HLS streams not supported for direct playback"] = "HLS ストリームの直接再生には対応していません",
        ["Live streams not supported for direct playback"] = "ライブストリームの直接再生には対応していません",
        ["DRM or protected media not supported"] = "DRM 保護されたメディアには対応していません",
        ["Incompatible codec: %s"] = "非対応のコーデック: %s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "FLAC 以外のコンテナ (%s) 内の FLAC は非対応です",
        ["MP3 in non-MP3 container (%s) unsupported"] = "MP3 以外のコンテナ (%s) 内の MP3 は非対応です",
        ["AAC in unsupported container (%s)"] = "非対応コンテナ (%s) 内の AAC です",
        ["No compatible audio stream found"] = "互換性のあるオーディオストリームが見つかりません",
        ["Failed to resolve track details: %s"] = "曲の詳細を取得できませんでした: %s",
        ["Unsupported audio format"] = "非対応のオーディオ形式です",
        ["No stream link"] = "ストリームリンクがありません",
        ["Unsupported format"] = "非対応の形式です",
        ["Please log in first"] = "先にログインしてください",
        ["Playing: %s"] = "再生中: %s",
        ["track"] = "トラック",
        ["No tracks to play"] = "再生する曲がありません",
        ["Selected track not found in list"] = "選択した曲がリストに見つかりません",
        ["Queued %d tracks"] = "%d 曲をキューに追加しました",
        ["Preparing playback"] = "再生を準備しています",
        ["No compatible playable tracks found"] = "再生可能な互換トラックが見つかりません",
        ["Queued %d tracks (%d unsupported skipped)"] = "%d 曲をキューに追加 (%d 曲の非対応をスキップ)",
        ["Selected track is unsupported: %s"] = "選択した曲は非対応です: %s",
        ["format"] = "形式",
        ["Format inspection unsupported on this build"] = "このビルドではフォーマット確認に対応していません",
        ["No active track is currently playing"] = "現在再生中の曲がありません",
        ["N/A (compressed)"] = "N/A (圧縮音源)",
        ["%d bit"] = "%d bit",
        ["Forward-only (Not seekable)"] = "順方向のみ (シーク不可)",
        ["Seekable (Confirmed by player Range)"] = "シーク可能 (Range 対応確認済み)",
        ["unknown"] = "不明",
        ["Codec: %s"] = "コーデック: %s",
        ["Sample Rate: %d Hz"] = "サンプルレート: %d Hz",
        ["Bit Depth: %s"] = "ビット深度: %s",
        ["Channels: %d"] = "チャンネル数: %d",
        ["Bitrate: %d kbps"] = "ビットレート: %d kbps",
        ["Stream Source: %s"] = "ストリーム元: %s",
        ["Yes (HTTP)"] = "はい (HTTP)",
        ["No (Local)"] = "いいえ (ローカル)",
        ["Native Range Seeking: %s"] = "ネイティブ Range シーク: %s",
        ["Volume Gain: %.2f"] = "音量ゲイン: %.2f",
        ["Playback Format"] = "再生フォーマット",
        ["Password"] = "パスワード",
        ["Saved Servers"] = "保存済みサーバー",
        ["No saved servers"] = "保存されたサーバーはありません",
        ["Add one in Settings."] = "設定から追加してください。",
        ["Server URL"] = "サーバー URL",
        ["Username"] = "ユーザー名",
        ["Remove %s?"] = "%s を削除しますか？",
        ["Remove"] = "削除",
        ["Server removed"] = "サーバーを削除しました",
        ["Remove Server"] = "サーバーを削除",
        ["Add Server"] = "サーバーを追加",
        ["New server type: %s"] = "新規サーバー種別: %s",
        ["Failed to save server type"] = "サーバー種別を保存できませんでした",
        ["Verify HTTPS TLS"] = "HTTPS TLS を検証",
        ["Failed to save TLS setting"] = "TLS 設定を保存できませんでした",
        ["Page Size: %s items"] = "ページサイズ: %s 件",
        ["Failed to save page size"] = "ページサイズを保存できませんでした",
        ["Music"] = "ミュージック",
        ["Search %s"] = "%s を検索",
        ["Back"] = "戻る",
        ["Unnamed Library"] = "名称未設定のライブラリ",
        ["Search Music"] = "音楽を検索",
        ["Settings"] = "設定",
        ["Music Libraries"] = "音楽ライブラリ",
        ["Library"] = "ライブラリ",
        ["Artists"] = "アーティスト",
        ["Albums"] = "アルバム",
        ["Songs"] = "曲",
        ["Search in Library"] = "ライブラリ内を検索",
        ["Previous page"] = "前のページ",
        ["Next page"] = "次のページ",
        ["Artists (%d-%d / %d)"] = "アーティスト (%d-%d / %d)",
        ["Artist"] = "アーティスト",
        ["%s Albums (%d-%d / %d)"] = "%s のアルバム (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "アルバム (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "このページを再生 (%d / %d 曲)",
        ["Play album (%d tracks)"] = "アルバムを再生 (%d 曲)",
        ["Album Tracks"] = "アルバムの曲",
        ["Songs (%d-%d / %d)"] = "曲 (%d-%d / %d)",
        ["Item"] = "項目",
        ["Song"] = "曲",
        ["Album"] = "アルバム",
        ["(No results found)"] = "(結果が見つかりません)",
        ["Search: %s"] = "検索: %s",
    },
    nl = {
        ["Jellyfin & Emby"] = "Jellyfin & Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Jellyfin & Emby vereist afspelen op afstand",
        ["Missing or invalid server URL"] = "Ontbrekende of ongeldige server-URL",
        ["Server URL contains control characters"] = "Server-URL bevat stuurtekens",
        ["Server URL cannot contain whitespace"] = "Server-URL mag geen spaties bevatten",
        ["Credentials (userinfo) not allowed in server URL"] = "Inloggegevens niet toegestaan in server-URL",
        ["Query string not allowed in base server URL"] = "Querystring niet toegestaan in basis-server-URL",
        ["Fragment not allowed in base server URL"] = "Fragment niet toegestaan in basis-server-URL",
        ["Unsupported URL scheme; must be http or https"] = "Niet-ondersteund URL-schema; moet http of https zijn",
        ["Missing host in server URL"] = "Host ontbreekt in server-URL",
        ["Invalid IPv6 address in server URL"] = "Ongeldig IPv6-adres in server-URL",
        ["Invalid host in server URL"] = "Ongeldige host in server-URL",
        ["Invalid port number; must be 1-65535"] = "Ongeldig poortnummer; moet 1-65535 zijn",
        ["Invalid IPv4 address in server URL"] = "Ongeldig IPv4-adres in server-URL",
        ["Host name exceeds 253 characters"] = "Hostnaam is langer dan 253 tekens",
        ["Host label must be between 1 and 63 characters"] = "Hostlabel moet tussen 1 en 63 tekens lang zijn",
        ["Host domain label cannot start or end with hyphen"] = "Domeinlabel mag niet beginnen of eindigen met een streepje",
        ["Invalid characters in host name"] = "Ongeldige tekens in hostnaam",
        ["Request failed"] = "Verzoek mislukt",
        ["Unknown Artist"] = "Onbekende artiest",
        ["Unknown Album"] = "Onbekend album",
        ["Unknown Track"] = "Onbekend nummer",
        ["HTTP request threw an error"] = "HTTP-verzoek veroorzaakte een fout",
        ["Failed to start HTTP request"] = "HTTP-verzoek starten mislukt",
        ["Not logged in"] = "Niet ingelogd",
        ["Server URL not configured"] = "Server-URL niet ingesteld",
        ["Signed out"] = "Uitgelogd",
        ["Network error: %s"] = "Netwerkfout: %s",
        ["Session expired - please log in again"] = "Sessie verlopen - log opnieuw in",
        ["Unauthorized (401)"] = "Niet geautoriseerd (401)",
        ["HTTP error %s"] = "HTTP-fout %s",
        ["JSON decode error: %s"] = "JSON-decodeerfout: %s",
        ["Invalid server URL"] = "Ongeldige server-URL",
        ["Please enter a username"] = "Voer een gebruikersnaam in",
        ["Failed to save server URL"] = "Server-URL opslaan mislukt",
        ["Failed to save username"] = "Gebruikersnaam opslaan mislukt",
        ["Login failed: %s"] = "Inloggen mislukt: %s",
        ["Invalid username or password"] = "Ongeldige gebruikersnaam of wachtwoord",
        ["Login failed (HTTP %s)"] = "Inloggen mislukt (HTTP %s)",
        ["Invalid server response"] = "Ongeldige serverreactie",
        ["Login failed: missing access token or user ID"] = "Inloggen mislukt: toegangstoken of gebruikers-ID ontbreekt",
        ["Secure storage unavailable"] = "Veilige opslag niet beschikbaar",
        ["Failed to store access token safely"] = "Toegangstoken veilig opslaan mislukt",
        ["Failed to save user profile"] = "Gebruikersprofiel opslaan mislukt",
        ["Logged in as %s"] = "Ingelogd als %s",
        ["Logged out"] = "Uitgelogd",
        ["Invalid track item"] = "Ongeldig nummeritem",
        ["Unsupported stream protocol: %s"] = "Niet-ondersteund streamprotocol: %s",
        ["HLS streams not supported for direct playback"] = "HLS-streams niet ondersteund voor direct afspelen",
        ["Live streams not supported for direct playback"] = "Livestreams niet ondersteund voor direct afspelen",
        ["DRM or protected media not supported"] = "DRM of beveiligde media niet ondersteund",
        ["Incompatible codec: %s"] = "Incompatibele codec: %s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "FLAC in niet-FLAC-container (%s) niet ondersteund",
        ["MP3 in non-MP3 container (%s) unsupported"] = "MP3 in niet-MP3-container (%s) niet ondersteund",
        ["AAC in unsupported container (%s)"] = "AAC in niet-ondersteunde container (%s)",
        ["No compatible audio stream found"] = "Geen compatibele audiostream gevonden",
        ["Failed to resolve track details: %s"] = "Nummerdetails ophalen mislukt: %s",
        ["Unsupported audio format"] = "Niet-ondersteund audioformaat",
        ["No stream link"] = "Geen streamlink",
        ["Unsupported format"] = "Niet-ondersteund formaat",
        ["Please log in first"] = "Log eerst in",
        ["Playing: %s"] = "Speelt af: %s",
        ["track"] = "nummer",
        ["No tracks to play"] = "Geen nummers om af te spelen",
        ["Selected track not found in list"] = "Geselecteerd nummer niet gevonden in lijst",
        ["Queued %d tracks"] = "%d nummers in wachtrij",
        ["Preparing playback"] = "Afspelen voorbereiden",
        ["No compatible playable tracks found"] = "Geen compatibele afspeelbare nummers gevonden",
        ["Queued %d tracks (%d unsupported skipped)"] = "%d nummers in wachtrij (%d niet-ondersteunde overgeslagen)",
        ["Selected track is unsupported: %s"] = "Geselecteerd nummer wordt niet ondersteund: %s",
        ["format"] = "formaat",
        ["Format inspection unsupported on this build"] = "Formaatinspectie niet ondersteund in deze versie",
        ["No active track is currently playing"] = "Er wordt momenteel geen nummer afgespeeld",
        ["N/A (compressed)"] = "N.v.t. (gecomprimeerd)",
        ["%d bit"] = "%d bit",
        ["Forward-only (Not seekable)"] = "Alleen vooruit (niet spoelbaar)",
        ["Seekable (Confirmed by player Range)"] = "Spoelbaar (bevestigd door speler-Range)",
        ["unknown"] = "onbekend",
        ["Codec: %s"] = "Codec: %s",
        ["Sample Rate: %d Hz"] = "Samplerate: %d Hz",
        ["Bit Depth: %s"] = "Bitdiepte: %s",
        ["Channels: %d"] = "Kanalen: %d",
        ["Bitrate: %d kbps"] = "Bitrate: %d kbps",
        ["Stream Source: %s"] = "Streambron: %s",
        ["Yes (HTTP)"] = "Ja (HTTP)",
        ["No (Local)"] = "Nee (Lokaal)",
        ["Native Range Seeking: %s"] = "Native Range-spoelen: %s",
        ["Volume Gain: %.2f"] = "Volumeversterking: %.2f",
        ["Playback Format"] = "Afspeelformaat",
        ["Password"] = "Wachtwoord",
        ["Saved Servers"] = "Opgeslagen servers",
        ["No saved servers"] = "Geen opgeslagen servers",
        ["Add one in Settings."] = "Voeg er een toe in Instellingen.",
        ["Server URL"] = "Server-URL",
        ["Username"] = "Gebruikersnaam",
        ["Remove %s?"] = "%s verwijderen?",
        ["Remove"] = "Verwijderen",
        ["Server removed"] = "Server verwijderd",
        ["Remove Server"] = "Server verwijderen",
        ["Add Server"] = "Server toevoegen",
        ["New server type: %s"] = "Nieuw servertype: %s",
        ["Failed to save server type"] = "Servertype opslaan mislukt",
        ["Verify HTTPS TLS"] = "HTTPS TLS verifiëren",
        ["Failed to save TLS setting"] = "TLS-instelling opslaan mislukt",
        ["Page Size: %s items"] = "Paginagrootte: %s items",
        ["Failed to save page size"] = "Paginagrootte opslaan mislukt",
        ["Music"] = "Muziek",
        ["Search %s"] = "Zoeken in %s",
        ["Back"] = "Terug",
        ["Unnamed Library"] = "Naamloze bibliotheek",
        ["Search Music"] = "Muziek zoeken",
        ["Settings"] = "Instellingen",
        ["Music Libraries"] = "Muziekbibliotheken",
        ["Library"] = "Bibliotheek",
        ["Artists"] = "Artiesten",
        ["Albums"] = "Albums",
        ["Songs"] = "Nummers",
        ["Search in Library"] = "Zoeken in bibliotheek",
        ["Previous page"] = "Vorige pagina",
        ["Next page"] = "Volgende pagina",
        ["Artists (%d-%d / %d)"] = "Artiesten (%d-%d / %d)",
        ["Artist"] = "Artiest",
        ["%s Albums (%d-%d / %d)"] = "%s Albums (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "Albums (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "Pagina afspelen (%d van %d nummers)",
        ["Play album (%d tracks)"] = "Album afspelen (%d nummers)",
        ["Album Tracks"] = "Albumnummers",
        ["Songs (%d-%d / %d)"] = "Nummers (%d-%d / %d)",
        ["Item"] = "Item",
        ["Song"] = "Nummer",
        ["Album"] = "Album",
        ["(No results found)"] = "(Geen resultaten gevonden)",
        ["Search: %s"] = "Zoeken: %s",
    },
    pt = {
        ["Jellyfin & Emby"] = "Jellyfin & Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Jellyfin & Emby requer reprodução remota",
        ["Missing or invalid server URL"] = "URL do servidor ausente ou inválida",
        ["Server URL contains control characters"] = "A URL do servidor contém caracteres de controle",
        ["Server URL cannot contain whitespace"] = "A URL do servidor não pode conter espaços",
        ["Credentials (userinfo) not allowed in server URL"] = "Credenciais não permitidas na URL do servidor",
        ["Query string not allowed in base server URL"] = "String de consulta não permitida na URL base",
        ["Fragment not allowed in base server URL"] = "Fragmento não permitido na URL base",
        ["Unsupported URL scheme; must be http or https"] = "Esquema de URL não suportado; deve ser http ou https",
        ["Missing host in server URL"] = "Host ausente na URL do servidor",
        ["Invalid IPv6 address in server URL"] = "Endereço IPv6 inválido na URL do servidor",
        ["Invalid host in server URL"] = "Host inválido na URL do servidor",
        ["Invalid port number; must be 1-65535"] = "Porta inválida; deve ser 1-65535",
        ["Invalid IPv4 address in server URL"] = "Endereço IPv4 inválido na URL do servidor",
        ["Host name exceeds 253 characters"] = "O nome do host excede 253 caracteres",
        ["Host label must be between 1 and 63 characters"] = "O rótulo do host deve ter entre 1 e 63 caracteres",
        ["Host domain label cannot start or end with hyphen"] = "O rótulo do domínio não pode começar ou terminar com hífen",
        ["Invalid characters in host name"] = "Caracteres inválidos no nome do host",
        ["Request failed"] = "Falha na solicitação",
        ["Unknown Artist"] = "Artista desconhecido",
        ["Unknown Album"] = "Álbum desconhecido",
        ["Unknown Track"] = "Faixa desconhecida",
        ["HTTP request threw an error"] = "A solicitação HTTP gerou um erro",
        ["Failed to start HTTP request"] = "Falha ao iniciar a solicitação HTTP",
        ["Not logged in"] = "Não conectado",
        ["Server URL not configured"] = "URL do servidor não configurada",
        ["Signed out"] = "Desconectado",
        ["Network error: %s"] = "Erro de rede: %s",
        ["Session expired - please log in again"] = "Sessão expirada - faça login novamente",
        ["Unauthorized (401)"] = "Não autorizado (401)",
        ["HTTP error %s"] = "Erro HTTP %s",
        ["JSON decode error: %s"] = "Erro ao decodificar JSON: %s",
        ["Invalid server URL"] = "URL do servidor inválida",
        ["Please enter a username"] = "Insira um nome de usuário",
        ["Failed to save server URL"] = "Falha ao salvar a URL do servidor",
        ["Failed to save username"] = "Falha ao salvar o nome de usuário",
        ["Login failed: %s"] = "Falha no login: %s",
        ["Invalid username or password"] = "Usuário ou senha inválidos",
        ["Login failed (HTTP %s)"] = "Falha no login (HTTP %s)",
        ["Invalid server response"] = "Resposta inválida do servidor",
        ["Login failed: missing access token or user ID"] = "Falha no login: token de acesso ou ID de usuário ausente",
        ["Secure storage unavailable"] = "Armazenamento seguro indisponível",
        ["Failed to store access token safely"] = "Falha ao armazenar o token com segurança",
        ["Failed to save user profile"] = "Falha ao salvar o perfil do usuário",
        ["Logged in as %s"] = "Conectado como %s",
        ["Logged out"] = "Desconectado",
        ["Invalid track item"] = "Item de faixa inválido",
        ["Unsupported stream protocol: %s"] = "Protocolo de stream não suportado: %s",
        ["HLS streams not supported for direct playback"] = "Streams HLS não suportados para reprodução direta",
        ["Live streams not supported for direct playback"] = "Transmissões ao vivo não suportadas para reprodução direta",
        ["DRM or protected media not supported"] = "Mídia protegida ou com DRM não suportada",
        ["Incompatible codec: %s"] = "Codec incompatível: %s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "FLAC em contêiner não FLAC (%s) não suportado",
        ["MP3 in non-MP3 container (%s) unsupported"] = "MP3 em contêiner não MP3 (%s) não suportado",
        ["AAC in unsupported container (%s)"] = "AAC em contêiner não suportado (%s)",
        ["No compatible audio stream found"] = "Nenhum stream de áudio compatível encontrado",
        ["Failed to resolve track details: %s"] = "Falha ao obter detalhes da faixa: %s",
        ["Unsupported audio format"] = "Formato de áudio não suportado",
        ["No stream link"] = "Sem link de stream",
        ["Unsupported format"] = "Formato não suportado",
        ["Please log in first"] = "Faça login primeiro",
        ["Playing: %s"] = "Reproduzindo: %s",
        ["track"] = "faixa",
        ["No tracks to play"] = "Nenhuma faixa para reproduzir",
        ["Selected track not found in list"] = "Faixa selecionada não encontrada na lista",
        ["Queued %d tracks"] = "%d faixas na fila",
        ["Preparing playback"] = "Preparando reprodução",
        ["No compatible playable tracks found"] = "Nenhuma faixa compatível reproduzível encontrada",
        ["Queued %d tracks (%d unsupported skipped)"] = "%d faixas na fila (%d não suportadas ignoradas)",
        ["Selected track is unsupported: %s"] = "A faixa selecionada não é suportada: %s",
        ["format"] = "formato",
        ["Format inspection unsupported on this build"] = "Inspeção de formato não suportada nesta versão",
        ["No active track is currently playing"] = "Nenhuma faixa ativa tocando no momento",
        ["N/A (compressed)"] = "N/D (comprimido)",
        ["%d bit"] = "%d bits",
        ["Forward-only (Not seekable)"] = "Apenas avanço (sem busca)",
        ["Seekable (Confirmed by player Range)"] = "Com busca (confirmado por Range)",
        ["unknown"] = "desconhecido",
        ["Codec: %s"] = "Codec: %s",
        ["Sample Rate: %d Hz"] = "Taxa de amostragem: %d Hz",
        ["Bit Depth: %s"] = "Profundidade de bits: %s",
        ["Channels: %d"] = "Canais: %d",
        ["Bitrate: %d kbps"] = "Taxa de bits: %d kbps",
        ["Stream Source: %s"] = "Fonte do stream: %s",
        ["Yes (HTTP)"] = "Sim (HTTP)",
        ["No (Local)"] = "Não (Local)",
        ["Native Range Seeking: %s"] = "Busca Range nativa: %s",
        ["Volume Gain: %.2f"] = "Ganho de volume: %.2f",
        ["Playback Format"] = "Formato de reprodução",
        ["Password"] = "Senha",
        ["Saved Servers"] = "Servidores salvos",
        ["No saved servers"] = "Nenhum servidor salvo",
        ["Add one in Settings."] = "Adicione um em Configurações.",
        ["Server URL"] = "URL do servidor",
        ["Username"] = "Usuário",
        ["Remove %s?"] = "Remover %s?",
        ["Remove"] = "Remover",
        ["Server removed"] = "Servidor removido",
        ["Remove Server"] = "Remover servidor",
        ["Add Server"] = "Adicionar servidor",
        ["New server type: %s"] = "Novo tipo de servidor: %s",
        ["Failed to save server type"] = "Falha ao salvar o tipo de servidor",
        ["Verify HTTPS TLS"] = "Verificar HTTPS TLS",
        ["Failed to save TLS setting"] = "Falha ao salvar a configuração TLS",
        ["Page Size: %s items"] = "Tamanho da página: %s itens",
        ["Failed to save page size"] = "Falha ao salvar o tamanho da página",
        ["Music"] = "Música",
        ["Search %s"] = "Pesquisar em %s",
        ["Back"] = "Voltar",
        ["Unnamed Library"] = "Biblioteca sem nome",
        ["Search Music"] = "Pesquisar música",
        ["Settings"] = "Configurações",
        ["Music Libraries"] = "Bibliotecas de música",
        ["Library"] = "Biblioteca",
        ["Artists"] = "Artistas",
        ["Albums"] = "Álbuns",
        ["Songs"] = "Músicas",
        ["Search in Library"] = "Pesquisar na biblioteca",
        ["Previous page"] = "Página anterior",
        ["Next page"] = "Próxima página",
        ["Artists (%d-%d / %d)"] = "Artistas (%d-%d / %d)",
        ["Artist"] = "Artista",
        ["%s Albums (%d-%d / %d)"] = "Álbuns de %s (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "Álbuns (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "Reproduzir página (%d de %d faixas)",
        ["Play album (%d tracks)"] = "Reproduzir álbum (%d faixas)",
        ["Album Tracks"] = "Faixas do álbum",
        ["Songs (%d-%d / %d)"] = "Músicas (%d-%d / %d)",
        ["Item"] = "Item",
        ["Song"] = "Música",
        ["Album"] = "Álbum",
        ["(No results found)"] = "(Nenhum resultado encontrado)",
        ["Search: %s"] = "Pesquisa: %s",
    },
    ru = {
        ["Jellyfin & Emby"] = "Jellyfin и Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Для Jellyfin и Emby требуется удалённое воспроизведение",
        ["Missing or invalid server URL"] = "Отсутствует или некорректен URL сервера",
        ["Server URL contains control characters"] = "URL сервера содержит управляющие символы",
        ["Server URL cannot contain whitespace"] = "URL сервера не должен содержать пробелы",
        ["Credentials (userinfo) not allowed in server URL"] = "Учётные данные в URL сервера не допускаются",
        ["Query string not allowed in base server URL"] = "Параметры запроса в базовом URL сервера не допускаются",
        ["Fragment not allowed in base server URL"] = "Фрагмент в базовом URL сервера не допускается",
        ["Unsupported URL scheme; must be http or https"] = "Неподдерживаемая схема URL; должна быть http или https",
        ["Missing host in server URL"] = "В URL сервера отсутствует хост",
        ["Invalid IPv6 address in server URL"] = "Некорректный IPv6-адрес в URL сервера",
        ["Invalid host in server URL"] = "Некорректный хост в URL сервера",
        ["Invalid port number; must be 1-65535"] = "Некорректный порт; должен быть 1–65535",
        ["Invalid IPv4 address in server URL"] = "Некорректный IPv4-адрес в URL сервера",
        ["Host name exceeds 253 characters"] = "Имя хоста превышает 253 символа",
        ["Host label must be between 1 and 63 characters"] = "Метка хоста должна содержать от 1 до 63 символов",
        ["Host domain label cannot start or end with hyphen"] = "Метка домена не может начинаться или заканчиваться дефисом",
        ["Invalid characters in host name"] = "Недопустимые символы в имени хоста",
        ["Request failed"] = "Ошибка запроса",
        ["Unknown Artist"] = "Неизвестный исполнитель",
        ["Unknown Album"] = "Неизвестный альбом",
        ["Unknown Track"] = "Неизвестный трек",
        ["HTTP request threw an error"] = "HTTP-запрос вызвал ошибку",
        ["Failed to start HTTP request"] = "Не удалось запустить HTTP-запрос",
        ["Not logged in"] = "Вход не выполнен",
        ["Server URL not configured"] = "URL сервера не настроен",
        ["Signed out"] = "Выход выполнен",
        ["Network error: %s"] = "Ошибка сети: %s",
        ["Session expired - please log in again"] = "Сессия истекла — войдите снова",
        ["Unauthorized (401)"] = "Не авторизован (401)",
        ["HTTP error %s"] = "Ошибка HTTP %s",
        ["JSON decode error: %s"] = "Ошибка декодирования JSON: %s",
        ["Invalid server URL"] = "Некорректный URL сервера",
        ["Please enter a username"] = "Введите имя пользователя",
        ["Failed to save server URL"] = "Не удалось сохранить URL сервера",
        ["Failed to save username"] = "Не удалось сохранить имя пользователя",
        ["Login failed: %s"] = "Ошибка входа: %s",
        ["Invalid username or password"] = "Неверное имя пользователя или пароль",
        ["Login failed (HTTP %s)"] = "Ошибка входа (HTTP %s)",
        ["Invalid server response"] = "Некорректный ответ сервера",
        ["Login failed: missing access token or user ID"] = "Ошибка входа: отсутствует токен или ID пользователя",
        ["Secure storage unavailable"] = "Защищённое хранилище недоступно",
        ["Failed to store access token safely"] = "Не удалось безопасно сохранить токен доступа",
        ["Failed to save user profile"] = "Не удалось сохранить профиль пользователя",
        ["Logged in as %s"] = "Вход выполнен: %s",
        ["Logged out"] = "Выход выполнен",
        ["Invalid track item"] = "Некорректный элемент трека",
        ["Unsupported stream protocol: %s"] = "Неподдерживаемый протокол потока: %s",
        ["HLS streams not supported for direct playback"] = "Потоки HLS не поддерживаются для прямого воспроизведения",
        ["Live streams not supported for direct playback"] = "Прямые трансляции не поддерживаются для воспроизведения",
        ["DRM or protected media not supported"] = "Защищённые DRM медиафайлы не поддерживаются",
        ["Incompatible codec: %s"] = "Несовместимый кодек: %s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "FLAC в контейнере %s не поддерживается",
        ["MP3 in non-MP3 container (%s) unsupported"] = "MP3 в контейнере %s не поддерживается",
        ["AAC in unsupported container (%s)"] = "AAC в неподдерживаемом контейнере (%s)",
        ["No compatible audio stream found"] = "Совместимый аудиопоток не найден",
        ["Failed to resolve track details: %s"] = "Не удалось получить сведения о треке: %s",
        ["Unsupported audio format"] = "Неподдерживаемый аудиоформат",
        ["No stream link"] = "Нет ссылки на поток",
        ["Unsupported format"] = "Неподдерживаемый формат",
        ["Please log in first"] = "Сначала войдите в аккаунт",
        ["Playing: %s"] = "Играет: %s",
        ["track"] = "трек",
        ["No tracks to play"] = "Нет треков для воспроизведения",
        ["Selected track not found in list"] = "Выбранный трек не найден в списке",
        ["Queued %d tracks"] = "В очереди %d треков",
        ["Preparing playback"] = "Подготовка воспроизведения",
        ["No compatible playable tracks found"] = "Совместимые треки не найдены",
        ["Queued %d tracks (%d unsupported skipped)"] = "В очереди %d треков (пропущено неподдерживаемых: %d)",
        ["Selected track is unsupported: %s"] = "Выбранный трек не поддерживается: %s",
        ["format"] = "формат",
        ["Format inspection unsupported on this build"] = "Проверка формата не поддерживается в этой сборке",
        ["No active track is currently playing"] = "Сейчас ничего не воспроизводится",
        ["N/A (compressed)"] = "Н/Д (сжатый)",
        ["%d bit"] = "%d бит",
        ["Forward-only (Not seekable)"] = "Только вперёд (без перемотки)",
        ["Seekable (Confirmed by player Range)"] = "С перемоткой (подтверждено Range)",
        ["unknown"] = "неизвестно",
        ["Codec: %s"] = "Кодек: %s",
        ["Sample Rate: %d Hz"] = "Частота дискретизации: %d Гц",
        ["Bit Depth: %s"] = "Разрядность: %s",
        ["Channels: %d"] = "Каналы: %d",
        ["Bitrate: %d kbps"] = "Битрейт: %d кбит/с",
        ["Stream Source: %s"] = "Источник потока: %s",
        ["Yes (HTTP)"] = "Да (HTTP)",
        ["No (Local)"] = "Нет (локальный)",
        ["Native Range Seeking: %s"] = "Нативная перемотка Range: %s",
        ["Volume Gain: %.2f"] = "Усиление громкости: %.2f",
        ["Playback Format"] = "Формат воспроизведения",
        ["Password"] = "Пароль",
        ["Saved Servers"] = "Сохранённые серверы",
        ["No saved servers"] = "Нет сохранённых серверов",
        ["Add one in Settings."] = "Добавьте сервер в Настройках.",
        ["Server URL"] = "URL сервера",
        ["Username"] = "Имя пользователя",
        ["Remove %s?"] = "Удалить %s?",
        ["Remove"] = "Удалить",
        ["Server removed"] = "Сервер удалён",
        ["Remove Server"] = "Удалить сервер",
        ["Add Server"] = "Добавить сервер",
        ["New server type: %s"] = "Тип нового сервера: %s",
        ["Failed to save server type"] = "Не удалось сохранить тип сервера",
        ["Verify HTTPS TLS"] = "Проверять HTTPS TLS",
        ["Failed to save TLS setting"] = "Не удалось сохранить настройку TLS",
        ["Page Size: %s items"] = "Размер страницы: %s",
        ["Failed to save page size"] = "Не удалось сохранить размер страницы",
        ["Music"] = "Музыка",
        ["Search %s"] = "Поиск в %s",
        ["Back"] = "Назад",
        ["Unnamed Library"] = "Библиотека без названия",
        ["Search Music"] = "Поиск музыки",
        ["Settings"] = "Настройки",
        ["Music Libraries"] = "Музыкальные библиотеки",
        ["Library"] = "Библиотека",
        ["Artists"] = "Исполнители",
        ["Albums"] = "Альбомы",
        ["Songs"] = "Треки",
        ["Search in Library"] = "Поиск в библиотеке",
        ["Previous page"] = "Предыдущая страница",
        ["Next page"] = "Следующая страница",
        ["Artists (%d-%d / %d)"] = "Исполнители (%d-%d / %d)",
        ["Artist"] = "Исполнитель",
        ["%s Albums (%d-%d / %d)"] = "%s — Альбомы (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "Альбомы (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "Играть страницу (%d из %d треков)",
        ["Play album (%d tracks)"] = "Играть альбом (%d треков)",
        ["Album Tracks"] = "Треки альбома",
        ["Songs (%d-%d / %d)"] = "Треки (%d-%d / %d)",
        ["Item"] = "Элемент",
        ["Song"] = "Трек",
        ["Album"] = "Альбом",
        ["(No results found)"] = "(Ничего не найдено)",
        ["Search: %s"] = "Поиск: %s",
    },
    uk = {
        ["Jellyfin & Emby"] = "Jellyfin та Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Для Jellyfin та Emby потрібне віддалене відтворення",
        ["Missing or invalid server URL"] = "Відсутній або некоректний URL сервера",
        ["Server URL contains control characters"] = "URL сервера містить керівні символи",
        ["Server URL cannot contain whitespace"] = "URL сервера не може містити пробілів",
        ["Credentials (userinfo) not allowed in server URL"] = "Облікові дані в URL сервера не дозволені",
        ["Query string not allowed in base server URL"] = "Рядок запиту в базовому URL сервера не дозволений",
        ["Fragment not allowed in base server URL"] = "Фрагмент у базовому URL сервера не дозволений",
        ["Unsupported URL scheme; must be http or https"] = "Непідтримувана схема URL; має бути http або https",
        ["Missing host in server URL"] = "В URL сервера відсутній хост",
        ["Invalid IPv6 address in server URL"] = "Некоректна IPv6-адреса в URL сервера",
        ["Invalid host in server URL"] = "Некоректний хост в URL сервера",
        ["Invalid port number; must be 1-65535"] = "Некоректний порт; має бути 1–65535",
        ["Invalid IPv4 address in server URL"] = "Некоректна IPv4-адреса в URL сервера",
        ["Host name exceeds 253 characters"] = "Ім'я хоста перевищує 253 символи",
        ["Host label must be between 1 and 63 characters"] = "Мітка хоста має містити від 1 до 63 символів",
        ["Host domain label cannot start or end with hyphen"] = "Мітка домену не може починатися чи закінчуватися дефісом",
        ["Invalid characters in host name"] = "Неприпустимі символи в імені хоста",
        ["Request failed"] = "Помилка запиту",
        ["Unknown Artist"] = "Невідомий виконавець",
        ["Unknown Album"] = "Невідомий альбом",
        ["Unknown Track"] = "Невідомий трек",
        ["HTTP request threw an error"] = "HTTP-запит викликав помилку",
        ["Failed to start HTTP request"] = "Не вдалося запустити HTTP-запит",
        ["Not logged in"] = "Вхід не виконано",
        ["Server URL not configured"] = "URL сервера не налаштовано",
        ["Signed out"] = "Вихід виконано",
        ["Network error: %s"] = "Помилка мережі: %s",
        ["Session expired - please log in again"] = "Сесія закінчилася — увійдіть знову",
        ["Unauthorized (401)"] = "Не авторизовано (401)",
        ["HTTP error %s"] = "Помилка HTTP %s",
        ["JSON decode error: %s"] = "Помилка декодування JSON: %s",
        ["Invalid server URL"] = "Некоректний URL сервера",
        ["Please enter a username"] = "Введіть ім'я користувача",
        ["Failed to save server URL"] = "Не вдалося зберегти URL сервера",
        ["Failed to save username"] = "Не вдалося зберегти ім'я користувача",
        ["Login failed: %s"] = "Помилка входу: %s",
        ["Invalid username or password"] = "Невірне ім'я користувача або пароль",
        ["Login failed (HTTP %s)"] = "Помилка входу (HTTP %s)",
        ["Invalid server response"] = "Некоректна відповідь сервера",
        ["Login failed: missing access token or user ID"] = "Помилка входу: відсутній токен або ID користувача",
        ["Secure storage unavailable"] = "Захищене сховище недоступне",
        ["Failed to store access token safely"] = "Не вдалося безпечно зберегти токен доступу",
        ["Failed to save user profile"] = "Не вдалося зберегти профіль користувача",
        ["Logged in as %s"] = "Вхід виконано: %s",
        ["Logged out"] = "Вихід виконано",
        ["Invalid track item"] = "Некоректний елемент треку",
        ["Unsupported stream protocol: %s"] = "Непідтримуваний протокол потоку: %s",
        ["HLS streams not supported for direct playback"] = "Потоки HLS не підтримуються для прямого відтворення",
        ["Live streams not supported for direct playback"] = "Прямі трансляції не підтримуються для відтворення",
        ["DRM or protected media not supported"] = "Захищені DRM медіафайли не підтримуються",
        ["Incompatible codec: %s"] = "Несумісний кодек: %s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "FLAC у контейнері %s не підтримується",
        ["MP3 in non-MP3 container (%s) unsupported"] = "MP3 у контейнері %s не підтримується",
        ["AAC in unsupported container (%s)"] = "AAC у непідтримуваному контейнері (%s)",
        ["No compatible audio stream found"] = "Сумісний аудіопотік не знайдено",
        ["Failed to resolve track details: %s"] = "Не вдалося отримати відомості про трек: %s",
        ["Unsupported audio format"] = "Непідтримуваний аудіоформат",
        ["No stream link"] = "Немає посилання на потік",
        ["Unsupported format"] = "Непідтримуваний формат",
        ["Please log in first"] = "Спочатку увійдіть в акаунт",
        ["Playing: %s"] = "Грає: %s",
        ["track"] = "трек",
        ["No tracks to play"] = "Немає треків для відтворення",
        ["Selected track not found in list"] = "Вибраний трек не знайдено у списку",
        ["Queued %d tracks"] = "У черзі %d треків",
        ["Preparing playback"] = "Підготовка відтворення",
        ["No compatible playable tracks found"] = "Сумісних треків не знайдено",
        ["Queued %d tracks (%d unsupported skipped)"] = "У черзі %d треків (пропущено непідтримуваних: %d)",
        ["Selected track is unsupported: %s"] = "Вибраний трек не підтримується: %s",
        ["format"] = "формат",
        ["Format inspection unsupported on this build"] = "Перевірка формату не підтримується в цій збірці",
        ["No active track is currently playing"] = "Зараз нічого не відтворюється",
        ["N/A (compressed)"] = "Н/Д (стиснений)",
        ["%d bit"] = "%d біт",
        ["Forward-only (Not seekable)"] = "Лише вперед (без перемотування)",
        ["Seekable (Confirmed by player Range)"] = "З перемотуванням (підтверджено Range)",
        ["unknown"] = "невідомо",
        ["Codec: %s"] = "Кодек: %s",
        ["Sample Rate: %d Hz"] = "Частота дискретизації: %d Гц",
        ["Bit Depth: %s"] = "Розрядність: %s",
        ["Channels: %d"] = "Канали: %d",
        ["Bitrate: %d kbps"] = "Бітрейт: %d кбіт/с",
        ["Stream Source: %s"] = "Джерело потоку: %s",
        ["Yes (HTTP)"] = "Так (HTTP)",
        ["No (Local)"] = "Ні (локальний)",
        ["Native Range Seeking: %s"] = "Нативне перемотування Range: %s",
        ["Volume Gain: %.2f"] = "Підсилення гучності: %.2f",
        ["Playback Format"] = "Формат відтворення",
        ["Password"] = "Пароль",
        ["Saved Servers"] = "Збережені сервери",
        ["No saved servers"] = "Немає збережених серверів",
        ["Add one in Settings."] = "Додайте сервер у Налаштуваннях.",
        ["Server URL"] = "URL сервера",
        ["Username"] = "Ім'я користувача",
        ["Remove %s?"] = "Видалити %s?",
        ["Remove"] = "Видалити",
        ["Server removed"] = "Сервер видалено",
        ["Remove Server"] = "Видалити сервер",
        ["Add Server"] = "Додати сервер",
        ["New server type: %s"] = "Тип нового сервера: %s",
        ["Failed to save server type"] = "Не вдалося зберегти тип сервера",
        ["Verify HTTPS TLS"] = "Перевіряти HTTPS TLS",
        ["Failed to save TLS setting"] = "Не вдалося зберегти налаштування TLS",
        ["Page Size: %s items"] = "Розмір сторінки: %s",
        ["Failed to save page size"] = "Не вдалося зберегти розмір сторінки",
        ["Music"] = "Музика",
        ["Search %s"] = "Пошук у %s",
        ["Back"] = "Назад",
        ["Unnamed Library"] = "Бібліотека без назви",
        ["Search Music"] = "Пошук музики",
        ["Settings"] = "Налаштування",
        ["Music Libraries"] = "Музичні бібліотеки",
        ["Library"] = "Бібліотека",
        ["Artists"] = "Виконавці",
        ["Albums"] = "Альбоми",
        ["Songs"] = "Треки",
        ["Search in Library"] = "Пошук у бібліотеці",
        ["Previous page"] = "Попередня сторінка",
        ["Next page"] = "Наступна сторінка",
        ["Artists (%d-%d / %d)"] = "Виконавці (%d-%d / %d)",
        ["Artist"] = "Виконавець",
        ["%s Albums (%d-%d / %d)"] = "%s — Альбоми (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "Альбоми (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "Грати сторінку (%d з %d треків)",
        ["Play album (%d tracks)"] = "Грати альбом (%d треків)",
        ["Album Tracks"] = "Треки альбому",
        ["Songs (%d-%d / %d)"] = "Треки (%d-%d / %d)",
        ["Item"] = "Елемент",
        ["Song"] = "Трек",
        ["Album"] = "Альбом",
        ["(No results found)"] = "(Нічого не знайдено)",
        ["Search: %s"] = "Пошук: %s",
    },
    vi = {
        ["Jellyfin & Emby"] = "Jellyfin & Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Jellyfin & Emby yêu cầu phát từ xa",
        ["Missing or invalid server URL"] = "Thiếu hoặc sai URL máy chủ",
        ["Server URL contains control characters"] = "URL máy chủ chứa ký tự điều khiển",
        ["Server URL cannot contain whitespace"] = "URL máy chủ không được chứa khoảng trắng",
        ["Credentials (userinfo) not allowed in server URL"] = "Không cho phép thông tin đăng nhập trong URL máy chủ",
        ["Query string not allowed in base server URL"] = "Không cho phép chuỗi truy vấn trong URL gốc",
        ["Fragment not allowed in base server URL"] = "Không cho phép đoạn neo (#) trong URL gốc",
        ["Unsupported URL scheme; must be http or https"] = "Giao thức URL không hỗ trợ; phải là http hoặc https",
        ["Missing host in server URL"] = "Thiếu tên máy chủ trong URL",
        ["Invalid IPv6 address in server URL"] = "Địa chỉ IPv6 không hợp lệ trong URL máy chủ",
        ["Invalid host in server URL"] = "Tên máy chủ không hợp lệ trong URL",
        ["Invalid port number; must be 1-65535"] = "Số cổng không hợp lệ; phải từ 1-65535",
        ["Invalid IPv4 address in server URL"] = "Địa chỉ IPv4 không hợp lệ trong URL máy chủ",
        ["Host name exceeds 253 characters"] = "Tên máy chủ vượt quá 253 ký tự",
        ["Host label must be between 1 and 63 characters"] = "Nhãn máy chủ phải từ 1 đến 63 ký tự",
        ["Host domain label cannot start or end with hyphen"] = "Nhãn tên miền không được bắt đầu hoặc kết thúc bằng dấu gạch ngang",
        ["Invalid characters in host name"] = "Ký tự không hợp lệ trong tên máy chủ",
        ["Request failed"] = "Yêu cầu thất bại",
        ["Unknown Artist"] = "Nghệ sĩ không rõ",
        ["Unknown Album"] = "Album không rõ",
        ["Unknown Track"] = "Bài hát không rõ",
        ["HTTP request threw an error"] = "Yêu cầu HTTP gặp lỗi",
        ["Failed to start HTTP request"] = "Không thể bắt đầu yêu cầu HTTP",
        ["Not logged in"] = "Chưa đăng nhập",
        ["Server URL not configured"] = "Chưa cấu hình URL máy chủ",
        ["Signed out"] = "Đã đăng xuất",
        ["Network error: %s"] = "Lỗi mạng: %s",
        ["Session expired - please log in again"] = "Phiên đã hết hạn - vui lòng đăng nhập lại",
        ["Unauthorized (401)"] = "Không có quyền (401)",
        ["HTTP error %s"] = "Lỗi HTTP %s",
        ["JSON decode error: %s"] = "Lỗi giải mã JSON: %s",
        ["Invalid server URL"] = "URL máy chủ không hợp lệ",
        ["Please enter a username"] = "Vui lòng nhập tên người dùng",
        ["Failed to save server URL"] = "Không lưu được URL máy chủ",
        ["Failed to save username"] = "Không lưu được tên người dùng",
        ["Login failed: %s"] = "Đăng nhập thất bại: %s",
        ["Invalid username or password"] = "Sai tên người dùng hoặc mật khẩu",
        ["Login failed (HTTP %s)"] = "Đăng nhập thất bại (HTTP %s)",
        ["Invalid server response"] = "Phản hồi máy chủ không hợp lệ",
        ["Login failed: missing access token or user ID"] = "Đăng nhập thất bại: thiếu mã truy cập hoặc ID người dùng",
        ["Secure storage unavailable"] = "Bộ nhớ bảo mật không khả dụng",
        ["Failed to store access token safely"] = "Không thể lưu mã truy cập an toàn",
        ["Failed to save user profile"] = "Không lưu được hồ sơ người dùng",
        ["Logged in as %s"] = "Đã đăng nhập là %s",
        ["Logged out"] = "Đã đăng xuất",
        ["Invalid track item"] = "Mục bài hát không hợp lệ",
        ["Unsupported stream protocol: %s"] = "Giao thức phát không hỗ trợ: %s",
        ["HLS streams not supported for direct playback"] = "Không hỗ trợ phát trực tiếp luồng HLS",
        ["Live streams not supported for direct playback"] = "Không hỗ trợ phát trực tiếp luồng trực tuyến",
        ["DRM or protected media not supported"] = "Không hỗ trợ nội dung có DRM hoặc được bảo vệ",
        ["Incompatible codec: %s"] = "Codec không tương thích: %s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "Không hỗ trợ FLAC trong định dạng chứa (%s) khác FLAC",
        ["MP3 in non-MP3 container (%s) unsupported"] = "Không hỗ trợ MP3 trong định dạng chứa (%s) khác MP3",
        ["AAC in unsupported container (%s)"] = "AAC trong định dạng chứa không hỗ trợ (%s)",
        ["No compatible audio stream found"] = "Không tìm thấy luồng âm thanh tương thích",
        ["Failed to resolve track details: %s"] = "Không lấy được chi tiết bài hát: %s",
        ["Unsupported audio format"] = "Định dạng âm thanh không hỗ trợ",
        ["No stream link"] = "Không có liên kết phát",
        ["Unsupported format"] = "Định dạng không hỗ trợ",
        ["Please log in first"] = "Vui lòng đăng nhập trước",
        ["Playing: %s"] = "Đang phát: %s",
        ["track"] = "bài hát",
        ["No tracks to play"] = "Không có bài hát để phát",
        ["Selected track not found in list"] = "Không tìm thấy bài đã chọn trong danh sách",
        ["Queued %d tracks"] = "Đã thêm %d bài vào hàng đợi",
        ["Preparing playback"] = "Đang chuẩn bị phát",
        ["No compatible playable tracks found"] = "Không tìm thấy bài hát tương thích để phát",
        ["Queued %d tracks (%d unsupported skipped)"] = "Đã xếp %d bài (bỏ qua %d bài không hỗ trợ)",
        ["Selected track is unsupported: %s"] = "Bài đã chọn không được hỗ trợ: %s",
        ["format"] = "định dạng",
        ["Format inspection unsupported on this build"] = "Phiên bản này không hỗ trợ kiểm tra định dạng",
        ["No active track is currently playing"] = "Hiện không có bài hát nào đang phát",
        ["N/A (compressed)"] = "K/A (nén)",
        ["%d bit"] = "%d bit",
        ["Forward-only (Not seekable)"] = "Chỉ tiến (Không tua được)",
        ["Seekable (Confirmed by player Range)"] = "Tua được (Xác nhận qua Range)",
        ["unknown"] = "không rõ",
        ["Codec: %s"] = "Codec: %s",
        ["Sample Rate: %d Hz"] = "Tần số lấy mẫu: %d Hz",
        ["Bit Depth: %s"] = "Độ sâu bit: %s",
        ["Channels: %d"] = "Kênh: %d",
        ["Bitrate: %d kbps"] = "Bitrate: %d kbps",
        ["Stream Source: %s"] = "Nguồn phát: %s",
        ["Yes (HTTP)"] = "Có (HTTP)",
        ["No (Local)"] = "Không (Nội bộ)",
        ["Native Range Seeking: %s"] = "Tua Range gốc: %s",
        ["Volume Gain: %.2f"] = "Khuếch đại âm lượng: %.2f",
        ["Playback Format"] = "Định dạng phát",
        ["Password"] = "Mật khẩu",
        ["Saved Servers"] = "Máy chủ đã lưu",
        ["No saved servers"] = "Chưa có máy chủ đã lưu",
        ["Add one in Settings."] = "Hãy thêm trong Cài đặt.",
        ["Server URL"] = "URL máy chủ",
        ["Username"] = "Tên người dùng",
        ["Remove %s?"] = "Xóa %s?",
        ["Remove"] = "Xóa",
        ["Server removed"] = "Đã xóa máy chủ",
        ["Remove Server"] = "Xóa máy chủ",
        ["Add Server"] = "Thêm máy chủ",
        ["New server type: %s"] = "Loại máy chủ mới: %s",
        ["Failed to save server type"] = "Không lưu được loại máy chủ",
        ["Verify HTTPS TLS"] = "Xác minh HTTPS TLS",
        ["Failed to save TLS setting"] = "Không lưu được cài đặt TLS",
        ["Page Size: %s items"] = "Cỡ trang: %s mục",
        ["Failed to save page size"] = "Không lưu được cỡ trang",
        ["Music"] = "Nhạc",
        ["Search %s"] = "Tìm trong %s",
        ["Back"] = "Quay lại",
        ["Unnamed Library"] = "Thư viện chưa đặt tên",
        ["Search Music"] = "Tìm nhạc",
        ["Settings"] = "Cài đặt",
        ["Music Libraries"] = "Thư viện nhạc",
        ["Library"] = "Thư viện",
        ["Artists"] = "Nghệ sĩ",
        ["Albums"] = "Album",
        ["Songs"] = "Bài hát",
        ["Search in Library"] = "Tìm trong thư viện",
        ["Previous page"] = "Trang trước",
        ["Next page"] = "Trang sau",
        ["Artists (%d-%d / %d)"] = "Nghệ sĩ (%d-%d / %d)",
        ["Artist"] = "Nghệ sĩ",
        ["%s Albums (%d-%d / %d)"] = "Album của %s (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "Album (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "Phát trang (%d / %d bài)",
        ["Play album (%d tracks)"] = "Phát album (%d bài)",
        ["Album Tracks"] = "Bài hát trong album",
        ["Songs (%d-%d / %d)"] = "Bài hát (%d-%d / %d)",
        ["Item"] = "Mục",
        ["Song"] = "Bài hát",
        ["Album"] = "Album",
        ["(No results found)"] = "(Không tìm thấy kết quả)",
        ["Search: %s"] = "Tìm kiếm: %s",
    },
    zh_CN = {
        ["Jellyfin & Emby"] = "Jellyfin & Emby",
        ["Jellyfin / Emby"] = "Jellyfin / Emby",
        ["Jellyfin & Emby requires remote playback"] = "Jellyfin & Emby 需要远程播放支持",
        ["Missing or invalid server URL"] = "服务器 URL 缺失或无效",
        ["Server URL contains control characters"] = "服务器 URL 包含控制字符",
        ["Server URL cannot contain whitespace"] = "服务器 URL 不能包含空格",
        ["Credentials (userinfo) not allowed in server URL"] = "服务器 URL 中不允许包含凭据信息",
        ["Query string not allowed in base server URL"] = "服务器基础 URL 中不允许包含查询参数",
        ["Fragment not allowed in base server URL"] = "服务器基础 URL 中不允许包含片段标识",
        ["Unsupported URL scheme; must be http or https"] = "不支持的 URL 协议；必须为 http 或 https",
        ["Missing host in server URL"] = "服务器 URL 中缺少主机名",
        ["Invalid IPv6 address in server URL"] = "服务器 URL 中的 IPv6 地址无效",
        ["Invalid host in server URL"] = "服务器 URL 中的主机名无效",
        ["Invalid port number; must be 1-65535"] = "端口号无效；必须为 1-65535",
        ["Invalid IPv4 address in server URL"] = "服务器 URL 中的 IPv4 地址无效",
        ["Host name exceeds 253 characters"] = "主机名超过 253 个字符",
        ["Host label must be between 1 and 63 characters"] = "主机名段长度必须在 1 到 63 个字符之间",
        ["Host domain label cannot start or end with hyphen"] = "域名段不能以连字符开头或结尾",
        ["Invalid characters in host name"] = "主机名包含无效字符",
        ["Request failed"] = "请求失败",
        ["Unknown Artist"] = "未知艺人",
        ["Unknown Album"] = "未知专辑",
        ["Unknown Track"] = "未知曲目",
        ["HTTP request threw an error"] = "HTTP 请求抛出错误",
        ["Failed to start HTTP request"] = "无法发起 HTTP 请求",
        ["Not logged in"] = "未登录",
        ["Server URL not configured"] = "未配置服务器 URL",
        ["Signed out"] = "已退出登录",
        ["Network error: %s"] = "网络错误：%s",
        ["Session expired - please log in again"] = "会话已过期，请重新登录",
        ["Unauthorized (401)"] = "未授权 (401)",
        ["HTTP error %s"] = "HTTP 错误 %s",
        ["JSON decode error: %s"] = "JSON 解析错误：%s",
        ["Invalid server URL"] = "服务器 URL 无效",
        ["Please enter a username"] = "请输入用户名",
        ["Failed to save server URL"] = "无法保存服务器 URL",
        ["Failed to save username"] = "无法保存用户名",
        ["Login failed: %s"] = "登录失败：%s",
        ["Invalid username or password"] = "用户名或密码无效",
        ["Login failed (HTTP %s)"] = "登录失败 (HTTP %s)",
        ["Invalid server response"] = "服务器响应无效",
        ["Login failed: missing access token or user ID"] = "登录失败：缺少访问令牌或用户 ID",
        ["Secure storage unavailable"] = "安全存储不可用",
        ["Failed to store access token safely"] = "无法安全保存访问令牌",
        ["Failed to save user profile"] = "无法保存用户资料",
        ["Logged in as %s"] = "已作为 %s 登录",
        ["Logged out"] = "已退出登录",
        ["Invalid track item"] = "无效的曲目项",
        ["Unsupported stream protocol: %s"] = "不支持的流协议：%s",
        ["HLS streams not supported for direct playback"] = "不支持直接播放 HLS 流",
        ["Live streams not supported for direct playback"] = "不支持直接播放直播流",
        ["DRM or protected media not supported"] = "不支持 DRM 或受保护媒体",
        ["Incompatible codec: %s"] = "不兼容的编码：%s",
        ["FLAC in non-FLAC container (%s) unsupported"] = "不支持非 FLAC 容器 (%s) 中的 FLAC",
        ["MP3 in non-MP3 container (%s) unsupported"] = "不支持非 MP3 容器 (%s) 中的 MP3",
        ["AAC in unsupported container (%s)"] = "不支持该容器 (%s) 中的 AAC",
        ["No compatible audio stream found"] = "未找到兼容的音频流",
        ["Failed to resolve track details: %s"] = "无法获取曲目详情：%s",
        ["Unsupported audio format"] = "不支持的音频格式",
        ["No stream link"] = "无流媒体链接",
        ["Unsupported format"] = "不支持的格式",
        ["Please log in first"] = "请先登录",
        ["Playing: %s"] = "正在播放：%s",
        ["track"] = "曲目",
        ["No tracks to play"] = "没有可播放的曲目",
        ["Selected track not found in list"] = "列表中未找到所选曲目",
        ["Queued %d tracks"] = "已加入队列 %d 首曲目",
        ["Preparing playback"] = "正在准备播放",
        ["No compatible playable tracks found"] = "未找到可播放的兼容曲目",
        ["Queued %d tracks (%d unsupported skipped)"] = "已加入队列 %d 首（跳过 %d 首不支持曲目）",
        ["Selected track is unsupported: %s"] = "所选曲目不受支持：%s",
        ["format"] = "格式",
        ["Format inspection unsupported on this build"] = "当前版本不支持格式检查",
        ["No active track is currently playing"] = "当前没有正在播放的曲目",
        ["N/A (compressed)"] = "不适用（压缩音频）",
        ["%d bit"] = "%d bit",
        ["Forward-only (Not seekable)"] = "仅单向播放（不可拖动）",
        ["Seekable (Confirmed by player Range)"] = "可拖动（播放器 Range 已确认）",
        ["unknown"] = "未知",
        ["Codec: %s"] = "编码：%s",
        ["Sample Rate: %d Hz"] = "采样率：%d Hz",
        ["Bit Depth: %s"] = "位深：%s",
        ["Channels: %d"] = "声道：%d",
        ["Bitrate: %d kbps"] = "比特率：%d kbps",
        ["Stream Source: %s"] = "流来源：%s",
        ["Yes (HTTP)"] = "是 (HTTP)",
        ["No (Local)"] = "否（本地）",
        ["Native Range Seeking: %s"] = "原生 Range 拖动：%s",
        ["Volume Gain: %.2f"] = "音量增益：%.2f",
        ["Playback Format"] = "播放格式",
        ["Password"] = "密码",
        ["Saved Servers"] = "已保存的服务器",
        ["No saved servers"] = "没有已保存的服务器",
        ["Add one in Settings."] = "请在设置中添加。",
        ["Server URL"] = "服务器 URL",
        ["Username"] = "用户名",
        ["Remove %s?"] = "移除 %s？",
        ["Remove"] = "移除",
        ["Server removed"] = "已移除服务器",
        ["Remove Server"] = "移除服务器",
        ["Add Server"] = "添加服务器",
        ["New server type: %s"] = "新服务器类型：%s",
        ["Failed to save server type"] = "无法保存服务器类型",
        ["Verify HTTPS TLS"] = "验证 HTTPS TLS",
        ["Failed to save TLS setting"] = "无法保存 TLS 设置",
        ["Page Size: %s items"] = "每页数量：%s 项",
        ["Failed to save page size"] = "无法保存每页数量",
        ["Music"] = "音乐",
        ["Search %s"] = "搜索 %s",
        ["Back"] = "返回",
        ["Unnamed Library"] = "未命名媒体库",
        ["Search Music"] = "搜索音乐",
        ["Settings"] = "设置",
        ["Music Libraries"] = "音乐媒体库",
        ["Library"] = "媒体库",
        ["Artists"] = "艺人",
        ["Albums"] = "专辑",
        ["Songs"] = "歌曲",
        ["Search in Library"] = "在媒体库中搜索",
        ["Previous page"] = "上一页",
        ["Next page"] = "下一页",
        ["Artists (%d-%d / %d)"] = "艺人 (%d-%d / %d)",
        ["Artist"] = "艺人",
        ["%s Albums (%d-%d / %d)"] = "%s 的专辑 (%d-%d / %d)",
        ["Albums (%d-%d / %d)"] = "专辑 (%d-%d / %d)",
        ["Play page (%d of %d tracks)"] = "播放本页（%d / %d 首）",
        ["Play album (%d tracks)"] = "播放专辑（%d 首）",
        ["Album Tracks"] = "专辑曲目",
        ["Songs (%d-%d / %d)"] = "歌曲 (%d-%d / %d)",
        ["Item"] = "项目",
        ["Song"] = "歌曲",
        ["Album"] = "专辑",
        ["(No results found)"] = "（未找到结果）",
        ["Search: %s"] = "搜索：%s",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

if not plugin.has_capability("playback.remote") then
    plugin.show_toast(tr("Jellyfin & Emby requires remote playback"))
    return
end

local VALID_CODECS = { flac = true, mp3 = true, aac = true }
local REQUEST_FIELDS = "MediaSources,MediaStreams,ProductionYear,RunTimeTicks,AlbumArtist,Artists,ParentIndexNumber,IndexNumber"

-- Asynchronous lifecycle, generation counters, and navigation state
local current_generation = 1
local account_generation = 1
local nav_generation = 1
local active_requests = {}

local current_browse_handle = nil
local current_browse_view_key = nil
local browse_history = {}
local current_view = nil

local function cancel_active_requests()
    current_generation = current_generation + 1
    for handle in pairs(active_requests) do
        plugin.cancel(handle)
    end
    active_requests = {}
end

-- Strictly validate base http(s) URL with optional base path
local function validate_and_normalize_server_url(raw_url)
    if not raw_url or type(raw_url) ~= "string" then
        return nil, tr("Missing or invalid server URL")
    end

    if raw_url:find("[%z\1-\31\127]") then
        return nil, tr("Server URL contains control characters")
    end

    if raw_url:find("%s") then
        return nil, tr("Server URL cannot contain whitespace")
    end

    if raw_url:find("@", 1, true) then
        return nil, tr("Credentials (userinfo) not allowed in server URL")
    end

    if raw_url:find("?", 1, true) then
        return nil, tr("Query string not allowed in base server URL")
    end

    if raw_url:find("#", 1, true) then
        return nil, tr("Fragment not allowed in base server URL")
    end

    local scheme, rest
    if raw_url:match("^[hH][tT][tT][pP][sS]://") then
        scheme = "https"
        rest = raw_url:sub(9)
    elseif raw_url:match("^[hH][tT][tT][pP]://") then
        scheme = "http"
        rest = raw_url:sub(8)
    else
        if raw_url:find("://", 1, true) then
            return nil, tr("Unsupported URL scheme; must be http or https")
        end
        scheme = "https"
        rest = raw_url
    end

    local host_port, path = rest:match("^([^/]+)(.*)$")
    if not host_port or host_port == "" then
        return nil, tr("Missing host in server URL")
    end

    local host, port
    if host_port:sub(1, 1) == "[" then
        local ipv6, p = host_port:match("^%[([a-fA-F0-9:]+)%]:?(%d*)$")
        if not ipv6 then
            return nil, tr("Invalid IPv6 address in server URL")
        end
        host = "[" .. ipv6:lower() .. "]"
        port = p
    else
        host, port = host_port:match("^([^:]+):?(%d*)$")
        if not host or host == "" then
            return nil, tr("Invalid host in server URL")
        end
    end

    if port and port ~= "" then
        local pnum = tonumber(port)
        if not pnum or pnum < 1 or pnum > 65535 then
            return nil, tr("Invalid port number; must be 1-65535")
        end
    end

    if host:sub(1, 1) ~= "[" then
        local octets = { host:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$") }
        if #octets == 4 then
            for _, oct in ipairs(octets) do
                local n = tonumber(oct)
                if not n or n < 0 or n > 255 then
                    return nil, tr("Invalid IPv4 address in server URL")
                end
            end
        else
            if #host > 253 then
                return nil, tr("Host name exceeds 253 characters")
            end
            for label in host:gmatch("[^%.]+") do
                if #label == 0 or #label > 63 then
                    return nil, tr("Host label must be between 1 and 63 characters")
                end
                if label:match("^%-") or label:match("%-$") then
                    return nil, tr("Host domain label cannot start or end with hyphen")
                end
                if not label:match("^[a-zA-Z0-9%-]+$") then
                    return nil, tr("Invalid characters in host name")
                end
            end
        end
    end

    path = path or ""
    path = path:gsub("/+$", "")
    if path ~= "" and path:sub(1, 1) ~= "/" then
        path = "/" .. path
    end

    local port_str = (port and port ~= "") and (":" .. port) or ""
    return scheme .. "://" .. host:lower() .. port_str .. path, nil
end

local function url_encode(str)
    if not str then return "" end
    return (tostring(str):gsub("[^%w_%-%.~]", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

local function build_query(params)
    if not params then return "" end
    local parts = {}
    for k, v in pairs(params) do
        if v ~= nil and v ~= "" then
            parts[#parts + 1] = url_encode(k) .. "=" .. url_encode(tostring(v))
        end
    end
    table.sort(parts)
    return table.concat(parts, "&")
end

local function join_endpoint(base_url, endpoint)
    local norm_base, err = validate_and_normalize_server_url(base_url)
    if not norm_base then return nil, err end

    endpoint = (endpoint or ""):match("^%s*(.-)%s*$")
    endpoint = endpoint:gsub("^/+", "")

    local _, base_path = norm_base:match("^(https?://[^/]+)(.*)$")
    base_path = (base_path or ""):gsub("^/+", ""):gsub("/+$", "")

    if base_path ~= "" then
        if endpoint == base_path then
            endpoint = ""
        elseif endpoint:sub(1, #base_path + 1) == base_path .. "/" then
            endpoint = endpoint:sub(#base_path + 2)
        end
    end

    if endpoint == "" then
        return norm_base
    else
        return norm_base .. "/" .. endpoint
    end
end

local function api_url(endpoint, query_params)
    local server_url = plugin.storage.get("server_url", "")
    if server_url == "" then return nil end
    local full_url, err = join_endpoint(server_url, endpoint)
    if not full_url then return nil, err end
    if query_params then
        local qs = build_query(query_params)
        if qs ~= "" then
            full_url = full_url .. (full_url:find("?", 1, true) and "&" or "?") .. qs
        end
    end
    return full_url
end

local function get_device_id()
    local dev_id = plugin.storage.get("device_id", "")
    if dev_id == "" then
        local raw = tostring(os.time()) .. "-compas-" .. tostring(math.random(100000, 999999))
        if plugin.md5 then
            dev_id = plugin.md5(raw)
        else
            dev_id = "compas-device-" .. raw
        end
        plugin.storage.set("device_id", dev_id)
    end
    return dev_id
end

local function make_auth_header(token)
    local client = "Compas"
    local device = "Compas Player"
    local device_id = get_device_id()
    local version = "1.1"
    local parts = {
        string.format('Client="%s"', client),
        string.format('Device="%s"', device),
        string.format('DeviceId="%s"', device_id),
        string.format('Version="%s"', version),
    }
    if token and token ~= "" then
        parts[#parts + 1] = string.format('Token="%s"', token)
    end
    return "MediaBrowser " .. table.concat(parts, ", ")
end

local function is_tls_verify_enabled()
    return plugin.storage.get("verify_tls", "1") == "1"
end

local function is_authenticated()
    if not plugin.secrets or not plugin.secrets.get then return false end
    local token = plugin.secrets.get("access_token")
    local user_id = plugin.storage.get("user_id", "")
    return token ~= nil and token ~= "" and user_id ~= ""
end

local function get_clamped_page_size()
    local size = tonumber(plugin.storage.get("page_size", "25")) or 25
    size = math.floor(size)
    -- Keep requests small enough for the player's bounded JSON/UI memory.
    -- Older installs may still have stored 50; normalize that in memory.
    return size == 10 and 10 or 25
end

-- Invalidate all auth state immediately
local function clear_auth_state()
    account_generation = account_generation + 1
    nav_generation = nav_generation + 1
    cancel_active_requests()
    if plugin.secrets and plugin.secrets.delete then
        plugin.secrets.delete("access_token")
    end
    plugin.storage.delete("user_id")
    current_browse_handle = nil
    current_browse_view_key = nil
    current_view = nil
    browse_history = {}
end

-- Saved servers: a JSON list in storage "servers", each with its own token
-- secret. The active server keeps the original single-server keys, so the
-- browsing and playback code below is unchanged.
local function load_servers()
    local raw = plugin.storage.get("servers", "")
    local list = raw ~= "" and plugin.json_decode(raw) or nil
    return type(list) == "table" and list or {}
end

local function save_servers(list)
    return plugin.storage.set("servers", plugin.json_encode(list))
end

-- json_decode returns numbers as floats; format the id as an integer so
-- the key matches the one written at sign-in ("token_1", not "token_1.0").
local function server_token_key(server)
    return string.format("token_%d", math.floor(tonumber(server.id) or 0))
end

local function server_label(server)
    local host = tostring(server.url):match("^%a+://([^/]+)") or tostring(server.url)
    local kind = server.kind == "emby" and "Emby" or "Jellyfin"
    return tostring(server.username) .. " @ " .. host .. " (" .. kind .. ")"
end

local function find_active_server(list)
    local url = plugin.storage.get("server_url", "")
    local kind = plugin.storage.get("server_kind", "jellyfin")
    local username = plugin.storage.get("username", ""):lower()
    for i, server in ipairs(list) do
        if server.url == url and server.kind == kind and tostring(server.username):lower() == username then
            return i, server
        end
    end
end

-- Adds or updates the active server; token is nil when not signed in.
local function remember_active_server(token)
    local list = load_servers()
    local _, server = find_active_server(list)
    if not server then
        local next_id = tonumber(plugin.storage.get("next_server_id", "1")) or 1
        plugin.storage.set("next_server_id", tostring(next_id + 1))
        server = { id = next_id }
        list[#list + 1] = server
    end
    server.url = plugin.storage.get("server_url", "")
    server.kind = plugin.storage.get("server_kind", "jellyfin")
    server.username = plugin.storage.get("username", "")
    server.user_id = plugin.storage.get("user_id", "")
    if token and plugin.secrets and plugin.secrets.set then
        plugin.secrets.set(server_token_key(server), token)
    end
    save_servers(list)
end

local function forget_active_server_token()
    local _, server = find_active_server(load_servers())
    if server and plugin.secrets and plugin.secrets.delete then
        plugin.secrets.delete(server_token_key(server))
    end
end

local function activate_server(server)
    clear_auth_state()
    plugin.storage.set("server_url", server.url)
    plugin.storage.set("server_kind", server.kind)
    plugin.storage.set("username", server.username)
    local token = plugin.secrets and plugin.secrets.get and plugin.secrets.get(server_token_key(server))
    if token and token ~= "" and server.user_id and server.user_id ~= "" then
        plugin.secrets.set("access_token", token)
        plugin.storage.set("user_id", server.user_id)
    end
end

local function remove_server(index)
    local list = load_servers()
    local active_index = find_active_server(list)
    local server = table.remove(list, index)
    if not server then return end
    if plugin.secrets and plugin.secrets.delete then
        plugin.secrets.delete(server_token_key(server))
    end
    save_servers(list)
    if active_index == index then
        clear_auth_state()
        plugin.storage.delete("server_url")
        plugin.storage.delete("username")
    end
end

-- Earlier versions kept a single server; keep it as the first saved one.
local function migrate_single_server()
    if plugin.storage.get("servers", "") ~= "" or plugin.storage.get("server_url", "") == "" then return end
    local token = plugin.secrets and plugin.secrets.get and plugin.secrets.get("access_token")
    remember_active_server(token ~= "" and token or nil)
end

local function sanitize_error(err)
    if not err then return tr("Request failed") end
    local s = tostring(err)
    s = s:gsub("https?://[^%s\"',;>]+", "[server]")
    s = s:gsub("Token=\"[^\"]*\"", "Token=\"[REDACTED]\"")
    s = s:gsub("Authorization:[^\r\n]*", "Authorization: [REDACTED]")
    s = s:gsub("ApiKey=[^%s&]*", "ApiKey=[REDACTED]")
    s = s:gsub("api_key=[^%s&]*", "api_key=[REDACTED]")
    s = s:gsub("Pw=\"[^\"]*\"", "Pw=\"[REDACTED]\"")
    s = s:gsub("password=[^%s&]*", "password=[REDACTED]")
    return s
end

local function to_positive_integer(v)
    if type(v) == "number" and v > 0 and v == v and v ~= math.huge then
        return math.floor(v)
    elseif type(v) == "string" then
        local n = tonumber(v)
        if n and n > 0 and n == n and n ~= math.huge then
            return math.floor(n)
        end
    end
    return 0
end

local function safe_string(val, default, max_len)
    default = default or ""
    max_len = max_len or 256
    if type(val) == "string" then
        val = val:match("^%s*(.-)%s*$")
        if #val > max_len then
            val = val:sub(1, max_len)
        end
        return (val ~= "") and val or default
    elseif type(val) == "number" then
        return tostring(val)
    end
    return default
end

local function safe_artist_name(item)
    if not item or type(item) ~= "table" then return tr("Unknown Artist") end
    if type(item.AlbumArtist) == "string" and item.AlbumArtist:match("%S") then
        return safe_string(item.AlbumArtist, tr("Unknown Artist"), 128)
    end
    if type(item.Artists) == "table" and #item.Artists > 0 then
        local names = {}
        for _, a in ipairs(item.Artists) do
            if type(a) == "string" and a:match("%S") then
                names[#names + 1] = safe_string(a, "", 64)
            elseif type(a) == "table" and type(a.Name) == "string" and a.Name:match("%S") then
                names[#names + 1] = safe_string(a.Name, "", 64)
            end
        end
        if #names > 0 then
            return table.concat(names, ", ")
        end
    end
    return tr("Unknown Artist")
end

local function safe_album_name(item)
    if not item or type(item) ~= "table" then return tr("Unknown Album") end
    return safe_string(item.Album or item.Name, tr("Unknown Album"), 128)
end

local function safe_track_name(item)
    if not item or type(item) ~= "table" then return tr("Unknown Track") end
    return safe_string(item.Name, tr("Unknown Track"), 128)
end

-- Asynchronous HTTP dispatch
local function http_call(opts, callback)
    local gen = current_generation
    local called = false
    local handle = nil

    local function safe_callback(status, body, err, headers)
        if called then return end
        called = true
        if gen ~= current_generation then
            return
        end
        local safe_err = err and sanitize_error(err) or nil
        callback(status, body, safe_err, headers)
    end

    local ok, res, req_err = pcall(function()
        return plugin.http_request(opts, function(status, body, err, headers)
            if handle then
                active_requests[handle] = nil
            end
            safe_callback(status, body, err, headers)
        end)
    end)

    if not ok then
        safe_callback(nil, nil, sanitize_error(res or tr("HTTP request threw an error")), nil)
        return nil
    end

    handle = res
    if not handle then
        safe_callback(nil, nil, sanitize_error(req_err or tr("Failed to start HTTP request")), nil)
        return nil
    end

    if not called then
        active_requests[handle] = gen
    end
    return handle
end

-- Authenticated API requests guarded by account, navigation generation and list visibility
-- background: stream lookups for the player, answered whatever screen is up.
local function request_api(method, endpoint, query_params, body, callback, background)
    local token = nil
    if plugin.secrets and plugin.secrets.get then
        token = plugin.secrets.get("access_token")
    end
    if not token or token == "" then
        callback(nil, tr("Not logged in"))
        return
    end

    local url, url_err = api_url(endpoint, query_params)
    if not url then
        callback(nil, sanitize_error(url_err or tr("Server URL not configured")))
        return
    end

    local server_kind = plugin.storage.get("server_kind", "jellyfin")
    local auth_header = make_auth_header(token)

    local headers = {
        ["Authorization"] = auth_header,
        ["User-Agent"] = "Compas/1.1",
        ["Accept"] = "application/json",
    }
    if server_kind == "emby" then
        headers["X-Emby-Token"] = token
        headers["X-Emby-Authorization"] = auth_header
    end

    local content_type = body and "application/json" or nil
    local verify_tls = is_tls_verify_enabled()

    local req_acc_gen = account_generation
    local req_nav_gen = nav_generation
    local req_handle = current_browse_handle

    http_call({
        url = url,
        method = method or "GET",
        headers = headers,
        body = body,
        content_type = content_type,
        verify_tls = verify_tls,
        connect_timeout_ms = 15000,
        read_timeout_ms = 20000,
        total_timeout_ms = 35000,
    }, function(status, resp_body, err, resp_headers)
        if req_acc_gen ~= account_generation then
            if background then callback(nil, tr("Signed out")) end
            return
        end

        if not background and req_nav_gen ~= nav_generation then
            return
        end

        if not background and req_handle and plugin.has_capability("ui.list_showing") and not plugin.is_list_showing(req_handle) then
            return
        end

        if err then
            callback(nil, string.format(tr("Network error: %s"), sanitize_error(err)))
            return
        end

        if status == 401 then
            forget_active_server_token()
            clear_auth_state()
            plugin.show_toast(tr("Session expired - please log in again"))
            callback(nil, tr("Unauthorized (401)"))
            return
        end

        if status < 200 or status >= 300 then
            callback(nil, string.format(tr("HTTP error %s"), tostring(status)))
            return
        end

        if not resp_body or resp_body == "" then
            callback({}, nil)
            return
        end

        local data, json_err = plugin.json_decode(resp_body)
        if not data then
            callback(nil, string.format(tr("JSON decode error: %s"), sanitize_error(json_err)))
            return
        end

        callback(data, nil)
    end)
end

-- Login flow with pre-clearing of credentials
local function do_login(server_url, username, password, on_done)
    local norm_url, url_err = validate_and_normalize_server_url(server_url)
    if not norm_url then
        plugin.show_toast(url_err or tr("Invalid server URL"))
        if on_done then on_done(false, url_err or tr("Invalid server URL")) end
        return
    end

    username = (username or ""):match("^%s*(.-)%s*$")
    if username == "" then
        plugin.show_toast(tr("Please enter a username"))
        if on_done then on_done(false, "Missing username") end
        return
    end

    if not password then password = "" end

    -- Clear old auth state BEFORE attempting new login
    clear_auth_state()

    local url_ok = plugin.storage.set("server_url", norm_url)
    if not url_ok then
        plugin.show_toast(tr("Failed to save server URL"))
        if on_done then on_done(false, "Storage error: server_url") end
        return
    end

    local user_ok = plugin.storage.set("username", username)
    if not user_ok then
        plugin.show_toast(tr("Failed to save username"))
        if on_done then on_done(false, "Storage error: username") end
        return
    end

    local auth_endpoint = join_endpoint(norm_url, "Users/AuthenticateByName")
    local auth_header = make_auth_header(nil)
    local body_json = plugin.json_encode({
        Username = username,
        Pw = password,
    })

    local verify_tls = is_tls_verify_enabled()
    local server_kind = plugin.storage.get("server_kind", "jellyfin")
    local headers = {
        ["Authorization"] = auth_header,
        ["Content-Type"] = "application/json",
        ["User-Agent"] = "Compas/1.1",
        ["Accept"] = "application/json",
    }
    if server_kind == "emby" then
        headers["X-Emby-Authorization"] = auth_header
    end

    local login_acc_gen = account_generation

    http_call({
        url = auth_endpoint,
        method = "POST",
        headers = headers,
        body = body_json,
        content_type = "application/json",
        verify_tls = verify_tls,
        connect_timeout_ms = 15000,
        read_timeout_ms = 20000,
        total_timeout_ms = 35000,
    }, function(status, resp_body, err, resp_headers)
        if login_acc_gen ~= account_generation then
            return
        end

        if err then
            plugin.show_toast(string.format(tr("Login failed: %s"), sanitize_error(err)))
            if on_done then on_done(false, sanitize_error(err)) end
            return
        end

        if status == 401 then
            plugin.show_toast(tr("Invalid username or password"))
            if on_done then on_done(false, "Invalid credentials") end
            return
        end

        if status ~= 200 then
            plugin.show_toast(string.format(tr("Login failed (HTTP %s)"), tostring(status)))
            if on_done then on_done(false, "HTTP " .. tostring(status)) end
            return
        end

        local data, jerr = plugin.json_decode(resp_body)
        if not data or type(data) ~= "table" then
            plugin.show_toast(tr("Invalid server response"))
            if on_done then on_done(false, "JSON error") end
            return
        end

        local token = data.AccessToken
        local user = data.User

        if type(user) ~= "table" or type(user.Id) ~= "string" or #user.Id == 0 or
           type(token) ~= "string" or #token == 0 then
            plugin.show_toast(tr("Login failed: missing access token or user ID"))
            if on_done then on_done(false, "Missing token or user ID") end
            return
        end

        local user_id = user.Id

        if not plugin.secrets or not plugin.secrets.set then
            plugin.show_toast(tr("Secure storage unavailable"))
            if on_done then on_done(false, "plugin.secrets unavailable") end
            return
        end

        local token_saved = plugin.secrets.set("access_token", token)
        if not token_saved then
            clear_auth_state()
            plugin.show_toast(tr("Failed to store access token safely"))
            if on_done then on_done(false, "secrets storage failure") end
            return
        end

        local user_saved = plugin.storage.set("user_id", user_id)
        if not user_saved then
            clear_auth_state()
            plugin.show_toast(tr("Failed to save user profile"))
            if on_done then on_done(false, "storage failure") end
            return
        end

        if user.Name and type(user.Name) == "string" then
            plugin.storage.set("username", user.Name)
        end

        remember_active_server(token)
        plugin.show_toast(string.format(tr("Logged in as %s"), tostring(user.Name or username)))
        if on_done then on_done(true, nil) end
    end)
end

local function do_logout()
    clear_auth_state()
    plugin.show_toast(tr("Logged out"))
end

-- MediaSources and MediaStreams compatibility checking
local function is_mp4_container(container)
    -- Jellyfin's ProbeResultNormalizer preserves FFprobe's comma-separated
    -- aliases (mov,mp4,m4a,3gp,3g2,mj2). These name one container family.
    local family = { mov = true, mp4 = true, m4a = true, m4b = true, ["3gp"] = true, ["3g2"] = true, mj2 = true }
    local identified = false
    for raw_alias in container:gmatch("[^,]+") do
        local alias = raw_alias:match("^%s*(.-)%s*$")
        if not family[alias] then return false end
        if alias == "mp4" or alias == "m4a" or alias == "m4b" then identified = true end
    end
    return identified
end

local function evaluate_track_compatibility(item)
    if not item or type(item) ~= "table" then
        return nil, tr("Invalid track item")
    end

    local sources = item.MediaSources
    if not sources or type(sources) ~= "table" or #sources == 0 then
        return nil, "missing_metadata"
    end

    local first_incompatible_reason = nil
    local has_incomplete_source = false

    for _, src in ipairs(sources) do
        if type(src) ~= "table" then
            has_incomplete_source = true
        else
            local is_rejected = false
            local reject_reason = nil

            local raw_proto = (type(src.Protocol) == "string") and src.Protocol or "File"
            local proto = raw_proto:lower()
            if proto ~= "file" and proto ~= "http" then
                is_rejected = true
                reject_reason = string.format(tr("Unsupported stream protocol: %s"), raw_proto)
            end

            local raw_container = ""
            if type(src.Container) == "string" then
                raw_container = src.Container:lower()
            elseif type(item.Container) == "string" then
                raw_container = item.Container:lower()
            end

            if raw_container == "m3u8" or raw_container == "hls" then
                is_rejected = true
                reject_reason = tr("HLS streams not supported for direct playback")
            end

            if src.IsInfiniteStream == true or item.IsInfiniteStream == true then
                is_rejected = true
                reject_reason = tr("Live streams not supported for direct playback")
            end

            if src.IsKeyFrameRequired == true or src.DRM == true or src.IsEncrypted == true then
                is_rejected = true
                reject_reason = tr("DRM or protected media not supported")
            end

            if not is_rejected then
                local streams = src.MediaStreams
                if not streams or type(streams) ~= "table" or #streams == 0 then
                    has_incomplete_source = true
                else
                    local found_audio = false
                    for _, st in ipairs(streams) do
                        if type(st) == "table" and st.Type == "Audio" then
                            found_audio = true
                            local raw_codec = (type(st.Codec) == "string") and st.Codec or ""
                            local codec = raw_codec:lower()

                            if codec == "" then
                                has_incomplete_source = true
                            elseif not VALID_CODECS[codec] then
                                if not first_incompatible_reason then
                                    first_incompatible_reason = string.format(tr("Incompatible codec: %s"), codec)
                                end
                            else
                                local container_ok = false
                                local is_forward_only = false
                                local stream_ext = nil

                                if codec == "flac" then
                                    if raw_container == "flac" then
                                        container_ok = true
                                        stream_ext = "flac"
                                    else
                                        reject_reason = string.format(tr("FLAC in non-FLAC container (%s) unsupported"), raw_container)
                                    end
                                elseif codec == "mp3" then
                                    if raw_container == "mp3" or raw_container == "" then
                                        container_ok = true
                                        stream_ext = "mp3"
                                    else
                                        reject_reason = string.format(tr("MP3 in non-MP3 container (%s) unsupported"), raw_container)
                                    end
                                elseif codec == "aac" then
                                    if is_mp4_container(raw_container) then
                                        container_ok = true
                                        stream_ext = "m4a"
                                    elseif raw_container == "aac" then
                                        container_ok = true
                                        stream_ext = "aac"
                                        is_forward_only = true
                                    else
                                        reject_reason = string.format(tr("AAC in unsupported container (%s)"), raw_container)
                                    end
                                end

                                if container_ok then
                                    local src_id = (type(src.Id) == "string" or type(src.Id) == "number") and tostring(src.Id) or nil
                                    return {
                                        codec = codec,
                                        container = stream_ext,
                                        sample_rate = to_positive_integer(st.SampleRate),
                                        bit_depth = to_positive_integer(st.BitDepth),
                                        channels = to_positive_integer(st.Channels),
                                        bitrate_kbps = math.floor(to_positive_integer(st.BitRate) / 1000),
                                        source_id = src_id,
                                        is_forward_only = is_forward_only,
                                    }
                                else
                                    if not first_incompatible_reason then
                                        first_incompatible_reason = reject_reason
                                    end
                                end
                            end
                        end
                    end
                    if not found_audio then
                        has_incomplete_source = true
                    end
                end
            else
                if not first_incompatible_reason then
                    first_incompatible_reason = reject_reason
                end
            end
        end
    end

    if has_incomplete_source and not first_incompatible_reason then
        return nil, "missing_metadata"
    end

    return nil, first_incompatible_reason or (has_incomplete_source and "missing_metadata" or tr("No compatible audio stream found"))
end

-- Resolve detailed item metadata if missing before playback
local function resolve_item_media(item, callback, background)
    if not item or type(item) ~= "table" then
        callback(nil, nil, tr("Invalid track item"))
        return
    end

    local compat, err = evaluate_track_compatibility(item)
    if compat then
        callback(item, compat, nil)
        return
    end

    if err == "missing_metadata" and (item.Id or item.ItemId) then
        local it_id = tostring(item.Id or item.ItemId)
        local user_id = plugin.storage.get("user_id", "")
        local endpoint = (user_id ~= "") and ("Users/" .. user_id .. "/Items/" .. it_id)
            or ("Items/" .. it_id)
        local params = { Fields = REQUEST_FIELDS }

        request_api("GET", endpoint, params, nil, function(data, api_err)
            if api_err then
                callback(nil, nil, string.format(tr("Failed to resolve track details: %s"), sanitize_error(api_err)))
                return
            end
            local detailed_item = (type(data) == "table") and data or item
            local d_compat, d_err = evaluate_track_compatibility(detailed_item)
            if not d_compat then
                callback(nil, nil, d_err or tr("Unsupported audio format"))
                return
            end
            callback(detailed_item, d_compat, nil)
        end, background)
    else
        callback(nil, nil, err or tr("Unsupported audio format"))
    end
end

local function item_id(item)
    return (type(item.Id) == "string" or type(item.Id) == "number") and tostring(item.Id) or "unknown"
end

local function stream_link(item, compat, token, server_kind)
    local token_param = (server_kind == "emby") and "api_key" or "ApiKey"
    local stream_query = {
        static = "true",
        [token_param] = token,
    }
    if compat.source_id then
        stream_query["mediaSourceId"] = compat.source_id
    end
    local raw_url = api_url("Audio/" .. item_id(item) .. "/stream." .. compat.container, stream_query)
    return raw_url and (raw_url .. "#." .. compat.container) or ""
end

-- Queue entry without a stream link; the resolver fetches it on demand.
local function track_metadata(item, token, server_kind)
    local token_param = (server_kind == "emby") and "api_key" or "ApiKey"
    local it_id = item_id(item)
    local art_id = (type(item.AlbumId) == "string" or type(item.AlbumId) == "number") and tostring(item.AlbumId) or it_id
    local artwork_url = api_url("Items/" .. art_id .. "/Images/Primary", {
        [token_param] = token,
        maxWidth = "300",
    }) or ""

    local ticks = to_positive_integer(item.RunTimeTicks)
    local duration_ms = math.floor(ticks / 10000)

    local title = safe_track_name(item)
    local artist = safe_artist_name(item)
    local album = safe_album_name(item)

    return {
        provider = (server_kind == "emby") and "emby" or "jellyfin",
        track_id = it_id,
        verify_tls = is_tls_verify_enabled(),
        title = title,
        artist = artist,
        album = album,
        duration_ms = duration_ms,
        artwork_url = artwork_url,
    }
end

local function build_remote_track(item, compat, token, server_kind)
    local track = track_metadata(item, token, server_kind)
    track.stream_url = stream_link(item, compat, token, server_kind)
    track.codec = compat.codec
    track.sample_rate = compat.sample_rate
    track.bit_depth = compat.bit_depth
    track.channels = compat.channels
    track.bitrate_kbps = compat.bitrate_kbps
    return track
end

-- With playback.remote_resolve the player asks for each link when the track
-- is about to play, so a whole album or page can be queued at once.
local ON_DEMAND = plugin.has_capability("playback.remote_resolve")
local EAGER_QUEUE_CAP = 12

local function stream_error_reason(err)
    err = tostring(err or "")
    local net_prefix = tr("Network error: %s"):match("^([^%%]+)") or "Network error"
    if err:find("Network error", 1, true) or (net_prefix ~= "" and err:find(net_prefix, 1, true)) then
        return "network"
    end
    if err == tr("Not logged in") or err == tr("Signed out") or err == tr("Unauthorized (401)")
       or err:find("Not logged in", 1, true) or err:find("Signed out", 1, true) or err:find("401", 1, true) then
        return "auth"
    end
    if err == tr("Unsupported audio format")
       or err == tr("HLS streams not supported for direct playback")
       or err == tr("Live streams not supported for direct playback")
       or err == tr("DRM or protected media not supported")
       or err == tr("No compatible audio stream found")
       or err:find("Unsupported", 1, true) or err:find("unsupported", 1, true) then
        return "quality"
    end
    for _, fmt in ipairs({
        "Unsupported stream protocol: %s",
        "Incompatible codec: %s",
        "FLAC in non-FLAC container (%s) unsupported",
        "MP3 in non-MP3 container (%s) unsupported",
        "AAC in unsupported container (%s)",
    }) do
        local prefix = tr(fmt):match("^([^%%]+)")
        if prefix and prefix ~= "" and err:find(prefix, 1, true) then
            return "quality"
        end
    end
    return "unavailable"
end

local function on_remote_stream_needed(provider, track_id, request_id)
    if provider ~= "jellyfin" and provider ~= "emby" then return end
    local token = plugin.secrets and plugin.secrets.get and plugin.secrets.get("access_token")
    if not token or token == "" then
        plugin.provide_remote_stream(request_id, { error = tr("Not logged in"), reason = "auth" })
        return
    end
    resolve_item_media({ Id = track_id }, function(item, compat, err)
        if not compat then
            plugin.provide_remote_stream(request_id, { error = err or tr("No stream link"), reason = stream_error_reason(err) })
            return
        end
        plugin.provide_remote_stream(request_id, {
            stream_url = stream_link(item, compat, token, plugin.storage.get("server_kind", "jellyfin")),
            codec = compat.codec,
            sample_rate = compat.sample_rate,
            bit_depth = compat.bit_depth,
            channels = compat.channels,
            bitrate_kbps = compat.bitrate_kbps,
            -- The link carries the session token, valid until sign-out.
            url_ttl_s = 3600,
        })
    end, true)
end
if ON_DEMAND then plugin.on("remote_stream_needed", on_remote_stream_needed) end

local function play_single_item(item)
    resolve_item_media(item, function(detailed_item, compat, err)
        if not compat then
            plugin.show_toast(err or tr("Unsupported format"))
            return
        end

        local token = plugin.secrets and plugin.secrets.get and plugin.secrets.get("access_token")
        if not token or token == "" then
            plugin.show_toast(tr("Please log in first"))
            return
        end

        local server_kind = plugin.storage.get("server_kind", "jellyfin")
        local track_meta = build_remote_track(detailed_item, compat, token, server_kind)
        plugin.play_remote(track_meta)
        plugin.show_toast(string.format(tr("Playing: %s"), track_meta.title or tr("track")))
    end)
end

local function play_items_queue(items, selected_item_id)
    if not items or type(items) ~= "table" or #items == 0 then
        plugin.show_toast(tr("No tracks to play"))
        return
    end

    local token = plugin.secrets and plugin.secrets.get and plugin.secrets.get("access_token")
    if not token or token == "" then
        plugin.show_toast(tr("Please log in first"))
        return
    end
    local server_kind = plugin.storage.get("server_kind", "jellyfin")

    local start_index = 1
    if selected_item_id then
        start_index = nil
        for idx, it in ipairs(items) do
            if type(it) == "table" and tostring(it.Id) == tostring(selected_item_id) then
                start_index = idx
                break
            end
        end
        if not start_index then
            plugin.show_toast(tr("Selected track not found in list"))
            return
        end
    end

    if ON_DEMAND then
        local queue, queue_start = {}, 1
        for idx, it in ipairs(items) do
            if #queue >= 500 then break end
            if type(it) == "table" and it.Id then
                queue[#queue + 1] = track_metadata(it, token, server_kind)
                if idx == start_index then queue_start = #queue end
            end
        end
        if #queue == 0 then
            plugin.show_toast(tr("No tracks to play"))
            return
        end
        plugin.show_toast(string.format(tr("Queued %d tracks"), #queue))
        plugin.queue_remote_list(queue, queue_start)
        return
    end

    -- Older players need every link before the queue starts: resolve a
    -- short queue from the selected track, like Qobuz and Tidal.
    local pending = {}
    for idx = start_index, #items do
        if type(items[idx]) == "table" then pending[#pending + 1] = items[idx] end
        if #pending >= EAGER_QUEUE_CAP then break end
    end
    plugin.show_toast(tr("Preparing playback"))
    local tracks, skipped = {}, 0
    local function step(k)
        if k > #pending then
            if #tracks == 0 then
                plugin.show_toast(tr("No compatible playable tracks found"))
                return
            end
            if skipped > 0 then
                plugin.show_toast(string.format(tr("Queued %d tracks (%d unsupported skipped)"), #tracks, skipped))
            else
                plugin.show_toast(string.format(tr("Queued %d tracks"), #tracks))
            end
            plugin.queue_remote_list(tracks, 1)
            return
        end
        resolve_item_media(pending[k], function(detailed_item, compat, err)
            if compat then
                tracks[#tracks + 1] = build_remote_track(detailed_item, compat, token, server_kind)
            elseif k == 1 and selected_item_id then
                plugin.show_toast(string.format(tr("Selected track is unsupported: %s"), tostring(err or tr("format"))))
                return
            else
                skipped = skipped + 1
            end
            step(k + 1)
        end, true)
    end
    step(1)
end

-- Dynamic format inspection
local function show_playback_format_screen()
    if not plugin.has_capability("playback.format") or not plugin.get_playback_format then
        plugin.show_toast(tr("Format inspection unsupported on this build"))
        return
    end

    local fmt = plugin.get_playback_format()
    if not fmt or type(fmt) ~= "table" then
        plugin.show_toast(tr("No active track is currently playing"))
        return
    end

    local depth_label = tr("N/A (compressed)")
    local b_depth = to_positive_integer(fmt.bit_depth)
    if b_depth > 0 then
        depth_label = string.format(tr("%d bit"), b_depth)
    end

    local seek_label = tr("Forward-only (Not seekable)")
    if fmt.seekable == true then
        seek_label = tr("Seekable (Confirmed by player Range)")
    end

    local gain_val = 1.0
    if type(fmt.software_volume_gain) == "number" and fmt.software_volume_gain == fmt.software_volume_gain then
        gain_val = fmt.software_volume_gain
    end

    local rows = {
        string.format(tr("Codec: %s"), safe_string(fmt.codec, tr("unknown"), 32)),
        string.format(tr("Sample Rate: %d Hz"), to_positive_integer(fmt.sample_rate)),
        string.format(tr("Bit Depth: %s"), depth_label),
        string.format(tr("Channels: %d"), to_positive_integer(fmt.channels)),
        string.format(tr("Bitrate: %d kbps"), to_positive_integer(fmt.bitrate_kbps)),
        string.format(tr("Stream Source: %s"), fmt.is_stream and tr("Yes (HTTP)") or tr("No (Local)")),
        string.format(tr("Native Range Seeking: %s"), seek_label),
        string.format(tr("Volume Gain: %.2f"), gain_val),
    }

    plugin.show_list(tr("Playback Format"), rows, function(index)
    end)
end

-- Virtual Browsing Screen with ui.list_update replace semantics
local execute_view

local function browse_view_key(view, page_size)
    local function part(value)
        local text = value == nil and "" or tostring(value)
        return tostring(#text) .. ":" .. text
    end
    local library = type(view.library) == "table" and view.library or {}
    local artist = type(view.artist) == "table" and view.artist or {}
    local album = type(view.album) == "table" and view.album or {}
    return table.concat({
        part(view.type), part(library.Id), part(artist.Id), part(album.Id),
        part(view.query), part(to_positive_integer(view.start_index)), part(page_size),
    })
end

local function render_screen(title, items, on_select, view, page_size, view_key_override)
    local bounded_items = {}
    local n = math.min(#items, 500)
    for i = 1, n do
        bounded_items[i] = items[i]
    end

    local view_key = view_key_override or browse_view_key(view or {}, page_size)
    local new_handle = nil
    if current_browse_handle and plugin.has_capability("ui.list_update") and plugin.is_list_showing(current_browse_handle) then
        local options = { replace = current_browse_handle }
        if current_browse_view_key ~= view_key and plugin.has_capability("ui.list_scroll_reset") then
            options.reset_scroll = true
        end
        new_handle = plugin.show_list(title, bounded_items, on_select, options)
    end

    if not new_handle then
        new_handle = plugin.show_list(title, bounded_items, on_select)
    end

    if new_handle then
        current_browse_handle = new_handle
        current_browse_view_key = view_key
    end
    return new_handle
end

local function go_back()
    if #browse_history > 0 then
        local prev_view = table.remove(browse_history)
        nav_generation = nav_generation + 1
        current_view = prev_view
        execute_view(prev_view)
    else
        current_browse_handle = nil
        current_browse_view_key = nil
        current_view = nil
    end
end

local function navigate_to(next_view)
    if current_view then
        if #browse_history >= 50 then
            table.remove(browse_history, 1)
        end
        browse_history[#browse_history + 1] = current_view
    end
    nav_generation = nav_generation + 1
    current_view = next_view
    execute_view(next_view)
end

local open_settings

local function open_libraries()
    browse_history = {}
    current_browse_handle = nil
    current_browse_view_key = nil
    nav_generation = nav_generation + 1
    current_view = { type = "libraries" }
    execute_view(current_view)
end

local function connect_server(server)
    activate_server(server)
    if is_authenticated() then
        open_libraries()
        return
    end
    plugin.show_text_input(tr("Password"), nil, true, function(pwd)
        if pwd == nil then return end
        do_login(server.url, server.username, pwd, function(ok)
            if ok then open_libraries() end
        end)
    end)
end

local function open_saved_servers()
    local list = load_servers()
    if #list == 0 then
        plugin.show_list(tr("Saved Servers"), { tr("No saved servers"), tr("Add one in Settings.") }, function() end)
        return
    end
    local labels = {}
    for i, server in ipairs(list) do labels[i] = server_label(server) end
    plugin.show_list(tr("Saved Servers"), labels, function(index)
        if list[index] then connect_server(list[index]) end
    end)
end

local function prompt_add_server()
    plugin.show_text_input(tr("Server URL"), "", false, function(url)
        if not url or url == "" then return end
        local norm_url, err = validate_and_normalize_server_url(url)
        if not norm_url then
            plugin.show_toast(err or tr("Invalid server URL"))
            return
        end
        plugin.show_text_input(tr("Username"), "", false, function(user)
            if not user or user == "" then return end
            plugin.show_text_input(tr("Password"), nil, true, function(pwd)
                plugin.storage.set("server_kind", plugin.storage.get("new_server_kind", "jellyfin"))
                do_login(norm_url, user, pwd or "", function(ok)
                    if ok then open_libraries() end
                end)
            end)
        end)
    end)
end

local function open_remove_servers(handle)
    local list = load_servers()
    local labels = {}
    for i, server in ipairs(list) do labels[i] = server_label(server) end
    if #labels == 0 then labels[1] = tr("No saved servers") end
    local function on_select(index)
        local server = list[index]
        if not server then return end
        plugin.show_confirmation(string.format(tr("Remove %s?"), server_label(server)), tr("Remove"), function()
            remove_server(index)
            plugin.show_toast(tr("Server removed"))
            open_remove_servers(handle)
        end)
    end
    if handle and plugin.has_capability("ui.list_update") and plugin.is_list_showing(handle) then
        handle = plugin.show_list(tr("Remove Server"), labels, on_select, { replace = handle }) or handle
    else
        handle = plugin.show_list(tr("Remove Server"), labels, on_select)
    end
end

open_settings = function()
    local new_kind = plugin.storage.get("new_server_kind", "jellyfin")
    local page_size = tostring(get_clamped_page_size())

    local items = {
        {
            type = "row",
            label = tr("Add Server"),
            on_select = prompt_add_server,
        },
        {
            type = "row",
            label = string.format(tr("New server type: %s"), new_kind == "emby" and "Emby" or "Jellyfin"),
            on_select = function()
                local ok = plugin.storage.set("new_server_kind", new_kind == "emby" and "jellyfin" or "emby")
                if not ok then
                    plugin.show_toast(tr("Failed to save server type"))
                    return
                end
                open_settings()
            end,
        },
        {
            type = "row",
            label = tr("Remove Server"),
            on_select = function() open_remove_servers(nil) end,
        },
        {
            type = "toggle",
            label = tr("Verify HTTPS TLS"),
            value = is_tls_verify_enabled(),
            on_change = function(val)
                local ok = plugin.storage.set("verify_tls", val and "1" or "0")
                if not ok then
                    plugin.show_toast(tr("Failed to save TLS setting"))
                end
            end,
        },
        {
            type = "row",
            label = string.format(tr("Page Size: %s items"), page_size),
            on_select = function()
                local new_size = (page_size == "25") and "10" or "25"
                local ok = plugin.storage.set("page_size", new_size)
                if not ok then
                    plugin.show_toast(tr("Failed to save page size"))
                    return
                end
                open_settings()
            end,
        },
    }

    plugin.show_settings_list(tr("Jellyfin & Emby"), items, { update = true })
end

local function prompt_search(library)
    local lib_name = (type(library) == "table") and safe_string(library.Name, tr("Music"), 128) or tr("Music")
    local title = string.format(tr("Search %s"), lib_name)
    plugin.show_text_input(title, "", false, function(query)
        if not query or query == "" then return end
        navigate_to({ type = "search", library = library, query = query })
    end)
end

-- Search results show the item type as the row's muted secondary line
-- ("title\nsecondary" on wrapped rows); older players get the bare title.
local LIST_WRAP = plugin.has_capability("ui.list_wrap")
local function search_result_row(name, kind)
    if LIST_WRAP then
        return { label = name .. "\n" .. kind, wrap = true }
    end
    return name
end

-- View rendering execution dispatcher
execute_view = function(view)
    if not is_authenticated() then
        open_settings()
        return
    end

    nav_generation = nav_generation + 1
    local page_size = get_clamped_page_size()
    local view_key = browse_view_key(view, page_size)
    local user_id = plugin.storage.get("user_id", "")

    if view.type == "libraries" then
        local endpoint = (user_id ~= "") and ("Users/" .. user_id .. "/Views") or "UserViews"
        request_api("GET", endpoint, nil, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local music_libs = {}
            for _, lib in ipairs(items) do
                if type(lib) == "table" and (type(lib.CollectionType) == "string") and lib.CollectionType:lower() == "music" then
                    music_libs[#music_libs + 1] = lib
                end
            end

            local final_libs = (#music_libs > 0) and music_libs or items
            local labels = {}
            local actions = {}

            if #browse_history > 0 then
                labels[#labels + 1] = tr("Back")
                actions[#actions + 1] = go_back
            end

            for _, lib in ipairs(final_libs) do
                if type(lib) == "table" then
                    labels[#labels + 1] = safe_string(lib.Name, tr("Unnamed Library"), 128)
                    actions[#actions + 1] = function()
                        navigate_to({ type = "library_menu", library = lib })
                    end
                end
            end

            labels[#labels + 1] = tr("Search Music")
            actions[#actions + 1] = function() prompt_search(nil) end

            labels[#labels + 1] = tr("Playback Format")
            actions[#actions + 1] = show_playback_format_screen

            labels[#labels + 1] = tr("Settings")
            actions[#actions + 1] = open_settings

            render_screen(tr("Music Libraries"), labels, function(index)
                if actions[index] then actions[index]() end
            end, view, page_size, view_key)
        end)

    elseif view.type == "library_menu" then
        local lib = (type(view.library) == "table") and view.library or {}
        local lib_name = safe_string(lib.Name, tr("Library"), 128)
        local labels = {
            tr("Back"),
            tr("Artists"),
            tr("Albums"),
            tr("Songs"),
            tr("Search in Library"),
        }
        local actions = {
            go_back,
            function() navigate_to({ type = "artists", library = lib, start_index = 0 }) end,
            function() navigate_to({ type = "albums", library = lib, start_index = 0 }) end,
            function() navigate_to({ type = "songs", library = lib, start_index = 0 }) end,
            function() prompt_search(lib) end,
        }
        render_screen(lib_name, labels, function(index)
            if actions[index] then actions[index]() end
        end, view, page_size, view_key)

    elseif view.type == "artists" then
        local lib = (type(view.library) == "table") and view.library or {}
        local start_idx = to_positive_integer(view.start_index)
        local params = {
            ParentId = lib.Id,
            SortBy = "SortName",
            SortOrder = "Ascending",
            StartIndex = start_idx,
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Artists", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local total = (type(data) == "table" and to_positive_integer(data.TotalRecordCount)) or #items
            if total < #items then total = #items end
            local labels = {}
            local actions = {}

            labels[#labels + 1] = tr("Back")
            actions[#actions + 1] = go_back

            if start_idx > 0 then
                labels[#labels + 1] = tr("Previous page")
                actions[#actions + 1] = function()
                    view.start_index = math.max(0, start_idx - page_size)
                    execute_view(view)
                end
            end

            for _, art in ipairs(items) do
                if #labels >= 500 then break end
                if type(art) == "table" then
                    labels[#labels + 1] = safe_string(art.Name, tr("Unknown Artist"), 128)
                    actions[#actions + 1] = function()
                        navigate_to({ type = "artist_albums", library = lib, artist = art, start_index = 0 })
                    end
                end
            end

            if (start_idx + #items < total) and (#labels < 500) then
                labels[#labels + 1] = tr("Next page")
                actions[#actions + 1] = function()
                    view.start_index = start_idx + page_size
                    execute_view(view)
                end
            end

            local title = string.format(tr("Artists (%d-%d / %d)"), start_idx + 1, start_idx + #items, total)
            render_screen(title, labels, function(index)
                if actions[index] then actions[index]() end
            end, view, page_size, view_key)
        end)

    elseif view.type == "artist_albums" then
        local lib = (type(view.library) == "table") and view.library or {}
        local art = (type(view.artist) == "table") and view.artist or {}
        local start_idx = to_positive_integer(view.start_index)
        local params = {
            ArtistIds = art.Id,
            IncludeItemTypes = "MusicAlbum",
            Recursive = "true",
            SortBy = "ProductionYear,SortName",
            SortOrder = "Descending",
            StartIndex = start_idx,
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if lib and lib.Id then params.ParentId = lib.Id end
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Items", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local total = (type(data) == "table" and to_positive_integer(data.TotalRecordCount)) or #items
            if total < #items then total = #items end
            local labels = {}
            local actions = {}

            labels[#labels + 1] = tr("Back")
            actions[#actions + 1] = go_back

            if start_idx > 0 then
                labels[#labels + 1] = tr("Previous page")
                actions[#actions + 1] = function()
                    view.start_index = math.max(0, start_idx - page_size)
                    execute_view(view)
                end
            end

            for _, alb in ipairs(items) do
                if #labels >= 500 then break end
                if type(alb) == "table" then
                    local yr_num = to_positive_integer(alb.ProductionYear)
                    local yr = (yr_num > 0) and (" (" .. yr_num .. ")") or ""
                    labels[#labels + 1] = safe_string(alb.Name, tr("Unknown Album"), 128) .. yr
                    actions[#actions + 1] = function()
                        navigate_to({ type = "album_tracks", album = alb, library = lib, start_index = 0 })
                    end
                end
            end

            if (start_idx + #items < total) and (#labels < 500) then
                labels[#labels + 1] = tr("Next page")
                actions[#actions + 1] = function()
                    view.start_index = start_idx + page_size
                    execute_view(view)
                end
            end

            local art_name = safe_string(art.Name, tr("Artist"), 128)
            local title = string.format(tr("%s Albums (%d-%d / %d)"), art_name, start_idx + 1, start_idx + #items, total)
            render_screen(title, labels, function(index)
                if actions[index] then actions[index]() end
            end, view, page_size, view_key)
        end)

    elseif view.type == "albums" then
        local lib = (type(view.library) == "table") and view.library or {}
        local start_idx = to_positive_integer(view.start_index)
        local params = {
            ParentId = lib.Id,
            IncludeItemTypes = "MusicAlbum",
            Recursive = "true",
            SortBy = "SortName",
            SortOrder = "Ascending",
            StartIndex = start_idx,
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Items", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local total = (type(data) == "table" and to_positive_integer(data.TotalRecordCount)) or #items
            if total < #items then total = #items end
            local labels = {}
            local actions = {}

            labels[#labels + 1] = tr("Back")
            actions[#actions + 1] = go_back

            if start_idx > 0 then
                labels[#labels + 1] = tr("Previous page")
                actions[#actions + 1] = function()
                    view.start_index = math.max(0, start_idx - page_size)
                    execute_view(view)
                end
            end

            for _, alb in ipairs(items) do
                if #labels >= 500 then break end
                if type(alb) == "table" then
                    local a_label = safe_artist_name(alb)
                    local by_a = (a_label ~= tr("Unknown Artist")) and (" - " .. a_label) or ""
                    labels[#labels + 1] = safe_string(alb.Name, tr("Unknown Album"), 128) .. by_a
                    actions[#actions + 1] = function()
                        navigate_to({ type = "album_tracks", album = alb, library = lib, start_index = 0 })
                    end
                end
            end

            if (start_idx + #items < total) and (#labels < 500) then
                labels[#labels + 1] = tr("Next page")
                actions[#actions + 1] = function()
                    view.start_index = start_idx + page_size
                    execute_view(view)
                end
            end

            local title = string.format(tr("Albums (%d-%d / %d)"), start_idx + 1, start_idx + #items, total)
            render_screen(title, labels, function(index)
                if actions[index] then actions[index]() end
            end, view, page_size, view_key)
        end)

    elseif view.type == "album_tracks" then
        local alb = (type(view.album) == "table") and view.album or {}
        local start_idx = to_positive_integer(view.start_index)
        local params = {
            ParentId = alb.Id,
            IncludeItemTypes = "Audio",
            SortBy = "ParentIndexNumber,IndexNumber,SortName",
            SortOrder = "Ascending",
            StartIndex = start_idx,
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Items", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local tracks = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local total = (type(data) == "table" and to_positive_integer(data.TotalRecordCount)) or #tracks
            if total < #tracks then total = #tracks end
            local labels = {}
            local actions = {}

            labels[#labels + 1] = tr("Back")
            actions[#actions + 1] = go_back

            if #tracks < total then
                labels[#labels + 1] = string.format(tr("Play page (%d of %d tracks)"), #tracks, total)
            else
                labels[#labels + 1] = string.format(tr("Play album (%d tracks)"), #tracks)
            end
            actions[#actions + 1] = function()
                play_items_queue(tracks, nil)
            end

            if start_idx > 0 then
                labels[#labels + 1] = tr("Previous page")
                actions[#actions + 1] = function()
                    view.start_index = math.max(0, start_idx - page_size)
                    execute_view(view)
                end
            end

            local has_multi_disc = false
            for _, trk in ipairs(tracks) do
                if type(trk) == "table" and to_positive_integer(trk.ParentIndexNumber) > 1 then
                    has_multi_disc = true
                    break
                end
            end

            for _, trk in ipairs(tracks) do
                if #labels >= 500 then break end
                if type(trk) == "table" then
                    local p_idx = to_positive_integer(trk.ParentIndexNumber)
                    local idx = to_positive_integer(trk.IndexNumber)
                    local trk_name = safe_track_name(trk)
                    local track_label
                    if has_multi_disc and p_idx > 0 then
                        track_label = string.format("D%d.%02d %s", p_idx, idx, trk_name)
                    elseif idx > 0 then
                        track_label = string.format("%d. %s", idx, trk_name)
                    else
                        track_label = trk_name
                    end

                    local trk_id = (type(trk.Id) == "string" or type(trk.Id) == "number") and tostring(trk.Id) or nil
                    labels[#labels + 1] = track_label
                    actions[#actions + 1] = function()
                        play_items_queue(tracks, trk_id)
                    end
                end
            end

            if (start_idx + #tracks < total) and (#labels < 500) then
                labels[#labels + 1] = tr("Next page")
                actions[#actions + 1] = function()
                    view.start_index = start_idx + page_size
                    execute_view(view)
                end
            end

            local alb_title = safe_string(alb.Name, tr("Album Tracks"), 128)
            render_screen(alb_title, labels, function(index)
                if actions[index] then actions[index]() end
            end, view, page_size, view_key)
        end)

    elseif view.type == "songs" then
        local lib = (type(view.library) == "table") and view.library or {}
        local start_idx = to_positive_integer(view.start_index)
        local params = {
            ParentId = lib.Id,
            IncludeItemTypes = "Audio",
            Recursive = "true",
            SortBy = "SortName",
            SortOrder = "Ascending",
            StartIndex = start_idx,
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Items", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local total = (type(data) == "table" and to_positive_integer(data.TotalRecordCount)) or #items
            if total < #items then total = #items end
            local labels = {}
            local actions = {}

            labels[#labels + 1] = tr("Back")
            actions[#actions + 1] = go_back

            if start_idx > 0 then
                labels[#labels + 1] = tr("Previous page")
                actions[#actions + 1] = function()
                    view.start_index = math.max(0, start_idx - page_size)
                    execute_view(view)
                end
            end

            for _, trk in ipairs(items) do
                if #labels >= 500 then break end
                if type(trk) == "table" then
                    local art = safe_artist_name(trk)
                    local by_art = (art ~= tr("Unknown Artist")) and (" - " .. art) or ""
                    labels[#labels + 1] = safe_track_name(trk) .. by_art
                    actions[#actions + 1] = function()
                        play_single_item(trk)
                    end
                end
            end

            if (start_idx + #items < total) and (#labels < 500) then
                labels[#labels + 1] = tr("Next page")
                actions[#actions + 1] = function()
                    view.start_index = start_idx + page_size
                    execute_view(view)
                end
            end

            local title = string.format(tr("Songs (%d-%d / %d)"), start_idx + 1, start_idx + #items, total)
            render_screen(title, labels, function(index)
                if actions[index] then actions[index]() end
            end, view, page_size, view_key)
        end)

    elseif view.type == "search" then
        local lib = (type(view.library) == "table") and view.library or {}
        local query = safe_string(view.query, "", 128)
        local params = {
            SearchTerm = query,
            IncludeItemTypes = "Audio,MusicAlbum,MusicArtist",
            Recursive = "true",
            Limit = page_size,
            Fields = REQUEST_FIELDS,
        }
        if lib and lib.Id then params.ParentId = lib.Id end
        if user_id ~= "" then params.UserId = user_id end

        request_api("GET", "Items", params, nil, function(data, err)
            if err then plugin.show_toast(err) return end

            local items = (type(data) == "table" and type(data.Items) == "table") and data.Items or {}
            local labels = {}
            local actions = {}

            labels[#labels + 1] = tr("Back")
            actions[#actions + 1] = go_back

            for _, it in ipairs(items) do
                if #labels >= 500 then break end
                if type(it) == "table" then
                    local it_type = (type(it.Type) == "string") and it.Type or ""
                    local it_name = safe_string(it.Name, tr("Item"), 128)
                    if it_type == "Audio" then
                        labels[#labels + 1] = search_result_row(it_name, tr("Song"))
                        actions[#actions + 1] = function() play_single_item(it) end
                    elseif it_type == "MusicAlbum" then
                        labels[#labels + 1] = search_result_row(it_name, tr("Album"))
                        actions[#actions + 1] = function()
                            navigate_to({ type = "album_tracks", album = it, library = lib, start_index = 0 })
                        end
                    elseif it_type == "MusicArtist" then
                        labels[#labels + 1] = search_result_row(it_name, tr("Artist"))
                        actions[#actions + 1] = function()
                            navigate_to({ type = "artist_albums", library = lib, artist = it, start_index = 0 })
                        end
                    else
                        labels[#labels + 1] = it_name
                        actions[#actions + 1] = function() play_single_item(it) end
                    end
                end
            end

            if #labels == 1 then
                labels[#labels + 1] = tr("(No results found)")
                actions[#actions + 1] = function() end
            end

            render_screen(string.format(tr("Search: %s"), query), labels, function(index)
                if actions[index] then actions[index]() end
            end, view, page_size, view_key)
        end)
    end
end

local function open_stream_media_tile()
    plugin.show_settings_list(tr("Jellyfin / Emby"), {
        { type = "row", label = tr("Saved Servers"), on_select = open_saved_servers },
        { type = "row", label = tr("Settings"), on_select = open_settings },
    })
end

migrate_single_server()

-- Plugin entry registrations
-- Players with ui.breeze_stream_icons ship a Jellyfin-tinted Breeze server
-- icon; older ones keep the generic stream tile art.
local tile_icon = plugin.has_capability and plugin.has_capability("ui.breeze_stream_icons")
    and "stream_media/jellyfin_row.png" or "stream_media/radio.png"
plugin.register_stream_media_tile(tr("Jellyfin / Emby"), open_stream_media_tile, tile_icon)

-- Test export hook
if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        do_login = do_login,
        do_logout = do_logout,
        is_authenticated = is_authenticated,
        validate_and_normalize_server_url = validate_and_normalize_server_url,
        join_endpoint = join_endpoint,
        url_encode = url_encode,
        build_query = build_query,
        api_url = api_url,
        make_auth_header = make_auth_header,
        is_tls_verify_enabled = is_tls_verify_enabled,
        cancel_active_requests = cancel_active_requests,
        account_generation = function() return account_generation end,
        nav_generation = function() return nav_generation end,
        evaluate_track_compatibility = evaluate_track_compatibility,
        resolve_item_media = resolve_item_media,
        build_remote_track = build_remote_track,
        play_single_item = play_single_item,
        play_items_queue = play_items_queue,
        show_playback_format_screen = show_playback_format_screen,
        open_settings = open_settings,
        open_saved_servers = open_saved_servers,
        load_servers = load_servers,
        remove_server = remove_server,
        activate_server = activate_server,
        open_stream_media_tile = open_stream_media_tile,
        request_api = request_api,
        navigate_to = navigate_to,
        go_back = go_back,
        get_current_view = function() return current_view end,
        get_browse_history = function() return browse_history end,
        get_current_browse_handle = function() return current_browse_handle end,
        execute_view = execute_view,
        clear_auth_state = clear_auth_state,
    }
end
