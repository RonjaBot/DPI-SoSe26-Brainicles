# Profiling: praxis_waldrand_kunden.csv

## Datei
- Format: CSV
- Trennzeichen: Komma
- Encoding: UTF-8
- Zeilen: 227

## Spalten

| Spalte | Typ-Vermutung | Bemerkung |
|---|---|---|
| customer_id | VARCHAR | Kunden-ID |
| first_name | VARCHAR | Vorname |
| last_name | VARCHAR | 1 NULL-Wert |
| street | VARCHAR | Adresse |
| zip_code | BIGINT | PLZ |
| city | VARCHAR | Ort |
| phone | VARCHAR | Inkonsistente Formate |
| email_address | VARCHAR | 50 NULL-Werte |
| created_at | VARCHAR | Format MM/DD/YYYY |
| marketing_consent | BOOLEAN | Marketing-Einwilligung |

## Auffällige Muster
- Telefonnummern liegen in unterschiedlichen Formaten vor
- Datumsformat MM/DD/YYYY statt ISO-8601
- Teilweise fehlende Kontaktinformationen

## Datenqualitätsprobleme
- 50 fehlende Werte in email_address
- 1 fehlender Wert in last_name
- Telefonnummern nicht standardisiert
- Datumsformat nicht harmonisiert
  
