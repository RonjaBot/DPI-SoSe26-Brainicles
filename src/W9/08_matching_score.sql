CREATE OR REPLACE TABLE transform.match_scored AS
SELECT
    *,

    CASE
        WHEN email IS NOT NULL THEN 50
        ELSE 0
    END

    +

    CASE
        WHEN telefon_norm IS NOT NULL THEN 30
        ELSE 0
    END

    +

    CASE
        WHEN lower(nachname_a) = lower(nachname_b) THEN 20
        ELSE 0
    END

    AS score,

    CASE
        WHEN
            (
                CASE WHEN email IS NOT NULL THEN 50 ELSE 0 END
                +
                CASE WHEN telefon_norm IS NOT NULL THEN 30 ELSE 0 END
                +
                CASE WHEN lower(nachname_a)=lower(nachname_b) THEN 20 ELSE 0 END
            ) >= 50
        THEN 1
        ELSE 0
    END AS predicted_match

FROM transform.match_candidates;
