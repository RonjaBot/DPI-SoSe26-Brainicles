CREATE SCHEMA IF NOT EXISTS transform;

CREATE OR REPLACE TABLE transform.norm_wald_behandlungen AS
SELECT
    'wald' AS quelle,
    treatment_id AS behandlung_id,
    customer_id AS kunde_ref,
    animal_name AS tier_name,

    species AS tierart_raw,
    CASE
        WHEN lower(species) = 'dog' THEN 'Hund'
        WHEN lower(species) = 'cat' THEN 'Katze'
        ELSE species
    END AS tierart,

    treatment_date AS datum,
    diagnosis AS diagnose,
    total_eur AS kosten_euro,

    quell_zeile,
    quell_datei
FROM staging.wald_behandlungen;

