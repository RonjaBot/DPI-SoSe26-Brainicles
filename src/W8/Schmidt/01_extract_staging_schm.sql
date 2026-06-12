-- Schmidt Kunden

DROP TABLE IF EXISTS staging.schm_kunden;

CREATE TABLE staging.schm_kunden AS
         SELECT *
         FROM read_csv(
             'fallstudie_datenmanagement_master/verbund/praxis_schmidt_kunden.csv',
             delim='|',
             header=true,
             all_varchar=true
         );

-- Schmidt Behandlungen

DROP TABLE IF EXISTS staging.schm_behandlungen_unflat;
CREATE TABLE staging.schm_behandlungen_unflat AS

         SELECT *

         FROM read_json_auto(
             'fallstudie_datenmanagement_master/verbund/praxis_schmidt_behandlungen.json',
             format='auto'
         );

DROP TABLE IF EXISTS staging.schm_behandlungen;
CREATE TABLE staging.schm_behandlungen AS 

SELECT

    id,
    datum,
    kunde,
    tier.name AS tier_name,
    tier.art AS tier_art,
    leistung,
    betrag

FROM staging.schm_behandlungen_unflat
         ;
