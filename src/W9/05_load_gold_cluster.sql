CREATE SCHEMA IF NOT EXISTS transform;

CREATE OR REPLACE TABLE transform.gold_cluster AS
SELECT *
FROM read_csv(
    './fallstudie_datenmanagement_master/verbund/gold_cluster.csv',
    header=true,
    all_varchar=true
);
