plugin.define({ id = "example.mseb", name = "MSEB", version = "1.7.0", api_min = 19 })

local T = {
    de = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "MSEB aus. Crossfeed wurde auf den gespeicherten Wert zurückgesetzt.",
        ["Turn off Loudness Boost first"] = "Schalte zuerst den Loudness-Boost aus",
        ["Could not change MSEB. Try again."] = "MSEB konnte nicht geändert werden. Bitte erneut versuchen.",
        ["Damaged preset %d"] = "Beschädigtes Preset %d",
        ["Preset changed; reopen the preset list"] = "Preset geändert; Preset-Liste erneut öffnen",
        ["Text input is unavailable"] = "Texteingabe nicht verfügbar",
        ["Enter a short preset name without line breaks"] = "Kurzen Preset-Namen ohne Zeilenumbrüche eingeben",
        ["Could not open name entry"] = "Namenseingabe konnte nicht geöffnet werden",
        ["Create new preset"] = "Neues Preset erstellen",
        ["Overwrite: %s"] = "Überschreiben: %s",
        ["Save named preset"] = "Benanntes Preset speichern",
        ["New preset name"] = "Neuer Preset-Name",
        ["A preset with that name already exists"] = "Ein Preset mit diesem Namen existiert bereits",
        ["Preset limit reached (%d)"] = "Preset-Limit erreicht (%d)",
        ["Preset saved"] = "Preset gespeichert",
        ["Could not save preset. Try again."] = "Preset konnte nicht gespeichert werden. Bitte erneut versuchen.",
        ["Overwrite preset?"] = "Preset überschreiben?",
        ["Cancel"] = "Abbrechen",
        ["Overwrite %s"] = "%s überschreiben",
        ["Preset overwritten"] = "Preset überschrieben",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "Ältere MSEB-Regler werden nicht unterstützt; Preset nicht geladen",
        ["Preset loaded"] = "Preset geladen",
        ["Could not load preset. Try again."] = "Preset konnte nicht geladen werden. Bitte erneut versuchen.",
        ["Rename preset"] = "Preset umbenennen",
        ["Preset renamed"] = "Preset umbenannt",
        ["Could not rename preset. Try again."] = "Preset konnte nicht umbenannt werden. Bitte erneut versuchen.",
        ["Delete preset?"] = "Preset löschen?",
        ["Delete %s"] = "%s löschen",
        ["Preset deleted"] = "Preset gelöscht",
        ["Could not delete preset. Try again."] = "Preset konnte nicht gelöscht werden. Bitte erneut versuchen.",
        ["Delete damaged preset?"] = "Beschädigtes Preset löschen?",
        ["Delete file %d"] = "Datei %d löschen",
        ["Damaged preset deleted"] = "Beschädigtes Preset gelöscht",
        ["Load"] = "Laden",
        ["Overwrite"] = "Überschreiben",
        ["Rename"] = "Umbenennen",
        ["Delete"] = "Löschen",
        ["%s (delete to free slot)"] = "%s (löschen, um Platz freizugeben)",
        ["No named presets saved"] = "Keine benannten Presets gespeichert",
        ["Named presets"] = "Benannte Presets",
        ["Adjustment Range"] = "Einstellbereich",
        ["Could not save range. Try again."] = "Bereich konnte nicht gespeichert werden. Bitte erneut versuchen.",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "Bereich gespeichert. Bestehende Werte beibehalten; Bereich erweitern, um größere Werte zu bearbeiten.",
        ["Range set to ±%d"] = "Bereich auf ±%d gesetzt",
        ["Slot is empty"] = "Speicherplatz ist leer",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "Ältere MSEB-Regler werden nicht unterstützt; Speicherplatz nicht geladen",
        ["Slot loaded"] = "Speicherplatz geladen",
        ["Could not load slot. Try again."] = "Speicherplatz konnte nicht geladen werden. Bitte erneut versuchen.",
        ["Could not apply changes. Try again."] = "Änderungen konnten nicht übernommen werden. Bitte erneut versuchen.",
        ["Some values exceed this range. Widen it to edit them."] = "Einige Werte überschreiten diesen Bereich. Erweitere ihn zum Bearbeiten.",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "Gespeicherte Werte und Klang sind unverändert; erweitere den Bereich, um Werte außerhalb zu bearbeiten.",
        ["%s: %d (outside ±%d)"] = "%s: %d (außerhalb ±%d)",
        ["Stock MSEB width changes the channel mix."] = "Standard-MSEB-Breite ändert die Kanalmischung.",
        ["Stereo width changes the channel mix."] = "Stereobreite ändert die Kanalmischung.",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "Breite ist von 0.00 (Mono) bis 2.00 (breit) normiert, 1.00 ist neutral. Mono-Eingang bleibt unverändert.",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "Negativ verengt, positiv verbreitert mit abgesenkter Mitte. Mono-Eingang bleibt unverändert.",
        ["Stereo Width"] = "Stereobreite",
        ["Sound Stage"] = "Klangbühne",
        ["Overall Temperature"] = "Gesamttemperatur",
        ["Bass Extension"] = "Basserweiterung",
        ["Bass Texture"] = "Basstextur",
        ["Note Thickness"] = "Notendicke",
        ["Vocals"] = "Gesang",
        ["Female Overtones"] = "Weibliche Obertöne",
        ["Sibilance LF"] = "Zischlaute LF",
        ["Sibilance HF"] = "Zischlaute HF",
        ["Impulse Response"] = "Impulsverhalten",
        ["Air"] = "Luftigkeit",
        ["Reset to Defaults"] = "Auf Standard zurücksetzen",
        ["Named Presets"] = "Benannte Presets",
        ["Save Named Preset"] = "Benanntes Preset speichern",
        ["Save to Slot"] = "Auf Speicherplatz speichern",
        ["Load from Slot"] = "Von Speicherplatz laden",
        ["MSEB reset"] = "MSEB zurückgesetzt",
        ["Could not reset MSEB. Try again."] = "MSEB konnte nicht zurückgesetzt werden. Bitte erneut versuchen.",
        ["Slot 1"] = "Speicherplatz 1",
        ["Slot 2"] = "Speicherplatz 2",
        ["Slot 3"] = "Speicherplatz 3",
        ["Saved to slot"] = "Auf Speicherplatz gespeichert",
        ["Could not save slot. Try again."] = "Speicherplatz konnte nicht gespeichert werden. Bitte erneut versuchen.",
        ["MSEB Options"] = "MSEB-Optionen",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "Dieses gespeicherte Layout wird nicht unterstützt. Der Wechsel ersetzt Instrumentenpräsenz, Bass-Biss und Höhen-Biss durch die Standardregler.",
        ["Stock MSEB controls are already selected"] = "Standard-MSEB-Regler sind bereits ausgewählt",
        ["Could not switch controls. Try again."] = "Regler konnten nicht gewechselt werden. Bitte erneut versuchen.",
        ["Stock MSEB controls selected"] = "Standard-MSEB-Regler ausgewählt",
        ["Switch to stock MSEB"] = "Zu Standard-MSEB wechseln",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "Wechsel ersetzt Instrumentenpräsenz, Bass-Biss und Höhen-Biss",
        ["Kept existing MSEB settings"] = "Bestehende MSEB-Einstellungen beibehalten",
        ["Enabled"] = "Aktiviert",
        ["Options"] = "Optionen",
        ["Latest Compas firmware with stock MSEB is required"] = "Aktuelle Compás-Firmware mit Standard-MSEB erforderlich",
    },
    es = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "MSEB desactivado. El crossfeed volvió a su valor guardado.",
        ["Turn off Loudness Boost first"] = "Desactiva primero el realce de sonoridad",
        ["Could not change MSEB. Try again."] = "No se pudo cambiar MSEB. Inténtalo de nuevo.",
        ["Damaged preset %d"] = "Ajuste predefinido dañado %d",
        ["Preset changed; reopen the preset list"] = "El preajuste cambió; vuelve a abrir la lista",
        ["Text input is unavailable"] = "La entrada de texto no está disponible",
        ["Enter a short preset name without line breaks"] = "Escribe un nombre corto sin saltos de línea",
        ["Could not open name entry"] = "No se pudo abrir el campo de nombre",
        ["Create new preset"] = "Crear nuevo preajuste",
        ["Overwrite: %s"] = "Sobrescribir: %s",
        ["Save named preset"] = "Guardar preajuste con nombre",
        ["New preset name"] = "Nombre del nuevo preajuste",
        ["A preset with that name already exists"] = "Ya existe un preajuste con ese nombre",
        ["Preset limit reached (%d)"] = "Límite de preajustes alcanzado (%d)",
        ["Preset saved"] = "Preajuste guardado",
        ["Could not save preset. Try again."] = "No se pudo guardar el preajuste. Inténtalo de nuevo.",
        ["Overwrite preset?"] = "¿Sobrescribir preajuste?",
        ["Cancel"] = "Cancelar",
        ["Overwrite %s"] = "Sobrescribir %s",
        ["Preset overwritten"] = "Preajuste sobrescrito",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "Los controles antiguos de MSEB no son compatibles; no se cargó el preajuste",
        ["Preset loaded"] = "Preajuste cargado",
        ["Could not load preset. Try again."] = "No se pudo cargar el preajuste. Inténtalo de nuevo.",
        ["Rename preset"] = "Renombrar preajuste",
        ["Preset renamed"] = "Preajuste renombrado",
        ["Could not rename preset. Try again."] = "No se pudo renombrar el preajuste. Inténtalo de nuevo.",
        ["Delete preset?"] = "¿Eliminar preajuste?",
        ["Delete %s"] = "Eliminar %s",
        ["Preset deleted"] = "Preajuste eliminado",
        ["Could not delete preset. Try again."] = "No se pudo eliminar el preajuste. Inténtalo de nuevo.",
        ["Delete damaged preset?"] = "¿Eliminar preajuste dañado?",
        ["Delete file %d"] = "Eliminar archivo %d",
        ["Damaged preset deleted"] = "Preajuste dañado eliminado",
        ["Load"] = "Cargar",
        ["Overwrite"] = "Sobrescribir",
        ["Rename"] = "Renombrar",
        ["Delete"] = "Eliminar",
        ["%s (delete to free slot)"] = "%s (eliminar para liberar espacio)",
        ["No named presets saved"] = "No hay preajustes guardados",
        ["Named presets"] = "Preajustes con nombre",
        ["Adjustment Range"] = "Rango de ajuste",
        ["Could not save range. Try again."] = "No se pudo guardar el rango. Inténtalo de nuevo.",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "Rango guardado. Se mantienen los valores actuales; amplía el rango para editar los que lo superan.",
        ["Range set to ±%d"] = "Rango fijado en ±%d",
        ["Slot is empty"] = "La ranura está vacía",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "Los controles antiguos de MSEB no son compatibles; no se cargó la ranura",
        ["Slot loaded"] = "Ranura cargada",
        ["Could not load slot. Try again."] = "No se pudo cargar la ranura. Inténtalo de nuevo.",
        ["Could not apply changes. Try again."] = "No se pudieron aplicar los cambios. Inténtalo de nuevo.",
        ["Some values exceed this range. Widen it to edit them."] = "Algunos valores superan este rango. Amplíalo para editarlos.",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "Los valores guardados y el sonido no cambian; amplía el rango para editar valores fuera de él.",
        ["%s: %d (outside ±%d)"] = "%s: %d (fuera de ±%d)",
        ["Stock MSEB width changes the channel mix."] = "La amplitud MSEB cambia la mezcla de canales.",
        ["Stereo width changes the channel mix."] = "La amplitud estéreo cambia la mezcla de canales.",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "La amplitud va de 0.00 (mono) a 2.00 (amplio), con 1.00 neutro. La entrada mono no cambia.",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "Negativo estrecha, positivo amplía reduciendo el centro. La entrada mono no cambia.",
        ["Stereo Width"] = "Amplitud estéreo",
        ["Sound Stage"] = "Escena sonora",
        ["Overall Temperature"] = "Temperatura general",
        ["Bass Extension"] = "Extensión de graves",
        ["Bass Texture"] = "Textura de graves",
        ["Note Thickness"] = "Grosor de notas",
        ["Vocals"] = "Voces",
        ["Female Overtones"] = "Armónicos femeninos",
        ["Sibilance LF"] = "Sibilancia graves",
        ["Sibilance HF"] = "Sibilancia agudos",
        ["Impulse Response"] = "Respuesta al impulso",
        ["Air"] = "Aire",
        ["Reset to Defaults"] = "Restablecer valores",
        ["Named Presets"] = "Preajustes con nombre",
        ["Save Named Preset"] = "Guardar preajuste con nombre",
        ["Save to Slot"] = "Guardar en ranura",
        ["Load from Slot"] = "Cargar de ranura",
        ["MSEB reset"] = "MSEB restablecido",
        ["Could not reset MSEB. Try again."] = "No se pudo restablecer MSEB. Inténtalo de nuevo.",
        ["Slot 1"] = "Ranura 1",
        ["Slot 2"] = "Ranura 2",
        ["Slot 3"] = "Ranura 3",
        ["Saved to slot"] = "Guardado en ranura",
        ["Could not save slot. Try again."] = "No se pudo guardar en la ranura. Inténtalo de nuevo.",
        ["MSEB Options"] = "Opciones de MSEB",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "Este diseño guardado no es compatible. Al cambiar se reemplazan Presencia instrumental, Ataque de graves y Ataque de agudos por los controles estándar.",
        ["Stock MSEB controls are already selected"] = "Los controles estándar de MSEB ya están seleccionados",
        ["Could not switch controls. Try again."] = "No se pudieron cambiar los controles. Inténtalo de nuevo.",
        ["Stock MSEB controls selected"] = "Controles estándar de MSEB seleccionados",
        ["Switch to stock MSEB"] = "Cambiar a MSEB estándar",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "Al cambiar se reemplazan Presencia instrumental, Ataque de graves y Ataque de agudos",
        ["Kept existing MSEB settings"] = "Se mantuvieron los ajustes actuales de MSEB",
        ["Enabled"] = "Activado",
        ["Options"] = "Opciones",
        ["Latest Compas firmware with stock MSEB is required"] = "Se requiere el último firmware de Compás con MSEB nativo",
    },
    fi = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "MSEB pois. Crossfeed palautettiin tallennettuun arvoon.",
        ["Turn off Loudness Boost first"] = "Kytke ensin äänekkyyden korostus pois",
        ["Could not change MSEB. Try again."] = "MSEB-tilaa ei voitu muuttaa. Yritä uudelleen.",
        ["Damaged preset %d"] = "Vioittunut esiasetus %d",
        ["Preset changed; reopen the preset list"] = "Esiasetus muuttui; avaa lista uudelleen",
        ["Text input is unavailable"] = "Tekstinsyöttö ei ole käytettävissä",
        ["Enter a short preset name without line breaks"] = "Anna lyhyt nimi ilman rivinvaihtoja",
        ["Could not open name entry"] = "Nimikenttää ei voitu avata",
        ["Create new preset"] = "Luo uusi esiasetus",
        ["Overwrite: %s"] = "Korvaa: %s",
        ["Save named preset"] = "Tallenna nimetty esiasetus",
        ["New preset name"] = "Uuden esiasetuksen nimi",
        ["A preset with that name already exists"] = "Samanniminen esiasetus on jo olemassa",
        ["Preset limit reached (%d)"] = "Esiasetusraja saavutettu (%d)",
        ["Preset saved"] = "Esiasetus tallennettu",
        ["Could not save preset. Try again."] = "Esiasetusta ei voitu tallentaa. Yritä uudelleen.",
        ["Overwrite preset?"] = "Korvataanko esiasetus?",
        ["Cancel"] = "Peruuta",
        ["Overwrite %s"] = "Korvaa %s",
        ["Preset overwritten"] = "Esiasetus korvattu",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "Vanhoja MSEB-säätimiä ei tueta; esiasetusta ei ladattu",
        ["Preset loaded"] = "Esiasetus ladattu",
        ["Could not load preset. Try again."] = "Esiasetusta ei voitu ladata. Yritä uudelleen.",
        ["Rename preset"] = "Nimeä esiasetus uudelleen",
        ["Preset renamed"] = "Esiasetus nimetty uudelleen",
        ["Could not rename preset. Try again."] = "Esiasetusta ei voitu nimetä uudelleen. Yritä uudelleen.",
        ["Delete preset?"] = "Poistetaanko esiasetus?",
        ["Delete %s"] = "Poista %s",
        ["Preset deleted"] = "Esiasetus poistettu",
        ["Could not delete preset. Try again."] = "Esiasetusta ei voitu poistaa. Yritä uudelleen.",
        ["Delete damaged preset?"] = "Poistetaanko vioittunut esiasetus?",
        ["Delete file %d"] = "Poista tiedosto %d",
        ["Damaged preset deleted"] = "Vioittunut esiasetus poistettu",
        ["Load"] = "Lataa",
        ["Overwrite"] = "Korvaa",
        ["Rename"] = "Nimeä uudelleen",
        ["Delete"] = "Poista",
        ["%s (delete to free slot)"] = "%s (poista vapauttaaksesi paikan)",
        ["No named presets saved"] = "Ei tallennettuja esiasetuksia",
        ["Named presets"] = "Nimetyt esiasetukset",
        ["Adjustment Range"] = "Säätöalue",
        ["Could not save range. Try again."] = "Aluetta ei voitu tallentaa. Yritä uudelleen.",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "Alue tallennettu. Nykyiset arvot säilytettiin; laajenna aluetta muokataksesi sen ylittäviä arvoja.",
        ["Range set to ±%d"] = "Säätöalueeksi asetettu ±%d",
        ["Slot is empty"] = "Muistipaikka on tyhjä",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "Vanhoja MSEB-säätimiä ei tueta; muistipaikkaa ei ladattu",
        ["Slot loaded"] = "Muistipaikka ladattu",
        ["Could not load slot. Try again."] = "Muistipaikkaa ei voitu ladata. Yritä uudelleen.",
        ["Could not apply changes. Try again."] = "Muutoksia ei voitu ottaa käyttöön. Yritä uudelleen.",
        ["Some values exceed this range. Widen it to edit them."] = "Jotkin arvot ylittävät tämän alueen. Laajenna aluetta muokataksesi niitä.",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "Tallennetut arvot ja ääni eivät muuttuneet; laajenna aluetta muokataksesi sen ulkopuolisia arvoja.",
        ["%s: %d (outside ±%d)"] = "%s: %d (±%d ulkopuolella)",
        ["Stock MSEB width changes the channel mix."] = "MSEB-leveys muuttaa kanavamiksausta.",
        ["Stereo width changes the channel mix."] = "Stereoleveys muuttaa kanavamiksausta.",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "Leveys on 0.00 (mono) – 2.00 (leveä), 1.00 on neutraali. Monotulo ei muutu.",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "Negatiivinen kaventaa, positiivinen leventää laskien keskikanavaa. Monotulo ei muutu.",
        ["Stereo Width"] = "Stereoleveys",
        ["Sound Stage"] = "Äänikuva",
        ["Overall Temperature"] = "Yleislämpötila",
        ["Bass Extension"] = "Basson ulottuvuus",
        ["Bass Texture"] = "Basson rakenne",
        ["Note Thickness"] = "Sävelten paksuus",
        ["Vocals"] = "Laulu",
        ["Female Overtones"] = "Naisäänen yläsävelet",
        ["Sibilance LF"] = "Sibilanssi matala",
        ["Sibilance HF"] = "Sibilanssi korkea",
        ["Impulse Response"] = "Impulssivaste",
        ["Air"] = "Ilmavuus",
        ["Reset to Defaults"] = "Palauta oletukset",
        ["Named Presets"] = "Nimetyt esiasetukset",
        ["Save Named Preset"] = "Tallenna nimetty esiasetus",
        ["Save to Slot"] = "Tallenna muistipaikkaan",
        ["Load from Slot"] = "Lataa muistipaikasta",
        ["MSEB reset"] = "MSEB nollattu",
        ["Could not reset MSEB. Try again."] = "MSEB:tä ei voitu nollata. Yritä uudelleen.",
        ["Slot 1"] = "Paikka 1",
        ["Slot 2"] = "Paikka 2",
        ["Slot 3"] = "Paikka 3",
        ["Saved to slot"] = "Tallennettu muistipaikkaan",
        ["Could not save slot. Try again."] = "Muistipaikkaan tallennus epäonnistui. Yritä uudelleen.",
        ["MSEB Options"] = "MSEB-valinnat",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "Tallennettua asettelua ei tueta. Vaihto korvaa Instrumenttien läsnäolon, Basson purevuuden ja Diskantin purevuuden vakiosäätimillä.",
        ["Stock MSEB controls are already selected"] = "MSEB-vakiosäätimet on jo valittu",
        ["Could not switch controls. Try again."] = "Säätimiä ei voitu vaihtaa. Yritä uudelleen.",
        ["Stock MSEB controls selected"] = "MSEB-vakiosäätimet valittu",
        ["Switch to stock MSEB"] = "Vaihda vakio-MSEB:hen",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "Vaihto korvaa Instrumenttien läsnäolon, Basson purevuuden ja Diskantin purevuuden",
        ["Kept existing MSEB settings"] = "Nykyiset MSEB-asetukset säilytettiin",
        ["Enabled"] = "Käytössä",
        ["Options"] = "Valinnat",
        ["Latest Compas firmware with stock MSEB is required"] = "Vaaditaan uusin Compás-ohjelmisto vakio-MSEB-tuella",
    },
    fr = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "MSEB désactivé. Le crossfeed a été réinitialisé à sa valeur enregistrée.",
        ["Turn off Loudness Boost first"] = "Désactivez d'abord le boost de sonie",
        ["Could not change MSEB. Try again."] = "Impossible de modifier MSEB. Réessayez.",
        ["Damaged preset %d"] = "Préréglage endommagé %d",
        ["Preset changed; reopen the preset list"] = "Préréglage modifié ; rouvrez la liste",
        ["Text input is unavailable"] = "Saisie de texte indisponible",
        ["Enter a short preset name without line breaks"] = "Entrez un nom court sans retour à la ligne",
        ["Could not open name entry"] = "Impossible d'ouvrir la saisie du nom",
        ["Create new preset"] = "Créer un nouveau préréglage",
        ["Overwrite: %s"] = "Écraser : %s",
        ["Save named preset"] = "Enregistrer un préréglage nommé",
        ["New preset name"] = "Nom du nouveau préréglage",
        ["A preset with that name already exists"] = "Un préréglage portant ce nom existe déjà",
        ["Preset limit reached (%d)"] = "Limite de préréglages atteinte (%d)",
        ["Preset saved"] = "Préréglage enregistré",
        ["Could not save preset. Try again."] = "Impossible d'enregistrer le préréglage. Réessayez.",
        ["Overwrite preset?"] = "Écraser le préréglage ?",
        ["Cancel"] = "Annuler",
        ["Overwrite %s"] = "Écraser %s",
        ["Preset overwritten"] = "Préréglage écrasé",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "Anciens contrôles MSEB non pris en charge ; préréglage non chargé",
        ["Preset loaded"] = "Préréglage chargé",
        ["Could not load preset. Try again."] = "Impossible de charger le préréglage. Réessayez.",
        ["Rename preset"] = "Renommer le préréglage",
        ["Preset renamed"] = "Préréglage renommé",
        ["Could not rename preset. Try again."] = "Impossible de renommer le préréglage. Réessayez.",
        ["Delete preset?"] = "Supprimer le préréglage ?",
        ["Delete %s"] = "Supprimer %s",
        ["Preset deleted"] = "Préréglage supprimé",
        ["Could not delete preset. Try again."] = "Impossible de supprimer le préréglage. Réessayez.",
        ["Delete damaged preset?"] = "Supprimer le préréglage endommagé ?",
        ["Delete file %d"] = "Supprimer le fichier %d",
        ["Damaged preset deleted"] = "Préréglage endommagé supprimé",
        ["Load"] = "Charger",
        ["Overwrite"] = "Écraser",
        ["Rename"] = "Renommer",
        ["Delete"] = "Supprimer",
        ["%s (delete to free slot)"] = "%s (supprimer pour libérer l'emplacement)",
        ["No named presets saved"] = "Aucun préréglage nommé enregistré",
        ["Named presets"] = "Préréglages nommés",
        ["Adjustment Range"] = "Plage de réglage",
        ["Could not save range. Try again."] = "Impossible d'enregistrer la plage. Réessayez.",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "Plage enregistrée. Valeurs actuelles conservées ; élargissez la plage pour modifier celles qui la dépassent.",
        ["Range set to ±%d"] = "Plage réglée sur ±%d",
        ["Slot is empty"] = "L'emplacement est vide",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "Anciens contrôles MSEB non pris en charge ; emplacement non chargé",
        ["Slot loaded"] = "Emplacement chargé",
        ["Could not load slot. Try again."] = "Impossible de charger l'emplacement. Réessayez.",
        ["Could not apply changes. Try again."] = "Impossible d'appliquer les modifications. Réessayez.",
        ["Some values exceed this range. Widen it to edit them."] = "Certaines valeurs dépassent cette plage. Élargissez-la pour les modifier.",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "Les valeurs enregistrées et le son sont inchangés ; élargissez la plage pour modifier les valeurs hors limites.",
        ["%s: %d (outside ±%d)"] = "%s : %d (hors ±%d)",
        ["Stock MSEB width changes the channel mix."] = "La largeur MSEB modifie le mixage des canaux.",
        ["Stereo width changes the channel mix."] = "La largeur stéréo modifie le mixage des canaux.",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "La largeur est normalisée de 0.00 (mono) à 2.00 (large), 1.00 étant neutre. L'entrée mono reste inchangée.",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "Négatif rétrécit, positif élargit en réduisant le centre. L'entrée mono reste inchangée.",
        ["Stereo Width"] = "Largeur stéréo",
        ["Sound Stage"] = "Scène sonore",
        ["Overall Temperature"] = "Température globale",
        ["Bass Extension"] = "Extension des graves",
        ["Bass Texture"] = "Texture des graves",
        ["Note Thickness"] = "Épaisseur des notes",
        ["Vocals"] = "Voix",
        ["Female Overtones"] = "Harmoniques féminines",
        ["Sibilance LF"] = "Sibilance BF",
        ["Sibilance HF"] = "Sibilance HF",
        ["Impulse Response"] = "Réponse impulsionnelle",
        ["Air"] = "Air",
        ["Reset to Defaults"] = "Réinitialiser",
        ["Named Presets"] = "Préréglages nommés",
        ["Save Named Preset"] = "Enregistrer un préréglage nommé",
        ["Save to Slot"] = "Enregistrer dans un emplacement",
        ["Load from Slot"] = "Charger depuis un emplacement",
        ["MSEB reset"] = "MSEB réinitialisé",
        ["Could not reset MSEB. Try again."] = "Impossible de réinitialiser MSEB. Réessayez.",
        ["Slot 1"] = "Emplacement 1",
        ["Slot 2"] = "Emplacement 2",
        ["Slot 3"] = "Emplacement 3",
        ["Saved to slot"] = "Enregistré dans l'emplacement",
        ["Could not save slot. Try again."] = "Impossible d'enregistrer l'emplacement. Réessayez.",
        ["MSEB Options"] = "Options MSEB",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "Cette disposition enregistrée n'est pas prise en charge. Le changement remplace Présence des instruments, Mordant des graves et Mordant des aigus par les contrôles standard.",
        ["Stock MSEB controls are already selected"] = "Les contrôles MSEB standard sont déjà sélectionnés",
        ["Could not switch controls. Try again."] = "Impossible de changer les contrôles. Réessayez.",
        ["Stock MSEB controls selected"] = "Contrôles MSEB standard sélectionnés",
        ["Switch to stock MSEB"] = "Passer au MSEB standard",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "Le changement remplace Présence des instruments, Mordant des graves et Mordant des aigus",
        ["Kept existing MSEB settings"] = "Réglages MSEB existants conservés",
        ["Enabled"] = "Activé",
        ["Options"] = "Options",
        ["Latest Compas firmware with stock MSEB is required"] = "Dernier firmware Compás avec MSEB natif requis",
    },
    it = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "MSEB disattivato. Il crossfeed è stato ripristinato al valore salvato.",
        ["Turn off Loudness Boost first"] = "Disattiva prima il Loudness Boost",
        ["Could not change MSEB. Try again."] = "Impossibile modificare MSEB. Riprova.",
        ["Damaged preset %d"] = "Preset danneggiato %d",
        ["Preset changed; reopen the preset list"] = "Preset modificato; riapri l'elenco dei preset",
        ["Text input is unavailable"] = "Inserimento testo non disponibile",
        ["Enter a short preset name without line breaks"] = "Inserisci un nome breve senza interruzioni di riga",
        ["Could not open name entry"] = "Impossibile aprire il campo del nome",
        ["Create new preset"] = "Crea nuovo preset",
        ["Overwrite: %s"] = "Sovrascrivi: %s",
        ["Save named preset"] = "Salva preset con nome",
        ["New preset name"] = "Nome nuovo preset",
        ["A preset with that name already exists"] = "Esiste già un preset con questo nome",
        ["Preset limit reached (%d)"] = "Limite preset raggiunto (%d)",
        ["Preset saved"] = "Preset salvato",
        ["Could not save preset. Try again."] = "Impossibile salvare il preset. Riprova.",
        ["Overwrite preset?"] = "Sovrascrivere il preset?",
        ["Cancel"] = "Annulla",
        ["Overwrite %s"] = "Sovrascrivi %s",
        ["Preset overwritten"] = "Preset sovrascritto",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "I vecchi controlli MSEB non sono supportati; preset non caricato",
        ["Preset loaded"] = "Preset caricato",
        ["Could not load preset. Try again."] = "Impossibile caricare il preset. Riprova.",
        ["Rename preset"] = "Rinomina preset",
        ["Preset renamed"] = "Preset rinominato",
        ["Could not rename preset. Try again."] = "Impossibile rinominare il preset. Riprova.",
        ["Delete preset?"] = "Eliminare il preset?",
        ["Delete %s"] = "Elimina %s",
        ["Preset deleted"] = "Preset eliminato",
        ["Could not delete preset. Try again."] = "Impossibile eliminare il preset. Riprova.",
        ["Delete damaged preset?"] = "Eliminare il preset danneggiato?",
        ["Delete file %d"] = "Elimina file %d",
        ["Damaged preset deleted"] = "Preset danneggiato eliminato",
        ["Load"] = "Carica",
        ["Overwrite"] = "Sovrascrivi",
        ["Rename"] = "Rinomina",
        ["Delete"] = "Elimina",
        ["%s (delete to free slot)"] = "%s (elimina per liberare spazio)",
        ["No named presets saved"] = "Nessun preset salvato",
        ["Named presets"] = "Preset con nome",
        ["Adjustment Range"] = "Intervallo di regolazione",
        ["Could not save range. Try again."] = "Impossibile salvare l'intervallo. Riprova.",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "Intervallo salvato. Valori esistenti mantenuti; amplia l'intervallo per modificare i valori oltre il limite.",
        ["Range set to ±%d"] = "Intervallo impostato su ±%d",
        ["Slot is empty"] = "Lo slot è vuoto",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "I vecchi controlli MSEB non sono supportati; slot non caricato",
        ["Slot loaded"] = "Slot caricato",
        ["Could not load slot. Try again."] = "Impossibile caricare lo slot. Riprova.",
        ["Could not apply changes. Try again."] = "Impossibile applicare le modifiche. Riprova.",
        ["Some values exceed this range. Widen it to edit them."] = "Alcuni valori superano questo intervallo. Amplialo per modificarli.",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "I valori salvati e il suono sono invariati; amplia l'intervallo per modificare i valori fuori limite.",
        ["%s: %d (outside ±%d)"] = "%s: %d (fuori da ±%d)",
        ["Stock MSEB width changes the channel mix."] = "L'ampiezza MSEB modifica il mix dei canali.",
        ["Stereo width changes the channel mix."] = "L'ampiezza stereo modifica il mix dei canali.",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "L'ampiezza è normalizzata da 0.00 (mono) a 2.00 (ampio), con 1.00 neutro. L'ingresso mono resta invariato.",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "Negativo restringe, positivo amplia riducendo il centro. L'ingresso mono resta invariato.",
        ["Stereo Width"] = "Ampiezza stereo",
        ["Sound Stage"] = "Scena sonora",
        ["Overall Temperature"] = "Temperatura generale",
        ["Bass Extension"] = "Estensione bassi",
        ["Bass Texture"] = "Trama dei bassi",
        ["Note Thickness"] = "Spessore delle note",
        ["Vocals"] = "Voci",
        ["Female Overtones"] = "Armonici femminili",
        ["Sibilance LF"] = "Sibilanti BF",
        ["Sibilance HF"] = "Sibilanti AF",
        ["Impulse Response"] = "Risposta all'impulso",
        ["Air"] = "Aria",
        ["Reset to Defaults"] = "Ripristina predefiniti",
        ["Named Presets"] = "Preset con nome",
        ["Save Named Preset"] = "Salva preset con nome",
        ["Save to Slot"] = "Salva nello slot",
        ["Load from Slot"] = "Carica dallo slot",
        ["MSEB reset"] = "MSEB ripristinato",
        ["Could not reset MSEB. Try again."] = "Impossibile ripristinare MSEB. Riprova.",
        ["Slot 1"] = "Slot 1",
        ["Slot 2"] = "Slot 2",
        ["Slot 3"] = "Slot 3",
        ["Saved to slot"] = "Salvato nello slot",
        ["Could not save slot. Try again."] = "Impossibile salvare nello slot. Riprova.",
        ["MSEB Options"] = "Opzioni MSEB",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "Questo layout salvato non è supportato. Il passaggio sostituisce Presenza strumenti, Attacco bassi e Attacco alti con i controlli standard.",
        ["Stock MSEB controls are already selected"] = "I controlli MSEB standard sono già selezionati",
        ["Could not switch controls. Try again."] = "Impossibile cambiare i controlli. Riprova.",
        ["Stock MSEB controls selected"] = "Controlli MSEB standard selezionati",
        ["Switch to stock MSEB"] = "Passa a MSEB standard",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "Il passaggio sostituisce Presenza strumenti, Attacco bassi e Attacco alti",
        ["Kept existing MSEB settings"] = "Impostazioni MSEB esistenti mantenute",
        ["Enabled"] = "Attivato",
        ["Options"] = "Opzioni",
        ["Latest Compas firmware with stock MSEB is required"] = "È richiesto l'ultimo firmware Compás con MSEB nativo",
    },
    ja = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "MSEB オフ。クロスフィードは保存値に戻りました。",
        ["Turn off Loudness Boost first"] = "先にラウドネスブーストをオフにしてください",
        ["Could not change MSEB. Try again."] = "MSEB を変更できませんでした。再試行してください。",
        ["Damaged preset %d"] = "破損したプリセット %d",
        ["Preset changed; reopen the preset list"] = "プリセットが変更されました。一覧を開き直してください",
        ["Text input is unavailable"] = "テキスト入力は利用できません",
        ["Enter a short preset name without line breaks"] = "改行なしの短いプリセット名を入力してください",
        ["Could not open name entry"] = "名前入力を開けませんでした",
        ["Create new preset"] = "新規プリセットを作成",
        ["Overwrite: %s"] = "上書き: %s",
        ["Save named preset"] = "名前付きプリセットを保存",
        ["New preset name"] = "新しいプリセット名",
        ["A preset with that name already exists"] = "その名前のプリセットは既に存在します",
        ["Preset limit reached (%d)"] = "プリセットの上限に達しました (%d)",
        ["Preset saved"] = "プリセットを保存しました",
        ["Could not save preset. Try again."] = "プリセットを保存できませんでした。再試行してください。",
        ["Overwrite preset?"] = "プリセットを上書きしますか？",
        ["Cancel"] = "キャンセル",
        ["Overwrite %s"] = "%s を上書き",
        ["Preset overwritten"] = "プリセットを上書きしました",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "旧式の MSEB 調整は非対応のため、プリセットを読み込めませんでした",
        ["Preset loaded"] = "プリセットを読み込みました",
        ["Could not load preset. Try again."] = "プリセットを読み込めませんでした。再試行してください。",
        ["Rename preset"] = "プリセット名を変更",
        ["Preset renamed"] = "プリセット名を変更しました",
        ["Could not rename preset. Try again."] = "プリセット名を変更できませんでした。再試行してください。",
        ["Delete preset?"] = "プリセットを削除しますか？",
        ["Delete %s"] = "%s を削除",
        ["Preset deleted"] = "プリセットを削除しました",
        ["Could not delete preset. Try again."] = "プリセットを削除できませんでした。再試行してください。",
        ["Delete damaged preset?"] = "破損したプリセットを削除しますか？",
        ["Delete file %d"] = "ファイル %d を削除",
        ["Damaged preset deleted"] = "破損したプリセットを削除しました",
        ["Load"] = "読み込む",
        ["Overwrite"] = "上書き",
        ["Rename"] = "名前変更",
        ["Delete"] = "削除",
        ["%s (delete to free slot)"] = "%s (削除して空きを作る)",
        ["No named presets saved"] = "保存されたプリセットはありません",
        ["Named presets"] = "名前付きプリセット",
        ["Adjustment Range"] = "調整範囲",
        ["Could not save range. Try again."] = "範囲を保存できませんでした。再試行してください。",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "範囲を保存しました。既存の値は維持されます。範囲外の値を編集するには範囲を広げてください。",
        ["Range set to ±%d"] = "範囲を ±%d に設定しました",
        ["Slot is empty"] = "スロットは空です",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "旧式の MSEB 調整は非対応のため、スロットを読み込めませんでした",
        ["Slot loaded"] = "スロットを読み込みました",
        ["Could not load slot. Try again."] = "スロットを読み込めませんでした。再試行してください。",
        ["Could not apply changes. Try again."] = "変更を適用できませんでした。再試行してください。",
        ["Some values exceed this range. Widen it to edit them."] = "一部の値がこの範囲を超えています。編集するには範囲を広げてください。",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "保存値と音質は維持されます。範囲外の値を編集するには範囲を広げてください。",
        ["%s: %d (outside ±%d)"] = "%s: %d (±%d の範囲外)",
        ["Stock MSEB width changes the channel mix."] = "標準 MSEB の幅調整はチャンネルミックスを変更します。",
        ["Stereo width changes the channel mix."] = "ステレオ幅はチャンネルミックスを変更します。",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "幅は 0.00 (モノラル) から 2.00 (ワイド) で、1.00 が標準です。モノラル入力は変化しません。",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "マイナスで狭まり、プラスで中央を抑えて広がります。モノラル入力は変化しません。",
        ["Stereo Width"] = "ステレオ幅",
        ["Sound Stage"] = "サウンドステージ",
        ["Overall Temperature"] = "全体の温度感",
        ["Bass Extension"] = "低域の伸び",
        ["Bass Texture"] = "低域の質感",
        ["Note Thickness"] = "音の厚み",
        ["Vocals"] = "ボーカル",
        ["Female Overtones"] = "女性ボーカル倍音",
        ["Sibilance LF"] = "歯擦音 (低域)",
        ["Sibilance HF"] = "歯擦音 (高域)",
        ["Impulse Response"] = "インパルス応答",
        ["Air"] = "空気感",
        ["Reset to Defaults"] = "初期値に戻す",
        ["Named Presets"] = "名前付きプリセット",
        ["Save Named Preset"] = "名前付きプリセットを保存",
        ["Save to Slot"] = "スロットに保存",
        ["Load from Slot"] = "スロットから読み込む",
        ["MSEB reset"] = "MSEB をリセットしました",
        ["Could not reset MSEB. Try again."] = "MSEB をリセットできませんでした。再試行してください。",
        ["Slot 1"] = "スロット 1",
        ["Slot 2"] = "スロット 2",
        ["Slot 3"] = "スロット 3",
        ["Saved to slot"] = "スロットに保存しました",
        ["Could not save slot. Try again."] = "スロットに保存できませんでした。再試行してください。",
        ["MSEB Options"] = "MSEB オプション",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "保存されたレイアウトは非対応です。切り替えると楽器の定位・低域のアタック・高域のアタックが標準項目に置き換わります。",
        ["Stock MSEB controls are already selected"] = "標準 MSEB 項目は既に選択されています",
        ["Could not switch controls. Try again."] = "項目を切り替えられませんでした。再試行してください。",
        ["Stock MSEB controls selected"] = "標準 MSEB 項目を選択しました",
        ["Switch to stock MSEB"] = "標準 MSEB に切り替え",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "切り替えると楽器の定位・低域のアタック・高域のアタックが置き換わります",
        ["Kept existing MSEB settings"] = "現在の MSEB 設定を維持しました",
        ["Enabled"] = "有効",
        ["Options"] = "オプション",
        ["Latest Compas firmware with stock MSEB is required"] = "標準 MSEB 対応の最新 Compás ファームウェアが必要です",
    },
    nl = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "MSEB uit. Crossfeed is teruggezet naar de opgeslagen waarde.",
        ["Turn off Loudness Boost first"] = "Schakel eerst Loudness Boost uit",
        ["Could not change MSEB. Try again."] = "Kon MSEB niet wijzigen. Probeer het opnieuw.",
        ["Damaged preset %d"] = "Beschadigde preset %d",
        ["Preset changed; reopen the preset list"] = "Preset gewijzigd; heropen de presetlijst",
        ["Text input is unavailable"] = "Tekstinvoer is niet beschikbaar",
        ["Enter a short preset name without line breaks"] = "Voer een korte presetnaam in zonder regeleinden",
        ["Could not open name entry"] = "Kon naaminvoer niet openen",
        ["Create new preset"] = "Nieuwe preset maken",
        ["Overwrite: %s"] = "Overschrijven: %s",
        ["Save named preset"] = "Preset met naam opslaan",
        ["New preset name"] = "Nieuwe presetnaam",
        ["A preset with that name already exists"] = "Er bestaat al een preset met die naam",
        ["Preset limit reached (%d)"] = "Presetlimiet bereikt (%d)",
        ["Preset saved"] = "Preset opgeslagen",
        ["Could not save preset. Try again."] = "Kon preset niet opslaan. Probeer het opnieuw.",
        ["Overwrite preset?"] = "Preset overschrijven?",
        ["Cancel"] = "Annuleren",
        ["Overwrite %s"] = "%s overschrijven",
        ["Preset overwritten"] = "Preset overschreven",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "Oudere MSEB-regelaars worden niet ondersteund; preset niet geladen",
        ["Preset loaded"] = "Preset geladen",
        ["Could not load preset. Try again."] = "Kon preset niet laden. Probeer het opnieuw.",
        ["Rename preset"] = "Preset hernoemen",
        ["Preset renamed"] = "Preset hernoemd",
        ["Could not rename preset. Try again."] = "Kon preset niet hernoemen. Probeer het opnieuw.",
        ["Delete preset?"] = "Preset verwijderen?",
        ["Delete %s"] = "%s verwijderen",
        ["Preset deleted"] = "Preset verwijderd",
        ["Could not delete preset. Try again."] = "Kon preset niet verwijderen. Probeer het opnieuw.",
        ["Delete damaged preset?"] = "Beschadigde preset verwijderen?",
        ["Delete file %d"] = "Bestand %d verwijderen",
        ["Damaged preset deleted"] = "Beschadigde preset verwijderd",
        ["Load"] = "Laden",
        ["Overwrite"] = "Overschrijven",
        ["Rename"] = "Hernoemen",
        ["Delete"] = "Verwijderen",
        ["%s (delete to free slot)"] = "%s (verwijderen om plek vrij te maken)",
        ["No named presets saved"] = "Geen presets met naam opgeslagen",
        ["Named presets"] = "Presets met naam",
        ["Adjustment Range"] = "Instelbereik",
        ["Could not save range. Try again."] = "Kon bereik niet opslaan. Probeer het opnieuw.",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "Bereik opgeslagen. Bestaande waarden behouden; vergroot het bereik om waarden erbuiten te bewerken.",
        ["Range set to ±%d"] = "Bereik ingesteld op ±%d",
        ["Slot is empty"] = "Geheugenplek is leeg",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "Oudere MSEB-regelaars worden niet ondersteund; geheugenplek niet geladen",
        ["Slot loaded"] = "Geheugenplek geladen",
        ["Could not load slot. Try again."] = "Kon geheugenplek niet laden. Probeer het opnieuw.",
        ["Could not apply changes. Try again."] = "Kon wijzigingen niet toepassen. Probeer het opnieuw.",
        ["Some values exceed this range. Widen it to edit them."] = "Sommige waarden overschrijden dit bereik. Vergroot het om ze te bewerken.",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "Opgeslagen waarden en geluid zijn ongewijzigd; vergroot het bereik om waarden erbuiten te bewerken.",
        ["%s: %d (outside ±%d)"] = "%s: %d (buiten ±%d)",
        ["Stock MSEB width changes the channel mix."] = "Standaard MSEB-breedte verandert de kanaalmix.",
        ["Stereo width changes the channel mix."] = "Stereobreedte verandert de kanaalmix.",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "Breedte is genormaliseerd van 0.00 (mono) tot 2.00 (breed), met 1.00 neutraal. Mono-invoer blijft ongewijzigd.",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "Negatief versmalt, positief verbreedt met lager middenniveau. Mono-invoer blijft ongewijzigd.",
        ["Stereo Width"] = "Stereobreedte",
        ["Sound Stage"] = "Geluidsbeeld",
        ["Overall Temperature"] = "Algemene temperatuur",
        ["Bass Extension"] = "Basbereik",
        ["Bass Texture"] = "Bastextuur",
        ["Note Thickness"] = "Nootdikte",
        ["Vocals"] = "Zang",
        ["Female Overtones"] = "Vrouwelijke boventonen",
        ["Sibilance LF"] = "Sisklanken LF",
        ["Sibilance HF"] = "Sisklanken HF",
        ["Impulse Response"] = "Impulsrespons",
        ["Air"] = "Luchtigheid",
        ["Reset to Defaults"] = "Standaardwaarden herstellen",
        ["Named Presets"] = "Presets met naam",
        ["Save Named Preset"] = "Preset met naam opslaan",
        ["Save to Slot"] = "Opslaan op plek",
        ["Load from Slot"] = "Laden van plek",
        ["MSEB reset"] = "MSEB hersteld",
        ["Could not reset MSEB. Try again."] = "Kon MSEB niet herstellen. Probeer het opnieuw.",
        ["Slot 1"] = "Plek 1",
        ["Slot 2"] = "Plek 2",
        ["Slot 3"] = "Plek 3",
        ["Saved to slot"] = "Opgeslagen op plek",
        ["Could not save slot. Try again."] = "Kon plek niet opslaan. Probeer het opnieuw.",
        ["MSEB Options"] = "MSEB-opties",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "Deze opgeslagen indeling wordt niet ondersteund. Omschakelen vervangt Instrumentaanwezigheid, Bas-bite en Treble-bite door de standaardregelaars.",
        ["Stock MSEB controls are already selected"] = "Standaard MSEB-regelaars zijn al geselecteerd",
        ["Could not switch controls. Try again."] = "Kon regelaars niet omschakelen. Probeer het opnieuw.",
        ["Stock MSEB controls selected"] = "Standaard MSEB-regelaars geselecteerd",
        ["Switch to stock MSEB"] = "Omschakelen naar standaard MSEB",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "Omschakelen vervangt Instrumentaanwezigheid, Bas-bite en Treble-bite",
        ["Kept existing MSEB settings"] = "Bestaande MSEB-instellingen behouden",
        ["Enabled"] = "Ingeschakeld",
        ["Options"] = "Opties",
        ["Latest Compas firmware with stock MSEB is required"] = "Nieuwste Compás-firmware met standaard MSEB is vereist",
    },
    pt = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "MSEB desligado. O crossfeed voltou ao valor salvo.",
        ["Turn off Loudness Boost first"] = "Desative primeiro o Reforço de sonoridade",
        ["Could not change MSEB. Try again."] = "Não foi possível alterar o MSEB. Tente novamente.",
        ["Damaged preset %d"] = "Predefinição corrompida %d",
        ["Preset changed; reopen the preset list"] = "A predefinição mudou; reabra a lista",
        ["Text input is unavailable"] = "Entrada de texto indisponível",
        ["Enter a short preset name without line breaks"] = "Digite um nome curto sem quebras de linha",
        ["Could not open name entry"] = "Não foi possível abrir o campo de nome",
        ["Create new preset"] = "Criar nova predefinição",
        ["Overwrite: %s"] = "Substituir: %s",
        ["Save named preset"] = "Salvar predefinição com nome",
        ["New preset name"] = "Nome da nova predefinição",
        ["A preset with that name already exists"] = "Já existe uma predefinição com esse nome",
        ["Preset limit reached (%d)"] = "Limite de predefinições atingido (%d)",
        ["Preset saved"] = "Predefinição salva",
        ["Could not save preset. Try again."] = "Não foi possível salvar a predefinição. Tente novamente.",
        ["Overwrite preset?"] = "Substituir predefinição?",
        ["Cancel"] = "Cancelar",
        ["Overwrite %s"] = "Substituir %s",
        ["Preset overwritten"] = "Predefinição substituída",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "Controles antigos do MSEB não são suportados; predefinição não carregada",
        ["Preset loaded"] = "Predefinição carregada",
        ["Could not load preset. Try again."] = "Não foi possível carregar a predefinição. Tente novamente.",
        ["Rename preset"] = "Renomear predefinição",
        ["Preset renamed"] = "Predefinição renomeada",
        ["Could not rename preset. Try again."] = "Não foi possível renomear a predefinição. Tente novamente.",
        ["Delete preset?"] = "Excluir predefinição?",
        ["Delete %s"] = "Excluir %s",
        ["Preset deleted"] = "Predefinição excluída",
        ["Could not delete preset. Try again."] = "Não foi possível excluir a predefinição. Tente novamente.",
        ["Delete damaged preset?"] = "Excluir predefinição corrompida?",
        ["Delete file %d"] = "Excluir arquivo %d",
        ["Damaged preset deleted"] = "Predefinição corrompida excluída",
        ["Load"] = "Carregar",
        ["Overwrite"] = "Substituir",
        ["Rename"] = "Renomear",
        ["Delete"] = "Excluir",
        ["%s (delete to free slot)"] = "%s (excluir para liberar espaço)",
        ["No named presets saved"] = "Nenhuma predefinição salva",
        ["Named presets"] = "Predefinições com nome",
        ["Adjustment Range"] = "Faixa de ajuste",
        ["Could not save range. Try again."] = "Não foi possível salvar a faixa. Tente novamente.",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "Faixa salva. Valores atuais mantidos; amplie a faixa para editar valores além dela.",
        ["Range set to ±%d"] = "Faixa definida para ±%d",
        ["Slot is empty"] = "A posição está vazia",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "Controles antigos do MSEB não são suportados; posição não carregada",
        ["Slot loaded"] = "Posição carregada",
        ["Could not load slot. Try again."] = "Não foi possível carregar a posição. Tente novamente.",
        ["Could not apply changes. Try again."] = "Não foi possível aplicar as alterações. Tente novamente.",
        ["Some values exceed this range. Widen it to edit them."] = "Alguns valores excedem esta faixa. Amplie-a para editá-los.",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "Os valores salvos e o som não mudaram; amplie a faixa para editar valores fora dela.",
        ["%s: %d (outside ±%d)"] = "%s: %d (fora de ±%d)",
        ["Stock MSEB width changes the channel mix."] = "A largura do MSEB altera a mistura de canais.",
        ["Stereo width changes the channel mix."] = "A largura estéreo altera a mistura de canais.",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "A largura vai de 0.00 (mono) a 2.00 (amplo), com 1.00 neutro. A entrada mono não muda.",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "Negativo estreita, positivo amplia reduzindo o centro. A entrada mono não muda.",
        ["Stereo Width"] = "Largura estéreo",
        ["Sound Stage"] = "Palco sonoro",
        ["Overall Temperature"] = "Temperatura geral",
        ["Bass Extension"] = "Extensão de graves",
        ["Bass Texture"] = "Textura de graves",
        ["Note Thickness"] = "Espessura das notas",
        ["Vocals"] = "Vozes",
        ["Female Overtones"] = "Harmônicos femininos",
        ["Sibilance LF"] = "Sibilância BF",
        ["Sibilance HF"] = "Sibilância AF",
        ["Impulse Response"] = "Resposta ao impulso",
        ["Air"] = "Ar",
        ["Reset to Defaults"] = "Restaurar padrões",
        ["Named Presets"] = "Predefinições com nome",
        ["Save Named Preset"] = "Salvar predefinição com nome",
        ["Save to Slot"] = "Salvar na posição",
        ["Load from Slot"] = "Carregar da posição",
        ["MSEB reset"] = "MSEB restaurado",
        ["Could not reset MSEB. Try again."] = "Não foi possível restaurar o MSEB. Tente novamente.",
        ["Slot 1"] = "Posição 1",
        ["Slot 2"] = "Posição 2",
        ["Slot 3"] = "Posição 3",
        ["Saved to slot"] = "Salvo na posição",
        ["Could not save slot. Try again."] = "Não foi possível salvar na posição. Tente novamente.",
        ["MSEB Options"] = "Opções do MSEB",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "Este layout salvo não é suportado. A troca substitui Presença de instrumentos, Ataque de graves e Ataque de agudos pelos controles padrão.",
        ["Stock MSEB controls are already selected"] = "Os controles padrão do MSEB já estão selecionados",
        ["Could not switch controls. Try again."] = "Não foi possível trocar os controles. Tente novamente.",
        ["Stock MSEB controls selected"] = "Controles padrão do MSEB selecionados",
        ["Switch to stock MSEB"] = "Mudar para MSEB padrão",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "A troca substitui Presença de instrumentos, Ataque de graves e Ataque de agudos",
        ["Kept existing MSEB settings"] = "Configurações atuais do MSEB mantidas",
        ["Enabled"] = "Ativado",
        ["Options"] = "Opções",
        ["Latest Compas firmware with stock MSEB is required"] = "É necessário o firmware Compás mais recente com MSEB nativo",
    },
    ru = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "MSEB выкл. Кроссфид сброшен к сохранённому значению.",
        ["Turn off Loudness Boost first"] = "Сначала отключите усиление громкости",
        ["Could not change MSEB. Try again."] = "Не удалось изменить MSEB. Повторите попытку.",
        ["Damaged preset %d"] = "Повреждённый пресет %d",
        ["Preset changed; reopen the preset list"] = "Пресет изменён; откройте список заново",
        ["Text input is unavailable"] = "Ввод текста недоступен",
        ["Enter a short preset name without line breaks"] = "Введите короткое имя без переносов строк",
        ["Could not open name entry"] = "Не удалось открыть поле ввода имени",
        ["Create new preset"] = "Создать новый пресет",
        ["Overwrite: %s"] = "Перезаписать: %s",
        ["Save named preset"] = "Сохранить именной пресет",
        ["New preset name"] = "Имя нового пресета",
        ["A preset with that name already exists"] = "Пресет с таким именем уже существует",
        ["Preset limit reached (%d)"] = "Достигнут лимит пресетов (%d)",
        ["Preset saved"] = "Пресет сохранён",
        ["Could not save preset. Try again."] = "Не удалось сохранить пресет. Повторите попытку.",
        ["Overwrite preset?"] = "Перезаписать пресет?",
        ["Cancel"] = "Отмена",
        ["Overwrite %s"] = "Перезаписать %s",
        ["Preset overwritten"] = "Пресет перезаписан",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "Старые регуляторы MSEB не поддерживаются; пресет не загружен",
        ["Preset loaded"] = "Пресет загружен",
        ["Could not load preset. Try again."] = "Не удалось загрузить пресет. Повторите попытку.",
        ["Rename preset"] = "Переименовать пресет",
        ["Preset renamed"] = "Пресет переименован",
        ["Could not rename preset. Try again."] = "Не удалось переименовать пресет. Повторите попытку.",
        ["Delete preset?"] = "Удалить пресет?",
        ["Delete %s"] = "Удалить %s",
        ["Preset deleted"] = "Пресет удалён",
        ["Could not delete preset. Try again."] = "Не удалось удалить пресет. Повторите попытку.",
        ["Delete damaged preset?"] = "Удалить повреждённый пресет?",
        ["Delete file %d"] = "Удалить файл %d",
        ["Damaged preset deleted"] = "Повреждённый пресет удалён",
        ["Load"] = "Загрузить",
        ["Overwrite"] = "Перезаписать",
        ["Rename"] = "Переименовать",
        ["Delete"] = "Удалить",
        ["%s (delete to free slot)"] = "%s (удалите, чтобы освободить слот)",
        ["No named presets saved"] = "Нет сохранённых пресетов",
        ["Named presets"] = "Именные пресеты",
        ["Adjustment Range"] = "Диапазон регулировки",
        ["Could not save range. Try again."] = "Не удалось сохранить диапазон. Повторите попытку.",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "Диапазон сохранён. Текущие значения оставлены; расширьте диапазон для изменения значений за его пределами.",
        ["Range set to ±%d"] = "Диапазон установлен на ±%d",
        ["Slot is empty"] = "Ячейка пуста",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "Старые регуляторы MSEB не поддерживаются; ячейка не загружена",
        ["Slot loaded"] = "Ячейка загружена",
        ["Could not load slot. Try again."] = "Не удалось загрузить ячейку. Повторите попытку.",
        ["Could not apply changes. Try again."] = "Не удалось применить изменения. Повторите попытку.",
        ["Some values exceed this range. Widen it to edit them."] = "Некоторые значения выходят за этот диапазон. Расширьте его для редактирования.",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "Сохранённые значения и звук не изменились; расширьте диапазон для редактирования значений вне его.",
        ["%s: %d (outside ±%d)"] = "%s: %d (вне ±%d)",
        ["Stock MSEB width changes the channel mix."] = "Ширина штатного MSEB меняет микс каналов.",
        ["Stereo width changes the channel mix."] = "Ширина стерео меняет микс каналов.",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "Ширина нормирована от 0.00 (моно) до 2.00 (широко), 1.00 нейтрально. Моно-сигнал не меняется.",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "Отрицательные значения сужают, положительные расширяют с ослаблением центра. Моно-сигнал не меняется.",
        ["Stereo Width"] = "Ширина стерео",
        ["Sound Stage"] = "Звуковая сцена",
        ["Overall Temperature"] = "Общая температура",
        ["Bass Extension"] = "Глубина баса",
        ["Bass Texture"] = "Текстура баса",
        ["Note Thickness"] = "Плотность нот",
        ["Vocals"] = "Вокал",
        ["Female Overtones"] = "Женские обертоны",
        ["Sibilance LF"] = "Сибилянты НЧ",
        ["Sibilance HF"] = "Сибилянты ВЧ",
        ["Impulse Response"] = "Импульсный отклик",
        ["Air"] = "Воздух",
        ["Reset to Defaults"] = "Сбросить по умолчанию",
        ["Named Presets"] = "Именные пресеты",
        ["Save Named Preset"] = "Сохранить именной пресет",
        ["Save to Slot"] = "Сохранить в ячейку",
        ["Load from Slot"] = "Загрузить из ячейки",
        ["MSEB reset"] = "MSEB сброшен",
        ["Could not reset MSEB. Try again."] = "Не удалось сбросить MSEB. Повторите попытку.",
        ["Slot 1"] = "Ячейка 1",
        ["Slot 2"] = "Ячейка 2",
        ["Slot 3"] = "Ячейка 3",
        ["Saved to slot"] = "Сохранено в ячейку",
        ["Could not save slot. Try again."] = "Не удалось сохранить в ячейку. Повторите попытку.",
        ["MSEB Options"] = "Параметры MSEB",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "Эта сохранённая схема не поддерживается. Переключение заменит Присутствие инструментов, Атаку баса и Атаку ВЧ штатными регуляторами.",
        ["Stock MSEB controls are already selected"] = "Штатные регуляторы MSEB уже выбраны",
        ["Could not switch controls. Try again."] = "Не удалось переключить регуляторы. Повторите попытку.",
        ["Stock MSEB controls selected"] = "Выбраны штатные регуляторы MSEB",
        ["Switch to stock MSEB"] = "Переключить на штатный MSEB",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "Переключение заменит Присутствие инструментов, Атаку баса и Атаку ВЧ",
        ["Kept existing MSEB settings"] = "Текущие настройки MSEB сохранены",
        ["Enabled"] = "Включено",
        ["Options"] = "Параметры",
        ["Latest Compas firmware with stock MSEB is required"] = "Требуется последняя прошивка Compás со штатным MSEB",
    },
    uk = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "MSEB вимк. Кросфід скинуто до збереженого значення.",
        ["Turn off Loudness Boost first"] = "Спочатку вимкніть підсилення гучності",
        ["Could not change MSEB. Try again."] = "Не вдалося змінити MSEB. Спробуйте ще раз.",
        ["Damaged preset %d"] = "Пошкоджений пресет %d",
        ["Preset changed; reopen the preset list"] = "Пресет змінено; відкрийте список заново",
        ["Text input is unavailable"] = "Введення тексту недоступне",
        ["Enter a short preset name without line breaks"] = "Введіть коротку назву без переносів рядків",
        ["Could not open name entry"] = "Не вдалося відкрити поле введення назви",
        ["Create new preset"] = "Створити новий пресет",
        ["Overwrite: %s"] = "Перезаписати: %s",
        ["Save named preset"] = "Зберегти іменний пресет",
        ["New preset name"] = "Назва нового пресету",
        ["A preset with that name already exists"] = "Пресет із такою назвою вже існує",
        ["Preset limit reached (%d)"] = "Досягнуто ліміту пресетів (%d)",
        ["Preset saved"] = "Пресет збережено",
        ["Could not save preset. Try again."] = "Не вдалося зберегти пресет. Спробуйте ще раз.",
        ["Overwrite preset?"] = "Перезаписати пресет?",
        ["Cancel"] = "Скасувати",
        ["Overwrite %s"] = "Перезаписати %s",
        ["Preset overwritten"] = "Пресет перезаписано",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "Старі регулятори MSEB не підтримуються; пресет не завантажено",
        ["Preset loaded"] = "Пресет завантажено",
        ["Could not load preset. Try again."] = "Не вдалося завантажити пресет. Спробуйте ще раз.",
        ["Rename preset"] = "Перейменувати пресет",
        ["Preset renamed"] = "Пресет перейменовано",
        ["Could not rename preset. Try again."] = "Не вдалося перейменувати пресет. Спробуйте ще раз.",
        ["Delete preset?"] = "Видалити пресет?",
        ["Delete %s"] = "Видалити %s",
        ["Preset deleted"] = "Пресет видалено",
        ["Could not delete preset. Try again."] = "Не вдалося видалити пресет. Спробуйте ще раз.",
        ["Delete damaged preset?"] = "Видалити пошкоджений пресет?",
        ["Delete file %d"] = "Видалити файл %d",
        ["Damaged preset deleted"] = "Пошкоджений пресет видалено",
        ["Load"] = "Завантажити",
        ["Overwrite"] = "Перезаписати",
        ["Rename"] = "Перейменувати",
        ["Delete"] = "Видалити",
        ["%s (delete to free slot)"] = "%s (видаліть, щоб звільнити комірку)",
        ["No named presets saved"] = "Немає збережених пресетів",
        ["Named presets"] = "Іменні пресети",
        ["Adjustment Range"] = "Діапазон регулювання",
        ["Could not save range. Try again."] = "Не вдалося зберегти діапазон. Спробуйте ще раз.",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "Діапазон збережено. Поточні значення залишено; розширте діапазон для редагування значень поза ним.",
        ["Range set to ±%d"] = "Діапазон встановлено на ±%d",
        ["Slot is empty"] = "Комірка порожня",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "Старі регулятори MSEB не підтримуються; комірку не завантажено",
        ["Slot loaded"] = "Комірку завантажено",
        ["Could not load slot. Try again."] = "Не вдалося завантажити комірку. Спробуйте ще раз.",
        ["Could not apply changes. Try again."] = "Не вдалося застосувати зміни. Спробуйте ще раз.",
        ["Some values exceed this range. Widen it to edit them."] = "Деякі значення виходять за цей діапазон. Розширте його для редагування.",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "Збережені значення та звук не змінилися; розширте діапазон для редагування значень поза ним.",
        ["%s: %d (outside ±%d)"] = "%s: %d (поза ±%d)",
        ["Stock MSEB width changes the channel mix."] = "Ширина штатного MSEB змінює мікс каналів.",
        ["Stereo width changes the channel mix."] = "Ширина стерео змінює мікс каналів.",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "Ширина нормована від 0.00 (моно) до 2.00 (широко), 1.00 нейтрально. Моно-сигнал не змінюється.",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "Від'ємні значення звужують, додатні розширюють зі зменшенням центру. Моно-сигнал не змінюється.",
        ["Stereo Width"] = "Ширина стерео",
        ["Sound Stage"] = "Звукова сцена",
        ["Overall Temperature"] = "Загальна температура",
        ["Bass Extension"] = "Глибина баса",
        ["Bass Texture"] = "Текстура баса",
        ["Note Thickness"] = "Щільність нот",
        ["Vocals"] = "Вокал",
        ["Female Overtones"] = "Жіночі обертони",
        ["Sibilance LF"] = "Сибілянти НЧ",
        ["Sibilance HF"] = "Сибілянти ВЧ",
        ["Impulse Response"] = "Імпульсний відгук",
        ["Air"] = "Повітря",
        ["Reset to Defaults"] = "Скинути за замовчуванням",
        ["Named Presets"] = "Іменні пресети",
        ["Save Named Preset"] = "Зберегти іменний пресет",
        ["Save to Slot"] = "Зберегти в комірку",
        ["Load from Slot"] = "Завантажити з комірки",
        ["MSEB reset"] = "MSEB скинуто",
        ["Could not reset MSEB. Try again."] = "Не вдалося скинути MSEB. Спробуйте ще раз.",
        ["Slot 1"] = "Комірка 1",
        ["Slot 2"] = "Комірка 2",
        ["Slot 3"] = "Комірка 3",
        ["Saved to slot"] = "Збережено в комірку",
        ["Could not save slot. Try again."] = "Не вдалося зберегти в комірку. Спробуйте ще раз.",
        ["MSEB Options"] = "Параметри MSEB",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "Ця збережена схема не підтримується. Перемикання замінить Присутність інструментів, Атаку баса та Атаку ВЧ штатними регуляторами.",
        ["Stock MSEB controls are already selected"] = "Штатні регулятори MSEB вже вибрано",
        ["Could not switch controls. Try again."] = "Не вдалося перемкнути регулятори. Спробуйте ще раз.",
        ["Stock MSEB controls selected"] = "Вибрано штатні регулятори MSEB",
        ["Switch to stock MSEB"] = "Перемкнути на штатний MSEB",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "Перемикання замінить Присутність інструментів, Атаку баса та Атаку ВЧ",
        ["Kept existing MSEB settings"] = "Поточні налаштування MSEB збережено",
        ["Enabled"] = "Увімкнено",
        ["Options"] = "Параметри",
        ["Latest Compas firmware with stock MSEB is required"] = "Потрібна остання прошивка Compás зі штатним MSEB",
    },
    vi = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "Đã tắt MSEB. Crossfeed đã về giá trị đã lưu.",
        ["Turn off Loudness Boost first"] = "Hãy tắt Tăng âm lượng trước",
        ["Could not change MSEB. Try again."] = "Không thể thay đổi MSEB. Hãy thử lại.",
        ["Damaged preset %d"] = "Cài đặt sẵn bị hỏng %d",
        ["Preset changed; reopen the preset list"] = "Cài đặt sẵn đã đổi; hãy mở lại danh sách",
        ["Text input is unavailable"] = "Không hỗ trợ nhập văn bản",
        ["Enter a short preset name without line breaks"] = "Nhập tên ngắn gọn không xuống dòng",
        ["Could not open name entry"] = "Không thể mở ô nhập tên",
        ["Create new preset"] = "Tạo cài đặt sẵn mới",
        ["Overwrite: %s"] = "Ghi đè: %s",
        ["Save named preset"] = "Lưu cài đặt sẵn có tên",
        ["New preset name"] = "Tên cài đặt sẵn mới",
        ["A preset with that name already exists"] = "Đã có cài đặt sẵn mang tên này",
        ["Preset limit reached (%d)"] = "Đã đạt giới hạn cài đặt sẵn (%d)",
        ["Preset saved"] = "Đã lưu cài đặt sẵn",
        ["Could not save preset. Try again."] = "Không thể lưu cài đặt sẵn. Hãy thử lại.",
        ["Overwrite preset?"] = "Ghi đè cài đặt sẵn?",
        ["Cancel"] = "Hủy",
        ["Overwrite %s"] = "Ghi đè %s",
        ["Preset overwritten"] = "Đã ghi đè cài đặt sẵn",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "Không hỗ trợ thanh chỉnh MSEB cũ; chưa tải cài đặt sẵn",
        ["Preset loaded"] = "Đã tải cài đặt sẵn",
        ["Could not load preset. Try again."] = "Không thể tải cài đặt sẵn. Hãy thử lại.",
        ["Rename preset"] = "Đổi tên cài đặt sẵn",
        ["Preset renamed"] = "Đã đổi tên cài đặt sẵn",
        ["Could not rename preset. Try again."] = "Không thể đổi tên cài đặt sẵn. Hãy thử lại.",
        ["Delete preset?"] = "Xóa cài đặt sẵn?",
        ["Delete %s"] = "Xóa %s",
        ["Preset deleted"] = "Đã xóa cài đặt sẵn",
        ["Could not delete preset. Try again."] = "Không thể xóa cài đặt sẵn. Hãy thử lại.",
        ["Delete damaged preset?"] = "Xóa cài đặt sẵn bị hỏng?",
        ["Delete file %d"] = "Xóa tệp %d",
        ["Damaged preset deleted"] = "Đã xóa cài đặt sẵn bị hỏng",
        ["Load"] = "Tải",
        ["Overwrite"] = "Ghi đè",
        ["Rename"] = "Đổi tên",
        ["Delete"] = "Xóa",
        ["%s (delete to free slot)"] = "%s (xóa để giải phóng ô)",
        ["No named presets saved"] = "Chưa lưu cài đặt sẵn nào",
        ["Named presets"] = "Cài đặt sẵn có tên",
        ["Adjustment Range"] = "Phạm vi điều chỉnh",
        ["Could not save range. Try again."] = "Không thể lưu phạm vi. Hãy thử lại.",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "Đã lưu phạm vi. Giữ nguyên giá trị hiện tại; mở rộng phạm vi để sửa các giá trị vượt mức.",
        ["Range set to ±%d"] = "Đã đặt phạm vi thành ±%d",
        ["Slot is empty"] = "Ô nhớ trống",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "Không hỗ trợ thanh chỉnh MSEB cũ; chưa tải ô nhớ",
        ["Slot loaded"] = "Đã tải ô nhớ",
        ["Could not load slot. Try again."] = "Không thể tải ô nhớ. Hãy thử lại.",
        ["Could not apply changes. Try again."] = "Không thể áp dụng thay đổi. Hãy thử lại.",
        ["Some values exceed this range. Widen it to edit them."] = "Một số giá trị vượt quá phạm vi này. Hãy mở rộng để chỉnh sửa.",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "Giá trị đã lưu và âm thanh không đổi; hãy mở rộng phạm vi để sửa giá trị ngoài mức.",
        ["%s: %d (outside ±%d)"] = "%s: %d (ngoài ±%d)",
        ["Stock MSEB width changes the channel mix."] = "Độ rộng MSEB chuẩn làm thay đổi bản phối kênh.",
        ["Stereo width changes the channel mix."] = "Độ rộng stereo làm thay đổi bản phối kênh.",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "Độ rộng chuẩn hóa từ 0.00 (mono) đến 2.00 (rộng), 1.00 là trung tính. Nguồn mono không đổi.",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "Số âm thu hẹp, số dương mở rộng và giảm âm giữa. Nguồn mono không đổi.",
        ["Stereo Width"] = "Độ rộng stereo",
        ["Sound Stage"] = "Âm trường",
        ["Overall Temperature"] = "Độ ấm tổng thể",
        ["Bass Extension"] = "Độ sâu âm trầm",
        ["Bass Texture"] = "Kết cấu âm trầm",
        ["Note Thickness"] = "Độ dày nốt nhạc",
        ["Vocals"] = "Giọng hát",
        ["Female Overtones"] = "Âm bồi giọng nữ",
        ["Sibilance LF"] = "Âm xuýt tần thấp",
        ["Sibilance HF"] = "Âm xuýt tần cao",
        ["Impulse Response"] = "Đáp ứng xung",
        ["Air"] = "Độ thoáng",
        ["Reset to Defaults"] = "Khôi phục mặc định",
        ["Named Presets"] = "Cài đặt sẵn có tên",
        ["Save Named Preset"] = "Lưu cài đặt sẵn có tên",
        ["Save to Slot"] = "Lưu vào ô nhớ",
        ["Load from Slot"] = "Tải từ ô nhớ",
        ["MSEB reset"] = "Đã đặt lại MSEB",
        ["Could not reset MSEB. Try again."] = "Không thể đặt lại MSEB. Hãy thử lại.",
        ["Slot 1"] = "Ô nhớ 1",
        ["Slot 2"] = "Ô nhớ 2",
        ["Slot 3"] = "Ô nhớ 3",
        ["Saved to slot"] = "Đã lưu vào ô nhớ",
        ["Could not save slot. Try again."] = "Không thể lưu vào ô nhớ. Hãy thử lại.",
        ["MSEB Options"] = "Tùy chọn MSEB",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "Bố cục đã lưu này không được hỗ trợ. Chuyển đổi sẽ thay thế Độ nổi nhạc cụ, Độ sắc âm trầm và Độ sắc âm cao bằng các thanh chỉnh chuẩn.",
        ["Stock MSEB controls are already selected"] = "Đã chọn các thanh chỉnh MSEB chuẩn",
        ["Could not switch controls. Try again."] = "Không thể chuyển đổi thanh chỉnh. Hãy thử lại.",
        ["Stock MSEB controls selected"] = "Đã chọn thanh chỉnh MSEB chuẩn",
        ["Switch to stock MSEB"] = "Chuyển sang MSEB chuẩn",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "Chuyển đổi sẽ thay thế Độ nổi nhạc cụ, Độ sắc âm trầm và Độ sắc âm cao",
        ["Kept existing MSEB settings"] = "Đã giữ cài đặt MSEB hiện tại",
        ["Enabled"] = "Đã bật",
        ["Options"] = "Tùy chọn",
        ["Latest Compas firmware with stock MSEB is required"] = "Cần firmware Compás mới nhất có hỗ trợ MSEB chuẩn",
    },
    zh_CN = {
        ["MSEB off. Crossfeed was reset to its saved value."] = "MSEB 已关闭。交叉馈送已恢复为保存的值。",
        ["Turn off Loudness Boost first"] = "请先关闭响度增强",
        ["Could not change MSEB. Try again."] = "无法更改 MSEB，请重试。",
        ["Damaged preset %d"] = "损坏的预设 %d",
        ["Preset changed; reopen the preset list"] = "预设已更改，请重新打开预设列表",
        ["Text input is unavailable"] = "文本输入不可用",
        ["Enter a short preset name without line breaks"] = "请输入不含换行的简短预设名称",
        ["Could not open name entry"] = "无法打开名称输入",
        ["Create new preset"] = "创建新预设",
        ["Overwrite: %s"] = "覆盖：%s",
        ["Save named preset"] = "保存命名预设",
        ["New preset name"] = "新预设名称",
        ["A preset with that name already exists"] = "同名预设已存在",
        ["Preset limit reached (%d)"] = "已达预设数量上限 (%d)",
        ["Preset saved"] = "预设已保存",
        ["Could not save preset. Try again."] = "无法保存预设，请重试。",
        ["Overwrite preset?"] = "覆盖预设？",
        ["Cancel"] = "取消",
        ["Overwrite %s"] = "覆盖 %s",
        ["Preset overwritten"] = "预设已覆盖",
        ["Older MSEB controls are unsupported; preset was not loaded"] = "不支持旧版 MSEB 调节项，未加载预设",
        ["Preset loaded"] = "预设已加载",
        ["Could not load preset. Try again."] = "无法加载预设，请重试。",
        ["Rename preset"] = "重命名预设",
        ["Preset renamed"] = "预设已重命名",
        ["Could not rename preset. Try again."] = "无法重命名预设，请重试。",
        ["Delete preset?"] = "删除预设？",
        ["Delete %s"] = "删除 %s",
        ["Preset deleted"] = "预设已删除",
        ["Could not delete preset. Try again."] = "无法删除预设，请重试。",
        ["Delete damaged preset?"] = "删除损坏的预设？",
        ["Delete file %d"] = "删除文件 %d",
        ["Damaged preset deleted"] = "已删除损坏的预设",
        ["Load"] = "加载",
        ["Overwrite"] = "覆盖",
        ["Rename"] = "重命名",
        ["Delete"] = "删除",
        ["%s (delete to free slot)"] = "%s（删除以释放槽位）",
        ["No named presets saved"] = "没有已保存的命名预设",
        ["Named presets"] = "命名预设",
        ["Adjustment Range"] = "调节范围",
        ["Could not save range. Try again."] = "无法保存范围，请重试。",
        ["Range saved. Existing values kept; widen the range to edit values beyond it."] = "范围已保存。保留现有数值；扩大范围可编辑超出部分。",
        ["Range set to ±%d"] = "范围已设为 ±%d",
        ["Slot is empty"] = "槽位为空",
        ["Older MSEB controls are unsupported; slot was not loaded"] = "不支持旧版 MSEB 调节项，未加载槽位",
        ["Slot loaded"] = "槽位已加载",
        ["Could not load slot. Try again."] = "无法加载槽位，请重试。",
        ["Could not apply changes. Try again."] = "无法应用更改，请重试。",
        ["Some values exceed this range. Widen it to edit them."] = "部分数值超出此范围，请扩大范围以进行编辑。",
        ["Stored values and sound are unchanged; widen the range to edit values outside it."] = "已保存数值与声音保持不变；扩大范围可编辑超出部分。",
        ["%s: %d (outside ±%d)"] = "%s：%d（超出 ±%d）",
        ["Stock MSEB width changes the channel mix."] = "原生 MSEB 宽度会改变声道混合。",
        ["Stereo width changes the channel mix."] = "立体声宽度会改变声道混合。",
        ["Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged."] = "宽度范围为 0.00（单声道）至 2.00（宽广），1.00 为中性。单声道输入不受影响。",
        ["Negative narrows, positive widens with lower center level. Mono input is unchanged."] = "负值收窄，正值拓宽并降低中置电平。单声道输入不受影响。",
        ["Stereo Width"] = "立体声宽度",
        ["Sound Stage"] = "声场",
        ["Overall Temperature"] = "整体冷暖",
        ["Bass Extension"] = "低频下潜",
        ["Bass Texture"] = "低频质感",
        ["Note Thickness"] = "声音厚度",
        ["Vocals"] = "人声位置",
        ["Female Overtones"] = "女声泛音",
        ["Sibilance LF"] = "低频齿音",
        ["Sibilance HF"] = "高频齿音",
        ["Impulse Response"] = "脉冲响应",
        ["Air"] = "空气感",
        ["Reset to Defaults"] = "恢复默认",
        ["Named Presets"] = "命名预设",
        ["Save Named Preset"] = "保存命名预设",
        ["Save to Slot"] = "保存到槽位",
        ["Load from Slot"] = "从槽位加载",
        ["MSEB reset"] = "MSEB 已重置",
        ["Could not reset MSEB. Try again."] = "无法重置 MSEB，请重试。",
        ["Slot 1"] = "槽位 1",
        ["Slot 2"] = "槽位 2",
        ["Slot 3"] = "槽位 3",
        ["Saved to slot"] = "已保存到槽位",
        ["Could not save slot. Try again."] = "无法保存到槽位，请重试。",
        ["MSEB Options"] = "MSEB 选项",
        ["This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."] = "不支持此已保存布局。切换后会将乐器存在感、低频冲击和高频冲击替换为原生调节项。",
        ["Stock MSEB controls are already selected"] = "已选择原生 MSEB 调节项",
        ["Could not switch controls. Try again."] = "无法切换调节项，请重试。",
        ["Stock MSEB controls selected"] = "已切换为原生 MSEB 调节项",
        ["Switch to stock MSEB"] = "切换到原生 MSEB",
        ["Switching replaces Instrument Presence, Bass Bite, and Treble Bite"] = "切换后将替换乐器存在感、低频冲击和高频冲击",
        ["Kept existing MSEB settings"] = "已保留现有 MSEB 设置",
        ["Enabled"] = "已启用",
        ["Options"] = "选项",
        ["Latest Compas firmware with stock MSEB is required"] = "需要支持原生 MSEB 的最新 Compás 固件",
    },
}
local function tr(s)
    return plugin.tr(s, T)
