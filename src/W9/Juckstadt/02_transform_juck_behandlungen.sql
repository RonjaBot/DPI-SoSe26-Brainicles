CREATE SCHEMA IF NOT EXISTS transform;

CREATE OR REPLACE TABLE transform.norm_juck_behandlungen AS
SELECT
    'juck' AS quelle,
    beh_nr AS behandlung_id,
    kunde_nachname AS kunde_ref,
    patient_name AS tier_name,
    CAST(NULL AS VARCHAR) AS tierart_raw,
    CAST(NULL AS VARCHAR) AS tierart,
    datum AS datum_raw,
    try_strptime(datum, '%Y-%m-%d')::DATE AS datum,
    diagnose,
    replace(kosten_euro, ',', '.')::DOUBLE AS kosten_euro,
    quell_zeile,
    quell_datei
FROM staging.juck_behandlungen;
