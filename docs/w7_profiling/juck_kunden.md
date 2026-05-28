# Profiling: praxis_juckstadt_kunden.csv

## Datei
- Format: CSV
- Trennzeichen: ;
- Encoding: UTF-8
- Header: ja 
- Zeilen: 223

## Spalten

| Spalte | Typ-Vermutung | Beispiel | Distinct | Null% | Bemerkung |
|---|---|---|---|---|---|
| kunden_nr | Integer | 1 | 223 | 0% | eindeutige Kunden-ID |
| anrede | String | Herr | 2 | 0% | nur Herr/Frau |
| vorname | String | Thomas | 63 | 0% | normale Textwerte |
| nachname | String | Berger | 43 | 0% | einige Nachnamen mehrfach vorhanden |
| strasse | String | Hauptstr. 12 | 214 | 0% | verschiedene Schreibweisen|
| plz | Integer/String | 35500 | 8 | 0% | wenige unterschiedliche PLZ |
| ort | String | Juckstadt | 10 | 0% | Ortsnamen wiederholen sich |
| telefon | String | 06450-1234 | 222 | 0% | lokales Telefonnummernformat |
| email | String | berger@email.de | 196 | 9% | 21 fehlende Werte |
| angelegt_am | Datum/String | 2021-05-12 | 215 | 0% | Datumsformat bereits ISO-ähnlich |

## Auffällige Muster
- deutsche Spaltennamen
- viele Kunden aus denselben Orten
- Telefonnummern im lokalen Format
- Datumswerte zweistelliges Jahr
- einige Nachnamen kommen mehrfach vor

## Datenqualitätsprobleme
- Datumsformat nicht ISO-8601
- fehlende Email-Adressen
- Telefonnummern nicht international formatiert
- Straßenangaben könnten unterschiedliche Schreibweisen enthalten (z. B. Str./Straße)
