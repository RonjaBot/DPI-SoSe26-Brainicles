# Data Dictionary

## Ziel des Data Dictionary

Dieses Data Dictionary dokumentiert die relevanten Felder der verschiedenen Quelldateien des VetKliniken-Verbunds und ordnet sie gemeinsamen Zielattributen zu. Es dient als Grundlage für die spätere Harmonisierung im Transform-Layer der ETL-Pipeline.

---

# Kundendaten / Halterdaten

| Quelle    | Originalfeld | Bedeutung       | Zielattribut | Auffälligkeit             |
| --------- | ------------ | --------------- | ------------ | ------------------------- |
| Juckstadt | kunden_nr    | Kunden-ID       | quell_id     | numerische ID             |
| Juckstadt | anrede       | Anrede          | anrede       | Werte: Herr/Frau          |
| Juckstadt | vorname      | Vorname         | vorname      | deutsch                   |
| Juckstadt | nachname     | Nachname        | nachname     | wiederholte Nachnamen     |
| Juckstadt | strasse      | Straße          | strasse      | mögliche Schreibvarianten |
| Juckstadt | plz          | Postleitzahl    | plz          | numerisch                 |
| Juckstadt | ort          | Ort             | ort          | wiederkehrende Orte       |
| Juckstadt | telefon      | Telefonnummer   | telefon      | deutsches Lokalformat     |
| Juckstadt | email        | E-Mail-Adresse  | email        | 21 fehlende Werte         |
| Juckstadt | angelegt_am  | Erfassungsdatum | angelegt_am  | Datumsformat prüfen       |

| Quelle   | Originalfeld      | Bedeutung              | Zielattribut      | Auffälligkeit          |
| -------- | ----------------- | ---------------------- | ----------------- | ---------------------- |
| Waldrand | customer_id       | Kunden-ID              | quell_id          | englische Feldnamen    |
| Waldrand | first_name        | Vorname                | vorname           | englisch               |
| Waldrand | last_name         | Nachname               | nachname          | 1 NULL-Wert            |
| Waldrand | street            | Straße                 | strasse           | englisch               |
| Waldrand | zip_code          | Postleitzahl           | plz               | numerisch              |
| Waldrand | city              | Ort                    | ort               | englisch               |
| Waldrand | phone             | Telefonnummer          | telefon           | uneinheitliche Formate |
| Waldrand | email_address     | E-Mail-Adresse         | email             | 50 NULL-Werte          |
| Waldrand | created_at        | Erfassungsdatum        | angelegt_am       | MM/DD/YYYY             |
| Waldrand | marketing_consent | Marketing-Einwilligung | marketing_consent | BOOLEAN                |

| Quelle  | Originalfeld | Bedeutung       | Zielattribut | Auffälligkeit            |
| ------- | ------------ | --------------- | ------------ | ------------------------ |
| Schmidt | nachname     | Nachname        | nachname     | wiederkehrende Werte     |
| Schmidt | vorname      | Vorname         | vorname      | teilweise abgekürzt      |
| Schmidt | anrede       | Anrede          | anrede       | Hr./Fr.                  |
| Schmidt | plz          | Postleitzahl    | plz          | numerisch                |
| Schmidt | ort          | Ort             | ort          | wiederkehrend            |
| Schmidt | strasse      | Straße          | strasse      | Schreibvarianten möglich |
| Schmidt | tel          | Telefonnummer   | telefon      | Leerzeichen enthalten    |
| Schmidt | email        | E-Mail-Adresse  | email        | fehlende Werte           |
| Schmidt | erfasst      | Erfassungsdatum | angelegt_am  | TT.MM.JJJJ               |

| Quelle    | Originalfeld    | Bedeutung          | Zielattribut     | Auffälligkeit       |
| --------- | --------------- | ------------------ | ---------------- | ------------------- |
| Bergblick | patient id      | Patienten-ID       | quell_id         | XML-Attribut        |
| Bergblick | anrede          | Anrede             | anrede           | XML-Element         |
| Bergblick | name            | Vollständiger Name | vorname/nachname | nicht getrennt      |
| Bergblick | telefon         | Telefonnummer      | telefon          | XML-Element mit Typ |
| Bergblick | email           | E-Mail-Adresse     | email            | verschachtelt       |
| Bergblick | adresse/strasse | Straße             | strasse          | XML-Struktur        |
| Bergblick | adresse/plz     | Postleitzahl       | plz              | XML-Struktur        |
| Bergblick | adresse/ort     | Ort                | ort              | XML-Struktur        |
| Bergblick | erfasst         | Erfassungsdatum    | angelegt_am      | ISO-Format          |

---

# Tierdaten

| Quelle   | Originalfeld | Bedeutung | Zielattribut | Auffälligkeit  |
| -------- | ------------ | --------- | ------------ | -------------- |
| Waldrand | animal_name  | Tiername  | tier_name    | englisch       |
| Waldrand | species      | Tierart   | tierart      | Werte: cat/dog |

