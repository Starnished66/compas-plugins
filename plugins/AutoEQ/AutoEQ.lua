plugin.define({
    id = "compas.autoeq",
    name = "AutoEQ",
    version = "1.2.0",
    api_min = 19,
})

local T = {
    de = {
        ["Catalog is empty or too large"] = "Katalog ist leer oder zu groß",
        ["Catalog has a line longer than %d bytes"] = "Katalog enthält eine Zeile mit mehr als %d Bytes",
        ["Catalog has too many models"] = "Katalog enthält zu viele Modelle",
        ["No model entries found in catalog"] = "Keine Modelle im Katalog gefunden",
        ["AutoEQ catalog"] = "AutoEQ-Katalog",
        ["Loading catalog…"] = "Katalog wird geladen…",
        ["Loading AutoEQ catalog…"] = "AutoEQ-Katalog wird geladen…",
        ["error"] = "Fehler",
        ["Offline: using saved AutoEQ catalog"] = "Offline: gespeicherter AutoEQ-Katalog wird verwendet",
        ["AutoEQ catalog failed: %s"] = "AutoEQ-Katalog fehlgeschlagen: %s",
        ["AutoEQ catalog invalid: %s"] = "AutoEQ-Katalog ungültig: %s",
        ["Catalog loaded; cache could not be saved"] = "Katalog geladen; Cache konnte nicht gespeichert werden",
        ["AutoEQ catalog ready"] = "AutoEQ-Katalog bereit",
        ["request could not start"] = "Anfrage konnte nicht gestartet werden",
        ["Model: %s"] = "Modell: %s",
        ["Measurement: %s"] = "Messung: %s",
        ["Replace existing profile: %s"] = "Vorhandenes Profil ersetzen: %s",
        ["Save as new copy"] = "Als neue Kopie speichern",
        ["Download profile"] = "Profil herunterladen",
        ["Profile is empty or too large"] = "Profil ist leer oder zu groß",
        ["Invalid or duplicate preamp row"] = "Ungültige oder doppelte Preamp-Zeile",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "Preamp liegt außerhalb des Bereichs (-12 bis +12 dB)",
        ["Malformed or duplicate filter row"] = "Fehlerhafte oder doppelte Filterzeile",
        ["Filter count or enable state is invalid"] = "Filteranzahl oder Aktivierungsstatus ungültig",
        ["Filter has a non-finite number"] = "Filter enthält einen ungültigen Zahlenwert",
        ["Filter frequency is outside 20–20000 Hz"] = "Filterfrequenz liegt außerhalb von 20–20000 Hz",
        ["Filter gain is outside -12 to +12 dB"] = "Filterverstärkung liegt außerhalb von -12 bis +12 dB",
        ["Filter Q is outside 0.1–10"] = "Filter-Q liegt außerhalb von 0.1–10",
        ["Unsupported filter type: %s"] = "Nicht unterstützter Filtertyp: %s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "Umgerechnete Flankensteilheit liegt außerhalb des Bereichs (0.1–10)",
        ["Unrecognized profile row: %s"] = "Unbekannte Profilzeile: %s",
        ["Profile has no Preamp row"] = "Profil enthält keine Preamp-Zeile",
        ["Profile has no filter rows"] = "Profil enthält keine Filterzeilen",
        ["Filter numbering has a gap"] = "Filternummerierung weist eine Lücke auf",
        ["Profile now exists; choose Replace explicitly"] = "Profil existiert bereits; bitte explizit Ersetzen wählen",
        ["Could not create PEQ_Profiles"] = "PEQ_Profiles konnte nicht erstellt werden",
        ["Could not open temporary profile"] = "Temporäres Profil konnte nicht geöffnet werden",
        ["Could not save profile; existing file was kept"] = "Profil konnte nicht gespeichert werden; vorhandene Datei wurde behalten",
        ["Invalid AutoEQ catalog path"] = "Ungültiger AutoEQ-Katalogpfad",
        ["AutoEQ profile"] = "AutoEQ-Profil",
        ["Downloading profile…"] = "Profil wird heruntergeladen…",
        ["Profile download failed: %s"] = "Profil-Download fehlgeschlagen: %s",
        ["Validating and saving profile…"] = "Profil wird geprüft und gespeichert…",
        ["Profile not saved: %s"] = "Profil nicht gespeichert: %s",
        ["Saved. Select it in Equalizer → Profiles"] = "Gespeichert. Wähle es unter Equalizer → Profile aus",
        ["Profile download could not start: %s"] = "Profil-Download konnte nicht gestartet werden: %s",
        ["Downloading AutoEQ profile…"] = "AutoEQ-Profil wird heruntergeladen…",
        ["No models matched"] = "Keine passenden Modelle gefunden",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d Treffer",
        ["Enter at least 2 characters"] = "Mindestens 2 Zeichen eingeben",
        ["Models %d–%d"] = "Modelle %d–%d",
        ["AutoEQ pages · %d matches"] = "AutoEQ-Seiten · %d Treffer",
        ["Search AutoEQ models (%d)"] = "AutoEQ-Modelle suchen (%d)",
        ["Search AutoEQ models"] = "AutoEQ-Modelle suchen",
        ["Refresh catalog"] = "Katalog aktualisieren",
        ["Cancel current task"] = "Aktuelle Aufgabe abbrechen",
        ["About and sources"] = "Über & Quellen",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "AutoEQ durchsuchen",
        ["Using saved catalog: %d models"] = "Gespeicherter Katalog: %d Modelle",
        ["Catalog updated: %d models"] = "Katalog aktualisiert: %d Modelle",
        ["AutoEQ task cancelled"] = "AutoEQ-Aufgabe abgebrochen",
        ["No AutoEQ task is running"] = "Keine aktive AutoEQ-Aufgabe",
        ["AutoEQ sources"] = "AutoEQ-Quellen",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "Der AutoEQ-Profilkatalog und die Messungen stammen von jaakkopasanen/AutoEq.\n\nKatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImportierte Profile werden unter PEQ_Profiles gespeichert; wähle eines unter Equalizer → Profile aus, um es zu laden.",
    },
    es = {
        ["Catalog is empty or too large"] = "El catálogo está vacío o es demasiado grande",
        ["Catalog has a line longer than %d bytes"] = "El catálogo tiene una línea de más de %d bytes",
        ["Catalog has too many models"] = "El catálogo tiene demasiados modelos",
        ["No model entries found in catalog"] = "No se encontraron modelos en el catálogo",
        ["AutoEQ catalog"] = "Catálogo AutoEQ",
        ["Loading catalog…"] = "Cargando catálogo…",
        ["Loading AutoEQ catalog…"] = "Cargando catálogo AutoEQ…",
        ["error"] = "error",
        ["Offline: using saved AutoEQ catalog"] = "Sin conexión: usando catálogo AutoEQ guardado",
        ["AutoEQ catalog failed: %s"] = "Falló el catálogo AutoEQ: %s",
        ["AutoEQ catalog invalid: %s"] = "Catálogo AutoEQ no válido: %s",
        ["Catalog loaded; cache could not be saved"] = "Catálogo cargado; no se pudo guardar la caché",
        ["AutoEQ catalog ready"] = "Catálogo AutoEQ listo",
        ["request could not start"] = "no se pudo iniciar la solicitud",
        ["Model: %s"] = "Modelo: %s",
        ["Measurement: %s"] = "Medición: %s",
        ["Replace existing profile: %s"] = "Reemplazar perfil existente: %s",
        ["Save as new copy"] = "Guardar como copia nueva",
        ["Download profile"] = "Descargar perfil",
        ["Profile is empty or too large"] = "El perfil está vacío o es demasiado grande",
        ["Invalid or duplicate preamp row"] = "Fila de preamp no válida o duplicada",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "El preamp está fuera del rango del reproductor (-12 a +12 dB)",
        ["Malformed or duplicate filter row"] = "Fila de filtro mal formada o duplicada",
        ["Filter count or enable state is invalid"] = "Número o estado de filtro no válido",
        ["Filter has a non-finite number"] = "El filtro tiene un número no finito",
        ["Filter frequency is outside 20–20000 Hz"] = "La frecuencia del filtro está fuera de 20–20000 Hz",
        ["Filter gain is outside -12 to +12 dB"] = "La ganancia del filtro está fuera de -12 a +12 dB",
        ["Filter Q is outside 0.1–10"] = "El factor Q del filtro está fuera de 0.1–10",
        ["Unsupported filter type: %s"] = "Tipo de filtro no compatible: %s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "La pendiente convertida está fuera del rango del reproductor (0.1–10)",
        ["Unrecognized profile row: %s"] = "Fila de perfil no reconocida: %s",
        ["Profile has no Preamp row"] = "El perfil no tiene fila Preamp",
        ["Profile has no filter rows"] = "El perfil no tiene filas de filtro",
        ["Filter numbering has a gap"] = "La numeración de filtros tiene un salto",
        ["Profile now exists; choose Replace explicitly"] = "El perfil ya existe; elige Reemplazar explícitamente",
        ["Could not create PEQ_Profiles"] = "No se pudo crear PEQ_Profiles",
        ["Could not open temporary profile"] = "No se pudo abrir el perfil temporal",
        ["Could not save profile; existing file was kept"] = "No se pudo guardar el perfil; se conservó el archivo existente",
        ["Invalid AutoEQ catalog path"] = "Ruta de catálogo AutoEQ no válida",
        ["AutoEQ profile"] = "Perfil AutoEQ",
        ["Downloading profile…"] = "Descargando perfil…",
        ["Profile download failed: %s"] = "Falló la descarga del perfil: %s",
        ["Validating and saving profile…"] = "Validando y guardando perfil…",
        ["Profile not saved: %s"] = "Perfil no guardado: %s",
        ["Saved. Select it in Equalizer → Profiles"] = "Guardado. Selecciónalo en Ecualizador → Perfiles",
        ["Profile download could not start: %s"] = "No se pudo iniciar la descarga del perfil: %s",
        ["Downloading AutoEQ profile…"] = "Descargando perfil AutoEQ…",
        ["No models matched"] = "No se encontraron modelos",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d coincidencias",
        ["Enter at least 2 characters"] = "Introduce al menos 2 caracteres",
        ["Models %d–%d"] = "Modelos %d–%d",
        ["AutoEQ pages · %d matches"] = "Páginas de AutoEQ · %d coincidencias",
        ["Search AutoEQ models (%d)"] = "Buscar modelos AutoEQ (%d)",
        ["Search AutoEQ models"] = "Buscar modelos AutoEQ",
        ["Refresh catalog"] = "Refrescar catálogo",
        ["Cancel current task"] = "Cancelar tarea actual",
        ["About and sources"] = "Acerca de y fuentes",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "Buscar en AutoEQ",
        ["Using saved catalog: %d models"] = "Usando catálogo guardado: %d modelos",
        ["Catalog updated: %d models"] = "Catálogo actualizado: %d modelos",
        ["AutoEQ task cancelled"] = "Tarea AutoEQ cancelada",
        ["No AutoEQ task is running"] = "No hay ninguna tarea AutoEQ en curso",
        ["AutoEQ sources"] = "Fuentes de AutoEQ",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "El catálogo de perfiles y las mediciones de AutoEQ son proporcionados por jaakkopasanen/AutoEq.\n\nCatálogo: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nLos perfiles importados se guardan en PEQ_Profiles; elige uno en Ecualizador → Perfiles para cargarlo.",
    },
    fi = {
        ["Catalog is empty or too large"] = "Luettelo on tyhjä tai liian suuri",
        ["Catalog has a line longer than %d bytes"] = "Luettelossa on yli %d tavun pituinen rivi",
        ["Catalog has too many models"] = "Luettelossa on liikaa malleja",
        ["No model entries found in catalog"] = "Luettelosta ei löytynyt malleja",
        ["AutoEQ catalog"] = "AutoEQ-luettelo",
        ["Loading catalog…"] = "Ladataan luetteloa…",
        ["Loading AutoEQ catalog…"] = "Ladataan AutoEQ-luetteloa…",
        ["error"] = "virhe",
        ["Offline: using saved AutoEQ catalog"] = "Ei yhteyttä: käytetään tallennettua AutoEQ-luetteloa",
        ["AutoEQ catalog failed: %s"] = "AutoEQ-luettelon lataus epäonnistui: %s",
        ["AutoEQ catalog invalid: %s"] = "Virheellinen AutoEQ-luettelo: %s",
        ["Catalog loaded; cache could not be saved"] = "Luettelo ladattu; välimuistia ei voitu tallentaa",
        ["AutoEQ catalog ready"] = "AutoEQ-luettelo valmis",
        ["request could not start"] = "pyyntöä ei voitu aloittaa",
        ["Model: %s"] = "Malli: %s",
        ["Measurement: %s"] = "Mittaus: %s",
        ["Replace existing profile: %s"] = "Korvaa nykyinen profiili: %s",
        ["Save as new copy"] = "Tallenna uutena kopiona",
        ["Download profile"] = "Lataa profiili",
        ["Profile is empty or too large"] = "Profiili on tyhjä tai liian suuri",
        ["Invalid or duplicate preamp row"] = "Virheellinen tai päällekkäinen esivahvistusrivi",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "Esivahvistus on soittimen alueen ulkopuolella (-12…+12 dB)",
        ["Malformed or duplicate filter row"] = "Virheellinen tai päällekkäinen suodatinrivi",
        ["Filter count or enable state is invalid"] = "Suodattimen numero tai tila on virheellinen",
        ["Filter has a non-finite number"] = "Suodattimessa on epäkelpo luku",
        ["Filter frequency is outside 20–20000 Hz"] = "Suodattimen taajuus on alueen 20–20000 Hz ulkopuolella",
        ["Filter gain is outside -12 to +12 dB"] = "Suodattimen vahvistus on alueen -12…+12 dB ulkopuolella",
        ["Filter Q is outside 0.1–10"] = "Suodattimen Q-arvo on alueen 0.1–10 ulkopuolella",
        ["Unsupported filter type: %s"] = "Suodatintyyppiä ei tueta: %s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "Muunnettu hyllyjyrkkyys on alueen ulkopuolella (0.1–10)",
        ["Unrecognized profile row: %s"] = "Tunnistamaton profiilirivi: %s",
        ["Profile has no Preamp row"] = "Profiilista puuttuu Preamp-rivi",
        ["Profile has no filter rows"] = "Profiilissa ei ole suodatinrivejä",
        ["Filter numbering has a gap"] = "Suodattimien numeroinnissa on aukko",
        ["Profile now exists; choose Replace explicitly"] = "Profiili on jo olemassa; valitse Korvaa erikseen",
        ["Could not create PEQ_Profiles"] = "PEQ_Profiles-kansiota ei voitu luoda",
        ["Could not open temporary profile"] = "Väliaikaista profiilia ei voitu avata",
        ["Could not save profile; existing file was kept"] = "Profiilia ei voitu tallentaa; vanha tiedosto säilytettiin",
        ["Invalid AutoEQ catalog path"] = "Virheellinen AutoEQ-luettelopolku",
        ["AutoEQ profile"] = "AutoEQ-profiili",
        ["Downloading profile…"] = "Ladataan profiilia…",
        ["Profile download failed: %s"] = "Profiilin lataus epäonnistui: %s",
        ["Validating and saving profile…"] = "Tarkistetaan ja tallennetaan profiilia…",
        ["Profile not saved: %s"] = "Profiilia ei tallennettu: %s",
        ["Saved. Select it in Equalizer → Profiles"] = "Tallennettu. Valitse se kohdasta Taajuuskorjain → Profiilit",
        ["Profile download could not start: %s"] = "Profiilin latausta ei voitu aloittaa: %s",
        ["Downloading AutoEQ profile…"] = "Ladataan AutoEQ-profiilia…",
        ["No models matched"] = "Ei osumia",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d osumaa",
        ["Enter at least 2 characters"] = "Syötä vähintään 2 merkkiä",
        ["Models %d–%d"] = "Mallit %d–%d",
        ["AutoEQ pages · %d matches"] = "AutoEQ-sivut · %d osumaa",
        ["Search AutoEQ models (%d)"] = "Hae AutoEQ-malleja (%d)",
        ["Search AutoEQ models"] = "Hae AutoEQ-malleja",
        ["Refresh catalog"] = "Päivitä luettelo",
        ["Cancel current task"] = "Peruuta nykyinen tehtävä",
        ["About and sources"] = "Tietoja ja lähteet",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "Hae AutoEQ:sta",
        ["Using saved catalog: %d models"] = "Käytetään tallennettua luetteloa: %d mallia",
        ["Catalog updated: %d models"] = "Luettelo päivitetty: %d mallia",
        ["AutoEQ task cancelled"] = "AutoEQ-tehtävä peruutettu",
        ["No AutoEQ task is running"] = "AutoEQ-tehtävää ei ole käynnissä",
        ["AutoEQ sources"] = "AutoEQ-lähteet",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "AutoEQ-profiililuettelon ja mittaukset tarjoaa jaakkopasanen/AutoEq.\n\nLuettelo: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nTuodut profiilit tallennetaan PEQ_Profiles-kansioon; ota profiili käyttöön kohdasta Taajuuskorjain → Profiilit.",
    },
    fr = {
        ["Catalog is empty or too large"] = "Le catalogue est vide ou trop volumineux",
        ["Catalog has a line longer than %d bytes"] = "Le catalogue contient une ligne de plus de %d octets",
        ["Catalog has too many models"] = "Le catalogue contient trop de modèles",
        ["No model entries found in catalog"] = "Aucun modèle trouvé dans le catalogue",
        ["AutoEQ catalog"] = "Catalogue AutoEQ",
        ["Loading catalog…"] = "Chargement du catalogue…",
        ["Loading AutoEQ catalog…"] = "Chargement du catalogue AutoEQ…",
        ["error"] = "erreur",
        ["Offline: using saved AutoEQ catalog"] = "Hors ligne : utilisation du catalogue AutoEQ enregistré",
        ["AutoEQ catalog failed: %s"] = "Échec du catalogue AutoEQ : %s",
        ["AutoEQ catalog invalid: %s"] = "Catalogue AutoEQ invalide : %s",
        ["Catalog loaded; cache could not be saved"] = "Catalogue chargé ; impossible d'enregistrer le cache",
        ["AutoEQ catalog ready"] = "Catalogue AutoEQ prêt",
        ["request could not start"] = "la requête n'a pas pu démarrer",
        ["Model: %s"] = "Modèle : %s",
        ["Measurement: %s"] = "Mesure : %s",
        ["Replace existing profile: %s"] = "Remplacer le profil existant : %s",
        ["Save as new copy"] = "Enregistrer une nouvelle copie",
        ["Download profile"] = "Télécharger le profil",
        ["Profile is empty or too large"] = "Le profil est vide ou trop volumineux",
        ["Invalid or duplicate preamp row"] = "Ligne de préampli invalide ou en double",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "Le préampli est hors de la plage du lecteur (-12 à +12 dB)",
        ["Malformed or duplicate filter row"] = "Ligne de filtre mal formée ou en double",
        ["Filter count or enable state is invalid"] = "Numéro ou état du filtre invalide",
        ["Filter has a non-finite number"] = "Le filtre contient un nombre non fini",
        ["Filter frequency is outside 20–20000 Hz"] = "La fréquence du filtre est hors de 20–20000 Hz",
        ["Filter gain is outside -12 to +12 dB"] = "Le gain du filtre est hors de -12 à +12 dB",
        ["Filter Q is outside 0.1–10"] = "Le facteur Q du filtre est hors de 0.1–10",
        ["Unsupported filter type: %s"] = "Type de filtre non pris en charge : %s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "La pente convertie est hors de la plage du lecteur (0.1–10)",
        ["Unrecognized profile row: %s"] = "Ligne de profil non reconnue : %s",
        ["Profile has no Preamp row"] = "Le profil ne contient pas de ligne Preamp",
        ["Profile has no filter rows"] = "Le profil ne contient aucune ligne de filtre",
        ["Filter numbering has a gap"] = "La numérotation des filtres comporte un écart",
        ["Profile now exists; choose Replace explicitly"] = "Le profil existe déjà ; choisissez explicitement Remplacer",
        ["Could not create PEQ_Profiles"] = "Impossible de créer PEQ_Profiles",
        ["Could not open temporary profile"] = "Impossible d'ouvrir le profil temporaire",
        ["Could not save profile; existing file was kept"] = "Impossible d'enregistrer le profil ; le fichier existant a été conservé",
        ["Invalid AutoEQ catalog path"] = "Chemin du catalogue AutoEQ invalide",
        ["AutoEQ profile"] = "Profil AutoEQ",
        ["Downloading profile…"] = "Téléchargement du profil…",
        ["Profile download failed: %s"] = "Échec du téléchargement du profil : %s",
        ["Validating and saving profile…"] = "Validation et enregistrement du profil…",
        ["Profile not saved: %s"] = "Profil non enregistré : %s",
        ["Saved. Select it in Equalizer → Profiles"] = "Enregistré. Sélectionnez-le dans Égaliseur → Profils",
        ["Profile download could not start: %s"] = "Le téléchargement n'a pas pu démarrer : %s",
        ["Downloading AutoEQ profile…"] = "Téléchargement du profil AutoEQ…",
        ["No models matched"] = "Aucun modèle correspondant",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d résultats",
        ["Enter at least 2 characters"] = "Saisissez au moins 2 caractères",
        ["Models %d–%d"] = "Modèles %d–%d",
        ["AutoEQ pages · %d matches"] = "Pages AutoEQ · %d résultats",
        ["Search AutoEQ models (%d)"] = "Rechercher des modèles AutoEQ (%d)",
        ["Search AutoEQ models"] = "Rechercher des modèles AutoEQ",
        ["Refresh catalog"] = "Actualiser le catalogue",
        ["Cancel current task"] = "Annuler la tâche en cours",
        ["About and sources"] = "À propos et sources",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "Rechercher dans AutoEQ",
        ["Using saved catalog: %d models"] = "Catalogue enregistré : %d modèles",
        ["Catalog updated: %d models"] = "Catalogue mis à jour : %d modèles",
        ["AutoEQ task cancelled"] = "Tâche AutoEQ annulée",
        ["No AutoEQ task is running"] = "Aucune tâche AutoEQ en cours",
        ["AutoEQ sources"] = "Sources AutoEQ",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "Le catalogue de profils AutoEQ et les mesures sont fournis par jaakkopasanen/AutoEq.\n\nCatalogue : https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nLes profils importés sont enregistrés dans PEQ_Profiles ; choisissez-en un dans Égaliseur → Profils pour le charger.",
    },
    it = {
        ["Catalog is empty or too large"] = "Il catalogo è vuoto o troppo grande",
        ["Catalog has a line longer than %d bytes"] = "Il catalogo ha una riga più lunga di %d byte",
        ["Catalog has too many models"] = "Il catalogo contiene troppi modelli",
        ["No model entries found in catalog"] = "Nessun modello trovato nel catalogo",
        ["AutoEQ catalog"] = "Catalogo AutoEQ",
        ["Loading catalog…"] = "Caricamento catalogo…",
        ["Loading AutoEQ catalog…"] = "Caricamento catalogo AutoEQ…",
        ["error"] = "errore",
        ["Offline: using saved AutoEQ catalog"] = "Offline: uso il catalogo AutoEQ salvato",
        ["AutoEQ catalog failed: %s"] = "Errore catalogo AutoEQ: %s",
        ["AutoEQ catalog invalid: %s"] = "Catalogo AutoEQ non valido: %s",
        ["Catalog loaded; cache could not be saved"] = "Catalogo caricato; impossibile salvare la cache",
        ["AutoEQ catalog ready"] = "Catalogo AutoEQ pronto",
        ["request could not start"] = "impossibile avviare la richiesta",
        ["Model: %s"] = "Modello: %s",
        ["Measurement: %s"] = "Misurazione: %s",
        ["Replace existing profile: %s"] = "Sostituisci profilo esistente: %s",
        ["Save as new copy"] = "Salva come nuova copia",
        ["Download profile"] = "Scarica profilo",
        ["Profile is empty or too large"] = "Il profilo è vuoto o troppo grande",
        ["Invalid or duplicate preamp row"] = "Riga preamp non valida o duplicata",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "Preamp fuori dall'intervallo del lettore (-12 a +12 dB)",
        ["Malformed or duplicate filter row"] = "Riga filtro malformata o duplicata",
        ["Filter count or enable state is invalid"] = "Numero o stato del filtro non valido",
        ["Filter has a non-finite number"] = "Il filtro contiene un numero non finito",
        ["Filter frequency is outside 20–20000 Hz"] = "La frequenza del filtro è fuori da 20–20000 Hz",
        ["Filter gain is outside -12 to +12 dB"] = "Il guadagno del filtro è fuori da -12 a +12 dB",
        ["Filter Q is outside 0.1–10"] = "Il Q del filtro è fuori da 0.1–10",
        ["Unsupported filter type: %s"] = "Tipo di filtro non supportato: %s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "La pendenza convertita è fuori dall'intervallo del lettore (0.1–10)",
        ["Unrecognized profile row: %s"] = "Riga profilo non riconosciuta: %s",
        ["Profile has no Preamp row"] = "Il profilo non contiene la riga Preamp",
        ["Profile has no filter rows"] = "Il profilo non contiene righe filtro",
        ["Filter numbering has a gap"] = "La numerazione dei filtri presenta un'interruzione",
        ["Profile now exists; choose Replace explicitly"] = "Il profilo esiste già; scegli esplicitamente Sostituisci",
        ["Could not create PEQ_Profiles"] = "Impossibile creare PEQ_Profiles",
        ["Could not open temporary profile"] = "Impossibile aprire il profilo temporaneo",
        ["Could not save profile; existing file was kept"] = "Impossibile salvare il profilo; il file esistente è stato mantenuto",
        ["Invalid AutoEQ catalog path"] = "Percorso del catalogo AutoEQ non valido",
        ["AutoEQ profile"] = "Profilo AutoEQ",
        ["Downloading profile…"] = "Download del profilo…",
        ["Profile download failed: %s"] = "Download profilo non riuscito: %s",
        ["Validating and saving profile…"] = "Verifica e salvataggio del profilo…",
        ["Profile not saved: %s"] = "Profilo non salvato: %s",
        ["Saved. Select it in Equalizer → Profiles"] = "Salvato. Selezionalo in Equalizzatore → Profili",
        ["Profile download could not start: %s"] = "Impossibile avviare il download del profilo: %s",
        ["Downloading AutoEQ profile…"] = "Download profilo AutoEQ…",
        ["No models matched"] = "Nessun modello trovato",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d risultati",
        ["Enter at least 2 characters"] = "Inserisci almeno 2 caratteri",
        ["Models %d–%d"] = "Modelli %d–%d",
        ["AutoEQ pages · %d matches"] = "Pagine AutoEQ · %d risultati",
        ["Search AutoEQ models (%d)"] = "Cerca modelli AutoEQ (%d)",
        ["Search AutoEQ models"] = "Cerca modelli AutoEQ",
        ["Refresh catalog"] = "Aggiorna catalogo",
        ["Cancel current task"] = "Annulla operazione in corso",
        ["About and sources"] = "Informazioni e fonti",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "Cerca in AutoEQ",
        ["Using saved catalog: %d models"] = "Uso catalogo salvato: %d modelli",
        ["Catalog updated: %d models"] = "Catalogo aggiornato: %d modelli",
        ["AutoEQ task cancelled"] = "Operazione AutoEQ annullata",
        ["No AutoEQ task is running"] = "Nessuna operazione AutoEQ in corso",
        ["AutoEQ sources"] = "Fonti AutoEQ",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "Il catalogo dei profili AutoEQ e le misurazioni sono forniti da jaakkopasanen/AutoEq.\n\nCatalogo: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nI profili importati vengono salvati in PEQ_Profiles; scegline uno in Equalizzatore → Profili per caricarlo.",
    },
    ja = {
        ["Catalog is empty or too large"] = "カタログが空か大きすぎます",
        ["Catalog has a line longer than %d bytes"] = "カタログに %d バイトを超える行があります",
        ["Catalog has too many models"] = "カタログのモデル数が多すぎます",
        ["No model entries found in catalog"] = "カタログにモデルが見つかりません",
        ["AutoEQ catalog"] = "AutoEQ カタログ",
        ["Loading catalog…"] = "カタログを読み込み中…",
        ["Loading AutoEQ catalog…"] = "AutoEQ カタログを読み込み中…",
        ["error"] = "エラー",
        ["Offline: using saved AutoEQ catalog"] = "オフライン: 保存済みの AutoEQ カタログを使用します",
        ["AutoEQ catalog failed: %s"] = "AutoEQ カタログの取得失敗: %s",
        ["AutoEQ catalog invalid: %s"] = "AutoEQ カタログが無効です: %s",
        ["Catalog loaded; cache could not be saved"] = "カタログを読み込みました (キャッシュ保存失敗)",
        ["AutoEQ catalog ready"] = "AutoEQ カタログ準備完了",
        ["request could not start"] = "リクエストを開始できませんでした",
        ["Model: %s"] = "モデル: %s",
        ["Measurement: %s"] = "測定元: %s",
        ["Replace existing profile: %s"] = "既存のプロファイルを置換: %s",
        ["Save as new copy"] = "新しいコピーとして保存",
        ["Download profile"] = "プロファイルをダウンロード",
        ["Profile is empty or too large"] = "プロファイルが空か大きすぎます",
        ["Invalid or duplicate preamp row"] = "無効または重複したプリアンプ行です",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "プリアンプがプレーヤーの範囲外です (-12〜+12 dB)",
        ["Malformed or duplicate filter row"] = "不正または重複したフィルター行です",
        ["Filter count or enable state is invalid"] = "フィルター番号または有効状態が無効です",
        ["Filter has a non-finite number"] = "フィルターに無効な数値があります",
        ["Filter frequency is outside 20–20000 Hz"] = "フィルター周波数が 20–20000 Hz の範囲外です",
        ["Filter gain is outside -12 to +12 dB"] = "フィルターゲインが -12〜+12 dB の範囲外です",
        ["Filter Q is outside 0.1–10"] = "フィルター Q が 0.1–10 の範囲外です",
        ["Unsupported filter type: %s"] = "未対応のフィルター種類: %s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "変換後のシェルフスロープが範囲外です (0.1–10)",
        ["Unrecognized profile row: %s"] = "認識できないプロファイル行: %s",
        ["Profile has no Preamp row"] = "プロファイルに Preamp 行がありません",
        ["Profile has no filter rows"] = "プロファイルにフィルター行がありません",
        ["Filter numbering has a gap"] = "フィルター番号に欠番があります",
        ["Profile now exists; choose Replace explicitly"] = "プロファイルが既に存在します。置換を選択してください",
        ["Could not create PEQ_Profiles"] = "PEQ_Profiles を作成できませんでした",
        ["Could not open temporary profile"] = "一時プロファイルを開けませんでした",
        ["Could not save profile; existing file was kept"] = "保存できませんでした。既存のファイルを保持しました",
        ["Invalid AutoEQ catalog path"] = "無効な AutoEQ カタログパスです",
        ["AutoEQ profile"] = "AutoEQ プロファイル",
        ["Downloading profile…"] = "プロファイルをダウンロード中…",
        ["Profile download failed: %s"] = "プロファイルのダウンロード失敗: %s",
        ["Validating and saving profile…"] = "プロファイルを検証して保存中…",
        ["Profile not saved: %s"] = "プロファイルを保存できませんでした: %s",
        ["Saved. Select it in Equalizer → Profiles"] = "保存しました。イコライザー → プロファイルで選択してください",
        ["Profile download could not start: %s"] = "ダウンロードを開始できませんでした: %s",
        ["Downloading AutoEQ profile…"] = "AutoEQ プロファイルをダウンロード中…",
        ["No models matched"] = "一致するモデルがありません",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d 件",
        ["Enter at least 2 characters"] = "2 文字以上入力してください",
        ["Models %d–%d"] = "モデル %d–%d",
        ["AutoEQ pages · %d matches"] = "AutoEQ ページ · %d 件",
        ["Search AutoEQ models (%d)"] = "AutoEQ モデルを検索 (%d)",
        ["Search AutoEQ models"] = "AutoEQ モデルを検索",
        ["Refresh catalog"] = "カタログを更新",
        ["Cancel current task"] = "現在のタスクを中止",
        ["About and sources"] = "概要とデータ元",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "AutoEQ を検索",
        ["Using saved catalog: %d models"] = "保存済みカタログを使用中: %d モデル",
        ["Catalog updated: %d models"] = "カタログを更新しました: %d モデル",
        ["AutoEQ task cancelled"] = "AutoEQ タスクを中止しました",
        ["No AutoEQ task is running"] = "実行中の AutoEQ タスクはありません",
        ["AutoEQ sources"] = "AutoEQ のデータ元",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "AutoEQ プロファイルカタログと測定データは jaakkopasanen/AutoEq により提供されています。\n\nカタログ: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\n取り込んだプロファイルは PEQ_Profiles に保存されます。イコライザー → プロファイルから選択して読み込んでください。",
    },
    nl = {
        ["Catalog is empty or too large"] = "Catalogus is leeg of te groot",
        ["Catalog has a line longer than %d bytes"] = "Catalogus bevat een regel langer dan %d bytes",
        ["Catalog has too many models"] = "Catalogus bevat te veel modellen",
        ["No model entries found in catalog"] = "Geen modellen gevonden in catalogus",
        ["AutoEQ catalog"] = "AutoEQ-catalogus",
        ["Loading catalog…"] = "Catalogus laden…",
        ["Loading AutoEQ catalog…"] = "AutoEQ-catalogus laden…",
        ["error"] = "fout",
        ["Offline: using saved AutoEQ catalog"] = "Offline: opgeslagen AutoEQ-catalogus wordt gebruikt",
        ["AutoEQ catalog failed: %s"] = "AutoEQ-catalogus mislukt: %s",
        ["AutoEQ catalog invalid: %s"] = "AutoEQ-catalogus ongeldig: %s",
        ["Catalog loaded; cache could not be saved"] = "Catalogus geladen; cache kon niet worden opgeslagen",
        ["AutoEQ catalog ready"] = "AutoEQ-catalogus gereed",
        ["request could not start"] = "verzoek kon niet starten",
        ["Model: %s"] = "Model: %s",
        ["Measurement: %s"] = "Meting: %s",
        ["Replace existing profile: %s"] = "Bestaand profiel vervangen: %s",
        ["Save as new copy"] = "Opslaan als nieuwe kopie",
        ["Download profile"] = "Profiel downloaden",
        ["Profile is empty or too large"] = "Profiel is leeg of te groot",
        ["Invalid or duplicate preamp row"] = "Ongeldige of dubbele preamp-regel",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "Preamp valt buiten het bereik van de speler (-12 tot +12 dB)",
        ["Malformed or duplicate filter row"] = "Ongeldige of dubbele filterregel",
        ["Filter count or enable state is invalid"] = "Filternummer of status is ongeldig",
        ["Filter has a non-finite number"] = "Filter bevat een ongeldig getal",
        ["Filter frequency is outside 20–20000 Hz"] = "Filterfrequentie valt buiten 20–20000 Hz",
        ["Filter gain is outside -12 to +12 dB"] = "Filterversterking valt buiten -12 tot +12 dB",
        ["Filter Q is outside 0.1–10"] = "Filter-Q valt buiten 0.1–10",
        ["Unsupported filter type: %s"] = "Niet-ondersteund filtertype: %s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "Omgerekende filterhelling valt buiten het bereik (0.1–10)",
        ["Unrecognized profile row: %s"] = "Onbekende profielregel: %s",
        ["Profile has no Preamp row"] = "Profiel bevat geen Preamp-regel",
        ["Profile has no filter rows"] = "Profiel bevat geen filterregels",
        ["Filter numbering has a gap"] = "Filternummering mist een nummer",
        ["Profile now exists; choose Replace explicitly"] = "Profiel bestaat al; kies expliciet Vervangen",
        ["Could not create PEQ_Profiles"] = "Kon PEQ_Profiles niet aanmaken",
        ["Could not open temporary profile"] = "Kon tijdelijk profiel niet openen",
        ["Could not save profile; existing file was kept"] = "Kon profiel niet opslaan; bestaand bestand is behouden",
        ["Invalid AutoEQ catalog path"] = "Ongeldig AutoEQ-cataloguspad",
        ["AutoEQ profile"] = "AutoEQ-profiel",
        ["Downloading profile…"] = "Profiel downloaden…",
        ["Profile download failed: %s"] = "Profiel downloaden mislukt: %s",
        ["Validating and saving profile…"] = "Profiel controleren en opslaan…",
        ["Profile not saved: %s"] = "Profiel niet opgeslagen: %s",
        ["Saved. Select it in Equalizer → Profiles"] = "Opgeslagen. Selecteer het via Equalizer → Profielen",
        ["Profile download could not start: %s"] = "Profiel downloaden kon niet starten: %s",
        ["Downloading AutoEQ profile…"] = "AutoEQ-profiel downloaden…",
        ["No models matched"] = "Geen modellen gevonden",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d resultaten",
        ["Enter at least 2 characters"] = "Voer minimaal 2 tekens in",
        ["Models %d–%d"] = "Modellen %d–%d",
        ["AutoEQ pages · %d matches"] = "AutoEQ-pagina's · %d resultaten",
        ["Search AutoEQ models (%d)"] = "AutoEQ-modellen zoeken (%d)",
        ["Search AutoEQ models"] = "AutoEQ-modellen zoeken",
        ["Refresh catalog"] = "Catalogus vernieuwen",
        ["Cancel current task"] = "Huidige taak annuleren",
        ["About and sources"] = "Over en bronnen",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "AutoEQ doorzoeken",
        ["Using saved catalog: %d models"] = "Opgeslagen catalogus gebruikt: %d modellen",
        ["Catalog updated: %d models"] = "Catalogus bijgewerkt: %d modellen",
        ["AutoEQ task cancelled"] = "AutoEQ-taak geannuleerd",
        ["No AutoEQ task is running"] = "Er is geen AutoEQ-taak actief",
        ["AutoEQ sources"] = "AutoEQ-bronnen",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "De AutoEQ-profielcatalogus en metingen worden geleverd door jaakkopasanen/AutoEq.\n\nCatalogus: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nGeïmporteerde profielen worden opgeslagen onder PEQ_Profiles; kies er een in Equalizer → Profielen om het te laden.",
    },
    pt = {
        ["Catalog is empty or too large"] = "O catálogo está vazio ou é muito grande",
        ["Catalog has a line longer than %d bytes"] = "O catálogo tem uma linha maior que %d bytes",
        ["Catalog has too many models"] = "O catálogo tem modelos demais",
        ["No model entries found in catalog"] = "Nenhum modelo encontrado no catálogo",
        ["AutoEQ catalog"] = "Catálogo AutoEQ",
        ["Loading catalog…"] = "Carregando catálogo…",
        ["Loading AutoEQ catalog…"] = "Carregando catálogo AutoEQ…",
        ["error"] = "erro",
        ["Offline: using saved AutoEQ catalog"] = "Offline: usando catálogo AutoEQ salvo",
        ["AutoEQ catalog failed: %s"] = "Falha no catálogo AutoEQ: %s",
        ["AutoEQ catalog invalid: %s"] = "Catálogo AutoEQ inválido: %s",
        ["Catalog loaded; cache could not be saved"] = "Catálogo carregado; não foi possível salvar o cache",
        ["AutoEQ catalog ready"] = "Catálogo AutoEQ pronto",
        ["request could not start"] = "não foi possível iniciar a requisição",
        ["Model: %s"] = "Modelo: %s",
        ["Measurement: %s"] = "Medição: %s",
        ["Replace existing profile: %s"] = "Substituir perfil existente: %s",
        ["Save as new copy"] = "Salvar como nova cópia",
        ["Download profile"] = "Baixar perfil",
        ["Profile is empty or too large"] = "O perfil está vazio ou é muito grande",
        ["Invalid or duplicate preamp row"] = "Linha de pré-amplificação inválida ou duplicada",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "O pré-amplificador está fora da faixa do reprodutor (-12 a +12 dB)",
        ["Malformed or duplicate filter row"] = "Linha de filtro malformada ou duplicada",
        ["Filter count or enable state is invalid"] = "Número ou estado do filtro inválido",
        ["Filter has a non-finite number"] = "O filtro tem um número não finito",
        ["Filter frequency is outside 20–20000 Hz"] = "A frequência do filtro está fora de 20–20000 Hz",
        ["Filter gain is outside -12 to +12 dB"] = "O ganho do filtro está fora de -12 a +12 dB",
        ["Filter Q is outside 0.1–10"] = "O fator Q do filtro está fora de 0.1–10",
        ["Unsupported filter type: %s"] = "Tipo de filtro não suportado: %s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "A inclinação convertida está fora da faixa do reprodutor (0.1–10)",
        ["Unrecognized profile row: %s"] = "Linha de perfil não reconhecida: %s",
        ["Profile has no Preamp row"] = "O perfil não tem linha Preamp",
        ["Profile has no filter rows"] = "O perfil não tem linhas de filtro",
        ["Filter numbering has a gap"] = "A numeração dos filtros tem uma lacuna",
        ["Profile now exists; choose Replace explicitly"] = "O perfil já existe; escolha Substituir explicitamente",
        ["Could not create PEQ_Profiles"] = "Não foi possível criar PEQ_Profiles",
        ["Could not open temporary profile"] = "Não foi possível abrir o perfil temporário",
        ["Could not save profile; existing file was kept"] = "Não foi possível salvar o perfil; o arquivo existente foi mantido",
        ["Invalid AutoEQ catalog path"] = "Caminho do catálogo AutoEQ inválido",
        ["AutoEQ profile"] = "Perfil AutoEQ",
        ["Downloading profile…"] = "Baixando perfil…",
        ["Profile download failed: %s"] = "Falha ao baixar perfil: %s",
        ["Validating and saving profile…"] = "Validando e salvando perfil…",
        ["Profile not saved: %s"] = "Perfil não salvo: %s",
        ["Saved. Select it in Equalizer → Profiles"] = "Salvo. Selecione-o em Equalizador → Perfis",
        ["Profile download could not start: %s"] = "Não foi possível iniciar o download do perfil: %s",
        ["Downloading AutoEQ profile…"] = "Baixando perfil AutoEQ…",
        ["No models matched"] = "Nenhum modelo encontrado",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d resultados",
        ["Enter at least 2 characters"] = "Digite pelo menos 2 caracteres",
        ["Models %d–%d"] = "Modelos %d–%d",
        ["AutoEQ pages · %d matches"] = "Páginas AutoEQ · %d resultados",
        ["Search AutoEQ models (%d)"] = "Buscar modelos AutoEQ (%d)",
        ["Search AutoEQ models"] = "Buscar modelos AutoEQ",
        ["Refresh catalog"] = "Atualizar catálogo",
        ["Cancel current task"] = "Cancelar tarefa atual",
        ["About and sources"] = "Sobre e fontes",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "Buscar no AutoEQ",
        ["Using saved catalog: %d models"] = "Usando catálogo salvo: %d modelos",
        ["Catalog updated: %d models"] = "Catálogo atualizado: %d modelos",
        ["AutoEQ task cancelled"] = "Tarefa AutoEQ cancelada",
        ["No AutoEQ task is running"] = "Nenhuma tarefa AutoEQ em execução",
        ["AutoEQ sources"] = "Fontes do AutoEQ",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "O catálogo de perfis AutoEQ e as medições são fornecidos por jaakkopasanen/AutoEq.\n\nCatálogo: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nOs perfis importados são salvos em PEQ_Profiles; escolha um em Equalizador → Perfis para carregá-lo.",
    },
    ru = {
        ["Catalog is empty or too large"] = "Каталог пуст или слишком велик",
        ["Catalog has a line longer than %d bytes"] = "Строка в каталоге превышает %d байт",
        ["Catalog has too many models"] = "В каталоге слишком много моделей",
        ["No model entries found in catalog"] = "Модели в каталоге не найдены",
        ["AutoEQ catalog"] = "Каталог AutoEQ",
        ["Loading catalog…"] = "Загрузка каталога…",
        ["Loading AutoEQ catalog…"] = "Загрузка каталога AutoEQ…",
        ["error"] = "ошибка",
        ["Offline: using saved AutoEQ catalog"] = "Офлайн: используется сохранённый каталог AutoEQ",
        ["AutoEQ catalog failed: %s"] = "Ошибка каталога AutoEQ: %s",
        ["AutoEQ catalog invalid: %s"] = "Некорректный каталог AutoEQ: %s",
        ["Catalog loaded; cache could not be saved"] = "Каталог загружен; не удалось сохранить кэш",
        ["AutoEQ catalog ready"] = "Каталог AutoEQ готов",
        ["request could not start"] = "не удалось запустить запрос",
        ["Model: %s"] = "Модель: %s",
        ["Measurement: %s"] = "Измерение: %s",
        ["Replace existing profile: %s"] = "Заменить существующий профиль: %s",
        ["Save as new copy"] = "Сохранить как новую копию",
        ["Download profile"] = "Скачать профиль",
        ["Profile is empty or too large"] = "Профиль пуст или слишком велик",
        ["Invalid or duplicate preamp row"] = "Некорректная или дублирующаяся строка Preamp",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "Preamp вне диапазона плеера (-12…+12 дБ)",
        ["Malformed or duplicate filter row"] = "Некорректная или дублирующаяся строка фильтра",
        ["Filter count or enable state is invalid"] = "Некорректный номер или состояние фильтра",
        ["Filter has a non-finite number"] = "Некорректное число в параметрах фильтра",
        ["Filter frequency is outside 20–20000 Hz"] = "Частота фильтра вне диапазона 20–20000 Гц",
        ["Filter gain is outside -12 to +12 dB"] = "Усиление фильтра вне диапазона -12…+12 дБ",
        ["Filter Q is outside 0.1–10"] = "Добротность Q вне диапазона 0.1–10",
        ["Unsupported filter type: %s"] = "Неподдерживаемый тип фильтра: %s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "Преобразованный наклон полки вне диапазона (0.1–10)",
        ["Unrecognized profile row: %s"] = "Нераспознанная строка профиля: %s",
        ["Profile has no Preamp row"] = "В профиле нет строки Preamp",
        ["Profile has no filter rows"] = "В профиле нет строк фильтров",
        ["Filter numbering has a gap"] = "Пропуск в нумерации фильтров",
        ["Profile now exists; choose Replace explicitly"] = "Профиль уже существует; выберите Заменить",
        ["Could not create PEQ_Profiles"] = "Не удалось создать PEQ_Profiles",
        ["Could not open temporary profile"] = "Не удалось открыть временный профиль",
        ["Could not save profile; existing file was kept"] = "Не удалось сохранить профиль; старый файл сохранён",
        ["Invalid AutoEQ catalog path"] = "Некорректный путь в каталоге AutoEQ",
        ["AutoEQ profile"] = "Профиль AutoEQ",
        ["Downloading profile…"] = "Загрузка профиля…",
        ["Profile download failed: %s"] = "Ошибка загрузки профиля: %s",
        ["Validating and saving profile…"] = "Проверка и сохранение профиля…",
        ["Profile not saved: %s"] = "Профиль не сохранён: %s",
        ["Saved. Select it in Equalizer → Profiles"] = "Сохранено. Выберите его в Эквалайзер → Профили",
        ["Profile download could not start: %s"] = "Не удалось начать загрузку профиля: %s",
        ["Downloading AutoEQ profile…"] = "Загрузка профиля AutoEQ…",
        ["No models matched"] = "Модели не найдены",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d совп.",
        ["Enter at least 2 characters"] = "Введите не менее 2 символов",
        ["Models %d–%d"] = "Модели %d–%d",
        ["AutoEQ pages · %d matches"] = "Страницы AutoEQ · %d совп.",
        ["Search AutoEQ models (%d)"] = "Поиск моделей AutoEQ (%d)",
        ["Search AutoEQ models"] = "Поиск моделей AutoEQ",
        ["Refresh catalog"] = "Обновить каталог",
        ["Cancel current task"] = "Отменить текущую задачу",
        ["About and sources"] = "О плагине и источниках",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "Поиск в AutoEQ",
        ["Using saved catalog: %d models"] = "Сохранённый каталог: %d моделей",
        ["Catalog updated: %d models"] = "Каталог обновлён: %d моделей",
        ["AutoEQ task cancelled"] = "Задача AutoEQ отменена",
        ["No AutoEQ task is running"] = "Нет активных задач AutoEQ",
        ["AutoEQ sources"] = "Источники AutoEQ",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "Каталог профилей и измерения AutoEQ предоставлены проектом jaakkopasanen/AutoEq.\n\nКаталог: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nИмпортированные профили сохраняются в папку PEQ_Profiles; выберите нужный в меню Эквалайзер → Профили.",
    },
    uk = {
        ["Catalog is empty or too large"] = "Каталог порожній або завеликий",
        ["Catalog has a line longer than %d bytes"] = "Рядок у каталозі перевищує %d байт",
        ["Catalog has too many models"] = "У каталозі забагато моделей",
        ["No model entries found in catalog"] = "Моделі в каталозі не знайдено",
        ["AutoEQ catalog"] = "Каталог AutoEQ",
        ["Loading catalog…"] = "Завантаження каталогу…",
        ["Loading AutoEQ catalog…"] = "Завантаження каталогу AutoEQ…",
        ["error"] = "помилка",
        ["Offline: using saved AutoEQ catalog"] = "Офлайн: використовується збережений каталог AutoEQ",
        ["AutoEQ catalog failed: %s"] = "Помилка каталогу AutoEQ: %s",
        ["AutoEQ catalog invalid: %s"] = "Некоректний каталог AutoEQ: %s",
        ["Catalog loaded; cache could not be saved"] = "Каталог завантажено; не вдалося зберегти кеш",
        ["AutoEQ catalog ready"] = "Каталог AutoEQ готовий",
        ["request could not start"] = "не вдалося розпочати запит",
        ["Model: %s"] = "Модель: %s",
        ["Measurement: %s"] = "Вимірювання: %s",
        ["Replace existing profile: %s"] = "Замінити наявний профіль: %s",
        ["Save as new copy"] = "Зберегти як нову копію",
        ["Download profile"] = "Завантажити профіль",
        ["Profile is empty or too large"] = "Профіль порожній або завеликий",
        ["Invalid or duplicate preamp row"] = "Некоректний або дубльований рядок Preamp",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "Preamp поза діапазоном плеєра (-12…+12 дБ)",
        ["Malformed or duplicate filter row"] = "Некоректний або дубльований рядок фільтра",
        ["Filter count or enable state is invalid"] = "Некоректний номер або стан фільтра",
        ["Filter has a non-finite number"] = "Некоректне число у параметрах фільтра",
        ["Filter frequency is outside 20–20000 Hz"] = "Частота фільтра поза діапазоном 20–20000 Гц",
        ["Filter gain is outside -12 to +12 dB"] = "Підсилення фільтра поза діапазоном -12…+12 дБ",
        ["Filter Q is outside 0.1–10"] = "Добротність Q поза діапазоном 0.1–10",
        ["Unsupported filter type: %s"] = "Непідтримуваний тип фільтра: %s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "Перетворений нахил полиці поза діапазоном (0.1–10)",
        ["Unrecognized profile row: %s"] = "Нерозпізнаний рядок профілю: %s",
        ["Profile has no Preamp row"] = "У профілі немає рядка Preamp",
        ["Profile has no filter rows"] = "У профілі немає рядків фільтрів",
        ["Filter numbering has a gap"] = "Пропуск у нумерації фільтрів",
        ["Profile now exists; choose Replace explicitly"] = "Профіль уже існує; виберіть Замінити",
        ["Could not create PEQ_Profiles"] = "Не вдалося створити PEQ_Profiles",
        ["Could not open temporary profile"] = "Не вдалося відкрити тимчасовий профіль",
        ["Could not save profile; existing file was kept"] = "Не вдалося зберегти профіль; старий файл збережено",
        ["Invalid AutoEQ catalog path"] = "Некоректний шлях у каталозі AutoEQ",
        ["AutoEQ profile"] = "Профіль AutoEQ",
        ["Downloading profile…"] = "Завантаження профілю…",
        ["Profile download failed: %s"] = "Помилка завантаження профілю: %s",
        ["Validating and saving profile…"] = "Перевірка та збереження профілю…",
        ["Profile not saved: %s"] = "Профіль не збережено: %s",
        ["Saved. Select it in Equalizer → Profiles"] = "Збережено. Виберіть його в Еквалайзер → Профілі",
        ["Profile download could not start: %s"] = "Не вдалося розпочати завантаження профілю: %s",
        ["Downloading AutoEQ profile…"] = "Завантаження профілю AutoEQ…",
        ["No models matched"] = "Моделі не знайдено",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d збігів",
        ["Enter at least 2 characters"] = "Введіть щонайменше 2 символи",
        ["Models %d–%d"] = "Моделі %d–%d",
        ["AutoEQ pages · %d matches"] = "Сторінки AutoEQ · %d збігів",
        ["Search AutoEQ models (%d)"] = "Пошук моделей AutoEQ (%d)",
        ["Search AutoEQ models"] = "Пошук моделей AutoEQ",
        ["Refresh catalog"] = "Оновити каталог",
        ["Cancel current task"] = "Скасувати поточне завдання",
        ["About and sources"] = "Про плагін і джерела",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "Пошук в AutoEQ",
        ["Using saved catalog: %d models"] = "Збережений каталог: %d моделей",
        ["Catalog updated: %d models"] = "Каталог оновлено: %d моделей",
        ["AutoEQ task cancelled"] = "Завдання AutoEQ скасовано",
        ["No AutoEQ task is running"] = "Немає активних завдань AutoEQ",
        ["AutoEQ sources"] = "Джерела AutoEQ",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "Каталог профілів і вимірювання AutoEQ надано проєктом jaakkopasanen/AutoEq.\n\nКаталог: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nІмпортовані профілі зберігаються в теці PEQ_Profiles; виберіть потрібний у меню Еквалайзер → Профілі.",
    },
    vi = {
        ["Catalog is empty or too large"] = "Danh mục trống hoặc quá lớn",
        ["Catalog has a line longer than %d bytes"] = "Danh mục có dòng dài hơn %d byte",
        ["Catalog has too many models"] = "Danh mục có quá nhiều mẫu",
        ["No model entries found in catalog"] = "Không tìm thấy mẫu nào trong danh mục",
        ["AutoEQ catalog"] = "Danh mục AutoEQ",
        ["Loading catalog…"] = "Đang tải danh mục…",
        ["Loading AutoEQ catalog…"] = "Đang tải danh mục AutoEQ…",
        ["error"] = "lỗi",
        ["Offline: using saved AutoEQ catalog"] = "Ngoại tuyến: đang dùng danh mục AutoEQ đã lưu",
        ["AutoEQ catalog failed: %s"] = "Lỗi danh mục AutoEQ: %s",
        ["AutoEQ catalog invalid: %s"] = "Danh mục AutoEQ không hợp lệ: %s",
        ["Catalog loaded; cache could not be saved"] = "Đã tải danh mục; không thể lưu bộ nhớ đệm",
        ["AutoEQ catalog ready"] = "Danh mục AutoEQ đã sẵn sàng",
        ["request could not start"] = "không thể bắt đầu yêu cầu",
        ["Model: %s"] = "Mẫu: %s",
        ["Measurement: %s"] = "Phép đo: %s",
        ["Replace existing profile: %s"] = "Thay thế hồ sơ hiện có: %s",
        ["Save as new copy"] = "Lưu thành bản sao mới",
        ["Download profile"] = "Tải hồ sơ",
        ["Profile is empty or too large"] = "Hồ sơ trống hoặc quá lớn",
        ["Invalid or duplicate preamp row"] = "Dòng preamp không hợp lệ hoặc bị trùng",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "Preamp nằm ngoài phạm vi của máy (-12 đến +12 dB)",
        ["Malformed or duplicate filter row"] = "Dòng bộ lọc sai định dạng hoặc bị trùng",
        ["Filter count or enable state is invalid"] = "Số thứ tự hoặc trạng thái bộ lọc không hợp lệ",
        ["Filter has a non-finite number"] = "Bộ lọc có giá trị số không hợp lệ",
        ["Filter frequency is outside 20–20000 Hz"] = "Tần số bộ lọc nằm ngoài 20–20000 Hz",
        ["Filter gain is outside -12 to +12 dB"] = "Độ lợi bộ lọc nằm ngoài -12 đến +12 dB",
        ["Filter Q is outside 0.1–10"] = "Hệ số Q nằm ngoài 0.1–10",
        ["Unsupported filter type: %s"] = "Loại bộ lọc không hỗ trợ: %s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "Độ dốc chuyển đổi nằm ngoài phạm vi (0.1–10)",
        ["Unrecognized profile row: %s"] = "Dòng hồ sơ không nhận dạng được: %s",
        ["Profile has no Preamp row"] = "Hồ sơ không có dòng Preamp",
        ["Profile has no filter rows"] = "Hồ sơ không có dòng bộ lọc nào",
        ["Filter numbering has a gap"] = "Thứ tự bộ lọc bị ngắt quãng",
        ["Profile now exists; choose Replace explicitly"] = "Hồ sơ đã tồn tại; hãy chọn Thay thế",
        ["Could not create PEQ_Profiles"] = "Không thể tạo thư mục PEQ_Profiles",
        ["Could not open temporary profile"] = "Không thể mở hồ sơ tạm thời",
        ["Could not save profile; existing file was kept"] = "Không thể lưu hồ sơ; đã giữ nguyên tệp cũ",
        ["Invalid AutoEQ catalog path"] = "Đường dẫn danh mục AutoEQ không hợp lệ",
        ["AutoEQ profile"] = "Hồ sơ AutoEQ",
        ["Downloading profile…"] = "Đang tải hồ sơ…",
        ["Profile download failed: %s"] = "Tải hồ sơ thất bại: %s",
        ["Validating and saving profile…"] = "Đang kiểm tra và lưu hồ sơ…",
        ["Profile not saved: %s"] = "Chưa lưu hồ sơ: %s",
        ["Saved. Select it in Equalizer → Profiles"] = "Đã lưu. Hãy chọn trong Bộ chỉnh âm → Hồ sơ",
        ["Profile download could not start: %s"] = "Không thể bắt đầu tải hồ sơ: %s",
        ["Downloading AutoEQ profile…"] = "Đang tải hồ sơ AutoEQ…",
        ["No models matched"] = "Không có mẫu phù hợp",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d kết quả",
        ["Enter at least 2 characters"] = "Nhập ít nhất 2 ký tự",
        ["Models %d–%d"] = "Mẫu %d–%d",
        ["AutoEQ pages · %d matches"] = "Trang AutoEQ · %d kết quả",
        ["Search AutoEQ models (%d)"] = "Tìm mẫu AutoEQ (%d)",
        ["Search AutoEQ models"] = "Tìm mẫu AutoEQ",
        ["Refresh catalog"] = "Làm mới danh mục",
        ["Cancel current task"] = "Hủy tác vụ hiện tại",
        ["About and sources"] = "Giới thiệu và nguồn",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "Tìm kiếm AutoEQ",
        ["Using saved catalog: %d models"] = "Đang dùng danh mục đã lưu: %d mẫu",
        ["Catalog updated: %d models"] = "Đã cập nhật danh mục: %d mẫu",
        ["AutoEQ task cancelled"] = "Đã hủy tác vụ AutoEQ",
        ["No AutoEQ task is running"] = "Không có tác vụ AutoEQ nào đang chạy",
        ["AutoEQ sources"] = "Nguồn AutoEQ",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "Danh mục hồ sơ và dữ liệu đo AutoEQ được cung cấp bởi jaakkopasanen/AutoEq.\n\nDanh mục: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nHồ sơ đã tải được lưu trong PEQ_Profiles; hãy chọn một hồ sơ trong Bộ chỉnh âm → Hồ sơ để sử dụng.",
    },
    zh_CN = {
        ["Catalog is empty or too large"] = "目录为空或过大",
        ["Catalog has a line longer than %d bytes"] = "目录中存在超过 %d 字节的行",
        ["Catalog has too many models"] = "目录中的型号过多",
        ["No model entries found in catalog"] = "目录中未找到任何型号",
        ["AutoEQ catalog"] = "AutoEQ 目录",
        ["Loading catalog…"] = "正在加载目录…",
        ["Loading AutoEQ catalog…"] = "正在加载 AutoEQ 目录…",
        ["error"] = "错误",
        ["Offline: using saved AutoEQ catalog"] = "离线：正在使用已保存的 AutoEQ 目录",
        ["AutoEQ catalog failed: %s"] = "AutoEQ 目录加载失败：%s",
        ["AutoEQ catalog invalid: %s"] = "AutoEQ 目录无效：%s",
        ["Catalog loaded; cache could not be saved"] = "目录已加载；无法保存缓存",
        ["AutoEQ catalog ready"] = "AutoEQ 目录已就绪",
        ["request could not start"] = "无法发起请求",
        ["Model: %s"] = "型号：%s",
        ["Measurement: %s"] = "测量来源：%s",
        ["Replace existing profile: %s"] = "替换现有配置文件：%s",
        ["Save as new copy"] = "另存为新副本",
        ["Download profile"] = "下载配置文件",
        ["Profile is empty or too large"] = "配置文件为空或过大",
        ["Invalid or duplicate preamp row"] = "无效或重复的前级行",
        ["Preamp is outside the player range (-12 to +12 dB)"] = "前级增益超出播放器范围（-12 至 +12 dB）",
        ["Malformed or duplicate filter row"] = "格式错误或重复的滤波器行",
        ["Filter count or enable state is invalid"] = "滤波器编号或启用状态无效",
        ["Filter has a non-finite number"] = "滤波器包含无效数值",
        ["Filter frequency is outside 20–20000 Hz"] = "滤波器频率超出 20–20000 Hz 范围",
        ["Filter gain is outside -12 to +12 dB"] = "滤波器增益超出 -12 至 +12 dB 范围",
        ["Filter Q is outside 0.1–10"] = "滤波器 Q 值超出 0.1–10 范围",
        ["Unsupported filter type: %s"] = "不支持的滤波器类型：%s",
        ["Converted shelf slope is outside the player range (0.1–10)"] = "转换后的搁架斜率超出范围（0.1–10）",
        ["Unrecognized profile row: %s"] = "无法识别的配置行：%s",
        ["Profile has no Preamp row"] = "配置文件缺少 Preamp 行",
        ["Profile has no filter rows"] = "配置文件没有滤波器行",
        ["Filter numbering has a gap"] = "滤波器编号不连续",
        ["Profile now exists; choose Replace explicitly"] = "配置文件已存在，请明确选择替换",
        ["Could not create PEQ_Profiles"] = "无法创建 PEQ_Profiles 文件夹",
        ["Could not open temporary profile"] = "无法打开临时配置文件",
        ["Could not save profile; existing file was kept"] = "无法保存配置文件，已保留原有文件",
        ["Invalid AutoEQ catalog path"] = "无效的 AutoEQ 目录路径",
        ["AutoEQ profile"] = "AutoEQ 配置文件",
        ["Downloading profile…"] = "正在下载配置文件…",
        ["Profile download failed: %s"] = "配置文件下载失败：%s",
        ["Validating and saving profile…"] = "正在验证并保存配置文件…",
        ["Profile not saved: %s"] = "配置文件未保存：%s",
        ["Saved. Select it in Equalizer → Profiles"] = "已保存。请在 均衡器 → 配置文件 中选择",
        ["Profile download could not start: %s"] = "无法启动配置文件下载：%s",
        ["Downloading AutoEQ profile…"] = "正在下载 AutoEQ 配置文件…",
        ["No models matched"] = "没有匹配的型号",
        ["AutoEQ %d/%d · %d matches"] = "AutoEQ %d/%d · %d 个匹配",
        ["Enter at least 2 characters"] = "请输入至少 2 个字符",
        ["Models %d–%d"] = "型号 %d–%d",
        ["AutoEQ pages · %d matches"] = "AutoEQ 分页 · %d 个匹配",
        ["Search AutoEQ models (%d)"] = "搜索 AutoEQ 型号（%d）",
        ["Search AutoEQ models"] = "搜索 AutoEQ 型号",
        ["Refresh catalog"] = "刷新目录",
        ["Cancel current task"] = "取消当前任务",
        ["About and sources"] = "关于与来源",
        ["AutoEQ"] = "AutoEQ",
        ["Search AutoEQ"] = "搜索 AutoEQ",
        ["Using saved catalog: %d models"] = "正在使用已保存目录：%d 个型号",
        ["Catalog updated: %d models"] = "目录已更新：%d 个型号",
        ["AutoEQ task cancelled"] = "AutoEQ 任务已取消",
        ["No AutoEQ task is running"] = "当前没有正在运行的 AutoEQ 任务",
        ["AutoEQ sources"] = "AutoEQ 来源",
        ["AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."] = "AutoEQ 配置文件目录与测量数据由 jaakkopasanen/AutoEq 提供。\n\n目录：https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\n导入的配置文件保存在 PEQ_Profiles 下；请在 均衡器 → 配置文件 中选择并加载。",
    },
}

