# W10 – Aufbau der Gold-Schicht

## Ziel

Im letzten Verarbeitungsschritt werden die zuvor erkannten Dubletten zu einer Gold-Schicht zusammengeführt. Ziel ist es, dass jede reale Person nur noch einmal in der finalen Kundentabelle vorkommt. Anders als bei der Evaluation basiert die Zusammenführung nicht auf dem bereitgestellten Goldstandard, sondern ausschließlich auf den Ergebnissen des eigenen Matching-Algorithmus.

---

## 1. Übernahme der erkannten Matches

Zunächst werden alle vom optimierten Matching-Verfahren als Dublette erkannten Datensatzpaare übernommen.

```sql
CREATE OR REPLACE TABLE final.matches AS
SELECT *
FROM transform.match_scored_similarity_v2
WHERE predicted_match = 1;
```

Die Tabelle `final.matches` enthält ausschließlich die durch den eigenen Matching-Algorithmus erkannten Dubletten.

---

## 2. Bildung der Kunden-Cluster

Da eine Person in mehreren Datenquellen vorkommen kann, wurden die erkannten Dubletten zu Kundengruppen zusammengefasst. Hierfür wurden zunächst sämtliche Kunden als Knoten (`kunde_nodes`) sowie alle erkannten Dubletten als Verbindungen (`kunde_edges`) modelliert. Anschließend wurden mithilfe einer rekursiven Abfrage zusammenhängende Komponenten bestimmt.

Auf Basis dieser Komponenten erhält jeder ursprüngliche Kundendatensatz eine eindeutige finale Kunden-ID.

---

## 3. Erstellung der Mapping-Tabelle

Aus den berechneten Komponenten wurde die Tabelle `final.kunde_mapping` erstellt.

```
quelle + quell_id
        ↓
final_kunde_id
```

Jeder ursprüngliche Kundendatensatz wird dadurch genau einer finalen Kunden-ID zugeordnet. Diese Mapping-Tabelle bildet die Grundlage für die weitere Zusammenführung der Kunden- und Behandlungsdaten.

---

## 4. Erstellung der finalen Kundentabelle

Mithilfe der Mapping-Tabelle wurden alle Kundendatensätze zu einer finalen Kundentabelle zusammengeführt.

```
final.verbund_kunde
```

Jede durch den Matching-Algorithmus erkannte reale Person erscheint dort nur noch einmal. Zusätzlich wird dokumentiert, aus welchen Quelldatensätzen sich der jeweilige finale Datensatz zusammensetzt.

### Ergebnis

| Kennzahl | Wert |
|----------|-----:|
| Ursprüngliche Kundendatensätze | 916 |
| Finale Kundendatensätze | 799 |

Die Anzahl der Kundendatensätze konnte damit durch die Zusammenführung erkannter Dubletten von **916 auf 799** reduziert werden.

---

## 5. Konfliktauflösung

Bei der Zusammenführung wurden die Kundenattribute aggregiert. Zusätzlich werden die zusammengeführten Quelldatensätze dokumentiert, sodass jederzeit nachvollziehbar bleibt, aus welchen Ursprungseinträgen ein finaler Datensatz entstanden ist.

Wichtige Felder der finalen Kundentabelle:

| Feld | Beschreibung |
|------|--------------|
| `kunde_id` | finale Kunden-ID |
| `quellen_datensaetze` | zusammengeführte Quelldatensätze |
| `anzahl_quell_datensaetze` | Anzahl der zusammengeführten Datensätze |

---

## 6. Erstellung der finalen Behandlungstabelle

Im nächsten Schritt wurden sämtliche Behandlungen auf die neu erzeugten Kunden referenziert.

```
final.verbund_behandlung
```

Da die vier Praxissysteme unterschiedliche Referenzierungsmechanismen verwenden, erfolgte die Zuordnung abhängig von der jeweiligen Quelle.

| Quelle | Verknüpfung |
|---------|-------------|
| Waldrand | direkte Zuordnung über Kunden-ID |
| Bergblick | direkte Zuordnung über Patienten-ID |
| Juckstadt | Zuordnung über den Nachnamen |
| Schmidt | Zuordnung über Nachname und Anfangsbuchstaben des Vornamens |

Die finale Kunden-ID wurde anschließend über die Mapping-Tabelle `final.kunde_mapping` übernommen.

---

## 7. Ergebnis der Behandlungstabelle

Nach der Erstellung der finalen Behandlungstabelle wurde überprüft, ob sämtliche Behandlungen erfolgreich einem finalen Kunden zugeordnet werden konnten.

| Quelle | Behandlungen | Ohne Kunden-ID |
|---------|-------------:|---------------:|
| Bergblick | 150 | 0 |
| Juckstadt | 150 | 0 |
| Schmidt | 150 | 0 |
| Waldrand | 150 | 0 |

Insgesamt enthält die finale Behandlungstabelle weiterhin **600 Behandlungen**. Alle Behandlungen konnten erfolgreich einer finalen Kunden-ID zugeordnet werden.

---

## 8. Zusammenfassung

Die Gold-Schicht wurde vollständig auf Basis des selbst entwickelten Matching-Algorithmus aufgebaut. Der bereitgestellte Goldstandard wurde ausschließlich zur Evaluation des Matchings (Precision, Recall und F1-Score) verwendet und nicht für die Erstellung der finalen Kundentabelle genutzt.

Erstellte Tabellen der Gold-Schicht:

- `final.matches`
- `final.kunde_nodes`
- `final.kunde_edges`
- `final.kunde_components`
- `final.kunde_mapping`
- `final.verbund_kunde`
- `final.verbund_behandlung`

Damit ist der vollständige ETL-Prozess erfolgreich abgeschlossen. Aus den normalisierten Quelldaten wurden zunächst Dubletten erkannt und anschließend zu einer konsistenten Gold-Schicht zusammengeführt. Die finale Behandlungstabelle referenziert vollständig auf die in der Gold-Schicht erzeugten Kunden.
