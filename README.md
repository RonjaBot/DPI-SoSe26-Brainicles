# DPI-SoSe26-Brainicles – VetKliniken-Verbund

## Projektbeschreibung

Dieses Projekt implementiert eine ETL-Pipeline zur Integration heterogener Datenquellen mehrerer Tierarztpraxen in eine gemeinsame Verbund-Datenbank.

Im Fokus stehen:

* Datenprofiling
* Datenharmonisierung
* Dublettenerkennung
* Golden Records
* Datenintegration mit DuckDB und Python

Die Quelldaten stammen aus verschiedenen Praxissystemen und liegen in unterschiedlichen Formaten vor:

* CSV
* JSON
* XML mit Namespace

---

## Team

* Alexandra Witzsche-Grafen
* Ronja Charlot Bothe
* Trieu-Vi Dao

---

## Projektstruktur

```text
docs/
├── w7_profiling/
│   ├── juck_kunden.md
│   ├── juck_behandlungen.md
│   ├── wald_kunden.md
│   ├── wald_behandlungen.md
│   ├── schm_kunden.md
│   ├── schm_behandlungen.md
│   ├── berg_patienten.md
│   ├── berg_behandlungen.md
│   ├── data_dictionary.md
│   └── fehlerliste.md
│
└── w8_staging/
    └── zeilenstatistik.md

src/
├── W7/
│   └── profile_juck.py
│
└── W8/
    ├── Bergblick/
    │   ├── 00_create_schemas_berg.sql
    │   ├── 01_extract_staging_berg.py
    │   └── 02_row_statistics_berg.sql
    │
    ├── Juckstadt/
    │   ├── 00_create_schemas_juck.sql
    │   ├── 01_extract_staging_juck.sql
    │   └── 02_row_statistics_juck.sql
    │
    ├── Schmidt/
    │   ├── 00_create_schemas_schm.sql
    │   ├── 01_extract_staging_schm.sql
    │   └── 02_row_statistics_schm.sql
    │
    └── Waldrand/
        ├── 00_create_schemas_wald.sql
        ├── 01_extract_staging_wald.sql
        └── 02_row_statistics_wald.sql

data/
└── duckDB/
    └── dpi.duckdb

requirements.txt
README.md
```

---

## Setup

### Repository klonen

```bash
git clone <repo-url>
```

### Virtuelle Umgebung erstellen

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### Dependencies installieren

```bash
pip install -r requirements.txt
```

---

## DuckDB starten

### DuckDB Web UI

```bash
duckdb -ui
```

Die DuckDB-Oberfläche öffnet sich anschließend im Browser unter:

```text
http://localhost:4213
```

### Bestehende DuckDB-Datenbank öffnen

```bash
duckdb data/duckDB/dpi.duckdb
```

### Staging-Tabellen prüfen

```sql
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'staging'
ORDER BY table_name;
```

---

## Datenquellen

Die Quelldaten bestehen aus mehreren heterogenen Datenquellen verschiedener Tierarztpraxen.

### Enthaltene Formate

* CSV-Dateien mit unterschiedlichen Trennzeichen (`;`, `,`, `|`)
* JSON-Dateien mit verschachtelter Struktur
* XML-Dateien mit Namespace und Nested Elements

### Wichtige Unterschiede zwischen den Quellen

* unterschiedliche Datumsformate
* unterschiedliche Telefonnummernformate
* deutsche und englische Feldnamen
* unterschiedliche Schreibweisen von Diagnosen und Tierarten
* fehlende Werte
* unterschiedliche Referenzierungslogiken

---

## Pipeline-Architektur

```mermaid
flowchart LR
Q[Quelldaten] --> S[staging]
S --> T[transform]
T --> F[final]
F --> M[Matching / Golden Record]
```

---

## Schichtenmodell

### staging

Rohdaten aus den Quellen ohne fachliche Transformation.

### transform

Normalisierte und harmonisierte Daten:

* Datumsformate
* Telefonnummern
* Tierarten
* Beträge

### final

Konsolidiertes Zielmodell mit Dublettenerkennung und Golden Records.

---

## Aktueller Stand

### W07 – Profiling

Abgeschlossen:

* Datenprofiling aller relevanten Quellen
* Erstellung von Profiling-Reports
* Erstellung einer Fehlerliste
* Erstellung eines Data Dictionary

Identifizierte Hauptprobleme:

* uneinheitliche Datumsformate
* unterschiedliche Telefonnummernformate
* fehlende Werte
* verschachtelte JSON- und XML-Strukturen
* semantische Inkonsistenzen
* fehlende eindeutige Referenzen
* unterschiedliche Sprach- und Formatkonventionen

### W08 – Extract und Staging

Abgeschlossen:

* Extract-Skripte für Juckstadt, Waldrand, Schmidt und Bergblick
* Anlage der DuckDB-Schemata `staging`, `transform` und `final`
* Befüllung der Staging-Tabellen
* Dokumentation der Zeilenstatistik

Angelegte Staging-Tabellen:

* `staging.juck_kunden`
* `staging.juck_behandlungen`
* `staging.wald_kunden`
* `staging.wald_behandlungen`
* `staging.schm_kunden`
* `staging.schm_behandlungen`
* `staging.berg_patienten`
* `staging.berg_behandlungen`

---

## Verwendete Technologien

* Python
* DuckDB
* pandas
* Git/GitHub
* Markdown
* SQL
