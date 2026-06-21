CREATE OR REPLACE TABLE transform.norm_kunde_with_gold AS
SELECT
    k.*,
    g.cluster_id
FROM transform.norm_kunde k
LEFT JOIN transform.gold_cluster g
    ON upper(k.quelle) = g.praxis
   AND k.quell_id = g.quell_id;

