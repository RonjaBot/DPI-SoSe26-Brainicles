CREATE OR REPLACE TABLE final.kunde_nodes AS
SELECT DISTINCT
    quelle || ':' || quell_id AS kunde_key,
    quelle,
    quell_id
FROM transform.norm_kunde;

CREATE OR REPLACE TABLE final.kunde_edges AS
SELECT
    quelle_a || ':' || id_a AS source_key,
    quelle_b || ':' || id_b AS target_key
FROM final.matches

UNION ALL

SELECT
    quelle_b || ':' || id_b AS source_key,
    quelle_a || ':' || id_a AS target_key
FROM final.matches;

CREATE OR REPLACE TABLE final.kunde_components AS
WITH RECURSIVE reach(root_key, kunde_key) AS (
    SELECT
        kunde_key AS root_key,
        kunde_key AS kunde_key
    FROM final.kunde_nodes

    UNION

    SELECT
        r.root_key,
        e.target_key
    FROM reach r
    JOIN final.kunde_edges e
        ON r.kunde_key = e.source_key
)
SELECT
    kunde_key,
    MIN(root_key) AS component_key
FROM reach
GROUP BY kunde_key;

CREATE OR REPLACE TABLE final.kunde_mapping AS
SELECT
    n.quelle,
    n.quell_id,
    DENSE_RANK() OVER (ORDER BY c.component_key) AS final_kunde_id
FROM final.kunde_components c
JOIN final.kunde_nodes n
    ON c.kunde_key = n.kunde_key;
