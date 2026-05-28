# Profiling: praxis_bergblick_export.xml

## Datei

* Format: XML
* Encoding: UTF-8
* Schema-Version: 2.1
* Exportdatum: 2026-03-31
* Zeilen: 232
* Spalten: 11

## Spalten

| Spalte        | Typ-Vermutung | Beispiel                                  | Distinct | Null% | Bemerkung                              |
| ------------- | ------------- | ----------------------------------------- | -------- | ----- | -------------------------------------- |
| patient_id    | String        | P-4001                                    | 232      | 0%    | eindeutige Patienten-ID                |
| halter_anrede | String        | Herr                                      | 2        | 0%    | nur Herr/Frau vorhanden                |
| halter_name   | String        | Thomas Berger                             | 222      | 0%    | einige Namen wiederholen sich          |
| telefon       | String        | 0645-01234                                | 215      | 0%    | teilweise leere Telefonnummern         |
| email         | String        | [berger@email.de](mailto:berger@email.de) | 206      | 0%    | einige leere E-Mail-Adressen           |
| strasse       | String        | Hauptstrasse 12                           | 228      | 0%    | unterschiedliche Schreibweisen möglich |
| plz           | String        | 35500                                     | 8        | 0%    | wenige unterschiedliche PLZ            |
| ort           | String        | Juckstadt                                 | 11       | 0%    | Ortsnamen wiederholen sich             |
| tier_name     | String        | Lucky                                     | 32       | 0%    | Tiernamen wiederholen sich mehrfach    |
| tier_art      | String        | Hund                                      | 2        | 0%    | nur Hund/Katze vorhanden               |
| tier_geburt   | Datum/String  | 2022-05-03                                | 222      | 0%    | Geburtsdaten im ISO-Format             |

## Auffällige Muster

* Die XML-Datei enthält verschachtelte Strukturen (Patient → Halter → Tier).
* Telefonnummern liegen im lokalen deutschen Format vor.
* Tierarten enthalten nur zwei Werte (Hund/Katze).
* Mehrere Tiernamen wiederholen sich häufig.
* Die meisten Datensätze stammen aus wenigen Orten und PLZ-Bereichen.
* Datumswerte liegen bereits im ISO-Format YYYY-MM-DD vor.

## Datenqualitätsprobleme

* Einige Telefonnummern sind leer oder unvollständig.
* Einige E-Mail-Adressen fehlen.
* Straßenangaben könnten unterschiedliche Schreibweisen enthalten (z. B. Str./Strasse).
* Telefonnummern sind nicht im internationalen E.164-Format gespeichert.
* Personen- und Tiernamen könnten Schreibfehler enthalten.
* Wiederkehrende Tiernamen könnten spätere Matching-Prozesse erschweren.
