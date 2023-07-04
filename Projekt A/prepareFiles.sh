
#!/bin/bash


verzeichnis_template="_template"
mkdir "$verzeichnis_template" 2>/dev/null
cd "$verzeichnis_template"

# Vorlagendateien erstellen
echo "datei-1.txt" > datei-1.txt
echo "datei-2.docx" > datei-2.docx
echo "datei-3.pdf" > datei-3.pdf
echo "datei-4.xlsx" > datei-4.xlsx

cd ..

# Verzeichnis für die Namensdateien erstellen
verzeichnis_namensdateien="_namensdateien"
mkdir "$verzeichnis_namensdateien" 2>/dev/null
cd "$verzeichnis_namensdateien"

# Erste Namensdatei erstellen
namensdatei="M122-BR23a.txt"
echo "Amherd" > "$namensdatei"
echo "Baume-Schneider" >> "$namensdatei"
echo "Berset" >> "$namensdatei"
echo "Cassis" >> "$namensdatei"
echo "Keller-Sutter" >> "$namensdatei"
echo "Parmelin" >> "$namensdatei"
echo "Roesti" >> "$namensdatei"

# Zweite Namensdatei erstellen
namensdatei="M122-SR23a.txt"
echo "Burkhart" > "$namensdatei"
echo "Chiesa" >> "$namensdatei"
echo "Jositsch" >> "$namensdatei"
echo "Noser" >> "$namensdatei"

cd ..

# Iteration über Namensdateien
allFiles=$(ls "$verzeichnis_namensdateien")

for file in $allFiles; do
        fileNameVorPunkt="${file%.*}"
        klasse="$fileNameVorPunkt"
        fileinhalt=$(cat "$verzeichnis_namensdateien/$file")
        IFS=$'\n' read -rd '' -a teilnehmer_arr <<< "$fileinhalt"
        for teilnehmer in "${teilnehmer_arr[@]}"; do
                mkdir -p "$verzeichnis_namensdateien/$klasse/$teilnehmer"
                cp "$verzeichnis_template"/* "$verzeichnis_namensdateien/$klasse/$teilnehmer/"
        done
done