CREATE OR REPLACE TABLE final.verbund_behandlung AS
WITH juck_match AS (
    SELECT
        b.quelle,
        b.behandlung_id,
        MIN(m.final_kunde_id) AS kunde_id
    FROM transform.norm_behandlung b
    JOIN transform.norm_kunde k
        ON b.quelle = 'juck'
       AND k.quelle = 'juck'
       AND lower(b.kunde_ref) = lower(k.nachname)
    JOIN final.kunde_mapping m
        ON k.quelle = m.quelle
       AND k.quell_id = m.quell_id
    GROUP BY b.quelle, b.behandlung_id
),

schm_match AS (
    SELECT
        b.quelle,
        b.behandlung_id,
        MIN(m.final_kunde_id) AS kunde_id
    FROM transform.norm_behandlung b
    JOIN transform.norm_kunde k
        ON b.quelle = 'schm'
       AND k.quelle = 'schm'
       AND lower(split_part(b.kunde_ref, ' ', 1)) = lower(k.nachname)
       AND lower(substr(split_part(b.kunde_ref, ' ', 2), 1, 1)) = lower(substr(k.vorname, 1, 1))
    JOIN final.kunde_mapping m
        ON k.quelle = m.quelle
       AND k.quell_id = m.quell_id
    GROUP BY b.quelle, b.behandlung_id
)

SELECT
    b.quelle,
    b.behandlung_id,
    COALESCE(m_id.final_kunde_id, jm.kunde_id, sm.kunde_id) AS kunde_id,
    b.kunde_ref,
    b.tier_name,
    b.tierart_raw,
    b.tierart,
    b.datum_raw,
    b.datum,
    b.diagnose,
    b.kosten_euro_raw,
    b.kosten_euro,
    b.quell_zeile,
    b.quell_datei

FROM transform.norm_behandlung b
LEFT JOIN final.kunde_mapping m_id
    ON b.quelle = m_id.quelle
   AND b.kunde_ref = m_id.quell_id
LEFT JOIN juck_match jm
    ON b.quelle = jm.quelle
   AND b.behandlung_id = jm.behandlung_id
LEFT JOIN schm_match sm
    ON b.quelle = sm.quelle
   AND b.behandlung_id = sm.behandlung_id;

-- Kontrolle
SELECT COUNT(*) AS anzahl_finale_kunden
FROM final.verbund_kunde;

SELECT COUNT(*) AS behandlungen_gesamt
FROM final.verbund_behandlung;

SELECT
    quelle,
    COUNT(*) AS gesamt,
    SUM(CASE WHEN kunde_id IS NULL THEN 1 ELSE 0 END) AS ohne_kunde_id
FROM final.verbund_behandlung
GROUP BY quelle
ORDER BY quelle;