| Quelle  | Originalfeld | Bedeutung | Zielattribut | Auffälligkeit         |
| ------- | ------------ | --------- | ------------ | --------------------- |
| Schmidt | tier.name    | Tiername  | tier_name    | JSON Nested Structure |
| Schmidt | tier.art     | Tierart   | tierart      | Werte: Hund/Katze     |

| Quelle    | Originalfeld | Bedeutung         | Zielattribut | Auffälligkeit   |
| --------- | ------------ | ----------------- | ------------ | --------------- |
| Bergblick | tier/name    | Tiername          | tier_name    | XML-Element     |
| Bergblick | tier/art     | Tierart           | tierart      | bereits deutsch |
| Bergblick | tier/geburt  | Geburtsdatum Tier | tier_geburt  | ISO-Format      |

---

# Behandlungsdaten

| Quelle    | Originalfeld   | Bedeutung         | Zielattribut  | Auffälligkeit                 |
| --------- | -------------- | ----------------- | ------------- | ----------------------------- |
| Juckstadt | beh_nr         | Behandlungs-ID    | behandlung_id | numerische ID                 |
| Juckstadt | datum          | Behandlungsdatum  | datum         | Datumsformat prüfen           |
| Juckstadt | patient_name   | Tiername          | tier_name     | wiederkehrende Werte          |
| Juckstadt | kunde_nachname | Kundenreferenz    | nachname      | keine eindeutige ID           |
| Juckstadt | diagnose       | Diagnose          | diagnose      | Freitext                      |
| Juckstadt | kosten_euro    | Behandlungskosten | kosten_euro   | deutsches Dezimaltrennzeichen |

| Quelle   | Originalfeld   | Bedeutung         | Zielattribut    | Auffälligkeit            |
| -------- | -------------- | ----------------- | --------------- | ------------------------ |
| Waldrand | treatment_id   | Behandlungs-ID    | behandlung_id   | englische Feldnamen      |
| Waldrand | customer_id    | Kundenreferenz    | quell_kunden_id | Verweis auf Kunde        |
| Waldrand | animal_name    | Tiername          | tier_name       | englisch                 |
| Waldrand | species        | Tierart           | tierart         | cat/dog                  |
| Waldrand | treatment_date | Behandlungsdatum  | datum           | ISO-Format               |
| Waldrand | diagnosis      | Diagnose          | diagnose        | Freitext                 |
| Waldrand | total_eur      | Behandlungskosten | kosten_euro     | Punkt als Dezimaltrenner |

| Quelle  | Originalfeld | Bedeutung         | Zielattribut  | Auffälligkeit         |
| ------- | ------------ | ----------------- | ------------- | --------------------- |
| Schmidt | id           | Behandlungs-ID    | behandlung_id | JSON-Struktur         |
| Schmidt | datum        | Behandlungsdatum  | datum         | TT.MM.JJJJ            |
| Schmidt | kunde        | Kundenreferenz    | kunde         | teilweise abgekürzt   |
| Schmidt | leistung     | Diagnose/Leistung | diagnose      | standardisierte Werte |
| Schmidt | betrag       | Behandlungskosten | kosten_euro   | Text mit „EUR“        |
| Schmidt | tier.name    | Tiername          | tier_name     | verschachtelt         |
| Schmidt | tier.art     | Tierart           | tierart       | deutsch               |

| Quelle    | Originalfeld | Bedeutung         | Zielattribut    | Auffälligkeit          |
| --------- | ------------ | ----------------- | --------------- | ---------------------- |
| Bergblick | patientId    | Patientenreferenz | quell_kunden_id | XML-Attribut           |
| Bergblick | datum        | Behandlungsdatum  | datum           | XML-Attribut           |
| Bergblick | diagnose     | Diagnose          | diagnose        | teilweise ohne Umlaute |
| Bergblick | summe@netto  | Nettobetrag       | kosten_netto    | XML-Attribut           |
| Bergblick | summe@brutto | Bruttobetrag      | kosten_brutto   | XML-Attribut           |

---

# Harmonisierungshinweise

| Bereich        | Problem                                                | Ziel                                          |
| -------------- | ------------------------------------------------------ | --------------------------------------------- |
| IDs            | Jede Praxis verwendet eigene IDs                       | Ergänzung von `quelle` und `quell_id`         |
| Namen          | Vor-/Nachname teilweise getrennt, teilweise kombiniert | Vereinheitlichung in `vorname` und `nachname` |
| Telefonnummern | Unterschiedliche Formate und Schreibweisen             | Normalisierung auf E.164                      |
| Datum          | Unterschiedliche Datumsformate                         | ISO-8601                                      |
| Tierarten      | Deutsch und Englisch gemischt                          | Einheitliche deutsche Werte                   |
| Beträge        | Komma/Punkt bzw. EUR-Strings                           | Numerische Standardisierung                   |
| Diagnosen      | Unterschiedliche Schreibweisen/Freitext                | Harmonisierung                                |
| JSON/XML       | Verschachtelte Strukturen                              | Flattening für Staging                        |
| XML            | Namespace erforderlich                                 | Namespace-aware Parsing                       |
| Dubletten      | Wiederkehrende Namen/Tiernamen                         | Fuzzy Matching / Clusterbildung               |
