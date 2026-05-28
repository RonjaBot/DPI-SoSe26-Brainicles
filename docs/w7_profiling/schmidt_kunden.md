# Profiling: praxis_schmidt_kunden.csv

## Datei

* Format: CSV
* Trennzeichen: |
* Encoding: UTF-8
* Header: ja
* Zeilen: 234
* Spalten: 9

## Spalten

| Spalte   | Typ-Vermutung  | Beispiel                                  | Distinct | Null% | Bemerkung                                 |
| -------- | -------------- | ----------------------------------------- | -------- | ----- | ----------------------------------------- |
| nachname | String         | Berger                                    | 43       | 0%    | Nachnamen wiederholen sich teilweise      |
| vorname  | String         | Th.                                       | 61       | 0%    | teilweise abgekürzte Vornamen vorhanden   |
| anrede   | String         | Hr.                                       | 3        | 0%    | unterschiedliche Schreibweisen der Anrede |
| plz      | Integer/String | 35500                                     | 8        | 0%    | wenige unterschiedliche PLZ               |
| ort      | String         | Juckstadt                                 | 10       | 0%    | Ortsnamen wiederholen sich                |
| strasse  | String         | Hauptstr. 12                              | 220      | 0%    | mögliche unterschiedliche Schreibweisen   |
| tel      | String         | 0645 01234                                | 233      | 0%    | Telefonnummern enthalten Leerzeichen      |
| email    | String         | [berger@email.de](mailto:berger@email.de) | 205      | 12%   | fehlende Werte vorhanden                  |
| erfasst  | Datum/String   | 06.12.2020                                | 220      | 0%    | deutsches Datumsformat vorhanden          |

## Auffällige Muster

* Die Datei verwendet Pipe-Zeichen (`|`) als Trennzeichen.
* Telefonnummern enthalten teilweise Leerzeichen und uneinheitliche Schreibweisen.
* Vornamen liegen teilweise in abgekürzter Form vor (z. B. „Th.“).
* Das Feld „anrede“ verwendet unterschiedliche Abkürzungen wie „Hr.“ und „Fr.“.
* Datumswerte liegen im deutschen Format `TT.MM.JJJJ` vor.
* Ortsnamen und PLZ-Bereiche wiederholen sich häufig.

## Datenqualitätsprobleme

* Telefonnummern sind nicht standardisiert und müssen normalisiert werden.
* Abgekürzte Vornamen könnten spätere Matching-Prozesse erschweren.
* Unterschiedliche Schreibweisen bei Anreden müssen vereinheitlicht werden.
* Fehlende E-Mail-Adressen reduzieren die Qualität der Dublettenerkennung.
* Datumswerte müssen auf ein einheitliches ISO-Format transformiert werden.
* Straßenangaben könnten unterschiedliche Schreibweisen enthalten (z. B. „Str.“ vs. „Straße“).
