CREATE OR REPLACE TABLE final.verbund_kunde AS
SELECT
    m.final_kunde_id AS kunde_id,

    max(k.anrede) AS anrede,
    max(k.vorname) AS vorname,
    max(k.nachname) AS nachname,
    max(k.strasse) AS strasse,
    max(k.plz) AS plz,
    max(k.ort) AS ort,
    max(k.telefon_norm) AS telefon,
    max(k.email) AS email,
    max(k.angelegt_am) AS angelegt_am,

    string_agg(k.quelle || ':' || k.quell_id, ', ') AS quellen_datensaetze,
    count(*) AS anzahl_quell_datensaetze

FROM transform.norm_kunde k
JOIN final.kunde_mapping m
    ON k.quelle = m.quelle
   AND k.quell_id = m.quell_id

GROUP BY m.final_kunde_id;
