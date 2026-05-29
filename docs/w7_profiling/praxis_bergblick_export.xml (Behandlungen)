# Profiling: praxis_bergblick_export.xml (Behandlungen)

## Datei
- Format: XML
- Encoding: UTF-8
- Namespace vorhanden
- Behandlungsdaten liegen in einem separaten `<behandlungen>`-Block
- Zeilen/Einträge: 150

## Spalten / extrahierbare Felder

| Feld | Typ-Vermutung | Beispiel | Bemerkung |
|---|---|---|---|
| patientId | VARCHAR | P-4191 | Referenz auf Patient |
| datum | DATE | 2025-11-15 | Bereits ISO-8601-konform |
| diagnose | VARCHAR | Tumorabklaerung | Diagnose als Freitext |
| netto | DOUBLE | 162.92 | Betrag netto |
| brutto | DOUBLE | 193.87 | Betrag brutto |

## Auffällige Muster
- Behandlungsdaten sind nicht tabellarisch, sondern als XML-Struktur gespeichert.
- Die Verknüpfung zu Patienten erfolgt über das Attribut `patientId`.
- Das Behandlungsdatum liegt als Attribut und nicht als eigenes Element vor.
- Beträge sind als Attribute innerhalb des leeren Elements `<summe />` gespeichert.
- Netto- und Bruttobeträge sind getrennt gespeichert.
- Diagnosen enthalten teilweise Umschreibungen ohne Umlaute, z. B. `Tumorabklaerung`.

## Datenqualitätsprobleme
- XML-Namespace muss beim Parsing berücksichtigt werden.
- Behandlungsdaten müssen aus einer verschachtelten XML-Struktur in eine flache Tabelle überführt werden.
- Patientenzuordnung erfolgt nur über `patientId`; ohne Join zu den Patientendaten fehlen Tier- und Halterinformationen.
- Diagnosewerte sind semantisch/fachlich zu harmonisieren.
- Umlaute sind teilweise ausgeschrieben statt als Sonderzeichen gespeichert.
