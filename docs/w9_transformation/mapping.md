Kundendaten – Mapping-Matrix
| Zielattribut | Datentyp | Juckstadt   | Waldrand      | Schmidt   | Bergblick       | Transformation                                   |
| ------------ | -------- | ----------- | ------------- | --------- | --------------- | ------------------------------------------------ |
| quell_id     | String   | kunden_nr   | customer_id   | kunden_id | patient_id      | keine                                            |
| anrede       | String   | anrede      | -             | anrede    | anrede          | Hr. → Herr, Fr. → Frau                           |
| vorname      | String   | vorname     | first_name    | vorname   | name            | Vollname aufteilen                               |
| nachname     | String   | nachname    | last_name     | nachname  | name            | Vollname aufteilen                               |
| strasse      | String   | strasse     | street        | strasse   | adresse/strasse | Schreibweisen vereinheitlichen                   |
| plz          | String   | plz         | zip_code      | plz       | adresse/plz     | keine                                            |
| ort          | String   | ort         | city          | ort       | adresse/ort     | keine                                            |
| telefon_raw  | String   | telefon     | phone         | tel       | telefon         | unverändert übernehmen                           |
| telefon_norm | String   | telefon     | phone         | tel       | telefon         | Sonderzeichen entfernen, Format vereinheitlichen |
| email        | String   | email       | email_address | email     | email           | NULL-Werte behandeln                             |
| angelegt_am  | Date     | angelegt_am | created_at    | erfasst   | erfasst         | ISO-Format YYYY-MM-DD                            |
| quelle       | String   | konstant    | konstant      | konstant  | konstant        | Herkunft dokumentieren                           |
| quell_zeile  | Integer  | erzeugt     | erzeugt       | erzeugt   | erzeugt         | technische Metadaten                             |
| quell_datei  | String   | Dateiname   | Dateiname     | Dateiname | Dateiname       | technische Metadaten                             |

---

## Tierdaten – Mapping-Matrix

| Zielattribut | Datentyp | Juckstadt    | Waldrand    | Schmidt   | Bergblick | Transformation          |
| ------------ | -------- | ------------ | ----------- | --------- | --------- | ----------------------- |
| tier_name    | String   | patient_name | animal_name | tier.name | tier/name | keine                   |
| tierart_raw  | String   | tierart      | species     | tier.art  | tier/art  | Rohwert übernehmen      |
| tierart      | String   | tierart      | species     | tier.art  | tier/art  | dog → Hund, cat → Katze |
| quelle       | String   | konstant     | konstant    | konstant  | konstant  | Herkunft dokumentieren  |


---

## Behandlungsdaten – Mapping-Matrix

| Zielattribut    | Datentyp | Juckstadt      | Waldrand       | Schmidt   | Bergblick  | Transformation               |
| --------------- | -------- | -------------- | -------------- | --------- | ---------- | ---------------------------- |
| behandlung_id   | String   | beh_nr         | treatment_id   | id        | -          | keine                        |
| kunde_ref       | String   | kunde_nachname | customer_id    | kunde     | patient_id | Referenz auf Kundendatensatz |
| datum_raw       | String   | datum          | treatment_date | datum     | datum      | Rohwert übernehmen           |
| datum           | Date     | datum          | treatment_date | datum     | datum      | ISO-Format YYYY-MM-DD        |
| diagnose        | String   | diagnose       | diagnosis      | leistung  | diagnose   | vereinheitlichte Bezeichnung |
| kosten_euro_raw | String   | kosten_euro    | total_eur      | betrag    | brutto_raw | Rohwert übernehmen           |
| kosten_euro     | Decimal  | kosten_euro    | total_eur      | betrag    | brutto_eur | numerisches Format           |
| netto_raw       | String   | -              | -              | -         | netto_raw  | keine                        |
| netto_eur       | Decimal  | -              | -              | -         | netto_eur  | numerisches Format           |
| brutto_raw      | String   | -              | -              | -         | brutto_raw | keine                        |
| brutto_eur      | Decimal  | -              | -              | -         | brutto_eur | numerisches Format           |
| quelle          | String   | konstant       | konstant       | konstant  | konstant   | Herkunft dokumentieren       |
| quell_zeile     | Integer  | erzeugt        | erzeugt        | erzeugt   | erzeugt    | technische Metadaten         |
| quell_datei     | String   | Dateiname      | Dateiname      | Dateiname | Dateiname  | technische Metadaten         |

