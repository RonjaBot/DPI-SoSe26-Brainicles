CREATE SCHEMA IF NOT EXISTS transform;

CREATE OR REPLACE TABLE transform.norm_berg_patienten AS
SELECT
    'berg' AS quelle,
    patient_id AS quell_id,
    halter_anrede AS anrede,
    split_part(halter_name, ' ', 1) AS vorname,
    substr(halter_name, length(split_part(halter_name, ' ', 1)) + 2) AS nachname,
    strasse,
    plz,
    ort,
    telefon AS telefon_raw,
    regexp_replace(telefon, '[^0-9]', '', 'g') AS telefon_norm,
    email,
    halter_erfasst AS angelegt_am_raw,
    try_strptime(halter_erfasst, '%Y-%m-%d')::DATE AS angelegt_am,
    CAST(NULL AS VARCHAR) AS marketing_consent,
    CAST(quell_zeile AS BIGINT) AS quell_zeile,
    quell_datei,
    tier_name,
    tier_art AS tierart,
    try_strptime(tier_geburt, '%Y-%m-%d')::DATE AS tier_geburt
FROM staging.berg_patienten;
