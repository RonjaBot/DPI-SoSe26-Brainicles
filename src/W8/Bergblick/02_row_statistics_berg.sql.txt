SELECT
    'staging.berg_patienten' AS tabelle,
    COUNT(*) AS zeilen
FROM staging.berg_patienten

UNION ALL

SELECT
    'staging.berg_behandlungen' AS tabelle,
    COUNT(*) AS zeilen
FROM staging.berg_behandlungen;