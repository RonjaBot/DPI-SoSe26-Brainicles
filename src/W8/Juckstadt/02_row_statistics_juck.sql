SELECT
    'staging.juck_kunden' AS tabelle,
    COUNT(*) AS zeilen
FROM staging.juck_kunden

UNION ALL

SELECT
    'staging.juck_behandlungen' AS tabelle,
    COUNT(*) AS zeilen
FROM staging.juck_behandlungen;