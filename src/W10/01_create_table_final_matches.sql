CREATE SCHEMA IF NOT EXISTS final;

CREATE OR REPLACE TABLE final.matches AS
SELECT *
FROM transform.match_scored_similarity_v2
WHERE predicted_match = 1;
