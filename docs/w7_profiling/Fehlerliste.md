# Fehlerliste – Datenqualitätsprobleme der Verbund-Datenquellen

## Ziel der Fehlerliste

Diese Fehlerliste dokumentiert identifizierte Datenqualitätsprobleme der verschiedenen Quelldateien. Die Probleme wurden während der Profiling-Phase erkannt und nach Kategorien klassifiziert.

| Kategorie       | Quelle                            | Problem                                       | Beispiel                                         | Auswirkung                                 |
| --------------- | --------------------------------- | --------------------------------------------- | ------------------------------------------------ | ------------------------------------------ |
| Fehlwerte       | praxis_waldrand_kunden.csv        | Fehlende E-Mail-Adressen                      | 50 NULL-Werte in `email_address`                 | erschwert Dublettenerkennung               |
| Fehlwerte       | praxis_juckstadt_kunden.csv       | Fehlende E-Mail-Adressen                      | 21 fehlende Werte in `email`                     | geringere Matching-Qualität                |
| Fehlwerte       | praxis_schmidt_kunden.csv         | Fehlende E-Mail-Adressen                      | 12 % NULL-Werte                                  | reduzierte Datenqualität                   |
| Fehlwerte       | praxis_waldrand_kunden.csv        | Fehlender Nachname                            | 1 NULL-Wert in `last_name`                       | unvollständiger Kundendatensatz            |
| Format          | praxis_waldrand_kunden.csv        | Unterschiedliche Telefonnummernformate        | `0640/777991`, `+49 640 758420`                  | erschwerte Normalisierung                  |
| Format          | praxis_schmidt_kunden.csv         | Telefonnummern enthalten Leerzeichen          | `0645 01234`                                     | inkonsistente Speicherung                  |
| Format          | praxis_juckstadt_kunden.csv       | Telefonnummern nur lokal gespeichert          | `06450-1234`                                     | kein E.164-Format                          |
| Format          | praxis_juckstadt_behandlungen.csv | Kostenwerte mit deutschem Dezimaltrennzeichen | `191,17`                                         | Konvertierung erforderlich                 |
| Format          | praxis_schmidt_behandlungen.json  | Beträge als Text gespeichert                  | `15,46 EUR`                                      | numerische Berechnung nicht direkt möglich |
| Format          | praxis_schmidt_behandlungen.json  | Deutsches Datumsformat                        | `24.09.2025`                                     | ISO-Transformation erforderlich            |
| Format          | praxis_schmidt_kunden.csv         | Deutsches Datumsformat                        | `06.12.2020`                                     | Harmonisierung erforderlich                |
| Format          | praxis_waldrand_kunden.csv        | US-Datumsformat                               | `05/29/2025`                                     | uneinheitliche Datumsdarstellung           |
| Schema Drift    | praxis_waldrand_kunden.csv        | Englische Spaltennamen                        | `first_name`, `zip_code`                         | Mapping erforderlich                       |
| Schema Drift    | praxis_schmidt_kunden.csv         | Unterschiedliche Feldnamen                    | `tel` statt `telefon`                            | Harmonisierung notwendig                   |
| Schema Drift    | praxis_bergblick_export.xml       | Vollname statt getrennte Namensfelder         | `Thomas Berger`                                  | Vor-/Nachname müssen extrahiert werden     |
| Schema Drift    | praxis_juckstadt_behandlungen.csv | Keine eindeutige Kunden-ID                    | nur `kunde_nachname` vorhanden                   | unsichere Zuordnung                        |
| Struktur        | praxis_schmidt_behandlungen.json  | Verschachtelte JSON-Struktur                  | `tier.name`, `tier.art`                          | Flattening notwendig                       |
| Struktur        | praxis_bergblick_export.xml       | Verschachtelte XML-Struktur                   | `<halter>`, `<tier>`                             | keine flache Tabellenstruktur              |
| Struktur        | praxis_bergblick_export.xml       | XML Namespace vorhanden                       | `xmlns="http://vetkliniken-hessen.de/schema/v2"` | Namespace-aware Parsing notwendig          |
| Semantik        | praxis_waldrand_behandlungen.csv  | Tierarten auf Englisch                        | `cat`, `dog`                                     | sprachliche Harmonisierung erforderlich    |
| Semantik        | praxis_schmidt_behandlungen.json  | Unterschiedliche Diagnosewerte                | Freitext-Behandlungen                            | Standardisierung notwendig                 |
| Semantik        | praxis_waldrand_behandlungen.csv  | Semantisch ähnliche Diagnosen                 | `Flea treatment` vs. `Flea/tick treatment`       | mögliche Dubletten                         |
| Encoding        | praxis_bergblick_export.xml       | Umlaute ausgeschrieben                        | `Tumorabklaerung`                                | semantische Inkonsistenz                   |
| Dublettenrisiko | praxis_schmidt_kunden.csv         | Abgekürzte Vornamen                           | `Th.`                                            | erschwert Matching                         |
| Dublettenrisiko | praxis_schmidt_behandlungen.json  | Tippfehler in Kundennamen                     | `Muleler`, `Rtoh`                                | unsichere Dublettenerkennung               |
| Dublettenrisiko | praxis_juckstadt_behandlungen.csv | Wiederkehrende Tiernamen                      | `Pumba` mehrfach vorhanden                       | keine eindeutige Identifikation            |
| Dublettenrisiko | praxis_schmidt_behandlungen.json  | Wiederkehrende Tiernamen                      | `Buddy`, `Charlie`                               | Verwechslungsgefahr                        |
