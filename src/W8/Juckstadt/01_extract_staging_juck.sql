-- Juckstadt Kunden

DROP TABLE IF EXISTS staging.juck_kunden;

CREATE TABLE staging.juck_kunden AS
SELECT
    *,
    row_number() OVER () AS quell_zeile,
    'praxis_juckstadt_kunden.csv' AS quell_datei
FROM read_csv(
    'fallstudie_datenmanagement_master/verbund/praxis_juckstadt_kunden.csv',
    sep=';',
    header=true,
    all_varchar=true
);

-- Juckstadt Behandlungen

DROP TABLE IF EXISTS staging.juck_behandlungen;

CREATE TABLE staging.juck_behandlungen AS
SELECT
    *,
    row_number() OVER () AS quell_zeile,
    'praxis_juckstadt_behandlungen.csv' AS quell_datei
FROM read_csv(
    'fallstudie_datenmanagement_master/verbund/praxis_juckstadt_behandlungen.csv',
    sep=';',
    header=true,
    all_varchar=true
);