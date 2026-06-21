CREATE SCHEMA IF NOT EXISTS transform;

CREATE OR REPLACE TABLE transform.norm_schm_behandlungen AS
SELECT
    'schm' AS quelle,
    CAST(id AS VARCHAR) AS behandlung_id,
    kunde AS kunde_ref,
    tier_name,
    tier_art AS tierart_raw,
    tier_art AS tierart,
    datum AS datum_raw,
    try_strptime(datum, '%d.%m.%Y')::DATE AS datum,
    leistung AS diagnose,
    replace(replace(betrag, ' EUR', ''), ',', '.')::DOUBLE AS kosten_euro,
    CAST(NULL AS BIGINT) AS quell_zeile,
    'praxis_schmidt_behandlungen.json' AS quell_datei
FROM staging.schm_behandlungen;