end

local modern_mseb_ui = plugin.has_capability("ui.settings_list_10_sliders")
    and plugin.has_capability("audio.mseb.stock")
    and plugin.mseb_apply_state and plugin.get_mseb_state

-- Mood-based tone tuning for firmware's native 13-filter stock MSEB engine.
-- This release requires native stock MSEB and the ten-slider settings UI.
-- Legacy saved curves require an explicit conversion before editing.
-- The plugin appears under Settings -> Sound. Sound Stage holds Stereo Width,
-- a normalized mid/side matrix saved in MSEB state (or the fallback PEQ
-- profile). Crossfeed remains separate in the native Sound settings; it is
-- read from the live EQ so tone and width changes leave it unchanged.
-- Presets (slots) hold tone and width only.
-- On stock-MSEB builds Impulse is a tonal presence control. Legacy PEQ
-- fallback maps it to a broad 7.5 kHz EQ level; neither path changes attack.
--
-- The current stock curve exposes ten controls. curve=legacy is the earlier
-- 1.1 mapping, including Instrument Presence, Bass Bite, and Treble Bite;
-- the explicit conversion replaces those three with Sibilance LF / HF and
-- Impulse controls.
-- A file with no curve marker is legacy, so opening or upgrading does not
-- retune an existing user. A missing state file starts on curve=new.
-- Switching is a confirmed action.
local OLD_FREQS = { 31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000 }
local OLD_Q     = { 0.2, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.2 }
local NEW_FREQS = { 31, 62, 125, 250, 500, 1000, 7500, 5800, 9200, 16000 }
local NEW_Q     = { 0.2, 0.7, 0.7, 0.7, 0.7, 0.7, 0.4, 1.0, 1.0, 0.2 }
local BAND_TYPE  = { "low_shelf", "peaking", "peaking", "peaking", "peaking",
                      "peaking", "peaking", "peaking", "peaking", "high_shelf" }

