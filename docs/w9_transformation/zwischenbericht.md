# Zwischenbericht W9 – Transformation und Matching

## 1. Ziel des Meilensteins

Ziel von W9 war es, auf Basis der in W8 erstellten Staging-Schicht eine harmonisierte Transformationsschicht aufzubauen und darauf einen ersten regelbasierten Dublettenabgleich umzusetzen. Die Rohdaten im Schema `staging` wurden dabei unverändert gelassen. Alle Transformationen erfolgen ausschließlich im Schema `transform`.

---

## 2. Transformation und Normalisierung

Für die Transformation wurden die Daten aller vier Praxen aus der Staging-Schicht in ein gemeinsames Zielschema überführt. Dabei wurden die ursprünglich unterschiedlichen Feldnamen, Formate und Strukturen vereinheitlicht.

Erstellt wurden zunächst quellenspezifische Transformationstabellen:

* `transform.norm_juck_kunden`
* `transform.norm_wald_kunden`
* `transform.norm_schm_kunden`
* `transform.norm_berg_patienten`
* `transform.norm_juck_behandlungen`
* `transform.norm_wald_behandlungen`
* `transform.norm_schm_behandlungen`
* `transform.norm_berg_behandlungen`

Anschließend wurden diese Tabellen zu zwei gemeinsamen Tabellen zusammengeführt:

* `transform.norm_kunde`
* `transform.norm_behandlung`

Die Tabelle `transform.norm_kunde` enthält 916 Kundendatensätze. Die Tabelle `transform.norm_behandlung` enthält 600 Behandlungsdatensätze.

### Umgesetzte Normalisierungen

Folgende Normalisierungsregeln wurden umgesetzt:

| Bereich        | Ausgangsproblem                              | Umsetzung                                                           |
| -------------- | -------------------------------------------- | ------------------------------------------------------------------- |
| Datumswerte    | Unterschiedliche Datumsformate je Quelle     | Umwandlung in ISO-Format `YYYY-MM-DD`                               |
| Telefonnummern | Leerzeichen, Sonderzeichen, Vorwahlvarianten | Normalisierung auf Ziffernfolge                                     |
| Kostenwerte    | Komma/Punkt und Währungstexte                | Umwandlung in numerische Werte                                      |
| Tierarten      | Deutsch/Englisch gemischt                    | Harmonisierung, z. B. `dog` → `Hund`, `cat` → `Katze`               |
| Namen          | Vollname bzw. getrennte Namensfelder         | Vereinheitlichung in `vorname` und `nachname`                       |
| Quellbezug     | Unterschiedliche IDs je Praxis               | Mitführen von `quelle`, `quell_id`, `quell_zeile` und `quell_datei` |

Damit ist die Transformationsschicht als harmonisierte Silver-Schicht aufgebaut.

---

## 3. Goldstandard

Zur Bewertung des Matchings wurde die Datei `gold_cluster.csv` in die Tabelle `transform.gold_cluster` geladen. Der Goldstandard enthält 916 Datensätze und ordnet jedem Quelldatensatz eine `cluster_id` zu.

Anschließend wurde der Goldstandard mit `transform.norm_kunde` verknüpft. Die Prüfung ergab, dass alle 916 Kundendatensätze erfolgreich einer Gold-Cluster-ID zugeordnet werden konnten. Es gab keine Datensätze ohne Cluster-Zuordnung.

---

## 4. Matching-Ansatz

Für Szenario A wurde ein deterministischer, regelbasierter Matching-Ansatz gewählt. Ziel war es, Datensätze zu identifizieren, die dieselbe reale Person bezeichnen.

Zunächst wurde eine einfache Matching-Regel getestet. Kandidatenpaare wurden gebildet, wenn entweder die E-Mail-Adresse oder die normalisierte Telefonnummer übereinstimmte. Zusätzlich wurde die Übereinstimmung des Nachnamens in den Score einbezogen.

### Erste Matching-Variante

Regel:

* gleiche E-Mail-Adresse: 50 Punkte
* gleiche normalisierte Telefonnummer: 30 Punkte
* gleicher Nachname: 20 Punkte
* Schwellwert: mindestens 50 Punkte

Ergebnis:

| Kennzahl        |   Wert |
| --------------- | -----: |
| True Positives  |    122 |
| False Positives |     58 |
| False Negatives |      4 |
| Precision       | 0,6778 |
| Recall          | 0,9683 |
| F1-Score        | 0,7974 |

Diese Variante erzielte einen sehr hohen Recall. Das bedeutet, dass fast alle tatsächlichen Dubletten erkannt wurden. Gleichzeitig war die Precision vergleichsweise niedrig, da relativ viele falsche Treffer erzeugt wurden.

---

## 5. Erweiterte Matching-Variante mit String-Ähnlichkeit

Da Szenario A einen regelbasierten Ansatz mit String-Ähnlichkeit vorsieht, wurde eine zweite Variante auf Basis von Levenshtein-Ähnlichkeit ergänzt. Dafür wurden zusätzliche Kandidatenpaare gebildet, wenn Postleitzahl und Anfangsbuchstabe des Nachnamens übereinstimmten. Anschließend wurden Ähnlichkeiten für Nachname und Straße berechnet.

### Zweite Matching-Variante

Berücksichtigte Merkmale:

* E-Mail-Übereinstimmung
* Telefonnummern-Übereinstimmung
* Levenshtein-Ähnlichkeit des Nachnamens
* Levenshtein-Ähnlichkeit der Straße
* Blocking über Postleitzahl und Anfangsbuchstaben des Nachnamens

Ergebnis:

| Kennzahl        |   Wert |
| --------------- | -----: |
| Kandidatenpaare |  1.789 |
| True Positives  |     96 |
| False Positives |      1 |
| False Negatives |     40 |
| Precision       | 0,9897 |
| Recall          | 0,7059 |
| F1-Score        | 0,8240 |

Diese Variante liefert eine deutlich höhere Precision. Das bedeutet, dass fast alle vorhergesagten Matches tatsächlich korrekt sind. Der Recall fällt jedoch niedriger aus, da einige echte Dubletten nicht mehr erkannt werden. Insgesamt verbessert sich der F1-Score gegenüber der ersten Variante leicht von 0,7974 auf 0,8240.

---

## 6. Bewertung der Ergebnisse

Die beiden Varianten zeigen den typischen Precision-Recall-Trade-off im Matching:

* Die erste Variante ist großzügiger und erkennt fast alle echten Dubletten, erzeugt aber mehr False Positives.
* Die zweite Variante ist strenger und erzeugt kaum falsche Treffer, übersieht dafür aber mehr echte Dubletten.

Für die weitere Bearbeitung wird die zweite Variante bevorzugt, da sie durch die Einbindung von String-Ähnlichkeit fachlich besser zum deterministischen Szenario A passt und eine höhere Gesamtgüte nach F1-Score erreicht.

---

## 7. Nächste Schritte

Als nächster Schritt sollen die erkannten Dubletten zu einer Gold-Schicht zusammengeführt werden. Dafür wird auf Basis der Matching-Ergebnisse eine finale Kundentabelle aufgebaut:

* `final.verbund_kunde`

In dieser Tabelle soll jede reale Person nur noch einmal vorkommen. Dabei müssen Konflikte dokumentiert werden, z. B. welcher Wert bei abweichenden Telefonnummern, Namen oder Adressen übernommen wird. Anschließend können die Behandlungen auf die zusammengeführten Kunden referenziert werden.

