SELECT 'staging.wald_kunden' AS tabelle, COUNT(*) AS zeilen
FROM staging.wald_kunden
UNION ALL
SELECT 'staging.wald_behandlungen', COUNT(*)
FROM staging.wald_behandlungen;
