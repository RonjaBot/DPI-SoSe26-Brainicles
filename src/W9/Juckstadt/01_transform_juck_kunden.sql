CREATE SCHEMA IF NOT EXISTS transform;

CREATE OR REPLACE TABLE transform.norm_juck_kunden AS
SELECT
    'juck' AS quelle,
    kunden_nr AS quell_id,
    anrede,
    vorname,
    nachname,
    strasse,
    plz,
    ort,
    telefon AS telefon_raw,
    regexp_replace(telefon, '[^0-9]', '', 'g') AS telefon_norm,
    email,
    angelegt_am AS angelegt_am_raw,
    try_strptime(angelegt_am, '%Y-%m-%d')::DATE AS angelegt_am,
    CAST(NULL AS VARCHAR) AS marketing_consent,
    quell_zeile,
    quell_datei
FROM staging.juck_kunden;
