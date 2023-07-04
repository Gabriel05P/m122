
#!/bin/bash


verzeichnis_template="_template"
mkdir "$verzeichnis_template" 2>/dev/null


# Vorlagendateien erstellen
echo "datei-1.txt" > $verzeichnis_template/datei-1.txt
echo "datei-2.docx" > $verzeichnis_template/datei-2.docx
echo "datei-3.pdf" > $verzeichnis_template/datei-3.pdf
echo "datei-4.xlsx" > $verzeichnis_template/datei-4.xlsx


# Verzeichnis für die Namensdateien erstellen
verzeichnis_namensdateien="_namensdateien"
mkdir "$verzeichnis_namensdateien" 2>/dev/null


# Erste Namensdatei erstellen
namensdatei="M122-BR23a.txt"
echo -e "Amherd\nBaume-Schneider\nBerset\nCassis\nKeller-Sutter\nParmelin\nRoesti" > "$verzeichnis_namensdateien/$namensdatei"


# Zweite Namensdatei erstellen
namensdatei="M122-SR23a.txt"
echo -e "Burkhart\nChiesa\nJositsch\nNoser" > "$verzeichnis_namensdateien/$namensdatei"



# Iteration über Namensdateien
allFiles=$(ls "$verzeichnis_namensdateien")

for file in $allFiles; do
        klasse="${file%.*}"
        fileinhalt=$(cat "$verzeichnis_namensdateien/$file")
        IFS=$'\n' read -rd '' -a teilnehmer_arr <<< "$fileinhalt"
        for teilnehmer in "${teilnehmer_arr[@]}"; do
                mkdir -p "$verzeichnis_namensdateien/$klasse/$teilnehmer"
                cp "$verzeichnis_template"/* "$verzeichnis_namensdateien/$klasse/$teilnehmer/"
        done
done