-- Each axis is -100..100. `contrib` is the PEQ band (1-based, matching
-- plugin.eq_set_band()) and the dB at full deflection. `mode` nil means the
-- axis is in both curves. Only band 1 and band 10 are shared by two live
-- axes. Contributions to one band are summed, then clamped to ±12 dB.
local AXES = {
    { key = "sound_stage", contrib = {} },
    { key = "temperature",  contrib = { { band = 1, db = 3 }, { band = 10, db = -4 } } },
    { key = "bass_ext",     contrib = { { band = 1, db = 6 } } },
    { key = "bass_texture", contrib = { { band = 2, db = 5 } } },
    { key = "thickness",    contrib = { { band = 4, db = 5 } } },
    { key = "vocal_pos",    contrib = { { band = 5, db = 5 } } },
    { key = "female_vocal", contrib = { { band = 6, db = 4 } } },
    { key = "air",          contrib = { { band = 10, db = 5 } } },
    { key = "instruments",  mode = "legacy", contrib = { { band = 3, db = 3 }, { band = 7, db = 4 } } },
    { key = "bass_bite",    mode = "legacy", contrib = { { band = 8, db = 4 } } },
    { key = "treble_bite",  mode = "legacy", contrib = { { band = 9, db = 4 } } },
    { key = "sibilance_lf", mode = "new",    contrib = { { band = 8, db = 4 } } },
    { key = "sibilance_hf", mode = "new",    contrib = { { band = 9, db = 4 } } },
    { key = "impulse_tone", mode = "new",    contrib = { { band = 7, db = 3 } } },
}

