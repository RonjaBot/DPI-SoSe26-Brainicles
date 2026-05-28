# Profiling: praxis_schmidt_behandlungen.json

## Datei

* Format: JSON
* Struktur: Nested JSON
* Encoding: UTF-8
* Datensätze: 150
* Spalten: 7

## Spalten

| Spalte    | Typ-Vermutung | Beispiel             | Distinct | Null% | Bemerkung                            |
| --------- | ------------- | -------------------- | -------: | ----: | ------------------------------------ |
| id        | Integer       | 301                  |      150 |    0% | vermutlich eindeutige Behandlungs-ID |
| datum     | Datum/String  | 24.09.2025           |      108 |    0% | deutsches Datumsformat               |
| kunde     | String        | Schneider X.         |      104 |    0% | Kundennamen teilweise wiederholt     |
| leistung  | String        | Vorsorgeuntersuchung |       19 |    0% | standardisierte Behandlungsarten     |
| betrag    | String        | 15,46 EUR            |      148 |    0% | Währungsformat als Text gespeichert  |
| tier.name | String        | Caesar               |       32 |    0% | Tiernamen wiederholen sich mehrfach  |
| tier.art  | String        | Katze                |        2 |    0% | nur Hund und Katze vorhanden         |

## Auffällige Muster

* Die Datei enthält verschachtelte JSON-Strukturen („tier.name“ und „tier.art“).
* Tiernamen wie „Caesar“, „Charlie“ oder „Buddy“ kommen mehrfach vor.
* Es existieren nur zwei Tierarten: Hund und Katze.
* Behandlungsarten wiederholen sich regelmäßig.
* Beträge sind als Text inklusive „EUR“ gespeichert.
* Datumswerte liegen im deutschen Format TT.MM.JJJJ vor.

## Datenqualitätsprobleme

* Das Feld „betrag“ ist kein numerischer Datentyp und muss vor Berechnungen konvertiert werden.
* Datumswerte müssen in ein standardisiertes Datumsformat transformiert werden.
* Kundennamen sind verkürzt gespeichert (z. B. „Schneider X.“), was Matching-Prozesse erschweren kann.
* Schreibfehler in Kundennamen sind möglich (z. B. „Muleler“ statt „Mueller“, „Rtoh“ statt „Roth“).
* Wiederkehrende Tiernamen sind nicht eindeutig und dürfen nicht allein zur Identifikation verwendet werden.
* Die verschachtelte JSON-Struktur musste zunächst normalisiert werden.
