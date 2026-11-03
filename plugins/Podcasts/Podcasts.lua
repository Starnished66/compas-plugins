plugin.define({ id = "example.podcasts", name = "Podcasts", version = "1.8.0", api_min = 19 })

local T = {
    de = {
        ["Podcasts"] = "Podcasts",
        ["Podcasts · Reading Room"] = "Podcasts · Lesezimmer",
        ["Podcast download"] = "Podcast-Download",
        ["%s applied for this session"] = "%s für diese Sitzung angewendet",
        ["Playback speed requires a newer player"] = "Wiedergabegeschwindigkeit erfordert einen neueren Player",
        ["Playback speed"] = "Wiedergabegeschwindigkeit",
        ["Playback speed is available for downloaded episodes"] = "Wiedergabegeschwindigkeit ist für heruntergeladene Folgen verfügbar",
        ["Speed is unavailable for this audio format"] = "Geschwindigkeit ist für dieses Audioformat nicht verfügbar",
        ["Could not save playback speed"] = "Wiedergabegeschwindigkeit konnte nicht gespeichert werden",
        ["Playback speed set to %sx"] = "Wiedergabegeschwindigkeit auf %sx gesetzt",
        ["Playback speed: %sx"] = "Wiedergabegeschwindigkeit: %sx",
        ["Podcasts settings"] = "Podcast-Einstellungen",
        ["No podcast episode selected"] = "Keine Podcast-Folge ausgewählt",
        ["Choose an episode from Podcasts to see its details"] = "Wähle eine Folge in Podcasts aus, um Details zu sehen",
        ["Episode · %s"] = "Folge · %s",
        ["Unknown episode"] = "Unbekannte Folge",
        ["Host · %s"] = "Moderator · %s",
        ["Unknown host"] = "Unbekannter Moderator",
        ["Show · %s"] = "Sendung · %s",
        ["Unknown show"] = "Unbekannte Sendung",
        ["Podcast speed is available for downloaded episodes"] = "Podcast-Geschwindigkeit ist für heruntergeladene Folgen verfügbar",
        ["Untitled episode"] = "Unbenannte Folge",
        ["Some download history could not be loaded"] = "Ein Teil des Download-Verlaufs konnte nicht geladen werden",
        ["Played"] = "Gespielt",
        ["Resume at %s"] = "Fortsetzen bei %s",
        ["New"] = "Neu",
        ["Downloaded"] = "Heruntergeladen",
        ["Downloading"] = "Wird heruntergeladen",
        ["Refresh episodes"] = "Folgen aktualisieren",
        ["Unsubscribe"] = "Deabonnieren",
        ["Could not load episodes. Try again."] = "Folgen konnten nicht geladen werden. Erneut versuchen.",
        ["Could not parse feed"] = "Feed konnte nicht verarbeitet werden",
        ["The feed returned no episodes; kept the saved list"] = "Der Feed enthielt keine Folgen; gespeicherte Liste beibehalten",
        ["%d new episodes"] = "%d neue Folgen",
        ["No new episodes"] = "Keine neuen Folgen",
        ["Loading..."] = "Laden...",
        ["Unsubscribe?"] = "Deabonnieren?",
        ["Unsubscribe %s"] = "%s deabonnieren",
        ["Cancel"] = "Abbrechen",
        ["Could not save subscriptions. Try again."] = "Abonnements konnten nicht gespeichert werden. Erneut versuchen.",
        ["Unsubscribed; downloads kept"] = "Deabonniert; Downloads behalten",
        ["Episode details unavailable"] = "Folgendetails nicht verfügbar",
        ["Resume"] = "Fortsetzen",
        ["Play download"] = "Download abspielen",
        ["Download"] = "Herunterladen",
        ["Cancel download"] = "Download abbrechen",
        ["Stream (no resume)"] = "Streamen (ohne Fortsetzen)",
        ["Could not stream episode. Try again."] = "Folge konnte nicht gestreamt werden. Erneut versuchen.",
        ["Mark as played"] = "Als gespielt markieren",
        ["Mark as unplayed"] = "Als ungespielt markieren",
        ["Marked as played"] = "Als gespielt markiert",
        ["Marked as unplayed"] = "Als ungespielt markiert",
        ["Delete download"] = "Download löschen",
        ["Tap Delete download again within 8 seconds to confirm"] = "Zur Bestätigung innerhalb von 8 Sekunden erneut auf Download löschen tippen",
        ["Download is no longer available"] = "Download ist nicht mehr verfügbar",
        ["Stop this episode before deleting its download"] = "Stoppe diese Folge, bevor du den Download löschst",
        ["Could not delete download. Try again."] = "Download konnte nicht gelöscht werden. Erneut versuchen.",
        ["Download deleted"] = "Download gelöscht",
        ["Episode"] = "Folge",
        ["Enter an http(s) feed URL"] = "Gib eine http(s)-Feed-URL ein",
        ["Subscription limit reached"] = "Abonnementlimit erreicht",
        ["Already subscribed"] = "Bereits abonniert",
        ["Could not read OPML"] = "OPML konnte nicht gelesen werden",
        ["Could not import subscriptions. Try again."] = "Abonnements konnten nicht importiert werden. Erneut versuchen.",
        ["Imported %d podcasts"] = "%d Podcasts importiert",
        ["No OPML files found in Podcasts"] = "Keine OPML-Dateien in Podcasts gefunden",
        ["Import OPML"] = "OPML importieren",
        ["No podcasts found"] = "Keine Podcasts gefunden",
        ["Podcast Search"] = "Podcast-Suche",
        ["Could not search podcasts. Try again."] = "Podcast-Suche fehlgeschlagen. Erneut versuchen.",
        ["Search podcasts"] = "Podcasts suchen",
        ["Text input busy"] = "Texteingabe belegt",
        ["Add feed URL"] = "Feed-URL hinzufügen",
        ["Could not download episode. Try again."] = "Folge konnte nicht heruntergeladen werden. Erneut versuchen.",
        ["Downloading episode…"] = "Folge wird heruntergeladen…",
        ["Episode downloaded"] = "Folge heruntergeladen",
        ["Episode downloaded, but progress could not be saved"] = "Folge heruntergeladen, aber Fortschritt konnte nicht gespeichert werden",
        ["Resolving episode URL…"] = "Folgen-URL wird aufgelöst…",
        ["Preparing episode download…"] = "Folgen-Download wird vorbereitet…",
        ["Download limit reached. Delete some downloads first."] = "Download-Limit erreicht. Lösche zuerst einige Downloads.",
        ["Episode download queued"] = "Folgen-Download in Warteschlange",
        ["Download cancelled"] = "Download abgebrochen",
        ["Unsubscribed"] = "Deabonniert",
        ["Downloads"] = "Downloads",
        ["Not played"] = "Ungespielt",
        ["No unplayed downloads"] = "Keine ungespielten Downloads",
        ["No played downloads"] = "Keine gespielten Downloads",
        ["No downloads yet. Open an episode and choose Download."] = "Noch keine Downloads. Öffne eine Folge und wähle Herunterladen.",
        ["Undated"] = "Ohne Datum",
        ["%s part %d"] = "%s Teil %d",
        ["%s to %s"] = "%s bis %s",
        ["File Manager is not supported on this device"] = "Dateimanager wird auf diesem Gerät nicht unterstützt",
        ["Could not open File Manager"] = "Dateimanager konnte nicht geöffnet werden",
        ["Could not open Podcasts in File Manager"] = "Podcasts konnte im Dateimanager nicht geöffnet werden",
        ["Downloads folder (File Manager)"] = "Download-Ordner (Dateimanager)",
        ["All downloads (%d)"] = "Alle Downloads (%d)",
        ["Not played (%d)"] = "Ungespielt (%d)",
        ["Played (%d)"] = "Gespielt (%d)",
        ["Delete played downloads"] = "Gespielte Downloads löschen",
        ["Tap again within 8 seconds to delete played downloads"] = "Innerhalb von 8 Sekunden erneut tippen, um gespielte Downloads zu löschen",
        ["Deleted %d; kept %d"] = "%d gelöscht; %d behalten",
        ["Deleted %d; kept %d; progress could not be saved"] = "%d gelöscht; %d behalten; Fortschritt konnte nicht gespeichert werden",
        ["Manage downloads"] = "Downloads verwalten",
        ["Manage subscriptions"] = "Abonnements verwalten",
        ["Export subscriptions"] = "Abonnements exportieren",
        ["Subscriptions exported"] = "Abonnements exportiert",
        ["Could not export subscriptions. Try again."] = "Abonnements konnten nicht exportiert werden. Erneut versuchen.",
        ["Continue: %s"] = "Weiterhören: %s",
        ["Downloads (File Manager)"] = "Downloads (Dateimanager)",
        ["1 new episode"] = "1 neue Folge",
        ["%d new"] = "%d neu",
        ["Discover podcasts"] = "Podcasts entdecken",
        ["Settings"] = "Einstellungen",
        ["Resume did not complete. Retry Resume from the episode."] = "Fortsetzen fehlgeschlagen. Versuche Fortsetzen in der Folge erneut.",
        ["Podcasts needs a newer player build"] = "Podcasts erfordert eine neuere Player-Version",
    },
    es = {
        ["Podcasts"] = "Podcasts",
        ["Podcasts · Reading Room"] = "Podcasts · Sala de lectura",
        ["Podcast download"] = "Descarga de podcast",
        ["%s applied for this session"] = "%s aplicado para esta sesión",
        ["Playback speed requires a newer player"] = "La velocidad de reproducción requiere un reproductor más reciente",
        ["Playback speed"] = "Velocidad de reproducción",
        ["Playback speed is available for downloaded episodes"] = "La velocidad de reproducción está disponible para episodios descargados",
        ["Speed is unavailable for this audio format"] = "La velocidad no está disponible para este formato de audio",
        ["Could not save playback speed"] = "No se pudo guardar la velocidad de reproducción",
        ["Playback speed set to %sx"] = "Velocidad de reproducción ajustada a %sx",
        ["Playback speed: %sx"] = "Velocidad de reproducción: %sx",
        ["Podcasts settings"] = "Ajustes de Podcasts",
        ["No podcast episode selected"] = "Ningún episodio de podcast seleccionado",
        ["Choose an episode from Podcasts to see its details"] = "Elige un episodio en Podcasts para ver sus detalles",
        ["Episode · %s"] = "Episodio · %s",
        ["Unknown episode"] = "Episodio desconocido",
        ["Host · %s"] = "Presentador · %s",
        ["Unknown host"] = "Presentador desconocido",
        ["Show · %s"] = "Programa · %s",
        ["Unknown show"] = "Programa desconocido",
        ["Podcast speed is available for downloaded episodes"] = "La velocidad de podcast está disponible para episodios descargados",
        ["Untitled episode"] = "Episodio sin título",
        ["Some download history could not be loaded"] = "No se pudo cargar parte del historial de descargas",
        ["Played"] = "Reproducido",
        ["Resume at %s"] = "Reanudar en %s",
        ["New"] = "Nuevo",
        ["Downloaded"] = "Descargado",
        ["Downloading"] = "Descargando",
        ["Refresh episodes"] = "Refrescar episodios",
        ["Unsubscribe"] = "Cancelar suscripción",
        ["Could not load episodes. Try again."] = "No se pudieron cargar los episodios. Inténtalo de nuevo.",
        ["Could not parse feed"] = "No se pudo procesar el feed",
        ["The feed returned no episodes; kept the saved list"] = "El feed no devolvió episodios; se conservó la lista guardada",
        ["%d new episodes"] = "%d episodios nuevos",
        ["No new episodes"] = "No hay episodios nuevos",
        ["Loading..."] = "Cargando...",
        ["Unsubscribe?"] = "¿Cancelar suscripción?",
        ["Unsubscribe %s"] = "Cancelar suscripción a %s",
        ["Cancel"] = "Cancelar",
        ["Could not save subscriptions. Try again."] = "No se pudieron guardar las suscripciones. Inténtalo de nuevo.",
        ["Unsubscribed; downloads kept"] = "Suscripción cancelada; se conservaron las descargas",
        ["Episode details unavailable"] = "Detalles del episodio no disponibles",
        ["Resume"] = "Reanudar",
        ["Play download"] = "Reproducir descarga",
        ["Download"] = "Descargar",
        ["Cancel download"] = "Cancelar descarga",
        ["Stream (no resume)"] = "Transmitir (sin reanudar)",
        ["Could not stream episode. Try again."] = "No se pudo transmitir el episodio. Inténtalo de nuevo.",
        ["Mark as played"] = "Marcar como reproducido",
        ["Mark as unplayed"] = "Marcar como no reproducido",
        ["Marked as played"] = "Marcado como reproducido",
        ["Marked as unplayed"] = "Marcado como no reproducido",
        ["Delete download"] = "Eliminar descarga",
        ["Tap Delete download again within 8 seconds to confirm"] = "Toca Eliminar descarga de nuevo en 8 segundos para confirmar",
        ["Download is no longer available"] = "La descarga ya no está disponible",
        ["Stop this episode before deleting its download"] = "Detén este episodio antes de eliminar su descarga",
        ["Could not delete download. Try again."] = "No se pudo eliminar la descarga. Inténtalo de nuevo.",
        ["Download deleted"] = "Descarga eliminada",
        ["Episode"] = "Episodio",
        ["Enter an http(s) feed URL"] = "Introduce una URL de feed http(s)",
        ["Subscription limit reached"] = "Límite de suscripciones alcanzado",
        ["Already subscribed"] = "Ya estás suscrito",
        ["Could not read OPML"] = "No se pudo leer el OPML",
        ["Could not import subscriptions. Try again."] = "No se pudieron importar las suscripciones. Inténtalo de nuevo.",
        ["Imported %d podcasts"] = "Se importaron %d podcasts",
        ["No OPML files found in Podcasts"] = "No se encontraron archivos OPML en Podcasts",
        ["Import OPML"] = "Importar OPML",
        ["No podcasts found"] = "No se encontraron podcasts",
        ["Podcast Search"] = "Búsqueda de podcasts",
        ["Could not search podcasts. Try again."] = "No se pudieron buscar podcasts. Inténtalo de nuevo.",
        ["Search podcasts"] = "Buscar podcasts",
        ["Text input busy"] = "Entrada de texto ocupada",
        ["Add feed URL"] = "Añadir URL de feed",
        ["Could not download episode. Try again."] = "No se pudo descargar el episodio. Inténtalo de nuevo.",
        ["Downloading episode…"] = "Descargando episodio…",
        ["Episode downloaded"] = "Episodio descargado",
        ["Episode downloaded, but progress could not be saved"] = "Episodio descargado, pero no se pudo guardar el progreso",
        ["Resolving episode URL…"] = "Resolviendo URL del episodio…",
        ["Preparing episode download…"] = "Preparando descarga del episodio…",
        ["Download limit reached. Delete some downloads first."] = "Límite de descargas alcanzado. Elimina algunas descargas primero.",
        ["Episode download queued"] = "Descarga de episodio en cola",
        ["Download cancelled"] = "Descarga cancelada",
        ["Unsubscribed"] = "Sin suscripción",
        ["Downloads"] = "Descargas",
        ["Not played"] = "No reproducidos",
        ["No unplayed downloads"] = "No hay descargas sin reproducir",
        ["No played downloads"] = "No hay descargas reproducidas",
        ["No downloads yet. Open an episode and choose Download."] = "Aún no hay descargas. Abre un episodio y elige Descargar.",
        ["Undated"] = "Sin fecha",
        ["%s part %d"] = "%s parte %d",
        ["%s to %s"] = "%s a %s",
        ["File Manager is not supported on this device"] = "El gestor de archivos no es compatible con este dispositivo",
        ["Could not open File Manager"] = "No se pudo abrir el gestor de archivos",
        ["Could not open Podcasts in File Manager"] = "No se pudo abrir Podcasts en el gestor de archivos",
        ["Downloads folder (File Manager)"] = "Carpeta de descargas (Gestor de archivos)",
        ["All downloads (%d)"] = "Todas las descargas (%d)",
        ["Not played (%d)"] = "No reproducidos (%d)",
        ["Played (%d)"] = "Reproducidos (%d)",
        ["Delete played downloads"] = "Eliminar descargas reproducidas",
        ["Tap again within 8 seconds to delete played downloads"] = "Toca de nuevo en 8 segundos para eliminar las descargas reproducidas",
        ["Deleted %d; kept %d"] = "Eliminados %d; conservados %d",
        ["Deleted %d; kept %d; progress could not be saved"] = "Eliminados %d; conservados %d; no se pudo guardar el progreso",
        ["Manage downloads"] = "Gestionar descargas",
        ["Manage subscriptions"] = "Gestionar suscripciones",
        ["Export subscriptions"] = "Exportar suscripciones",
        ["Subscriptions exported"] = "Suscripciones exportadas",
        ["Could not export subscriptions. Try again."] = "No se pudieron exportar las suscripciones. Inténtalo de nuevo.",
        ["Continue: %s"] = "Continuar: %s",
        ["Downloads (File Manager)"] = "Descargas (Gestor de archivos)",
        ["1 new episode"] = "1 episodio nuevo",
        ["%d new"] = "%d nuevos",
        ["Discover podcasts"] = "Descubrir podcasts",
        ["Settings"] = "Ajustes",
        ["Resume did not complete. Retry Resume from the episode."] = "No se pudo reanudar. Vuelve a intentar Reanudar desde el episodio.",
        ["Podcasts needs a newer player build"] = "Podcasts requiere una versión más reciente del reproductor",
    },
    fi = {
        ["Podcasts"] = "Podcastit",
        ["Podcasts · Reading Room"] = "Podcastit · Lukusali",
        ["Podcast download"] = "Podcastin lataus",
        ["%s applied for this session"] = "%s käytössä tässä istunnossa",
        ["Playback speed requires a newer player"] = "Toistonopeus vaatii uudemman soittimen",
        ["Playback speed"] = "Toistonopeus",
        ["Playback speed is available for downloaded episodes"] = "Toistonopeus on käytettävissä ladatuille jaksoille",
        ["Speed is unavailable for this audio format"] = "Nopeus ei ole käytettävissä tälle äänimuodolle",
        ["Could not save playback speed"] = "Toistonopeutta ei voitu tallentaa",
        ["Playback speed set to %sx"] = "Toistonopeudeksi asetettu %sx",
        ["Playback speed: %sx"] = "Toistonopeus: %sx",
        ["Podcasts settings"] = "Podcast-asetukset",
        ["No podcast episode selected"] = "Ei valittua podcast-jaksoa",
        ["Choose an episode from Podcasts to see its details"] = "Valitse jakso Podcasteista nähdäksesi sen tiedot",
        ["Episode · %s"] = "Jakso · %s",
        ["Unknown episode"] = "Tuntematon jakso",
        ["Host · %s"] = "Juontaja · %s",
        ["Unknown host"] = "Tuntematon juontaja",
        ["Show · %s"] = "Ohjelma · %s",
        ["Unknown show"] = "Tuntematon ohjelma",
        ["Podcast speed is available for downloaded episodes"] = "Podcast-nopeus on käytettävissä ladatuille jaksoille",
        ["Untitled episode"] = "Nimetön jakso",
        ["Some download history could not be loaded"] = "Osaa lataushistoriasta ei voitu ladata",
        ["Played"] = "Kuunneltu",
        ["Resume at %s"] = "Jatka kohdasta %s",
        ["New"] = "Uusi",
        ["Downloaded"] = "Ladattu",
        ["Downloading"] = "Ladataan",
        ["Refresh episodes"] = "Päivitä jaksot",
        ["Unsubscribe"] = "Lopeta tilaus",
        ["Could not load episodes. Try again."] = "Jaksoja ei voitu ladata. Yritä uudelleen.",
        ["Could not parse feed"] = "Syötteen jäsentäminen epäonnistui",
        ["The feed returned no episodes; kept the saved list"] = "Syöte ei palauttanut jaksoja; säilytettiin tallennettu luettelo",
        ["%d new episodes"] = "%d uutta jaksoa",
        ["No new episodes"] = "Ei uusia jaksoja",
        ["Loading..."] = "Ladataan...",
        ["Unsubscribe?"] = "Lopetetaanko tilaus?",
        ["Unsubscribe %s"] = "Lopeta tilaus: %s",
        ["Cancel"] = "Peruuta",
        ["Could not save subscriptions. Try again."] = "Tilauksia ei voitu tallentaa. Yritä uudelleen.",
        ["Unsubscribed; downloads kept"] = "Tilaus lopetettu; lataukset säilytetty",
        ["Episode details unavailable"] = "Jakson tiedot eivät ole saatavilla",
        ["Resume"] = "Jatka",
        ["Play download"] = "Toista lataus",
        ["Download"] = "Lataa",
        ["Cancel download"] = "Peruuta lataus",
        ["Stream (no resume)"] = "Suoratoista (ei jatkoa)",
        ["Could not stream episode. Try again."] = "Jaksoa ei voitu suoratoistaa. Yritä uudelleen.",
        ["Mark as played"] = "Merkitse kuunnelluksi",
        ["Mark as unplayed"] = "Merkitse kuuntelemattomaksi",
        ["Marked as played"] = "Merkitty kuunnelluksi",
        ["Marked as unplayed"] = "Merkitty kuuntelemattomaksi",
        ["Delete download"] = "Poista lataus",
        ["Tap Delete download again within 8 seconds to confirm"] = "Vahvista napauttamalla Poista lataus uudelleen 8 sekunnin kuluessa",
        ["Download is no longer available"] = "Lataus ei ole enää saatavilla",
        ["Stop this episode before deleting its download"] = "Pysäytä tämä jakso ennen latauksen poistamista",
        ["Could not delete download. Try again."] = "Latausta ei voitu poistaa. Yritä uudelleen.",
        ["Download deleted"] = "Lataus poistettu",
        ["Episode"] = "Jakso",
        ["Enter an http(s) feed URL"] = "Syötä http(s)-syötteen osoite",
        ["Subscription limit reached"] = "Tilausraja saavutettu",
        ["Already subscribed"] = "Jo tilattu",
        ["Could not read OPML"] = "OPML-tiedostoa ei voitu lukea",
        ["Could not import subscriptions. Try again."] = "Tilauksia ei voitu tuoda. Yritä uudelleen.",
        ["Imported %d podcasts"] = "Tuotiin %d podcastia",
        ["No OPML files found in Podcasts"] = "Podcasts-kansiosta ei löytynyt OPML-tiedostoja",
        ["Import OPML"] = "Tuo OPML",
        ["No podcasts found"] = "Podcasteja ei löytynyt",
        ["Podcast Search"] = "Podcast-haku",
        ["Could not search podcasts. Try again."] = "Podcast-haku epäonnistui. Yritä uudelleen.",
        ["Search podcasts"] = "Hae podcasteja",
        ["Text input busy"] = "Tekstinsyöttö varattu",
        ["Add feed URL"] = "Lisää syötteen osoite",
        ["Could not download episode. Try again."] = "Jaksoa ei voitu ladata. Yritä uudelleen.",
        ["Downloading episode…"] = "Ladataan jaksoa…",
        ["Episode downloaded"] = "Jakso ladattu",
        ["Episode downloaded, but progress could not be saved"] = "Jakso ladattu, mutta edistymistä ei voitu tallentaa",
        ["Resolving episode URL…"] = "Selvitetään jakson osoitetta…",
        ["Preparing episode download…"] = "Valmistellaan jakson latausta…",
        ["Download limit reached. Delete some downloads first."] = "Latausraja saavutettu. Poista ensin joitakin latauksia.",
        ["Episode download queued"] = "Jakson lataus jonossa",
        ["Download cancelled"] = "Lataus peruutettu",
        ["Unsubscribed"] = "Tilaus lopetettu",
        ["Downloads"] = "Lataukset",
        ["Not played"] = "Kuuntelemattomat",
        ["No unplayed downloads"] = "Ei kuuntelemattomia latauksia",
        ["No played downloads"] = "Ei kuunneltuja latauksia",
        ["No downloads yet. Open an episode and choose Download."] = "Ei vielä latauksia. Avaa jakso ja valitse Lataa.",
        ["Undated"] = "Ei päiväystä",
        ["%s part %d"] = "%s osa %d",
        ["%s to %s"] = "%s – %s",
        ["File Manager is not supported on this device"] = "Tiedostonhallintaa ei tueta tällä laitteella",
        ["Could not open File Manager"] = "Tiedostonhallintaa ei voitu avata",
        ["Could not open Podcasts in File Manager"] = "Podcasts-kansiota ei voitu avata tiedostonhallinnassa",
        ["Downloads folder (File Manager)"] = "Latauskansio (Tiedostonhallinta)",
        ["All downloads (%d)"] = "Kaikki lataukset (%d)",
        ["Not played (%d)"] = "Kuuntelemattomat (%d)",
        ["Played (%d)"] = "Kuunnellut (%d)",
        ["Delete played downloads"] = "Poista kuunnellut lataukset",
        ["Tap again within 8 seconds to delete played downloads"] = "Napauta uudelleen 8 sekunnin kuluessa poistaaksesi kuunnellut lataukset",
        ["Deleted %d; kept %d"] = "Poistettu %d; säilytetty %d",
        ["Deleted %d; kept %d; progress could not be saved"] = "Poistettu %d; säilytetty %d; edistymistä ei voitu tallentaa",
        ["Manage downloads"] = "Hallitse latauksia",
        ["Manage subscriptions"] = "Hallitse tilauksia",
        ["Export subscriptions"] = "Vie tilaukset",
        ["Subscriptions exported"] = "Tilaukset viety",
        ["Could not export subscriptions. Try again."] = "Tilauksia ei voitu viedä. Yritä uudelleen.",
        ["Continue: %s"] = "Jatka: %s",
        ["Downloads (File Manager)"] = "Lataukset (Tiedostonhallinta)",
        ["1 new episode"] = "1 uusi jakso",
        ["%d new"] = "%d uutta",
        ["Discover podcasts"] = "Etsi podcasteja",
        ["Settings"] = "Asetukset",
        ["Resume did not complete. Retry Resume from the episode."] = "Jatkaminen epäonnistui. Yritä Jatka-toimintoa uudelleen jaksosta.",
        ["Podcasts needs a newer player build"] = "Podcastit vaatii uudemman soitinversion",
    },
    fr = {
        ["Podcasts"] = "Podcasts",
        ["Podcasts · Reading Room"] = "Podcasts · Salon d'écoute",
        ["Podcast download"] = "Téléchargement du podcast",
        ["%s applied for this session"] = "%s appliqué pour cette session",
        ["Playback speed requires a newer player"] = "La vitesse de lecture nécessite un lecteur plus récent",
        ["Playback speed"] = "Vitesse de lecture",
        ["Playback speed is available for downloaded episodes"] = "La vitesse de lecture est disponible pour les épisodes téléchargés",
        ["Speed is unavailable for this audio format"] = "La vitesse n'est pas disponible pour ce format audio",
        ["Could not save playback speed"] = "Impossible d'enregistrer la vitesse de lecture",
        ["Playback speed set to %sx"] = "Vitesse de lecture réglée sur %sx",
        ["Playback speed: %sx"] = "Vitesse de lecture : %sx",
        ["Podcasts settings"] = "Paramètres des podcasts",
        ["No podcast episode selected"] = "Aucun épisode de podcast sélectionné",
        ["Choose an episode from Podcasts to see its details"] = "Choisissez un épisode dans Podcasts pour voir ses détails",
        ["Episode · %s"] = "Épisode · %s",
        ["Unknown episode"] = "Épisode inconnu",
        ["Host · %s"] = "Animateur · %s",
        ["Unknown host"] = "Animateur inconnu",
        ["Show · %s"] = "Émission · %s",
        ["Unknown show"] = "Émission inconnue",
        ["Podcast speed is available for downloaded episodes"] = "La vitesse du podcast est disponible pour les épisodes téléchargés",
        ["Untitled episode"] = "Épisode sans titre",
        ["Some download history could not be loaded"] = "Une partie de l'historique des téléchargements n'a pas pu être chargée",
        ["Played"] = "Lu",
        ["Resume at %s"] = "Reprendre à %s",
        ["New"] = "Nouveau",
        ["Downloaded"] = "Téléchargé",
        ["Downloading"] = "Téléchargement",
        ["Refresh episodes"] = "Actualiser les épisodes",
        ["Unsubscribe"] = "Se désabonner",
        ["Could not load episodes. Try again."] = "Impossible de charger les épisodes. Réessayez.",
        ["Could not parse feed"] = "Impossible d'analyser le flux",
        ["The feed returned no episodes; kept the saved list"] = "Le flux n'a renvoyé aucun épisode ; liste enregistrée conservée",
        ["%d new episodes"] = "%d nouveaux épisodes",
        ["No new episodes"] = "Aucun nouvel épisode",
        ["Loading..."] = "Chargement...",
        ["Unsubscribe?"] = "Se désabonner ?",
        ["Unsubscribe %s"] = "Se désabonner de %s",
        ["Cancel"] = "Annuler",
        ["Could not save subscriptions. Try again."] = "Impossible d'enregistrer les abonnements. Réessayez.",
        ["Unsubscribed; downloads kept"] = "Désabonné ; téléchargements conservés",
        ["Episode details unavailable"] = "Détails de l'épisode indisponibles",
        ["Resume"] = "Reprendre",
        ["Play download"] = "Lire le téléchargement",
        ["Download"] = "Télécharger",
        ["Cancel download"] = "Annuler le téléchargement",
        ["Stream (no resume)"] = "Écouter en flux (sans reprise)",
        ["Could not stream episode. Try again."] = "Impossible de diffuser l'épisode. Réessayez.",
        ["Mark as played"] = "Marquer comme lu",
        ["Mark as unplayed"] = "Marquer comme non lu",
        ["Marked as played"] = "Marqué comme lu",
        ["Marked as unplayed"] = "Marqué comme non lu",
        ["Delete download"] = "Supprimer le téléchargement",
        ["Tap Delete download again within 8 seconds to confirm"] = "Appuyez à nouveau sur Supprimer le téléchargement sous 8 secondes pour confirmer",
        ["Download is no longer available"] = "Le téléchargement n'est plus disponible",
        ["Stop this episode before deleting its download"] = "Arrêtez cet épisode avant de supprimer son téléchargement",
        ["Could not delete download. Try again."] = "Impossible de supprimer le téléchargement. Réessayez.",
        ["Download deleted"] = "Téléchargement supprimé",
        ["Episode"] = "Épisode",
        ["Enter an http(s) feed URL"] = "Entrez une URL de flux http(s)",
        ["Subscription limit reached"] = "Limite d'abonnements atteinte",
        ["Already subscribed"] = "Déjà abonné",
        ["Could not read OPML"] = "Impossible de lire le fichier OPML",
        ["Could not import subscriptions. Try again."] = "Impossible d'importer les abonnements. Réessayez.",
        ["Imported %d podcasts"] = "%d podcasts importés",
        ["No OPML files found in Podcasts"] = "Aucun fichier OPML trouvé dans Podcasts",
        ["Import OPML"] = "Importer OPML",
        ["No podcasts found"] = "Aucun podcast trouvé",
        ["Podcast Search"] = "Recherche de podcasts",
        ["Could not search podcasts. Try again."] = "Impossible de rechercher des podcasts. Réessayez.",
        ["Search podcasts"] = "Rechercher des podcasts",
        ["Text input busy"] = "Saisie de texte occupée",
        ["Add feed URL"] = "Ajouter l'URL du flux",
        ["Could not download episode. Try again."] = "Impossible de télécharger l'épisode. Réessayez.",
        ["Downloading episode…"] = "Téléchargement de l'épisode…",
        ["Episode downloaded"] = "Épisode téléchargé",
        ["Episode downloaded, but progress could not be saved"] = "Épisode téléchargé, mais la progression n'a pas pu être enregistrée",
        ["Resolving episode URL…"] = "Résolution de l'URL de l'épisode…",
        ["Preparing episode download…"] = "Préparation du téléchargement de l'épisode…",
        ["Download limit reached. Delete some downloads first."] = "Limite de téléchargements atteinte. Supprimez d'abord des téléchargements.",
        ["Episode download queued"] = "Téléchargement de l'épisode mis en file d'attente",
        ["Download cancelled"] = "Téléchargement annulé",
        ["Unsubscribed"] = "Désabonné",
        ["Downloads"] = "Téléchargements",
        ["Not played"] = "Non lus",
        ["No unplayed downloads"] = "Aucun téléchargement non lu",
        ["No played downloads"] = "Aucun téléchargement lu",
        ["No downloads yet. Open an episode and choose Download."] = "Aucun téléchargement. Ouvrez un épisode et choisissez Télécharger.",
        ["Undated"] = "Sans date",
        ["%s part %d"] = "%s partie %d",
        ["%s to %s"] = "%s à %s",
        ["File Manager is not supported on this device"] = "Le gestionnaire de fichiers n'est pas pris en charge sur cet appareil",
        ["Could not open File Manager"] = "Impossible d'ouvrir le gestionnaire de fichiers",
        ["Could not open Podcasts in File Manager"] = "Impossible d'ouvrir Podcasts dans le gestionnaire de fichiers",
        ["Downloads folder (File Manager)"] = "Dossier de téléchargements (Gestionnaire)",
        ["All downloads (%d)"] = "Tous les téléchargements (%d)",
        ["Not played (%d)"] = "Non lus (%d)",
        ["Played (%d)"] = "Lus (%d)",
        ["Delete played downloads"] = "Supprimer les téléchargements lus",
        ["Tap again within 8 seconds to delete played downloads"] = "Appuyez à nouveau sous 8 secondes pour supprimer les téléchargements lus",
        ["Deleted %d; kept %d"] = "%d supprimés ; %d conservés",
        ["Deleted %d; kept %d; progress could not be saved"] = "%d supprimés ; %d conservés ; impossible d'enregistrer la progression",
        ["Manage downloads"] = "Gérer les téléchargements",
        ["Manage subscriptions"] = "Gérer les abonnements",
        ["Export subscriptions"] = "Exporter les abonnements",
        ["Subscriptions exported"] = "Abonnements exportés",
        ["Could not export subscriptions. Try again."] = "Impossible d'exporter les abonnements. Réessayez.",
        ["Continue: %s"] = "Continuer : %s",
        ["Downloads (File Manager)"] = "Téléchargements (Gestionnaire)",
        ["1 new episode"] = "1 nouvel épisode",
        ["%d new"] = "%d nouveaux",
        ["Discover podcasts"] = "Découvrir des podcasts",
        ["Settings"] = "Paramètres",
        ["Resume did not complete. Retry Resume from the episode."] = "La reprise a échoué. Réessayez Reprendre depuis l'épisode.",
        ["Podcasts needs a newer player build"] = "Podcasts nécessite une version plus récente du lecteur",
    },
    it = {
        ["Podcasts"] = "Podcast",
        ["Podcasts · Reading Room"] = "Podcast · Sala d'ascolto",
        ["Podcast download"] = "Download podcast",
        ["%s applied for this session"] = "%s applicato per questa sessione",
        ["Playback speed requires a newer player"] = "La velocità di riproduzione richiede un lettore più recente",
        ["Playback speed"] = "Velocità di riproduzione",
        ["Playback speed is available for downloaded episodes"] = "La velocità di riproduzione è disponibile per gli episodi scaricati",
        ["Speed is unavailable for this audio format"] = "La velocità non è disponibile per questo formato audio",
        ["Could not save playback speed"] = "Impossibile salvare la velocità di riproduzione",
        ["Playback speed set to %sx"] = "Velocità di riproduzione impostata a %sx",
        ["Playback speed: %sx"] = "Velocità di riproduzione: %sx",
        ["Podcasts settings"] = "Impostazioni Podcast",
        ["No podcast episode selected"] = "Nessun episodio podcast selezionato",
        ["Choose an episode from Podcasts to see its details"] = "Scegli un episodio da Podcast per vederne i dettagli",
        ["Episode · %s"] = "Episodio · %s",
        ["Unknown episode"] = "Episodio sconosciuto",
        ["Host · %s"] = "Conduttore · %s",
        ["Unknown host"] = "Conduttore sconosciuto",
        ["Show · %s"] = "Programma · %s",
        ["Unknown show"] = "Programma sconosciuto",
        ["Podcast speed is available for downloaded episodes"] = "La velocità podcast è disponibile per gli episodi scaricati",
        ["Untitled episode"] = "Episodio senza titolo",
        ["Some download history could not be loaded"] = "Impossibile caricare parte della cronologia dei download",
        ["Played"] = "Ascoltato",
        ["Resume at %s"] = "Riprendi a %s",
        ["New"] = "Nuovo",
        ["Downloaded"] = "Scaricato",
        ["Downloading"] = "Download in corso",
        ["Refresh episodes"] = "Aggiorna episodi",
        ["Unsubscribe"] = "Annulla iscrizione",
        ["Could not load episodes. Try again."] = "Impossibile caricare gli episodi. Riprova.",
        ["Could not parse feed"] = "Impossibile analizzare il feed",
        ["The feed returned no episodes; kept the saved list"] = "Il feed non ha restituito episodi; mantenuto l'elenco salvato",
        ["%d new episodes"] = "%d nuovi episodi",
        ["No new episodes"] = "Nessun nuovo episodio",
        ["Loading..."] = "Caricamento...",
        ["Unsubscribe?"] = "Annullare l'iscrizione?",
        ["Unsubscribe %s"] = "Annulla iscrizione a %s",
        ["Cancel"] = "Annulla",
        ["Could not save subscriptions. Try again."] = "Impossibile salvare le iscrizioni. Riprova.",
        ["Unsubscribed; downloads kept"] = "Iscrizione annullata; download mantenuti",
        ["Episode details unavailable"] = "Dettagli episodio non disponibili",
        ["Resume"] = "Riprendi",
        ["Play download"] = "Riproduci download",
        ["Download"] = "Scarica",
        ["Cancel download"] = "Annulla download",
        ["Stream (no resume)"] = "Streaming (senza ripresa)",
        ["Could not stream episode. Try again."] = "Impossibile riprodurre l'episodio in streaming. Riprova.",
        ["Mark as played"] = "Segna come ascoltato",
        ["Mark as unplayed"] = "Segna come non ascoltato",
        ["Marked as played"] = "Segnato come ascoltato",
        ["Marked as unplayed"] = "Segnato come non ascoltato",
        ["Delete download"] = "Elimina download",
        ["Tap Delete download again within 8 seconds to confirm"] = "Tocca di nuovo Elimina download entro 8 secondi per confermare",
        ["Download is no longer available"] = "Il download non è più disponibile",
        ["Stop this episode before deleting its download"] = "Ferma questo episodio prima di eliminarne il download",
        ["Could not delete download. Try again."] = "Impossibile eliminare il download. Riprova.",
        ["Download deleted"] = "Download eliminato",
        ["Episode"] = "Episodio",
        ["Enter an http(s) feed URL"] = "Inserisci un URL feed http(s)",
        ["Subscription limit reached"] = "Limite di iscrizioni raggiunto",
        ["Already subscribed"] = "Già iscritto",
        ["Could not read OPML"] = "Impossibile leggere il file OPML",
        ["Could not import subscriptions. Try again."] = "Impossibile importare le iscrizioni. Riprova.",
        ["Imported %d podcasts"] = "%d podcast importati",
        ["No OPML files found in Podcasts"] = "Nessun file OPML trovato in Podcasts",
        ["Import OPML"] = "Importa OPML",
        ["No podcasts found"] = "Nessun podcast trovato",
        ["Podcast Search"] = "Ricerca podcast",
        ["Could not search podcasts. Try again."] = "Impossibile cercare podcast. Riprova.",
        ["Search podcasts"] = "Cerca podcast",
        ["Text input busy"] = "Inserimento testo occupato",
        ["Add feed URL"] = "Aggiungi URL feed",
        ["Could not download episode. Try again."] = "Impossibile scaricare l'episodio. Riprova.",
        ["Downloading episode…"] = "Download episodio…",
        ["Episode downloaded"] = "Episodio scaricato",
        ["Episode downloaded, but progress could not be saved"] = "Episodio scaricato, ma impossibile salvare i progressi",
        ["Resolving episode URL…"] = "Risoluzione URL episodio…",
        ["Preparing episode download…"] = "Preparazione download episodio…",
        ["Download limit reached. Delete some downloads first."] = "Limite download raggiunto. Elimina prima alcuni download.",
        ["Episode download queued"] = "Download episodio in coda",
        ["Download cancelled"] = "Download annullato",
        ["Unsubscribed"] = "Disiscritto",
        ["Downloads"] = "Download",
        ["Not played"] = "Non ascoltati",
        ["No unplayed downloads"] = "Nessun download non ascoltato",
        ["No played downloads"] = "Nessun download ascoltato",
        ["No downloads yet. Open an episode and choose Download."] = "Nessun download. Apri un episodio e scegli Scarica.",
        ["Undated"] = "Senza data",
        ["%s part %d"] = "%s parte %d",
        ["%s to %s"] = "da %s a %s",
        ["File Manager is not supported on this device"] = "Gestione file non è supportato su questo dispositivo",
        ["Could not open File Manager"] = "Impossibile aprire Gestione file",
        ["Could not open Podcasts in File Manager"] = "Impossibile aprire Podcasts in Gestione file",
        ["Downloads folder (File Manager)"] = "Cartella download (Gestione file)",
        ["All downloads (%d)"] = "Tutti i download (%d)",
        ["Not played (%d)"] = "Non ascoltati (%d)",
        ["Played (%d)"] = "Ascoltati (%d)",
        ["Delete played downloads"] = "Elimina download ascoltati",
        ["Tap again within 8 seconds to delete played downloads"] = "Tocca di nuovo entro 8 secondi per eliminare i download ascoltati",
        ["Deleted %d; kept %d"] = "Eliminati %d; mantenuti %d",
        ["Deleted %d; kept %d; progress could not be saved"] = "Eliminati %d; mantenuti %d; impossibile salvare i progressi",
        ["Manage downloads"] = "Gestisci download",
        ["Manage subscriptions"] = "Gestisci iscrizioni",
        ["Export subscriptions"] = "Esporta iscrizioni",
        ["Subscriptions exported"] = "Iscrizioni esportate",
        ["Could not export subscriptions. Try again."] = "Impossibile esportare le iscrizioni. Riprova.",
        ["Continue: %s"] = "Continua: %s",
        ["Downloads (File Manager)"] = "Download (Gestione file)",
        ["1 new episode"] = "1 nuovo episodio",
        ["%d new"] = "%d nuovi",
        ["Discover podcasts"] = "Scopri podcast",
        ["Settings"] = "Impostazioni",
        ["Resume did not complete. Retry Resume from the episode."] = "Ripresa non riuscita. Riprova Riprendi dall'episodio.",
        ["Podcasts needs a newer player build"] = "Podcast richiede una versione più recente del lettore",
    },
    ja = {
        ["Podcasts"] = "ポッドキャスト",
        ["Podcasts · Reading Room"] = "ポッドキャスト · リーディングルーム",
        ["Podcast download"] = "ポッドキャストのダウンロード",
        ["%s applied for this session"] = "このセッションに %s を適用しました",
        ["Playback speed requires a newer player"] = "再生速度の変更には新しいプレイヤーが必要です",
        ["Playback speed"] = "再生速度",
        ["Playback speed is available for downloaded episodes"] = "再生速度はダウンロード済みのエピソードで利用できます",
        ["Speed is unavailable for this audio format"] = "この音声形式では再生速度を変更できません",
        ["Could not save playback speed"] = "再生速度を保存できませんでした",
        ["Playback speed set to %sx"] = "再生速度を %sx に設定しました",
        ["Playback speed: %sx"] = "再生速度: %sx",
        ["Podcasts settings"] = "ポッドキャスト設定",
        ["No podcast episode selected"] = "ポッドキャストのエピソードが選択されていません",
        ["Choose an episode from Podcasts to see its details"] = "詳細を表示するにはポッドキャストからエピソードを選択してください",
        ["Episode · %s"] = "エピソード · %s",
        ["Unknown episode"] = "不明なエピソード",
        ["Host · %s"] = "ホスト · %s",
        ["Unknown host"] = "不明なホスト",
        ["Show · %s"] = "番組 · %s",
        ["Unknown show"] = "不明な番組",
        ["Podcast speed is available for downloaded episodes"] = "ポッドキャストの速度変更はダウンロード済みのエピソードで利用できます",
        ["Untitled episode"] = "無題のエピソード",
        ["Some download history could not be loaded"] = "一部のダウンロード履歴を読み込めませんでした",
        ["Played"] = "再生済み",
        ["Resume at %s"] = "%s から再開",
        ["New"] = "新着",
        ["Downloaded"] = "ダウンロード済み",
        ["Downloading"] = "ダウンロード中",
        ["Refresh episodes"] = "エピソードを更新",
        ["Unsubscribe"] = "登録解除",
        ["Could not load episodes. Try again."] = "エピソードを読み込めませんでした。再試行してください。",
        ["Could not parse feed"] = "フィードを解析できませんでした",
        ["The feed returned no episodes; kept the saved list"] = "フィードにエピソードがありません。保存済みのリストを維持しました",
        ["%d new episodes"] = "%d 件の新着エピソード",
        ["No new episodes"] = "新着エピソードはありません",
        ["Loading..."] = "読み込み中...",
        ["Unsubscribe?"] = "登録を解除しますか？",
        ["Unsubscribe %s"] = "%s の登録を解除",
        ["Cancel"] = "キャンセル",
        ["Could not save subscriptions. Try again."] = "登録リストを保存できませんでした。再試行してください。",
        ["Unsubscribed; downloads kept"] = "登録を解除しました（ダウンロードは保持されます）",
        ["Episode details unavailable"] = "エピソードの詳細はありません",
        ["Resume"] = "再開",
        ["Play download"] = "ダウンロードを再生",
        ["Download"] = "ダウンロード",
        ["Cancel download"] = "ダウンロードを中止",
        ["Stream (no resume)"] = "ストリーミング（再開なし）",
        ["Could not stream episode. Try again."] = "エピソードをストリーミングできませんでした。再試行してください。",
        ["Mark as played"] = "再生済みにする",
        ["Mark as unplayed"] = "未再生にする",
        ["Marked as played"] = "再生済みにしました",
        ["Marked as unplayed"] = "未再生にしました",
        ["Delete download"] = "ダウンロードを削除",
        ["Tap Delete download again within 8 seconds to confirm"] = "確認のため8秒以内にもう一度「ダウンロードを削除」をタップしてください",
        ["Download is no longer available"] = "ダウンロードは利用できなくなりました",
        ["Stop this episode before deleting its download"] = "ダウンロードを削除する前にこのエピソードの再生を停止してください",
        ["Could not delete download. Try again."] = "ダウンロードを削除できませんでした。再試行してください。",
        ["Download deleted"] = "ダウンロードを削除しました",
        ["Episode"] = "エピソード",
        ["Enter an http(s) feed URL"] = "http(s) のフィード URL を入力してください",
        ["Subscription limit reached"] = "登録数の上限に達しました",
        ["Already subscribed"] = "すでに登録済みです",
        ["Could not read OPML"] = "OPML を読み込めませんでした",
        ["Could not import subscriptions. Try again."] = "登録リストをインポートできませんでした。再試行してください。",
        ["Imported %d podcasts"] = "%d 件のポッドキャストをインポートしました",
        ["No OPML files found in Podcasts"] = "Podcasts フォルダに OPML ファイルが見つかりません",
        ["Import OPML"] = "OPML をインポート",
        ["No podcasts found"] = "ポッドキャストが見つかりません",
        ["Podcast Search"] = "ポッドキャスト検索",
        ["Could not search podcasts. Try again."] = "ポッドキャストを検索できませんでした。再試行してください。",
        ["Search podcasts"] = "ポッドキャストを検索",
        ["Text input busy"] = "テキスト入力が使用中です",
        ["Add feed URL"] = "フィード URL を追加",
        ["Could not download episode. Try again."] = "エピソードをダウンロードできませんでした。再試行してください。",
        ["Downloading episode…"] = "エピソードをダウンロード中…",
        ["Episode downloaded"] = "エピソードをダウンロードしました",
        ["Episode downloaded, but progress could not be saved"] = "エピソードをダウンロードしましたが、進行状況を保存できませんでした",
        ["Resolving episode URL…"] = "エピソードの URL を解決中…",
        ["Preparing episode download…"] = "エピソードのダウンロードを準備中…",
        ["Download limit reached. Delete some downloads first."] = "ダウンロード上限に達しました。先にいくつかのダウンロードを削除してください。",
        ["Episode download queued"] = "エピソードをダウンロード待ちに追加しました",
        ["Download cancelled"] = "ダウンロードをキャンセルしました",
        ["Unsubscribed"] = "登録解除済み",
        ["Downloads"] = "ダウンロード",
        ["Not played"] = "未再生",
        ["No unplayed downloads"] = "未再生のダウンロードはありません",
        ["No played downloads"] = "再生済みのダウンロードはありません",
        ["No downloads yet. Open an episode and choose Download."] = "ダウンロードはまだありません。エピソードを開いて「ダウンロード」を選択してください。",
        ["Undated"] = "日付なし",
        ["%s part %d"] = "%s パート %d",
        ["%s to %s"] = "%s 〜 %s",
        ["File Manager is not supported on this device"] = "このデバイスではファイルマネージャーはサポートされていません",
        ["Could not open File Manager"] = "ファイルマネージャーを開けませんでした",
        ["Could not open Podcasts in File Manager"] = "ファイルマネージャーで Podcasts を開けませんでした",
        ["Downloads folder (File Manager)"] = "ダウンロードフォルダ（ファイルマネージャー）",
        ["All downloads (%d)"] = "すべてのダウンロード (%d)",
        ["Not played (%d)"] = "未再生 (%d)",
        ["Played (%d)"] = "再生済み (%d)",
        ["Delete played downloads"] = "再生済みのダウンロードを削除",
        ["Tap again within 8 seconds to delete played downloads"] = "再生済みのダウンロードを削除するには8秒以内にもう一度タップしてください",
        ["Deleted %d; kept %d"] = "%d 件削除・%d 件保持",
        ["Deleted %d; kept %d; progress could not be saved"] = "%d 件削除・%d 件保持（進行状況を保存できませんでした）",
        ["Manage downloads"] = "ダウンロードを管理",
        ["Manage subscriptions"] = "登録番組を管理",
        ["Export subscriptions"] = "登録リストをエクスポート",
        ["Subscriptions exported"] = "登録リストをエクスポートしました",
        ["Could not export subscriptions. Try again."] = "登録リストをエクスポートできませんでした。再試行してください。",
        ["Continue: %s"] = "続きを再生: %s",
        ["Downloads (File Manager)"] = "ダウンロード（ファイルマネージャー）",
        ["1 new episode"] = "1 件の新着エピソード",
        ["%d new"] = "%d 件の新着",
        ["Discover podcasts"] = "ポッドキャストを探す",
        ["Settings"] = "設定",
        ["Resume did not complete. Retry Resume from the episode."] = "再開できませんでした。エピソードからもう一度「再開」をお試しください。",
        ["Podcasts needs a newer player build"] = "ポッドキャストには新しいプレイヤービルドが必要です",
    },
    nl = {
        ["Podcasts"] = "Podcasts",
        ["Podcasts · Reading Room"] = "Podcasts · Luisterkamer",
        ["Podcast download"] = "Podcast-download",
        ["%s applied for this session"] = "%s toegepast voor deze sessie",
        ["Playback speed requires a newer player"] = "Afspeelsnelheid vereist een nieuwere speler",
        ["Playback speed"] = "Afspeelsnelheid",
        ["Playback speed is available for downloaded episodes"] = "Afspeelsnelheid is beschikbaar voor gedownloade afleveringen",
        ["Speed is unavailable for this audio format"] = "Snelheid is niet beschikbaar voor dit audioformaat",
        ["Could not save playback speed"] = "Kan afspeelsnelheid niet opslaan",
        ["Playback speed set to %sx"] = "Afspeelsnelheid ingesteld op %sx",
        ["Playback speed: %sx"] = "Afspeelsnelheid: %sx",
        ["Podcasts settings"] = "Podcast-instellingen",
        ["No podcast episode selected"] = "Geen podcastaflevering geselecteerd",
        ["Choose an episode from Podcasts to see its details"] = "Kies een aflevering in Podcasts om de details te zien",
        ["Episode · %s"] = "Aflevering · %s",
        ["Unknown episode"] = "Onbekende aflevering",
        ["Host · %s"] = "Presentator · %s",
        ["Unknown host"] = "Onbekende presentator",
        ["Show · %s"] = "Programma · %s",
        ["Unknown show"] = "Onbekend programma",
        ["Podcast speed is available for downloaded episodes"] = "Podcastsnelheid is beschikbaar voor gedownloade afleveringen",
        ["Untitled episode"] = "Naamloze aflevering",
        ["Some download history could not be loaded"] = "Een deel van de downloadgeschiedenis kon niet worden geladen",
        ["Played"] = "Afgespeeld",
        ["Resume at %s"] = "Hervatten op %s",
        ["New"] = "Nieuw",
        ["Downloaded"] = "Gedownload",
        ["Downloading"] = "Downloaden",
        ["Refresh episodes"] = "Afleveringen vernieuwen",
        ["Unsubscribe"] = "Abonnement opzeggen",
        ["Could not load episodes. Try again."] = "Kan afleveringen niet laden. Probeer het opnieuw.",
        ["Could not parse feed"] = "Kan feed niet verwerken",
        ["The feed returned no episodes; kept the saved list"] = "De feed bevatte geen afleveringen; opgeslagen lijst behouden",
        ["%d new episodes"] = "%d nieuwe afleveringen",
        ["No new episodes"] = "Geen nieuwe afleveringen",
        ["Loading..."] = "Laden...",
        ["Unsubscribe?"] = "Abonnement opzeggen?",
        ["Unsubscribe %s"] = "Afmelden voor %s",
        ["Cancel"] = "Annuleren",
        ["Could not save subscriptions. Try again."] = "Kan abonnementen niet opslaan. Probeer het opnieuw.",
        ["Unsubscribed; downloads kept"] = "Afgemeld; downloads behouden",
        ["Episode details unavailable"] = "Afleveringsdetails niet beschikbaar",
        ["Resume"] = "Hervatten",
        ["Play download"] = "Download afspelen",
        ["Download"] = "Downloaden",
        ["Cancel download"] = "Download annuleren",
        ["Stream (no resume)"] = "Streamen (zonder hervatten)",
        ["Could not stream episode. Try again."] = "Kan aflevering niet streamen. Probeer het opnieuw.",
        ["Mark as played"] = "Markeren als afgespeeld",
        ["Mark as unplayed"] = "Markeren als niet afgespeeld",
        ["Marked as played"] = "Gemarkeerd als afgespeeld",
        ["Marked as unplayed"] = "Gemarkeerd als niet afgespeeld",
        ["Delete download"] = "Download verwijderen",
        ["Tap Delete download again within 8 seconds to confirm"] = "Tik binnen 8 seconden nogmaals op Download verwijderen om te bevestigen",
        ["Download is no longer available"] = "Download is niet meer beschikbaar",
        ["Stop this episode before deleting its download"] = "Stop deze aflevering voordat je de download verwijdert",
        ["Could not delete download. Try again."] = "Kan download niet verwijderen. Probeer het opnieuw.",
        ["Download deleted"] = "Download verwijderd",
        ["Episode"] = "Aflevering",
        ["Enter an http(s) feed URL"] = "Voer een http(s)-feed-URL in",
        ["Subscription limit reached"] = "Abonnementslimiet bereikt",
        ["Already subscribed"] = "Al geabonneerd",
        ["Could not read OPML"] = "Kan OPML niet lezen",
        ["Could not import subscriptions. Try again."] = "Kan abonnementen niet importeren. Probeer het opnieuw.",
        ["Imported %d podcasts"] = "%d podcasts geïmporteerd",
        ["No OPML files found in Podcasts"] = "Geen OPML-bestanden gevonden in Podcasts",
        ["Import OPML"] = "OPML importeren",
        ["No podcasts found"] = "Geen podcasts gevonden",
        ["Podcast Search"] = "Podcasts zoeken",
        ["Could not search podcasts. Try again."] = "Kan geen podcasts zoeken. Probeer het opnieuw.",
        ["Search podcasts"] = "Podcasts zoeken",
        ["Text input busy"] = "Tekstinvoer bezet",
        ["Add feed URL"] = "Feed-URL toevoegen",
        ["Could not download episode. Try again."] = "Kan aflevering niet downloaden. Probeer het opnieuw.",
        ["Downloading episode…"] = "Aflevering downloaden…",
        ["Episode downloaded"] = "Aflevering gedownload",
        ["Episode downloaded, but progress could not be saved"] = "Aflevering gedownload, maar voortgang kon niet worden opgeslagen",
        ["Resolving episode URL…"] = "Afleverings-URL ophalen…",
        ["Preparing episode download…"] = "Download van aflevering voorbereiden…",
        ["Download limit reached. Delete some downloads first."] = "Downloadlimiet bereikt. Verwijder eerst enkele downloads.",
        ["Episode download queued"] = "Aflevering in wachtrij voor download",
        ["Download cancelled"] = "Download geannuleerd",
        ["Unsubscribed"] = "Afgemeld",
        ["Downloads"] = "Downloads",
        ["Not played"] = "Niet afgespeeld",
        ["No unplayed downloads"] = "Geen onafgespeelde downloads",
        ["No played downloads"] = "Geen afgespeelde downloads",
        ["No downloads yet. Open an episode and choose Download."] = "Nog geen downloads. Open een aflevering en kies Downloaden.",
        ["Undated"] = "Zonder datum",
        ["%s part %d"] = "%s deel %d",
        ["%s to %s"] = "%s t/m %s",
        ["File Manager is not supported on this device"] = "Bestandsbeheer wordt niet ondersteund op dit apparaat",
        ["Could not open File Manager"] = "Kan Bestandsbeheer niet openen",
        ["Could not open Podcasts in File Manager"] = "Kan Podcasts niet openen in Bestandsbeheer",
        ["Downloads folder (File Manager)"] = "Downloadmap (Bestandsbeheer)",
        ["All downloads (%d)"] = "Alle downloads (%d)",
        ["Not played (%d)"] = "Niet afgespeeld (%d)",
        ["Played (%d)"] = "Afgespeeld (%d)",
        ["Delete played downloads"] = "Afgespeelde downloads verwijderen",
        ["Tap again within 8 seconds to delete played downloads"] = "Tik binnen 8 seconden nogmaals om afgespeelde downloads te verwijderen",
        ["Deleted %d; kept %d"] = "%d verwijderd; %d behouden",
        ["Deleted %d; kept %d; progress could not be saved"] = "%d verwijderd; %d behouden; voortgang kon niet worden opgeslagen",
        ["Manage downloads"] = "Downloads beheren",
        ["Manage subscriptions"] = "Abonnementen beheren",
        ["Export subscriptions"] = "Abonnementen exporteren",
        ["Subscriptions exported"] = "Abonnementen geëxporteerd",
        ["Could not export subscriptions. Try again."] = "Kan abonnementen niet exporteren. Probeer het opnieuw.",
        ["Continue: %s"] = "Verder luisteren: %s",
        ["Downloads (File Manager)"] = "Downloads (Bestandsbeheer)",
        ["1 new episode"] = "1 nieuwe aflevering",
        ["%d new"] = "%d nieuw",
        ["Discover podcasts"] = "Podcasts ontdekken",
        ["Settings"] = "Instellingen",
        ["Resume did not complete. Retry Resume from the episode."] = "Hervatten niet gelukt. Probeer Hervatten opnieuw vanuit de aflevering.",
        ["Podcasts needs a newer player build"] = "Podcasts vereist een nieuwere spelerversie",
    },
    pt = {
        ["Podcasts"] = "Podcasts",
        ["Podcasts · Reading Room"] = "Podcasts · Sala de leitura",
        ["Podcast download"] = "Download de podcast",
        ["%s applied for this session"] = "%s aplicado para esta sessão",
        ["Playback speed requires a newer player"] = "A velocidade de reprodução requer um reprodutor mais recente",
        ["Playback speed"] = "Velocidade de reprodução",
        ["Playback speed is available for downloaded episodes"] = "A velocidade de reprodução está disponível para episódios baixados",
        ["Speed is unavailable for this audio format"] = "A velocidade não está disponível para este formato de áudio",
        ["Could not save playback speed"] = "Não foi possível salvar a velocidade de reprodução",
        ["Playback speed set to %sx"] = "Velocidade de reprodução definida para %sx",
        ["Playback speed: %sx"] = "Velocidade de reprodução: %sx",
        ["Podcasts settings"] = "Configurações de Podcasts",
        ["No podcast episode selected"] = "Nenhum episódio de podcast selecionado",
        ["Choose an episode from Podcasts to see its details"] = "Escolha um episódio em Podcasts para ver seus detalhes",
        ["Episode · %s"] = "Episódio · %s",
        ["Unknown episode"] = "Episódio desconhecido",
        ["Host · %s"] = "Apresentador · %s",
        ["Unknown host"] = "Apresentador desconhecido",
        ["Show · %s"] = "Programa · %s",
        ["Unknown show"] = "Programa desconhecido",
        ["Podcast speed is available for downloaded episodes"] = "A velocidade do podcast está disponível para episódios baixados",
        ["Untitled episode"] = "Episódio sem título",
        ["Some download history could not be loaded"] = "Não foi possível carregar parte do histórico de downloads",
        ["Played"] = "Reproduzido",
        ["Resume at %s"] = "Retomar em %s",
        ["New"] = "Novo",
        ["Downloaded"] = "Baixado",
        ["Downloading"] = "Baixando",
        ["Refresh episodes"] = "Atualizar episódios",
        ["Unsubscribe"] = "Cancelar inscrição",
        ["Could not load episodes. Try again."] = "Não foi possível carregar os episódios. Tente novamente.",
        ["Could not parse feed"] = "Não foi possível analisar o feed",
        ["The feed returned no episodes; kept the saved list"] = "O feed não retornou episódios; lista salva mantida",
        ["%d new episodes"] = "%d novos episódios",
        ["No new episodes"] = "Nenhum episódio novo",
        ["Loading..."] = "Carregando...",
        ["Unsubscribe?"] = "Cancelar inscrição?",
        ["Unsubscribe %s"] = "Cancelar inscrição de %s",
        ["Cancel"] = "Cancelar",
        ["Could not save subscriptions. Try again."] = "Não foi possível salvar as inscrições. Tente novamente.",
        ["Unsubscribed; downloads kept"] = "Inscrição cancelada; downloads mantidos",
        ["Episode details unavailable"] = "Detalhes do episódio indisponíveis",
        ["Resume"] = "Retomar",
        ["Play download"] = "Reproduzir download",
        ["Download"] = "Baixar",
        ["Cancel download"] = "Cancelar download",
        ["Stream (no resume)"] = "Transmitir (sem retomar)",
        ["Could not stream episode. Try again."] = "Não foi possível transmitir o episódio. Tente novamente.",
        ["Mark as played"] = "Marcar como reproduzido",
        ["Mark as unplayed"] = "Marcar como não reproduzido",
        ["Marked as played"] = "Marcado como reproduzido",
        ["Marked as unplayed"] = "Marcado como não reproduzido",
        ["Delete download"] = "Excluir download",
        ["Tap Delete download again within 8 seconds to confirm"] = "Toque em Excluir download novamente em 8 segundos para confirmar",
        ["Download is no longer available"] = "O download não está mais disponível",
        ["Stop this episode before deleting its download"] = "Pare este episódio antes de excluir o download",
        ["Could not delete download. Try again."] = "Não foi possível excluir o download. Tente novamente.",
        ["Download deleted"] = "Download excluído",
        ["Episode"] = "Episódio",
        ["Enter an http(s) feed URL"] = "Digite uma URL de feed http(s)",
        ["Subscription limit reached"] = "Limite de inscrições atingido",
        ["Already subscribed"] = "Já inscrito",
        ["Could not read OPML"] = "Não foi possível ler o OPML",
        ["Could not import subscriptions. Try again."] = "Não foi possível importar as inscrições. Tente novamente.",
        ["Imported %d podcasts"] = "%d podcasts importados",
        ["No OPML files found in Podcasts"] = "Nenhum arquivo OPML encontrado em Podcasts",
        ["Import OPML"] = "Importar OPML",
        ["No podcasts found"] = "Nenhum podcast encontrado",
        ["Podcast Search"] = "Busca de podcasts",
        ["Could not search podcasts. Try again."] = "Não foi possível buscar podcasts. Tente novamente.",
        ["Search podcasts"] = "Buscar podcasts",
        ["Text input busy"] = "Entrada de texto ocupada",
        ["Add feed URL"] = "Adicionar URL do feed",
        ["Could not download episode. Try again."] = "Não foi possível baixar o episódio. Tente novamente.",
        ["Downloading episode…"] = "Baixando episódio…",
        ["Episode downloaded"] = "Episódio baixado",
        ["Episode downloaded, but progress could not be saved"] = "Episódio baixado, mas o progresso não pôde ser salvo",
        ["Resolving episode URL…"] = "Resolvendo URL do episódio…",
        ["Preparing episode download…"] = "Preparando download do episódio…",
        ["Download limit reached. Delete some downloads first."] = "Limite de downloads atingido. Exclua alguns downloads primeiro.",
        ["Episode download queued"] = "Download do episódio na fila",
        ["Download cancelled"] = "Download cancelado",
        ["Unsubscribed"] = "Inscrição cancelada",
        ["Downloads"] = "Downloads",
        ["Not played"] = "Não reproduzidos",
        ["No unplayed downloads"] = "Nenhum download não reproduzido",
        ["No played downloads"] = "Nenhum download reproduzido",
        ["No downloads yet. Open an episode and choose Download."] = "Nenhum download ainda. Abra um episódio e escolha Baixar.",
        ["Undated"] = "Sem data",
        ["%s part %d"] = "%s parte %d",
        ["%s to %s"] = "%s a %s",
        ["File Manager is not supported on this device"] = "O Gerenciador de arquivos não é suportado neste dispositivo",
        ["Could not open File Manager"] = "Não foi possível abrir o Gerenciador de arquivos",
        ["Could not open Podcasts in File Manager"] = "Não foi possível abrir Podcasts no Gerenciador de arquivos",
        ["Downloads folder (File Manager)"] = "Pasta de downloads (Gerenciador de arquivos)",
        ["All downloads (%d)"] = "Todos os downloads (%d)",
        ["Not played (%d)"] = "Não reproduzidos (%d)",
        ["Played (%d)"] = "Reproduzidos (%d)",
        ["Delete played downloads"] = "Excluir downloads reproduzidos",
        ["Tap again within 8 seconds to delete played downloads"] = "Toque novamente em 8 segundos para excluir os downloads reproduzidos",
        ["Deleted %d; kept %d"] = "%d excluídos; %d mantidos",
        ["Deleted %d; kept %d; progress could not be saved"] = "%d excluídos; %d mantidos; não foi possível salvar o progresso",
        ["Manage downloads"] = "Gerenciar downloads",
        ["Manage subscriptions"] = "Gerenciar inscrições",
        ["Export subscriptions"] = "Exportar inscrições",
        ["Subscriptions exported"] = "Inscrições exportadas",
        ["Could not export subscriptions. Try again."] = "Não foi possível exportar as inscrições. Tente novamente.",
        ["Continue: %s"] = "Continuar: %s",
        ["Downloads (File Manager)"] = "Downloads (Gerenciador de arquivos)",
        ["1 new episode"] = "1 novo episódio",
        ["%d new"] = "%d novos",
        ["Discover podcasts"] = "Descobrir podcasts",
        ["Settings"] = "Configurações",
        ["Resume did not complete. Retry Resume from the episode."] = "A retomada não foi concluída. Tente Retomar novamente a partir do episódio.",
        ["Podcasts needs a newer player build"] = "Podcasts requer uma versão mais recente do reprodutor",
    },
    ru = {
        ["Podcasts"] = "Подкасты",
        ["Podcasts · Reading Room"] = "Подкасты · Читальный зал",
        ["Podcast download"] = "Загрузка подкаста",
        ["%s applied for this session"] = "%s применён на этот сеанс",
        ["Playback speed requires a newer player"] = "Для изменения скорости требуется более новая версия плеера",
        ["Playback speed"] = "Скорость воспроизведения",
        ["Playback speed is available for downloaded episodes"] = "Скорость воспроизведения доступна для скачанных выпусков",
        ["Speed is unavailable for this audio format"] = "Изменение скорости недоступно для этого аудиоформата",
        ["Could not save playback speed"] = "Не удалось сохранить скорость воспроизведения",
        ["Playback speed set to %sx"] = "Скорость воспроизведения: %sx",
        ["Playback speed: %sx"] = "Скорость воспроизведения: %sx",
        ["Podcasts settings"] = "Настройки подкастов",
        ["No podcast episode selected"] = "Выпуск подкаста не выбран",
        ["Choose an episode from Podcasts to see its details"] = "Выберите выпуск в «Подкастах», чтобы увидеть подробности",
        ["Episode · %s"] = "Выпуск · %s",
        ["Unknown episode"] = "Неизвестный выпуск",
        ["Host · %s"] = "Ведущий · %s",
        ["Unknown host"] = "Неизвестный ведущий",
        ["Show · %s"] = "Шоу · %s",
        ["Unknown show"] = "Неизвестное шоу",
        ["Podcast speed is available for downloaded episodes"] = "Скорость подкаста доступна для скачанных выпусков",
        ["Untitled episode"] = "Выпуск без названия",
        ["Some download history could not be loaded"] = "Часть истории загрузок не удалось загрузить",
        ["Played"] = "Прослушано",
        ["Resume at %s"] = "Продолжить с %s",
        ["New"] = "Новое",
        ["Downloaded"] = "Скачано",
        ["Downloading"] = "Загрузка",
        ["Refresh episodes"] = "Обновить выпуски",
        ["Unsubscribe"] = "Отписаться",
        ["Could not load episodes. Try again."] = "Не удалось загрузить выпуски. Повторите попытку.",
        ["Could not parse feed"] = "Не удалось разобрать ленту",
        ["The feed returned no episodes; kept the saved list"] = "Лента не вернула выпусков; сохранён прежний список",
        ["%d new episodes"] = "Новых выпусков: %d",
        ["No new episodes"] = "Нет новых выпусков",
        ["Loading..."] = "Загрузка...",
        ["Unsubscribe?"] = "Отписаться?",
        ["Unsubscribe %s"] = "Отписаться от %s",
        ["Cancel"] = "Отмена",
        ["Could not save subscriptions. Try again."] = "Не удалось сохранить подписки. Повторите попытку.",
        ["Unsubscribed; downloads kept"] = "Подписка отменена; загрузки сохранены",
        ["Episode details unavailable"] = "Сведения о выпуске недоступны",
        ["Resume"] = "Продолжить",
        ["Play download"] = "Воспроизвести загрузку",
        ["Download"] = "Скачать",
        ["Cancel download"] = "Отменить загрузку",
        ["Stream (no resume)"] = "Поток (без продолжения)",
        ["Could not stream episode. Try again."] = "Не удалось воспроизвести поток. Повторите попытку.",
        ["Mark as played"] = "Отметить прослушанным",
        ["Mark as unplayed"] = "Отметить непрослушанным",
        ["Marked as played"] = "Отмечено прослушанным",
        ["Marked as unplayed"] = "Отмечено непрослушанным",
        ["Delete download"] = "Удалить загрузку",
        ["Tap Delete download again within 8 seconds to confirm"] = "Нажмите «Удалить загрузку» ещё раз в течение 8 секунд для подтверждения",
        ["Download is no longer available"] = "Загрузка больше недоступна",
        ["Stop this episode before deleting its download"] = "Остановите этот выпуск перед удалением загрузки",
        ["Could not delete download. Try again."] = "Не удалось удалить загрузку. Повторите попытку.",
        ["Download deleted"] = "Загрузка удалена",
        ["Episode"] = "Выпуск",
        ["Enter an http(s) feed URL"] = "Введите http(s) URL ленты",
        ["Subscription limit reached"] = "Достигнут лимит подписок",
        ["Already subscribed"] = "Уже в подписках",
        ["Could not read OPML"] = "Не удалось прочитать OPML",
        ["Could not import subscriptions. Try again."] = "Не удалось импортировать подписки. Повторите попытку.",
        ["Imported %d podcasts"] = "Импортировано подкастов: %d",
        ["No OPML files found in Podcasts"] = "Файлы OPML в папке Podcasts не найдены",
        ["Import OPML"] = "Импорт OPML",
        ["No podcasts found"] = "Подкасты не найдены",
        ["Podcast Search"] = "Поиск подкастов",
        ["Could not search podcasts. Try again."] = "Не удалось выполнить поиск подкастов. Повторите попытку.",
        ["Search podcasts"] = "Искать подкасты",
        ["Text input busy"] = "Ввод текста занят",
        ["Add feed URL"] = "Добавить URL ленты",
        ["Could not download episode. Try again."] = "Не удалось скачать выпуск. Повторите попытку.",
        ["Downloading episode…"] = "Загрузка выпуска…",
        ["Episode downloaded"] = "Выпуск скачан",
        ["Episode downloaded, but progress could not be saved"] = "Выпуск скачан, но не удалось сохранить прогресс",
        ["Resolving episode URL…"] = "Получение URL выпуска…",
        ["Preparing episode download…"] = "Подготовка загрузки выпуска…",
        ["Download limit reached. Delete some downloads first."] = "Достигнут лимит загрузок. Сначала удалите часть загрузок.",
        ["Episode download queued"] = "Загрузка выпуска в очереди",
        ["Download cancelled"] = "Загрузка отменена",
        ["Unsubscribed"] = "Без подписки",
        ["Downloads"] = "Загрузки",
        ["Not played"] = "Не прослушано",
        ["No unplayed downloads"] = "Нет непрослушанных загрузок",
        ["No played downloads"] = "Нет прослушанных загрузок",
        ["No downloads yet. Open an episode and choose Download."] = "Загрузок пока нет. Откройте выпуск и выберите «Скачать».",
        ["Undated"] = "Без даты",
        ["%s part %d"] = "%s, часть %d",
        ["%s to %s"] = "%s — %s",
        ["File Manager is not supported on this device"] = "Файловый менеджер не поддерживается на этом устройстве",
        ["Could not open File Manager"] = "Не удалось открыть файловый менеджер",
        ["Could not open Podcasts in File Manager"] = "Не удалось открыть Podcasts в файловом менеджере",
        ["Downloads folder (File Manager)"] = "Папка загрузок (Файловый менеджер)",
        ["All downloads (%d)"] = "Все загрузки (%d)",
        ["Not played (%d)"] = "Не прослушано (%d)",
        ["Played (%d)"] = "Прослушано (%d)",
        ["Delete played downloads"] = "Удалить прослушанные загрузки",
        ["Tap again within 8 seconds to delete played downloads"] = "Нажмите ещё раз в течение 8 секунд, чтобы удалить прослушанные загрузки",
        ["Deleted %d; kept %d"] = "Удалено: %d; оставлено: %d",
        ["Deleted %d; kept %d; progress could not be saved"] = "Удалено: %d; оставлено: %d; не удалось сохранить прогресс",
        ["Manage downloads"] = "Управление загрузками",
        ["Manage subscriptions"] = "Управление подписками",
        ["Export subscriptions"] = "Экспорт подписок",
        ["Subscriptions exported"] = "Подписки экспортированы",
        ["Could not export subscriptions. Try again."] = "Не удалось экспортировать подписки. Повторите попытку.",
        ["Continue: %s"] = "Продолжить: %s",
        ["Downloads (File Manager)"] = "Загрузки (Файловый менеджер)",
        ["1 new episode"] = "1 новый выпуск",
        ["%d new"] = "%d нов.",
        ["Discover podcasts"] = "Найти подкасты",
        ["Settings"] = "Настройки",
        ["Resume did not complete. Retry Resume from the episode."] = "Не удалось продолжить. Повторите «Продолжить» из меню выпуска.",
        ["Podcasts needs a newer player build"] = "Для подкастов требуется более новая сборка плеера",
    },
    uk = {
        ["Podcasts"] = "Подкасти",
        ["Podcasts · Reading Room"] = "Подкасти · Читальна зала",
        ["Podcast download"] = "Завантаження подкасту",
        ["%s applied for this session"] = "%s застосовано на цей сеанс",
        ["Playback speed requires a newer player"] = "Для зміни швидкості потрібен новіший плеєр",
        ["Playback speed"] = "Швидкість відтворення",
        ["Playback speed is available for downloaded episodes"] = "Швидкість відтворення доступна для завантажених випусків",
        ["Speed is unavailable for this audio format"] = "Зміна швидкості недоступна для цього аудіоформату",
        ["Could not save playback speed"] = "Не вдалося зберегти швидкість відтворення",
        ["Playback speed set to %sx"] = "Швидкість відтворення: %sx",
        ["Playback speed: %sx"] = "Швидкість відтворення: %sx",
        ["Podcasts settings"] = "Налаштування подкастів",
        ["No podcast episode selected"] = "Випуск подкасту не вибрано",
        ["Choose an episode from Podcasts to see its details"] = "Виберіть випуск у «Подкастах», щоб переглянути подробиці",
        ["Episode · %s"] = "Випуск · %s",
        ["Unknown episode"] = "Невідомий випуск",
        ["Host · %s"] = "Ведучий · %s",
        ["Unknown host"] = "Невідомий ведучий",
        ["Show · %s"] = "Шоу · %s",
        ["Unknown show"] = "Невідоме шоу",
        ["Podcast speed is available for downloaded episodes"] = "Швидкість подкасту доступна для завантажених випусків",
        ["Untitled episode"] = "Випуск без назви",
        ["Some download history could not be loaded"] = "Частину історії завантажень не вдалося завантажити",
        ["Played"] = "Прослухано",
        ["Resume at %s"] = "Продовжити з %s",
        ["New"] = "Нове",
        ["Downloaded"] = "Завантажено",
        ["Downloading"] = "Завантаження",
        ["Refresh episodes"] = "Оновити випуски",
        ["Unsubscribe"] = "Відписатися",
        ["Could not load episodes. Try again."] = "Не вдалося завантажити випуски. Спробуйте ще раз.",
        ["Could not parse feed"] = "Не вдалося розібрати стрічку",
        ["The feed returned no episodes; kept the saved list"] = "Стрічка не повернула випусків; збережено попередній список",
        ["%d new episodes"] = "Нових випусків: %d",
        ["No new episodes"] = "Немає нових випусків",
        ["Loading..."] = "Завантаження...",
        ["Unsubscribe?"] = "Відписатися?",
        ["Unsubscribe %s"] = "Відписатися від %s",
        ["Cancel"] = "Скасувати",
        ["Could not save subscriptions. Try again."] = "Не вдалося зберегти підписки. Спробуйте ще раз.",
        ["Unsubscribed; downloads kept"] = "Підписку скасовано; завантаження збережено",
        ["Episode details unavailable"] = "Відомості про випуск недоступні",
        ["Resume"] = "Продовжити",
        ["Play download"] = "Відтворити завантаження",
        ["Download"] = "Завантажити",
        ["Cancel download"] = "Скасувати завантаження",
        ["Stream (no resume)"] = "Потік (без продовження)",
        ["Could not stream episode. Try again."] = "Не вдалося відтворити потік. Спробуйте ще раз.",
        ["Mark as played"] = "Позначити прослуханим",
        ["Mark as unplayed"] = "Позначити непрослуханим",
        ["Marked as played"] = "Позначено прослуханим",
        ["Marked as unplayed"] = "Позначено непрослуханим",
        ["Delete download"] = "Видалити завантаження",
        ["Tap Delete download again within 8 seconds to confirm"] = "Натисніть «Видалити завантаження» ще раз протягом 8 секунд для підтвердження",
        ["Download is no longer available"] = "Завантаження більше недоступне",
        ["Stop this episode before deleting its download"] = "Зупиніть цей випуск перед видаленням завантаження",
        ["Could not delete download. Try again."] = "Не вдалося видалити завантаження. Спробуйте ще раз.",
        ["Download deleted"] = "Завантаження видалено",
        ["Episode"] = "Випуск",
        ["Enter an http(s) feed URL"] = "Введіть http(s) URL стрічки",
        ["Subscription limit reached"] = "Досягнуто ліміту підписок",
        ["Already subscribed"] = "Уже в підписках",
        ["Could not read OPML"] = "Не вдалося прочитати OPML",
        ["Could not import subscriptions. Try again."] = "Не вдалося імпортувати підписки. Спробуйте ще раз.",
        ["Imported %d podcasts"] = "Імпортовано подкастів: %d",
        ["No OPML files found in Podcasts"] = "Файли OPML у теці Podcasts не знайдено",
        ["Import OPML"] = "Імпорт OPML",
        ["No podcasts found"] = "Подкасти не знайдено",
        ["Podcast Search"] = "Пошук подкастів",
        ["Could not search podcasts. Try again."] = "Не вдалося виконати пошук подкастів. Спробуйте ще раз.",
        ["Search podcasts"] = "Шукати подкасти",
        ["Text input busy"] = "Введення тексту зайняте",
        ["Add feed URL"] = "Додати URL стрічки",
        ["Could not download episode. Try again."] = "Не вдалося завантажити випуск. Спробуйте ще раз.",
        ["Downloading episode…"] = "Завантаження випуску…",
        ["Episode downloaded"] = "Випуск завантажено",
        ["Episode downloaded, but progress could not be saved"] = "Випуск завантажено, але прогрес не вдалося зберегти",
        ["Resolving episode URL…"] = "Отримання URL випуску…",
        ["Preparing episode download…"] = "Підготовка завантаження випуску…",
        ["Download limit reached. Delete some downloads first."] = "Досягнуто ліміту завантажень. Спочатку видаліть частину завантажень.",
        ["Episode download queued"] = "Завантаження випуску в черзі",
        ["Download cancelled"] = "Завантаження скасовано",
        ["Unsubscribed"] = "Без підписки",
        ["Downloads"] = "Завантаження",
        ["Not played"] = "Не прослухано",
        ["No unplayed downloads"] = "Немає непрослуханих завантажень",
        ["No played downloads"] = "Немає прослуханих завантажень",
        ["No downloads yet. Open an episode and choose Download."] = "Завантажень ще немає. Відкрийте випуск і виберіть «Завантажити».",
        ["Undated"] = "Без дати",
        ["%s part %d"] = "%s, частина %d",
        ["%s to %s"] = "%s — %s",
        ["File Manager is not supported on this device"] = "Файловий менеджер не підтримується на цьому пристрої",
        ["Could not open File Manager"] = "Не вдалося відкрити файловий менеджер",
        ["Could not open Podcasts in File Manager"] = "Не вдалося відкрити Podcasts у файловому менеджері",
        ["Downloads folder (File Manager)"] = "Тека завантажень (Файловий менеджер)",
        ["All downloads (%d)"] = "Усі завантаження (%d)",
        ["Not played (%d)"] = "Не прослухано (%d)",
        ["Played (%d)"] = "Прослухано (%d)",
        ["Delete played downloads"] = "Видалити прослухані завантаження",
        ["Tap again within 8 seconds to delete played downloads"] = "Натисніть ще раз протягом 8 секунд, щоб видалити прослухані завантаження",
        ["Deleted %d; kept %d"] = "Видалено: %d; залишено: %d",
        ["Deleted %d; kept %d; progress could not be saved"] = "Видалено: %d; залишено: %d; не вдалося зберегти прогрес",
        ["Manage downloads"] = "Керування завантаженнями",
        ["Manage subscriptions"] = "Керування підписками",
        ["Export subscriptions"] = "Експорт підписок",
        ["Subscriptions exported"] = "Підписки експортовано",
        ["Could not export subscriptions. Try again."] = "Не вдалося експортувати підписки. Спробуйте ще раз.",
        ["Continue: %s"] = "Продовжити: %s",
        ["Downloads (File Manager)"] = "Завантаження (Файловий менеджер)",
        ["1 new episode"] = "1 новий випуск",
        ["%d new"] = "%d нов.",
        ["Discover podcasts"] = "Знайти подкасти",
        ["Settings"] = "Налаштування",
        ["Resume did not complete. Retry Resume from the episode."] = "Не вдалося продовжити. Повторіть «Продовжити» з меню випуску.",
        ["Podcasts needs a newer player build"] = "Для подкастів потрібна новіша збірка плеєра",
    },
    vi = {
        ["Podcasts"] = "Podcast",
        ["Podcasts · Reading Room"] = "Podcast · Phòng nghe",
        ["Podcast download"] = "Tải podcast",
        ["%s applied for this session"] = "Đã áp dụng %s cho phiên này",
        ["Playback speed requires a newer player"] = "Tốc độ phát cần trình phát mới hơn",
        ["Playback speed"] = "Tốc độ phát",
        ["Playback speed is available for downloaded episodes"] = "Tốc độ phát khả dụng cho các tập đã tải xuống",
        ["Speed is unavailable for this audio format"] = "Tốc độ không khả dụng cho định dạng âm thanh này",
        ["Could not save playback speed"] = "Không thể lưu tốc độ phát",
        ["Playback speed set to %sx"] = "Đã đặt tốc độ phát thành %sx",
        ["Playback speed: %sx"] = "Tốc độ phát: %sx",
        ["Podcasts settings"] = "Cài đặt Podcast",
        ["No podcast episode selected"] = "Chưa chọn tập podcast nào",
        ["Choose an episode from Podcasts to see its details"] = "Chọn một tập từ Podcast để xem chi tiết",
        ["Episode · %s"] = "Tập · %s",
        ["Unknown episode"] = "Tập không xác định",
        ["Host · %s"] = "Người dẫn · %s",
        ["Unknown host"] = "Người dẫn không xác định",
        ["Show · %s"] = "Chương trình · %s",
        ["Unknown show"] = "Chương trình không xác định",
        ["Podcast speed is available for downloaded episodes"] = "Tốc độ podcast khả dụng cho các tập đã tải xuống",
        ["Untitled episode"] = "Tập không tiêu đề",
        ["Some download history could not be loaded"] = "Không thể tải một phần lịch sử tải xuống",
        ["Played"] = "Đã nghe",
        ["Resume at %s"] = "Tiếp tục tại %s",
        ["New"] = "Mới",
        ["Downloaded"] = "Đã tải",
        ["Downloading"] = "Đang tải",
        ["Refresh episodes"] = "Làm mới tập",
        ["Unsubscribe"] = "Hủy đăng ký",
        ["Could not load episodes. Try again."] = "Không thể tải danh sách tập. Hãy thử lại.",
        ["Could not parse feed"] = "Không thể phân tích nguồn cấp",
        ["The feed returned no episodes; kept the saved list"] = "Nguồn cấp không có tập nào; đã giữ danh sách lưu",
        ["%d new episodes"] = "%d tập mới",
        ["No new episodes"] = "Không có tập mới",
        ["Loading..."] = "Đang tải...",
        ["Unsubscribe?"] = "Hủy đăng ký?",
        ["Unsubscribe %s"] = "Hủy đăng ký %s",
        ["Cancel"] = "Hủy",
        ["Could not save subscriptions. Try again."] = "Không thể lưu đăng ký. Hãy thử lại.",
        ["Unsubscribed; downloads kept"] = "Đã hủy đăng ký; giữ lại các bản tải",
        ["Episode details unavailable"] = "Không có chi tiết tập",
        ["Resume"] = "Tiếp tục",
        ["Play download"] = "Phát bản tải",
        ["Download"] = "Tải xuống",
        ["Cancel download"] = "Hủy tải xuống",
        ["Stream (no resume)"] = "Phát trực tuyến (không lưu vị trí)",
        ["Could not stream episode. Try again."] = "Không thể phát trực tuyến tập này. Hãy thử lại.",
        ["Mark as played"] = "Đánh dấu đã nghe",
        ["Mark as unplayed"] = "Đánh dấu chưa nghe",
        ["Marked as played"] = "Đã đánh dấu đã nghe",
        ["Marked as unplayed"] = "Đã đánh dấu chưa nghe",
        ["Delete download"] = "Xóa bản tải",
        ["Tap Delete download again within 8 seconds to confirm"] = "Chạm Xóa bản tải lần nữa trong 8 giây để xác nhận",
        ["Download is no longer available"] = "Bản tải không còn khả dụng",
        ["Stop this episode before deleting its download"] = "Hãy dừng tập này trước khi xóa bản tải",
        ["Could not delete download. Try again."] = "Không thể xóa bản tải. Hãy thử lại.",
        ["Download deleted"] = "Đã xóa bản tải",
        ["Episode"] = "Tập",
        ["Enter an http(s) feed URL"] = "Nhập URL nguồn cấp http(s)",
        ["Subscription limit reached"] = "Đã đạt giới hạn đăng ký",
        ["Already subscribed"] = "Đã đăng ký rồi",
        ["Could not read OPML"] = "Không đọc được OPML",
        ["Could not import subscriptions. Try again."] = "Không thể nhập đăng ký. Hãy thử lại.",
        ["Imported %d podcasts"] = "Đã nhập %d podcast",
        ["No OPML files found in Podcasts"] = "Không tìm thấy tệp OPML trong Podcasts",
        ["Import OPML"] = "Nhập OPML",
        ["No podcasts found"] = "Không tìm thấy podcast nào",
        ["Podcast Search"] = "Tìm kiếm podcast",
        ["Could not search podcasts. Try again."] = "Không thể tìm podcast. Hãy thử lại.",
        ["Search podcasts"] = "Tìm podcast",
        ["Text input busy"] = "Ô nhập văn bản đang bận",
        ["Add feed URL"] = "Thêm URL nguồn cấp",
        ["Could not download episode. Try again."] = "Không thể tải tập này. Hãy thử lại.",
        ["Downloading episode…"] = "Đang tải tập…",
        ["Episode downloaded"] = "Đã tải xong tập",
        ["Episode downloaded, but progress could not be saved"] = "Đã tải tập nhưng không thể lưu tiến trình",
        ["Resolving episode URL…"] = "Đang phân giải URL tập…",
        ["Preparing episode download…"] = "Đang chuẩn bị tải tập…",
        ["Download limit reached. Delete some downloads first."] = "Đã đạt giới hạn tải xuống. Hãy xóa bớt bản tải trước.",
        ["Episode download queued"] = "Đã xếp hàng tải tập",
        ["Download cancelled"] = "Đã hủy tải xuống",
        ["Unsubscribed"] = "Đã hủy đăng ký",
        ["Downloads"] = "Bản tải xuống",
        ["Not played"] = "Chưa nghe",
        ["No unplayed downloads"] = "Không có bản tải chưa nghe",
        ["No played downloads"] = "Không có bản tải đã nghe",
        ["No downloads yet. Open an episode and choose Download."] = "Chưa có bản tải nào. Mở một tập và chọn Tải xuống.",
        ["Undated"] = "Không rõ ngày",
        ["%s part %d"] = "%s phần %d",
        ["%s to %s"] = "%s đến %s",
        ["File Manager is not supported on this device"] = "Trình quản lý tệp không được hỗ trợ trên thiết bị này",
        ["Could not open File Manager"] = "Không thể mở Trình quản lý tệp",
        ["Could not open Podcasts in File Manager"] = "Không thể mở Podcasts trong Trình quản lý tệp",
        ["Downloads folder (File Manager)"] = "Thư mục tải xuống (Trình quản lý tệp)",
        ["All downloads (%d)"] = "Tất cả bản tải (%d)",
        ["Not played (%d)"] = "Chưa nghe (%d)",
        ["Played (%d)"] = "Đã nghe (%d)",
        ["Delete played downloads"] = "Xóa các bản tải đã nghe",
        ["Tap again within 8 seconds to delete played downloads"] = "Chạm lần nữa trong 8 giây để xóa các bản tải đã nghe",
        ["Deleted %d; kept %d"] = "Đã xóa %d; giữ lại %d",
        ["Deleted %d; kept %d; progress could not be saved"] = "Đã xóa %d; giữ lại %d; không thể lưu tiến trình",
        ["Manage downloads"] = "Quản lý bản tải",
        ["Manage subscriptions"] = "Quản lý đăng ký",
        ["Export subscriptions"] = "Xuất đăng ký",
        ["Subscriptions exported"] = "Đã xuất đăng ký",
        ["Could not export subscriptions. Try again."] = "Không thể xuất đăng ký. Hãy thử lại.",
        ["Continue: %s"] = "Tiếp tục: %s",
        ["Downloads (File Manager)"] = "Bản tải (Trình quản lý tệp)",
        ["1 new episode"] = "1 tập mới",
        ["%d new"] = "%d mới",
        ["Discover podcasts"] = "Khám phá podcast",
        ["Settings"] = "Cài đặt",
        ["Resume did not complete. Retry Resume from the episode."] = "Chưa thể tiếp tục. Hãy thử Tiếp tục lại từ tập đó.",
        ["Podcasts needs a newer player build"] = "Podcast cần bản dựng trình phát mới hơn",
    },
    zh_CN = {
        ["Podcasts"] = "播客",
        ["Podcasts · Reading Room"] = "播客 · 阅览室",
        ["Podcast download"] = "播客下载",
        ["%s applied for this session"] = "本次会话已应用 %s",
        ["Playback speed requires a newer player"] = "播放速度需要更新的播放器版本",
        ["Playback speed"] = "播放速度",
        ["Playback speed is available for downloaded episodes"] = "已下载的单集可使用播放速度调节",
        ["Speed is unavailable for this audio format"] = "此音频格式不支持速度调节",
        ["Could not save playback speed"] = "无法保存播放速度",
        ["Playback speed set to %sx"] = "播放速度已设为 %sx",
        ["Playback speed: %sx"] = "播放速度：%sx",
        ["Podcasts settings"] = "播客设置",
        ["No podcast episode selected"] = "未选择播客单集",
        ["Choose an episode from Podcasts to see its details"] = "从播客中选择一个单集以查看详情",
        ["Episode · %s"] = "单集 · %s",
        ["Unknown episode"] = "未知单集",
        ["Host · %s"] = "主播 · %s",
        ["Unknown host"] = "未知主播",
        ["Show · %s"] = "节目 · %s",
        ["Unknown show"] = "未知节目",
        ["Podcast speed is available for downloaded episodes"] = "已下载的单集可使用播客速度调节",
        ["Untitled episode"] = "无标题单集",
        ["Some download history could not be loaded"] = "部分下载记录无法加载",
        ["Played"] = "已播",
        ["Resume at %s"] = "从 %s 继续",
        ["New"] = "新",
        ["Downloaded"] = "已下载",
        ["Downloading"] = "下载中",
        ["Refresh episodes"] = "刷新单集",
        ["Unsubscribe"] = "取消订阅",
        ["Could not load episodes. Try again."] = "无法加载单集。请重试。",
        ["Could not parse feed"] = "无法解析订阅源",
        ["The feed returned no episodes; kept the saved list"] = "订阅源未返回单集；已保留保存的列表",
        ["%d new episodes"] = "%d 个新单集",
        ["No new episodes"] = "没有新单集",
        ["Loading..."] = "加载中...",
        ["Unsubscribe?"] = "取消订阅？",
        ["Unsubscribe %s"] = "取消订阅 %s",
        ["Cancel"] = "取消",
        ["Could not save subscriptions. Try again."] = "无法保存订阅。请重试。",
        ["Unsubscribed; downloads kept"] = "已取消订阅；保留已下载文件",
        ["Episode details unavailable"] = "单集详情不可用",
        ["Resume"] = "继续播放",
        ["Play download"] = "播放下载项",
        ["Download"] = "下载",
        ["Cancel download"] = "取消下载",
        ["Stream (no resume)"] = "在线播放（不记进度）",
        ["Could not stream episode. Try again."] = "无法在线播放单集。请重试。",
        ["Mark as played"] = "标为已播",
        ["Mark as unplayed"] = "标为未播",
        ["Marked as played"] = "已标为已播",
        ["Marked as unplayed"] = "已标为未播",
        ["Delete download"] = "删除下载",
        ["Tap Delete download again within 8 seconds to confirm"] = "请在 8 秒内再次轻触“删除下载”以确认",
        ["Download is no longer available"] = "下载项已不可用",
        ["Stop this episode before deleting its download"] = "删除下载前请先停止播放此单集",
        ["Could not delete download. Try again."] = "无法删除下载。请重试。",
        ["Download deleted"] = "下载已删除",
        ["Episode"] = "单集",
        ["Enter an http(s) feed URL"] = "请输入 http(s) 订阅源 URL",
        ["Subscription limit reached"] = "已达订阅上限",
        ["Already subscribed"] = "已订阅",
        ["Could not read OPML"] = "无法读取 OPML",
        ["Could not import subscriptions. Try again."] = "无法导入订阅。请重试。",
        ["Imported %d podcasts"] = "已导入 %d 个播客",
        ["No OPML files found in Podcasts"] = "在 Podcasts 中未找到 OPML 文件",
        ["Import OPML"] = "导入 OPML",
        ["No podcasts found"] = "未找到播客",
        ["Podcast Search"] = "播客搜索",
        ["Could not search podcasts. Try again."] = "无法搜索播客。请重试。",
        ["Search podcasts"] = "搜索播客",
        ["Text input busy"] = "文本输入正忙",
        ["Add feed URL"] = "添加订阅源 URL",
        ["Could not download episode. Try again."] = "无法下载单集。请重试。",
        ["Downloading episode…"] = "正在下载单集…",
        ["Episode downloaded"] = "单集已下载",
        ["Episode downloaded, but progress could not be saved"] = "单集已下载，但无法保存进度",
        ["Resolving episode URL…"] = "正在解析单集 URL…",
        ["Preparing episode download…"] = "正在准备下载单集…",
        ["Download limit reached. Delete some downloads first."] = "已达下载上限。请先删除部分下载。",
        ["Episode download queued"] = "单集下载已加入队列",
        ["Download cancelled"] = "下载已取消",
        ["Unsubscribed"] = "已取消订阅",
        ["Downloads"] = "下载",
        ["Not played"] = "未播",
        ["No unplayed downloads"] = "没有未播的下载项",
        ["No played downloads"] = "没有已播的下载项",
        ["No downloads yet. Open an episode and choose Download."] = "暂无下载。打开单集并选择“下载”。",
        ["Undated"] = "无日期",
        ["%s part %d"] = "%s 第 %d 部分",
        ["%s to %s"] = "%s 至 %s",
        ["File Manager is not supported on this device"] = "此设备不支持文件管理器",
        ["Could not open File Manager"] = "无法打开文件管理器",
        ["Could not open Podcasts in File Manager"] = "无法在文件管理器中打开 Podcasts",
        ["Downloads folder (File Manager)"] = "下载文件夹（文件管理器）",
        ["All downloads (%d)"] = "全部下载 (%d)",
        ["Not played (%d)"] = "未播 (%d)",
        ["Played (%d)"] = "已播 (%d)",
        ["Delete played downloads"] = "删除已播下载",
        ["Tap again within 8 seconds to delete played downloads"] = "请在 8 秒内再次轻触以删除已播下载",
        ["Deleted %d; kept %d"] = "已删除 %d 个；保留 %d 个",
        ["Deleted %d; kept %d; progress could not be saved"] = "已删除 %d 个；保留 %d 个；无法保存进度",
        ["Manage downloads"] = "管理下载",
        ["Manage subscriptions"] = "管理订阅",
        ["Export subscriptions"] = "导出订阅",
        ["Subscriptions exported"] = "订阅已导出",
        ["Could not export subscriptions. Try again."] = "无法导出订阅。请重试。",
        ["Continue: %s"] = "继续：%s",
        ["Downloads (File Manager)"] = "下载（文件管理器）",
        ["1 new episode"] = "1 个新单集",
        ["%d new"] = "%d 个新单集",
        ["Discover podcasts"] = "发现播客",
        ["Settings"] = "设置",
        ["Resume did not complete. Retry Resume from the episode."] = "未能继续播放。请从单集中重试“继续播放”。",
        ["Podcasts needs a newer player build"] = "播客需要更新的播放器版本",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

-- Download-first podcast library stored under <SD>/Podcasts. Put OPML files
-- beside subscriptions.opml to import them from the Podcasts home screen.
-- subscriptions.opml is the export/source list, .catalog caches feeds,
-- .progress.tsv stores resume state, and show folders hold downloaded audio.
-- HTTP playback is limited to MP3 and has no seek or resume; local downloads
-- support the player's formats, resume, and optional playback speed. Speed
-- applies only inside this plugin's download directory. The catalog keeps
-- 40 newest episodes per show. Chapters are not provided.

local ROOT = plugin.sd_root() .. "/Podcasts"
local READING_ROOM = {
    id = "example.podcasts.reading_room",
    name = tr("Podcasts · Reading Room"),
    xml = "Podcasts/player_layouts/reading_room.xml",
}
local ICON_ROOT = plugin.sd_root() .. "/.plugin-assets/Podcasts"
local ICON = {
    show = ICON_ROOT .. "/show.png",
    download = ICON_ROOT .. "/download.png",
    search = ICON_ROOT .. "/search.png",
    manage = ICON_ROOT .. "/manage.png",
    play = ICON_ROOT .. "/play.png",
    refresh = ICON_ROOT .. "/refresh.png",
    remove = ICON_ROOT .. "/remove.png",
    check = ICON_ROOT .. "/check.png",
    link = ICON_ROOT .. "/link.png",
}
local LIST_WRAP = plugin.has_capability("ui.list_wrap")
local CATALOG = ROOT .. "/.catalog"
local SUBSCRIPTIONS = ROOT .. "/subscriptions.opml"
local PROGRESS = ROOT .. "/.progress.tsv"
local SETTINGS = ROOT .. "/.settings"
local USER_AGENT = "CompasPodcasts/1.0"
local MAX_SUBSCRIPTIONS = 300 -- keeps Home well inside show_list's 500-row limit
local MAX_OPML_BYTES = 1048576
-- History bounds. Past them the oldest entries without a download are
-- dropped (played marks, old positions); downloads are never dropped.
local MAX_PROGRESS_BYTES, MAX_PROGRESS_RECORDS = 2097152, 5000
local MAX_PROGRESS_READ_BYTES = 8388608
-- Download entries are never pruned, so new downloads stop here instead.
local MAX_DOWNLOADS = 2000
local MAX_NEW_PER_SHOW = 5
local subscriptions, catalogs, progress = {}, {}, {}
local fetching, search_running = {}, false
local queue, active_download = {}, nil
local function update_download_progress(item, message, fraction)
    if not item or not plugin.has_capability("ui.progress") then return false end
    if item.progress_handle and plugin.update_progress(item.progress_handle, message, fraction) then return true end
    if item.progress_handle then item.progress_handle = nil end
    if item.progress_attempted then return false end
    item.progress_attempted = true
    item.progress_handle = plugin.show_progress(tr("Podcast download"), message, fraction)
    return item.progress_handle ~= nil
end

local function close_download_progress(item)
    if item and item.progress_handle then
        plugin.close_progress(item.progress_handle)
        item.progress_handle = nil
    end
end

local path_to_key, pending_seek = {}, nil
local progress_dirty = false
-- Set when the history file was larger than one read: it is then never
-- overwritten this session, so no entry beyond the read is lost.
local progress_partial = false
local cancelled_files = {}
local stream_generation = 0
local last_saved_position, interval_handle = -1, nil
local playback_speed, speed_retry_pending = 1.0, false
local SPEEDS = { 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0 }
local fetch_feed, feed_response, confirm_unsubscribe, open_episode
local enqueue_download, cancel_download, resolve_redirect
local open_settings, open_speed_menu
local has_required_capabilities = plugin.has_capability("network.http.async")
    and plugin.has_capability("network.http.download")
    and plugin.has_capability("filesystem.mkdir")

local function trim(s)
    return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function encode(s)
    return (
        tostring(s or ""):gsub("([^%w%._%- ])", function(c)
            return string.format("%%%02X", string.byte(c))
        end)
    )
end

local function decode(s)
    return ((s or ""):gsub("%%(%x%x)", function(h)
        return string.char(tonumber(h, 16))
    end))
end

local function split_tabs(line)
    local out = {}
    for value in (line .. "\t"):gmatch("(.-)\t") do
        out[#out + 1] = value
    end
    return out
end

-- Writes through a checked writer: a failed write (a full card) must never
-- replace good state with a truncated file.
local function atomic_write(path, writer)
    local tmp = path .. ".tmp"
    local f = io.open(tmp, "w")
    if not f then
        return false
    end
    local checked = {
        write = function(_, ...)
            local ok, err = f:write(...)
            if not ok then
                error(err or "write failed")
            end
        end,
    }
    local ok = pcall(writer, checked)
    local closed = f:close()
    if not ok or not closed then
        os.remove(tmp)
        return false
    end
    if os.rename(tmp, path) then
        return true
    end
    os.remove(tmp)
    return false
end

local function speed_supported()
    return plugin.has_capability and plugin.has_capability("playback.speed")
        and type(plugin.set_playback_speed) == "function"
end

local function is_podcast_path(path)
    return type(path) == "string" and path:sub(1, #ROOT + 1) == ROOT .. "/"
end

local function restore_reading_room()
    local ok, changed = pcall(plugin.restore_player_layout)
    return ok and changed == true
end

local function apply_reading_room(quiet)
    local ok = pcall(plugin.set_player_layout, READING_ROOM)
    if ok and not quiet then plugin.show_toast(string.format(tr("%s applied for this session"), READING_ROOM.name)) end
    return ok
end

local function current_download_path()
    local path = plugin.get_current_track_path()
    if type(path) ~= "string" then
        return nil
    end
    if path:sub(1, #ROOT + 1) ~= ROOT .. "/" then
        return nil
    end
    if not path_to_key[path] then
        for key, p in pairs(progress) do
            if p.path == path then
                path_to_key[path] = key
                break
            end
        end
    end
    if not path_to_key[path] then
        return nil
    end
    return path
end

local function apply_speed(value)
    if not speed_supported() then
        return value == 1.0
    end
    local ok, accepted = pcall(plugin.set_playback_speed, ROOT, value)
    return ok and accepted == true
end

local function read_settings()
    local f = io.open(SETTINGS, "r")
    if not f then return end
    for _ = 1, 8 do
        local line = f:read("*l")
        if not line then break end
        local value = tonumber(line:match("^playback_speed\t([%d%.]+)$"))
        for _, speed in ipairs(SPEEDS) do
            if value == speed then playback_speed = value end
        end
    end
    f:close()
end

local function save_settings()
    return atomic_write(SETTINGS, function(f)
        f:write("playback_speed\t", tostring(playback_speed), "\n")
    end)
end

open_speed_menu = function(require_download)
    if not speed_supported() then
        plugin.show_toast(tr("Playback speed requires a newer player"))
        return
    end
    local choices = {}
    for _, value in ipairs(SPEEDS) do
        choices[#choices + 1] = tostring(value) .. "x"
    end
    plugin.show_list(tr("Playback speed"), choices, function(choice)
        local speed = SPEEDS[choice]
        if not speed then return end
        local current_path = current_download_path()
        if require_download and not current_path then
            plugin.show_toast(tr("Playback speed is available for downloaded episodes"))
            return
        end
        local defer_until_resume = current_path and pending_seek and not pending_seek.failed and pending_seek.path == current_path
        if current_path and not defer_until_resume and not apply_speed(speed) then
            plugin.show_toast(tr("Speed is unavailable for this audio format"))
            return
        end
        local previous = playback_speed
        playback_speed = speed
        if not save_settings() then
            playback_speed = previous
            if current_path then
                speed_retry_pending = defer_until_resume == true or not apply_speed(previous)
            else
                speed_retry_pending = true
            end
            plugin.show_toast(tr("Could not save playback speed"))
            return
        end
        speed_retry_pending = current_path == nil or defer_until_resume == true
        if not require_download then open_settings(true) end
        plugin.show_toast(string.format(tr("Playback speed set to %sx"), tostring(speed)))
    end)
end

open_settings = function(update_existing)
    local rows = { {
        type = "row", label = string.format(tr("Playback speed: %sx"), tostring(playback_speed)),
        icon = ICON.manage, on_select = function() open_speed_menu(false) end,
    } }
    if type(plugin.show_settings_list) == "function" then
        plugin.show_settings_list(tr("Podcasts settings"), rows,
            update_existing and { update = true } or nil)
    else
        -- API-min-2 builds predate the settings-list helper. They also lack
        -- playback.speed, so retain a tappable row that explains the limit.
        plugin.show_list(tr("Podcasts settings"), { rows[1].label }, function(index)
            if index == 1 then open_speed_menu(false) end
        end)
    end
end

local function show_podcast_reading_menu()
    if not is_podcast_path(plugin.get_current_track_path()) then
        plugin.show_list(tr("Podcasts · Reading Room"), {
            tr("No podcast episode selected"),
            tr("Choose an episode from Podcasts to see its details"),
        }, function() end)
        return
    end

    local title, artist, album = plugin.get_now_playing()
    local function display_value(value, fallback)
        if type(value) ~= "string" then return fallback end
        value = value:gsub("^%s+", ""):gsub("%s+$", "")
        return value ~= "" and value or fallback
    end
    local rows = {
        string.format(tr("Episode · %s"), display_value(title, tr("Unknown episode"))),
        string.format(tr("Host · %s"), display_value(artist, tr("Unknown host"))),
        string.format(tr("Show · %s"), display_value(album, tr("Unknown show"))),
    }
    plugin.show_list(tr("Podcasts · Reading Room"), rows, function() end)
end

local function skip_podcast_seconds(delta)
    if not is_podcast_path(plugin.get_current_track_path()) then return end
    local position = tonumber(plugin.get_position()) or 0
    local target = math.max(0, position + delta)
    local duration = tonumber(plugin.get_duration()) or 0
    if duration and duration > 0 then target = math.min(target, duration) end
    plugin.seek(target)
end

-- set_player_layout registers this session-owned layout for the picker.
plugin.set_player_layout(READING_ROOM)
plugin.register_player_action("reading_menu", show_podcast_reading_menu)
plugin.register_player_action("speed_menu", function()
    if not current_download_path() then
        plugin.show_toast(tr("Podcast speed is available for downloaded episodes"))
        return
    end
    open_speed_menu(true)
end)
plugin.register_player_action("rewind_15", function() skip_podcast_seconds(-15) end)
plugin.register_player_action("forward_15", function() skip_podcast_seconds(15) end)

local function valid_url(url)
    return type(url) == "string"
        and #url <= 2047 -- the native request APIs refuse 2048 bytes and more
        and url:match("^https?://") ~= nil
        and not url:find("[%c%s]")
end

local function remove_dot_segments(path)
    local segments, out = {}, {}
    for segment in (path:sub(2) .. "/"):gmatch("(.-)/") do
        segments[#segments + 1] = segment
    end
    for _, segment in ipairs(segments) do
        if segment == ".." then
            if #out > 0 then
                table.remove(out)
            end
        elseif segment ~= "." then
            out[#out + 1] = segment
        end
    end
    local result = "/" .. table.concat(out, "/")
    local last = segments[#segments]
    if (last == "." or last == "..") and result:sub(-1) ~= "/" then
        result = result .. "/"
    end
    return result
end

-- A Location header resolved against the URL that returned it (RFC 3986
-- section 5.2, for the forms servers send: absolute, //host, /path, ?query,
-- and relative paths with dot segments).
local function resolve_reference(base, reference)
    local ref = trim(reference):gsub("#.*$", "")
    if ref:match("^[Hh][Tt][Tt][Pp][Ss]?://") then
        return ref
    end
    local scheme, authority, path = base:match("^(https?)://([^/?#]*)([^?#]*)")
    if not scheme then
        return nil
    end
    if ref:sub(1, 2) == "//" then
        return scheme .. ":" .. ref
    end
    if path == "" then
        path = "/"
    end
    if ref == "" then
        return (base:gsub("#.*$", ""))
    end
    if ref:sub(1, 1) == "?" then
        return scheme .. "://" .. authority .. path .. ref
    end
    local ref_path, ref_query = ref:match("^([^?]*)(.*)$")
    local merged = ref_path:sub(1, 1) == "/" and ref_path or ((path:match("^(.*/)") or "/") .. ref_path)
    return scheme .. "://" .. authority .. remove_dot_segments(merged) .. ref_query
end

local function cap(s, n)
    s = tostring(s or "")
    if #s <= n then
        return s
    end
    return s:sub(1, n)
end

local function xml_escape(s)
    return (
        tostring(s or "")
            :gsub("&", "&amp;")
            :gsub("<", "&lt;")
            :gsub(">", "&gt;")
            :gsub('"', "&quot;")
            :gsub("'", "&apos;")
    )
end

local function utf8_char(n)
    if n < 0 or n > 1114111 or (n >= 55296 and n <= 57343) then
        return ""
    end
    if n < 128 then
        return string.char(n)
    end
    if n < 2048 then
        return string.char(192 + math.floor(n / 64), 128 + n % 64)
    end
    if n < 65536 then
        return string.char(224 + math.floor(n / 4096), 128 + math.floor(n / 64) % 64, 128 + n % 64)
    end
    return string.char(
        240 + math.floor(n / 262144),
        128 + math.floor(n / 4096) % 64,
        128 + math.floor(n / 64) % 64,
        128 + n % 64
    )
end

local ENTITIES = { amp = "&", lt = "<", gt = ">", quot = '"', apos = "'" }

-- One pass, so "&amp;lt;" becomes the literal "&lt;" rather than "<".
local function decode_entities(s)
    return (
        (s or ""):gsub("&(#?[%w]+);", function(entity)
            local hex = entity:match("^#[xX](%x+)$")
            if hex then
                return #hex <= 6 and utf8_char(tonumber(hex, 16)) or ""
            end
            local dec = entity:match("^#(%d+)$")
            if dec then
                return #dec <= 7 and utf8_char(tonumber(dec)) or ""
            end
            return ENTITIES[entity] or ("&" .. entity .. ";")
        end)
    )
end

-- Linear: each "<" and ">" is looked for once, and an unterminated "<"
-- ends the scan (a pattern such as "<[^>]*>" rescans on every "<").
local function strip_markup(s)
    local out, pos = {}, 1
    while true do
        local a = s:find("<", pos, true)
        if not a then
            out[#out + 1] = s:sub(pos)
            break
        end
        out[#out + 1] = s:sub(pos, a - 1)
        local b = s:find(">", a + 1, true)
        if not b then
            out[#out + 1] = s:sub(a)
            break
        end
        out[#out + 1] = " "
        pos = b + 1
    end
    return table.concat(out)
end

-- Raw element text is cut before cleanup; every field shown is far shorter.
local MAX_FIELD_BYTES = 8192

-- Element text: markup is removed before entities are decoded, so escaped
-- text such as "&lt;Bonus&gt;" survives; CDATA sections are taken as-is
-- apart from the HTML tags podcast feeds put in them.
local function clean_text(s)
    s = s or ""
    local out, pos = {}, 1
    while true do
        local a, b = s:find("<![CDATA[", pos, true)
        out[#out + 1] = decode_entities(strip_markup(s:sub(pos, a and a - 1 or #s)))
        if not a then
            break
        end
        local c = s:find("]]>", b + 1, true)
        out[#out + 1] = decode_entities(strip_markup(s:sub(b + 1, c and c - 1 or #s)))
        if not c then
            break
        end
        pos = c + 3
    end
    return trim((table.concat(out):gsub("[%c%s]+", " ")))
end

-- The next <name ...> tag at or after pos (name may be "/item" for a closing
-- tag), skipping CDATA sections and comments, where show notes may quote
-- tags and a user may comment one out. One forward pass over each "<".
-- While a feed is parsed, every "<" visited counts against this budget, so
-- a feed built to make the lookups rescan (say, a megabyte of "<") fails
-- cleanly instead of running past the callback time limit.
local scan_budget = nil

local function find_tag(body, pos, name)
    local wanted = "<" .. name
    while true do
        local i = body:find("<", pos, true)
        if not i then
            return nil
        end
        if scan_budget then
            scan_budget = scan_budget - 1
            if scan_budget < 0 then
                error("Feed is too complex")
            end
        end
        if body:sub(i, i + 8) == "<![CDATA[" then
            local e = body:find("]]>", i + 9, true)
            if not e then
                return nil
            end
            pos = e + 3
        elseif body:sub(i, i + 3) == "<!--" then
            local e = body:find("-->", i + 4, true)
            if not e then
                return nil
            end
            pos = e + 3
        elseif body:sub(i, i + #wanted - 1) == wanted then
            local after = body:sub(i + #wanted, i + #wanted)
            if after == ">" or after:match("%s") then
                return i
            end
            pos = i + #wanted
        else
            pos = i + 1
        end
    end
end

-- Plain searches for the exact tag name: scanning every tag with a pattern
-- is too slow for items that carry long HTML show notes.
local function tag_text(block, name)
    local a = find_tag(block, 1, name)
    if not a then
        return ""
    end
    local open_end = block:find(">", a + #name + 1, true)
    if not open_end then
        return ""
    end
    local close_start = find_tag(block, open_end + 1, "/" .. name)
    if not close_start then
        return ""
    end
    return clean_text(block:sub(open_end + 1, math.min(close_start - 1, open_end + MAX_FIELD_BYTES)))
end

-- Removes <name ...>...</name> blocks (show notes) before field lookups.
local function strip_blocks(block, name)
    local parts, pos = {}, 1
    while true do
        -- find_tag skips comments and CDATA for both ends, so a quoted tag
        -- neither ends a block early nor starts one.
        local a = find_tag(block, pos, name)
        if not a then
            break
        end
        local b = find_tag(block, a + #name + 1, "/" .. name)
        if not b then
            break
        end
        local e = block:find(">", b, true)
        if not e then
            break
        end
        parts[#parts + 1] = block:sub(pos, a - 1)
        pos = e + 1
    end
    parts[#parts + 1] = block:sub(pos)
    return table.concat(parts)
end

-- End of the tag opened at `start`: the first ">" outside quotes (a quoted
-- attribute value may contain ">"), or nil past MAX_TAG_BYTES.
local function tag_end(s, start)
    local pos, limit = start, start + 16384
    while pos <= limit do
        local i = s:find("[\"'>]", pos)
        if not i or i > limit then
            return nil
        end
        local c = s:sub(i, i)
        if c == ">" then
            return i
        end
        local close = s:find(c, i + 1, true)
        if not close then
            return nil
        end
        pos = close + 1
    end
    return nil
end

-- Linear scan of name=value pairs: an anchored or single-class pattern at
-- each step, never one that can backtrack over a long hostile tag.
local MAX_TAG_BYTES = 16384

local function attr(tag, name)
    if #tag > MAX_TAG_BYTES then
        return nil
    end
    local wanted, i, n = name:lower(), 1, #tag
    while i <= n do
        if scan_budget then
            scan_budget = scan_budget - 1
            if scan_budget < 0 then
                error("File is too complex")
            end
        end
        local s, e = tag:find("[%w_:%-]+", i)
        if not s then
            return nil
        end
        local key = tag:sub(s, e):lower()
        local _, ws = tag:find("^%s*", e + 1)
        local j = ws + 1
        if tag:sub(j, j) ~= "=" then
            i = e + 1
        else
            _, ws = tag:find("^%s*", j + 1)
            j = ws + 1
            local q = tag:sub(j, j)
            local value, next_i
            if q == '"' or q == "'" then
                local close = tag:find(q, j + 1, true)
                if not close then
                    return nil
                end
                value, next_i = tag:sub(j + 1, close - 1), close + 1
            else
                -- Unquoted (invalid XML, but seen): runs to a space or ">",
                -- less the "/" of a self-closing tag.
                local stop = tag:find("[%s>]", j) or (n + 1)
                value, next_i = tag:sub(j, stop - 1), stop
                if tag:sub(stop, stop) == ">" and value:sub(-1) == "/" then
                    value = value:sub(1, -2)
                end
            end
            if key == wanted then
                return decode_entities(value)
            end
            i = math.max(next_i, e + 1)
        end
    end
    return nil
end

local function date_epoch(year, month, day, hour, minute, second, zone)
    local base = os.time({
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(minute),
        sec = tonumber(second),
        isdst = false,
    })
    local utc_fields = os.date("!*t", base)
    local local_offset = base - os.time(utc_fields)
    local zones = {
        GMT = 0,
        UTC = 0,
        UT = 0,
        EST = -5,
        EDT = -4,
        CST = -6,
        CDT = -5,
        MST = -7,
        MDT = -6,
        PST = -8,
        PDT = -7,
        CET = 1,
        CEST = 2,
        BST = 1,
        JST = 9,
        AEST = 10,
        AEDT = 11,
        NZST = 12,
        NZDT = 13,
    }
    local zone_offset = 0
    local sign, zh, zm = zone:match("^([%+%-])(%d%d):?(%d%d)$")
    if sign then
        zone_offset = (tonumber(zh) * 60 + tonumber(zm)) * 60
        if sign == "-" then
            zone_offset = -zone_offset
        end
    else
        zone_offset = (zones[zone:upper()] or 0) * 3600
    end
    return base + local_offset - zone_offset
end

local MONTHS = {
    jan = 1,
    feb = 2,
    mar = 3,
    apr = 4,
    may = 5,
    jun = 6,
    jul = 7,
    aug = 8,
    sep = 9,
    oct = 10,
    nov = 11,
    dec = 12,
}

local function parse_date(s)
    s = trim(s)
    local y, mo, d, h, mi, se, iso_zone = s:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)[Tt ](%d%d):(%d%d):(%d%d)(.*)$")
    if y then
        iso_zone = trim(iso_zone):gsub("^%.%d+", "")
        if iso_zone == "" or iso_zone == "Z" or iso_zone == "z" then
            iso_zone = "UTC"
        end
        if iso_zone:match("^[%+%-]%d%d:?%d%d$") or iso_zone == "UTC" then
            return date_epoch(y, mo, d, h, mi, se, iso_zone)
        end
        return nil
    end
    -- RFC 822: the weekday and the seconds are both optional.
    s = s:gsub("^%a+,?%s*", "")
    local day, mon, year, hour, minute, rest =
        s:match("^(%d%d?)%s+(%a+)%s+(%d%d%d?%d?)%s+(%d%d?):(%d%d)(.*)$")
    if not day then
        return nil
    end
    local second, zone = rest:match("^:(%d%d)%s*(%S*)")
    if not second then
        second, zone = "0", rest:match("^%s*(%S*)")
    end
    local month = MONTHS[mon:lower():sub(1, 3)]
    if not month then
        return nil
    end
    year = tonumber(year)
    if year < 100 then
        year = year < 50 and year + 2000 or year + 1900
    end
    return date_epoch(year, month, day, hour, minute, second, zone ~= "" and zone or "GMT")
end

local function format_duration(seconds)
    seconds = math.max(0, math.floor(seconds or 0))
    local h, m, s = math.floor(seconds / 3600), math.floor(seconds / 60) % 60, seconds % 60
    if h > 0 then
        return string.format("%d:%02d:%02d", h, m, s)
    end
    return string.format("%d:%02d", m, s)
end

local MAX_DURATION = 100 * 3600

-- Seconds, mm:ss or hh:mm:ss; anything non-finite or absurd counts as unknown.
local function parse_duration(s)
    s = trim(s):gsub(",", ".")
    local value
    local h, m, sec = s:match("^(%d+):(%d%d):(%d%d)")
    if h then
        value = tonumber(h) * 3600 + tonumber(m) * 60 + tonumber(sec)
    else
        m, sec = s:match("^(%d+):(%d%d)")
        if m then
            value = tonumber(m) * 60 + tonumber(sec)
        else
            value = tonumber(s:match("^%d+%.?%d*$") or "")
        end
    end
    if not value or value ~= value or value < 0 or value > MAX_DURATION then
        return 0
    end
    return math.floor(value)
end

local function audio_ext(url, mime)
    local path = (url or ""):match("^https?://[^/]+([^?#]*)") or url or ""
    local ext = path:match("%.([%w]+)$")
    ext = ext and ext:lower()
    local known = { mp3 = true, m4a = true, aac = true, ogg = true, opus = true, flac = true }
    if known[ext] then
        return ext
    end
    local types = {
        ["audio/mpeg"] = "mp3",
        ["audio/mp4"] = "m4a",
        ["audio/x-m4a"] = "m4a",
        ["audio/m4a"] = "m4a",
        ["audio/aac"] = "aac",
        ["audio/ogg"] = "ogg",
        ["audio/opus"] = "opus",
        ["audio/flac"] = "flac",
    }
    return types[(mime or ""):lower()] or "mp3"
end

local function is_mp3_url(url)
    local lower = (url or ""):lower()
    return lower:match("%.mp3$") ~= nil or lower:match("%.mp3[?#]") ~= nil
end

-- Episode identity. A long GUID or URL is hashed whole rather than cut
-- short, so two episodes sharing a long prefix never merge their state.
local function episode_identity(s)
    if #s <= 200 then
        return s
    end
    return "md5:" .. plugin.md5(s)
end

local function parse_rss(body, feed_url)
    if body:sub(1, 2) == string.char(31, 139) then
        return nil, "Feed is compressed"
    end
    local prefix = body:sub(1, 8192):lower()
    if
        prefix:find("<feed", 1, true)
        and not prefix:find("<rss", 1, true)
        and not prefix:find("<channel", 1, true)
    then
        return nil, "Atom feeds are not supported"
    end
    -- An HTML login or error page must not replace a show's episodes.
    if not prefix:find("<rss", 1, true) and not prefix:find("<channel", 1, true) then
        return nil, "Not a podcast feed"
    end
    local function find_item(start)
        return find_tag(body, start, "item")
    end
    local first_item = find_item(1) or (#body + 1)
    local channel = strip_blocks(body:sub(1, first_item - 1), "image")
    local title = tag_text(channel, "title")
    local author = tag_text(channel, "itunes:author")
    if author == "" then
        author = tag_text(channel, "author")
    end
    local items, pos = {}, 1
    -- Items without audio do not count toward the 40, so the number looked at
    -- is capped too.
    local inspected = 0
    while #items < 40 and inspected < 400 do
        inspected = inspected + 1
        local a = find_item(pos)
        if not a then
            break
        end
        local open_end = body:find(">", a, true)
        if not open_end then
            break
        end
        local close_a = find_tag(body, open_end + 1, "/item")
        if not close_a then
            break
        end
        local close_end = body:find(">", close_a, true)
        if not close_end then
            break
        end
        local block = body:sub(a, close_end)
        block = strip_blocks(block, "content:encoded")
        block = strip_blocks(block, "description")
        block = strip_blocks(block, "itunes:summary")
        local item_title = tag_text(block, "title")
        if item_title == "" then
            item_title = tag_text(block, "itunes:title")
        end
        local item = { title = cap(item_title, 200) }
        item.pub_date = tag_text(block, "pubDate")
        item.epoch = parse_date(item.pub_date)
        item.date = item.epoch and os.date("!%Y-%m-%d", item.epoch) or ""
        item.duration = parse_duration(tag_text(block, "itunes:duration"))
        if item.duration == 0 then
            item.duration = parse_duration(tag_text(block, "duration"))
        end
        local guid = tag_text(block, "guid")
        local enc_pos = 1
        while true do
            local ea = find_tag(block, enc_pos, "enclosure")
            if not ea then
                break
            end
            local eb = tag_end(block, ea)
            if not eb then
                break
            end
            local etag = block:sub(ea, eb)
            local url, mime = attr(etag, "url"), attr(etag, "type")
            if mime == "" then
                mime = nil
            end
            local ext = audio_ext(url, mime)
            local enclosure_ext = url
                and ((url:match("^https?://[^/]+([^?#]*)") or url):lower():match("%.([%w]+)$"))
            local audio_extensions =
                { mp3 = true, m4a = true, aac = true, ogg = true, opus = true, flac = true }
            local is_audio = (mime and mime:lower():match("^audio/"))
                or (not mime and audio_extensions[enclosure_ext])
            if valid_url(url) and is_audio then
                item.url, item.mime = url, cap(mime, 128)
                item.length = tonumber(attr(etag, "length")) or 0
                item.ext = ext
                break
            end
            enc_pos = eb + 1
        end
        if item.url then
            item.guid = episode_identity(guid ~= "" and guid or item.url)
            item.key = plugin.md5(item.guid)
            item.feed_url = feed_url
            item.title = item.title ~= "" and item.title or tr("Untitled episode")
            items[#items + 1] = item
        end
        pos = close_end + 1
    end
    table.sort(items, function(a, b)
        if not a.epoch then
            return false
        end
        if not b.epoch then
            return true
        end
        return a.epoch > b.epoch
    end)
    return { title = cap(title, 200), author = cap(author, 200), feed_url = feed_url, items = items }
end

local function show_key(url)
    return plugin.md5(url):sub(1, 16)
end
local function catalog_path(key)
    return CATALOG .. "/" .. key .. ".tsv"
end

local function save_catalog(show)
    return atomic_write(catalog_path(show.key), function(f)
        f:write(
            "S\t",
            encode(show.title),
            "\t",
            encode(show.author),
            "\t",
            encode(show.feed_url),
            "\t",
            tostring(os.time()),
            "\n"
        )
        for i = 1, math.min(40, #show.items) do
            local e = show.items[i]
            f:write(
                "E\t",
                encode(e.guid),
                "\t",
                encode(e.title),
                "\t",
                encode(e.url),
                "\t",
                encode(e.mime),
                "\t",
                tostring(e.length or 0),
                "\t",
                tostring(e.duration or 0),
                "\t",
                tostring(e.epoch or 0),
                "\t",
                encode(e.date),
                "\n"
            )
        end
    end)
end

local function load_catalog(key, title, url)
    local f = io.open(catalog_path(key), "r")
    if not f then
        return nil
    end
    local show, count = nil, 0
    for line in f:lines() do
        if #line > 10000 then
            break
        end
        local p = split_tabs(line)
        if p[1] == "S" then
            show = {
                key = key,
                title = decode(p[2]),
                author = decode(p[3]),
                feed_url = decode(p[4]),
                refreshed = tonumber(p[5]) or 0,
                items = {},
            }
        elseif p[1] == "E" and show and count < 40 then
            count = count + 1
            local urlv = decode(p[4])
            if valid_url(urlv) then
                show.items[#show.items + 1] = {
                    guid = decode(p[2]),
                    title = decode(p[3]),
                    url = urlv,
                    mime = decode(p[5]),
                    length = tonumber(p[6]) or 0,
                    duration = tonumber(p[7]) or 0,
                    epoch = tonumber(p[8]) or nil,
                    date = decode(p[9]),
                    ext = audio_ext(urlv, decode(p[5])),
                    key = plugin.md5(decode(p[2])),
                }
            end
        end
    end
    f:close()
    if show then
        show.title = show.title ~= "" and show.title or title
        show.feed_url = show.feed_url ~= "" and show.feed_url or url
    end
    return show
end

local function progress_line(k, p)
    return table.concat({
        "P",
        encode(k),
        tostring(math.floor(p.position or 0)),
        tostring(math.floor(p.duration or 0)),
        p.played and "1" or "0",
        p.new and "1" or "0",
        encode(p.path),
        tostring(p.last_played or 0),
        encode(p.title),
        encode(p.date),
        tostring(p.epoch or 0),
    }, "\t") .. "\n"
end

-- Drops the least recently played entries without a download until both
-- bounds hold (or only download entries remain).
local function prune_progress()
    local count, bytes, droppable = 0, 0, {}
    for k, p in pairs(progress) do
        count = count + 1
        bytes = bytes + #progress_line(k, p)
        if p.path == "" then
            droppable[#droppable + 1] = k
        end
    end
    if count <= MAX_PROGRESS_RECORDS and bytes <= MAX_PROGRESS_BYTES then
        return
    end
    table.sort(droppable, function(a, b)
        local pa, pb = progress[a], progress[b]
        if pa.last_played ~= pb.last_played then
            return pa.last_played < pb.last_played
        end
        return (pa.epoch or 0) < (pb.epoch or 0)
    end)
    for _, k in ipairs(droppable) do
        if count <= MAX_PROGRESS_RECORDS and bytes <= MAX_PROGRESS_BYTES then
            break
        end
        count = count - 1
        bytes = bytes - #progress_line(k, progress[k])
        progress[k] = nil
    end
end

local function save_progress()
    if progress_partial then
        return false
    end
    local stateless = {}
    for k, p in pairs(progress) do
        if not (p.position ~= 0 or p.played or p.new or p.path ~= "" or p.last_played ~= 0) then
            stateless[#stateless + 1] = k
        end
    end
    for _, k in ipairs(stateless) do
        progress[k] = nil
    end
    prune_progress()
    local ok = atomic_write(PROGRESS, function(f)
        for k, p in pairs(progress) do
            f:write(progress_line(k, p))
        end
    end)
    -- The index follows memory, not the file, and a failed write (a full
    -- card) is retried from the tick.
    path_to_key = {}
    for k, p in pairs(progress) do
        if p.path and p.path ~= "" then
            path_to_key[p.path] = k
        end
    end
    progress_dirty = not ok
    return ok
end

local function load_progress()
    local f = io.open(PROGRESS, "r")
    if not f then
        return
    end
    local body = f:read(MAX_PROGRESS_READ_BYTES) or ""
    if #body == MAX_PROGRESS_READ_BYTES and f:read(1) then
        progress_partial = true
        body = body:match("^(.*\n)") or "" -- only complete entries
        plugin.show_toast(tr("Some download history could not be loaded"))
    end
    f:close()
    for line in body:gmatch("([^\n]+)\n?") do
        -- A corrupt over-long line is skipped, not fatal to the rest.
        if #line < 8192 then
            local p = split_tabs(line)
            if p[1] == "P" and p[2] then
                local k = decode(p[2])
                progress[k] = {
                    position = tonumber(p[3]) or 0,
                    duration = tonumber(p[4]) or 0,
                    played = p[5] == "1",
                    new = p[6] == "1",
                    path = decode(p[7]),
                    last_played = tonumber(p[8]) or 0,
                    title = decode(p[9]),
                    date = decode(p[10]),
                    epoch = tonumber(p[11]) or 0,
                }
            end
        end
    end
    body = nil
    if not progress_partial then
        prune_progress()
    end
    for k, p in pairs(progress) do
        if p.path ~= "" then
            path_to_key[p.path] = k
        end
    end
end

local function save_subscriptions()
    return atomic_write(SUBSCRIPTIONS, function(f)
        f:write(
            '<?xml version="1.0" encoding="UTF-8"?>\n<opml version="2.0"><head><title>Podcasts</title></head><body>\n'
        )
        for _, s in ipairs(subscriptions) do
            f:write(
                '<outline type="rss" text="',
                xml_escape(s.title),
                '" xmlUrl="',
                xml_escape(s.url),
                '"/>\n'
            )
        end
        f:write("</body></opml>\n")
    end)
end

local function load_subscriptions()
    local f = io.open(SUBSCRIPTIONS, "r")
    if not f then
        return
    end
    local body = f:read(MAX_OPML_BYTES) or ""
    f:close()
    scan_budget = 400000
    local ok = pcall(function()
        local seen, pos = {}, 1
        while #subscriptions < MAX_SUBSCRIPTIONS do
            local a = find_tag(body, pos, "outline")
            if not a then
                break
            end
            local b = tag_end(body, a)
            if not b then
                break
            end
            local tag = body:sub(a, b)
            local url = attr(tag, "xmlUrl") or attr(tag, "xmlurl")
            local title = attr(tag, "text") or attr(tag, "title")
            if valid_url(url) and not seen[url] then
                seen[url] = true
                subscriptions[#subscriptions + 1] =
                    { url = url, title = cap(title or url, 200), key = show_key(url) }
            end
            pos = b + 1
        end
    end)
    scan_budget = nil
    if not ok then
        -- Keep whatever loaded before the limit; the file is rewritten on
        -- the next change.
        print("[Podcasts] subscriptions.opml is too complex; loaded " .. #subscriptions .. " shows")
    end
end

local function sort_subscriptions()
    table.sort(subscriptions, function(a, b)
        return a.title:lower() < b.title:lower()
    end)
end

local function find_subscription(url)
    for _, s in ipairs(subscriptions) do
        if s.url == url then
            return s
        end
    end
end

local function show_by_key(key)
    for _, s in ipairs(subscriptions) do
        if s.key == key then
            return s
        end
    end
end

local function progress_key(show, episode)
    return show.key .. "|" .. episode.guid
end

local function episode_progress(show, episode)
    local k = progress_key(show, episode)
    progress[k] = progress[k]
        or {
            position = 0,
            duration = episode.duration or 0,
            played = false,
            new = false,
            path = "",
            last_played = 0,
        }
    return progress[k], k
end

-- A single safe path component. Leading and trailing dots and spaces go
-- too, so feed data can never produce "." or ".." (or a name FAT rejects).
local function sanitized(s, fallback)
    s = tostring(s or ""):gsub('[/\\:*?"<>|]', " "):gsub("%c", " "):gsub("%s+", " ")
    s = s:gsub("^[%s%.]+", ""):gsub("[%s%.]+$", "")
    while #s > 80 do
        s = s:sub(1, #s - 1)
        while #s > 0 and s:byte(-1) >= 128 and s:byte(-1) < 192 do
            s = s:sub(1, -2)
        end
        if #s > 0 and s:byte(-1) >= 192 then
            s = s:sub(1, -2)
        end
    end
    s = s:gsub("[%s%.]+$", "")
    return s ~= "" and s or fallback
end

local function downloaded(show, episode)
    local p = progress[progress_key(show, episode)]
    if p and p.path and p.path ~= "" then
        local f = io.open(p.path, "rb")
        if f then
            f:close()
            return p.path
        end
    end
end

local function queued(show, episode)
    local key = progress_key(show, episode)
    if active_download and active_download.key == key then
        return true
    end
    for _, item in ipairs(queue) do
        if item.key == key then
            return true
        end
    end
    return false
end

local function request_options(url, extra)
    local headers = { ["User-Agent"] = USER_AGENT }
    if extra then
        for k, v in pairs(extra) do
            headers[k] = v
        end
    end
    return {
        url = url,
        headers = headers,
        verify_tls = true,
        connect_timeout_ms = 10000,
        read_timeout_ms = 20000,
        total_timeout_ms = 60000,
    }
end

-- Starts an async request; argument errors raise in the native API, so they
-- come back here as (nil, message) like a full request pool does.
local function start_request(fn, ...)
    local ok, handle, err = pcall(fn, ...)
    if not ok then
        return nil, tostring(handle)
    end
    return handle, err
end

local function pool_busy(err)
    return type(err) == "string" and err:find("too many active", 1, true) ~= nil
end

-- Work that must wait for the next tick: a request started inside another
-- request's callback cannot use the pool slot that request still holds.
local deferred = {}

local function defer(fn)
    deferred[#deferred + 1] = fn
end

local function run_deferred()
    local jobs = deferred
    deferred = {}
    for _, fn in ipairs(jobs) do
        fn()
    end
end

-- Starts a request now or, while the shared pool is full, from later ticks
-- (a finished request frees its slot only after its callback returns).
local function request_with_retry(opts, on_done, on_fail, tries)
    local handle, err = start_request(plugin.http_request, opts, on_done)
    if handle then
        return
    end
    tries = tries or 0
    if pool_busy(err) and tries < 30 then
        defer(function()
            request_with_retry(opts, on_done, on_fail, tries + 1)
        end)
    else
        on_fail(err)
    end
end

-- A few catalogs stay in memory; the rest are read from the card when opened.
local CATALOG_CACHE_SIZE = 4
local catalog_order = {}

local function remember_catalog(key, catalog)
    for i, k in ipairs(catalog_order) do
        if k == key then
            table.remove(catalog_order, i)
            break
        end
    end
    catalogs[key] = catalog
    if catalog then
        catalog_order[#catalog_order + 1] = key
        while #catalog_order > CATALOG_CACHE_SIZE do
            catalogs[table.remove(catalog_order, 1)] = nil
        end
    end
end

local function get_catalog(show)
    local catalog = catalogs[show.key] or load_catalog(show.key, show.title, show.url)
    remember_catalog(show.key, catalog)
    return catalog
end

local function open_show(show)
    local catalog = get_catalog(show)
    if catalog then
        catalog.title = show.title
        catalog.url = show.url
        catalog.key = show.key
    end
    if catalog then
        local labels, episodes = {}, {}
        for i, episode in ipairs(catalog.items) do
            episodes[i] = episode
            local p = progress[progress_key(show, episode)]
            local status = p and p.played and tr("Played")
                or (p and p.position > 5 and string.format(tr("Resume at %s"), format_duration(p.position))
                    or (p and p.new and tr("New") or ""))
            local availability = downloaded(show, episode) and tr("Downloaded")
                or (queued(show, episode) and tr("Downloading") or "")
            local metadata = {}
            if availability ~= "" then metadata[#metadata + 1] = availability end
            if status ~= "" then metadata[#metadata + 1] = status end
            if episode.date ~= "" then metadata[#metadata + 1] = episode.date end
            if (episode.duration or 0) > 0 then metadata[#metadata + 1] = format_duration(episode.duration) end
            local detail = table.concat(metadata, " · ")
            local icon = downloaded(show, episode) and ICON.download
                or (p and p.played and ICON.check or ICON.play)
            labels[#labels + 1] = {
                label = cap(
                    detail ~= "" and (episode.title .. (LIST_WRAP and ("\n" .. detail) or (" · " .. detail)))
                        or episode.title,
                    LIST_WRAP and 511 or 159
                ),
                icon = icon,
                wrap = LIST_WRAP,
            }
        end
        local refresh_index = #episodes + 1
        labels[refresh_index] = { label = tr("Refresh episodes"), icon = ICON.refresh }
        local unsubscribe_index = refresh_index + 1
        labels[unsubscribe_index] = { label = tr("Unsubscribe"), icon = ICON.remove }
        plugin.show_list(show.title, labels, function(index)
            if index == refresh_index then
                fetch_feed(show, false)
            elseif index == unsubscribe_index then
                confirm_unsubscribe(show)
            else
                open_episode(show, episodes[index])
            end
        end)
        return
    end
    fetch_feed(show, true)
end

local function header_value(headers, name)
    for k, v in pairs(headers or {}) do
        if k:lower() == name then
            return v
        end
    end
end

-- Every redirect is followed here, one hop at a time, so each Location is
-- resolved against the URL that sent it (the callback does not say which
-- URL the native client ended on). A feed over 1 MiB is retried once as
-- a Range request for its first 1 MiB (a chunked body reports io_error
-- instead of response_too_large when it overflows).
local function request_feed(show, first_open)
    if fetching[show.key] then
        return
    end
    fetching[show.key] = true
    local function failed(start_err)
        fetching[show.key] = nil
        plugin.show_toast(tr("Could not load episodes. Try again."))
    end
    local function fetch(url, hops, ranged)
        local opts = request_options(url, ranged and { Range = "bytes=0-1048575" } or nil)
        opts.redirect_limit, opts.max_response_bytes = 0, 1048576
        request_with_retry(opts, function(status, body, err, headers)
            local location = status and status >= 300 and status < 400 and header_value(headers, "location")
            if location then
                local next_url = resolve_reference(url, location)
                if hops >= 8 then
                    fetching[show.key] = nil
                    plugin.show_toast(tr("Could not load episodes. Try again."))
                    return
                end
                if url:match("^https://") and next_url and next_url:match("^http://") then
                    fetching[show.key] = nil
                    plugin.show_toast(tr("Could not load episodes. Try again."))
                    return
                end
                if valid_url(next_url) then
                    defer(function()
                        fetch(next_url, hops + 1, ranged)
                    end)
                    return
                end
            end
            if not ranged and (err == "response_too_large" or err == "io_error") then
                defer(function()
                    fetch(url, hops, true)
                end)
                return
            end
            fetching[show.key] = nil
            feed_response(show, first_open, status, body, err)
        end, failed)
    end
    fetch(show.url, 0, false)
end

feed_response = function(show, first_open, status, body, err)
    if err then
        plugin.show_toast(tr("Could not load episodes. Try again."))
        return
    end
    if status < 200 or status >= 300 then
        plugin.show_toast(tr("Could not load episodes. Try again."))
        return
    end
    scan_budget = 400000
    local ok, result, parse_err = pcall(parse_rss, body or "", show.url)
    scan_budget = nil
    body = nil
    collectgarbage("step")
    if not ok then
        plugin.show_toast(
            tr("Could not parse feed")
        )
        return
    end
    if not result then
        plugin.show_toast(tr("Could not parse feed"))
        return
    end
    local prior = get_catalog(show)
    if #result.items == 0 and prior and #prior.items > 0 then
        plugin.show_toast(tr("The feed returned no episodes; kept the saved list"))
        return
    end
    local old = {}
    if prior then
        for _, e in ipairs(prior.items) do
            old[e.guid] = true
        end
    end
    result.key, result.url = show.key, show.url
    if result.title == "" then
        result.title = show.title
    end
    local present, added = {}, 0
    local new_marked = 0
    for _, e in ipairs(result.items) do
        local p = progress[progress_key(show, e)]
        if p and p.new then
            new_marked = new_marked + 1
        end
    end
    -- Progress records are created only for episodes that get state.
    for i, e in ipairs(result.items) do
        present[e.guid] = true
        local is_new = prior and not old[e.guid] or (not prior and i <= 3)
        if is_new then
            if prior then
                added = added + 1
            end
            -- At most the newest few per show carry the flag, so hundreds of
            -- shows cannot fill memory with new-episode records.
            if new_marked < MAX_NEW_PER_SHOW then
                episode_progress(show, e).new = true
                new_marked = new_marked + 1
            end
        end
    end
    local prefix = show.key .. "|"
    for k, p in pairs(progress) do
        if k:sub(1, #prefix) == prefix then
            local guid = k:sub(#prefix + 1)
            if not present[guid] then
                -- Out of the catalog: no longer counted as new, and forgotten
                -- unless it is downloaded or partly heard.
                p.new = false
                local kept_file = p.path and p.path ~= ""
                if not kept_file and (p.played or (p.position or 0) == 0) then
                    progress[k] = nil
                end
            end
        end
    end
    remember_catalog(show.key, result)
    show.title = result.title
    for _, sub in ipairs(subscriptions) do
        if sub.key == show.key then
            sub.title = show.title
        end
    end
    save_catalog(result)
    save_subscriptions()
    save_progress()
    if first_open then
        open_show(show)
    else
        plugin.show_toast(added > 0 and string.format(tr("%d new episodes"), added) or tr("No new episodes"))
    end
end

-- Feed completion callbacks deliberately stay on screen only for the first open.
fetch_feed = function(show, first_open)
    plugin.show_toast(tr("Loading..."))
    request_feed(show, first_open)
end

local function ask_unsubscribe(show)
    plugin.show_list(tr("Unsubscribe?"), {
        { label = string.format(tr("Unsubscribe %s"), cap(show.title, 180)), icon = ICON.remove },
        { label = tr("Cancel"), icon = ICON.link },
    }, function(index)
        if index ~= 1 then
            return
        end
        local removed_at, removed
        for i, s in ipairs(subscriptions) do
            if s.key == show.key then
                removed_at, removed = i, table.remove(subscriptions, i)
                break
            end
        end
        if not save_subscriptions() then
            if removed then
                table.insert(subscriptions, removed_at, removed)
            end
            plugin.show_toast(tr("Could not save subscriptions. Try again."))
            return
        end
        -- The cache goes only once the removal is on the card.
        os.remove(catalog_path(show.key))
        remember_catalog(show.key, nil)
        plugin.show_toast(tr("Unsubscribed; downloads kept"))
    end)
end

confirm_unsubscribe = ask_unsubscribe

open_episode = function(show, episode)
    local p, key = episode_progress(show, episode)
    p.new = false
    save_progress()
    -- Saving drops records without state, so every action takes a fresh one.
    local function state()
        return episode_progress(show, episode)
    end
    local labels, actions = {}, {}
    local path = downloaded(show, episode)
    local is_queued = queued(show, episode)
    local detail_parts = {}
    if episode.date ~= "" then detail_parts[#detail_parts + 1] = episode.date end
    if (episode.duration or 0) > 0 then detail_parts[#detail_parts + 1] = format_duration(episode.duration) end
    local metadata = #detail_parts > 0 and table.concat(detail_parts, " · ") or tr("Episode details unavailable")
    labels[1] = {
        label = LIST_WRAP and (episode.title .. "\n" .. metadata) or cap(episode.title, 159),
        icon = ICON.show,
        wrap = LIST_WRAP,
    }
    actions[1] = function() end
    local function add(label, fn, icon)
        labels[#labels + 1] = icon and { label = label, icon = icon } or label
        actions[#actions + 1] = fn
    end
    if path then
        add((p.position > 5 and not p.played) and tr("Resume") or tr("Play download"), function()
            local current = state()
            -- A replay of a finished episode starts over and can be resumed.
            if current.played then
                current.played = false
                current.position = 0
            end
            current.last_played = os.time()
            save_progress()
            -- Keep the saved point guarded even if native playback refuses
            -- to restart and no track_started event follows.
            pending_seek = { path = path, position = current.position or 0, tries = 0 }
            plugin.play_file(path)
        end, ICON.play)
    end
    if not path and not is_queued and episode.url ~= "" then
        add(tr("Download"), function()
            enqueue_download(show, episode)
        end, ICON.download)
    end
    if is_queued then
        add(tr("Cancel download"), function()
            cancel_download(key)
        end, ICON.remove)
    end
    if
        not path
        and episode.url ~= ""
        and ((episode.mime or ""):lower() == "audio/mpeg" or is_mp3_url(episode.url))
    then
        add(tr("Stream (no resume)"), function()
            -- Any newer stream or track makes this request stale.
            stream_generation = stream_generation + 1
            local generation = stream_generation
            local function stale()
                return generation ~= stream_generation
            end
            resolve_redirect(episode.url, function(url, err)
                if stale() then
                    return
                end
                if err then
                    plugin.show_toast(tr("Could not stream episode. Try again."))
                else
                    plugin.play_file(url)
                end
            end, nil, stale)
        end, ICON.link)
    end
    local mark_played = not p.played
    add(mark_played and tr("Mark as played") or tr("Mark as unplayed"), function()
        local current = state()
        current.played = mark_played
        current.position = 0
        save_progress()
        plugin.show_toast(current.played and tr("Marked as played") or tr("Marked as unplayed"))
    end, ICON.check)
    local delete_index
    local delete_armed, delete_deadline = false, 0
    if path then
        add(tr("Delete download"), function()
            if not delete_armed or os.time() > delete_deadline then
                delete_armed = true
                delete_deadline = os.time() + 8
                plugin.show_toast(tr("Tap Delete download again within 8 seconds to confirm"))
                return
            end
            delete_armed, delete_deadline = false, 0
            if downloaded(show, episode) ~= path then
                plugin.show_toast(tr("Download is no longer available"))
                return
            end
            if plugin.get_current_track_path() == path then
                plugin.show_toast(tr("Stop this episode before deleting its download"))
                return
            end
            if not os.remove(path) then
                plugin.show_toast(tr("Could not delete download. Try again."))
                return
            end
            local current = state()
            current.path = ""
            current.position = 0
            path_to_key[path] = nil
            save_progress()
            plugin.show_toast(tr("Download deleted"))
        end, ICON.remove)
        delete_index = #actions
    end
    plugin.show_list(tr("Episode"), labels, function(index)
        if index ~= delete_index then
            delete_armed, delete_deadline = false, 0
        end
        actions[index]()
    end)
end

-- defer_save lets an import add many shows and write the list once.
local function add_subscription(url, title, defer_save)
    if not valid_url(url) then
        plugin.show_toast(tr("Enter an http(s) feed URL"))
        return nil
    end
    local exists = find_subscription(url)
    if exists then
        return exists, true
    end
    if #subscriptions >= MAX_SUBSCRIPTIONS then
        plugin.show_toast(tr("Subscription limit reached"))
        return nil
    end
    local show = { url = url, title = cap(title ~= "" and title or url, 200), key = show_key(url) }
    subscriptions[#subscriptions + 1] = show
    if not defer_save then
        sort_subscriptions()
        if not save_subscriptions() then
            for i, s in ipairs(subscriptions) do
                if s == show then
                    table.remove(subscriptions, i)
                    break
                end
            end
            plugin.show_toast(tr("Could not save subscriptions. Try again."))
            return nil
        end
    end
    return show, false
end

local function open_added(show, already)
    if already then
        plugin.show_toast(tr("Already subscribed"))
    end
    open_show(show)
end

local function parse_attrs_for_opml(xml)
    local found, seen, pos = {}, {}, 1
    while #found < MAX_SUBSCRIPTIONS do
        local a = find_tag(xml, pos, "outline")
        if not a then
            break
        end
        local b = tag_end(xml, a)
        if not b then
            break
        end
        local tag = xml:sub(a, b)
        local url = attr(tag, "xmlUrl") or attr(tag, "xmlurl")
        local title = attr(tag, "text") or attr(tag, "title") or url
        if valid_url(url) and not seen[url] then
            seen[url] = true
            found[#found + 1] = { url = url, title = cap(title, 200) }
        end
        pos = b + 1
    end
    return found
end

local function import_file(path)
    local f = io.open(path, "r")
    if not f then
        plugin.show_toast(tr("Could not read OPML"))
        return
    end
    local xml = f:read(MAX_OPML_BYTES) or ""
    f:close()
    scan_budget = 400000
    local parsed, imported = pcall(parse_attrs_for_opml, xml)
    scan_budget = nil
    xml = nil
    if not parsed then
        plugin.show_toast(tr("Could not import subscriptions. Try again."))
        return
    end
    local n = 0
    local before = #subscriptions
    for _, s in ipairs(imported) do
        if #subscriptions >= MAX_SUBSCRIPTIONS then
            break
        end
        local existed = find_subscription(s.url) ~= nil
        local added = add_subscription(s.url, s.title, true)
        if added and not existed then
            n = n + 1
        end
    end
    if not save_subscriptions() then
        -- Nothing was written: drop the additions so memory matches the card.
        for i = #subscriptions, before + 1, -1 do
            table.remove(subscriptions, i)
        end
        plugin.show_toast(tr("Could not save subscriptions. Try again."))
        return
    end
    sort_subscriptions()
    plugin.show_toast(string.format(tr("Imported %d podcasts"), n))
end

local function pick_import()
    local files = {}
    for _, e in ipairs(plugin.list_dir(ROOT)) do
        if not e.dir and e.name:lower():match("%.opml$") and e.name ~= "subscriptions.opml" then
            files[#files + 1] = e.name
        end
    end
    table.sort(files)
    if #files == 0 then
        plugin.show_toast(tr("No OPML files found in Podcasts"))
        return
    end
    local rows = {}
    for i, name in ipairs(files) do
        rows[i] = { label = name, icon = ICON.link }
    end
    plugin.show_list(tr("Import OPML"), rows, function(index)
        import_file(ROOT .. "/" .. files[index])
    end)
end

local function url_encode(s)
    return (
        tostring(s):gsub("([^%w%-_%.~])", function(c)
            return string.format("%%%02X", string.byte(c))
        end)
    )
end

local function show_search_results(results)
    if #results == 0 then
        plugin.show_toast(tr("No podcasts found"))
        return
    end
    local labels = {}
    for i, r in ipairs(results) do
        labels[i] = {
            label = cap(r.title .. (r.author ~= "" and (" - " .. r.author) or ""), LIST_WRAP and 511 or 159),
            icon = ICON.show,
            wrap = LIST_WRAP,
        }
    end
    plugin.show_list(tr("Podcast Search"), labels, function(index)
        local r = results[index]
        local show, already = add_subscription(r.url, r.title)
        if show then
            open_added(show, already)
        end
    end)
end

local function search_url(query, fallback)
    local url
    if fallback then
        url = "https://api.fyyd.de/0.2/search/podcast?term=" .. url_encode(query) .. "&count=10"
    else
        url = "https://itunes.apple.com/search?term="
            .. url_encode(query)
            .. "&media=podcast&entity=podcast&limit=15"
    end
    -- The fyyd fallback always starts from a later tick (see defer).
    local function fall_back()
        defer(function()
            search_url(query, true)
        end)
    end
    request_with_retry(request_options(url), function(status, body, err)
        if err or status < 200 or status >= 300 then
            if not fallback then
                fall_back()
            else
                search_running = false
                plugin.show_toast(tr("Could not search podcasts. Try again."))
            end
            return
        end
        local ok, data = pcall(plugin.json_decode, body or "")
        body = nil
        collectgarbage("step")
        local results = {}
        local list = ok and type(data) == "table" and (fallback and data.data or data.results) or nil
        if type(list) == "table" then
            for i = 1, math.min(#list, 20) do
                local row = list[i]
                if type(row) == "table" then
                    local u = fallback and row.xmlURL or row.feedUrl
                    local title = fallback and row.title or row.collectionName
                    local author = fallback and row.author or row.artistName
                    if valid_url(u) then
                        results[#results + 1] = {
                            url = u,
                            title = cap(clean_text(cap(type(title) == "string" and title or u, 2048)), 200),
                            author = cap(
                                clean_text(cap(type(author) == "string" and author or "", 2048)),
                                200
                            ),
                        }
                    end
                end
            end
        end
        if #results == 0 and not fallback then
            fall_back()
            return
        end
        search_running = false
        show_search_results(results)
    end, function(start_err)
        if fallback then
            search_running = false
            plugin.show_toast(tr("Could not search podcasts. Try again."))
        else
            fall_back()
        end
    end)
end

local function start_search()
    if search_running then
        return
    end
    local opened = plugin.show_text_input(tr("Search podcasts"), nil, false, function(query)
        query = trim(query)
        if query == "" then
            return
        end
        if search_running then
            return
        end
        search_running = true
        search_url(query, false)
    end)
    if opened == false then
        plugin.show_toast(tr("Text input busy"))
    end
end

local function add_feed_input()
    local opened = plugin.show_text_input(tr("Add feed URL"), "https://", false, function(url)
        url = trim(url)
        if not valid_url(url) then
            plugin.show_toast(tr("Enter an http(s) feed URL"))
            return
        end
        local show, already = add_subscription(url, url)
        if show then
            open_added(show, already)
        end
    end)
    if opened == false then
        plugin.show_toast(tr("Text input busy"))
    end
end

-- Follows the redirect chain one request per tick: HEAD, or a one-byte GET
-- where HEAD is refused. A full request pool retries the same step from the
-- URL already reached.
-- is_cancelled, when given, stops the chain before any further request.
resolve_redirect = function(url, callback, on_handle, is_cancelled)
    local current, hops, busy_tries = url, 0, 0
    local step
    local function start(use_get)
        if is_cancelled and is_cancelled() then
            return
        end
        local opts = request_options(current, use_get and { Range = "bytes=0-0" } or nil)
        opts.method = use_get and "GET" or "HEAD"
        opts.redirect_limit = 0
        opts.max_response_bytes = 4096
        local handle, err = start_request(plugin.http_request, opts, function(code, _, request_err, headers)
            step(code, request_err, headers, use_get)
        end)
        if handle then
            busy_tries = 0
            if on_handle then
                on_handle(handle)
            end
        elseif pool_busy(err) and busy_tries < 30 then
            busy_tries = busy_tries + 1
            defer(function()
                start(use_get)
            end)
        else
            callback(nil, err or "Could not start redirect request")
        end
    end
    step = function(code, request_err, headers, from_get)
        if is_cancelled and is_cancelled() then
            return
        end
        -- A body too big for the probe means this URL serves the file (a
        -- chunked body reports io_error instead); the transfer itself will
        -- report a real network failure.
        if from_get and (request_err == "response_too_large" or request_err == "io_error") then
            callback(current)
            return
        end
        if request_err or code == 405 or code == 403 or code == 501 then
            if from_get then
                callback(nil, request_err or ("HTTP " .. tostring(code)))
            else
                defer(function()
                    start(true)
                end)
            end
            return
        end
        local location
        for k, v in pairs(headers or {}) do
            if k:lower() == "location" then
                location = v
                break
            end
        end
        if code >= 300 and code < 400 and location then
            local next_url = resolve_reference(current, location)
            if not valid_url(next_url) then
                callback(nil, "Invalid redirect URL")
                return
            end
            if current:match("^https://") and next_url:match("^http://") then
                callback(nil, "Refused insecure redirect")
                return
            end
            hops = hops + 1
            if hops > 8 then
                callback(nil, "Too many redirects")
                return
            end
            current = next_url
            defer(function()
                start(false)
            end)
            return
        end
        if (code >= 200 and code < 300) or code == 206 then
            callback(current)
        else
            callback(nil, "HTTP " .. tostring(code))
        end
    end
    if not valid_url(url) then
        callback(nil, "Invalid URL")
    else
        start(false)
    end
end

-- Every file name carries a short hash of the episode identity, so two
-- episodes with the same date and title never share (or delete) one file.
local function download_dest(show, episode)
    local folder = sanitized(show.title, show.key)
    local id = plugin.md5(show.key .. "|" .. episode.guid):sub(1, 8)
    local name = sanitized((episode.date ~= "" and episode.date .. " " or "") .. episode.title, "Episode")
    return ROOT .. "/" .. folder,
        ROOT .. "/" .. folder .. "/" .. name .. " [" .. id .. "]." .. audio_ext(episode.url, episode.mime)
end

-- One download at a time, in two steps: resolve the redirect chain, then
-- start the transfer from a later tick. A request's pool slot is freed only
-- after its callback returns, so starting the next request inside that
-- callback could never use the last free slot.
local function fail_download(item)
    if active_download == item then
        active_download = nil
    end
    item.download_handle = nil
    close_download_progress(item)
    plugin.show_toast(tr("Could not download episode. Try again."))
end

-- A full shared pool is transient: keep the item and try again next tick.
local function busy_retry(item)
    item.retries = (item.retries or 0) + 1
    if item.retries > 30 then
        fail_download(item)
        return
    end
    item.waiting = true
end

local function begin_transfer(item)
    item.waiting = false
    update_download_progress(item, tr("Downloading episode…"), nil)
    local handle, request_err = start_request(
        plugin.download_file_async,
        item.final_url,
        item.dest,
        true,
        function(path, download_err)
            if active_download ~= item then
                return
            end
            active_download = nil
            item.download_handle = nil
            if download_err then
                close_download_progress(item)
                plugin.show_toast(tr("Could not download episode. Try again."))
                return
            end
            local p = episode_progress(item.show, item.episode)
            -- Kept with the file so it stays listed after it leaves the 40-episode catalog.
            p.path, p.position = path, 0
            p.title, p.date, p.epoch = item.episode.title, item.episode.date, item.episode.epoch or 0
            local saved = save_progress()
            close_download_progress(item)
            if saved then
                plugin.show_toast(tr("Episode downloaded"))
            else
                plugin.show_toast(tr("Episode downloaded, but progress could not be saved"))
            end
        end
    )
    item.handle = handle
    item.download_handle = handle
    if not handle then
        if pool_busy(request_err) then
            busy_retry(item)
        else
            fail_download(item)
        end
    end
end

local function begin_resolve(item)
    item.waiting = false
    update_download_progress(item, tr("Resolving episode URL…"), nil)
    resolve_redirect(item.episode.url, function(final_url, err)
        if active_download ~= item then
            return
        end
        if err then
            fail_download(item)
            return
        end
        item.final_url = final_url
        item.waiting = true -- the transfer starts from the next tick
    end, function(handle)
        item.handle = handle
    end, function()
        return active_download ~= item
    end)
end

-- Called from the 1 s tick: advances the active item or starts the next one.
local function service_downloads()
    local item = active_download
    if item then
        if item.waiting then
            if item.final_url then
                begin_transfer(item)
            else
                begin_resolve(item)
            end
        end
        return
    end
    item = table.remove(queue, 1)
    if not item then
        return
    end
    active_download = item
    update_download_progress(item, tr("Preparing episode download…"), nil)
    local dir, dest = download_dest(item.show, item.episode)
    item.dest = dest
    -- A file already there (say, a download whose state was lost) is never
    -- removed by cancel cleanup; the native downloader keeps it too.
    local existing = io.open(dest, "rb")
    item.dest_existed = existing ~= nil
    if existing then
        existing:close()
    end
    if not plugin.mkdir(dir) then
        fail_download(item)
        return
    end
    begin_resolve(item)
end

enqueue_download = function(show, episode)
    if queued(show, episode) or downloaded(show, episode) then
        return
    end
    local downloads = #queue + (active_download and 1 or 0)
    for _ in pairs(path_to_key) do
        downloads = downloads + 1
    end
    -- A history that could not be read whole cannot record new downloads.
    if progress_partial or downloads >= MAX_DOWNLOADS then
        plugin.show_toast(tr("Download limit reached. Delete some downloads first."))
        return
    end
    local item = { show = show, episode = episode, key = progress_key(show, episode) }
    queue[#queue + 1] = item
    if active_download then
        plugin.show_toast(tr("Episode download queued"))
    end
    service_downloads()
end

cancel_download = function(key)
    for i, item in ipairs(queue) do
        if item.key == key then
            table.remove(queue, i)
            close_download_progress(item)
            plugin.show_toast(tr("Download cancelled"))
            return
        end
    end
    if active_download and active_download.key == key then
        if active_download.handle then
            plugin.cancel(active_download.handle)
        end
        active_download.cancelled = true
        active_download.download_handle = nil
        close_download_progress(active_download)
        -- The transfer may have finished just before the cancel; its file is
        -- removed from the tick unless something claims it meanwhile.
        if active_download.dest and not active_download.dest_existed then
            cancelled_files[#cancelled_files + 1] = { path = active_download.dest, ticks = 0 }
        end
        active_download = nil
        plugin.show_toast(tr("Download cancelled"))
    end
end

-- Every downloaded episode, from progress state rather than the catalogs, so
-- older episodes and those of unsubscribed shows stay reachable.
local function downloaded_entries()
    local list = {}
    for k, p in pairs(progress) do
        if p.path and p.path ~= "" then
            local f = io.open(p.path, "rb")
            if f then
                f:close()
                local key, guid = k:match("^([^|]+)|(.*)$")
                if key then
                    local show = show_by_key(key) or { key = key, title = tr("Unsubscribed"), url = "" }
                    local episode
                    local catalog = catalogs[key]
                    for _, e in ipairs(catalog and catalog.items or {}) do
                        if e.guid == guid then
                            episode = e
                            break
                        end
                    end
                    episode = episode
                        or {
                            guid = guid,
                            title = (p.title ~= "" and p.title) or p.path:match("([^/]+)$"),
                            url = "",
                            mime = "",
                            duration = p.duration or 0,
                            date = p.date or "",
                            epoch = p.epoch,
                        }
                    list[#list + 1] = { show = show, episode = episode, path = p.path, progress = p }
                end
            end
        end
    end
    return list
end

local MAX_LIST_ROWS = 500

-- Newest first, unless keep_order (a range already ordered by show).
local function show_download_list(title, list, with_show, keep_order)
    if not keep_order then
        table.sort(list, function(a, b)
            return (a.episode.epoch or 0) > (b.episode.epoch or 0)
        end)
    end
    local labels = {}
    for i = 1, math.min(#list, MAX_LIST_ROWS) do
        local row = list[i]
        local p = row.progress
        local status = p.played and tr("Played")
            or (p.position > 5 and string.format(tr("Resume at %s"), format_duration(p.position)) or "")
        local title = (with_show and (row.show.title .. " · ") or "") .. row.episode.title
        local metadata = {}
        if status ~= "" then metadata[#metadata + 1] = status end
        local date = row.episode.date or ""
        if date ~= "" then metadata[#metadata + 1] = date end
        labels[i] = {
            label = cap(
                title .. (#metadata > 0 and (LIST_WRAP and ("\n" .. table.concat(metadata, " · "))
                    or (" · " .. table.concat(metadata, " · "))) or ""),
                LIST_WRAP and 511 or 159
            ),
            icon = ICON.download,
            wrap = LIST_WRAP,
        }
    end
    plugin.show_list(title, labels, function(index)
        open_episode(list[index].show, list[index].episode)
    end)
end

-- A flat list while it fits one screen; beyond that, one row per show.
local function open_downloads(filter, heading)
    local list = downloaded_entries()
    if filter then
        local selected = {}
        for _, row in ipairs(list) do
            if filter(row.progress) then selected[#selected + 1] = row end
        end
        list = selected
    end
    heading = heading or "Downloads"
    if #list == 0 then
        plugin.show_toast(filter and (heading == "Not played" and tr("No unplayed downloads") or tr("No played downloads"))
            or tr("No downloads yet. Open an episode and choose Download."))
        return
    end
    if #list <= MAX_LIST_ROWS then
        show_download_list(tr(heading) .. " (" .. #list .. ")", list, true)
        return
    end
    -- One group per show; a show with more than a screenful is split by
    -- year, keeping the same screen depth (the list pool is four deep).
    local per_show = {}
    for _, row in ipairs(list) do
        per_show[row.show.key] = (per_show[row.show.key] or 0) + 1
    end
    local by_show, keys = {}, {}
    for _, row in ipairs(list) do
        local key, title = row.show.key, row.show.title
        if per_show[key] > MAX_LIST_ROWS then
            local year = (row.episode.date or ""):match("^(%d%d%d%d)") or tr("Undated")
            key, title = key .. "|" .. year, title .. " " .. year
        end
        if not by_show[key] then
            by_show[key] = { title = title, rows = {} }
            keys[#keys + 1] = key
        end
        table.insert(by_show[key].rows, row)
    end
    -- Any group still over a screenful is cut into numbered parts.
    local split_keys = {}
    for _, key in ipairs(keys) do
        local group = by_show[key]
        if #group.rows <= MAX_LIST_ROWS then
            split_keys[#split_keys + 1] = key
        else
            table.sort(group.rows, function(a, b)
                return (a.episode.epoch or 0) > (b.episode.epoch or 0)
            end)
            for first = 1, #group.rows, MAX_LIST_ROWS do
                local part_key = key .. "#" .. first
                local part =
                    { title = string.format(tr("%s part %d"), group.title, math.floor(first / MAX_LIST_ROWS) + 1), rows = {} }
                for i = first, math.min(first + MAX_LIST_ROWS - 1, #group.rows) do
                    part.rows[#part.rows + 1] = group.rows[i]
                end
                by_show[part_key] = part
                split_keys[#split_keys + 1] = part_key
            end
        end
    end
    keys = split_keys
    table.sort(keys, function(a, b)
        return by_show[a].title:lower() < by_show[b].title:lower()
    end)
    local function show_groups(title, page)
        local labels = {}
        for i, key in ipairs(page) do
            labels[i] = {
                label = cap(by_show[key].title .. " (" .. #by_show[key].rows .. ")", LIST_WRAP and 511 or 159),
                icon = ICON.show,
                wrap = LIST_WRAP,
            }
        end
        plugin.show_list(title, labels, function(index)
            local group = by_show[page[index]]
            show_download_list(group.title, group.rows, false)
        end)
    end
    local title = tr(heading) .. " (" .. #list .. ")"
    if #keys <= MAX_LIST_ROWS then
        show_groups(title, keys)
        return
    end
    -- More shows than one list holds: pick an alphabetical range, which
    -- lists its episodes with their show names. One level instead of two
    -- keeps Home, ranges, episodes and episode actions within the four
    -- list screens.
    local ordered = {}
    for _, key in ipairs(keys) do
        local rows = by_show[key].rows
        table.sort(rows, function(a, b)
            return (a.episode.epoch or 0) > (b.episode.epoch or 0)
        end)
        for _, row in ipairs(rows) do
            ordered[#ordered + 1] = row
        end
    end
    local pages, labels = {}, {}
    for first = 1, #ordered, MAX_LIST_ROWS do
        local page = {}
        for i = first, math.min(first + MAX_LIST_ROWS - 1, #ordered) do
            page[#page + 1] = ordered[i]
        end
        pages[#pages + 1] = page
        labels[#labels + 1] = {
            label = cap(string.format(tr("%s to %s"), page[1].show.title, page[#page].show.title), LIST_WRAP and 511 or 159),
            icon = ICON.download,
            wrap = LIST_WRAP,
        }
    end
    plugin.show_list(title, labels, function(index)
        show_download_list(labels[index].label, pages[index], true, true)
    end)
end

local function open_podcasts_downloads()
    if not (plugin.has_capability and plugin.has_capability("ui.file_manager")) then
        plugin.show_toast(tr("File Manager is not supported on this device"))
        return
    end
    pcall(plugin.mkdir, ROOT)
    local ok, res, err = pcall(plugin.open_file_manager, ROOT)
    if not ok then
        plugin.show_toast(tr("Could not open File Manager"))
        return
    end
    if not res then
        plugin.show_toast(err or tr("Could not open Podcasts in File Manager"))
    end
end

local function open_download_manager(update_existing)
    if type(plugin.show_settings_list) ~= "function" then
        open_downloads()
        return
    end
    local entries = downloaded_entries()
    local played, unfinished = 0, 0
    for _, row in ipairs(entries) do
        if row.progress.played then played = played + 1 else unfinished = unfinished + 1 end
    end
    local armed, deadline = false, 0
    local rows = {
        { type = "row", label = tr("Downloads folder (File Manager)"), icon = ICON.download,
            on_select = open_podcasts_downloads },
        { type = "row", label = string.format(tr("All downloads (%d)"), #entries), icon = ICON.download,
            on_select = function() open_downloads() end },
        { type = "row", label = string.format(tr("Not played (%d)"), unfinished), icon = ICON.play,
            on_select = function() open_downloads(function(p) return not p.played end, "Not played") end },
        { type = "row", label = string.format(tr("Played (%d)"), played), icon = ICON.check,
            on_select = function() open_downloads(function(p) return p.played end, "Played") end },
        { type = "row", label = tr("Delete played downloads"), icon = ICON.remove,
            on_select = function()
                if not armed or os.time() > deadline then
                    armed, deadline = true, os.time() + 8
                    plugin.show_toast(tr("Tap again within 8 seconds to delete played downloads"))
                    return
                end
                armed = false
                local removed, kept = 0, 0
                local current_path = plugin.get_current_track_path()
                -- Re-read at confirmation: never trust a stale page snapshot.
                for _, row in ipairs(downloaded_entries()) do
                    local p, path = row.progress, row.path
                    if p.played then
                        if path == current_path or path:sub(1, #ROOT + 1) ~= ROOT .. "/"
                            or not os.remove(path) then
                            kept = kept + 1
                        else
                            path_to_key[path] = nil
                            p.path, p.position = "", 0
                            removed = removed + 1
                        end
                    end
                end
                local saved = save_progress()
                open_download_manager(true)
                plugin.show_toast(saved
                    and string.format(tr("Deleted %d; kept %d"), removed, kept)
                    or string.format(tr("Deleted %d; kept %d; progress could not be saved"), removed, kept))
            end },
    }
    plugin.show_settings_list(tr("Manage downloads"), rows, update_existing and { update = true } or nil)
end

local function continue_episode(entries)
    local best, best_time
    for _, row in ipairs(entries) do
        local p = row.progress
        if p.position > 5 and not p.played and (not best_time or p.last_played > best_time) then
            best = { show = row.show, episode = row.episode, path = row.path, position = p.position }
            best_time = p.last_played
        end
    end
    return best
end

local function open_manage_subscriptions()
    plugin.show_list(tr("Manage subscriptions"), {
        { label = tr("Add feed URL"), icon = ICON.link },
        { label = tr("Import OPML"), icon = ICON.link },
        { label = tr("Export subscriptions"), icon = ICON.check },
    }, function(index)
        if index == 1 then
            add_feed_input()
        elseif index == 2 then
            pick_import()
        elseif save_subscriptions() then
            plugin.show_toast(tr("Subscriptions exported"))
        else
            plugin.show_toast(tr("Could not export subscriptions. Try again."))
        end
    end)
end

local function open_home()
    local rows, actions = {}, {}
    local entries = downloaded_entries()
    local cont = continue_episode(entries)
    if cont then
        rows[#rows + 1] = {
            label = cap(string.format(tr("Continue: %s"), cont.episode.title), LIST_WRAP and 511 or 159),
            icon = ICON.play,
            wrap = LIST_WRAP,
        }
        actions[#actions + 1] = function()
            -- track_started resumes from the position saved at that moment,
            -- not the one this screen was built with.
            pending_seek = nil
            plugin.play_file(cont.path)
        end
    end
    rows[#rows + 1] = { label = tr("Downloads (File Manager)"), icon = ICON.download }
    actions[#actions + 1] = open_podcasts_downloads
    if #subscriptions > 0 then
        sort_subscriptions()
        -- New counts come from progress state, so Home never loads every catalog.
        local new_counts = {}
        for k, p in pairs(progress) do
            if p.new then
                local key = k:match("^([^|]+)|")
                if key then
                    new_counts[key] = (new_counts[key] or 0) + 1
                end
            end
        end
        for _, show in ipairs(subscriptions) do
            local new_count = new_counts[show.key] or 0
            local new_label = new_count == 1 and tr("1 new episode") or string.format(tr("%d new episodes"), new_count)
            rows[#rows + 1] = {
                label = cap(
                    show.title .. (new_count > 0 and (LIST_WRAP and ("\n" .. new_label)
                        or (" (" .. string.format(tr("%d new"), new_count) .. ")")) or ""),
                    LIST_WRAP and 511 or 159
                ),
                icon = ICON.show,
                wrap = LIST_WRAP,
            }
            actions[#actions + 1] = function()
                open_show(show)
            end
        end
    end
    rows[#rows + 1] = { label = tr("Discover podcasts"), icon = ICON.search }
    actions[#actions + 1] = start_search
    rows[#rows + 1] = { label = tr("Manage downloads"), icon = ICON.download }
    actions[#actions + 1] = open_download_manager
    rows[#rows + 1] = { label = tr("Manage subscriptions"), icon = ICON.manage }
    actions[#actions + 1] = open_manage_subscriptions
    rows[#rows + 1] = { label = tr("Settings"), icon = ICON.manage }
    actions[#actions + 1] = open_settings
    plugin.show_list(tr("Podcasts"), rows, function(index)
        actions[index]()
    end)
end

local function save_playback(force)
    if not force and (not plugin.is_playing() or plugin.is_paused()) then
        return
    end
    local path = plugin.get_current_track_path()
    local k = path and path_to_key[path]
    if not k then
        return
    end
    -- Until the resume seek lands, the reported position is not ours to save.
    local position, duration = plugin.get_position(), plugin.get_duration()
    if pending_seek and pending_seek.path == path then
        if not pending_seek.failed or position < pending_seek.position then return end
        -- Listening forward past the saved point can safely advance progress.
        pending_seek = nil
    end
    if not force and math.abs(position - last_saved_position) < 1 then
        return
    end
    local p = progress[k]
    p.position, p.duration, p.last_played = position, duration, os.time()
    if duration > 0 and (position >= duration - 30 or position / duration >= 0.95) then
        p.played = true
        p.position = 0
    end
    last_saved_position = position
    save_progress()
end

load_subscriptions()
sort_subscriptions()
load_progress()
read_settings()
speed_retry_pending = true
if has_required_capabilities then
    plugin.mkdir(ROOT)
    plugin.mkdir(CATALOG)
    local ignore = io.open(ROOT .. "/database.ignore", "r")
    if not ignore then
        local f = io.open(ROOT .. "/database.ignore", "w")
        if f then
            f:close()
        end
    else
        ignore:close()
    end
end

-- The track can still be opening when track_started fires, and a seek then
-- is silently dropped, so a resume seek is retried on the 1 s tick until the
-- position shows it took effect (or it is given up on).
local function service_pending_seek()
    if not pending_seek then
        return
    end
    if pending_seek.failed then return end
    pending_seek.tries = pending_seek.tries + 1
    if pending_seek.tries > 15 then
        -- Keep the guard: saving an unconfirmed engine position here would
        -- replace the user's saved resume point with the beginning of the file.
        pending_seek.failed = true
        plugin.show_toast(tr("Resume did not complete. Retry Resume from the episode."))
        return
    end
    if plugin.get_current_track_path() ~= pending_seek.path or plugin.get_duration() <= 0 then
        return
    end
    -- Only a position read after our own seek counts, and one far past the
    -- target is the previous track's, still being reported.
    local position = plugin.get_position()
    if
        pending_seek.seeked
        and position >= pending_seek.position - 3
        and position <= pending_seek.position + 30
    then
        pending_seek = nil
        last_saved_position = -1
        return
    end
    plugin.seek(pending_seek.position)
    pending_seek.seeked = true
end

plugin.on("track_started", function()
    stream_generation = stream_generation + 1
    last_saved_position = -1
    speed_retry_pending = true
    local path = plugin.get_current_track_path()
    if is_podcast_path(path) then
        apply_reading_room(true)
    else
        restore_reading_room()
    end
    local k = path and path_to_key[path]
    if not k and path and path:sub(1, #ROOT + 1) == ROOT .. "/" then
        for key, p in pairs(progress) do
            if p.path == path then
                path_to_key[path] = key
                k = key
                break
            end
        end
    end
    if pending_seek and pending_seek.path ~= path then
        pending_seek = nil
    end
    if k and not pending_seek then
        local p = progress[k]
        if p and p.position > 5 and not p.played then
            pending_seek = { path = path, position = p.position, tries = 0 }
        end
    end
    -- No save here: the position and duration can still be the previous
    -- track's. The tick saves once the new one is really playing.
    service_pending_seek()
    if k and current_download_path() == path then
        if pending_seek and not pending_seek.failed and pending_seek.path == path then
            speed_retry_pending = true
        else
            speed_retry_pending = not apply_speed(playback_speed)
        end
    end
end)
plugin.on("paused", function()
    save_playback(true)
end)
plugin.on("stopped", function()
    save_playback(true)
end)
local ticks = 0
interval_handle = plugin.set_interval(1, function()
    service_pending_seek()
    if speed_retry_pending and (not pending_seek or pending_seek.failed) then
        local path = current_download_path()
        if path and speed_supported() then
            speed_retry_pending = not apply_speed(playback_speed)
        end
    end
    run_deferred()
    service_downloads()
    local download = active_download
    if download and download.download_handle and plugin.has_capability("network.http.download_progress") then
        local progress = plugin.get_download_progress(download.download_handle)
        if type(progress) == "table" then
            local total = tonumber(progress.total) or 0
            local downloaded = tonumber(progress.downloaded) or 0
            local fraction = total > 0 and math.max(0, math.min(1, downloaded / total)) or nil
            update_download_progress(download, tr("Downloading episode…"), fraction)
        end
    end
    for i = #cancelled_files, 1, -1 do
        local entry = cancelled_files[i]
        entry.ticks = entry.ticks + 1
        local reclaimed = path_to_key[entry.path] or (active_download and active_download.dest == entry.path)
        if reclaimed or entry.ticks > 30 then
            table.remove(cancelled_files, i)
        elseif entry.ticks >= 3 then
            local f = io.open(entry.path, "rb")
            if f then
                f:close()
                os.remove(entry.path)
                table.remove(cancelled_files, i)
            end
        end
    end
    ticks = ticks + 1
    if ticks % 10 == 0 then
        save_playback(false)
        if progress_dirty then
            save_progress()
        end
    end
end)

plugin.register_stream_media_tile(tr("Podcasts"), function()
    if not has_required_capabilities then
        plugin.show_toast(tr("Podcasts needs a newer player build"))
        return
    end
    open_home()
end, "stream_media/podcasts_row.png")

if rawget(_G, "COMPAS_PLUGIN_TEST") then
    _G.COMPAS_PLUGIN_UNDER_TEST = {
        enqueue_download = enqueue_download,
        active_download = function() return active_download end,
        queue = queue,
    }
end
