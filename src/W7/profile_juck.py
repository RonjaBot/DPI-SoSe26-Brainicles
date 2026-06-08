#import pandas as pd

#df = pd.read_csv(
 #   "../fallstudie_datenmanagement_master/verbund/praxis_juckstadt_kunden.csv",
  #  sep=";"
#)

#print(df.head())

#print("\nZEILEN UND SPALTEN:")
#print(df.shape)

#print("\nSPALTENNAMEN:")
#print(df.columns)

#print("\nFEHLENDE WERTE:")
#print(df.isnull().sum())

#print("\nANZAHL DISTINCT VALUES:")
#print(df.nunique())

import pandas as pd

datei = "../fallstudie_datenmanagement_master/verbund/praxis_juckstadt_behandlungen.csv"
separator = ";"

df = pd.read_csv(datei, sep=separator)

print(df.head())

print("\nZEILEN UND SPALTEN:")
print(df.shape)

print("\nSPALTENNAMEN:")
print(df.columns)

print("\nFEHLENDE WERTE:")
print(df.isnull().sum())

print("\nANZAHL DISTINCT VALUES:")
print(df.nunique())