-- Crossfeed angles the player accepts (peq.c). Index 1 is no delay.
local CROSSFEED_ANGLES = { 0, 30, 45, 60, 90 }

local PLUGIN_DIR = plugin.sd_root() .. "/.plugins"
local STATE_PATH = PLUGIN_DIR .. "/.mseb_state"
local PRESET_LIMIT = 20
local PRESET_NAME_MAX = 64
local RANGE_VALUES = { 20, 40, 100 }
-- Snapshot of whatever manual PEQ curve was live right before MSEB was
-- first enabled -- see set_enabled() below. Written/read only via
-- plugin.eq_save_profile()/eq_load_profile(), never parsed here directly.
local BACKUP_PATH = PLUGIN_DIR .. "/.mseb_pre_backup.peq"
local PROFILE_PATH = PLUGIN_DIR .. "/.mseb_active.peq"
-- Loudness Boost (PlaybackExtras) also snapshots and restores the whole EQ.
-- Its backup exists exactly while it is on, and two independent snapshots
-- cannot be restored in any order, so MSEB refuses to turn on beside it.
local OTHER_EQ_OWNER_BACKUP = PLUGIN_DIR .. "/.playback_extras_backup.peq"

local function slot_path(n)
    return PLUGIN_DIR .. "/.mseb_slot" .. n
