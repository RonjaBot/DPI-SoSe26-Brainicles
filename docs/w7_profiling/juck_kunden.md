# Profiling: praxis_juckstadt_kunden.csv

## Datei
- Format: CSV
- Trennzeichen: ;
- Encoding: UTF-8
- Header: ja
- Zeilen: 223
- Spalten: 10

## Spalten

| Spalte | Typ-Vermutung | Beispiel | Distinct | Null% | Bemerkung |
|---|---|---|---|---|---|
| kunden_nr | Integer | 1 | 223 | 0% | vermutlich eindeutige Kunden-ID |
| anrede | String | Herr | 2 | 0% | nur Herr/Frau vorhanden |
| vorname | String | Thomas | 63 | 0% | normale Textwerte |
| nachname | String | Berger | 43 | 0% | Nachnamen wiederholen sich teilweise |
| strasse | String | Hauptstr. 12 | 214 | 0% | unterschiedliche Schreibweisen möglich |
| plz | Integer/String | 35500 | 8 | 0% | wenige unterschiedliche PLZ |
| ort | String | Juckstadt | 10 | 0% | Ortsnamen wiederholen sich |
| telefon | String | 06450-1234 | 222 | 0% | lokales deutsches Telefonnummernformat |
| email | String | berger@email.de | 196 | 9% | 21 fehlende Werte |
| angelegt_am | Datum/String | 2021-05-12 | 215 | 0% | Datumswerte vorhanden |

## Auffällige Muster

- Telefonnummern liegen im lokalen deutschen Format vor.
- Die meisten Kunden stammen aus wenigen Orten und PLZ-Bereichen.
- Nachnamen wiederholen sich teilweise mehrfach.
- Das Feld „anrede“ enthält nur zwei Werte (Herr/Frau).
- Straßenangaben wirken textuell uneinheitlich aufgebaut.

## Datenqualitätsprobleme

- Telefonnummern sind nicht im internationalen E.164-Format gespeichert und müssen normalisiert werden.
- Im Feld „email“ fehlen 21 Werte, was die spätere Dublettenerkennung erschweren kann.
- Straßenangaben könnten unterschiedliche Schreibweisen enthalten (z. B. Str./Straße).
- Datumswerte müssen auf ein einheitliches Zielformat geprüft werden.
- Unterschiedliche Textschreibweisen könnten spätere Matching-Prozesse beeinflussen.
