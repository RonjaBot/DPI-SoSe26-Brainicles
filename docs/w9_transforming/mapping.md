## Kundendaten – Mapping-Matrix



| Zielattribut      | Datentyp | Juckstadt   | Waldrand          | Schmidt  | Bergblick       | Transformation                 |

| ----------------- | -------- | ----------- | ----------------- | -------- | --------------- | ------------------------------ |

| quell_id          | String   | kunden_nr   | customer_id       | -        | patient id      | keine                          |

| anrede            | String   | anrede      | -                 | anrede   | anrede          | Hr.→Herr, Fr.→Frau             |

| vorname           | String   | vorname     | first_name        | vorname  | name            | Vollname aufteilen             |

| nachname          | String   | nachname    | last_name         | nachname | name            | Vollname aufteilen             |

| strasse           | String   | strasse     | street            | strasse  | adresse/strasse | Schreibweisen vereinheitlichen |

| plz               | String   | plz         | zip_code          | plz      | adresse/plz     | keine                          |

| ort               | String   | ort         | city              | ort      | adresse/ort     | keine                          |

| telefon           | String   | telefon     | phone             | tel      | telefon         | Format normalisieren           |

| email             | String   | email       | email_address     | email    | email           | NULL-Werte behandeln           |

| angelegt_am       | Date     | angelegt_am | created_at        | erfasst  | erfasst         | ISO-Format YYYY-MM-DD          |

| marketing_consent | Boolean  | -           | marketing_consent | -        | -               | keine                          |



---



## Tierdaten – Mapping-Matrix



| Zielattribut | Datentyp | Waldrand    | Schmidt   | Bergblick   | Transformation      |

| ------------ | -------- | ----------- | --------- | ----------- | ------------------- |

| tier_name    | String   | animal_name | tier.name | tier/name   | keine               |

| tierart      | String   | species     | tier.art  | tier/art    | dog→Hund, cat→Katze |

| tier_geburt  | Date     | -           | -         | tier/geburt | ISO-Format          |



---



## Behandlungsdaten – Mapping-Matrix



| Zielattribut  | Datentyp | Juckstadt      | Waldrand       | Schmidt   | Bergblick    | Transformation             |

| ------------- | -------- | -------------- | -------------- | --------- | ------------ | -------------------------- |

| behandlung_id | String   | beh_nr         | treatment_id   | id        | -            | keine                      |

| datum         | Date     | datum          | treatment_date | datum     | datum        | ISO-Format                 |

| diagnose      | String   | diagnose       | diagnosis      | leistung  | diagnose     | Standardisierung möglich   |

| kosten_euro   | Decimal  | kosten_euro    | total_eur      | betrag    | -            | Komma/Punkt, EUR entfernen |

| kosten_netto  | Decimal  | -              | -              | -         | summe@netto  | keine                      |

| kosten_brutto | Decimal  | -              | -              | -         | summe@brutto | keine                      |

| kunde_ref     | String   | kunde_nachname | customer_id    | kunde     | patientId    | Matching notwendig         |

| tier_name     | String   | patient_name   | animal_name    | tier.name | -            | keine                      |



---


