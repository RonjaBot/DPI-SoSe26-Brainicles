# Profiling: praxis_bergblick_export.xml (Patienten)

## Datei
- Format: XML
- Encoding: UTF-8
- Namespace vorhanden
- Patienten-, Halter- und Tierdaten sind verschachtelt gespeichert
- Patienten besitzen eine eindeutige ID (`patient id`)

## Spalten / extrahierbare Felder

| Feld | Typ-Vermutung | Beispiel | Bemerkung |
|---|---|---|---|
| patient_id | VARCHAR | P-4001 | Primärreferenz des Patienten |
| anrede | VARCHAR | Herr | Halter-Anrede |
| name | VARCHAR | Thomas Berger | Vor- und Nachname nicht getrennt |
| telefon | VARCHAR | 0645-01234 | Unterschiedliche Formate möglich |
| telefon_typ | VARCHAR | festnetz | Attribut im XML |
| email | VARCHAR | berger@email.de | Kontaktfeld |
| strasse | VARCHAR | Hauptstrasse 12 | Adresse |
| plz | VARCHAR | 35500 | Postleitzahl |
| ort | VARCHAR | Juckstadt | Ort |
| tiername | VARCHAR | Lucky | Tiername |
| tierart | VARCHAR | Hund | Bereits deutsch |
| geburt | DATE | 2022-05-03 | Geburtsdatum des Tiers |
| erfasst | DATE | 2021-06-20 | Erfassungsdatum des Halters |

## Auffällige Muster
- Patienten-, Halter- und Tierdaten sind stark verschachtelt.
- Haltername liegt nur als zusammengesetztes Feld vor.
- Telefonnummern enthalten unterschiedliche Typen (`festnetz`, `mobil`).
- XML nutzt Namespaces.
- Tierarten liegen bereits auf Deutsch vor.

## Datenqualitätsprobleme
- Keine flache Tabellenstruktur vorhanden.
- Vor- und Nachname müssen später getrennt werden.
- XML-Namespace erschwert Parsing und Extraktion.
- Telefonnummern sind nicht standardisiert.
- Patienten-, Halter- und Tierdaten müssen für die Staging-Schicht separiert bzw. harmonisiert werden.
- Beziehungen zwischen Patienten und Behandlungen erfolgen indirekt über `patientId`.
