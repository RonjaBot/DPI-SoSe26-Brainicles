CREATE OR REPLACE TABLE transform.match_candidates AS
SELECT
    a.quelle AS quelle_a,
    a.quell_id AS id_a,
    b.quelle AS quelle_b,
    b.quell_id AS id_b,

    a.vorname AS vorname_a,
    b.vorname AS vorname_b,

    a.nachname AS nachname_a,
    b.nachname AS nachname_b,

    a.email,
    a.telefon_norm,

    a.cluster_id AS cluster_a,
    b.cluster_id AS cluster_b,

    CASE
        WHEN a.cluster_id = b.cluster_id THEN 1
        ELSE 0
    END AS true_match

FROM transform.norm_kunde_with_gold a
JOIN transform.norm_kunde_with_gold b
    ON a.quelle < b.quelle
   AND (
        (a.email IS NOT NULL AND a.email = b.email)
        OR
        (a.telefon_norm IS NOT NULL
         AND a.telefon_norm = b.telefon_norm)
   );
