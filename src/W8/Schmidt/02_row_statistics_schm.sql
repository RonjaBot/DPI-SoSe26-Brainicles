SELECT
    'staging.schm_kunden' AS tabelle,
    COUNT(*) AS zeilen
FROM staging.schm_kunden
    
UNION ALL

SELECT
     'staging.schm_behandlungen' AS tabelle,
     COUNT(*) AS zeilen
FROM staging.schm_behandlungen;
