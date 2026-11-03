local PLUGIN_VERSION = "1.1.0"
local WISHLIST_FORMAT_VERSION = 1

plugin.define({
    id = "com.buymyhubs.discover",
    name = "Discover",
    version = PLUGIN_VERSION,
    api_min = 19
})

local T = {
    de = {
        ["couldn't encode JSON"] = "JSON konnte nicht kodiert werden",
        ["plugin storage is full or unavailable"] = "Plugin-Speicher voll oder nicht verfügbar",
        ["No internet connection -- check Wi-Fi and try again"] = "Keine Internetverbindung -- WLAN prüfen und erneut versuchen",
        ["Request failed (%s)"] = "Anfrage fehlgeschlagen (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover: Server ausgelastet, neuer Versuch (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "Server ist gerade ausgelastet -- versuche es in einer Minute erneut",
        ["request failed (HTTP %s)"] = "Anfrage fehlgeschlagen (HTTP %s)",
        ["Include Live albums"] = "Live-Alben einbeziehen",
        ["Include Demos"] = "Demos einbeziehen",
        ["Include Mixtapes"] = "Mixtapes einbeziehen",
        ["Include Compilations"] = "Kompilationen einbeziehen",
        ["Include Soundtracks"] = "Soundtracks einbeziehen",
        ["Include Remixes"] = "Remixe einbeziehen",
        ["Include DJ mixes"] = "DJ-Mixe einbeziehen",
        ["Include Interviews"] = "Interviews einbeziehen",
        ["Include Spoken word"] = "Spoken Word einbeziehen",
        ["Include Audiobooks"] = "Hörbücher einbeziehen",
        ["Include Audio dramas"] = "Hörspiele einbeziehen",
        ["Include Field recordings"] = "Feldaufnahmen einbeziehen",
        ["Include Broadcasts"] = "Sendungen einbeziehen",
        ["SD card not available"] = "SD-Karte nicht verfügbar",
        ["no SD copy found"] = "keine SD-Kopie gefunden",
        ["SD copy is from a newer Discover -- update the plugin"] = "SD-Kopie stammt von einem neueren Discover -- aktualisiere das Plugin",
        ["SD copy can't be read"] = "SD-Kopie kann nicht gelesen werden",
        ["couldn't write the SD copy"] = "SD-Kopie konnte nicht geschrieben werden",
        ["couldn't finish the SD copy"] = "SD-Kopie konnte nicht abgeschlossen werden",
        ["wish list is invalid or has reached its 1000-item limit"] = "Wunschliste ist ungültig oder hat das Limit von 1000 Einträgen erreicht",
        ["Discover: wish list restored from your SD copy"] = "Discover: Wunschliste aus deiner SD-Kopie wiederhergestellt",
        ["Discover: %s"] = "Discover: %s",
        ["Discover: wish list merged with your SD copy"] = "Discover: Wunschliste mit deiner SD-Kopie zusammengeführt",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover: Wunschliste aus SD-Kopie aktualisiert (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "Künstler- und Albumnamen dürfen höchstens 1024 Bytes lang sein",
        ["wish list ID is too long"] = "Wunschlisten-ID ist zu lang",
        ["wish list can contain up to 1000 items"] = "Wunschliste kann bis zu 1000 Einträge enthalten",
        ["Discover: couldn't save wish list (%s)"] = "Discover: Wunschliste konnte nicht gespeichert werden (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover: Trefferbestätigungen konnten nicht gespeichert werden (%s)",
        ["Discover: removed %d item you already have"] = "Discover: %d Eintrag entfernt, den du bereits hast",
        ["Discover: removed %d items you already have"] = "Discover: %d Einträge entfernt, die du bereits hast",
        ["Discover: couldn't save the release feed"] = "Discover: Neuheiten-Feed konnte nicht gespeichert werden",
        ["Discover: couldn't save the release feed (%s)"] = "Discover: Neuheiten-Feed konnte nicht gespeichert werden (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover: %d Veröffentlichungen deiner Künstler (%d bevorstehend) -- öffne Neu & Bevorstehend",
        ["couldn't read the releases feed"] = "Neuheiten-Feed konnte nicht gelesen werden",
        ["Discover: checking releases (%d of %d)..."] = "Discover: prüfe Veröffentlichungen (%d von %d)...",
        ["Discover: already checking for new releases"] = "Discover: prüft bereits auf neue Veröffentlichungen",
        ["Discover: already up to date this week"] = "Discover: diese Woche bereits aktuell",
        ["Discover: couldn't start scanning (%s)"] = "Discover: Suche konnte nicht gestartet werden (%s)",
        ["Discover: checking for new releases..."] = "Discover: prüfe auf neue Veröffentlichungen...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover: prüfe auf neue Veröffentlichungen (erster Lauf: %d Anfragen, einige Minuten)...",
        ["Albums"] = "Alben",
        ["EPs"] = "EPs",
        ["Singles"] = "Singles",
        ["albums"] = "Alben",
        ["eps"] = "EPs",
        ["singles"] = "Singles",
        ["couldn't read the response"] = "Antwort konnte nicht gelesen werden",
        ["On Wish List"] = "Auf der Wunschliste",
        ["Added to wish list"] = "Zur Wunschliste hinzugefügt",
        ["Removed from wish list"] = "Von der Wunschliste entfernt",
        ["Artist: %s"] = "Künstler: %s",
        ["Type: %s"] = "Typ: %s",
        ["In your library"] = "In deiner Bibliothek",
        ["Released: %s"] = "Veröffentlicht: %s",
        ["Rating: %.1f (%d votes)"] = "Bewertung: %.1f (%d Stimmen)",
        ["Genres: %s"] = "Genres: %s",
        ["Discover: loading %s..."] = "Discover: lade %s...",
        ["Discover: %s (showing basic info)"] = "Discover: %s (zeige Basisinfos)",
        ["Discover: loading %s by %s..."] = "Discover: lade %s von %s...",
        ["Discover: %d %s hidden by your Options"] = "Discover: %d %s durch deine Optionen ausgeblendet",
        ["Discover: no %s found for %s"] = "Discover: keine %s für %s gefunden",
        ["Discover: finding artists similar to %s..."] = "Discover: suche ähnliche Künstler wie %s...",
        ["Discover: no recommendations found for %s"] = "Discover: keine Empfehlungen für %s gefunden",
        ["Similar to %s"] = "Ähnlich wie %s",
        ["present"] = "heute",
        ["Find Similar Artists"] = "Ähnliche Künstler finden",
        ["artist name is too long to search"] = "Künstlername ist zu lang für die Suche",
        ["couldn't identify \"%s\" on MusicBrainz"] = "\"%s\" konnte auf MusicBrainz nicht gefunden werden",
        ["Discover: looking up %s..."] = "Discover: schlage %s nach...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover: Suchtext darf höchstens 512 Bytes lang sein",
        ["Discover: searching artists..."] = "Discover: suche Künstler...",
        ["Discover: no artists found for \"%s\""] = "Discover: keine Künstler für \"%s\" gefunden",
        ["Artist Results"] = "Künstler-Ergebnisse",
        ["Discover: searching albums..."] = "Discover: suche Alben...",
        ["Discover: no albums found for \"%s\""] = "Discover: keine Alben für \"%s\" gefunden",
        ["Album Results"] = "Album-Ergebnisse",
        ["Search artist"] = "Künstler suchen",
        ["Search album"] = "Album suchen",
        ["Discover: no library artists found"] = "Discover: keine Künstler in der Bibliothek gefunden",
        ["My Artists"] = "Meine Künstler",
        ["Discover: no upcoming releases to show"] = "Discover: keine bevorstehenden Veröffentlichungen",
        ["Discover: no released releases to show"] = "Discover: keine erschienenen Veröffentlichungen",
        ["Upcoming"] = "Bevorstehend",
        ["Released (last %d days)"] = "Erschienen (letzte %d Tage)",
        ["Checking releases (%d of %d)..."] = "Prüfe Veröffentlichungen (%d von %d)...",
        ["Last checked %s -- tap to check again"] = "Zuletzt geprüft %s -- tippen zum erneuten Prüfen",
        ["Check for new releases now"] = "Jetzt auf neue Veröffentlichungen prüfen",
        ["Upcoming, next %d months (%d)"] = "Bevorstehend, nächste %d Monate (%d)",
        ["Released, last %d days (%d)"] = "Erschienen, letzte %d Tage (%d)",
        ["%d more hidden by your Options"] = "%d weitere durch deine Optionen ausgeblendet",
        ["No matches (scanned %d releases against %d of your artists)"] = "Keine Treffer (%d Veröffentlichungen mit %d deiner Künstler abgeglichen)",
        ["New & Upcoming"] = "Neu & Bevorstehend",
        ["Artist"] = "Künstler",
        ["Album"] = "Album",
        ["Already on your wish list"] = "Bereits auf deiner Wunschliste",
        ["%d possible match to confirm"] = "%d möglicher Treffer zu bestätigen",
        ["%d possible matches to confirm"] = "%d mögliche Treffer zu bestätigen",
        ["Wish List"] = "Wunschliste",
        ["Nothing here yet"] = "Noch nichts hier",
        ["Discover: couldn't save confirmations (%s)"] = "Discover: Bestätigungen konnten nicht gespeichert werden (%s)",
        ["Nothing to confirm"] = "Nichts zu bestätigen",
        ["Confirm Matches"] = "Treffer bestätigen",
        ["waiting for the SD card"] = "warte auf SD-Karte",
        ["changes not copied yet"] = "Änderungen noch nicht kopiert",
        ["not created yet"] = "noch nicht erstellt",
        ["in sync"] = "synchron",
        ["Restore wish list"] = "Wunschliste wiederherstellen",
        ["Replace my wish list with the SD copy (%d album)"] = "Meine Wunschliste durch SD-Kopie ersetzen (%d Album)",
        ["Replace my wish list with the SD copy (%d albums)"] = "Meine Wunschliste durch SD-Kopie ersetzen (%d Alben)",
        ["Cancel"] = "Abbrechen",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover: aktuelle Wunschliste konnte nicht gesichert werden (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover: Wunschliste konnte nicht wiederhergestellt werden (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover: Liste wiederhergestellt, aber SD-Sync-Status konnte nicht aktualisiert werden",
        ["Discover: restored %d from the SD copy"] = "Discover: %d aus der SD-Kopie wiederhergestellt",
        ["Discover: couldn't save Options (%s)"] = "Discover: Optionen konnten nicht gespeichert werden (%s)",
        ["Wish list SD copy: %s"] = "Wunschlisten-SD-Kopie: %s",
        ["Back up wish list to SD now"] = "Wunschliste jetzt auf SD sichern",
        ["Discover: wish list copied to the SD card"] = "Discover: Wunschliste auf SD-Karte kopiert",
        ["Restore wish list from SD copy"] = "Wunschliste aus SD-Kopie wiederherstellen",
        ["Options"] = "Optionen",
        ["Discover"] = "Entdecken",
        ["Search Artist"] = "Künstler suchen",
        ["Search Album"] = "Album suchen",
        ["Add By Hand"] = "Manuell hinzufügen",
    },
    es = {
        ["couldn't encode JSON"] = "no se pudo codificar el JSON",
        ["plugin storage is full or unavailable"] = "el almacenamiento del plugin está lleno o no disponible",
        ["No internet connection -- check Wi-Fi and try again"] = "Sin conexión a internet -- comprueba el Wi-Fi e inténtalo de nuevo",
        ["Request failed (%s)"] = "Error en la solicitud (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover: servidor ocupado, reintentando (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "el servidor está ocupado ahora mismo -- inténtalo de nuevo en un minuto",
        ["request failed (HTTP %s)"] = "falló la solicitud (HTTP %s)",
        ["Include Live albums"] = "Incluir álbumes en vivo",
        ["Include Demos"] = "Incluir maquetas",
        ["Include Mixtapes"] = "Incluir mixtapes",
        ["Include Compilations"] = "Incluir recopilatorios",
        ["Include Soundtracks"] = "Incluir bandas sonoras",
        ["Include Remixes"] = "Incluir remezclas",
        ["Include DJ mixes"] = "Incluir mezclas de DJ",
        ["Include Interviews"] = "Incluir entrevistas",
        ["Include Spoken word"] = "Incluir palabra hablada",
        ["Include Audiobooks"] = "Incluir audiolibros",
        ["Include Audio dramas"] = "Incluir dramas sonoros",
        ["Include Field recordings"] = "Incluir grabaciones de campo",
        ["Include Broadcasts"] = "Incluir emisiones",
        ["SD card not available"] = "tarjeta SD no disponible",
        ["no SD copy found"] = "no se encontró copia en la SD",
        ["SD copy is from a newer Discover -- update the plugin"] = "la copia SD es de un Discover más reciente -- actualiza el plugin",
        ["SD copy can't be read"] = "no se puede leer la copia SD",
        ["couldn't write the SD copy"] = "no se pudo escribir la copia SD",
        ["couldn't finish the SD copy"] = "no se pudo completar la copia SD",
        ["wish list is invalid or has reached its 1000-item limit"] = "la lista de deseos no es válida o alcanzó el límite de 1000 elementos",
        ["Discover: wish list restored from your SD copy"] = "Discover: lista de deseos restaurada desde tu copia SD",
        ["Discover: %s"] = "Discover: %s",
        ["Discover: wish list merged with your SD copy"] = "Discover: lista de deseos combinada con tu copia SD",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover: lista de deseos actualizada desde la copia SD (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "los nombres de artista y álbum deben tener 1024 bytes o menos",
        ["wish list ID is too long"] = "el ID de la lista de deseos es demasiado largo",
        ["wish list can contain up to 1000 items"] = "la lista de deseos puede contener hasta 1000 elementos",
        ["Discover: couldn't save wish list (%s)"] = "Discover: no se pudo guardar la lista de deseos (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover: no se pudieron guardar las confirmaciones (%s)",
        ["Discover: removed %d item you already have"] = "Discover: se eliminó %d elemento que ya tienes",
        ["Discover: removed %d items you already have"] = "Discover: se eliminaron %d elementos que ya tienes",
        ["Discover: couldn't save the release feed"] = "Discover: no se pudo guardar el canal de lanzamientos",
        ["Discover: couldn't save the release feed (%s)"] = "Discover: no se pudo guardar el canal de lanzamientos (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover: %d lanzamientos de tus artistas (%d próximos) -- abre Nuevos y próximos",
        ["couldn't read the releases feed"] = "no se pudo leer el canal de lanzamientos",
        ["Discover: checking releases (%d of %d)..."] = "Discover: comprobando lanzamientos (%d de %d)...",
        ["Discover: already checking for new releases"] = "Discover: ya se están buscando nuevos lanzamientos",
        ["Discover: already up to date this week"] = "Discover: ya está al día esta semana",
        ["Discover: couldn't start scanning (%s)"] = "Discover: no se pudo iniciar el análisis (%s)",
        ["Discover: checking for new releases..."] = "Discover: buscando nuevos lanzamientos...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover: buscando nuevos lanzamientos (primera vez: %d solicitudes, unos minutos)...",
        ["Albums"] = "Álbumes",
        ["EPs"] = "EPs",
        ["Singles"] = "Sencillos",
        ["albums"] = "álbumes",
        ["eps"] = "EPs",
        ["singles"] = "sencillos",
        ["couldn't read the response"] = "no se pudo leer la respuesta",
        ["On Wish List"] = "En la lista de deseos",
        ["Added to wish list"] = "Añadido a la lista de deseos",
        ["Removed from wish list"] = "Eliminado de la lista de deseos",
        ["Artist: %s"] = "Artista: %s",
        ["Type: %s"] = "Tipo: %s",
        ["In your library"] = "En tu biblioteca",
        ["Released: %s"] = "Publicado: %s",
        ["Rating: %.1f (%d votes)"] = "Valoración: %.1f (%d votos)",
        ["Genres: %s"] = "Géneros: %s",
        ["Discover: loading %s..."] = "Discover: cargando %s...",
        ["Discover: %s (showing basic info)"] = "Discover: %s (mostrando información básica)",
        ["Discover: loading %s by %s..."] = "Discover: cargando %s de %s...",
        ["Discover: %d %s hidden by your Options"] = "Discover: %d %s ocultos por tus Opciones",
        ["Discover: no %s found for %s"] = "Discover: no se encontraron %s de %s",
        ["Discover: finding artists similar to %s..."] = "Discover: buscando artistas similares a %s...",
        ["Discover: no recommendations found for %s"] = "Discover: no se encontraron recomendaciones para %s",
        ["Similar to %s"] = "Similares a %s",
        ["present"] = "presente",
        ["Find Similar Artists"] = "Buscar artistas similares",
        ["artist name is too long to search"] = "el nombre del artista es demasiado largo para buscar",
        ["couldn't identify \"%s\" on MusicBrainz"] = "no se pudo identificar \"%s\" en MusicBrainz",
        ["Discover: looking up %s..."] = "Discover: buscando %s...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover: el texto de búsqueda debe tener 512 bytes o menos",
        ["Discover: searching artists..."] = "Discover: buscando artistas...",
        ["Discover: no artists found for \"%s\""] = "Discover: no se encontraron artistas para \"%s\"",
        ["Artist Results"] = "Resultados de artistas",
        ["Discover: searching albums..."] = "Discover: buscando álbumes...",
        ["Discover: no albums found for \"%s\""] = "Discover: no se encontraron álbumes para \"%s\"",
        ["Album Results"] = "Resultados de álbumes",
        ["Search artist"] = "Buscar artista",
        ["Search album"] = "Buscar álbum",
        ["Discover: no library artists found"] = "Discover: no se encontraron artistas en la biblioteca",
        ["My Artists"] = "Mis artistas",
        ["Discover: no upcoming releases to show"] = "Discover: no hay próximos lanzamientos para mostrar",
        ["Discover: no released releases to show"] = "Discover: no hay lanzamientos recientes para mostrar",
        ["Upcoming"] = "Próximos",
        ["Released (last %d days)"] = "Publicados (últimos %d días)",
        ["Checking releases (%d of %d)..."] = "Comprobando lanzamientos (%d de %d)...",
        ["Last checked %s -- tap to check again"] = "Última comprobación %s -- toca para comprobar de nuevo",
        ["Check for new releases now"] = "Comprobar nuevos lanzamientos ahora",
        ["Upcoming, next %d months (%d)"] = "Próximos, siguientes %d meses (%d)",
        ["Released, last %d days (%d)"] = "Publicados, últimos %d días (%d)",
        ["%d more hidden by your Options"] = "%d más ocultos por tus Opciones",
        ["No matches (scanned %d releases against %d of your artists)"] = "Sin coincidencias (%d lanzamientos analizados frente a %d de tus artistas)",
        ["New & Upcoming"] = "Nuevos y próximos",
        ["Artist"] = "Artista",
        ["Album"] = "Álbum",
        ["Already on your wish list"] = "Ya está en tu lista de deseos",
        ["%d possible match to confirm"] = "%d posible coincidencia por confirmar",
        ["%d possible matches to confirm"] = "%d posibles coincidencias por confirmar",
        ["Wish List"] = "Lista de deseos",
        ["Nothing here yet"] = "Aún no hay nada aquí",
        ["Discover: couldn't save confirmations (%s)"] = "Discover: no se pudieron guardar las confirmaciones (%s)",
        ["Nothing to confirm"] = "Nada que confirmar",
        ["Confirm Matches"] = "Confirmar coincidencias",
        ["waiting for the SD card"] = "esperando la tarjeta SD",
        ["changes not copied yet"] = "cambios aún no copiados",
        ["not created yet"] = "aún no creada",
        ["in sync"] = "sincronizada",
        ["Restore wish list"] = "Restaurar lista de deseos",
        ["Replace my wish list with the SD copy (%d album)"] = "Reemplazar mi lista de deseos con la copia SD (%d álbum)",
        ["Replace my wish list with the SD copy (%d albums)"] = "Reemplazar mi lista de deseos con la copia SD (%d álbumes)",
        ["Cancel"] = "Cancelar",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover: no se pudo respaldar la lista de deseos actual (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover: no se pudo restaurar la lista de deseos (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover: lista restaurada, pero no se pudo actualizar el estado de sincronización SD",
        ["Discover: restored %d from the SD copy"] = "Discover: se restauraron %d desde la copia SD",
        ["Discover: couldn't save Options (%s)"] = "Discover: no se pudieron guardar las Opciones (%s)",
        ["Wish list SD copy: %s"] = "Copia SD de la lista de deseos: %s",
        ["Back up wish list to SD now"] = "Respaldar lista de deseos en la SD ahora",
        ["Discover: wish list copied to the SD card"] = "Discover: lista de deseos copiada a la tarjeta SD",
        ["Restore wish list from SD copy"] = "Restaurar lista de deseos desde la copia SD",
        ["Options"] = "Opciones",
        ["Discover"] = "Descubrir",
        ["Search Artist"] = "Buscar artista",
        ["Search Album"] = "Buscar álbum",
        ["Add By Hand"] = "Añadir manualmente",
    },
    fi = {
        ["couldn't encode JSON"] = "JSON-koodaus epäonnistui",
        ["plugin storage is full or unavailable"] = "liitännäisen tallennustila on täynnä tai poissa käytöstä",
        ["No internet connection -- check Wi-Fi and try again"] = "Ei internetyhteyttä -- tarkista Wi-Fi ja yritä uudelleen",
        ["Request failed (%s)"] = "Pyyntö epäonnistui (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover: palvelin varattu, yritetään uudelleen (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "palvelin on juuri nyt varattu -- yritä hetken kuluttua uudelleen",
        ["request failed (HTTP %s)"] = "pyyntö epäonnistui (HTTP %s)",
        ["Include Live albums"] = "Sisällytä live-albumit",
        ["Include Demos"] = "Sisällytä demot",
        ["Include Mixtapes"] = "Sisällytä mixtapet",
        ["Include Compilations"] = "Sisällytä kokoelmat",
        ["Include Soundtracks"] = "Sisällytä ääniraidat",
        ["Include Remixes"] = "Sisällytä remixit",
        ["Include DJ mixes"] = "Sisällytä DJ-miksaukset",
        ["Include Interviews"] = "Sisällytä haastattelut",
        ["Include Spoken word"] = "Sisällytä puheäänitteet",
        ["Include Audiobooks"] = "Sisällytä äänikirjat",
        ["Include Audio dramas"] = "Sisällytä kuunnelmat",
        ["Include Field recordings"] = "Sisällytä kenttääänitykset",
        ["Include Broadcasts"] = "Sisällytä lähetykset",
        ["SD card not available"] = "SD-kortti ei ole käytettävissä",
        ["no SD copy found"] = "SD-kopiota ei löytynyt",
        ["SD copy is from a newer Discover -- update the plugin"] = "SD-kopio on uudemmasta Discover-versiosta -- päivitä liitännäinen",
        ["SD copy can't be read"] = "SD-kopiota ei voi lukea",
        ["couldn't write the SD copy"] = "SD-kopion kirjoitus epäonnistui",
        ["couldn't finish the SD copy"] = "SD-kopion viimeistely epäonnistui",
        ["wish list is invalid or has reached its 1000-item limit"] = "toivelista on virheellinen tai täynnä (1000 kohdetta)",
        ["Discover: wish list restored from your SD copy"] = "Discover: toivelista palautettu SD-kopiosta",
        ["Discover: %s"] = "Discover: %s",
        ["Discover: wish list merged with your SD copy"] = "Discover: toivelista yhdistetty SD-kopioon",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover: toivelista päivitetty SD-kopiosta (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "artistin ja albumin nimen on oltava enintään 1024 tavua",
        ["wish list ID is too long"] = "toivelistan tunniste on liian pitkä",
        ["wish list can contain up to 1000 items"] = "toivelistalla voi olla enintään 1000 kohdetta",
        ["Discover: couldn't save wish list (%s)"] = "Discover: toivelistan tallennus epäonnistui (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover: vahvistusten tallennus epäonnistui (%s)",
        ["Discover: removed %d item you already have"] = "Discover: poistettiin %d kohde, joka sinulla jo on",
        ["Discover: removed %d items you already have"] = "Discover: poistettiin %d kohdetta, jotka sinulla jo on",
        ["Discover: couldn't save the release feed"] = "Discover: julkaisusyötteen tallennus epäonnistui",
        ["Discover: couldn't save the release feed (%s)"] = "Discover: julkaisusyötteen tallennus epäonnistui (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover: %d julkaisua artisteilta (%d tulossa) -- avaa Uudet ja tulevat",
        ["couldn't read the releases feed"] = "julkaisusyötteen lukeminen epäonnistui",
        ["Discover: checking releases (%d of %d)..."] = "Discover: tarkistetaan julkaisuja (%d/%d)...",
        ["Discover: already checking for new releases"] = "Discover: uusia julkaisuja tarkistetaan jo",
        ["Discover: already up to date this week"] = "Discover: jo ajan tasalla tällä viikolla",
        ["Discover: couldn't start scanning (%s)"] = "Discover: tarkistusta ei voitu aloittaa (%s)",
        ["Discover: checking for new releases..."] = "Discover: tarkistetaan uusia julkaisuja...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover: tarkistetaan uusia julkaisuja (ensimmäinen kerta: %d pyyntöä, muutama minuutti)...",
        ["Albums"] = "Albumit",
        ["EPs"] = "EP:t",
        ["Singles"] = "Singlet",
        ["albums"] = "albumia",
        ["eps"] = "EP:tä",
        ["singles"] = "singleä",
        ["couldn't read the response"] = "vastausta ei voitu lukea",
        ["On Wish List"] = "Toivelistalla",
        ["Added to wish list"] = "Lisätty toivelistalle",
        ["Removed from wish list"] = "Poistettu toivelistalta",
        ["Artist: %s"] = "Artisti: %s",
        ["Type: %s"] = "Tyyppi: %s",
        ["In your library"] = "Kirjastossasi",
        ["Released: %s"] = "Julkaistu: %s",
        ["Rating: %.1f (%d votes)"] = "Arvosana: %.1f (%d ääntä)",
        ["Genres: %s"] = "Tyylilajit: %s",
        ["Discover: loading %s..."] = "Discover: ladataan %s...",
        ["Discover: %s (showing basic info)"] = "Discover: %s (näytetään perustiedot)",
        ["Discover: loading %s by %s..."] = "Discover: ladataan %s artistilta %s...",
        ["Discover: %d %s hidden by your Options"] = "Discover: %d %s piilotettu valinnoillasi",
        ["Discover: no %s found for %s"] = "Discover: ei %s artistille %s",
        ["Discover: finding artists similar to %s..."] = "Discover: etsitään samankaltaisia artisteja kuin %s...",
        ["Discover: no recommendations found for %s"] = "Discover: suosituksia ei löytynyt artistille %s",
        ["Similar to %s"] = "Samankaltainen kuin %s",
        ["present"] = "nykyhetki",
        ["Find Similar Artists"] = "Etsi samankaltaisia artisteja",
        ["artist name is too long to search"] = "artistin nimi on liian pitkä haettavaksi",
        ["couldn't identify \"%s\" on MusicBrainz"] = "kohdetta \"%s\" ei tunnistettu MusicBrainzissa",
        ["Discover: looking up %s..."] = "Discover: haetaan %s...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover: hakuteksti saa olla enintään 512 tavua",
        ["Discover: searching artists..."] = "Discover: haetaan artisteja...",
        ["Discover: no artists found for \"%s\""] = "Discover: artisteja ei löytynyt haulla \"%s\"",
        ["Artist Results"] = "Artistitulokset",
        ["Discover: searching albums..."] = "Discover: haetaan albumeita...",
        ["Discover: no albums found for \"%s\""] = "Discover: albumeita ei löytynyt haulla \"%s\"",
        ["Album Results"] = "Albumitulokset",
        ["Search artist"] = "Hae artistia",
        ["Search album"] = "Hae albumia",
        ["Discover: no library artists found"] = "Discover: kirjaston artisteja ei löytynyt",
        ["My Artists"] = "Omat artistit",
        ["Discover: no upcoming releases to show"] = "Discover: ei tulevia julkaisuja",
        ["Discover: no released releases to show"] = "Discover: ei julkaistuja julkaisuja",
        ["Upcoming"] = "Tulevat",
        ["Released (last %d days)"] = "Julkaistut (viimeiset %d pv)",
        ["Checking releases (%d of %d)..."] = "Tarkistetaan julkaisuja (%d/%d)...",
        ["Last checked %s -- tap to check again"] = "Tarkistettu viimeksi %s -- tarkista uudelleen napauttamalla",
        ["Check for new releases now"] = "Tarkista uudet julkaisut nyt",
        ["Upcoming, next %d months (%d)"] = "Tulevat, seuraavat %d kk (%d)",
        ["Released, last %d days (%d)"] = "Julkaistut, viimeiset %d pv (%d)",
        ["%d more hidden by your Options"] = "%d muuta piilotettu valinnoillasi",
        ["No matches (scanned %d releases against %d of your artists)"] = "Ei osumia (tarkistettiin %d julkaisua %d artistillesi)",
        ["New & Upcoming"] = "Uudet ja tulevat",
        ["Artist"] = "Artisti",
        ["Album"] = "Albumi",
        ["Already on your wish list"] = "Jo toivelistallasi",
        ["%d possible match to confirm"] = "%d mahdollinen osuma vahvistettavana",
        ["%d possible matches to confirm"] = "%d mahdollista osumaa vahvistettavana",
        ["Wish List"] = "Toivelista",
        ["Nothing here yet"] = "Ei vielä mitään",
        ["Discover: couldn't save confirmations (%s)"] = "Discover: vahvistuksia ei voitu tallentaa (%s)",
        ["Nothing to confirm"] = "Ei vahvistettavaa",
        ["Confirm Matches"] = "Vahvista osumat",
        ["waiting for the SD card"] = "odotetaan SD-korttia",
        ["changes not copied yet"] = "muutoksia ei ole vielä kopioitu",
        ["not created yet"] = "ei vielä luotu",
        ["in sync"] = "ajan tasalla",
        ["Restore wish list"] = "Palauta toivelista",
        ["Replace my wish list with the SD copy (%d album)"] = "Korvaa toivelistani SD-kopiolla (%d albumi)",
        ["Replace my wish list with the SD copy (%d albums)"] = "Korvaa toivelistani SD-kopiolla (%d albumia)",
        ["Cancel"] = "Peruuta",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover: nykyisen toivelistan varmuuskopiointi epäonnistui (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover: toivelistan palautus epäonnistui (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover: lista palautettiin, mutta SD-synkronoinnin tilaa ei voitu päivittää",
        ["Discover: restored %d from the SD copy"] = "Discover: palautettiin %d SD-kopiosta",
        ["Discover: couldn't save Options (%s)"] = "Discover: valintoja ei voitu tallentaa (%s)",
        ["Wish list SD copy: %s"] = "Toivelistan SD-kopio: %s",
        ["Back up wish list to SD now"] = "Varmuuskopioi toivelista SD-kortille nyt",
        ["Discover: wish list copied to the SD card"] = "Discover: toivelista kopioitu SD-kortille",
        ["Restore wish list from SD copy"] = "Palauta toivelista SD-kopiosta",
        ["Options"] = "Valinnat",
        ["Discover"] = "Löydä",
        ["Search Artist"] = "Hae artistia",
        ["Search Album"] = "Hae albumia",
        ["Add By Hand"] = "Lisää käsin",
    },
    fr = {
        ["couldn't encode JSON"] = "impossible d'encoder le JSON",
        ["plugin storage is full or unavailable"] = "le stockage de l'extension est plein ou indisponible",
        ["No internet connection -- check Wi-Fi and try again"] = "Pas de connexion internet -- vérifiez le Wi-Fi et réessayez",
        ["Request failed (%s)"] = "Échec de la requête (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover : serveur occupé, nouvel essai (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "le serveur est occupé -- réessayez dans une minute",
        ["request failed (HTTP %s)"] = "échec de la requête (HTTP %s)",
        ["Include Live albums"] = "Inclure les albums live",
        ["Include Demos"] = "Inclure les démos",
        ["Include Mixtapes"] = "Inclure les mixtapes",
        ["Include Compilations"] = "Inclure les compilations",
        ["Include Soundtracks"] = "Inclure les bandes originales",
        ["Include Remixes"] = "Inclure les remixes",
        ["Include DJ mixes"] = "Inclure les mixes DJ",
        ["Include Interviews"] = "Inclure les interviews",
        ["Include Spoken word"] = "Inclure le spoken word",
        ["Include Audiobooks"] = "Inclure les livres audio",
        ["Include Audio dramas"] = "Inclure les fictions audio",
        ["Include Field recordings"] = "Inclure les enregistrements de terrain",
        ["Include Broadcasts"] = "Inclure les émissions",
        ["SD card not available"] = "carte SD indisponible",
        ["no SD copy found"] = "aucune copie SD trouvée",
        ["SD copy is from a newer Discover -- update the plugin"] = "la copie SD provient d'un Discover plus récent -- mettez à jour l'extension",
        ["SD copy can't be read"] = "impossible de lire la copie SD",
        ["couldn't write the SD copy"] = "impossible d'écrire la copie SD",
        ["couldn't finish the SD copy"] = "impossible de finaliser la copie SD",
        ["wish list is invalid or has reached its 1000-item limit"] = "la liste de souhaits est invalide ou a atteint la limite de 1000 éléments",
        ["Discover: wish list restored from your SD copy"] = "Discover : liste de souhaits restaurée depuis la copie SD",
        ["Discover: %s"] = "Discover : %s",
        ["Discover: wish list merged with your SD copy"] = "Discover : liste de souhaits fusionnée avec la copie SD",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover : liste de souhaits mise à jour depuis la copie SD (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "les noms d'artiste et d'album ne doivent pas dépasser 1024 octets",
        ["wish list ID is too long"] = "l'identifiant de la liste de souhaits est trop long",
        ["wish list can contain up to 1000 items"] = "la liste de souhaits peut contenir jusqu'à 1000 éléments",
        ["Discover: couldn't save wish list (%s)"] = "Discover : impossible d'enregistrer la liste de souhaits (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover : impossible d'enregistrer les confirmations (%s)",
        ["Discover: removed %d item you already have"] = "Discover : %d élément déjà possédé retiré",
        ["Discover: removed %d items you already have"] = "Discover : %d éléments déjà possédés retirés",
        ["Discover: couldn't save the release feed"] = "Discover : impossible d'enregistrer le flux des sorties",
        ["Discover: couldn't save the release feed (%s)"] = "Discover : impossible d'enregistrer le flux des sorties (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover : %d sorties de vos artistes (%d à venir) -- ouvrez Nouveautés et à venir",
        ["couldn't read the releases feed"] = "impossible de lire le flux des sorties",
        ["Discover: checking releases (%d of %d)..."] = "Discover : vérification des sorties (%d sur %d)...",
        ["Discover: already checking for new releases"] = "Discover : vérification des nouvelles sorties déjà en cours",
        ["Discover: already up to date this week"] = "Discover : déjà à jour cette semaine",
        ["Discover: couldn't start scanning (%s)"] = "Discover : impossible de démarrer l'analyse (%s)",
        ["Discover: checking for new releases..."] = "Discover : recherche de nouvelles sorties...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover : recherche de nouvelles sorties (1re fois : %d requêtes, quelques minutes)...",
        ["Albums"] = "Albums",
        ["EPs"] = "EP",
        ["Singles"] = "Singles",
        ["albums"] = "albums",
        ["eps"] = "EP",
        ["singles"] = "singles",
        ["couldn't read the response"] = "impossible de lire la réponse",
        ["On Wish List"] = "Dans la liste de souhaits",
        ["Added to wish list"] = "Ajouté à la liste de souhaits",
        ["Removed from wish list"] = "Retiré de la liste de souhaits",
        ["Artist: %s"] = "Artiste : %s",
        ["Type: %s"] = "Type : %s",
        ["In your library"] = "Dans votre bibliothèque",
        ["Released: %s"] = "Sortie : %s",
        ["Rating: %.1f (%d votes)"] = "Note : %.1f (%d votes)",
        ["Genres: %s"] = "Genres : %s",
        ["Discover: loading %s..."] = "Discover : chargement de %s...",
        ["Discover: %s (showing basic info)"] = "Discover : %s (infos de base affichées)",
        ["Discover: loading %s by %s..."] = "Discover : chargement des %s de %s...",
        ["Discover: %d %s hidden by your Options"] = "Discover : %d %s masqués par vos Options",
        ["Discover: no %s found for %s"] = "Discover : aucun %s trouvé pour %s",
        ["Discover: finding artists similar to %s..."] = "Discover : recherche d'artistes similaires à %s...",
        ["Discover: no recommendations found for %s"] = "Discover : aucune recommandation trouvée pour %s",
        ["Similar to %s"] = "Similaire à %s",
        ["present"] = "présent",
        ["Find Similar Artists"] = "Trouver des artistes similaires",
        ["artist name is too long to search"] = "le nom de l'artiste est trop long pour la recherche",
        ["couldn't identify \"%s\" on MusicBrainz"] = "impossible d'identifier \"%s\" sur MusicBrainz",
        ["Discover: looking up %s..."] = "Discover : recherche de %s...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover : le texte recherché ne doit pas dépasser 512 octets",
        ["Discover: searching artists..."] = "Discover : recherche d'artistes...",
        ["Discover: no artists found for \"%s\""] = "Discover : aucun artiste trouvé pour \"%s\"",
        ["Artist Results"] = "Résultats d'artistes",
        ["Discover: searching albums..."] = "Discover : recherche d'albums...",
        ["Discover: no albums found for \"%s\""] = "Discover : aucun album trouvé pour \"%s\"",
        ["Album Results"] = "Résultats d'albums",
        ["Search artist"] = "Rechercher un artiste",
        ["Search album"] = "Rechercher un album",
        ["Discover: no library artists found"] = "Discover : aucun artiste trouvé dans la bibliothèque",
        ["My Artists"] = "Mes artistes",
        ["Discover: no upcoming releases to show"] = "Discover : aucune sortie à venir",
        ["Discover: no released releases to show"] = "Discover : aucune sortie récente",
        ["Upcoming"] = "À venir",
        ["Released (last %d days)"] = "Sortis (%d derniers jours)",
        ["Checking releases (%d of %d)..."] = "Vérification des sorties (%d sur %d)...",
        ["Last checked %s -- tap to check again"] = "Dernière vérif. %s -- touchez pour revérifier",
        ["Check for new releases now"] = "Vérifier les nouvelles sorties maintenant",
        ["Upcoming, next %d months (%d)"] = "À venir, %d prochains mois (%d)",
        ["Released, last %d days (%d)"] = "Sortis, %d derniers jours (%d)",
        ["%d more hidden by your Options"] = "%d de plus masqués par vos Options",
        ["No matches (scanned %d releases against %d of your artists)"] = "Aucun résultat (%d sorties analysées pour %d de vos artistes)",
        ["New & Upcoming"] = "Nouveautés et à venir",
        ["Artist"] = "Artiste",
        ["Album"] = "Album",
        ["Already on your wish list"] = "Déjà dans votre liste de souhaits",
        ["%d possible match to confirm"] = "%d correspondance possible à confirmer",
        ["%d possible matches to confirm"] = "%d correspondances possibles à confirmer",
        ["Wish List"] = "Liste de souhaits",
        ["Nothing here yet"] = "Rien ici pour le moment",
        ["Discover: couldn't save confirmations (%s)"] = "Discover : impossible d'enregistrer les confirmations (%s)",
        ["Nothing to confirm"] = "Rien à confirmer",
        ["Confirm Matches"] = "Confirmer les correspondances",
        ["waiting for the SD card"] = "en attente de la carte SD",
        ["changes not copied yet"] = "modifications pas encore copiées",
        ["not created yet"] = "pas encore créée",
        ["in sync"] = "synchronisée",
        ["Restore wish list"] = "Restaurer la liste de souhaits",
        ["Replace my wish list with the SD copy (%d album)"] = "Remplacer ma liste par la copie SD (%d album)",
        ["Replace my wish list with the SD copy (%d albums)"] = "Remplacer ma liste par la copie SD (%d albums)",
        ["Cancel"] = "Annuler",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover : impossible de sauvegarder la liste actuelle (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover : impossible de restaurer la liste de souhaits (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover : liste restaurée, mais état de synchro SD non mis à jour",
        ["Discover: restored %d from the SD copy"] = "Discover : %d restaurés depuis la copie SD",
        ["Discover: couldn't save Options (%s)"] = "Discover : impossible d'enregistrer les Options (%s)",
        ["Wish list SD copy: %s"] = "Copie SD de la liste : %s",
        ["Back up wish list to SD now"] = "Sauvegarder la liste sur la SD maintenant",
        ["Discover: wish list copied to the SD card"] = "Discover : liste de souhaits copiée sur la carte SD",
        ["Restore wish list from SD copy"] = "Restaurer la liste depuis la copie SD",
        ["Options"] = "Options",
        ["Discover"] = "Découvrir",
        ["Search Artist"] = "Rechercher un artiste",
        ["Search Album"] = "Rechercher un album",
        ["Add By Hand"] = "Ajouter manuellement",
    },
    it = {
        ["couldn't encode JSON"] = "impossibile codificare il JSON",
        ["plugin storage is full or unavailable"] = "memoria del plugin piena o non disponibile",
        ["No internet connection -- check Wi-Fi and try again"] = "Nessuna connessione internet -- controlla il Wi-Fi e riprova",
        ["Request failed (%s)"] = "Richiesta non riuscita (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover: server occupato, nuovo tentativo (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "il server è occupato -- riprova tra un minuto",
        ["request failed (HTTP %s)"] = "richiesta non riuscita (HTTP %s)",
        ["Include Live albums"] = "Includi album dal vivo",
        ["Include Demos"] = "Includi demo",
        ["Include Mixtapes"] = "Includi mixtape",
        ["Include Compilations"] = "Includi compilation",
        ["Include Soundtracks"] = "Includi colonne sonore",
        ["Include Remixes"] = "Includi remix",
        ["Include DJ mixes"] = "Includi DJ mix",
        ["Include Interviews"] = "Includi interviste",
        ["Include Spoken word"] = "Includi spoken word",
        ["Include Audiobooks"] = "Includi audiolibri",
        ["Include Audio dramas"] = "Includi radiodrammi",
        ["Include Field recordings"] = "Includi registrazioni sul campo",
        ["Include Broadcasts"] = "Includi trasmissioni",
        ["SD card not available"] = "scheda SD non disponibile",
        ["no SD copy found"] = "nessuna copia SD trovata",
        ["SD copy is from a newer Discover -- update the plugin"] = "la copia SD proviene da un Discover più recente -- aggiorna il plugin",
        ["SD copy can't be read"] = "impossibile leggere la copia SD",
        ["couldn't write the SD copy"] = "impossibile scrivere la copia SD",
        ["couldn't finish the SD copy"] = "impossibile completare la copia SD",
        ["wish list is invalid or has reached its 1000-item limit"] = "la lista dei desideri non è valida o ha raggiunto il limite di 1000 elementi",
        ["Discover: wish list restored from your SD copy"] = "Discover: lista dei desideri ripristinata dalla copia SD",
        ["Discover: %s"] = "Discover: %s",
        ["Discover: wish list merged with your SD copy"] = "Discover: lista dei desideri unita alla copia SD",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover: lista dei desideri aggiornata dalla copia SD (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "i nomi di artista e album devono essere di massimo 1024 byte",
        ["wish list ID is too long"] = "l'ID della lista dei desideri è troppo lungo",
        ["wish list can contain up to 1000 items"] = "la lista dei desideri può contenere fino a 1000 elementi",
        ["Discover: couldn't save wish list (%s)"] = "Discover: impossibile salvare la lista dei desideri (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover: impossibile salvare le conferme (%s)",
        ["Discover: removed %d item you already have"] = "Discover: rimosso %d elemento che hai già",
        ["Discover: removed %d items you already have"] = "Discover: rimossi %d elementi che hai già",
        ["Discover: couldn't save the release feed"] = "Discover: impossibile salvare il feed delle uscite",
        ["Discover: couldn't save the release feed (%s)"] = "Discover: impossibile salvare il feed delle uscite (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover: %d uscite dai tuoi artisti (%d in arrivo) -- apri Nuove e in arrivo",
        ["couldn't read the releases feed"] = "impossibile leggere il feed delle uscite",
        ["Discover: checking releases (%d of %d)..."] = "Discover: controllo uscite (%d di %d)...",
        ["Discover: already checking for new releases"] = "Discover: controllo nuove uscite già in corso",
        ["Discover: already up to date this week"] = "Discover: già aggiornato questa settimana",
        ["Discover: couldn't start scanning (%s)"] = "Discover: impossibile avviare la scansione (%s)",
        ["Discover: checking for new releases..."] = "Discover: controllo nuove uscite...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover: controllo nuove uscite (prima volta: %d richieste, qualche minuto)...",
        ["Albums"] = "Album",
        ["EPs"] = "EP",
        ["Singles"] = "Singoli",
        ["albums"] = "album",
        ["eps"] = "EP",
        ["singles"] = "singoli",
        ["couldn't read the response"] = "impossibile leggere la risposta",
        ["On Wish List"] = "Nella lista dei desideri",
        ["Added to wish list"] = "Aggiunto alla lista dei desideri",
        ["Removed from wish list"] = "Rimosso dalla lista dei desideri",
        ["Artist: %s"] = "Artista: %s",
        ["Type: %s"] = "Tipo: %s",
        ["In your library"] = "Nella tua libreria",
        ["Released: %s"] = "Pubblicato: %s",
        ["Rating: %.1f (%d votes)"] = "Valutazione: %.1f (%d voti)",
        ["Genres: %s"] = "Generi: %s",
        ["Discover: loading %s..."] = "Discover: caricamento di %s...",
        ["Discover: %s (showing basic info)"] = "Discover: %s (info di base)",
        ["Discover: loading %s by %s..."] = "Discover: caricamento %s di %s...",
        ["Discover: %d %s hidden by your Options"] = "Discover: %d %s nascosti dalle tue Opzioni",
        ["Discover: no %s found for %s"] = "Discover: nessun %s trovato per %s",
        ["Discover: finding artists similar to %s..."] = "Discover: ricerca artisti simili a %s...",
        ["Discover: no recommendations found for %s"] = "Discover: nessun consiglio trovato per %s",
        ["Similar to %s"] = "Simili a %s",
        ["present"] = "oggi",
        ["Find Similar Artists"] = "Trova artisti simili",
        ["artist name is too long to search"] = "il nome dell'artista è troppo lungo per la ricerca",
        ["couldn't identify \"%s\" on MusicBrainz"] = "impossibile identificare \"%s\" su MusicBrainz",
        ["Discover: looking up %s..."] = "Discover: ricerca di %s...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover: il testo cercato deve essere di massimo 512 byte",
        ["Discover: searching artists..."] = "Discover: ricerca artisti...",
        ["Discover: no artists found for \"%s\""] = "Discover: nessun artista trovato per \"%s\"",
        ["Artist Results"] = "Risultati artisti",
        ["Discover: searching albums..."] = "Discover: ricerca album...",
        ["Discover: no albums found for \"%s\""] = "Discover: nessun album trovato per \"%s\"",
        ["Album Results"] = "Risultati album",
        ["Search artist"] = "Cerca artista",
        ["Search album"] = "Cerca album",
        ["Discover: no library artists found"] = "Discover: nessun artista trovato nella libreria",
        ["My Artists"] = "I miei artisti",
        ["Discover: no upcoming releases to show"] = "Discover: nessuna uscita in arrivo da mostrare",
        ["Discover: no released releases to show"] = "Discover: nessuna uscita pubblicata da mostrare",
        ["Upcoming"] = "In arrivo",
        ["Released (last %d days)"] = "Pubblicati (ultimi %d giorni)",
        ["Checking releases (%d of %d)..."] = "Controllo uscite (%d di %d)...",
        ["Last checked %s -- tap to check again"] = "Ultimo controllo %s -- tocca per ricontrollare",
        ["Check for new releases now"] = "Controlla nuove uscite ora",
        ["Upcoming, next %d months (%d)"] = "In arrivo, prossimi %d mesi (%d)",
        ["Released, last %d days (%d)"] = "Pubblicati, ultimi %d giorni (%d)",
        ["%d more hidden by your Options"] = "Altri %d nascosti dalle tue Opzioni",
        ["No matches (scanned %d releases against %d of your artists)"] = "Nessun risultato (%d uscite analizzate su %d tuoi artisti)",
        ["New & Upcoming"] = "Nuove e in arrivo",
        ["Artist"] = "Artista",
        ["Album"] = "Album",
        ["Already on your wish list"] = "Già nella tua lista dei desideri",
        ["%d possible match to confirm"] = "%d possibile corrispondenza da confermare",
        ["%d possible matches to confirm"] = "%d possibili corrispondenze da confermare",
        ["Wish List"] = "Lista dei desideri",
        ["Nothing here yet"] = "Ancora niente qui",
        ["Discover: couldn't save confirmations (%s)"] = "Discover: impossibile salvare le conferme (%s)",
        ["Nothing to confirm"] = "Niente da confermare",
        ["Confirm Matches"] = "Conferma corrispondenze",
        ["waiting for the SD card"] = "in attesa della scheda SD",
        ["changes not copied yet"] = "modifiche non ancora copiate",
        ["not created yet"] = "non ancora creata",
        ["in sync"] = "sincronizzata",
        ["Restore wish list"] = "Ripristina lista dei desideri",
        ["Replace my wish list with the SD copy (%d album)"] = "Sostituisci la mia lista con la copia SD (%d album)",
        ["Replace my wish list with the SD copy (%d albums)"] = "Sostituisci la mia lista con la copia SD (%d album)",
        ["Cancel"] = "Annulla",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover: impossibile eseguire il backup della lista attuale (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover: impossibile ripristinare la lista dei desideri (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover: lista ripristinata, ma impossibile aggiornare lo stato di sincronizzazione SD",
        ["Discover: restored %d from the SD copy"] = "Discover: ripristinati %d dalla copia SD",
        ["Discover: couldn't save Options (%s)"] = "Discover: impossibile salvare le Opzioni (%s)",
        ["Wish list SD copy: %s"] = "Copia SD lista dei desideri: %s",
        ["Back up wish list to SD now"] = "Esegui ora il backup della lista su SD",
        ["Discover: wish list copied to the SD card"] = "Discover: lista dei desideri copiata sulla scheda SD",
        ["Restore wish list from SD copy"] = "Ripristina lista dei desideri dalla copia SD",
        ["Options"] = "Opzioni",
        ["Discover"] = "Scopri",
        ["Search Artist"] = "Cerca artista",
        ["Search Album"] = "Cerca album",
        ["Add By Hand"] = "Aggiungi manualmente",
    },
    ja = {
        ["couldn't encode JSON"] = "JSON をエンコードできませんでした",
        ["plugin storage is full or unavailable"] = "プラグインの保存領域がいっぱいか利用できません",
        ["No internet connection -- check Wi-Fi and try again"] = "インターネット接続がありません -- Wi-Fi を確認して再試行してください",
        ["Request failed (%s)"] = "リクエスト失敗 (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover: サーバー混雑中、再試行しています (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "現在サーバーが混雑しています -- 少し待ってから再試行してください",
        ["request failed (HTTP %s)"] = "リクエスト失敗 (HTTP %s)",
        ["Include Live albums"] = "ライブアルバムを含める",
        ["Include Demos"] = "デモを含める",
        ["Include Mixtapes"] = "ミックステープを含める",
        ["Include Compilations"] = "コンピレーションを含める",
        ["Include Soundtracks"] = "サウンドトラックを含める",
        ["Include Remixes"] = "リミックスを含める",
        ["Include DJ mixes"] = "DJ ミックスを含める",
        ["Include Interviews"] = "インタビューを含める",
        ["Include Spoken word"] = "スポークン・ワードを含める",
        ["Include Audiobooks"] = "オーディオブックを含める",
        ["Include Audio dramas"] = "オーディオドラマを含める",
        ["Include Field recordings"] = "フィールド録音を含める",
        ["Include Broadcasts"] = "放送音源を含める",
        ["SD card not available"] = "SD カードが利用できません",
        ["no SD copy found"] = "SD コピーが見つかりません",
        ["SD copy is from a newer Discover -- update the plugin"] = "SD コピーは新しい Discover のものです -- プラグインを更新してください",
        ["SD copy can't be read"] = "SD コピーを読み込めません",
        ["couldn't write the SD copy"] = "SD コピーを書き込めませんでした",
        ["couldn't finish the SD copy"] = "SD コピーを完了できませんでした",
        ["wish list is invalid or has reached its 1000-item limit"] = "ウィッシュリストが無効か上限の 1000 件に達しています",
        ["Discover: wish list restored from your SD copy"] = "Discover: SD コピーからウィッシュリストを復元しました",
        ["Discover: %s"] = "Discover: %s",
        ["Discover: wish list merged with your SD copy"] = "Discover: ウィッシュリストを SD コピーと統合しました",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover: SD コピーからウィッシュリストを更新しました (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "アーティスト名とアルバム名は 1024 バイト以下にしてください",
        ["wish list ID is too long"] = "ウィッシュリスト ID が長すぎます",
        ["wish list can contain up to 1000 items"] = "ウィッシュリストは最大 1000 件まで登録できます",
        ["Discover: couldn't save wish list (%s)"] = "Discover: ウィッシュリストを保存できませんでした (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover: 一致確認を保存できませんでした (%s)",
        ["Discover: removed %d item you already have"] = "Discover: 所有済みの %d 件をリストから削除しました",
        ["Discover: removed %d items you already have"] = "Discover: 所有済みの %d 件をリストから削除しました",
        ["Discover: couldn't save the release feed"] = "Discover: リリース情報を保存できませんでした",
        ["Discover: couldn't save the release feed (%s)"] = "Discover: リリース情報を保存できませんでした (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover: アーティストのリリース %d 件 (発売予定 %d 件) -- 新着・発売予定を開いてください",
        ["couldn't read the releases feed"] = "リリース情報を読み込めませんでした",
        ["Discover: checking releases (%d of %d)..."] = "Discover: リリースを確認中 (%d / %d)...",
        ["Discover: already checking for new releases"] = "Discover: すでに新着リリースを確認中です",
        ["Discover: already up to date this week"] = "Discover: 今週分はすでに最新です",
        ["Discover: couldn't start scanning (%s)"] = "Discover: スキャンを開始できませんでした (%s)",
        ["Discover: checking for new releases..."] = "Discover: 新着リリースを確認中...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover: 新着リリースを確認中 (初回: %d リクエスト、数分かかります)...",
        ["Albums"] = "アルバム",
        ["EPs"] = "EP",
        ["Singles"] = "シングル",
        ["albums"] = "アルバム",
        ["eps"] = "EP",
        ["singles"] = "シングル",
        ["couldn't read the response"] = "応答を読み込めませんでした",
        ["On Wish List"] = "ウィッシュリストに登録",
        ["Added to wish list"] = "ウィッシュリストに追加しました",
        ["Removed from wish list"] = "ウィッシュリストから削除しました",
        ["Artist: %s"] = "アーティスト: %s",
        ["Type: %s"] = "種類: %s",
        ["In your library"] = "ライブラリに所有済み",
        ["Released: %s"] = "リリース年: %s",
        ["Rating: %.1f (%d votes)"] = "評価: %.1f (%d 票)",
        ["Genres: %s"] = "ジャンル: %s",
        ["Discover: loading %s..."] = "Discover: %s を読み込み中...",
        ["Discover: %s (showing basic info)"] = "Discover: %s (基本情報のみ表示)",
        ["Discover: loading %s by %s..."] = "Discover: %s (%s) を読み込み中...",
        ["Discover: %d %s hidden by your Options"] = "Discover: オプションにより %d 件の%sが非表示です",
        ["Discover: no %s found for %s"] = "Discover: %s (%s) は見つかりませんでした",
        ["Discover: finding artists similar to %s..."] = "Discover: %s に似たアーティストを検索中...",
        ["Discover: no recommendations found for %s"] = "Discover: %s のおすすめは見つかりませんでした",
        ["Similar to %s"] = "%s に似たアーティスト",
        ["present"] = "現在",
        ["Find Similar Artists"] = "似たアーティストを探す",
        ["artist name is too long to search"] = "アーティスト名が長すぎて検索できません",
        ["couldn't identify \"%s\" on MusicBrainz"] = "MusicBrainz で \"%s\" を特定できませんでした",
        ["Discover: looking up %s..."] = "Discover: %s を検索中...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover: 検索語は 512 バイト以下にしてください",
        ["Discover: searching artists..."] = "Discover: アーティストを検索中...",
        ["Discover: no artists found for \"%s\""] = "Discover: \"%s\" に一致するアーティストが見つかりません",
        ["Artist Results"] = "アーティストの検索結果",
        ["Discover: searching albums..."] = "Discover: アルバムを検索中...",
        ["Discover: no albums found for \"%s\""] = "Discover: \"%s\" に一致するアルバムが見つかりません",
        ["Album Results"] = "アルバムの検索結果",
        ["Search artist"] = "アーティストを検索",
        ["Search album"] = "アルバムを検索",
        ["Discover: no library artists found"] = "Discover: ライブラリにアーティストが見つかりません",
        ["My Artists"] = "マイアーティスト",
        ["Discover: no upcoming releases to show"] = "Discover: 表示する発売予定はありません",
        ["Discover: no released releases to show"] = "Discover: 表示する発売済みリリースはありません",
        ["Upcoming"] = "発売予定",
        ["Released (last %d days)"] = "発売済み (過去 %d 日間)",
        ["Checking releases (%d of %d)..."] = "リリースを確認中 (%d / %d)...",
        ["Last checked %s -- tap to check again"] = "最終確認 %s -- タップして再確認",
        ["Check for new releases now"] = "今すぐ新着リリースを確認",
        ["Upcoming, next %d months (%d)"] = "発売予定、今後 %d か月 (%d)",
        ["Released, last %d days (%d)"] = "発売済み、過去 %d 日間 (%d)",
        ["%d more hidden by your Options"] = "ほか %d 件がオプションで非表示",
        ["No matches (scanned %d releases against %d of your artists)"] = "一致なし (%d 件のリリースを %d 組のアーティストと照合)",
        ["New & Upcoming"] = "新着・発売予定",
        ["Artist"] = "アーティスト",
        ["Album"] = "アルバム",
        ["Already on your wish list"] = "すでにウィッシュリストにあります",
        ["%d possible match to confirm"] = "確認待ちの候補 %d 件",
        ["%d possible matches to confirm"] = "確認待ちの候補 %d 件",
        ["Wish List"] = "ウィッシュリスト",
        ["Nothing here yet"] = "まだ何もありません",
        ["Discover: couldn't save confirmations (%s)"] = "Discover: 確認結果を保存できませんでした (%s)",
        ["Nothing to confirm"] = "確認する項目はありません",
        ["Confirm Matches"] = "一致の確認",
        ["waiting for the SD card"] = "SD カード待機中",
        ["changes not copied yet"] = "変更はまだコピーされていません",
        ["not created yet"] = "未作成",
        ["in sync"] = "同期済み",
        ["Restore wish list"] = "ウィッシュリストを復元",
        ["Replace my wish list with the SD copy (%d album)"] = "ウィッシュリストを SD コピーで置き換える (%d 枚)",
        ["Replace my wish list with the SD copy (%d albums)"] = "ウィッシュリストを SD コピーで置き換える (%d 枚)",
        ["Cancel"] = "キャンセル",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover: 現在のウィッシュリストをバックアップできませんでした (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover: ウィッシュリストを復元できませんでした (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover: リストを復元しましたが、SD 同期状態を更新できませんでした",
        ["Discover: restored %d from the SD copy"] = "Discover: SD コピーから %d 件復元しました",
        ["Discover: couldn't save Options (%s)"] = "Discover: オプションを保存できませんでした (%s)",
        ["Wish list SD copy: %s"] = "ウィッシュリストの SD コピー: %s",
        ["Back up wish list to SD now"] = "今すぐウィッシュリストを SD にバックアップ",
        ["Discover: wish list copied to the SD card"] = "Discover: ウィッシュリストを SD カードにコピーしました",
        ["Restore wish list from SD copy"] = "SD コピーからウィッシュリストを復元",
        ["Options"] = "オプション",
        ["Discover"] = "ディスカバー",
        ["Search Artist"] = "アーティスト検索",
        ["Search Album"] = "アルバム検索",
        ["Add By Hand"] = "手動で追加",
    },
    nl = {
        ["couldn't encode JSON"] = "kon JSON niet coderen",
        ["plugin storage is full or unavailable"] = "plug-inopslag is vol of niet beschikbaar",
        ["No internet connection -- check Wi-Fi and try again"] = "Geen internetverbinding -- controleer Wi-Fi en probeer opnieuw",
        ["Request failed (%s)"] = "Verzoek mislukt (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover: server bezet, opnieuw proberen (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "server is momenteel bezet -- probeer het over een minuut opnieuw",
        ["request failed (HTTP %s)"] = "verzoek mislukt (HTTP %s)",
        ["Include Live albums"] = "Live-albums opnemen",
        ["Include Demos"] = "Demo's opnemen",
        ["Include Mixtapes"] = "Mixtapes opnemen",
        ["Include Compilations"] = "Compilaties opnemen",
        ["Include Soundtracks"] = "Soundtracks opnemen",
        ["Include Remixes"] = "Remixen opnemen",
        ["Include DJ mixes"] = "DJ-mixen opnemen",
        ["Include Interviews"] = "Interviews opnemen",
        ["Include Spoken word"] = "Spoken word opnemen",
        ["Include Audiobooks"] = "Luisterboeken opnemen",
        ["Include Audio dramas"] = "Hoorspelen opnemen",
        ["Include Field recordings"] = "Veldopnamen opnemen",
        ["Include Broadcasts"] = "Uitzendingen opnemen",
        ["SD card not available"] = "SD-kaart niet beschikbaar",
        ["no SD copy found"] = "geen SD-kopie gevonden",
        ["SD copy is from a newer Discover -- update the plugin"] = "SD-kopie komt van een nieuwere Discover -- werk de plug-in bij",
        ["SD copy can't be read"] = "SD-kopie kan niet worden gelezen",
        ["couldn't write the SD copy"] = "kon de SD-kopie niet schrijven",
        ["couldn't finish the SD copy"] = "kon de SD-kopie niet voltooien",
        ["wish list is invalid or has reached its 1000-item limit"] = "verlanglijst is ongeldig of heeft de limiet van 1000 items bereikt",
        ["Discover: wish list restored from your SD copy"] = "Discover: verlanglijst hersteld vanaf je SD-kopie",
        ["Discover: %s"] = "Discover: %s",
        ["Discover: wish list merged with your SD copy"] = "Discover: verlanglijst samengevoegd met je SD-kopie",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover: verlanglijst bijgewerkt vanaf SD-kopie (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "artiest- en albumnamen mogen maximaal 1024 bytes zijn",
        ["wish list ID is too long"] = "verlanglijst-ID is te lang",
        ["wish list can contain up to 1000 items"] = "verlanglijst kan maximaal 1000 items bevatten",
        ["Discover: couldn't save wish list (%s)"] = "Discover: kon verlanglijst niet opslaan (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover: kon bevestigingen niet opslaan (%s)",
        ["Discover: removed %d item you already have"] = "Discover: %d item verwijderd dat je al hebt",
        ["Discover: removed %d items you already have"] = "Discover: %d items verwijderd die je al hebt",
        ["Discover: couldn't save the release feed"] = "Discover: kon de releasefeed niet opslaan",
        ["Discover: couldn't save the release feed (%s)"] = "Discover: kon de releasefeed niet opslaan (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover: %d releases van je artiesten (%d verwacht) -- open Nieuw & Verwacht",
        ["couldn't read the releases feed"] = "kon de releasefeed niet lezen",
        ["Discover: checking releases (%d of %d)..."] = "Discover: releases controleren (%d van %d)...",
        ["Discover: already checking for new releases"] = "Discover: controleert al op nieuwe releases",
        ["Discover: already up to date this week"] = "Discover: deze week al bijgewerkt",
        ["Discover: couldn't start scanning (%s)"] = "Discover: kon scannen niet starten (%s)",
        ["Discover: checking for new releases..."] = "Discover: controleren op nieuwe releases...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover: controleren op nieuwe releases (eerste keer: %d verzoeken, enkele minuten)...",
        ["Albums"] = "Albums",
        ["EPs"] = "EP's",
        ["Singles"] = "Singles",
        ["albums"] = "albums",
        ["eps"] = "ep's",
        ["singles"] = "singles",
        ["couldn't read the response"] = "kon het antwoord niet lezen",
        ["On Wish List"] = "Op verlanglijst",
        ["Added to wish list"] = "Toegevoegd aan verlanglijst",
        ["Removed from wish list"] = "Verwijderd van verlanglijst",
        ["Artist: %s"] = "Artiest: %s",
        ["Type: %s"] = "Type: %s",
        ["In your library"] = "In je bibliotheek",
        ["Released: %s"] = "Uitgebracht: %s",
        ["Rating: %.1f (%d votes)"] = "Beoordeling: %.1f (%d stemmen)",
        ["Genres: %s"] = "Genres: %s",
        ["Discover: loading %s..."] = "Discover: %s laden...",
        ["Discover: %s (showing basic info)"] = "Discover: %s (basisinfo wordt getoond)",
        ["Discover: loading %s by %s..."] = "Discover: %s van %s laden...",
        ["Discover: %d %s hidden by your Options"] = "Discover: %d %s verborgen door je Opties",
        ["Discover: no %s found for %s"] = "Discover: geen %s gevonden voor %s",
        ["Discover: finding artists similar to %s..."] = "Discover: vergelijkbare artiesten zoeken voor %s...",
        ["Discover: no recommendations found for %s"] = "Discover: geen aanbevelingen gevonden voor %s",
        ["Similar to %s"] = "Vergelijkbaar met %s",
        ["present"] = "heden",
        ["Find Similar Artists"] = "Vergelijkbare artiesten zoeken",
        ["artist name is too long to search"] = "artiestnaam is te lang om te zoeken",
        ["couldn't identify \"%s\" on MusicBrainz"] = "kon \"%s\" niet vinden op MusicBrainz",
        ["Discover: looking up %s..."] = "Discover: %s opzoeken...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover: zoektekst mag maximaal 512 bytes zijn",
        ["Discover: searching artists..."] = "Discover: artiesten zoeken...",
        ["Discover: no artists found for \"%s\""] = "Discover: geen artiesten gevonden voor \"%s\"",
        ["Artist Results"] = "Artiestresultaten",
        ["Discover: searching albums..."] = "Discover: albums zoeken...",
        ["Discover: no albums found for \"%s\""] = "Discover: geen albums gevonden voor \"%s\"",
        ["Album Results"] = "Albumresultaten",
        ["Search artist"] = "Artiest zoeken",
        ["Search album"] = "Album zoeken",
        ["Discover: no library artists found"] = "Discover: geen artiesten gevonden in bibliotheek",
        ["My Artists"] = "Mijn artiesten",
        ["Discover: no upcoming releases to show"] = "Discover: geen verwachte releases om te tonen",
        ["Discover: no released releases to show"] = "Discover: geen uitgebrachte releases om te tonen",
        ["Upcoming"] = "Verwacht",
        ["Released (last %d days)"] = "Uitgebracht (laatste %d dagen)",
        ["Checking releases (%d of %d)..."] = "Releases controleren (%d van %d)...",
        ["Last checked %s -- tap to check again"] = "Laatst gecontroleerd %s -- tik om opnieuw te controleren",
        ["Check for new releases now"] = "Nu controleren op nieuwe releases",
        ["Upcoming, next %d months (%d)"] = "Verwacht, komende %d maanden (%d)",
        ["Released, last %d days (%d)"] = "Uitgebracht, laatste %d dagen (%d)",
        ["%d more hidden by your Options"] = "Nog %d verborgen door je Opties",
        ["No matches (scanned %d releases against %d of your artists)"] = "Geen resultaten (%d releases gecontroleerd voor %d van je artiesten)",
        ["New & Upcoming"] = "Nieuw & Verwacht",
        ["Artist"] = "Artiest",
        ["Album"] = "Album",
        ["Already on your wish list"] = "Staat al op je verlanglijst",
        ["%d possible match to confirm"] = "%d mogelijke overeenkomst om te bevestigen",
        ["%d possible matches to confirm"] = "%d mogelijke overeenkomsten om te bevestigen",
        ["Wish List"] = "Verlanglijst",
        ["Nothing here yet"] = "Nog niets hier",
        ["Discover: couldn't save confirmations (%s)"] = "Discover: kon bevestigingen niet opslaan (%s)",
        ["Nothing to confirm"] = "Niets te bevestigen",
        ["Confirm Matches"] = "Overeenkomsten bevestigen",
        ["waiting for the SD card"] = "wachten op de SD-kaart",
        ["changes not copied yet"] = "wijzigingen nog niet gekopieerd",
        ["not created yet"] = "nog niet aangemaakt",
        ["in sync"] = "gesynchroniseerd",
        ["Restore wish list"] = "Verlanglijst herstellen",
        ["Replace my wish list with the SD copy (%d album)"] = "Mijn verlanglijst vervangen door de SD-kopie (%d album)",
        ["Replace my wish list with the SD copy (%d albums)"] = "Mijn verlanglijst vervangen door de SD-kopie (%d albums)",
        ["Cancel"] = "Annuleren",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover: kon geen back-up maken van de huidige verlanglijst (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover: kon verlanglijst niet herstellen (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover: lijst hersteld, maar kon SD-synchronisatiestatus niet bijwerken",
        ["Discover: restored %d from the SD copy"] = "Discover: %d hersteld vanaf de SD-kopie",
        ["Discover: couldn't save Options (%s)"] = "Discover: kon Opties niet opslaan (%s)",
        ["Wish list SD copy: %s"] = "SD-kopie verlanglijst: %s",
        ["Back up wish list to SD now"] = "Verlanglijst nu naar SD kopiëren",
        ["Discover: wish list copied to the SD card"] = "Discover: verlanglijst gekopieerd naar de SD-kaart",
        ["Restore wish list from SD copy"] = "Verlanglijst herstellen vanaf SD-kopie",
        ["Options"] = "Opties",
        ["Discover"] = "Ontdekken",
        ["Search Artist"] = "Artiest zoeken",
        ["Search Album"] = "Album zoeken",
        ["Add By Hand"] = "Handmatig toevoegen",
    },
    pt = {
        ["couldn't encode JSON"] = "não foi possível codificar o JSON",
        ["plugin storage is full or unavailable"] = "armazenamento do plugin cheio ou indisponível",
        ["No internet connection -- check Wi-Fi and try again"] = "Sem conexão com a internet -- verifique o Wi-Fi e tente novamente",
        ["Request failed (%s)"] = "Falha na solicitação (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover: servidor ocupado, tentando novamente (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "o servidor está ocupado agora -- tente novamente em um minuto",
        ["request failed (HTTP %s)"] = "falha na solicitação (HTTP %s)",
        ["Include Live albums"] = "Incluir álbuns ao vivo",
        ["Include Demos"] = "Incluir demos",
        ["Include Mixtapes"] = "Incluir mixtapes",
        ["Include Compilations"] = "Incluir coletâneas",
        ["Include Soundtracks"] = "Incluir trilhas sonoras",
        ["Include Remixes"] = "Incluir remixes",
        ["Include DJ mixes"] = "Incluir DJ mixes",
        ["Include Interviews"] = "Incluir entrevistas",
        ["Include Spoken word"] = "Incluir spoken word",
        ["Include Audiobooks"] = "Incluir audiolivros",
        ["Include Audio dramas"] = "Incluir dramas de áudio",
        ["Include Field recordings"] = "Incluir gravações de campo",
        ["Include Broadcasts"] = "Incluir transmissões",
        ["SD card not available"] = "cartão SD indisponível",
        ["no SD copy found"] = "nenhuma cópia no SD encontrada",
        ["SD copy is from a newer Discover -- update the plugin"] = "a cópia no SD é de um Discover mais recente -- atualize o plugin",
        ["SD copy can't be read"] = "não é possível ler a cópia do SD",
        ["couldn't write the SD copy"] = "não foi possível gravar a cópia no SD",
        ["couldn't finish the SD copy"] = "não foi possível concluir a cópia no SD",
        ["wish list is invalid or has reached its 1000-item limit"] = "a lista de desejos é inválida ou atingiu o limite de 1000 itens",
        ["Discover: wish list restored from your SD copy"] = "Discover: lista de desejos restaurada da cópia no SD",
        ["Discover: %s"] = "Discover: %s",
        ["Discover: wish list merged with your SD copy"] = "Discover: lista de desejos mesclada com a cópia no SD",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover: lista de desejos atualizada da cópia no SD (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "os nomes de artista e álbum devem ter no máximo 1024 bytes",
        ["wish list ID is too long"] = "o ID da lista de desejos é longo demais",
        ["wish list can contain up to 1000 items"] = "a lista de desejos pode conter até 1000 itens",
        ["Discover: couldn't save wish list (%s)"] = "Discover: não foi possível salvar a lista de desejos (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover: não foi possível salvar as confirmações (%s)",
        ["Discover: removed %d item you already have"] = "Discover: %d item que você já tem foi removido",
        ["Discover: removed %d items you already have"] = "Discover: %d itens que você já tem foram removidos",
        ["Discover: couldn't save the release feed"] = "Discover: não foi possível salvar o feed de lançamentos",
        ["Discover: couldn't save the release feed (%s)"] = "Discover: não foi possível salvar o feed de lançamentos (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover: %d lançamentos dos seus artistas (%d futuros) -- abra Novos e Futuros",
        ["couldn't read the releases feed"] = "não foi possível ler o feed de lançamentos",
        ["Discover: checking releases (%d of %d)..."] = "Discover: verificando lançamentos (%d de %d)...",
        ["Discover: already checking for new releases"] = "Discover: já verificando novos lançamentos",
        ["Discover: already up to date this week"] = "Discover: já atualizado nesta semana",
        ["Discover: couldn't start scanning (%s)"] = "Discover: não foi possível iniciar a verificação (%s)",
        ["Discover: checking for new releases..."] = "Discover: verificando novos lançamentos...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover: verificando novos lançamentos (primeira vez: %d requisições, alguns minutos)...",
        ["Albums"] = "Álbuns",
        ["EPs"] = "EPs",
        ["Singles"] = "Singles",
        ["albums"] = "álbuns",
        ["eps"] = "EPs",
        ["singles"] = "singles",
        ["couldn't read the response"] = "não foi possível ler a resposta",
        ["On Wish List"] = "Na lista de desejos",
        ["Added to wish list"] = "Adicionado à lista de desejos",
        ["Removed from wish list"] = "Removido da lista de desejos",
        ["Artist: %s"] = "Artista: %s",
        ["Type: %s"] = "Tipo: %s",
        ["In your library"] = "Na sua biblioteca",
        ["Released: %s"] = "Lançamento: %s",
        ["Rating: %.1f (%d votes)"] = "Avaliação: %.1f (%d votos)",
        ["Genres: %s"] = "Gêneros: %s",
        ["Discover: loading %s..."] = "Discover: carregando %s...",
        ["Discover: %s (showing basic info)"] = "Discover: %s (exibindo informações básicas)",
        ["Discover: loading %s by %s..."] = "Discover: carregando %s de %s...",
        ["Discover: %d %s hidden by your Options"] = "Discover: %d %s ocultos pelas suas Opções",
        ["Discover: no %s found for %s"] = "Discover: nenhum %s encontrado para %s",
        ["Discover: finding artists similar to %s..."] = "Discover: buscando artistas semelhantes a %s...",
        ["Discover: no recommendations found for %s"] = "Discover: nenhuma recomendação encontrada para %s",
        ["Similar to %s"] = "Semelhantes a %s",
        ["present"] = "presente",
        ["Find Similar Artists"] = "Encontrar artistas semelhantes",
        ["artist name is too long to search"] = "o nome do artista é longo demais para pesquisar",
        ["couldn't identify \"%s\" on MusicBrainz"] = "não foi possível identificar \"%s\" no MusicBrainz",
        ["Discover: looking up %s..."] = "Discover: pesquisando %s...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover: o texto da pesquisa deve ter no máximo 512 bytes",
        ["Discover: searching artists..."] = "Discover: pesquisando artistas...",
        ["Discover: no artists found for \"%s\""] = "Discover: nenhum artista encontrado para \"%s\"",
        ["Artist Results"] = "Resultados de artistas",
        ["Discover: searching albums..."] = "Discover: pesquisando álbuns...",
        ["Discover: no albums found for \"%s\""] = "Discover: nenhum álbum encontrado para \"%s\"",
        ["Album Results"] = "Resultados de álbuns",
        ["Search artist"] = "Pesquisar artista",
        ["Search album"] = "Pesquisar álbum",
        ["Discover: no library artists found"] = "Discover: nenhum artista encontrado na biblioteca",
        ["My Artists"] = "Meus artistas",
        ["Discover: no upcoming releases to show"] = "Discover: nenhum lançamento futuro para mostrar",
        ["Discover: no released releases to show"] = "Discover: nenhum lançamento recente para mostrar",
        ["Upcoming"] = "Futuros",
        ["Released (last %d days)"] = "Lançados (últimos %d dias)",
        ["Checking releases (%d of %d)..."] = "Verificando lançamentos (%d de %d)...",
        ["Last checked %s -- tap to check again"] = "Última verificação %s -- toque para verificar novamente",
        ["Check for new releases now"] = "Verificar novos lançamentos agora",
        ["Upcoming, next %d months (%d)"] = "Futuros, próximos %d meses (%d)",
        ["Released, last %d days (%d)"] = "Lançados, últimos %d dias (%d)",
        ["%d more hidden by your Options"] = "Mais %d ocultos pelas suas Opções",
        ["No matches (scanned %d releases against %d of your artists)"] = "Nenhuma correspondência (%d lançamentos verificados com %d dos seus artistas)",
        ["New & Upcoming"] = "Novos e Futuros",
        ["Artist"] = "Artista",
        ["Album"] = "Álbum",
        ["Already on your wish list"] = "Já está na sua lista de desejos",
        ["%d possible match to confirm"] = "%d possível correspondência para confirmar",
        ["%d possible matches to confirm"] = "%d possíveis correspondências para confirmar",
        ["Wish List"] = "Lista de desejos",
        ["Nothing here yet"] = "Nada aqui ainda",
        ["Discover: couldn't save confirmations (%s)"] = "Discover: não foi possível salvar as confirmações (%s)",
        ["Nothing to confirm"] = "Nada para confirmar",
        ["Confirm Matches"] = "Confirmar correspondências",
        ["waiting for the SD card"] = "aguardando o cartão SD",
        ["changes not copied yet"] = "alterações ainda não copiadas",
        ["not created yet"] = "ainda não criada",
        ["in sync"] = "sincronizada",
        ["Restore wish list"] = "Restaurar lista de desejos",
        ["Replace my wish list with the SD copy (%d album)"] = "Substituir minha lista pela cópia do SD (%d álbum)",
        ["Replace my wish list with the SD copy (%d albums)"] = "Substituir minha lista pela cópia do SD (%d álbuns)",
        ["Cancel"] = "Cancelar",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover: não foi possível fazer backup da lista atual (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover: não foi possível restaurar a lista de desejos (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover: lista restaurada, mas não foi possível atualizar o status de sincronização SD",
        ["Discover: restored %d from the SD copy"] = "Discover: %d restaurados da cópia no SD",
        ["Discover: couldn't save Options (%s)"] = "Discover: não foi possível salvar as Opções (%s)",
        ["Wish list SD copy: %s"] = "Cópia da lista no SD: %s",
        ["Back up wish list to SD now"] = "Fazer backup da lista no SD agora",
        ["Discover: wish list copied to the SD card"] = "Discover: lista de desejos copiada para o cartão SD",
        ["Restore wish list from SD copy"] = "Restaurar lista de desejos da cópia no SD",
        ["Options"] = "Opções",
        ["Discover"] = "Descobrir",
        ["Search Artist"] = "Pesquisar artista",
        ["Search Album"] = "Pesquisar álbum",
        ["Add By Hand"] = "Adicionar manualmente",
    },
    ru = {
        ["couldn't encode JSON"] = "не удалось закодировать JSON",
        ["plugin storage is full or unavailable"] = "хранилище плагина заполнено или недоступно",
        ["No internet connection -- check Wi-Fi and try again"] = "Нет подключения к интернету -- проверьте Wi-Fi и повторите попытку",
        ["Request failed (%s)"] = "Ошибка запроса (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover: сервер занят, повтор (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "сервер сейчас перегружен -- попробуйте через минуту",
        ["request failed (HTTP %s)"] = "ошибка запроса (HTTP %s)",
        ["Include Live albums"] = "Включать концертные альбомы",
        ["Include Demos"] = "Включать демозаписи",
        ["Include Mixtapes"] = "Включать микстейпы",
        ["Include Compilations"] = "Включать сборники",
        ["Include Soundtracks"] = "Включать саундтреки",
        ["Include Remixes"] = "Включать ремиксы",
        ["Include DJ mixes"] = "Включать DJ-миксы",
        ["Include Interviews"] = "Включать интервью",
        ["Include Spoken word"] = "Включать разговорный жанр",
        ["Include Audiobooks"] = "Включать аудиокниги",
        ["Include Audio dramas"] = "Включать аудиоспектакли",
        ["Include Field recordings"] = "Включать полевые записи",
        ["Include Broadcasts"] = "Включать эфирные записи",
        ["SD card not available"] = "SD-карта недоступна",
        ["no SD copy found"] = "копия на SD не найдена",
        ["SD copy is from a newer Discover -- update the plugin"] = "копия на SD создана в более новой версии Discover -- обновите плагин",
        ["SD copy can't be read"] = "не удалось прочитать копию на SD",
        ["couldn't write the SD copy"] = "не удалось записать копию на SD",
        ["couldn't finish the SD copy"] = "не удалось завершить запись копии на SD",
        ["wish list is invalid or has reached its 1000-item limit"] = "список желаемого повреждён или достиг лимита в 1000 записей",
        ["Discover: wish list restored from your SD copy"] = "Discover: список желаемого восстановлен из копии на SD",
        ["Discover: %s"] = "Discover: %s",
        ["Discover: wish list merged with your SD copy"] = "Discover: список желаемого объединён с копией на SD",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover: список желаемого обновлён из копии на SD (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "названия исполнителя и альбома не должны превышать 1024 байт",
        ["wish list ID is too long"] = "слишком длинный ID записи",
        ["wish list can contain up to 1000 items"] = "список желаемого вмещает до 1000 записей",
        ["Discover: couldn't save wish list (%s)"] = "Discover: не удалось сохранить список желаемого (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover: не удалось сохранить подтверждения (%s)",
        ["Discover: removed %d item you already have"] = "Discover: удалена %d запись, которая уже есть в фонотеке",
        ["Discover: removed %d items you already have"] = "Discover: удалено записей, которые уже есть в фонотеке: %d",
        ["Discover: couldn't save the release feed"] = "Discover: не удалось сохранить ленту релизов",
        ["Discover: couldn't save the release feed (%s)"] = "Discover: не удалось сохранить ленту релизов (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover: %d релизов ваших исполнителей (ожидается: %d) -- откройте Новинки и скорые релизы",
        ["couldn't read the releases feed"] = "не удалось прочитать ленту релизов",
        ["Discover: checking releases (%d of %d)..."] = "Discover: проверка релизов (%d из %d)...",
        ["Discover: already checking for new releases"] = "Discover: проверка новых релизов уже выполняется",
        ["Discover: already up to date this week"] = "Discover: уже обновлено на этой неделе",
        ["Discover: couldn't start scanning (%s)"] = "Discover: не удалось запустить сканирование (%s)",
        ["Discover: checking for new releases..."] = "Discover: проверка новых релизов...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover: проверка новых релизов (первый запуск: %d запросов, несколько минут)...",
        ["Albums"] = "Альбомы",
        ["EPs"] = "EP",
        ["Singles"] = "Синглы",
        ["albums"] = "альбомы",
        ["eps"] = "EP",
        ["singles"] = "синглы",
        ["couldn't read the response"] = "не удалось прочитать ответ",
        ["On Wish List"] = "В списке желаемого",
        ["Added to wish list"] = "Добавлено в список желаемого",
        ["Removed from wish list"] = "Удалено из списка желаемого",
        ["Artist: %s"] = "Исполнитель: %s",
        ["Type: %s"] = "Тип: %s",
        ["In your library"] = "В вашей фонотеке",
        ["Released: %s"] = "Выпущен: %s",
        ["Rating: %.1f (%d votes)"] = "Рейтинг: %.1f (голосов: %d)",
        ["Genres: %s"] = "Жанры: %s",
        ["Discover: loading %s..."] = "Discover: загрузка %s...",
        ["Discover: %s (showing basic info)"] = "Discover: %s (показаны основные сведения)",
        ["Discover: loading %s by %s..."] = "Discover: загрузка (%s — %s)...",
        ["Discover: %d %s hidden by your Options"] = "Discover: скрыто настройками: %d (%s)",
        ["Discover: no %s found for %s"] = "Discover: %s для %s не найдены",
        ["Discover: finding artists similar to %s..."] = "Discover: поиск похожих на %s исполнителей...",
        ["Discover: no recommendations found for %s"] = "Discover: рекомендации для %s не найдены",
        ["Similar to %s"] = "Похожие на %s",
        ["present"] = "н. в.",
        ["Find Similar Artists"] = "Найти похожих исполнителей",
        ["artist name is too long to search"] = "имя исполнителя слишком длинное для поиска",
        ["couldn't identify \"%s\" on MusicBrainz"] = "не удалось найти \"%s\" в MusicBrainz",
        ["Discover: looking up %s..."] = "Discover: поиск %s...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover: поисковый запрос не должен превышать 512 байт",
        ["Discover: searching artists..."] = "Discover: поиск исполнителей...",
        ["Discover: no artists found for \"%s\""] = "Discover: исполнители по запросу \"%s\" не найдены",
        ["Artist Results"] = "Найденные исполнители",
        ["Discover: searching albums..."] = "Discover: поиск альбомов...",
        ["Discover: no albums found for \"%s\""] = "Discover: альбомы по запросу \"%s\" не найдены",
        ["Album Results"] = "Найденные альбомы",
        ["Search artist"] = "Поиск исполнителя",
        ["Search album"] = "Поиск альбома",
        ["Discover: no library artists found"] = "Discover: в фонотеке не найдено исполнителей",
        ["My Artists"] = "Мои исполнители",
        ["Discover: no upcoming releases to show"] = "Discover: нет ожидаемых релизов",
        ["Discover: no released releases to show"] = "Discover: нет вышедших релизов",
        ["Upcoming"] = "Ожидаемые",
        ["Released (last %d days)"] = "Вышедшие (за %d дн.)",
        ["Checking releases (%d of %d)..."] = "Проверка релизов (%d из %d)...",
        ["Last checked %s -- tap to check again"] = "Проверено %s -- нажмите для повтора",
        ["Check for new releases now"] = "Проверить новые релизы сейчас",
        ["Upcoming, next %d months (%d)"] = "Ожидаемые, след. %d мес. (%d)",
        ["Released, last %d days (%d)"] = "Вышедшие, посл. %d дн. (%d)",
        ["%d more hidden by your Options"] = "Ещё %d скрыто вашими параметрами",
        ["No matches (scanned %d releases against %d of your artists)"] = "Совпадений нет (проверено %d релизов для %d ваших исполнителей)",
        ["New & Upcoming"] = "Новинки и скорые релизы",
        ["Artist"] = "Исполнитель",
        ["Album"] = "Альбом",
        ["Already on your wish list"] = "Уже в списке желаемого",
        ["%d possible match to confirm"] = "%d возможное совпадение для подтверждения",
        ["%d possible matches to confirm"] = "Возможных совпадений для подтверждения: %d",
        ["Wish List"] = "Список желаемого",
        ["Nothing here yet"] = "Здесь пока пусто",
        ["Discover: couldn't save confirmations (%s)"] = "Discover: не удалось сохранить подтверждения (%s)",
        ["Nothing to confirm"] = "Нечего подтверждать",
        ["Confirm Matches"] = "Подтверждение совпадений",
        ["waiting for the SD card"] = "ожидание SD-карты",
        ["changes not copied yet"] = "изменения ещё не скопированы",
        ["not created yet"] = "ещё не создана",
        ["in sync"] = "синхронизировано",
        ["Restore wish list"] = "Восстановить список желаемого",
        ["Replace my wish list with the SD copy (%d album)"] = "Заменить список копией с SD (%d альбом)",
        ["Replace my wish list with the SD copy (%d albums)"] = "Заменить список копией с SD (альбомов: %d)",
        ["Cancel"] = "Отмена",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover: не удалось сохранить резервную копию списка (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover: не удалось восстановить список желаемого (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover: список восстановлен, но не удалось обновить статус синхронизации SD",
        ["Discover: restored %d from the SD copy"] = "Discover: восстановлено из копии на SD: %d",
        ["Discover: couldn't save Options (%s)"] = "Discover: не удалось сохранить параметры (%s)",
        ["Wish list SD copy: %s"] = "Копия списка на SD: %s",
        ["Back up wish list to SD now"] = "Сохранить копию списка на SD сейчас",
        ["Discover: wish list copied to the SD card"] = "Discover: список желаемого скопирован на SD-карту",
        ["Restore wish list from SD copy"] = "Восстановить список из копии на SD",
        ["Options"] = "Параметры",
        ["Discover"] = "Обзор",
        ["Search Artist"] = "Поиск исполнителя",
        ["Search Album"] = "Поиск альбома",
        ["Add By Hand"] = "Добавить вручную",
    },
    uk = {
        ["couldn't encode JSON"] = "не вдалося закодувати JSON",
        ["plugin storage is full or unavailable"] = "сховище плагіна заповнене або недоступне",
        ["No internet connection -- check Wi-Fi and try again"] = "Немає з'єднання з інтернетом -- перевірте Wi-Fi і спробуйте знову",
        ["Request failed (%s)"] = "Помилка запиту (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover: сервер зайнятий, повтор (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "сервер зараз перевантажений -- спробуйте за хвилину",
        ["request failed (HTTP %s)"] = "помилка запиту (HTTP %s)",
        ["Include Live albums"] = "Включати концертні альбоми",
        ["Include Demos"] = "Включати демозаписи",
        ["Include Mixtapes"] = "Включати мікстейпи",
        ["Include Compilations"] = "Включати збірки",
        ["Include Soundtracks"] = "Включати саундтреки",
        ["Include Remixes"] = "Включати ремікси",
        ["Include DJ mixes"] = "Включати DJ-мікси",
        ["Include Interviews"] = "Включати інтерв'ю",
        ["Include Spoken word"] = "Включати розмовний жанр",
        ["Include Audiobooks"] = "Включати аудіокниги",
        ["Include Audio dramas"] = "Включати аудіовистави",
        ["Include Field recordings"] = "Включати польові записи",
        ["Include Broadcasts"] = "Включати ефірні записи",
        ["SD card not available"] = "SD-карта недоступна",
        ["no SD copy found"] = "копію на SD не знайдено",
        ["SD copy is from a newer Discover -- update the plugin"] = "копія на SD створена в новішій версії Discover -- оновіть плагін",
        ["SD copy can't be read"] = "не вдалося прочитати копію на SD",
        ["couldn't write the SD copy"] = "не вдалося записати копію на SD",
        ["couldn't finish the SD copy"] = "не вдалося завершити запис копії на SD",
        ["wish list is invalid or has reached its 1000-item limit"] = "список бажаного пошкоджений або досяг ліміту в 1000 записів",
        ["Discover: wish list restored from your SD copy"] = "Discover: список бажаного відновлено з копії на SD",
        ["Discover: %s"] = "Discover: %s",
        ["Discover: wish list merged with your SD copy"] = "Discover: список бажаного об'єднано з копією на SD",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover: список бажаного оновлено з копії на SD (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "назви виконавця та альбому мають бути не довшими за 1024 байти",
        ["wish list ID is too long"] = "занадто довгий ID запису",
        ["wish list can contain up to 1000 items"] = "список бажаного вміщує до 1000 записів",
        ["Discover: couldn't save wish list (%s)"] = "Discover: не вдалося зберегти список бажаного (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover: не вдалося зберегти підтвердження (%s)",
        ["Discover: removed %d item you already have"] = "Discover: видалено %d запис, який уже є у фонотеці",
        ["Discover: removed %d items you already have"] = "Discover: видалено записів, які вже є у фонотеці: %d",
        ["Discover: couldn't save the release feed"] = "Discover: не вдалося зберегти стрічку релізів",
        ["Discover: couldn't save the release feed (%s)"] = "Discover: не вдалося зберегти стрічку релізів (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover: %d релізів ваших виконавців (очікується: %d) -- відкрийте Новинки та очікувані",
        ["couldn't read the releases feed"] = "не вдалося прочитати стрічку релізів",
        ["Discover: checking releases (%d of %d)..."] = "Discover: перевірка релізів (%d із %d)...",
        ["Discover: already checking for new releases"] = "Discover: перевірка нових релізів уже триває",
        ["Discover: already up to date this week"] = "Discover: уже оновлено цього тижня",
        ["Discover: couldn't start scanning (%s)"] = "Discover: не вдалося запустити сканування (%s)",
        ["Discover: checking for new releases..."] = "Discover: перевірка нових релізів...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover: перевірка нових релізів (перший запуск: %d запитів, кілька хвилин)...",
        ["Albums"] = "Альбоми",
        ["EPs"] = "EP",
        ["Singles"] = "Сингли",
        ["albums"] = "альбоми",
        ["eps"] = "EP",
        ["singles"] = "сингли",
        ["couldn't read the response"] = "не вдалося прочитати відповідь",
        ["On Wish List"] = "У списку бажаного",
        ["Added to wish list"] = "Додано до списку бажаного",
        ["Removed from wish list"] = "Видалено зі списку бажаного",
        ["Artist: %s"] = "Виконавець: %s",
        ["Type: %s"] = "Тип: %s",
        ["In your library"] = "У вашій фонотеці",
        ["Released: %s"] = "Випущено: %s",
        ["Rating: %.1f (%d votes)"] = "Рейтинг: %.1f (голосів: %d)",
        ["Genres: %s"] = "Жанри: %s",
        ["Discover: loading %s..."] = "Discover: завантаження %s...",
        ["Discover: %s (showing basic info)"] = "Discover: %s (показано основні відомості)",
        ["Discover: loading %s by %s..."] = "Discover: завантаження (%s — %s)...",
        ["Discover: %d %s hidden by your Options"] = "Discover: приховано параметрами: %d (%s)",
        ["Discover: no %s found for %s"] = "Discover: %s для %s не знайдено",
        ["Discover: finding artists similar to %s..."] = "Discover: пошук схожих на %s виконавців...",
        ["Discover: no recommendations found for %s"] = "Discover: рекомендацій для %s не знайдено",
        ["Similar to %s"] = "Схожі на %s",
        ["present"] = "дотепер",
        ["Find Similar Artists"] = "Знайти схожих виконавців",
        ["artist name is too long to search"] = "ім'я виконавця занадто довге для пошуку",
        ["couldn't identify \"%s\" on MusicBrainz"] = "не вдалося знайти \"%s\" у MusicBrainz",
        ["Discover: looking up %s..."] = "Discover: пошук %s...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover: пошуковий запит не має перевищувати 512 байтів",
        ["Discover: searching artists..."] = "Discover: пошук виконавців...",
        ["Discover: no artists found for \"%s\""] = "Discover: виконавців за запитом \"%s\" не знайдено",
        ["Artist Results"] = "Знайдені виконавці",
        ["Discover: searching albums..."] = "Discover: пошук альбомів...",
        ["Discover: no albums found for \"%s\""] = "Discover: альбомів за запитом \"%s\" не знайдено",
        ["Album Results"] = "Знайдені альбоми",
        ["Search artist"] = "Пошук виконавця",
        ["Search album"] = "Пошук альбому",
        ["Discover: no library artists found"] = "Discover: у фонотеці не знайдено виконавців",
        ["My Artists"] = "Мої виконавці",
        ["Discover: no upcoming releases to show"] = "Discover: немає очікуваних релізів",
        ["Discover: no released releases to show"] = "Discover: немає випущених релізів",
        ["Upcoming"] = "Очікувані",
        ["Released (last %d days)"] = "Випущені (за %d дн.)",
        ["Checking releases (%d of %d)..."] = "Перевірка релізів (%d із %d)...",
        ["Last checked %s -- tap to check again"] = "Перевірено %s -- торкніться для повтору",
        ["Check for new releases now"] = "Перевірити нові релізи зараз",
        ["Upcoming, next %d months (%d)"] = "Очікувані, наст. %d міс. (%d)",
        ["Released, last %d days (%d)"] = "Випущені, ост. %d дн. (%d)",
        ["%d more hidden by your Options"] = "Ще %d приховано вашими параметрами",
        ["No matches (scanned %d releases against %d of your artists)"] = "Збігів немає (перевірено %d релізів для %d ваших виконавців)",
        ["New & Upcoming"] = "Новинки та очікувані",
        ["Artist"] = "Виконавець",
        ["Album"] = "Альбом",
        ["Already on your wish list"] = "Уже в списку бажаного",
        ["%d possible match to confirm"] = "%d можливий збіг для підтвердження",
        ["%d possible matches to confirm"] = "Можливих збігів для підтвердження: %d",
        ["Wish List"] = "Список бажаного",
        ["Nothing here yet"] = "Тут поки порожньо",
        ["Discover: couldn't save confirmations (%s)"] = "Discover: не вдалося зберегти підтвердження (%s)",
        ["Nothing to confirm"] = "Нічого підтверджувати",
        ["Confirm Matches"] = "Підтвердження збігів",
        ["waiting for the SD card"] = "очікування SD-карти",
        ["changes not copied yet"] = "зміни ще не скопійовано",
        ["not created yet"] = "ще не створено",
        ["in sync"] = "синхронізовано",
        ["Restore wish list"] = "Відновити список бажаного",
        ["Replace my wish list with the SD copy (%d album)"] = "Замінити список копією з SD (%d альбом)",
        ["Replace my wish list with the SD copy (%d albums)"] = "Замінити список копією з SD (альбомів: %d)",
        ["Cancel"] = "Скасувати",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover: не вдалося створити резервну копію списку (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover: не вдалося відновити список бажаного (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover: список відновлено, але не вдалося оновити статус синхронізації SD",
        ["Discover: restored %d from the SD copy"] = "Discover: відновлено з копії на SD: %d",
        ["Discover: couldn't save Options (%s)"] = "Discover: не вдалося зберегти параметри (%s)",
        ["Wish list SD copy: %s"] = "Копія списку на SD: %s",
        ["Back up wish list to SD now"] = "Зберегти копію списку на SD зараз",
        ["Discover: wish list copied to the SD card"] = "Discover: список бажаного скопійовано на SD-карту",
        ["Restore wish list from SD copy"] = "Відновити список із копії на SD",
        ["Options"] = "Параметри",
        ["Discover"] = "Огляд",
        ["Search Artist"] = "Пошук виконавця",
        ["Search Album"] = "Пошук альбому",
        ["Add By Hand"] = "Додати вручну",
    },
    vi = {
        ["couldn't encode JSON"] = "không thể mã hóa JSON",
        ["plugin storage is full or unavailable"] = "bộ nhớ plugin đã đầy hoặc không khả dụng",
        ["No internet connection -- check Wi-Fi and try again"] = "Không có kết nối internet -- hãy kiểm tra Wi-Fi và thử lại",
        ["Request failed (%s)"] = "Yêu cầu thất bại (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover: máy chủ bận, đang thử lại (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "máy chủ hiện đang bận -- hãy thử lại sau một phút",
        ["request failed (HTTP %s)"] = "yêu cầu thất bại (HTTP %s)",
        ["Include Live albums"] = "Bao gồm album biểu diễn trực tiếp",
        ["Include Demos"] = "Bao gồm bản demo",
        ["Include Mixtapes"] = "Bao gồm mixtape",
        ["Include Compilations"] = "Bao gồm album tuyển tập",
        ["Include Soundtracks"] = "Bao gồm nhạc phim",
        ["Include Remixes"] = "Bao gồm bản remix",
        ["Include DJ mixes"] = "Bao gồm bản DJ mix",
        ["Include Interviews"] = "Bao gồm phỏng vấn",
        ["Include Spoken word"] = "Bao gồm bản đọc",
        ["Include Audiobooks"] = "Bao gồm sách nói",
        ["Include Audio dramas"] = "Bao gồm kịch truyền thanh",
        ["Include Field recordings"] = "Bao gồm thu âm hiện trường",
        ["Include Broadcasts"] = "Bao gồm chương trình phát sóng",
        ["SD card not available"] = "thẻ SD không khả dụng",
        ["no SD copy found"] = "không tìm thấy bản sao trên SD",
        ["SD copy is from a newer Discover -- update the plugin"] = "bản sao SD từ phiên bản Discover mới hơn -- hãy cập nhật plugin",
        ["SD copy can't be read"] = "không thể đọc bản sao trên SD",
        ["couldn't write the SD copy"] = "không thể ghi bản sao lên SD",
        ["couldn't finish the SD copy"] = "không thể hoàn tất bản sao trên SD",
        ["wish list is invalid or has reached its 1000-item limit"] = "danh sách mong muốn không hợp lệ hoặc đã đạt giới hạn 1000 mục",
        ["Discover: wish list restored from your SD copy"] = "Discover: đã khôi phục danh sách mong muốn từ bản sao SD",
        ["Discover: %s"] = "Discover: %s",
        ["Discover: wish list merged with your SD copy"] = "Discover: đã gộp danh sách mong muốn với bản sao SD",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover: đã cập nhật danh sách mong muốn từ bản sao SD (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "tên nghệ sĩ và album phải từ 1024 byte trở xuống",
        ["wish list ID is too long"] = "ID danh sách mong muốn quá dài",
        ["wish list can contain up to 1000 items"] = "danh sách mong muốn chứa tối đa 1000 mục",
        ["Discover: couldn't save wish list (%s)"] = "Discover: không thể lưu danh sách mong muốn (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover: không thể lưu xác nhận khớp (%s)",
        ["Discover: removed %d item you already have"] = "Discover: đã xóa %d mục bạn đã có",
        ["Discover: removed %d items you already have"] = "Discover: đã xóa %d mục bạn đã có",
        ["Discover: couldn't save the release feed"] = "Discover: không thể lưu nguồn tin phát hành",
        ["Discover: couldn't save the release feed (%s)"] = "Discover: không thể lưu nguồn tin phát hành (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover: %d bản phát hành từ nghệ sĩ của bạn (%d sắp ra mắt) -- mở Mới & Sắp ra mắt",
        ["couldn't read the releases feed"] = "không thể đọc nguồn tin phát hành",
        ["Discover: checking releases (%d of %d)..."] = "Discover: đang kiểm tra bản phát hành (%d/%d)...",
        ["Discover: already checking for new releases"] = "Discover: đang kiểm tra bản phát hành mới rồi",
        ["Discover: already up to date this week"] = "Discover: đã cập nhật trong tuần này",
        ["Discover: couldn't start scanning (%s)"] = "Discover: không thể bắt đầu quét (%s)",
        ["Discover: checking for new releases..."] = "Discover: đang kiểm tra bản phát hành mới...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover: đang kiểm tra bản phát hành mới (lần đầu: %d yêu cầu, mất vài phút)...",
        ["Albums"] = "Album",
        ["EPs"] = "EP",
        ["Singles"] = "Đĩa đơn",
        ["albums"] = "album",
        ["eps"] = "EP",
        ["singles"] = "đĩa đơn",
        ["couldn't read the response"] = "không thể đọc phản hồi",
        ["On Wish List"] = "Trong danh sách mong muốn",
        ["Added to wish list"] = "Đã thêm vào danh sách mong muốn",
        ["Removed from wish list"] = "Đã xóa khỏi danh sách mong muốn",
        ["Artist: %s"] = "Nghệ sĩ: %s",
        ["Type: %s"] = "Loại: %s",
        ["In your library"] = "Có trong thư viện của bạn",
        ["Released: %s"] = "Phát hành: %s",
        ["Rating: %.1f (%d votes)"] = "Đánh giá: %.1f (%d lượt)",
        ["Genres: %s"] = "Thể loại: %s",
        ["Discover: loading %s..."] = "Discover: đang tải %s...",
        ["Discover: %s (showing basic info)"] = "Discover: %s (hiển thị thông tin cơ bản)",
        ["Discover: loading %s by %s..."] = "Discover: đang tải %s của %s...",
        ["Discover: %d %s hidden by your Options"] = "Discover: đã ẩn %d %s theo Tùy chọn của bạn",
        ["Discover: no %s found for %s"] = "Discover: không tìm thấy %s nào của %s",
        ["Discover: finding artists similar to %s..."] = "Discover: đang tìm nghệ sĩ tương tự %s...",
        ["Discover: no recommendations found for %s"] = "Discover: không tìm thấy gợi ý cho %s",
        ["Similar to %s"] = "Tương tự %s",
        ["present"] = "nay",
        ["Find Similar Artists"] = "Tìm nghệ sĩ tương tự",
        ["artist name is too long to search"] = "tên nghệ sĩ quá dài để tìm kiếm",
        ["couldn't identify \"%s\" on MusicBrainz"] = "không tìm thấy \"%s\" trên MusicBrainz",
        ["Discover: looking up %s..."] = "Discover: đang tra cứu %s...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover: từ khóa tìm kiếm phải từ 512 byte trở xuống",
        ["Discover: searching artists..."] = "Discover: đang tìm nghệ sĩ...",
        ["Discover: no artists found for \"%s\""] = "Discover: không tìm thấy nghệ sĩ cho \"%s\"",
        ["Artist Results"] = "Kết quả nghệ sĩ",
        ["Discover: searching albums..."] = "Discover: đang tìm album...",
        ["Discover: no albums found for \"%s\""] = "Discover: không tìm thấy album cho \"%s\"",
        ["Album Results"] = "Kết quả album",
        ["Search artist"] = "Tìm nghệ sĩ",
        ["Search album"] = "Tìm album",
        ["Discover: no library artists found"] = "Discover: không tìm thấy nghệ sĩ trong thư viện",
        ["My Artists"] = "Nghệ sĩ của tôi",
        ["Discover: no upcoming releases to show"] = "Discover: không có bản phát hành sắp ra mắt",
        ["Discover: no released releases to show"] = "Discover: không có bản phát hành mới",
        ["Upcoming"] = "Sắp ra mắt",
        ["Released (last %d days)"] = "Đã phát hành (%d ngày qua)",
        ["Checking releases (%d of %d)..."] = "Đang kiểm tra phát hành (%d/%d)...",
        ["Last checked %s -- tap to check again"] = "Kiểm tra lần cuối %s -- chạm để kiểm tra lại",
        ["Check for new releases now"] = "Kiểm tra bản phát hành mới ngay",
        ["Upcoming, next %d months (%d)"] = "Sắp ra mắt, %d tháng tới (%d)",
        ["Released, last %d days (%d)"] = "Đã phát hành, %d ngày qua (%d)",
        ["%d more hidden by your Options"] = "Đã ẩn thêm %d mục theo Tùy chọn",
        ["No matches (scanned %d releases against %d of your artists)"] = "Không có kết quả (đã quét %d bản phát hành với %d nghệ sĩ của bạn)",
        ["New & Upcoming"] = "Mới & Sắp ra mắt",
        ["Artist"] = "Nghệ sĩ",
        ["Album"] = "Album",
        ["Already on your wish list"] = "Đã có trong danh sách mong muốn",
        ["%d possible match to confirm"] = "%d mục khớp cần xác nhận",
        ["%d possible matches to confirm"] = "%d mục khớp cần xác nhận",
        ["Wish List"] = "Danh sách mong muốn",
        ["Nothing here yet"] = "Chưa có gì ở đây",
        ["Discover: couldn't save confirmations (%s)"] = "Discover: không thể lưu xác nhận (%s)",
        ["Nothing to confirm"] = "Không có gì cần xác nhận",
        ["Confirm Matches"] = "Xác nhận mục khớp",
        ["waiting for the SD card"] = "đang chờ thẻ SD",
        ["changes not copied yet"] = "thay đổi chưa được sao chép",
        ["not created yet"] = "chưa được tạo",
        ["in sync"] = "đã đồng bộ",
        ["Restore wish list"] = "Khôi phục danh sách mong muốn",
        ["Replace my wish list with the SD copy (%d album)"] = "Thay danh sách bằng bản sao trên SD (%d album)",
        ["Replace my wish list with the SD copy (%d albums)"] = "Thay danh sách bằng bản sao trên SD (%d album)",
        ["Cancel"] = "Hủy",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover: không thể sao lưu danh sách hiện tại (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover: không thể khôi phục danh sách mong muốn (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover: đã khôi phục danh sách nhưng không thể cập nhật trạng thái đồng bộ SD",
        ["Discover: restored %d from the SD copy"] = "Discover: đã khôi phục %d mục từ bản sao SD",
        ["Discover: couldn't save Options (%s)"] = "Discover: không thể lưu Tùy chọn (%s)",
        ["Wish list SD copy: %s"] = "Bản sao SD danh sách mong muốn: %s",
        ["Back up wish list to SD now"] = "Sao lưu danh sách lên SD ngay",
        ["Discover: wish list copied to the SD card"] = "Discover: đã sao chép danh sách mong muốn sang thẻ SD",
        ["Restore wish list from SD copy"] = "Khôi phục danh sách từ bản sao SD",
        ["Options"] = "Tùy chọn",
        ["Discover"] = "Khám phá",
        ["Search Artist"] = "Tìm nghệ sĩ",
        ["Search Album"] = "Tìm album",
        ["Add By Hand"] = "Thêm thủ công",
    },
    zh_CN = {
        ["couldn't encode JSON"] = "无法编码 JSON",
        ["plugin storage is full or unavailable"] = "插件存储已满或不可用",
        ["No internet connection -- check Wi-Fi and try again"] = "无网络连接 -- 请检查 Wi-Fi 后重试",
        ["Request failed (%s)"] = "请求失败 (%s)",
        ["Discover: server busy, retrying (%d/%d)..."] = "Discover：服务器繁忙，正在重试 (%d/%d)...",
        ["server is busy right now -- try again in a minute"] = "服务器当前繁忙 -- 请一分钟后重试",
        ["request failed (HTTP %s)"] = "请求失败 (HTTP %s)",
        ["Include Live albums"] = "包含现场专辑",
        ["Include Demos"] = "包含小样 (Demo)",
        ["Include Mixtapes"] = "包含混音带 (Mixtape)",
        ["Include Compilations"] = "包含合辑",
        ["Include Soundtracks"] = "包含原声带",
        ["Include Remixes"] = "包含混音作品 (Remix)",
        ["Include DJ mixes"] = "包含 DJ 混音",
        ["Include Interviews"] = "包含访谈",
        ["Include Spoken word"] = "包含口语作品",
        ["Include Audiobooks"] = "包含有声书",
        ["Include Audio dramas"] = "包含广播剧",
        ["Include Field recordings"] = "包含实地录音",
        ["Include Broadcasts"] = "包含广播节目",
        ["SD card not available"] = "SD 卡不可用",
        ["no SD copy found"] = "未找到 SD 卡副本",
        ["SD copy is from a newer Discover -- update the plugin"] = "SD 卡副本来自更新版本的 Discover -- 请更新插件",
        ["SD copy can't be read"] = "无法读取 SD 卡副本",
        ["couldn't write the SD copy"] = "无法写入 SD 卡副本",
        ["couldn't finish the SD copy"] = "无法完成 SD 卡副本写入",
        ["wish list is invalid or has reached its 1000-item limit"] = "心愿单无效或已达到 1000 项上限",
        ["Discover: wish list restored from your SD copy"] = "Discover：已从 SD 卡副本恢复心愿单",
        ["Discover: %s"] = "Discover：%s",
        ["Discover: wish list merged with your SD copy"] = "Discover：心愿单已与 SD 卡副本合并",
        ["Discover: wish list updated from SD copy (%d)"] = "Discover：已从 SD 卡副本更新心愿单 (%d)",
        ["artist and album names must be 1024 bytes or fewer"] = "艺人名和专辑名不得超过 1024 字节",
        ["wish list ID is too long"] = "心愿单 ID 过长",
        ["wish list can contain up to 1000 items"] = "心愿单最多可包含 1000 个项目",
        ["Discover: couldn't save wish list (%s)"] = "Discover：无法保存心愿单 (%s)",
        ["Discover: couldn't save match confirmations (%s)"] = "Discover：无法保存匹配确认 (%s)",
        ["Discover: removed %d item you already have"] = "Discover：已移除 %d 个你已拥有的项目",
        ["Discover: removed %d items you already have"] = "Discover：已移除 %d 个你已拥有的项目",
        ["Discover: couldn't save the release feed"] = "Discover：无法保存发行动态",
        ["Discover: couldn't save the release feed (%s)"] = "Discover：无法保存发行动态 (%s)",
        ["Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"] = "Discover：你的艺人有 %d 张作品（%d 张即将发行）-- 请打开“新发行与预告”",
        ["couldn't read the releases feed"] = "无法读取发行动态",
        ["Discover: checking releases (%d of %d)..."] = "Discover：正在检查发行作品 (%d/%d)...",
        ["Discover: already checking for new releases"] = "Discover：正在检查新发行作品中",
        ["Discover: already up to date this week"] = "Discover：本周已是最新",
        ["Discover: couldn't start scanning (%s)"] = "Discover：无法启动扫描 (%s)",
        ["Discover: checking for new releases..."] = "Discover：正在检查新发行作品...",
        ["Discover: checking for new releases (first run: %d requests, a few minutes)..."] = "Discover：正在检查新发行作品（首次运行：%d 个请求，需几分钟）...",
        ["Albums"] = "专辑",
        ["EPs"] = "EP",
        ["Singles"] = "单曲",
        ["albums"] = "专辑",
        ["eps"] = "EP",
        ["singles"] = "单曲",
        ["couldn't read the response"] = "无法读取响应内容",
        ["On Wish List"] = "在心愿单中",
        ["Added to wish list"] = "已添加到心愿单",
        ["Removed from wish list"] = "已从心愿单移除",
        ["Artist: %s"] = "艺人：%s",
        ["Type: %s"] = "类型：%s",
        ["In your library"] = "已在你的音乐库中",
        ["Released: %s"] = "发行年份：%s",
        ["Rating: %.1f (%d votes)"] = "评分：%.1f（%d 票）",
        ["Genres: %s"] = "流派：%s",
        ["Discover: loading %s..."] = "Discover：正在加载 %s...",
        ["Discover: %s (showing basic info)"] = "Discover：%s（仅显示基本信息）",
        ["Discover: loading %s by %s..."] = "Discover：正在加载%s（%s）...",
        ["Discover: %d %s hidden by your Options"] = "Discover：已有 %d 张%s被你的选项隐藏",
        ["Discover: no %s found for %s"] = "Discover：未找到%s（%s）",
        ["Discover: finding artists similar to %s..."] = "Discover：正在查找与 %s 相似的艺人...",
        ["Discover: no recommendations found for %s"] = "Discover：未找到 %s 的相似推荐",
        ["Similar to %s"] = "与 %s 相似",
        ["present"] = "至今",
        ["Find Similar Artists"] = "查找相似艺人",
        ["artist name is too long to search"] = "艺人名称过长，无法搜索",
        ["couldn't identify \"%s\" on MusicBrainz"] = "无法在 MusicBrainz 上识别“%s”",
        ["Discover: looking up %s..."] = "Discover：正在查找 %s...",
        ["Discover: search text must be 512 bytes or fewer"] = "Discover：搜索内容不得超过 512 字节",
        ["Discover: searching artists..."] = "Discover：正在搜索艺人...",
        ["Discover: no artists found for \"%s\""] = "Discover：未找到“%s”相关的艺人",
        ["Artist Results"] = "艺人搜索结果",
        ["Discover: searching albums..."] = "Discover：正在搜索专辑...",
        ["Discover: no albums found for \"%s\""] = "Discover：未找到“%s”相关的专辑",
        ["Album Results"] = "专辑搜索结果",
        ["Search artist"] = "搜索艺人",
        ["Search album"] = "搜索专辑",
        ["Discover: no library artists found"] = "Discover：音乐库中未找到艺人",
        ["My Artists"] = "我的艺人",
        ["Discover: no upcoming releases to show"] = "Discover：暂无即将发行的作品",
        ["Discover: no released releases to show"] = "Discover：暂无近期已发行的作品",
        ["Upcoming"] = "即将发行",
        ["Released (last %d days)"] = "已发行（最近 %d 天）",
        ["Checking releases (%d of %d)..."] = "正在检查发行作品 (%d/%d)...",
        ["Last checked %s -- tap to check again"] = "上次检查 %s -- 点按重新检查",
        ["Check for new releases now"] = "立即检查新发行作品",
        ["Upcoming, next %d months (%d)"] = "即将发行，未来 %d 个月 (%d)",
        ["Released, last %d days (%d)"] = "已发行，最近 %d 天 (%d)",
        ["%d more hidden by your Options"] = "另有 %d 项被你的选项隐藏",
        ["No matches (scanned %d releases against %d of your artists)"] = "无匹配结果（已扫描 %d 张作品，比对 %d 位艺人）",
        ["New & Upcoming"] = "新发行与预告",
        ["Artist"] = "艺人",
        ["Album"] = "专辑",
        ["Already on your wish list"] = "已在你的心愿单中",
        ["%d possible match to confirm"] = "%d 个待确认的可能匹配",
        ["%d possible matches to confirm"] = "%d 个待确认的可能匹配",
        ["Wish List"] = "心愿单",
        ["Nothing here yet"] = "这里还没有内容",
        ["Discover: couldn't save confirmations (%s)"] = "Discover：无法保存确认结果 (%s)",
        ["Nothing to confirm"] = "没有需要确认的项目",
        ["Confirm Matches"] = "确认匹配",
        ["waiting for the SD card"] = "正在等待 SD 卡",
        ["changes not copied yet"] = "更改尚未复制",
        ["not created yet"] = "尚未创建",
        ["in sync"] = "已同步",
        ["Restore wish list"] = "恢复心愿单",
        ["Replace my wish list with the SD copy (%d album)"] = "用 SD 卡副本替换我的心愿单（%d 张专辑）",
        ["Replace my wish list with the SD copy (%d albums)"] = "用 SD 卡副本替换我的心愿单（%d 张专辑）",
        ["Cancel"] = "取消",
        ["Discover: couldn't back up the current wish list (%s)"] = "Discover：无法备份当前心愿单 (%s)",
        ["Discover: couldn't restore wish list (%s)"] = "Discover：无法恢复心愿单 (%s)",
        ["Discover: restored the list, but couldn't update SD sync status"] = "Discover：已恢复心愿单，但无法更新 SD 同步状态",
        ["Discover: restored %d from the SD copy"] = "Discover：已从 SD 卡副本恢复 %d 项",
        ["Discover: couldn't save Options (%s)"] = "Discover：无法保存选项 (%s)",
        ["Wish list SD copy: %s"] = "心愿单 SD 卡副本：%s",
        ["Back up wish list to SD now"] = "立即备份心愿单到 SD 卡",
        ["Discover: wish list copied to the SD card"] = "Discover：心愿单已复制到 SD 卡",
        ["Restore wish list from SD copy"] = "从 SD 卡副本恢复心愿单",
        ["Options"] = "选项",
        ["Discover"] = "发现",
        ["Search Artist"] = "搜索艺人",
        ["Search Album"] = "搜索专辑",
        ["Add By Hand"] = "手动添加",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

local REQUIRED_CAPS = {
    "ui.list", "ui.settings", "ui.settings_list_wrap",
    "library.paged", "network.http.async", "data.json",
    "storage.namespaced",
}

for _, cap in ipairs(REQUIRED_CAPS) do
    if not plugin.has_capability(cap) then
        return
    end
end

-- text helpers

local function trim(s)
    return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function normalize_name(s)
    if not s then return "" end
    s = s:lower()
    s = s:gsub("^the%s+", "")
    s = s:gsub("%sfeat%.?.*$", "")
    s = s:gsub("%sfeaturing.*$", "")
    s = s:gsub("%sft%.?%s.*$", "")
    s = s:gsub("[^%w%s]", "")
    s = s:gsub("%s+", " ")
    return trim(s)
end

-- drops trailing (...) and [...] groups
local function normalize_album_title(s)
    if not s then return "" end
    local prev
    repeat
        prev = s
        s = s:gsub("%s*%b()%s*$", "")
        s = s:gsub("%s*%b[]%s*$", "")
    until s == prev
    return normalize_name(s)
end

local function json_dump(value)
    local text, err = plugin.json_encode(value, { max_output_bytes = 262144 })
    if type(text) ~= "string" then return nil, err or tr("couldn't encode JSON") end
    return text
end

local function storage_json_set(key, value)
    local text, encode_err = json_dump(value)
    if not text then return false, encode_err end
    local ok, storage_err = plugin.storage.set(key, text)
    if not ok then return false, storage_err or tr("plugin storage is full or unavailable") end
    return true
end

local function json_load(text, default)
    if not text or text == "" then return default end
    local value, err = plugin.json_decode(text, { max_input_bytes = 524288 })
    if not value or (default ~= nil and type(value) ~= type(default)) then return default end
    return value
end

-- network helpers

-- no api for wifi state, so map connection errors to a readable message
local CONNECTION_ERRORS = {
    dns_failure = true, connect_failed = true, connect_timeout = true, timeout = true,
}

local function friendly_request_error(err)
    if CONNECTION_ERRORS[err] then
        return tr("No internet connection -- check Wi-Fi and try again")
    end
    return string.format(tr("Request failed (%s)"), tostring(err))
end

-- slow requests get a toast so the ui doesn't look frozen
local function loading_toast(message)
    plugin.show_toast(message, 4000)
end

-- runs fn after a delay, or right away if no timer is available
local function delayed(seconds, fn)
    local handle
    local ok, result = pcall(plugin.set_interval, seconds, function()
        if handle then
            plugin.clear_interval(handle)
            handle = nil
        end
        fn()
    end)
    if ok then
        handle = result
    else
        fn()
    end
end

-- musicbrainz/listenbrainz return 503 when busy; retry only those, spaced out
local MAX_RETRIES = 3
local RETRY_DELAY_SECONDS = 2

local function request_with_retry(options, on_done, attempt)
    attempt = attempt or 0
    local handle, start_err = plugin.http_request(options, function(status, body, req_err, headers)
        if status == 503 and attempt < MAX_RETRIES then
            plugin.show_toast(string.format(tr("Discover: server busy, retrying (%d/%d)..."), attempt + 1, MAX_RETRIES), 3000)
            delayed(RETRY_DELAY_SECONDS, function()
                request_with_retry(options, on_done, attempt + 1)
            end)
            return
        end
        on_done(status, body, req_err, headers)
    end)
    if not handle then
        on_done(nil, nil, tostring(start_err), nil)
    end
end

local function friendly_status_error(status)
    if status == 503 then
        return tr("server is busy right now -- try again in a minute")
    end
    return string.format(tr("request failed (HTTP %s)"), tostring(status))
end

-- options

local SECONDARY_TYPE_OPTIONS = {
    { key = "Live", label = "Include Live albums" },
    { key = "Demo", label = "Include Demos" },
    { key = "Mixtape/Street", label = "Include Mixtapes" },
    { key = "Compilation", label = "Include Compilations" },
    { key = "Soundtrack", label = "Include Soundtracks" },
    { key = "Remix", label = "Include Remixes" },
    { key = "DJ-mix", label = "Include DJ mixes" },
    { key = "Interview", label = "Include Interviews" },
    { key = "Spokenword", label = "Include Spoken word" },
    { key = "Audiobook", label = "Include Audiobooks" },
    { key = "Audio drama", label = "Include Audio dramas" },
    { key = "Field recording", label = "Include Field recordings" },
    { key = "Broadcast", label = "Include Broadcasts" },
}

local DEFAULT_SECONDARY_ON = {}

local OPTIONS_KEY = "options"

local function load_options()
    local saved = json_load(plugin.storage.get(OPTIONS_KEY), {})
    if type(saved) ~= "table" then saved = {} end
    local opts = {}
    for _, t in ipairs(SECONDARY_TYPE_OPTIONS) do
        if type(saved[t.key]) == "boolean" then
            opts[t.key] = saved[t.key]
        else
            opts[t.key] = DEFAULT_SECONDARY_ON[t.key] or false
        end
    end
    return opts
end

local function save_option(key, value)
    local saved = json_load(plugin.storage.get(OPTIONS_KEY), {})
    if type(saved) ~= "table" then saved = {} end
    saved[key] = value and true or false
    return storage_json_set(OPTIONS_KEY, saved)
end

local function release_types_allowed(secondary_types, opts)
    for _, t in ipairs(secondary_types or {}) do
        if opts[t] == false then return false end
    end
    return true
end

-- icons and artist filtering

local ICON_MENU = "Discover/discover.png"
local ICON_BLANK = "Discover/blank.png"
local ICON_OWNED = "Discover/owned.png"
local ICON_WISH = "Discover/wish.png"
local ICON_OWNED_WISH = "Discover/owned_wish.png"

-- Store assets live beside the plugin script, while UI icons resolve under
-- the theme root. Copy the bundled images into the plugin icon namespace at
-- load time so the paths used by list rows can resolve.
local function install_icon(name)
    pcall(plugin.set_icon, "Discover/" .. name, plugin.sd_root() .. "/.plugins/Discover/" .. name)
end

install_icon("discover.png")
install_icon("blank.png")
install_icon("owned.png")
install_icon("wish.png")
install_icon("owned_wish.png")

local function marker_icon(owned, wished)
    if owned and wished then return ICON_OWNED_WISH end
    if owned then return ICON_OWNED end
    if wished then return ICON_WISH end
    return ICON_BLANK
end

-- could become a table of excluded mbids/names if more artists are reported
local VARIOUS_ARTISTS_MBID = "89ad4ac3-39f7-470e-963a-56509c546377"
local VARIOUS_ARTISTS_NAMES = { ["various artists"] = true, ["various"] = true }

local function is_various_artists(artist_name, artist_mbids)
    for _, id in ipairs(artist_mbids or {}) do
        if id == VARIOUS_ARTISTS_MBID then return true end
    end
    return VARIOUS_ARTISTS_NAMES[normalize_name(artist_name)] == true
end

-- wish list storage
-- entries mean "want it" and are removed once owned; each caches its musicbrainz detail
-- plugin.storage is the primary copy, mirrored to <sd>/.plugins/Discover/wishlist.json
-- internal missing/unparseable: restore from sd. sd mtime newer than recorded: pull (merge if dirty)
-- mtime unreadable: push only. "newer" uses our recorded mtime, not the clock; older files are ignored
-- mirror is only touched while the card is mounted and not exported over usb

local MIRROR_FILE_NAME = "wishlist.json"
local USB_STORAGE_LUN_FILE = "/sys/kernel/config/usb_gadget/android0/functions/mass_storage.0/lun.0/file"

local function mirror_dir() return plugin.sd_root() .. "/.plugins/Discover" end
local function mirror_path() return mirror_dir() .. "/" .. MIRROR_FILE_NAME end

local function read_text_file(path)
    local f = io.open(path, "rb")
    if not f then return nil end
    local data = f:read("*a")
    f:close()
    return data
end

local function read_limited_text_file(path, max_bytes)
    local f = io.open(path, "rb")
    if not f then return nil end
    local data = f:read(max_bytes + 1)
    f:close()
    if not data or #data > max_bytes then return nil end
    return data
end

local function file_exists(path)
    local f = io.open(path, "rb")
    if f then
        f:close()
        return true
    end
    return false
end

-- compares the last two path parts since /data is a symlink and /proc/mounts shows the real path
local function sd_mounted()
    local mounts = read_text_file("/proc/mounts")
    if not mounts then return false end -- can't verify, so skip writes
    local root = plugin.sd_root()
    local tail = root:match("[^/]+/[^/]+$") or root
    for mount_point in mounts:gmatch("%S+%s+(%S+)%s") do
        if mount_point:sub(-#tail) == tail then return true end
    end
    return false
end

-- the host owns the card while it's exported as usb storage
local function usb_storage_active()
    local lun = read_text_file(USB_STORAGE_LUN_FILE)
    return lun ~= nil and trim(lun) ~= ""
end

local function mirror_writable()
    return sd_mounted() and not usb_storage_active()
end

local function valid_wishlist(value)
    if type(value) ~= "table" then return false end
    local count = #value
    for key in pairs(value) do
        if type(key) ~= "number" or key < 1 or key > count or key % 1 ~= 0 then return false end
    end
    if count > 1000 then return false end
    for _, e in ipairs(value) do
        if type(e) ~= "table" or type(e.id) ~= "string" or e.id == ""
            or type(e.artist) ~= "string" or e.artist == ""
            or type(e.album) ~= "string" or e.album == ""
            or #e.id > 2048 or #e.artist > 1024 or #e.album > 1024 then
            return false
        end
        if (e.added_at ~= nil and type(e.added_at) ~= "number")
            or (e.year ~= nil and type(e.year) ~= "string")
            or (e.release_group_mbid ~= nil and type(e.release_group_mbid) ~= "string")
            or (e.release_type ~= nil and type(e.release_type) ~= "string")
            or (e.source ~= nil and type(e.source) ~= "string")
            or (e.cached_info ~= nil and type(e.cached_info) ~= "table") then
            return false
        end
        if type(e.cached_info) == "table" then
            local info = e.cached_info
            if (info.disambiguation ~= nil and type(info.disambiguation) ~= "string")
                or (info.rating_value ~= nil and type(info.rating_value) ~= "number")
                or (info.rating_votes ~= nil and type(info.rating_votes) ~= "number")
                or (info.artist_mbid ~= nil and type(info.artist_mbid) ~= "string")
                or (info.genres ~= nil and type(info.genres) ~= "table") then
                return false
            end
            for _, genre in ipairs(info.genres or {}) do
                if type(genre) ~= "string" then return false end
            end
        end
    end
    return true
end

-- saved format: { version, plugin_version, saved_at, entries }; a bare array loads as version 0
-- returns entries, version; or nil + "unreadable" / "newer" (written by a newer format, left alone)
local function decode_wishlist_text(text)
    if not text or text == "" then return nil, "unreadable" end
    local value = plugin.json_decode(text, { max_input_bytes = 524288 })
    if type(value) ~= "table" then return nil, "unreadable" end

    local entries, version
    if value.entries ~= nil or value.version ~= nil then
        version = tonumber(value.version)
        if not version then return nil, "unreadable" end
        if version > WISHLIST_FORMAT_VERSION then return nil, "newer" end
        entries = value.entries or {}
    else
        entries, version = value, 0
    end

    if not valid_wishlist(entries) then return nil, "unreadable" end
    return entries, version
end

local function wishlist_envelope(list)
    return {
        version = WISHLIST_FORMAT_VERSION,
        plugin_version = PLUGIN_VERSION,
        saved_at = os.time(),
        entries = list,
    }
end

local function mirror_mtime()
    if not mirror_writable() then return nil end
    for _, e in ipairs(plugin.list_dir(mirror_dir()) or {}) do
        if e.name == MIRROR_FILE_NAME and not e.dir then return e.modified end
    end
    return nil
end

local function read_mirror()
    if not mirror_writable() then return nil, tr("SD card not available") end
    local text = read_limited_text_file(mirror_path(), 524288)
    if not text then return nil, tr("no SD copy found") end
    local list, why = decode_wishlist_text(text)
    if not list then
        if why == "newer" then return nil, tr("SD copy is from a newer Discover -- update the plugin") end
        return nil, tr("SD copy can't be read")
    end
    return list
end

local function record_mirror_mtime()
    local mt = mirror_mtime()
    if mt then
        plugin.storage.set("wishlist_mirror_mtime", tostring(mt))
    else
        plugin.storage.delete("wishlist_mirror_mtime")
    end
end

-- writes via temp file + rename, keeping the old one as .bak
local function write_mirror(list)
    if not mirror_writable() then return false, tr("SD card not available") end
    plugin.mkdir(mirror_dir())

    local path = mirror_path()
    local tmp, bak = path .. ".tmp", path .. ".bak"
    local f, open_err = io.open(tmp, "wb")
    if not f then return false, tostring(open_err) end

    local text, encode_err = json_dump(wishlist_envelope(list))
    if not text then
        f:close()
        os.remove(tmp)
        return false, encode_err
    end
    local wrote, write_err = f:write(text)
    local closed, close_err = f:close()
    if not wrote or not closed then
        os.remove(tmp)
        return false, tostring(write_err or close_err or tr("couldn't write the SD copy"))
    end

    if file_exists(path) then
        os.remove(bak)
        os.rename(path, bak)
    end
    local renamed = os.rename(tmp, path)
    if not renamed then
        if file_exists(bak) and not file_exists(path) then os.rename(bak, path) end
        os.remove(tmp)
        return false, tr("couldn't finish the SD copy")
    end

    record_mirror_mtime()
    plugin.storage.set("wishlist_mirror_dirty", "0")
    return true
end

-- returns list, status (ok/missing/corrupt), raw text if corrupt, format version if ok
local function read_internal_wishlist()
    local raw = plugin.storage.get("wishlist")
    if raw == nil then return nil, "missing" end
    local list, version = decode_wishlist_text(raw)
    if list then return list, "ok", nil, version end
    return nil, "corrupt", raw
end

local function merge_wishlists(a, b)
    local out, seen = {}, {}
    for _, list in ipairs({ a, b }) do
        for _, e in ipairs(list) do
            if not seen[e.id] then
                seen[e.id] = true
                out[#out + 1] = e
            end
        end
    end
    return out
end

local function save_wishlist(list)
    if not valid_wishlist(list) then
        return false, tr("wish list is invalid or has reached its 1000-item limit")
    end
    local stored, storage_err = storage_json_set("wishlist", wishlist_envelope(list))
    if not stored then return false, storage_err end
    local mirrored = write_mirror(list)
    if not mirrored then plugin.storage.set("wishlist_mirror_dirty", "1") end
    return true
end

local function sync_wishlist_mirror()
    local internal, status, raw, internal_version = read_internal_wishlist()

    if status == "corrupt" then
        plugin.storage.set("wishlist_corrupt", raw) -- keep the bad data
        local mirrored = read_mirror()
        if mirrored then
            local stored = storage_json_set("wishlist", wishlist_envelope(mirrored))
            if not stored then return "restore_failed" end
            record_mirror_mtime()
            plugin.show_toast(tr("Discover: wish list restored from your SD copy"))
            return "restored_corrupt"
        end
        return "corrupt_no_mirror"
    end

    if status == "missing" then
        local mirrored = read_mirror()
        if mirrored then
            local stored = storage_json_set("wishlist", wishlist_envelope(mirrored))
            if not stored then return "restore_failed" end
            record_mirror_mtime()
            return "restored_missing"
        end
        return "nothing"
    end

    local upgraded = internal_version ~= WISHLIST_FORMAT_VERSION
    if upgraded then
        local stored = storage_json_set("wishlist", wishlist_envelope(internal))
        if not stored then return "upgrade_failed" end
    end

    if not mirror_writable() then return "sd_unavailable" end

    local dirty = plugin.storage.get("wishlist_mirror_dirty", "0") == "1"
    if not file_exists(mirror_path()) then
        write_mirror(internal)
        return "mirror_created"
    end

    local mt = mirror_mtime()
    if mt == nil then
        if dirty or upgraded then write_mirror(internal) end
        return "no_mtime"
    end

    local recorded = tonumber(plugin.storage.get("wishlist_mirror_mtime", ""))
    if recorded == nil then
        write_mirror(internal)
        return "adopted"
    end

    if mt > recorded then
        local mirrored, why = read_mirror()
        if not mirrored then
            if why == tr("SD copy is from a newer Discover -- update the plugin") then
                plugin.show_toast(string.format(tr("Discover: %s"), why))
            end
            return "mirror_unreadable"
        end
        if dirty then
            local saved = save_wishlist(merge_wishlists(internal, mirrored))
            if not saved then return "merge_failed" end
            plugin.show_toast(tr("Discover: wish list merged with your SD copy"))
            return "merged"
        end
        local stored = storage_json_set("wishlist", wishlist_envelope(mirrored))
        if not stored then return "pull_failed" end
        record_mirror_mtime()
        plugin.show_toast(string.format(tr("Discover: wish list updated from SD copy (%d)"), #mirrored))
        return "pulled"
    end

    if dirty or upgraded then
        write_mirror(internal)
        return "pushed"
    end
    return "in_sync"
end

local function load_wishlist()
    local list, status = read_internal_wishlist()
    if status == "ok" then return list end

    sync_wishlist_mirror()
    list, status = read_internal_wishlist()
    if status == "ok" then return list end
    return {}
end

local function make_entry_id(artist, album, release_group_mbid)
    if release_group_mbid and release_group_mbid ~= "" then
        return "mbid:" .. release_group_mbid
    end
    return "na:" .. normalize_name(artist) .. "|" .. normalize_album_title(album)
end

local function find_wishlist_entry(id)
    for _, e in ipairs(load_wishlist()) do
        if e.id == id then return e end
    end
    return nil
end

local function is_on_wishlist(id)
    return find_wishlist_entry(id) ~= nil
end

-- newest first, ties keep stored order
local function wishlist_display_order(list)
    local indexed = {}
    for i, e in ipairs(list) do
        indexed[i] = { e = e, i = i }
    end

    table.sort(indexed, function(a, b)
        local ta, tb = a.e.added_at or 0, b.e.added_at or 0
        if ta ~= tb then return ta > tb end
        return a.i < b.i
    end)

    local out = {}
    for i, item in ipairs(indexed) do
        out[i] = item.e
    end
    return out
end

local function wishlist_checker()
    local ids = {}
    for _, e in ipairs(load_wishlist()) do
        ids[e.id] = true
    end
    return function(artist, title, mbid)
        if mbid and ids[make_entry_id(artist, title, mbid)] then return true end
        return ids[make_entry_id(artist, title, nil)] == true
    end
end

local function add_wishlist_entry(artist, album, year, release_group_mbid, release_type, source, cached_info)
    if #artist > 1024 or #album > 1024 then
        return nil, nil, tr("artist and album names must be 1024 bytes or fewer")
    end
    local id = make_entry_id(artist, album, release_group_mbid)
    if #id > 2048 then return nil, nil, tr("wish list ID is too long") end
    local wishlist = load_wishlist()
    if #wishlist >= 1000 then return nil, id, tr("wish list can contain up to 1000 items") end
    for _, e in ipairs(wishlist) do
        if e.id == id then return false, id end
    end

    table.insert(wishlist, 1, {
        id = id,
        artist = artist,
        album = album,
        year = year,
        release_group_mbid = release_group_mbid,
        release_type = release_type,
        source = source,
        added_at = os.time(),
        cached_info = cached_info,
    })
    local saved, err = save_wishlist(wishlist)
    if not saved then return nil, id, err end
    return true, id
end

local function remove_wishlist_entries(id_set)
    local wishlist = load_wishlist()
    local remaining, removed = {}, 0
    for _, e in ipairs(wishlist) do
        if id_set[e.id] then
            removed = removed + 1
        else
            table.insert(remaining, e)
        end
    end
    if removed > 0 then
        local saved, err = save_wishlist(remaining)
        if not saved then return 0, err end
    end
    return removed
end

local function remove_wishlist_entry(id)
    local removed, err = remove_wishlist_entries({ [id] = true })
    if err then return nil, err end
    return removed > 0
end

-- library lookups

-- normalized artist name -> name as spelled in the library
local function build_artist_index()
    local index = {}
    local offset = 0
    while true do
        local groups = plugin.library_get_artists(offset, 200)
        if not groups or #groups == 0 then break end
        for _, g in ipairs(groups) do
            local key = normalize_name(g.name)
            if key ~= "" and not index[key] then
                index[key] = g.name
            end
        end
        if #groups < 200 then break end
        offset = offset + 200
    end
    return index
end

local function build_owned_album_set(library_artist)
    local owned = {}
    if not library_artist then return owned end
    local offset = 0
    while true do
        local albums = plugin.library_get_albums(offset, 200, library_artist)
        if not albums or #albums == 0 then break end
        for _, a in ipairs(albums) do
            owned[normalize_album_title(a.name)] = true
        end
        if #albums < 200 then break end
        offset = offset + 200
    end
    return owned
end

-- returns fn(artist, title) -> owned; reads artists once and each artist's albums at most once
local function owned_checker()
    local index = build_artist_index()
    local cache = {}
    return function(artist, title)
        local library_artist = index[normalize_name(artist)]
        if not library_artist then return false end
        if not cache[library_artist] then
            cache[library_artist] = build_owned_album_set(library_artist)
        end
        return cache[library_artist][normalize_album_title(title)] == true
    end
end

-- auto check-off
-- exact matches are removed; loose matches wait in a possible-matches list for confirmation

local LAST_SONG_COUNT_KEY = "last_song_count"
local LAST_SCAN_AT_KEY = "last_scan_at"
local POSSIBLE_MATCHES_KEY = "possible_matches"
local SCAN_MAX_AGE_SECONDS = 24 * 3600

local function load_possible_matches()
    return json_load(plugin.storage.get(POSSIBLE_MATCHES_KEY), {})
end

local function save_possible_matches(list)
    return storage_json_set(POSSIBLE_MATCHES_KEY, list)
end

-- skipping or repeating a scan is harmless, matching is rederived each time
local scan_running = false

local function run_autocheck_scan()
    if scan_running then return end
    scan_running = true

    local wishlist = load_wishlist()
    if #wishlist == 0 then
        scan_running = false
        return
    end

    local artist_index = build_artist_index()
    local possible = load_possible_matches()
    local changed = false
    local to_remove, removed_count = {}, 0

    for _, entry in ipairs(wishlist) do
        local matched = false
        local norm_artist = normalize_name(entry.artist)
        local library_artist = artist_index[norm_artist]

        if library_artist then
            local owned = build_owned_album_set(library_artist)
            if owned[normalize_album_title(entry.album)] then
                matched = true
            end
        end

        if matched then
            to_remove[entry.id] = true
            removed_count = removed_count + 1
            changed = true
        else
            -- loose fallback: find songs by album title, then check the artist loosely
            local songs = plugin.library_get_songs(0, 20, { album = entry.album })
            if songs and #songs > 0 then
                local song_artist_norm = normalize_name(songs[1].artist)
                local loose = song_artist_norm ~= "" and norm_artist ~= "" and
                    (song_artist_norm:find(norm_artist, 1, true) or
                     norm_artist:find(song_artist_norm, 1, true))
                if loose then
                    local already = false
                    for _, p in ipairs(possible) do
                        if p.id == entry.id then
                            already = true
                            break
                        end
                    end
                    if not already then
                        table.insert(possible, entry)
                        changed = true
                    end
                end
            end
        end
    end

    if removed_count > 0 then
        local removed, remove_err = remove_wishlist_entries(to_remove)
        if remove_err then
            scan_running = false
            plugin.show_toast(string.format(tr("Discover: couldn't save wish list (%s)"), tostring(remove_err)))
            return
        end
        removed_count = removed
    end

    if changed then
        local saved, save_err = save_possible_matches(possible)
        if not saved then
            scan_running = false
            plugin.show_toast(string.format(tr("Discover: couldn't save match confirmations (%s)"), tostring(save_err)))
            return
        end
        if removed_count > 0 then
            local fmt = removed_count == 1
                and tr("Discover: removed %d item you already have")
                or tr("Discover: removed %d items you already have")
            plugin.show_toast(string.format(fmt, removed_count))
        end
    end

    plugin.storage.set(LAST_SCAN_AT_KEY, tostring(os.time()))
    scan_running = false
end

local function maybe_run_autocheck()
    local last_count = tonumber(plugin.storage.get(LAST_SONG_COUNT_KEY, "-1")) or -1
    local current_count = plugin.library_song_count()
    local last_scan = tonumber(plugin.storage.get(LAST_SCAN_AT_KEY, "0")) or 0
    local age = os.time() - last_scan

    if current_count ~= last_count or age > SCAN_MAX_AGE_SECONDS then
        plugin.storage.set(LAST_SONG_COUNT_KEY, tostring(current_count))
        run_autocheck_scan()
    end
end

-- fresh releases feed: last FEED_PAST_DAYS and next FEED_FUTURE_DAYS, matched against library artists
-- the feed can't filter by artist and caps a window at 90 days, so windows are fetched one at a time
-- past windows are small to stay under the 2 mb response cap; oversized windows are split in half
-- only days since the last check are refetched, older matches are kept
-- scanning splits the body with plain string search and only decodes releases by library artists
-- falls back to a char-by-char scanner if the feed layout changes

local USER_AGENT = "Discover-CompasPlugin/" .. PLUGIN_VERSION .. " " ..
    "( https://github.com/Starnished66/compas-player )"

local FEED_BASE_URL = "https://api.listenbrainz.org/1/explore/fresh-releases/"
local FEED_PAST_DAYS = 90
local FEED_FUTURE_DAYS = 365
local FEED_API_MAX_DAYS = 90            -- api max window
local FEED_API_MIN_DAYS = 1             -- api min window (400 below it)
local FEED_PAST_WINDOW_DAYS = 10        -- days per past request, ~1.5 mb
local FEED_RESCAN_OVERLAP_DAYS = 3      -- recheck recent days for late additions
local FEED_MAX_RESPONSE_BYTES = 2097152
local FEED_MAX_AGE_SECONDS = 7 * 24 * 3600
local FEED_REQUEST_GAP_SECONDS = 1      -- gap between requests
local FEED_MAX_STORED_BYTES = 240000    -- storage values max out at 256 kb

-- scan slices are time-limited: the device is slow and a slice counts against the 2s lua budget
local TICK_TIME_BUDGET_SECONDS = 0.5    -- margin under the 2s limit
local TIME_CHECK_INTERVAL = 500         -- chars between clock checks (slow)
local OBJECTS_PER_TIME_CHECK = 50       -- releases between clock checks (fast)

local LAST_FEED_FETCH_KEY = "last_feed_fetch_at"
local FEED_COVERED_TO_KEY = "feed_covered_to"
local MATCHED_RELEASES_KEY = "matched_releases"
local LAST_SCAN_DIAGNOSTICS_KEY = "last_scan_diagnostics"

local function load_matched_releases()
    return json_load(plugin.storage.get(MATCHED_RELEASES_KEY), {})
end

-- dates are YYYY-MM-DD strings (sort as text); noon avoids dst date shifts
local function date_to_time(date_str)
    local y, m, d = tostring(date_str):match("^(%d%d%d%d)-(%d%d)-(%d%d)$")
    if not y then return nil end
    return os.time({ year = tonumber(y), month = tonumber(m), day = tonumber(d), hour = 12 })
end

local function time_to_date(t)
    return os.date("%Y-%m-%d", t)
end

local function add_days(date_str, n)
    return time_to_date(date_to_time(date_str) + n * 86400)
end

local function days_between(a, b)
    return math.floor((date_to_time(b) - date_to_time(a)) / 86400 + 0.5)
end

-- past window covers date-days..date, future covers date..date+days (inclusive)
-- returns windows, rescan_from, earliest
local function plan_feed_windows(today, covered_to)
    local earliest = add_days(today, -FEED_PAST_DAYS)
    local rescan_from = earliest

    -- a future covered-to date means the clock was wrong (no battery-backed clock), so ignore it
    if covered_to and covered_to > today then covered_to = nil end
    if covered_to and covered_to > earliest then
        rescan_from = add_days(covered_to, -FEED_RESCAN_OVERLAP_DAYS)
        if rescan_from < earliest then rescan_from = earliest end
    end

    local windows = {}
    local end_date = today
    while end_date >= rescan_from do
        local span = math.min(FEED_PAST_WINDOW_DAYS, days_between(rescan_from, end_date) + 1)
        -- api refuses days=0, so a lone day is asked for as two and trimmed later
        local days = math.max(FEED_API_MIN_DAYS, span - 1)
        windows[#windows + 1] = { release_date = end_date, days = days, past = true, future = false }
        end_date = add_days(end_date, -span)
    end

    local last_future = add_days(today, FEED_FUTURE_DAYS)
    local start = today
    while start <= last_future do
        local days = math.max(FEED_API_MIN_DAYS, math.min(FEED_API_MAX_DAYS, days_between(start, last_future)))
        windows[#windows + 1] = { release_date = start, days = days, past = false, future = true }
        start = add_days(start, days + 1)
    end

    return windows, rescan_from, earliest
end

-- halves an oversized window; nil if a half would be under 2 days (days=0 is refused)
local function split_window(w)
    local n = w.days + 1
    if n < 4 then return nil end
    local n1 = math.ceil(n / 2)
    if w.past then
        return { release_date = w.release_date, days = n1 - 1, past = true, future = false },
               { release_date = add_days(w.release_date, -n1), days = n - n1 - 1, past = true, future = false }
    end
    return { release_date = w.release_date, days = n1 - 1, past = false, future = true },
           { release_date = add_days(w.release_date, n1), days = n - n1 - 1, past = false, future = true }
end

local function window_url(w)
    return ("%s?release_date=%s&days=%d&past=%s&future=%s&sort=release_date"):format(
        FEED_BASE_URL, w.release_date, w.days, tostring(w.past), tostring(w.future))
end

-- byte range of the releases array body; must stay a c-speed match, a lua char loop blew the 2s budget
local function find_releases_array_body(body)
    local _, bracket_pos = body:find('"releases"%s*:%s*%[')
    if not bracket_pos then return nil end
    local last_close = body:match(".*()%]")
    if not last_close or last_close <= bracket_pos then return nil end
    return bracket_pos + 1, last_close - 1
end

-- feed refresh state

local feed_job = nil -- current refresh, nil when idle
local feed_timer = nil
local run_next_feed_window -- forward decl

local function stop_feed_timer()
    if feed_timer then
        plugin.clear_interval(feed_timer)
        feed_timer = nil
    end
end

local function abort_feed_job(message)
    stop_feed_timer()
    feed_job = nil
    plugin.show_toast(string.format(tr("Discover: %s"), message))
end

local function finish_feed_job()
    local job = feed_job
    stop_feed_timer()
    feed_job = nil

    -- windows can overshoot the range by a day, so drop anything outside it
    local first_day = add_days(job.today, -FEED_PAST_DAYS)
    local last_day = add_days(job.today, FEED_FUTURE_DAYS)
    local function in_range(r)
        local d = r.release_date or ""
        return d >= first_day and d <= last_day
    end

    local combined = {}
    for _, r in ipairs(job.retained) do
        if in_range(r) then combined[#combined + 1] = r end
    end
    for _, r in ipairs(job.found) do
        if in_range(r) then combined[#combined + 1] = r end
    end
    table.sort(combined, function(a, b) return (a.release_date or "") < (b.release_date or "") end)

    -- stay under the storage limit by dropping the oldest first
    local text = json_dump(combined)
    while (not text or #text > FEED_MAX_STORED_BYTES) and #combined > 0 do
        for _ = 1, math.max(1, math.floor(#combined * 0.1)) do
            table.remove(combined, 1)
        end
        text = json_dump(combined)
    end

    if not text then
        plugin.show_toast(tr("Discover: couldn't save the release feed"))
        return
    end
    local saved, save_err = plugin.storage.set(MATCHED_RELEASES_KEY, text)
    if not saved then
        plugin.show_toast(string.format(tr("Discover: couldn't save the release feed (%s)"), tostring(save_err)))
        return
    end
    plugin.storage.set(FEED_COVERED_TO_KEY, job.today)
    plugin.storage.set(LAST_FEED_FETCH_KEY, tostring(os.time()))

    -- diagnostics help explain a surprising "no matches"
    plugin.storage.set(LAST_SCAN_DIAGNOSTICS_KEY, json_dump({
        scanned = job.scanned,
        empty_windows = job.empty_windows,
        decode_failures = job.decode_failures,
        library_artist_count = job.library_artist_count,
        requests = job.requests,
    }))

    local upcoming = 0
    for _, r in ipairs(combined) do
        if (r.release_date or "") >= job.today then upcoming = upcoming + 1 end
    end
    plugin.show_toast(string.format(tr("Discover: %d releases from your artists (%d upcoming) -- open New & Upcoming"),
        #combined, upcoming), 6000)
end

-- reads the artist from raw text first so non-library releases are never decoded
local NAME_PATTERN = '^{"artist_credit_name":"([^"\\]*)"'

local function process_release_object(job, obj)
    job.scanned = job.scanned + 1

    local raw_name = obj:match(NAME_PATTERN)
    if raw_name and (not job.artist_index[normalize_name(raw_name)] or is_various_artists(raw_name, nil)) then
        return
    end

    local rel = plugin.json_decode(obj, { max_input_bytes = 65536 })
    if type(rel) ~= "table" then
        job.decode_failures = job.decode_failures + 1
        return
    end
    if type(rel.artist_credit_name) ~= "string" or type(rel.release_name) ~= "string"
        or type(rel.release_date) ~= "string"
        or (rel.artist_mbids ~= nil and type(rel.artist_mbids) ~= "table") then
        job.decode_failures = job.decode_failures + 1
        return
    end
    if not job.artist_index[normalize_name(rel.artist_credit_name)] then return end
    if is_various_artists(rel.artist_credit_name, rel.artist_mbids) then return end

    local key = rel.release_group_mbid or rel.release_mbid
    if key then
        if job.seen[key] then return end
        job.seen[key] = true
    end

    job.found[#job.found + 1] = {
        artist = rel.artist_credit_name,
        album = rel.release_name,
        release_date = rel.release_date,
        release_group_mbid = rel.release_group_mbid,
        release_group_primary_type = rel.release_group_primary_type,
        release_group_secondary_type = rel.release_group_secondary_type,
        artist_mbid = rel.artist_mbids and rel.artist_mbids[1],
    }
end

-- an empty window comes back as http 500 with this body, not an empty list
-- a bodyless 500 is only forgiven for future windows; a failing past window stops the run
local EMPTY_WINDOW_ERROR = "Server failed to get latest release"

local function is_empty_window_response(status, body, w)
    if status ~= 500 then return false end
    if type(body) == "string" and body:find(EMPTY_WINDOW_ERROR, 1, true) then return true end
    return w.future and (body == nil or body == "")
end

local function window_scan_done(job)
    job.scan = nil
    delayed(FEED_REQUEST_GAP_SECONDS, function()
        if feed_job == job then run_next_feed_window() end
    end)
end

local OBJECT_PREFIX = '{"artist_credit_name":'
local OBJECT_SEPARATOR = ',{"artist_credit_name":'

-- one time-limited slice of the current window
local function scan_tick()
    local job = feed_job
    if not job or not job.scan then return end

    local sc = job.scan
    local body, stop = sc.body, sc.stop
    local tick_start = os.clock()

    if sc.mode == "fast" then
        local done = 0
        while sc.pos <= stop do
            local sep = body:find(OBJECT_SEPARATOR, sc.pos + 1, true)
            local obj_end = sep and (sep - 1) or stop
            if obj_end > stop then obj_end = stop end

            process_release_object(job, body:sub(sc.pos, obj_end))
            sc.pos = sep and (sep + 1) or (stop + 1)

            done = done + 1
            if done % OBJECTS_PER_TIME_CHECK == 0 and os.clock() - tick_start > TICK_TIME_BUDGET_SECONDS then
                break
            end
        end
    else
        -- fallback: track string/brace state char by char
        local i, since_check = sc.pos, 0
        while i <= stop do
            since_check = since_check + 1
            if since_check >= TIME_CHECK_INTERVAL then
                since_check = 0
                if os.clock() - tick_start > TICK_TIME_BUDGET_SECONDS then break end
            end

            local c = body:sub(i, i)
            if sc.in_string then
                if sc.escape then
                    sc.escape = false
                elseif c == "\\" then
                    sc.escape = true
                elseif c == '"' then
                    sc.in_string = false
                end
            elseif c == '"' then
                sc.in_string = true
            elseif c == "{" then
                if sc.depth == 0 then sc.obj_start = i end
                sc.depth = sc.depth + 1
            elseif c == "}" then
                sc.depth = sc.depth - 1
                if sc.depth == 0 and sc.obj_start then
                    process_release_object(job, body:sub(sc.obj_start, i))
                    sc.obj_start = nil
                end
            end
            i = i + 1
        end
        sc.pos = i
    end

    if sc.pos > stop then window_scan_done(job) end
end

local function start_window_scan(job, body)
    local start_pos, stop_pos = find_releases_array_body(body)
    if not start_pos then
        abort_feed_job(tr("couldn't read the releases feed"))
        return
    end

    local first = (start_pos <= stop_pos) and body:find("{", start_pos, true) or nil
    if not first or first > stop_pos then
        window_scan_done(job) -- empty window
        return
    end

    local sc = { body = body, stop = stop_pos }
    if body:sub(first, first + #OBJECT_PREFIX - 1) == OBJECT_PREFIX then
        sc.mode, sc.pos = "fast", first
    else
        sc.mode, sc.pos = "slow", start_pos
        sc.depth, sc.in_string, sc.escape, sc.obj_start = 0, false, false, nil
    end
    job.scan = sc
end

run_next_feed_window = function()
    local job = feed_job
    if not job then return end

    job.index = job.index + 1
    local w = job.windows[job.index]
    if not w then
        finish_feed_job()
        return
    end

    loading_toast(string.format(tr("Discover: checking releases (%d of %d)..."), job.index, #job.windows))
    job.requests = job.requests + 1

    request_with_retry({
        url = window_url(w),
        headers = { ["User-Agent"] = USER_AGENT },
        max_response_bytes = FEED_MAX_RESPONSE_BYTES,
        connect_timeout_ms = 10000,
        read_timeout_ms = 20000,
        total_timeout_ms = 30000,
    }, function(status, body, req_err, headers)
        if feed_job ~= job then return end -- aborted meanwhile

        if req_err == "response_too_large" then
            local a, b = split_window(w)
            if a then
                table.remove(job.windows, job.index)
                table.insert(job.windows, job.index, a)
                table.insert(job.windows, job.index + 1, b)
                job.index = job.index - 1
                run_next_feed_window()
                return
            end
        end

        if req_err then
            abort_feed_job(friendly_request_error(req_err))
            return
        end

        if is_empty_window_response(status, body, w) then
            job.empty_windows = job.empty_windows + 1
            window_scan_done(job)
            return
        end

        if status ~= 200 then
            abort_feed_job(friendly_status_error(status))
            return
        end

        start_window_scan(job, body)
    end)
end

local function fetch_feed(force)
    if feed_job then
        plugin.show_toast(tr("Discover: already checking for new releases"))
        return
    end

    local last_fetch = tonumber(plugin.storage.get(LAST_FEED_FETCH_KEY, "0")) or 0
    if not force and os.time() - last_fetch < FEED_MAX_AGE_SECONDS then
        plugin.show_toast(tr("Discover: already up to date this week"))
        return
    end

    local today = time_to_date(os.time())
    local covered_to = plugin.storage.get(FEED_COVERED_TO_KEY)
    if covered_to and not date_to_time(covered_to) then covered_to = nil end
    local windows, rescan_from, earliest = plan_feed_windows(today, covered_to)

    local artist_index = build_artist_index()
    local library_artist_count = 0
    for _ in pairs(artist_index) do
        library_artist_count = library_artist_count + 1
    end

    -- matches older than the rescan span are kept as is
    local retained, seen = {}, {}
    for _, r in ipairs(load_matched_releases()) do
        local d = r.release_date or ""
        if d < rescan_from and d >= earliest then
            retained[#retained + 1] = r
            if r.release_group_mbid then seen[r.release_group_mbid] = true end
        end
    end

    -- set_interval throws when the global 8-timer cap is hit; guard it or the callback dies silently
    local ok, result = pcall(plugin.set_interval, 1, scan_tick)
    if not ok then
        plugin.show_toast(string.format(tr("Discover: couldn't start scanning (%s)"), tostring(result)))
        return
    end
    feed_timer = result

    feed_job = {
        windows = windows, index = 0, requests = 0, found = {}, seen = seen, retained = retained,
        artist_index = artist_index, library_artist_count = library_artist_count,
        scanned = 0, decode_failures = 0, empty_windows = 0, today = today, rescan_from = rescan_from,
    }
    loading_toast(covered_to and tr("Discover: checking for new releases...")
        or string.format(tr("Discover: checking for new releases (first run: %d requests, a few minutes)..."), #windows))
    run_next_feed_window()
end

-- musicbrainz lookups and pages
-- every request comes from an explicit user action, never keystrokes or background (1 req/sec etiquette)
-- artist and album search stay separate: release-group search scores on title only

local MB_MAX_RESPONSE_BYTES = 1048576 -- ~5 kb per result observed
local SIMILAR_ARTISTS_ALGORITHM = "session_based_days_9000_session_300_contribution_5_threshold_15_limit_50_skip_30"
local RELEASE_TYPES = { "Albums", "EPs", "Singles" }
local RELEASE_TYPE_QUERY = { Albums = "album", EPs = "ep", Singles = "single" }

local function url_encode(s)
    return (s:gsub("([^%w%-%.%_%~])", function(c)
        return ("%%%02X"):format(c:byte())
    end))
end

local function mb_request(url, callback)
    request_with_retry({
        url = url,
        headers = { ["User-Agent"] = USER_AGENT },
        max_response_bytes = MB_MAX_RESPONSE_BYTES,
        connect_timeout_ms = 10000,
        read_timeout_ms = 15000,
        total_timeout_ms = 20000,
    }, function(status, body, req_err, headers)
        if req_err then
            callback(nil, friendly_request_error(req_err))
            return
        end
        if status ~= 200 then
            callback(nil, friendly_status_error(status))
            return
        end

        local data = plugin.json_decode(body, { max_input_bytes = MB_MAX_RESPONSE_BYTES })
        if type(data) ~= "table" then
            callback(nil, tr("couldn't read the response"))
            return
        end
        callback(data, nil)
    end)
end

-- genres come unsorted, so sort by vote count here
local function top_genres(genres, n)
    if type(genres) ~= "table" or #genres == 0 then return {} end

    local sorted = {}
    for _, g in ipairs(genres) do
        if type(g) == "table" and type(g.name) == "string" then
            table.insert(sorted, g)
        end
    end
    table.sort(sorted, function(a, b) return (a.count or 0) > (b.count or 0) end)

    local out = {}
    for i = 1, math.min(n or 3, #sorted) do
        out[i] = sorted[i].name
    end
    return out
end

local function year_of(date_str)
    if date_str and #date_str >= 4 then return date_str:sub(1, 4) end
    return nil
end

-- album page
-- opened live (fetches detail) or from a wish list entry's cached_info (no network)

-- defined further down
local show_artist_page
local open_artist_by_name

-- entry_id is the stored id when opened from a wish list entry, so hand-edited ids still work
local function render_album_page(artist, album, year, release_group_mbid, release_type, info, artist_mbid, entry_id)
    local id = entry_id or make_entry_id(artist, album, release_group_mbid)
    artist_mbid = artist_mbid or (info and info.artist_mbid)
    local on_wishlist = is_on_wishlist(id)

    local rows = {
        { type = "toggle", label = tr("On Wish List"), value = on_wishlist, icon = ICON_WISH,
            on_change = function(checked)
                if checked then
                    local added, _, err = add_wishlist_entry(
                        artist, album, year, release_group_mbid, release_type, "album_page", info)
                    if added then
                        plugin.show_toast(tr("Added to wish list"))
                    elseif added == nil then
                        plugin.show_toast(string.format(tr("Discover: couldn't save wish list (%s)"), tostring(err)))
                    end
                else
                    local removed, err = remove_wishlist_entry(id)
                    if err then
                        plugin.show_toast(string.format(tr("Discover: couldn't save wish list (%s)"), tostring(err)))
                    else
                        plugin.show_toast(tr("Removed from wish list"))
                    end
                end
            end },
        { type = "row", label = string.format(tr("Artist: %s"), artist), wrap = true,
            on_select = function()
                if artist_mbid then
                    show_artist_page(artist_mbid, artist)
                else
                    open_artist_by_name(artist)
                end
            end },
        { type = "row", label = string.format(tr("Type: %s"), release_type or "?"), on_select = function() end },
    }

    if owned_checker()(artist, album) then
        table.insert(rows, 2, { type = "row", label = tr("In your library"), icon = ICON_OWNED,
            on_select = function() end })
    end
    if year then
        rows[#rows + 1] = { type = "row", label = string.format(tr("Released: %s"), year), on_select = function() end }
    end
    if info and info.disambiguation and info.disambiguation ~= "" then
        rows[#rows + 1] = { type = "row", label = info.disambiguation, wrap = true, on_select = function() end }
    end
    if info and info.rating_value then
        rows[#rows + 1] = { type = "row",
            label = string.format(tr("Rating: %.1f (%d votes)"), info.rating_value, info.rating_votes or 0),
            on_select = function() end }
    end
    if info and info.genres and #info.genres > 0 then
        rows[#rows + 1] = { type = "row", label = string.format(tr("Genres: %s"), table.concat(info.genres, ", ")),
            wrap = true, on_select = function() end }
    end

    plugin.show_settings_list(album, rows)
end

-- fetches fresh release-group detail, for anything not on the wish list
local function show_album_page_live(artist, album, release_group_mbid, release_type, year, artist_mbid)
    if not release_group_mbid then
        render_album_page(artist, album, year, nil, release_type, nil, artist_mbid)
        return
    end

    local url = ("https://musicbrainz.org/ws/2/release-group/%s?fmt=json&inc=genres+ratings+artist-credits")
        :format(url_encode(release_group_mbid))
    loading_toast(string.format(tr("Discover: loading %s..."), album))

    mb_request(url, function(data, err)
        local info = nil
        if data then
            info = {
                disambiguation = data.disambiguation,
                rating_value = data.rating and data.rating.value,
                rating_votes = data.rating and data.rating["votes-count"],
                genres = top_genres(data.genres, 3),
                artist_mbid = (data["artist-credit"] and data["artist-credit"][1]
                    and data["artist-credit"][1].artist and data["artist-credit"][1].artist.id)
                    or artist_mbid,
            }
        elseif err then
            plugin.show_toast(string.format(tr("Discover: %s (showing basic info)"), err))
        end
        render_album_page(artist, album, year, release_group_mbid, release_type, info, artist_mbid)
    end)
end

-- renders from cached_info, no network
local function show_album_page_cached(entry)
    render_album_page(entry.artist, entry.album, entry.year, entry.release_group_mbid,
        entry.release_type, entry.cached_info, nil, entry.id)
end

-- artist page

-- musicbrainz caps pages at 100, so page up to a limit; if a later page fails, show what loaded
local MAX_BROWSE_RELEASES = 300
local BROWSE_PAGE_SIZE = 100
local BROWSE_PAGE_DELAY_SECONDS = 1.2

local function fetch_release_groups(artist_mbid, type_query, on_done)
    local all, seen = {}, {}

    local function fetch_page(offset)
        local url = ("https://musicbrainz.org/ws/2/release-group?artist=%s&fmt=json&limit=%d&offset=%d&type=%s")
            :format(url_encode(artist_mbid), BROWSE_PAGE_SIZE, offset, type_query)

        mb_request(url, function(data, err)
            if err then
                if #all > 0 then on_done(all, nil) else on_done(nil, err) end
                return
            end

            local groups = type(data["release-groups"]) == "table" and data["release-groups"] or {}
            for _, rg in ipairs(groups) do
                if type(rg) == "table" and type(rg.id) == "string" and not seen[rg.id] then
                    seen[rg.id] = true
                    all[#all + 1] = rg
                end
            end

            local next_offset = offset + #groups
            local total = data["release-group-count"] or next_offset
            if #groups > 0 and next_offset < total and next_offset < MAX_BROWSE_RELEASES then
                delayed(BROWSE_PAGE_DELAY_SECONDS, function() fetch_page(next_offset) end)
            else
                on_done(all, nil)
            end
        end)
    end

    fetch_page(0)
end

local function release_label(rg)
    local y = year_of(rg["first-release-date"]) or "?"
    local label = ("%s (%s)"):format(rg.title or "?", y)
    local secondary = rg["secondary-types"]
    if secondary and #secondary > 0 then
        label = label .. " [" .. table.concat(secondary, ", ") .. "]"
    end
    return label
end

local function show_release_type_list(artist_mbid, artist_name, type_label)
    local type_query = RELEASE_TYPE_QUERY[type_label]
    loading_toast(string.format(tr("Discover: loading %s by %s..."), tr(type_label:lower()), artist_name))

    fetch_release_groups(artist_mbid, type_query, function(groups, err)
        if err then
            plugin.show_toast(string.format(tr("Discover: %s"), err))
            return
        end

        local opts = load_options()
        local releases = {}
        for _, rg in ipairs(groups) do
            if release_types_allowed(rg["secondary-types"], opts) then
                table.insert(releases, rg)
            end
        end

        if #releases == 0 then
            if #groups > 0 then
                plugin.show_toast(string.format(tr("Discover: %d %s hidden by your Options"), #groups, tr(type_label:lower())))
            else
                plugin.show_toast(string.format(tr("Discover: no %s found for %s"), tr(type_label:lower()), artist_name))
            end
            return
        end

        table.sort(releases, function(a, b)
            return (a["first-release-date"] or "0000") > (b["first-release-date"] or "0000")
        end)

        local is_owned = owned_checker()
        local is_wished = wishlist_checker()

        local labels = {}
        for i, rg in ipairs(releases) do
            if i > 500 then break end
            labels[i] = {
                label = release_label(rg), wrap = true,
                icon = marker_icon(is_owned(artist_name, rg.title or ""),
                                   is_wished(artist_name, rg.title or "", rg.id)),
            }
        end

        plugin.show_list(artist_name .. " - " .. tr(type_label), labels, function(index)
            local rg = releases[index]
            if not rg then return end
            show_album_page_live(artist_name, rg.title or "?", rg.id,
                rg["primary-type"] or type_label:sub(1, -2), year_of(rg["first-release-date"]), artist_mbid)
        end)
    end)
end

local function show_similar_artists(seed_mbid, seed_name)
    local url = ("https://labs.api.listenbrainz.org/similar-artists/json?artist_mbids=%s&algorithm=%s")
        :format(url_encode(seed_mbid), SIMILAR_ARTISTS_ALGORITHM)
    loading_toast(string.format(tr("Discover: finding artists similar to %s..."), seed_name))

    request_with_retry({
        url = url,
        headers = { ["User-Agent"] = USER_AGENT },
        max_response_bytes = MB_MAX_RESPONSE_BYTES,
        connect_timeout_ms = 10000,
        read_timeout_ms = 15000,
        total_timeout_ms = 20000,
    }, function(status, body, req_err, headers)
        if req_err then
            plugin.show_toast(string.format(tr("Discover: %s"), friendly_request_error(req_err)))
            return
        end
        if status ~= 200 then
            plugin.show_toast(string.format(tr("Discover: %s"), friendly_status_error(status)))
            return
        end

        local similar = plugin.json_decode(body, { max_input_bytes = MB_MAX_RESPONSE_BYTES })
        if type(similar) ~= "table" or #similar == 0 then
            plugin.show_toast(string.format(tr("Discover: no recommendations found for %s"), seed_name))
            return
        end

        local labels = {}
        for i, a in ipairs(similar) do
            if i > 50 then break end
            if type(a) == "table" and type(a.name) == "string" then
                local comment = type(a.comment) == "string" and a.comment or nil
                labels[#labels + 1] = { label = (comment and comment ~= "") and
                    (a.name .. " (" .. comment .. ")") or a.name, wrap = true }
            end
        end

        plugin.show_list(string.format(tr("Similar to %s"), seed_name), labels, function(index)
            local a = similar[index]
            if not a then return end
            show_artist_page(a.artist_mbid, a.name)
        end)
    end)
end

show_artist_page = function(artist_mbid, artist_name)
    local url = ("https://musicbrainz.org/ws/2/artist/%s?fmt=json&inc=genres+ratings")
        :format(url_encode(artist_mbid))
    loading_toast(string.format(tr("Discover: loading %s..."), artist_name))

    mb_request(url, function(data, err)
        local rows = {}

        if data then
            local pieces = {}
            if data.type and data.type ~= "" then table.insert(pieces, data.type) end
            if data.country and data.country ~= "" then table.insert(pieces, data.country) end

            local life = data["life-span"]
            if life and life.begin then
                local span = life.begin
                if life.ended and life["end"] then
                    span = span .. "-" .. life["end"]
                elseif not life.ended then
                    span = span .. "-" .. tr("present")
                end
                table.insert(pieces, span)
            end

            if #pieces > 0 then
                rows[#rows + 1] = { type = "row", label = table.concat(pieces, " | "), wrap = true,
                    on_select = function() end }
            end
            if data.disambiguation and data.disambiguation ~= "" then
                rows[#rows + 1] = { type = "row", label = data.disambiguation, wrap = true,
                    on_select = function() end }
            end
            if data.rating and data.rating.value then
                rows[#rows + 1] = { type = "row",
                    label = string.format(tr("Rating: %.1f (%d votes)"), data.rating.value, data.rating["votes-count"] or 0),
                    on_select = function() end }
            end

            local genres = top_genres(data.genres, 3)
            if #genres > 0 then
                rows[#rows + 1] = { type = "row", label = string.format(tr("Genres: %s"), table.concat(genres, ", ")),
                    wrap = true, on_select = function() end }
            end
        elseif err then
            rows[#rows + 1] = { type = "row", label = err, wrap = true, on_select = function() end }
        end

        for _, type_label in ipairs(RELEASE_TYPES) do
            rows[#rows + 1] = { type = "row", label = tr(type_label),
                on_select = function() show_release_type_list(artist_mbid, artist_name, type_label) end }
        end

        rows[#rows + 1] = { type = "row", label = tr("Find Similar Artists"),
            on_select = function() show_similar_artists(artist_mbid, artist_name) end }

        plugin.show_settings_list(artist_name, rows)
    end)
end

local function resolve_artist_mbid(name, callback)
    if #name > 512 then
        callback(nil, tr("artist name is too long to search"))
        return
    end
    local url = "https://musicbrainz.org/ws/2/artist/?fmt=json&limit=1&query=" .. url_encode(name)
    mb_request(url, function(data, err)
        if err then
            callback(nil, err)
            return
        end

        local artists = data["artists"]
        if type(artists) ~= "table" or type(artists[1]) ~= "table" or type(artists[1].id) ~= "string"
            or type(artists[1].name) ~= "string" then
            callback(nil, string.format(tr("couldn't identify \"%s\" on MusicBrainz"), name))
            return
        end
        callback(artists[1], nil)
    end)
end

-- opens an artist page from just a name: one search, top hit
open_artist_by_name = function(name)
    loading_toast(string.format(tr("Discover: looking up %s..."), name))
    resolve_artist_mbid(name, function(artist, err)
        if err then
            plugin.show_toast(string.format(tr("Discover: %s"), err))
            return
        end
        show_artist_page(artist.id, artist.name)
    end)
end

-- search and browse screens

local function search_artist(query)
    query = trim(query)
    if query == "" then return end
    if #query > 512 then
        plugin.show_toast(tr("Discover: search text must be 512 bytes or fewer"))
        return
    end

    local url = "https://musicbrainz.org/ws/2/artist/?fmt=json&limit=15&query=" .. url_encode(query)
    loading_toast(tr("Discover: searching artists..."))

    mb_request(url, function(data, err)
        if err then
            plugin.show_toast(string.format(tr("Discover: %s"), err))
            return
        end

        local artists = data["artists"]
        if type(artists) ~= "table" or #artists == 0 then
            plugin.show_toast(string.format(tr("Discover: no artists found for \"%s\""), query))
            return
        end

        local labels = {}
        for i, a in ipairs(artists) do
            if type(a) == "table" and type(a.name) == "string" then
                local disambig = type(a.disambiguation) == "string" and a.disambiguation or nil
                labels[#labels + 1] = { label = (disambig and disambig ~= "") and
                    (a.name .. " (" .. disambig .. ")") or a.name, wrap = true }
            end
        end

        plugin.show_list(tr("Artist Results"), labels, function(index)
            local a = artists[index]
            if not a then return end
            show_artist_page(a.id, a.name)
        end)
    end)
end

local function format_album_search_result_label(rg)
    local artist = (rg["artist-credit"] and rg["artist-credit"][1] and rg["artist-credit"][1].name) or "?"
    local year = year_of(rg["first-release-date"])
    local kind = rg["primary-type"] or ""
    if year then
        return ("%s - %s (%s) [%s]"):format(artist, rg.title or "?", year, kind)
    end
    return ("%s - %s [%s]"):format(artist, rg.title or "?", kind)
end

local function search_album(query)
    query = trim(query)
    if query == "" then return end
    if #query > 512 then
        plugin.show_toast(tr("Discover: search text must be 512 bytes or fewer"))
        return
    end

    local url = "https://musicbrainz.org/ws/2/release-group/?fmt=json&limit=15&query=" .. url_encode(query)
    loading_toast(tr("Discover: searching albums..."))

    mb_request(url, function(data, err)
        if err then
            plugin.show_toast(string.format(tr("Discover: %s"), err))
            return
        end

        local groups = data["release-groups"]
        if type(groups) ~= "table" or #groups == 0 then
            plugin.show_toast(string.format(tr("Discover: no albums found for \"%s\""), query))
            return
        end

        local is_owned = owned_checker()
        local is_wished = wishlist_checker()

        local labels = {}
        for i, rg in ipairs(groups) do
            if type(rg) == "table" and type(rg.title) == "string" then
                local credit = rg["artist-credit"]
                local first_credit = type(credit) == "table" and credit[1] or nil
                local artist = type(first_credit) == "table" and type(first_credit.name) == "string"
                    and first_credit.name or ""
                labels[#labels + 1] = {
                    label = format_album_search_result_label(rg), wrap = true,
                    icon = marker_icon(is_owned(artist, rg.title), is_wished(artist, rg.title, rg.id)),
                }
            end
        end

        plugin.show_list(tr("Album Results"), labels, function(index)
            local rg = groups[index]
            if not rg then return end
            local artist = (rg["artist-credit"] and rg["artist-credit"][1] and rg["artist-credit"][1].name) or query
            local credit = rg["artist-credit"] and rg["artist-credit"][1]
            show_album_page_live(artist, rg.title or query, rg.id, rg["primary-type"],
                year_of(rg["first-release-date"]), credit and credit.artist and credit.artist.id)
        end)
    end)
end

local function show_search_artist()
    plugin.show_text_input(tr("Search artist"), "", false, search_artist)
end

local function show_search_album()
    plugin.show_text_input(tr("Search album"), "", false, search_album)
end

local function show_my_artists()
    local artists = {}
    local offset = 0
    while #artists < 500 do
        local page = plugin.library_get_artists(offset, 200)
        if not page or #page == 0 then break end
        for _, g in ipairs(page) do
            table.insert(artists, g)
        end
        if #page < 200 then break end
        offset = offset + 200
    end

    if #artists == 0 then
        plugin.show_toast(tr("Discover: no library artists found"))
        return
    end

    local labels = {}
    for i, g in ipairs(artists) do
        if i > 500 then break end
        labels[i] = g.name
    end

    plugin.show_list(tr("My Artists"), labels, function(index)
        local name = artists[index] and artists[index].name
        if not name then return end
        open_artist_by_name(name)
    end)
end

-- new & upcoming

local function format_release_label(r)
    local date = r.release_date or ""
    local tag = r.release_group_secondary_type and (" [" .. r.release_group_secondary_type .. "]") or ""
    return ("%s - %s (%s)%s"):format(r.artist, r.album, date, tag)
end

-- upcoming (soonest first) / released (newest first), filtered by options; various artists dropped
-- returns upcoming, released, hidden_by_options
local function partition_feed(opts)
    local today = time_to_date(os.time())
    local upcoming, released, hidden = {}, {}, 0

    for _, r in ipairs(load_matched_releases()) do
        if is_various_artists(r.artist, nil) then
            -- dropped without counting as hidden
        elseif not release_types_allowed({ r.release_group_secondary_type }, opts) then
            hidden = hidden + 1
        elseif (r.release_date or "") >= today then
            upcoming[#upcoming + 1] = r
        else
            released[#released + 1] = r
        end
    end

    table.sort(upcoming, function(a, b) return (a.release_date or "") < (b.release_date or "") end)
    table.sort(released, function(a, b) return (a.release_date or "") > (b.release_date or "") end)
    return upcoming, released, hidden
end

local MAX_FEED_LIST_ROWS = 500 -- show_list limit

local function show_feed_list(kind)
    local upcoming, released = partition_feed(load_options())
    local source = kind == "upcoming" and upcoming or released
    if #source == 0 then
        plugin.show_toast(kind == "upcoming"
            and tr("Discover: no upcoming releases to show")
            or tr("Discover: no released releases to show"))
        return
    end

    local is_owned = owned_checker()
    local is_wished = wishlist_checker()

    local labels, shown = {}, {}
    for i, r in ipairs(source) do
        if i > MAX_FEED_LIST_ROWS then break end
        shown[i] = r
        labels[i] = {
            label = format_release_label(r), wrap = true,
            icon = marker_icon(is_owned(r.artist, r.album), is_wished(r.artist, r.album, r.release_group_mbid)),
        }
    end

    local title = kind == "upcoming" and tr("Upcoming") or string.format(tr("Released (last %d days)"), FEED_PAST_DAYS)
    plugin.show_list(title, labels, function(index)
        local r = shown[index]
        if not r then return end
        show_album_page_live(r.artist, r.album, r.release_group_mbid,
            r.release_group_primary_type, year_of(r.release_date), r.artist_mbid)
    end)
end

local function build_new_and_upcoming_rows()
    local upcoming, released, hidden = partition_feed(load_options())
    local last_fetch = tonumber(plugin.storage.get(LAST_FEED_FETCH_KEY, "0")) or 0

    local status
    if feed_job then
        status = string.format(tr("Checking releases (%d of %d)..."), math.max(feed_job.index, 1), #feed_job.windows)
    elseif last_fetch > 0 then
        status = string.format(tr("Last checked %s -- tap to check again"), os.date("%Y-%m-%d %H:%M", last_fetch))
    else
        status = tr("Check for new releases now")
    end

    local rows = {
        { type = "row", icon = ICON_BLANK, wrap = true, label = status,
          on_select = function() fetch_feed(true) end },
        { type = "row", icon = ICON_BLANK,
          label = string.format(tr("Upcoming, next %d months (%d)"), math.floor(FEED_FUTURE_DAYS / 30.4 + 0.5), #upcoming),
          on_select = function() show_feed_list("upcoming") end },
        { type = "row", icon = ICON_BLANK,
          label = string.format(tr("Released, last %d days (%d)"), FEED_PAST_DAYS, #released),
          on_select = function() show_feed_list("released") end },
    }

    if hidden > 0 then
        rows[#rows + 1] = { type = "row", icon = ICON_BLANK, wrap = true, on_select = function() end,
            label = string.format(tr("%d more hidden by your Options"), hidden) }
    end

    if #upcoming == 0 and #released == 0 and hidden == 0 then
        local diag = json_load(plugin.storage.get(LAST_SCAN_DIAGNOSTICS_KEY), nil)
        if diag then
            rows[#rows + 1] = { type = "row", icon = ICON_BLANK, wrap = true, on_select = function() end,
                label = string.format(tr("No matches (scanned %d releases against %d of your artists)"),
                    diag.scanned, diag.library_artist_count) }
        end
    end

    return rows
end

local function show_new_and_upcoming()
    plugin.show_settings_list(tr("New & Upcoming"), build_new_and_upcoming_rows())
end

-- wish list screens

local function show_add_by_hand()
    plugin.show_text_input(tr("Artist"), "", false, function(artist)
        artist = trim(artist)
        if artist == "" then return end

        plugin.show_text_input(tr("Album"), "", false, function(album)
            album = trim(album)
            if album == "" then return end

            local added, _, err = add_wishlist_entry(artist, album, nil, nil, nil, "manual", nil)
            if added then
                plugin.show_toast(tr("Added to wish list"))
            elseif added == nil then
                plugin.show_toast(string.format(tr("Discover: couldn't save wish list (%s)"), tostring(err)))
            else
                plugin.show_toast(tr("Already on your wish list"))
            end
        end)
    end)
end

local function show_wish_list()
    pcall(sync_wishlist_mirror)
    maybe_run_autocheck()

    local wishlist = wishlist_display_order(load_wishlist())
    local possible = load_possible_matches()
    local labels = {}

    if #possible > 0 then
        local match_fmt = #possible == 1
            and tr("%d possible match to confirm")
            or tr("%d possible matches to confirm")
        labels[#labels + 1] = string.format(match_fmt, #possible)
    end

    local first_wishlist_index = #labels + 1
    for i, e in ipairs(wishlist) do
        if i > 490 then break end
        labels[#labels + 1] = ("%s - %s"):format(e.artist, e.album)
    end

    if #wishlist == 0 and #possible == 0 then
        plugin.show_list(tr("Wish List"), { tr("Nothing here yet") }, function() end)
        return
    end

    plugin.show_list(tr("Wish List"), labels, function(index)
        if #possible > 0 and index == 1 then
            local confirm_rows = {}
            for _, e in ipairs(possible) do
                confirm_rows[#confirm_rows + 1] = { type = "toggle",
                    label = ("%s - %s"):format(e.artist, e.album), wrap = true, value = false,
                    on_change = function(checked)
                        if not checked then return end

                        local removed, err = remove_wishlist_entry(e.id)
                        if not removed then
                            plugin.show_toast(string.format(tr("Discover: couldn't save wish list (%s)"), tostring(err)))
                            return
                        end

                        local remaining = {}
                        for _, p in ipairs(possible) do
                            if p.id ~= e.id then table.insert(remaining, p) end
                        end
                        possible = remaining

                        local saved, save_err = save_possible_matches(possible)
                        if not saved then
                            plugin.show_toast(string.format(tr("Discover: couldn't save confirmations (%s)"), tostring(save_err)))
                            return
                        end
                        plugin.show_toast(tr("Removed from wish list"))
                    end,
                }
            end

            if #confirm_rows == 0 then
                confirm_rows[1] = { type = "row", label = tr("Nothing to confirm"), on_select = function() end }
            end
            plugin.show_settings_list(tr("Confirm Matches"), confirm_rows)
            return
        end

        local wishlist_index = index - (first_wishlist_index - 1)
        local entry = wishlist[wishlist_index]
        if entry then
            show_album_page_cached(entry)
        end
    end)
end

-- options screen

local function mirror_status_text()
    if not mirror_writable() then return tr("waiting for the SD card") end
    if plugin.storage.get("wishlist_mirror_dirty", "0") == "1" then return tr("changes not copied yet") end
    if not file_exists(mirror_path()) then return tr("not created yet") end
    return tr("in sync")
end

-- explicit restore, since auto sync only pulls newer files; old list kept as wishlist_before_restore
local function show_restore_confirm()
    local mirrored, err = read_mirror()
    if not mirrored then
        plugin.show_toast(string.format(tr("Discover: %s"), err))
        return
    end

    local replace_fmt = #mirrored == 1
        and tr("Replace my wish list with the SD copy (%d album)")
        or tr("Replace my wish list with the SD copy (%d albums)")
    plugin.show_list(tr("Restore wish list"), {
        string.format(replace_fmt, #mirrored),
        tr("Cancel"),
    }, function(index)
        if index ~= 1 then return end

        local current = plugin.storage.get("wishlist")
        if current then
            local backed_up, backup_err = plugin.storage.set("wishlist_before_restore", current)
            if not backed_up then
                plugin.show_toast(string.format(tr("Discover: couldn't back up the current wish list (%s)"), tostring(backup_err)))
                return
            end
        end

        local stored, store_err = storage_json_set("wishlist", wishlist_envelope(mirrored))
        if not stored then
            plugin.show_toast(string.format(tr("Discover: couldn't restore wish list (%s)"), tostring(store_err)))
            return
        end
        record_mirror_mtime()
        local clean = plugin.storage.set("wishlist_mirror_dirty", "0")
        if not clean then
            plugin.show_toast(tr("Discover: restored the list, but couldn't update SD sync status"))
            return
        end
        plugin.show_toast(string.format(tr("Discover: restored %d from the SD copy"), #mirrored))
    end)
end

local function show_options()
    local opts = load_options()
    local rows = {
        -- first row shows which plugin copy loaded (pushed files need a plugin refresh or restart)
        { type = "row", icon = ICON_MENU, on_select = function() end,
          label = ("Discover v%s -- @buymyhubs"):format(PLUGIN_VERSION) },
    }

    for _, t in ipairs(SECONDARY_TYPE_OPTIONS) do
        rows[#rows + 1] = {
            type = "toggle", label = tr(t.label), value = opts[t.key],
            on_change = function(checked)
                local saved, err = save_option(t.key, checked)
                if not saved then plugin.show_toast(string.format(tr("Discover: couldn't save Options (%s)"), tostring(err))) end
            end,
        }
    end

    rows[#rows + 1] = { type = "row", icon = ICON_BLANK, wrap = true, on_select = function() end,
        label = string.format(tr("Wish list SD copy: %s"), mirror_status_text()) }
    rows[#rows + 1] = { type = "row", icon = ICON_BLANK, label = tr("Back up wish list to SD now"),
        on_select = function()
            local ok, err = write_mirror(load_wishlist())
            plugin.show_toast(ok and tr("Discover: wish list copied to the SD card")
                or string.format(tr("Discover: %s"), tostring(err)))
        end }
    rows[#rows + 1] = { type = "row", icon = ICON_BLANK, label = tr("Restore wish list from SD copy"),
        on_select = show_restore_confirm }

    plugin.show_settings_list(tr("Options"), rows)
end

-- main menu and registration

local function show_discover_menu()
    plugin.show_list(tr("Discover"), {
        tr("New & Upcoming"),
        tr("Wish List"),
        tr("My Artists"),
        tr("Search Artist"),
        tr("Search Album"),
        tr("Add By Hand"),
        tr("Options"),
    }, function(index)
        if index == 1 then show_new_and_upcoming()
        elseif index == 2 then show_wish_list()
        elseif index == 3 then show_my_artists()
        elseif index == 4 then show_search_artist()
        elseif index == 5 then show_search_album()
        elseif index == 6 then show_add_by_hand()
        elseif index == 7 then show_options()
        end
    end)
end

-- Music Library is the supported Settings list for music library tools.
local menu_options = { icon = ICON_MENU }
plugin.register_list_item("music_library", tr("Discover"), show_discover_menu, menu_options)

-- events
-- these trigger the auto check-off; the wish list screen also runs it on open

plugin.on("screen_woke", function()
    pcall(sync_wishlist_mirror)
    maybe_run_autocheck()
end)

plugin.on("system_resumed", function()
    pcall(sync_wishlist_mirror)
    maybe_run_autocheck()
end)

pcall(sync_wishlist_mirror)
