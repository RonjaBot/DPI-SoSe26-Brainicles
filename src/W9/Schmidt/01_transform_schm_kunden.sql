CREATE SCHEMA IF NOT EXISTS transform;

CREATE OR REPLACE TABLE transform.norm_schm_kunden AS
SELECT
    'schm' AS quelle,
    CAST(row_number() OVER () AS VARCHAR) AS quell_id,
    CASE
        WHEN anrede = 'Hr.' THEN 'Herr'
        WHEN anrede = 'Fr.' THEN 'Frau'
        ELSE anrede
    END AS anrede,
    vorname,
    nachname,
    strasse,
    plz,
    ort,
    tel AS telefon_raw,
    regexp_replace(tel, '[^0-9]', '', 'g') AS telefon_norm,
    email,
    erfasst AS angelegt_am_raw,
    try_strptime(erfasst, '%d.%m.%Y')::DATE AS angelegt_am,
    CAST(NULL AS VARCHAR) AS marketing_consent,
    CAST(NULL AS BIGINT) AS quell_zeile,
    'praxis_schmidt_kunden.csv' AS quell_datei
FROM staging.schm_kunden;
