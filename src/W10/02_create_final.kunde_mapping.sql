CREATE OR REPLACE TABLE final.kunde_mapping AS
SELECT
    quelle,
    quell_id,
    cluster_id AS final_kunde_id
FROM transform.norm_kunde_with_gold;