local function tr(s)
    return plugin.tr(s, T)
end

-- AutoEQ profile browser for the recommended catalog maintained by jaakkopasanen/AutoEq.
-- Network work starts only after the user opens this screen. Catalog/result sizes,
-- cached bytes, request sizes, and displayed page sizes are all bounded.
local ROOT = plugin.sd_root()
local PLUGIN_DIR = ROOT .. "/.plugins"
local CACHE_PATH = PLUGIN_DIR .. "/.autoeq_catalog.md"
local CATALOG_URL = "https://raw.githubusercontent.com/jaakkopasanen/AutoEq/master/results/README.md"
local RAW_PREFIX = "https://raw.githubusercontent.com/jaakkopasanen/AutoEq/master/results/"
local MAX_CATALOG_BYTES = 1024 * 1024
local MAX_MODELS = 20000
local MAX_CATALOG_LINE_BYTES = 4096
local PAGE_SIZE = 40

local BAND_FREQS = { 31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000 }
local BAND_Q = { 0.2, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.2 }
local BAND_TYPE = { 1, 0, 0, 0, 0, 0, 0, 0, 0, 2 }

local catalog = nil
local catalog_error = nil
local task_handle = nil
local task_generation = 0
local task_progress = nil
local task_progress_generation = nil
local active_screen = nil
local download_profile

