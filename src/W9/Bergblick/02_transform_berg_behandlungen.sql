CREATE SCHEMA IF NOT EXISTS transform;

CREATE OR REPLACE TABLE transform.norm_berg_behandlungen AS
SELECT
    'berg' AS quelle,
    CAST(NULL AS VARCHAR) AS behandlung_id,
    patient_id AS kunde_ref,
    CAST(NULL AS VARCHAR) AS tier_name,
    CAST(NULL AS VARCHAR) AS tierart_raw,
    CAST(NULL AS VARCHAR) AS tierart,
    datum AS datum_raw,
    try_strptime(datum, '%Y-%m-%d')::DATE AS datum,
    diagnose,
    CAST(brutto AS DOUBLE) AS kosten_euro,
    CAST(netto AS DOUBLE) AS kosten_netto,
    CAST(brutto AS DOUBLE) AS kosten_brutto,
    CAST(quell_zeile AS BIGINT) AS quell_zeile,
    quell_datei
FROM staging.berg_behandlungen;
