CREATE SCHEMA IF NOT EXISTS transform;

CREATE OR REPLACE TABLE transform.norm_behandlung AS
SELECT
    quelle,
    behandlung_id,
    kunde_ref,
    tier_name,
    tierart_raw,
    tierart,
    datum_raw,
    datum,
    diagnose,
    kosten_euro,
    CAST(NULL AS DOUBLE) AS kosten_netto,
    CAST(NULL AS DOUBLE) AS kosten_brutto,
    quell_zeile,
    quell_datei
FROM transform.norm_juck_behandlungen

UNION ALL

SELECT
    quelle,
    behandlung_id,
    kunde_ref,
    tier_name,
    tierart_raw,
    tierart,
    CAST(datum AS VARCHAR) AS datum_raw,
    datum,
    diagnose,
    kosten_euro,
    CAST(NULL AS DOUBLE) AS kosten_netto,
    CAST(NULL AS DOUBLE) AS kosten_brutto,
    quell_zeile,
    quell_datei
FROM transform.norm_wald_behandlungen

UNION ALL

SELECT
    quelle,
    behandlung_id,
    kunde_ref,
    tier_name,
    tierart_raw,
    tierart,
    datum_raw,
    datum,
    diagnose,
    kosten_euro,
    CAST(NULL AS DOUBLE) AS kosten_netto,
    CAST(NULL AS DOUBLE) AS kosten_brutto,
    quell_zeile,
    quell_datei
FROM transform.norm_schm_behandlungen

UNION ALL

SELECT
    quelle,
    behandlung_id,
    kunde_ref,
    tier_name,
    tierart_raw,
    tierart,
    datum_raw,
    datum,
    diagnose,
    kosten_euro,
    kosten_netto,
    kosten_brutto,
    quell_zeile,
    quell_datei
FROM transform.norm_berg_behandlungen;

