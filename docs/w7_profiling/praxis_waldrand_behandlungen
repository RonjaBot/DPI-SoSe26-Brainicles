# Profiling: praxis_waldrand_behandlungen.csv

## Datei
- Format: CSV
- Trennzeichen: Komma
- Encoding: UTF-8
- Zeilen: 150

## Spalten

| Spalte | Typ-Vermutung | Bemerkung |
|---|---|---|
| treatment_id | VARCHAR | Eindeutige Behandlungs-ID |
| customer_id | VARCHAR | Referenz auf Kunden |
| animal_name | VARCHAR | Tiername |
| species | VARCHAR | Tierart auf Englisch |
| treatment_date | DATE | Bereits ISO-8601-konform |
| diagnosis | VARCHAR | Freitext-Diagnosen |
| total_eur | DOUBLE | Betrag mit Punkt als Dezimaltrenner |

## Auffällige Muster
- Datumsformat bereits im ISO-8601-Format
- Beträge bereits numerisch standardisiert
- Tierarten in englischer Sprache
- Diagnosen teilweise semantisch ähnlich, aber unterschiedlich benannt

## Datenqualitätsprobleme
- Tierarten müssen sprachlich harmonisiert werden (cat/dog → deutsch)
- Diagnosen weisen semantische Variationen auf (z. B. "Flea treatment" vs. "Flea/tick treatment")
- Keine NULL-Werte vorhanden
