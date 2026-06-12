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
