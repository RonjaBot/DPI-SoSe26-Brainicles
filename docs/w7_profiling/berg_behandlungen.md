# Profiling: praxis_bergblick_export.xml

## Datei
- Format: XML
- Encoding: UTF-8
- Struktur: hierarchisch (Patient → Halter → Tier)
- Eindeutige Zuordnung: Patientenstammdaten
- Zeilen (nach Flattening): 232
- Spalten: 11

## Einordnung der Datenstruktur

- Die Datei enthält ausschließlich Patientenstammdaten inklusive Halter- und Tierinformationen.
- Behandlungsdaten (z. B. Leistungen oder Beträge) sind nicht enthalten.
- Das Element „tier“ ist als verschachteltes Objekt innerhalb des Patienten definiert und gehört daher logisch zu den Stammdaten.

## Datenmodell-Einordnung

- Kein eigenständiges Behandlungsobjekt vorhanden
- Keine Transaktionsdaten im Export enthalten
- Tierdaten sind Bestandteil der Patientenstruktur und nicht der Behandlungen