local function close_task_progress(generation)
    if task_progress and (not generation or task_progress_generation == generation) then
        plugin.close_progress(task_progress)
        task_progress = nil
        task_progress_generation = nil
    end
end

local function show_task_progress(generation, title, message)
    if not plugin.has_capability("ui.progress") then return end
    close_task_progress()
    task_progress = plugin.show_progress(title, message)
    task_progress_generation = task_progress and generation or nil
end

local function update_task_progress(generation, message)
    if not task_progress or task_progress_generation ~= generation then return end
    if not plugin.update_progress(task_progress, message) then
        -- A dismissed card remains dismissed until the user starts another task.
        task_progress = nil
        task_progress_generation = nil
    end
end

local function trim(s)
    return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function read_cache()
    local f = io.open(CACHE_PATH, "rb")
    if not f then return nil end
    local data = f:read(MAX_CATALOG_BYTES + 1)
    f:close()
    if not data or #data == 0 or #data > MAX_CATALOG_BYTES then return nil end
    return data
end

local function write_cache(data)
    if #data == 0 or #data > MAX_CATALOG_BYTES then return false end
    local f = io.open(CACHE_PATH .. ".tmp", "wb")
    if not f then return false end
    local ok = f:write(data)
    local closed = f:close()
    if not ok or not closed or not os.rename(CACHE_PATH .. ".tmp", CACHE_PATH) then
        os.remove(CACHE_PATH .. ".tmp")
        return false
    end
    return true
