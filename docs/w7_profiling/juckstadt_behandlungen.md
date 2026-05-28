# Profiling: praxis_juckstadt_behandlungen.csv

## Datei
- Format: CSV
- Trennzeichen: ;
- Encoding: vermutlich UTF-8, keine sichtbaren Zeichenfehler
- Header: ja
- Zeilen: 150
- Spalten: 6

## Spalten

| Spalte | Typ-Vermutung | Beispiel | Distinct | Null% | Bemerkung |
|---|---|---|---|---|---|
| beh_nr | Integer | 1 | 150 | 0% | vermutlich eindeutige Behandlungs-ID |
| datum | Datum/String | 2026-02-06 | 114 | 0% | ursprünglich deutsches Datumsformat |
| patient_name | String | Pumba | 32 | 0% | Tiernamen wiederholen sich |
| kunde_nachname | String | Krueger | 38 | 0% | keine eindeutige Kunden-ID vorhanden |
| diagnose | String | Augenuntersuchung | 19 | 0% | Diagnosen als Freitext |
| kosten_euro | Decimal/String | 191,17 | 150 | 0% | deutsches Dezimaltrennzeichen |

## Auffällige Muster

- Kostenwerte sind überwiegend eindeutig.
- Diagnosen liegen als Freitext vor.
- Patienten- und Kundennamen sind getrennt gespeichert.
- Datumswerte wurden von pandas automatisch interpretiert.
- Tiernamen treten mehrfach auf.

## Datenqualitätsprobleme

- Kunden werden nur über Nachnamen referenziert und besitzen keine eindeutige ID.
- Diagnosen als Freitext könnten unterschiedliche Schreibweisen enthalten.
- Kostenwerte verwenden deutsche Dezimaltrennzeichen mit Komma.
- Datumswerte liegen ursprünglich nicht im ISO-8601-Format vor.
- Wiederkehrende Tiernamen könnten die eindeutige Zuordnung von Behandlungen erschweren.