end

local function named_preset_path(n)
    return PLUGIN_DIR .. "/.mseb_preset" .. tostring(n)
end

-- Reads a plain key=value\n file into a table via repeated single-line
-- reads (same io pattern SoundProfiles.lua's own read_state() uses) --
-- deliberately not f:lines(), to stay within the exact io usage already
-- demonstrated as safe in this plugin sandbox.
local function read_kv_file(path)
    local out, raw_lines = {}, {}
    local f = io.open(path, "r")
    if not f then return out, false, nil end
    local line = f:read("*l")
    while line do
        raw_lines[#raw_lines + 1] = line .. "\n"
        local k, v = line:match("^([%w_]+)=(.-)$")
        if k then out[k] = v end
        line = f:read("*l")
    end
    f:close()
    return out, true, table.concat(raw_lines)
end

local function file_exists(path)
    local f = io.open(path, "r")
    if f then f:close() return true end
    return false
end

-- Sliders are -100..100. Non-numeric, NaN, and infinity become 0 so a
-- corrupt line cannot push a band gain outside the clamp below.
local function clamp_axis(raw)
    local v = tonumber(raw)
    if type(v) ~= "number" or v ~= v or v == math.huge or v == -math.huge then
        return 0
    end
    if v < -100 then v = -100 end
    if v > 100 then v = 100 end
    if v < 0 then return math.ceil(v - 0.5) end
    return math.floor(v + 0.5)
end

local values = {}
for _, a in ipairs(AXES) do values[a.key] = 0 end
local enabled = false
local manual_backup_restored = false
local axis_range = 100
-- Missing state is a new install. An existing file without curve= is 1.1.
local curve = "new"

local function curve_from_marker(marker)
    if marker == "new" then return "new" end
    return "legacy"
end

local function axis_in_curve(axis, which)
    return axis.mode == nil or axis.mode == which
end

do
    local kv, found = read_kv_file(STATE_PATH)
    if found then
        enabled = (kv.enabled == "1")
        local saved_range = tonumber(kv.range)
        if saved_range == 20 or saved_range == 40 or saved_range == 100 then axis_range = saved_range end
        curve = curve_from_marker(kv.curve)
        for _, a in ipairs(AXES) do
            if not axis_in_curve(a, curve) then
                values[a.key] = 0
            elseif kv[a.key] then
                values[a.key] = clamp_axis(kv[a.key])
            end
        end
    end
end

local function write_kv_file(path, include_enabled)
    local temp_path = path .. ".tmp"
    local f = io.open(temp_path, "w")
    if not f then return false end
    local ok = true
    ok = f:write("curve=" .. curve .. "\n")
    if ok and include_enabled then
        ok = f:write("enabled=" .. (enabled and "1" or "0") .. "\n")
        if ok then ok = f:write("range=" .. tostring(axis_range) .. "\n") end
    end
    for _, a in ipairs(AXES) do
        if ok and axis_in_curve(a, curve) then
            ok = f:write(a.key .. "=" .. tostring(values[a.key]) .. "\n")
        end
    end
    local closed = f:close()
    if not ok or not closed then
        os.remove(temp_path)
        return false
    end
    if not os.rename(temp_path, path) then
        os.remove(temp_path)
        return false
    end
    return true
end

local function write_state()
    return write_kv_file(STATE_PATH, true)
end

local function backup_preamp()
    local f = io.open(BACKUP_PATH, "r")
    if not f then return "0.00" end
    local preamp = "0.00"
    for line in f:lines() do
        local value = line:match("^preamp=([%-%d%.]+)$")
        if value then
            preamp = value
            break
        end
    end
    f:close()
    return preamp
end

local function write_whole(path, text)
    if text == nil then return true end
    local f = io.open(path, "w")
    if not f then return false end
    local ok = f:write(text)
    local closed = f:close()
    return ok and closed
end

local function write_atomic(path, text)
    local temp_path = path .. ".tmp"
    if not write_whole(temp_path, text) then
        os.remove(temp_path)
        return false
    end
    if not os.rename(temp_path, path) then
        os.remove(temp_path)
        return false
    end
    return true
end

local function angle_index(angle)
    for i, a in ipairs(CROSSFEED_ANGLES) do
        if a == angle then return i end
    end
    return nil
end

-- Detached snapshot of the live EQ, or nil on builds without the snapshot
-- API. Every crossfeed build has it, so a non-nil live crossfeed implies a
-- snapshot.
local function live_snapshot()
    if not plugin.has_capability("audio.peq.state") or not plugin.get_eq_state then return nil end
    return plugin.get_eq_state()
end

-- Applies a snapshot from live_snapshot() through the native validator. The
-- native side raises on refusal instead of returning false, so the call is
-- wrapped. Applying saves the whole EQ unless persist is false, as used by
-- rollback paths.
local function apply_snapshot(snapshot, persist)
    if not snapshot then return false end
    local opts = nil
    if persist == false then opts = { persist = false } end
    local ok, applied = pcall(plugin.eq_apply_state, snapshot, opts)
    return ok and applied == true
end

local function native_mseb()
    return plugin.has_capability("audio.mseb.stock") and plugin.mseb_apply_state
        and plugin.get_mseb_state
end

local function native_state(on)
    return {
        enabled = on,
        temperature = values.temperature, bass_ext = values.bass_ext,
        bass_texture = values.bass_texture, thickness = values.thickness,
        vocal_pos = values.vocal_pos, female_vocal = values.female_vocal,
        sibilance_lf = values.sibilance_lf, sibilance_hf = values.sibilance_hf,
        impulse_tone = values.impulse_tone, air = values.air,
        width = 1.0 + values.sound_stage / 100.0,
    }
end

local function apply_native(on)
    if not native_mseb() then return true end
    local ok, result = pcall(plugin.mseb_apply_state, native_state(on))
    return ok and result == true
end

local function restore_native_state(state)
    if not native_mseb() or not state then return true end
    local ok, result = pcall(plugin.mseb_apply_state, state)
    return ok and result == true
end

-- A rollback that returns the live EQ to MSEB's own curve must not save that
-- curve to the native file. On a build with audio.peq.transient MSEB never
-- saved it in the first place. Other builds saved it through the load
-- anyway, so their rollbacks keep saving.
local function rollback_persists()
    return not plugin.has_capability("audio.peq.transient")
end

-- Live crossfeed, or nil when this build has no crossfeed. `angle_supported`
-- is false on the early crossfeed builds that had strength but no angle.
-- One snapshot serves both fields.
local function read_crossfeed()
    if not plugin.has_capability("audio.crossfeed") then return nil end
    local state = live_snapshot()
    if not state then return nil end
    local strength = state.crossfeed
    if type(strength) ~= "number" or strength ~= strength or strength < 0 or strength > 1 then
        strength = 0
    end
    local live = { strength = strength, angle = 0, angle_supported = false }
    if plugin.has_capability("audio.crossfeed.angle") then
        live.angle_supported = true
        if angle_index(state.crossfeed_angle) then live.angle = state.crossfeed_angle end
    end
    return live
end

-- Builds a complete MSEB profile before loading it, so each change results
-- in one native profile load rather than a save for every EQ field.
-- MSEB owns the bands while active; the preamp stays the user's own, read
-- from the backup taken when MSEB was switched on. Crossfeed is not MSEB's:
-- the current live strength and angle are written back unchanged. A profile
-- without those keys would load them as off, which is the reset this avoids.
local function profile_text()
    local width = 1.0 + values.sound_stage / 100.0
    local lines = { "bypass=0", "preamp=" .. backup_preamp(), string.format("stereo_width=%.6f", width) }
    local live = read_crossfeed()
    if live then
        table.insert(lines, string.format("crossfeed=%.6f", live.strength))
        if live.angle_supported then
            table.insert(lines, string.format("crossfeed_angle=%d", live.angle))
        end
    end
    local freqs = (curve == "legacy") and OLD_FREQS or NEW_FREQS
    local qs = (curve == "legacy") and OLD_Q or NEW_Q
    local gains = {}
    for _, axis in ipairs(AXES) do
        if axis_in_curve(axis, curve) then
            for _, c in ipairs(axis.contrib) do
                gains[c.band] = (gains[c.band] or 0) + (values[axis.key] / 100.0) * c.db
            end
        end
    end
    for i = 1, 10 do
        local gain = math.max(-12, math.min(12, gains[i] or 0))
        local band_type = (BAND_TYPE[i] == "low_shelf") and 1 or (BAND_TYPE[i] == "high_shelf") and 2 or 0
        table.insert(lines, string.format("band%d_freq=%.2f", i - 1, freqs[i]))
        table.insert(lines, string.format("band%d_gain=%.2f", i - 1, gain))
        table.insert(lines, string.format("band%d_q=%.3f", i - 1, qs[i]))
        table.insert(lines, string.format("band%d_type=%d", i - 1, band_type))
        table.insert(lines, string.format("band%d_enabled=%d", i - 1, gain ~= 0 and 1 or 0))
    end
    return table.concat(lines, "\n") .. "\n"
end

-- Live-only apply when this build has it, so a tone change does not rewrite
-- the native EQ file. Older API 16 builds use the saving load.
local function load_active_profile()
    if plugin.has_capability("audio.peq.transient") and plugin.eq_apply_profile then
        return plugin.eq_apply_profile(PROFILE_PATH, { persist = false })
    end
    return plugin.eq_load_profile(PROFILE_PATH)
end

local function apply_profile()
    if curve == "new" and native_mseb() then
        return apply_native(true)
    end
    if not write_atomic(PROFILE_PATH, profile_text()) then return false end
    local loaded = load_active_profile()
    if not loaded then return false end
    -- A legacy PEQ curve takes ownership only after its profile was accepted.
    if native_mseb() then return apply_native(false) end
    return true
end

-- Puts back the EQ saved before MSEB was enabled. The backup loads through
-- the native loader, so no MSEB file is written and a read-only card cannot
-- block it. Returns ok, message. ok is false only when the native loader
-- refused the backup, and then nothing changed.
--
-- The backup can hold bands the snapshot validator refuses even though the
-- loader accepted them (for example q=0 on an unused band). So crossfeed the
-- user changed while MSEB was on is written back only when the loaded value
-- differs. If that write-back is refused, the loaded backup stays live and the
-- saved crossfeed is used. Turning MSEB off is never blocked by it. The
-- message tells the user their changed crossfeed was lost.
local function restore_backup()
    local live = read_crossfeed()
    if not plugin.eq_load_profile(BACKUP_PATH) then return false end
    -- Preserve the native effect until the manual PEQ backup is safely live.
    if native_mseb() and not apply_native(false) then return false end
    if not live then return true end
    local loaded = read_crossfeed()
    local same = math.abs(loaded.strength - live.strength) < 1e-6
        and (not live.angle_supported or loaded.angle == live.angle)
    if same then return true end
    local state = live_snapshot()
    state.crossfeed = live.strength
    if live.angle_supported then state.crossfeed_angle = live.angle end
    if apply_snapshot(state) then return true end
    return true, tr("MSEB off. Crossfeed was reset to its saved value.")
end

-- Restore a manual PEQ snapshot without deleting its durable backup. Curve
-- transitions only remove that backup after the matching state write commits.
local function load_manual_backup()
    local live = read_crossfeed()
    if not file_exists(BACKUP_PATH) or not plugin.eq_load_profile(BACKUP_PATH) then return false end
    manual_backup_restored = true
    if not live then return true end
    local loaded = read_crossfeed()
    if math.abs(loaded.strength - live.strength) < 1e-6
        and (not live.angle_supported or loaded.angle == live.angle) then return true end
    local state = live_snapshot()
    state.crossfeed = live.strength
    if live.angle_supported then state.crossfeed_angle = live.angle end
    apply_snapshot(state)
    return true
end

-- Stock mode changes only the transient DSP and plugin state; it leaves the
-- manual PEQ alone. Legacy mode also owns the PEQ bands and uses a manual-EQ
-- backup. Each branch rolls its live state back if the plugin-state write
-- fails.
local function set_enabled(new_enabled)
    if new_enabled == enabled then return true end
    if new_enabled then
        if file_exists(OTHER_EQ_OWNER_BACKUP) then
            return false, tr("Turn off Loudness Boost first")
        end
        if curve == "new" and native_mseb() then
            if file_exists(BACKUP_PATH) and not manual_backup_restored and not load_manual_backup() then
                return false
            end
            local native_before = plugin.get_mseb_state()
            if not apply_native(true) then return false end
            enabled = true
            if not write_state() then
                enabled = false
                restore_native_state(native_before)
                return false
            end
            if manual_backup_restored and file_exists(BACKUP_PATH) then os.remove(BACKUP_PATH) end
            return true
        end
        -- The legacy PEQ curve owns the bands, so save the manual curve before
        -- applying it. A leftover backup remains authoritative after a failed
        -- earlier restore and must not be overwritten.
        local created = not file_exists(BACKUP_PATH)
        if created and not plugin.eq_save_profile(BACKUP_PATH) then return false end
        local before = live_snapshot()
        local native_before = native_mseb() and plugin.get_mseb_state() or nil
        if not apply_profile() then
            local restored = apply_snapshot(before) or plugin.eq_load_profile(BACKUP_PATH)
            restore_native_state(native_before)
            if created and restored then os.remove(BACKUP_PATH) end
            return false
        end
        enabled = true
        if not write_state() then
            enabled = false
            if not apply_snapshot(before) then plugin.eq_load_profile(BACKUP_PATH) end
            restore_native_state(native_before)
            if created then os.remove(BACKUP_PATH) end
            return false
        end
    else
        if curve == "new" and native_mseb() then
            local native_before = plugin.get_mseb_state()
            if file_exists(BACKUP_PATH) and not manual_backup_restored and not load_manual_backup() then
                return false
            end
            if not apply_native(false) then return false end
            enabled = false
            if not write_state() then
                enabled = true
                restore_native_state(native_before)
                return false
            end
            -- A backup can only be left from an interrupted old-version
            -- migration. It is removed only after it was restored and the
            -- disabled state committed.
            if manual_backup_restored and file_exists(BACKUP_PATH) then os.remove(BACKUP_PATH) end
            return true
        end
        if not file_exists(BACKUP_PATH) then return false end
        local before = live_snapshot()
        local native_before = native_mseb() and plugin.get_mseb_state() or nil
        local restored, message = restore_backup()
        if not restored then return false end
        enabled = false
        if not write_state() then
            enabled = true
            if not apply_snapshot(before, rollback_persists()) then apply_profile() end
            restore_native_state(native_before)
            return false
        end
        os.remove(BACKUP_PATH)
        return true, message
    end
    return true
end

-- set_enabled() returns false with a reason when it refuses, and true with a
-- message when the switch worked but the user should know something.
local function show_enabled_result(ok, message)
    if not ok then
        plugin.show_toast(message or tr("Could not change MSEB. Try again."))
    elseif message then
        plugin.show_toast(message)
    end
end

local function snapshot_values()
    local previous = {}
    for _, a in ipairs(AXES) do previous[a.key] = values[a.key] end
    return previous
end

local function restore_values(previous)
    for _, a in ipairs(AXES) do values[a.key] = previous[a.key] end
end

-- Every change to tone, width, or curve goes through here. Native mode
-- updates transient MSEB state; legacy mode updates its PEQ profile. Curve
-- transitions additionally preserve the manual PEQ backup until the state
-- write commits.
local function commit_values(change)
    local previous = snapshot_values()
    local previous_curve = curve
    local previous_range = axis_range
    local before = live_snapshot()
    local native_before = native_mseb() and plugin.get_mseb_state() or nil
    local was_stock = enabled and curve == "new" and native_mseb()
    change()
    local becomes_stock = enabled and curve == "new" and native_mseb()
    local created_backup = false
    local ok = true
    if enabled and was_stock and not becomes_stock then
        created_backup = not file_exists(BACKUP_PATH)
        if created_backup then
            ok = plugin.eq_save_profile(BACKUP_PATH)
            if ok then manual_backup_restored = false end
        end
        if ok then ok = apply_profile() end
    elseif enabled and not was_stock and becomes_stock then
        -- Switching away from the PEQ-owned legacy curve restores the saved
        -- manual EQ before stock MSEB takes over. Keep its backup until state
        -- persistence succeeds, so a failed conversion can return to legacy.
        ok = load_manual_backup()
        if ok then ok = apply_profile() end
    elseif enabled then
        ok = apply_profile()
    end
    if ok then ok = write_state() end
    if ok then
        if was_stock and not becomes_stock and created_backup then
            -- Legacy mode now owns PEQ and needs this backup for disable.
        elseif not was_stock and becomes_stock and file_exists(BACKUP_PATH) then
            os.remove(BACKUP_PATH)
        end
        return true
    end
    curve = previous_curve
    axis_range = previous_range
    restore_values(previous)
    if enabled and was_stock and not becomes_stock then
        local restored = apply_snapshot(before, rollback_persists())
        if not restored and file_exists(BACKUP_PATH) then restored = plugin.eq_load_profile(BACKUP_PATH) end
        restore_native_state(native_before)
        if created_backup and restored then os.remove(BACKUP_PATH) end
    elseif enabled and not was_stock and becomes_stock then
        restore_native_state(native_before)
        -- Reapply the old legacy curve after returning config fields; its
        -- durable manual-EQ backup stays available for a later retry.
        if not apply_snapshot(before, rollback_persists()) then apply_profile() end
    else
        if enabled and not apply_snapshot(before, rollback_persists()) then apply_profile() end
        restore_native_state(native_before)
    end
    return false
end

-- Resets tone and width only. Crossfeed belongs to the live EQ and is kept.
local function reset_defaults()
    return commit_values(function()
        for _, a in ipairs(AXES) do values[a.key] = 0 end
    end)
end

local open_settings
local open_options
local choose_axis_range
local set_axis_range

local function encode_name(name)
    return (name:gsub(".", function(ch) return string.format("%02X", string.byte(ch)) end))
end

local function decode_name(encoded)
    if type(encoded) ~= "string" or #encoded == 0 or #encoded % 2 ~= 0 or encoded:find("[^%x]") then return nil end
    local out = {}
    for i = 1, #encoded, 2 do out[#out + 1] = string.char(tonumber(encoded:sub(i, i + 1), 16)) end
    local name = table.concat(out)
    if #name == 0 or #name > PRESET_NAME_MAX or name:find("[%c]") then return nil end
    return name
end

local function clean_preset_name(raw)
    if type(raw) ~= "string" then return nil end
    local name = raw:gsub("^%s+", ""):gsub("%s+$", "")
    if #name == 0 or #name > PRESET_NAME_MAX or name:find("[%c]") then return nil end
    return name
end

local function valid_named_preset(kv)
    if kv.format ~= "1" or (kv.curve ~= "new" and kv.curve ~= "legacy") then return false end
    if kv.range ~= "20" and kv.range ~= "40" and kv.range ~= "100" then return false end
    for _, axis in ipairs(AXES) do
        if axis_in_curve(axis, kv.curve) then
            local value = tonumber(kv[axis.key])
            if type(value) ~= "number" or value ~= value or value == math.huge or value == -math.huge
                or value < -100 or value > 100 or value % 1 ~= 0 then return false end
        end
    end
    return true
end

local function read_named_presets()
    local entries, damaged = {}, {}
    for i = 1, PRESET_LIMIT do
        local kv, found, signature = read_kv_file(named_preset_path(i))
        if found then
            local name = decode_name(kv.name_hex)
            if name and valid_named_preset(kv) then
                entries[#entries + 1] = { id = i, name = name, kv = kv, signature = signature }
            else
                damaged[#damaged + 1] = { id = i, signature = signature, name = string.format(tr("Damaged preset %d"), i) }
            end
        end
    end
    return entries, damaged
end

local function current_named_preset(entry)
    local kv, found, signature = read_kv_file(named_preset_path(entry.id))
    local name = found and decode_name(kv.name_hex) or nil
    if not name or not valid_named_preset(kv) or name ~= entry.name or signature ~= entry.signature then
        plugin.show_toast(tr("Preset changed; reopen the preset list"))
        return nil
    end
    return { id = entry.id, name = name, kv = kv, signature = signature }
end

local function preset_text(name)
    local lines = { "format=1", "name_hex=" .. encode_name(name), "curve=" .. curve,
                    "range=" .. tostring(axis_range) }
    for _, a in ipairs(AXES) do
        if axis_in_curve(a, curve) then lines[#lines + 1] = a.key .. "=" .. tostring(values[a.key]) end
    end
    return table.concat(lines, "\n") .. "\n"
end

local function write_named_preset(id, name)
    return write_atomic(named_preset_path(id), preset_text(name))
end

local function prompt_preset_name(title, initial, callback)
    if not plugin.show_text_input then
        plugin.show_toast(tr("Text input is unavailable"))
        return
    end
    local opened = plugin.show_text_input(title, initial, false, function(text)
        local name = clean_preset_name(text)
        if not name then
            plugin.show_toast(tr("Enter a short preset name without line breaks"))
            return
        end
        callback(name)
    end)
    if opened == false then plugin.show_toast(tr("Could not open name entry")) end
end

local function duplicate_preset_name(name, exclude_id)
    local wanted = name:lower()
    for _, entry in ipairs(read_named_presets()) do
        if entry.id ~= exclude_id and entry.name:lower() == wanted then return true end
    end
    return false
end

local function choose_free_preset_id()
    for i = 1, PRESET_LIMIT do
        if not file_exists(named_preset_path(i)) then return i end
    end
    return nil
end

local function save_named_preset()
    local entries = read_named_presets()
    local actions = { tr("Create new preset") }
    for _, entry in ipairs(entries) do actions[#actions + 1] = string.format(tr("Overwrite: %s"), entry.name) end
    plugin.show_list(tr("Save named preset"), actions, function(index)
        if index == 1 then
            prompt_preset_name(tr("New preset name"), "", function(name)
                if duplicate_preset_name(name) then plugin.show_toast(tr("A preset with that name already exists")); return end
                -- Re-scan after text entry: the list remains open after Return,
                -- and another create action may already have consumed its old slot.
                local free_id = choose_free_preset_id()
                if not free_id then plugin.show_toast(string.format(tr("Preset limit reached (%d)"), PRESET_LIMIT)); return end
                if write_named_preset(free_id, name) then plugin.show_toast(tr("Preset saved"))
                else plugin.show_toast(tr("Could not save preset. Try again.")) end
            end)
            return
        end
        local selected = entries[index - 1]
        if not selected then return end
        local current = current_named_preset(selected)
        if not current then return end
        plugin.show_list(tr("Overwrite preset?"), { tr("Cancel"), string.format(tr("Overwrite %s"), current.name) }, function(confirm)
            if confirm ~= 2 then return end
            local latest = current_named_preset(current)
            if not latest then return end
            if duplicate_preset_name(latest.name, latest.id) then
                plugin.show_toast(tr("A preset with that name already exists"))
                return
            end
            if write_named_preset(latest.id, latest.name) then plugin.show_toast(tr("Preset overwritten"))
            else plugin.show_toast(tr("Could not save preset. Try again.")) end
        end)
    end)
end

local function load_named_preset(entry)
    local current = current_named_preset(entry)
    if not current then return end
    local kv = current.kv
    local next_curve = curve_from_marker(kv.curve)
    if next_curve ~= "new" then
        plugin.show_toast(tr("Older MSEB controls are unsupported; preset was not loaded"))
        return
    end
    local next_range = tonumber(kv.range)
    local ok = commit_values(function()
        curve = next_curve
        axis_range = next_range
        for _, a in ipairs(AXES) do
            if axis_in_curve(a, next_curve) then values[a.key] = clamp_axis(kv[a.key])
            else values[a.key] = 0 end
        end
    end)
    plugin.show_toast(ok and tr("Preset loaded") or tr("Could not load preset. Try again."))
    if ok then open_settings({ update = true }) end
end

local function rename_named_preset(entry)
    local current = current_named_preset(entry)
    if not current then return end
    prompt_preset_name(tr("Rename preset"), current.name, function(name)
        local latest = current_named_preset(current)
        if not latest then return end
        if duplicate_preset_name(name, latest.id) then plugin.show_toast(tr("A preset with that name already exists")); return end
        local kv = latest.kv
        local lines = { "format=1", "name_hex=" .. encode_name(name), "curve=" .. kv.curve,
                        "range=" .. kv.range }
        for _, a in ipairs(AXES) do
            if kv[a.key] then lines[#lines + 1] = a.key .. "=" .. kv[a.key] end
        end
        if write_atomic(named_preset_path(latest.id), table.concat(lines, "\n") .. "\n") then
            plugin.show_toast(tr("Preset renamed"))
        else
            plugin.show_toast(tr("Could not rename preset. Try again."))
        end
    end)
end

local function delete_named_preset(entry)
    local current = current_named_preset(entry)
    if not current then return end
    plugin.show_list(tr("Delete preset?"), { tr("Cancel"), string.format(tr("Delete %s"), current.name) }, function(index)
        if index ~= 2 then return end
        local latest = current_named_preset(current)
        if not latest then return end
        if os.remove(named_preset_path(latest.id)) then plugin.show_toast(tr("Preset deleted"))
        else plugin.show_toast(tr("Could not delete preset. Try again.")) end
    end)
end

local function current_damaged_preset(entry)
    local kv, found, signature = read_kv_file(named_preset_path(entry.id))
    if not found or signature ~= entry.signature or (decode_name(kv.name_hex) and valid_named_preset(kv)) then
        plugin.show_toast(tr("Preset changed; reopen the preset list"))
        return nil
    end
    return true
end

local function delete_damaged_preset(entry)
    if not current_damaged_preset(entry) then return end
    plugin.show_list(tr("Delete damaged preset?"), { tr("Cancel"), string.format(tr("Delete file %d"), entry.id) }, function(index)
        if index ~= 2 or not current_damaged_preset(entry) then return end
        if os.remove(named_preset_path(entry.id)) then plugin.show_toast(tr("Damaged preset deleted"))
        else plugin.show_toast(tr("Could not delete preset. Try again.")) end
    end)
end

local function manage_named_preset(entry)
    local current = current_named_preset(entry)
    if not current then return end
    plugin.show_list(current.name, { tr("Load"), tr("Overwrite"), tr("Rename"), tr("Delete") }, function(index)
        local latest = current_named_preset(current)
        if not latest then return end
        if index == 1 then load_named_preset(latest)
        elseif index == 2 then
            plugin.show_list(tr("Overwrite preset?"), { tr("Cancel"), string.format(tr("Overwrite %s"), latest.name) }, function(confirm)
                if confirm ~= 2 then return end
                local confirmed = current_named_preset(latest)
                if not confirmed then return end
                if write_named_preset(confirmed.id, confirmed.name) then plugin.show_toast(tr("Preset overwritten"))
                else plugin.show_toast(tr("Could not save preset. Try again.")) end
            end)
        elseif index == 3 then rename_named_preset(latest)
        elseif index == 4 then delete_named_preset(latest) end
    end)
end

local function open_named_presets()
    local entries, damaged = read_named_presets()
    local labels, targets = {}, {}
    for _, entry in ipairs(entries) do
        labels[#labels + 1] = entry.name
        targets[#targets + 1] = { kind = "valid", entry = entry }
    end
    for _, entry in ipairs(damaged) do
        labels[#labels + 1] = string.format(tr("%s (delete to free slot)"), entry.name)
        targets[#targets + 1] = { kind = "damaged", entry = entry }
    end
    if #labels == 0 then labels[1] = tr("No named presets saved") end
    plugin.show_list(tr("Named presets"), labels, function(index)
        local target = targets[index]
        if not target then return end
        if target.kind == "valid" then manage_named_preset(target.entry)
        else delete_damaged_preset(target.entry) end
    end)
end

choose_axis_range = function(refresh)
    plugin.show_list(tr("Adjustment Range"), { "±20", "±40", "±100" }, function(index)
        set_axis_range(RANGE_VALUES[index], refresh)
    end)
end

set_axis_range = function(new_range, refresh)
    if new_range ~= 20 and new_range ~= 40 and new_range ~= 100 then return end
    if new_range == axis_range then return end
    local previous = axis_range
    axis_range = new_range
    if not write_state() then
        axis_range = previous
        plugin.show_toast(tr("Could not save range. Try again."))
        return
    end
    local outside = false
    for _, a in ipairs(AXES) do
        if axis_in_curve(a, curve) and math.abs(values[a.key]) > new_range then outside = true end
    end
    if outside then
        plugin.show_toast(tr("Range saved. Existing values kept; widen the range to edit values beyond it."))
    else
        plugin.show_toast(string.format(tr("Range set to ±%d"), new_range))
    end
    open_settings({ update = true })
    if refresh then refresh() end
end

local function save_slot(n)
    return write_kv_file(slot_path(n), false)
end

-- Pre-stock slots are rejected before state or audio changes. Current stock
-- slots carry tone and width only, so loading one leaves live crossfeed alone.
local function load_slot(n)
    local kv, found = read_kv_file(slot_path(n))
    if not found then
        plugin.show_toast(tr("Slot is empty"))
        return
    end
    local next_curve = curve_from_marker(kv.curve)
    if next_curve ~= "new" then
        plugin.show_toast(tr("Older MSEB controls are unsupported; slot was not loaded"))
        return
    end
    local ok = commit_values(function()
        curve = next_curve
        for _, a in ipairs(AXES) do
            if axis_in_curve(a, next_curve) then
                values[a.key] = kv[a.key] and clamp_axis(kv[a.key]) or 0
            else
                values[a.key] = 0
            end
        end
    end)
    plugin.show_toast(ok and tr("Slot loaded") or tr("Could not load slot. Try again."))
    if ok then open_settings({ update = true }) end
end

local function convert_to_new()
    if curve == "new" then return true end
    return commit_values(function()
        curve = "new"
        for _, a in ipairs(AXES) do
            if a.mode ~= nil then values[a.key] = 0 end
        end
    end)
end

-- Restore saved audio only after confirming this release supports its UI and
-- stock engine. Legacy settings are reapplied unchanged when their backup is
-- available; conversion is still required before the new controls appear.
if enabled and modern_mseb_ui then
    if file_exists(OTHER_EQ_OWNER_BACKUP) then
        -- Loudness Boost owns the EQ snapshot. If stock MSEB has no snapshot,
        -- simply turn off its transient override; never load the PEQ over the
        -- boost's active profile.
        local restored = true
        if file_exists(BACKUP_PATH) then
            restored = restore_backup()
        elseif curve == "new" and native_mseb() then
            restored = apply_native(false)
        end
        if restored then
            enabled = false
            if write_state() and file_exists(BACKUP_PATH) then os.remove(BACKUP_PATH) end
        end
    elseif curve == "new" and native_mseb() then
        if file_exists(BACKUP_PATH) then
            -- Upgrade from the former PEQ approximation. Restore the manual
            -- EQ once, then let stock MSEB own playback. Keep the backup until
            -- the enabled state is durably written so a failed migration can
            -- be retried on the next launch.
            local restored = load_manual_backup()
            if restored and apply_native(true) and write_state() then
                os.remove(BACKUP_PATH)
            end
        else
            -- Native state is transient across manager reloads; persisted
            -- plugin state is authoritative on each launch.
            apply_native(true)
        end
    elseif file_exists(BACKUP_PATH) then
        if not apply_profile() then
            local restored = restore_backup()
            enabled = false
            -- Keep the backup until the user's EQ is really back.
            if write_state() and restored then os.remove(BACKUP_PATH) end
        end
    else
        if curve ~= "legacy" then
            enabled = false
            write_state()
        end
    end
end

local function show_screen(title, rows, options)
    if options then
        plugin.show_settings_list(title, rows, options)
    else
        plugin.show_settings_list(title, rows)
    end
end

local open_sound_stage

local function redraw_sound_stage()
    open_sound_stage({ update = true })
end

-- Sliders report once, when the finger lifts. A cancelled drag never gets
-- here, so it changes nothing. A value that did not change writes nothing.
-- A refused change redraws the screen, so the slider shows the value that is
-- actually applied, not the one the finger left it on.
local function tone_slider(key, redraw)
    return function(v)
        local next_value = math.max(-axis_range, math.min(axis_range, clamp_axis(v)))
        if next_value == values[key] then return end
        if not commit_values(function() values[key] = next_value end) then
            plugin.show_toast(tr("Could not apply changes. Try again."))
            redraw()
        end
    end
end

local function group_rows(entries, note, redraw, refresh_range)
    local rows = {}
    local has_outside = false
    for _, e in ipairs(entries) do
        if math.abs(values[e[1]]) > axis_range then has_outside = true end
    end
    if has_outside then
        table.insert(rows, {
            type = "row",
            label = tr("Some values exceed this range. Widen it to edit them."),
            wrap = true,
            on_select = function() plugin.show_toast(tr("Stored values and sound are unchanged; widen the range to edit values outside it.")) end,
        })
    end
    if note then
        table.insert(rows, {
            type = "row",
            label = note.label,
            wrap = true,
            on_select = function()
                plugin.show_toast(note.toast)
            end,
        })
    end
    for _, e in ipairs(entries) do
        local key, label = e[1], tr(e[2])
        if math.abs(values[key]) > axis_range then
            table.insert(rows, {
                type = "row",
                label = string.format(tr("%s: %d (outside ±%d)"), label, values[key], axis_range),
                on_select = function() choose_axis_range(refresh_range) end,
            })
        else
            table.insert(rows, {
                type = "slider",
                label = label,
                min = -axis_range,
                max = axis_range,
                value = values[key],
                on_change = tone_slider(key, redraw),
            })
        end
    end
    return rows
end

-- Stereo width remains part of MSEB's state and presets. Crossfeed belongs to
-- the native Sound page and is deliberately not exposed here.
open_sound_stage = function(options)
    local rows = {
        {
            type = "row",
            label = native_mseb()
                and tr("Stock MSEB width changes the channel mix.")
                or tr("Stereo width changes the channel mix."),
            wrap = true,
            on_select = function()
                plugin.show_toast(native_mseb()
                    and tr("Width is normalized from 0.00 (mono) to 2.00 (wide), with 1.00 neutral. Mono input is unchanged.")
                    or tr("Negative narrows, positive widens with lower center level. Mono input is unchanged."))
            end,
        },
    }
    if math.abs(values.sound_stage) > axis_range then
        table.insert(rows, {
            type = "row",
            label = string.format(tr("%s: %d (outside ±%d)"), tr("Stereo Width"), values.sound_stage, axis_range),
            on_select = function() choose_axis_range(function() open_sound_stage({ update = true }) end) end,
        })
    else
        table.insert(rows, { type = "slider", label = tr("Stereo Width"), min = -axis_range, max = axis_range, value = values.sound_stage, on_change = tone_slider("sound_stage", redraw_sound_stage) })
    end
    show_screen(tr("Sound Stage"), rows, options)
end

-- The new-release UI uses the native stock ten-control layout. Legacy saved
-- curves must be explicitly converted before this screen is shown.
local STOCK_AXES = {
    { "temperature", "Overall Temperature" },
    { "bass_ext", "Bass Extension" },
    { "bass_texture", "Bass Texture" },
    { "thickness", "Note Thickness" },
    { "vocal_pos", "Vocals" },
    { "female_vocal", "Female Overtones" },
    { "sibilance_lf", "Sibilance LF" },
    { "sibilance_hf", "Sibilance HF" },
    { "impulse_tone", "Impulse Response" },
    { "air", "Air" },
}

local function refresh_mseb_pages()
    open_settings({ update = true })
end

open_options = function()
    local items = {
        tr("Adjustment Range"),
        tr("Sound Stage"),
        tr("Reset to Defaults"),
        tr("Named Presets"),
        tr("Save Named Preset"),
        tr("Save to Slot"),
        tr("Load from Slot"),
    }
    local actions = {
        function()
            choose_axis_range()
        end,
        function()
            open_sound_stage()
        end,
        function()
            if reset_defaults() then
                plugin.show_toast(tr("MSEB reset"))
                refresh_mseb_pages()
            else
                plugin.show_toast(tr("Could not reset MSEB. Try again."))
            end
        end,
        open_named_presets,
        save_named_preset,
        function()
            plugin.show_list(tr("Save to Slot"), { tr("Slot 1"), tr("Slot 2"), tr("Slot 3") }, function(index)
                if save_slot(index) then plugin.show_toast(tr("Saved to slot"))
                else plugin.show_toast(tr("Could not save slot. Try again.")) end
            end)
        end,
        function()
            plugin.show_list(tr("Load from Slot"), { tr("Slot 1"), tr("Slot 2"), tr("Slot 3") }, function(index)
                load_slot(index)
            end)
        end,
    }
    plugin.show_list(tr("MSEB Options"), items, function(index)
        local action = actions[index]
        if action then action() end
    end)
end

local LEGACY_LAYOUT_MESSAGE = "This saved layout is unsupported. Switching replaces Instrument Presence, Bass Bite, and Treble Bite with the stock controls."

local function show_legacy_confirmation(after)
    local function switch_to_stock()
        if curve ~= "legacy" then
            plugin.show_toast(tr("Stock MSEB controls are already selected"))
            return
        end
        if not convert_to_new() then
            plugin.show_toast(tr("Could not switch controls. Try again."))
            return
        end
        plugin.show_toast(tr("Stock MSEB controls selected"))
        if after then after() end
        open_settings({ update = true })
    end

    -- The native confirmation popup carries the explanation as its title and
    -- supplies its own Cancel; Cancel and the backdrop leave settings as they
    -- are. Older players fall back to the settings screen below.
    if plugin.has_capability("ui.confirmation") and plugin.show_confirmation then
        if plugin.show_confirmation(tr(LEGACY_LAYOUT_MESSAGE), tr("Switch to stock MSEB"), switch_to_stock) then
            return
        end
    end

    local rows = {
        {
            type = "row",
            label = tr(LEGACY_LAYOUT_MESSAGE),
            wrap = true,
            on_select = function()
                plugin.show_toast(tr("Switching replaces Instrument Presence, Bass Bite, and Treble Bite"))
            end,
        },
        {
            type = "row",
            label = tr("Switch to stock MSEB"),
            on_select = switch_to_stock,
        },
        {
            type = "row",
            label = tr("Cancel"),
            on_select = function()
                plugin.show_toast(tr("Kept existing MSEB settings"))
                if plugin.has_capability("ui.quick_toggle") then
                    plugin.set_quick_toggle("mseb", enabled)
                end
            end,
        },
    }
    plugin.show_settings_list(tr("MSEB"), rows, { update = true })
end

open_settings = function(options, after)
    if curve == "legacy" then
        show_legacy_confirmation(after)
        return
    end
    local rows = {
        {
            type = "toggle",
            label = tr("Enabled"),
            value = enabled,
            on_change = function(v)
                local ok, message = set_enabled(v)
                show_enabled_result(ok, message)
                if plugin.has_capability("ui.quick_toggle") then
                    plugin.set_quick_toggle("mseb", enabled)
                end
            end,
        },
        {
            type = "row",
            label = tr("Options"),
            on_select = function() open_options() end,
        },
    }

    local redraw = function() open_settings({ update = true }) end
    -- Range selection refreshes this root screen itself, so do not request a
    -- second redraw from the flat settings list.
    local flat_rows = group_rows(STOCK_AXES, nil, redraw, nil)
    for _, row in ipairs(flat_rows) do rows[#rows + 1] = row end
    plugin.show_settings_list(tr("MSEB"), rows, options)
end

if modern_mseb_ui then
    plugin.register_list_item("music_audio", tr("MSEB"), open_settings)
else
    plugin.show_toast(tr("Latest Compas firmware with stock MSEB is required"))
end

-- Quick drawer tile, mirroring the "Enabled" row above.
if modern_mseb_ui and plugin.has_capability("ui.quick_toggle") then
    plugin.register_quick_toggle("mseb", tr("MSEB"), function(on)
        if on and curve == "legacy" then
            plugin.set_quick_toggle("mseb", enabled)
            open_settings({ update = true }, function()
                local ok, message = set_enabled(true)
                show_enabled_result(ok, message)
                plugin.set_quick_toggle("mseb", enabled)
            end)
            return
        end
        local ok, message = set_enabled(on)
        show_enabled_result(ok, message)
        if not ok then
            plugin.set_quick_toggle("mseb", enabled)
        end
    end, {
        icon = "pull_down/mseb.png",
        value = enabled,
        on_hold = open_settings,
    })
end
