# m122
Projekt A
Code: 
#!/bin/bash

# Verzeichnis anlegen
mkdir _template 2>/dev/null

touch _template/file{1..3}.txt

namensdatei="M122-PE22a.txt"

verzeichnis_namensdateien="_namensdateien"
mkdir "$verzeichnis_namensdateien" 2>/dev/null

# Namendatei anlegen und Inhalte reinschreiben
echo -e "Amherd\nBaume-Schneider\nBerset\nCassis\nKeller-Sutter\nParmelin\nRoesti" > "$verzeichnis_namensdateien/$namensdatei"

# Gleich noch eine zweite Namensdatei
namensdatei="M122-PE22b.txt"
echo -e "Burkhart\nChiesa\nJositsch\nNoser\nArlind\nHarun" > "$verzeichnis_namensdateien/$namensdatei"

# erstellt alle Verzeichnisse und kopiert die
# Template-Dateien in alle Teilnehmer aller Klassen

verzeichnis_template="_template"
verzeichnis_namensdateien="_namensdateien"

allFiles=($(ls -1 "$verzeichnis_namensdateien"))

for file in "${allFiles[@]}"; do
  fileNameVorPunkt="${file%.*}"
  klasse="$fileNameVorPunkt"
  fileinhalt=$(cat "$verzeichnis_namensdateien/$file")

  IFS=$'\n' read -d '' -r -a teilnehmerArray <<< "$fileinhalt"

  for teilnehmer in "${teilnehmerArray[@]}"; do
    mkdir -p "$verzeichnis_namensdateien/$klasse/$teilnehmer"
    cp "$verzeichnis_template"/* "$verzeichnis_namensdateien/$klasse/$teilnehmer"
  done
done
