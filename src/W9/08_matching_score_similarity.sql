CREATE OR REPLACE TABLE transform.match_scored_similarity AS
SELECT
    a.quelle AS quelle_a,
    a.quell_id AS id_a,
    b.quelle AS quelle_b,
    b.quell_id AS id_b,

    a.vorname AS vorname_a,
    b.vorname AS vorname_b,
    a.nachname AS nachname_a,
    b.nachname AS nachname_b,
    a.strasse AS strasse_a,
    b.strasse AS strasse_b,

    a.email AS email_a,
    b.email AS email_b,
    a.telefon_norm AS telefon_a,
    b.telefon_norm AS telefon_b,

    a.cluster_id AS cluster_a,
    b.cluster_id AS cluster_b,

    CASE WHEN a.email IS NOT NULL AND a.email = b.email THEN 1 ELSE 0 END AS email_match,
    CASE WHEN a.telefon_norm IS NOT NULL AND a.telefon_norm = b.telefon_norm THEN 1 ELSE 0 END AS telefon_match,

    1.0 - (
        levenshtein(lower(a.nachname), lower(b.nachname))::DOUBLE
        / greatest(length(a.nachname), length(b.nachname))
    ) AS nachname_similarity,

    1.0 - (
        levenshtein(lower(a.strasse), lower(b.strasse))::DOUBLE
        / greatest(length(a.strasse), length(b.strasse))
    ) AS strasse_similarity,

    CASE
        WHEN a.cluster_id = b.cluster_id THEN 1
        ELSE 0
    END AS true_match,

    (
        CASE WHEN a.email IS NOT NULL AND a.email = b.email THEN 50 ELSE 0 END
        +
        CASE WHEN a.telefon_norm IS NOT NULL AND a.telefon_norm = b.telefon_norm THEN 30 ELSE 0 END
        +
        CASE
            WHEN 1.0 - (
                levenshtein(lower(a.nachname), lower(b.nachname))::DOUBLE
                / greatest(length(a.nachname), length(b.nachname))
            ) >= 0.85 THEN 10 ELSE 0
          END
        +
        CASE
            WHEN 1.0 - (
                levenshtein(lower(a.strasse), lower(b.strasse))::DOUBLE
                / greatest(length(a.strasse), length(b.strasse))
            ) >= 0.80 THEN 10 ELSE 0
          END
    ) AS score,

    CASE
        WHEN (
            CASE WHEN a.email IS NOT NULL AND a.email = b.email THEN 50 ELSE 0 END
            +
            CASE WHEN a.telefon_norm IS NOT NULL AND a.telefon_norm = b.telefon_norm THEN 30 ELSE 0 END
            +
            CASE
                WHEN 1.0 - (
                    levenshtein(lower(a.nachname), lower(b.nachname))::DOUBLE
                    / greatest(length(a.nachname), length(b.nachname))
                ) >= 0.85 THEN 10 ELSE 0
              END
            +
            CASE
                WHEN 1.0 - (
                    levenshtein(lower(a.strasse), lower(b.strasse))::DOUBLE
                    / greatest(length(a.strasse), length(b.strasse))
                ) >= 0.80 THEN 10 ELSE 0
              END
        ) >= 60 THEN 1
        ELSE 0
    END AS predicted_match

FROM transform.norm_kunde_with_gold a
JOIN transform.norm_kunde_with_gold b
    ON a.quelle < b.quelle
   AND a.plz = b.plz
   AND left(lower(a.nachname), 1) = left(lower(b.nachname), 1);
