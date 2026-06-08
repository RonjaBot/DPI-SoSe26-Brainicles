from lxml import etree
import pandas as pd
import duckdb

XML_FILE = "fallstudie_datenmanagement_master/verbund/praxis_bergblick_export.xml"
DB_FILE = "data/duckDB/dpi.duckdb"

NS = {"v": "http://vetkliniken-hessen.de/schema/v2"}
QUELL_DATEI = "praxis_bergblick_export.xml"


def text_or_none(element, path):
    if element is None:
        return None
    return element.findtext(path, namespaces=NS)


def extract_patienten(root):
    rows = []

    for index, patient in enumerate(root.findall(".//v:patient", namespaces=NS), start=1):
        halter = patient.find("v:halter", namespaces=NS)
        tier = patient.find("v:tier", namespaces=NS)
        kontakt = halter.find("v:kontakt", namespaces=NS) if halter is not None else None
        adresse = halter.find("v:adresse", namespaces=NS) if halter is not None else None
        telefon = kontakt.find("v:telefon", namespaces=NS) if kontakt is not None else None

        rows.append({
            "patient_id": patient.get("id"),
            "halter_erfasst": halter.get("erfasst") if halter is not None else None,
            "halter_anrede": text_or_none(halter, "v:anrede"),
            "halter_name": text_or_none(halter, "v:name"),
            "telefon": telefon.text if telefon is not None else None,
            "telefon_typ": telefon.get("typ") if telefon is not None else None,
            "email": text_or_none(kontakt, "v:email"),
            "strasse": text_or_none(adresse, "v:strasse"),
            "plz": text_or_none(adresse, "v:plz"),
            "ort": text_or_none(adresse, "v:ort"),
            "tier_name": text_or_none(tier, "v:name"),
            "tier_art": text_or_none(tier, "v:art"),
            "tier_geburt": text_or_none(tier, "v:geburt"),
            "quell_zeile": str(index),
            "quell_datei": QUELL_DATEI
        })

    return pd.DataFrame(rows).astype(str)


def extract_behandlungen(root):
    rows = []

    for index, behandlung in enumerate(root.findall(".//v:behandlung", namespaces=NS), start=1):
        summe = behandlung.find("v:summe", namespaces=NS)

        rows.append({
            "patient_id": behandlung.get("patientId"),
            "datum": behandlung.get("datum"),
            "diagnose": text_or_none(behandlung, "v:diagnose"),
            "netto": summe.get("netto") if summe is not None else None,
            "brutto": summe.get("brutto") if summe is not None else None,
            "quell_zeile": str(index),
            "quell_datei": QUELL_DATEI
        })

    return pd.DataFrame(rows).astype(str)


def main():
    tree = etree.parse(XML_FILE)
    root = tree.getroot()

    df_patienten = extract_patienten(root)
    df_behandlungen = extract_behandlungen(root)

    con = duckdb.connect(DB_FILE)

    con.execute("CREATE SCHEMA IF NOT EXISTS staging;")
    con.execute("CREATE SCHEMA IF NOT EXISTS transform;")
    con.execute("CREATE SCHEMA IF NOT EXISTS final;")

    con.execute("DROP TABLE IF EXISTS staging.berg_patienten;")
    con.register("df_patienten", df_patienten)
    con.execute("CREATE TABLE staging.berg_patienten AS SELECT * FROM df_patienten;")

    con.execute("DROP TABLE IF EXISTS staging.berg_behandlungen;")
    con.register("df_behandlungen", df_behandlungen)
    con.execute("CREATE TABLE staging.berg_behandlungen AS SELECT * FROM df_behandlungen;")

    print("staging.berg_patienten:", len(df_patienten))
    print("staging.berg_behandlungen:", len(df_behandlungen))

    con.close()


if __name__ == "__main__":
    main()
