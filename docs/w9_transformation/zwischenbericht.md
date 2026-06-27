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

##6 Optimierte Matching-Variante

Auf Basis der Fehleranalyse wurde die zweite Matching-Variante anschließend weiter verbessert. Dabei zeigte sich, dass mehrere tatsächliche Dubletten nicht erkannt wurden, obwohl sie dieselbe normalisierte Telefonnummer sowie sehr ähnliche Nachnamen und Straßenangaben aufwiesen. Diese Fälle erreichten im ursprünglichen Scoring nur 50 Punkte und lagen damit unter dem gewählten Schwellwert.

Deshalb wurde eine zusätzliche regelbasierte Entscheidungsregel ergänzt:

Wenn die normalisierte Telefonnummer übereinstimmt und sowohl der Nachname als auch die Straße eine hohe Levenshtein-Ähnlichkeit aufweisen, wird das Kandidatenpaar ebenfalls als Match klassifiziert.

### Zusätzliche Regel

* Senkung des Schwellwerts von **60 auf 55 Punkten**
* gleiche normalisierte Telefonnummer
* Nachnamen-Ähnlichkeit mindestens **0,85**
* Straßen-Ähnlichkeit mindestens **0,80**

### Ergebnis der optimierten Variante

| Kennzahl        | Wert   |
| --------------- | ------ |
| Kandidatenpaare | 1.789  |
| True Positives  | 125    |
| False Positives | 1      |
| False Negatives | 11     |
| Precision       | 0,9921 |
| Recall          | 0,9191 |
| F1-Score        | 0,9542 |

Durch diese Erweiterung konnten deutlich mehr echte Dubletten erkannt werden. Die Anzahl der True Positives stieg von 96 auf 125, während die False Positives unverändert bei 1 blieben. Dadurch verbesserte sich insbesondere der Recall von 0,7059 auf 0,9191. Gleichzeitig stieg der F1-Score deutlich von 0,8240 auf 0,9542. Die optimierte Variante stellt damit die beste bisher getestete Matching-Variante dar.

## 7. Bewertung der Ergebnisse

Die drei getesteten Varianten verdeutlichen, wie sich unterschiedliche Matching-Regeln auf die Erkennungsqualität auswirken.

* Die **erste Variante** erkennt einen Großteil der tatsächlichen Dubletten, erzeugt jedoch vergleichsweise viele False Positives.
* Die **zweite Variante** nutzt zusätzlich String-Ähnlichkeiten für Nachname und Straße. Dadurch werden Fehlmatches deutlich reduziert und die Precision erhöht, allerdings werden einige echte Dubletten nicht mehr erkannt.
* Die **optimierte dritte Variante** kombiniert den regelbasierten Score mit einer zusätzlichen Entscheidungsregel für Datensätze mit identischer Telefonnummer sowie hoher Nachnamen- und Straßenähnlichkeit. Zusätzlich wurde der Schwellwert von 60 auf 55 Punkte angepasst. Dadurch konnten deutlich mehr echte Dubletten erkannt werden, ohne die Anzahl der False Positives zu erhöhen.

Für die weitere Bearbeitung wird die **optimierte dritte Variante** verwendet. Sie erzielt mit einer Precision von **0,9921**, einem Recall von **0,9191** und einem **F1-Score von 0,9542** die beste Gesamtleistung aller getesteten Matching-Varianten und eignet sich daher am besten als Grundlage für die Erstellung der Gold-Schicht.


---

## 8. Nächste Schritte

Als nächster Schritt sollen die erkannten Dubletten zu einer Gold-Schicht zusammengeführt werden. Dafür wird auf Basis der Matching-Ergebnisse eine finale Kundentabelle aufgebaut:

* `final.verbund_kunde`

In dieser Tabelle soll jede reale Person nur noch einmal vorkommen. Dabei müssen Konflikte dokumentiert werden, z. B. welcher Wert bei abweichenden Telefonnummern, Namen oder Adressen übernommen wird. Anschließend können die Behandlungen auf die zusammengeführten Kunden referenziert werden.

