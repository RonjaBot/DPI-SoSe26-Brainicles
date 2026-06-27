CREATE OR REPLACE TABLE transform.match_scored_similarity_v2 AS
WITH scored AS (
    SELECT
        *,
        CASE
            WHEN telefon_match = 1
             AND nachname_similarity >= 0.85
             AND strasse_similarity >= 0.80
            THEN 1

            WHEN score >= 55
            THEN 1

            ELSE 0
        END AS predicted_match_new
    FROM transform.match_scored_similarity
)
SELECT
    * EXCLUDE (predicted_match),
    predicted_match_new AS predicted_match
FROM scored;

WITH metrics AS (
    SELECT
        COUNT(*) AS kandidatenpaare,
        SUM(CASE WHEN predicted_match = 1 AND true_match = 1 THEN 1 ELSE 0 END) AS tp,
        SUM(CASE WHEN predicted_match = 1 AND true_match = 0 THEN 1 ELSE 0 END) AS fp,
        SUM(CASE WHEN predicted_match = 0 AND true_match = 1 THEN 1 ELSE 0 END) AS fn
    FROM transform.match_scored_similarity_v2
)
SELECT
    kandidatenpaare,
    tp AS true_positives,
    fp AS false_positives,
    fn AS false_negatives,
    ROUND(tp::DOUBLE / (tp + fp), 4) AS precision,
    ROUND(tp::DOUBLE / (tp + fn), 4) AS recall,
    ROUND(
        2 * (tp::DOUBLE / (tp + fp)) * (tp::DOUBLE / (tp + fn))
        /
        ((tp::DOUBLE / (tp + fp)) + (tp::DOUBLE / (tp + fn))),
        4
    ) AS f1_score
FROM metrics;
