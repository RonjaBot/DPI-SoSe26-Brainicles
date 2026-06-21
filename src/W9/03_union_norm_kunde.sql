CREATE SCHEMA IF NOT EXISTS transform;

CREATE OR REPLACE TABLE transform.norm_kunde AS
SELECT
    quelle,
    quell_id,
    anrede,
    vorname,
    nachname,
    strasse,
    plz,
    ort,
    telefon_raw,
    telefon_norm,
    email,
    angelegt_am_raw,
    angelegt_am,
    marketing_consent,
    quell_zeile,
    quell_datei
FROM transform.norm_juck_kunden

UNION ALL

SELECT
    quelle,
    quell_id,
    CAST(NULL AS VARCHAR) AS anrede,
    vorname,
    nachname,
    strasse,
    plz,
    ort,
    telefon_raw,
    telefon_norm,
    email,
    angelegt_am_raw,
    angelegt_am,
    marketing_consent,
    quell_zeile,
    quell_datei
FROM transform.norm_wald_kunden

UNION ALL

SELECT
    quelle,
    quell_id,
    anrede,
    vorname,
    nachname,
    strasse,
    plz,
    ort,
    telefon_raw,
    telefon_norm,
    email,
    angelegt_am_raw,
    angelegt_am,
    marketing_consent,
    quell_zeile,
    quell_datei
FROM transform.norm_schm_kunden

UNION ALL

SELECT
    quelle,
    quell_id,
    anrede,
    vorname,
    nachname,
    strasse,
    plz,
    ort,
    telefon_raw,
    telefon_norm,
    email,
    angelegt_am_raw,
    angelegt_am,
    marketing_consent,
    quell_zeile,
    quell_datei
FROM transform.norm_berg_patienten;

