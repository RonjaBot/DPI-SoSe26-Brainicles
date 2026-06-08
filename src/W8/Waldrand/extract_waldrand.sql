CREATE OR REPLACE TABLE staging.wald_kunden AS
SELECT
    *,
    row_number() OVER () AS quell_zeile,
    'praxis_waldrand_kunden.csv' AS quell_datei
FROM read_csv_auto('fallstudie_datenmanagement_master/verbund/praxis_waldrand_kunden.csv');

CREATE OR REPLACE TABLE staging.wald_behandlungen AS
SELECT
    *,
    row_number() OVER () AS quell_zeile,
    'praxis_waldrand_behandlungen.csv' AS quell_datei
FROM read_csv_auto('fallstudie_datenmanagement_master/verbund/praxis_waldrand_behandlungen.csv');
