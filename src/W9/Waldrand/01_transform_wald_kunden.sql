CREATE SCHEMA IF NOT EXISTS transform;

CREATE OR REPLACE TABLE transform.norm_wald_kunden AS
SELECT
    'wald' AS quelle,
    customer_id AS quell_id,
    first_name AS vorname,
    last_name AS nachname,
    street AS strasse,
    CAST(zip_code AS VARCHAR) AS plz,
    city AS ort,

    phone AS telefon_raw,
    regexp_replace(phone, '[^0-9]', '', 'g') AS telefon_norm,

    email_address AS email,
    created_at AS angelegt_am_raw,
    try_strptime(created_at, '%m/%d/%Y')::DATE AS angelegt_am,

    CAST(marketing_consent AS VARCHAR) AS marketing_consent,

    quell_zeile,
    quell_datei
FROM staging.wald_kunden;