end

-- Validate each catalog href as a relative path before it can reach the URL builder.
local function valid_catalog_path(path)
    if type(path) ~= "string" or #path == 0 or #path > 1024 then return false end
    if path:find("\\", 1, true) or path:find("?", 1, true) or path:find("#", 1, true) then return false end
    if path:sub(1, 1) == "/" or path:match("^[%a][%w+%.%-]*:") then return false end
    local decoded = path:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)
    if decoded:find("\\", 1, true) or decoded:find("%c") then return false end
    local i = 1
    while true do
        local percent = path:find("%", i, true)
        if not percent then break end
        local escape = path:sub(percent + 1, percent + 2)
        if not escape:match("^%x%x$") then return false end
        local byte = tonumber(escape, 16)
        if not byte or byte == 47 or byte == 92 or byte < 32 or byte == 127 then return false end
        i = percent + 3
    end
    if decoded:sub(1, 1) == "/" or decoded:match("^[%a][%w+%.%-]*:") or decoded:find("//", 1, true) then return false end
    for segment in decoded:gmatch("[^/]+") do
        if segment == "." or segment == ".." or segment == "" then return false end
    end
    if path:find("//", 1, true) then return false end
    return true
end

local function encode_path(path)
    local out = {}
    local i = 1
    while i <= #path do
        local c = path:sub(i, i)
        if c == "/" or c:match("[A-Za-z0-9%-%._~]") then
            out[#out + 1] = c
        elseif c == "%" and path:sub(i + 1, i + 2):match("^%x%x$") then
            out[#out + 1] = path:sub(i, i + 2)
            i = i + 2
        else
            out[#out + 1] = string.format("%%%02X", string.byte(c))
        end
        i = i + 1
    end
    return table.concat(out)
end

local function parse_catalog(data)
    if type(data) ~= "string" or #data == 0 or #data > MAX_CATALOG_BYTES then
        return nil, tr("Catalog is empty or too large")
    end
    local models = {}
    for line in (data .. "\n"):gmatch("(.-)\n") do
        if #line > MAX_CATALOG_LINE_BYTES then
            return nil, string.format(tr("Catalog has a line longer than %d bytes"), MAX_CATALOG_LINE_BYTES)
        end
        -- Greedy href capture intentionally takes the final ')' so model names and
        -- nested path segments containing parentheses remain intact.
        local name, path = line:match("^%- %[(.-)%]%(%./(.+)%)%s*$")
        if name and valid_catalog_path(path) then
            if #models >= MAX_MODELS then return nil, tr("Catalog has too many models") end
            models[#models + 1] = { name = name, path = path }
        end
    end
    if #models == 0 then return nil, tr("No model entries found in catalog") end
    return models
end

local function ensure_catalog()
    if catalog then return true end
    local raw = read_cache()
    if raw then
        local parsed, err = parse_catalog(raw)
        if parsed then catalog = parsed; return true end
        catalog_error = err
    end
    return false
end

local function cancel_task()
    close_task_progress()
    task_generation = task_generation + 1
    if task_handle then plugin.cancel(task_handle); task_handle = nil end
end

local function begin_catalog_request(on_ready, screen_handle)
    cancel_task()
    local generation = task_generation
    show_task_progress(generation, tr("AutoEQ catalog"), tr("Loading catalog…"))
    if not task_progress then plugin.show_toast(tr("Loading AutoEQ catalog…")) end
    local handle, err = plugin.http_request({
        url = CATALOG_URL, method = "GET", verify_tls = true,
        max_response_bytes = MAX_CATALOG_BYTES,
        connect_timeout_ms = 10000, read_timeout_ms = 15000, total_timeout_ms = 30000,
        redirect_limit = 3,
    }, function(status, body, request_error)
        if generation ~= task_generation then return end
        task_handle = nil
        close_task_progress(generation)
        local screen_is_active = not screen_handle or plugin.is_list_showing(screen_handle)
        if request_error or not status or status < 200 or status >= 300 then
            catalog_error = request_error or ("HTTP " .. tostring(status or tr("error")))
            if ensure_catalog() then
                if screen_is_active then plugin.show_toast(tr("Offline: using saved AutoEQ catalog")) end
                if on_ready and screen_is_active then on_ready(true) end
            else
                if screen_is_active then plugin.show_toast(string.format(tr("AutoEQ catalog failed: %s"), tostring(catalog_error))) end
            end
            return
        end
        local parsed, parse_error = parse_catalog(body)
        if not parsed then
            catalog_error = parse_error
            if screen_is_active then plugin.show_toast(string.format(tr("AutoEQ catalog invalid: %s"), parse_error)) end
            return
        end
        catalog = parsed
        catalog_error = nil
        if screen_is_active then
            if not write_cache(body) then plugin.show_toast(tr("Catalog loaded; cache could not be saved"))
            else plugin.show_toast(tr("AutoEQ catalog ready")) end
        end
        if on_ready and screen_is_active then on_ready(false) end
    end)
    if not handle then
        close_task_progress(generation)
        catalog_error = err or tr("request could not start")
        local screen_is_active = not screen_handle or plugin.is_list_showing(screen_handle)
        if ensure_catalog() then
            if screen_is_active then plugin.show_toast(tr("Offline: using saved AutoEQ catalog")) end
            if on_ready and screen_is_active then on_ready(true) end
        elseif screen_is_active then plugin.show_toast(string.format(tr("AutoEQ catalog failed: %s"), tostring(catalog_error))) end
        return false
    end
    task_handle = handle
    return true
end

local function matching_models(query)
    local terms = {}
    for term in string.lower(query):gmatch("%S+") do terms[#terms + 1] = term end
    local matches = {}
    for _, model in ipairs(catalog or {}) do
        local candidate = string.lower(model.name)
        local all = true
        for _, term in ipairs(terms) do
            if not candidate:find(term, 1, true) then all = false; break end
        end
        if all then matches[#matches + 1] = model end
    end
    return matches
end

local function show_model_details(model)
    local parent = model.path:match("^(.*)/[^/]+$") or model.path
    local source = parent:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)
    -- The local profile path is deterministic and unique per catalog model.
    local safe = model.name:gsub("[/\\:*?\"<>|%c]", "_"):gsub("^%.*", ""):gsub("^%s+", ""):gsub("%s+$", "")
    safe = safe:sub(1, 140)
    -- If a byte limit split a UTF-8 sequence, drop its incomplete suffix.
    local last = #safe
    local first = last
    while first > 0 and safe:byte(first) >= 128 and safe:byte(first) < 192 do first = first - 1 end
    local lead = first > 0 and safe:byte(first) or 0
    local need = (lead >= 240 and 4) or (lead >= 224 and 3) or (lead >= 192 and 2) or 1
    if last - first + 1 < need then safe = safe:sub(1, first - 1) end
    if safe == "" then safe = "model" end
    local hash = plugin.md5(model.path):sub(1, 10)
    local base_name = "AutoEQ - " .. safe .. " - " .. hash .. ".peq"
    local target_path = ROOT .. "/PEQ_Profiles/" .. base_name
    local rows = {
        { label = string.format(tr("Model: %s"), model.name), wrap = true },
        { label = string.format(tr("Measurement: %s"), source), wrap = true },
    }
    local existing = io.open(target_path, "r")
    if existing then
        existing:close()
        rows[#rows + 1] = { label = string.format(tr("Replace existing profile: %s"), base_name), wrap = true }
        local alt = target_path:gsub("%.peq$", " - copy.peq")
        local n = 2
        while true do
            local probe = io.open(alt, "r")
            if not probe then break end
            probe:close()
            alt = target_path:gsub("%.peq$", " - copy " .. n .. ".peq")
            n = n + 1
            if n > 99 then alt = nil; break end
        end
        if alt then rows[#rows + 1] = { label = tr("Save as new copy") } end
        local replace_index = 3
        local copy_index = alt and 4 or nil
        local handle
        handle = plugin.show_list(model.name, rows, function(index)
            if index == replace_index then download_profile(model, target_path, handle, true)
            elseif copy_index and index == copy_index then download_profile(model, alt, handle, false) end
        end)
        active_screen = handle
    else
        rows[#rows + 1] = { label = tr("Download profile") }
        local handle
        handle = plugin.show_list(model.name, rows, function(index)
            if index == 3 then download_profile(model, target_path, handle, false) end
        end)
        active_screen = handle
    end
end

-- Strictly validates all source rows and converts AutoEQ shelf-Q into the
-- native peq.c shelf slope S because the native shelf formula uses RBJ's
-- slope expression even though the settings screen calls the field Q.
local function parse_parametric(text)
    if type(text) ~= "string" or #text == 0 or #text > 65536 then return nil, tr("Profile is empty or too large") end
    local preamp, filters = nil, {}
    for raw_line in (text .. "\n"):gmatch("(.-)\n") do
        local line = trim(raw_line:gsub("\r$", ""))
        if line:match("^[#;]") or line == "" then
            -- comments and blank lines are permitted
        elseif line:lower():match("^preamp%s*:") then
            local value = line:match("^[Pp][Rr][Ee][Aa][Mm][Pp]%s*:%s*([%+%-]?[%d%.]+[eE]?[%+%-]?%d*)%s*[dD][bB]%s*$")
            value = value and tonumber(value)
            if preamp ~= nil or not value or value ~= value or value == math.huge or value == -math.huge then return nil, tr("Invalid or duplicate preamp row") end
            if value < -12 or value > 12 then return nil, tr("Preamp is outside the player range (-12 to +12 dB)") end
            preamp = value
        elseif line:lower():match("^filter") then
            local n, enabled, kind, freq_s, gain_s, q_s = line:match("^[Ff]ilter%s+(%d+)%s*:%s*(%u+)%s+(%u+)%s+[Ff][Cc]%s+([%+%-]?[%d%.]+[eE]?[%+%-]?%d*)%s*[Hh][Zz]%s+[Gg]ain%s+([%+%-]?[%d%.]+[eE]?[%+%-]?%d*)%s*[dD][bB]%s+[Qq]%s+([%+%-]?[%d%.]+[eE]?[%+%-]?%d*)%s*$")
            n, freq_s, gain_s, q_s = tonumber(n), freq_s, gain_s, q_s
            local freq, gain, q = tonumber(freq_s), tonumber(gain_s), tonumber(q_s)
            if not n or not enabled or not kind or filters[n] then return nil, tr("Malformed or duplicate filter row") end
            if n < 1 or n > 10 or (enabled ~= "ON" and enabled ~= "OFF") then return nil, tr("Filter count or enable state is invalid") end
            if not freq or not gain or not q or freq ~= freq or gain ~= gain or q ~= q or freq == math.huge or gain == math.huge or q == math.huge or freq == -math.huge or gain == -math.huge or q == -math.huge then return nil, tr("Filter has a non-finite number") end
            if freq < 20 or freq > 20000 then return nil, tr("Filter frequency is outside 20–20000 Hz") end
            if gain < -12 or gain > 12 then return nil, tr("Filter gain is outside -12 to +12 dB") end
            if q <= 0 or q < 0.1 or q > 10 then return nil, tr("Filter Q is outside 0.1–10") end
            local band_type
            if kind == "PK" then band_type = 0
            elseif kind == "LSC" or kind == "LS" then band_type = 1
            elseif kind == "HSC" or kind == "HS" then band_type = 2
            else return nil, string.format(tr("Unsupported filter type: %s"), kind) end
            local native_q = q
            if band_type == 1 or band_type == 2 then
                local A = 10 ^ (gain / 40)
                local slope = 1 / (1 + (1 / (q * q) - 2) / (A + 1 / A))
                if slope ~= slope or slope == math.huge or slope < 0.1 or slope > 10 then return nil, tr("Converted shelf slope is outside the player range (0.1–10)") end
                native_q = slope
            end
            filters[n] = { enabled = enabled == "ON", kind = band_type, freq = freq, gain = gain, q = native_q }
        else
            return nil, string.format(tr("Unrecognized profile row: %s"), line:sub(1, 72))
        end
    end
    if preamp == nil then return nil, tr("Profile has no Preamp row") end
    local highest = 0
    for n in pairs(filters) do if n > highest then highest = n end end
    if highest == 0 then return nil, tr("Profile has no filter rows") end
    for n = 1, highest do if not filters[n] then return nil, tr("Filter numbering has a gap") end end
    return { preamp = preamp, filters = filters }
end

local function write_profile(model, destination, text, allow_replace)
    local parsed, err = parse_parametric(text)
    if not parsed then return false, err end
    local current = io.open(destination, "r")
    if current then
        current:close()
        if not allow_replace then return false, tr("Profile now exists; choose Replace explicitly") end
    end
    local dir_ok = plugin.mkdir(ROOT .. "/PEQ_Profiles")
    if not dir_ok then return false, tr("Could not create PEQ_Profiles") end
    local temp = destination .. ".tmp"
    local f = io.open(temp, "w")
    if not f then return false, tr("Could not open temporary profile") end
    local ok = f:write("bypass=0\npreamp=" .. string.format("%.6f", parsed.preamp) .. "\n")
    for i = 1, 10 do
        local spec = parsed.filters[i]
        local freq, gain, q, kind, enabled
        if spec then
            freq, gain, q, kind, enabled = spec.freq, spec.gain, spec.q, spec.kind, spec.enabled and 1 or 0
        else
            freq, gain, q, kind, enabled = BAND_FREQS[i], 0, BAND_Q[i], BAND_TYPE[i], 0
        end
        if ok then
            ok = f:write(string.format("band%d_freq=%.6f\nband%d_gain=%.6f\nband%d_q=%.6f\nband%d_type=%d\nband%d_enabled=%d\n",
                i - 1, freq, i - 1, gain, i - 1, q, i - 1, kind, i - 1, enabled))
        end
    end
    local closed = f:close()
    if not ok or not closed or not os.rename(temp, destination) then
        os.remove(temp)
        return false, tr("Could not save profile; existing file was kept")
    end
    return true
end

download_profile = function(model, destination, detail_handle, allow_replace)
    cancel_task()
    local generation = task_generation
    local path = model.path
    if not valid_catalog_path(path) then plugin.show_toast(tr("Invalid AutoEQ catalog path")); return end
    show_task_progress(generation, tr("AutoEQ profile"), tr("Downloading profile…"))
    -- Profile files are in each linked model directory and share its final path segment.
    local url = RAW_PREFIX .. encode_path(path .. "/" .. path:match("([^/]+)$") .. "%20ParametricEQ.txt")
    local handle, err = plugin.http_request({
        url = url, method = "GET", verify_tls = true,
        max_response_bytes = 65536,
        connect_timeout_ms = 10000, read_timeout_ms = 15000, total_timeout_ms = 30000,
        redirect_limit = 3,
    }, function(status, body, request_error)
        if generation ~= task_generation then return end
        task_handle = nil
        if request_error or not status or status < 200 or status >= 300 then
            close_task_progress(generation)
            if not detail_handle or plugin.is_list_showing(detail_handle) then plugin.show_toast(string.format(tr("Profile download failed: %s"), tostring(request_error or status))) end
            return
        end
        update_task_progress(generation, tr("Validating and saving profile…"))
        local ok, save_error = write_profile(model, destination, body, allow_replace)
        if not ok then
            close_task_progress(generation)
            if not detail_handle or plugin.is_list_showing(detail_handle) then plugin.show_toast(string.format(tr("Profile not saved: %s"), tostring(save_error))) end
            return
        end
        close_task_progress(generation)
        if not detail_handle or plugin.is_list_showing(detail_handle) then plugin.show_toast(tr("Saved. Select it in Equalizer → Profiles")) end
    end)
    if not handle then
        close_task_progress(generation)
        plugin.show_toast(string.format(tr("Profile download could not start: %s"), tostring(err)))
        return
    end
    task_handle = handle
    if not task_progress then plugin.show_toast(tr("Downloading AutoEQ profile…")) end
end

local function show_results(query, matches, page)
    local total = #matches
    local pages = math.max(1, math.ceil(total / PAGE_SIZE))
    page = math.max(1, math.min(page, pages))
    local rows, first = {}, (page - 1) * PAGE_SIZE + 1
    for i = first, math.min(total, first + PAGE_SIZE - 1) do
        local model = matches[i]
        rows[#rows + 1] = { label = model.name, wrap = true }
    end
    if #rows == 0 then rows[1] = tr("No models matched") end
    local handle
    handle = plugin.show_list(string.format(tr("AutoEQ %d/%d · %d matches"), page, pages, total), rows, function(index)
        if index <= math.min(total - first + 1, PAGE_SIZE) then show_model_details(matches[first + index - 1]) end
    end)
    active_screen = handle
end

local function run_search(query)
    query = trim(query or "")
    if #query < 2 then plugin.show_toast(tr("Enter at least 2 characters")); return end
    if not ensure_catalog() then
        local prior_screen = active_screen
        begin_catalog_request(function()
            if not prior_screen or plugin.is_list_showing(prior_screen) then
                run_search(query)
            end
        end, prior_screen)
        return
    end
    local matches = matching_models(query)
    if #matches <= PAGE_SIZE then show_results(query, matches, 1); return end
    local page_count = math.ceil(#matches / PAGE_SIZE)
    local rows = {}
    for p = 1, page_count do
        local lo = (p - 1) * PAGE_SIZE + 1
        local hi = math.min(#matches, lo + PAGE_SIZE - 1)
        rows[#rows + 1] = { label = string.format(tr("Models %d–%d"), lo, hi), wrap = true }
    end
    local handle
    handle = plugin.show_list(string.format(tr("AutoEQ pages · %d matches"), #matches), rows, function(index)
        show_results(query, matches, index)
    end)
    active_screen = handle
end

local function show_home()
    local cached = ensure_catalog()
    local items = {
        { label = cached and string.format(tr("Search AutoEQ models (%d)"), #catalog) or tr("Search AutoEQ models") },
        { label = tr("Refresh catalog") },
        { label = tr("Cancel current task") },
        { label = tr("About and sources") },
    }
    local handle
    handle = plugin.show_list(tr("AutoEQ"), items, function(index)
        if index == 1 then
            plugin.show_text_input(tr("Search AutoEQ"), nil, false, function(query) run_search(query) end)
        elseif index == 2 then
            begin_catalog_request(function(offline)
                plugin.show_toast(string.format(offline and tr("Using saved catalog: %d models") or tr("Catalog updated: %d models"), #catalog))
            end, handle)
        elseif index == 3 then
            if task_handle then cancel_task(); plugin.show_toast(tr("AutoEQ task cancelled"))
            else plugin.show_toast(tr("No AutoEQ task is running")) end
        elseif index == 4 then
            plugin.show_text_view(tr("AutoEQ sources"), tr("AutoEQ profile catalog and measurements are provided by jaakkopasanen/AutoEq.\n\nCatalog: https://github.com/jaakkopasanen/AutoEq/blob/master/results/README.md\n\nImported profiles are saved under PEQ_Profiles; choose one in Equalizer → Profiles to load it."))
        end
    end)
    active_screen = handle
end

plugin.register_list_item("music_audio", tr("AutoEQ"), show_home, { group = "profiles" })
