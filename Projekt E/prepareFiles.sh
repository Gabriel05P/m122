#!/bin/bash

#wurde überarbeitet!

# Optionen
output_file=""
timestamp=$(date '+%Y-%m-%d_%H%M')
hostname=$(hostname)

# Hostname des Systems
hostname=$(hostname)

# Betriebssystemversion
os_version=$(grep "PRETTY_NAME" /etc/os-release | cut -d "=" -f 2 | tr -d '"')

# Modellname der CPU
cpu_model=$(grep "model name" /proc/cpuinfo | head -n 1 | cut -d ":" -f 2 | sed 's/^[ \t]*//')

# Anzahl der CPU-Cores
cpu_cores=$(grep "cpu cores" /proc/cpuinfo | head -n 1 | cut -d ":" -f 2 | sed 's/^[ \t]*//')

# Gesamter Arbeitsspeicher
total_memory=$(free -h | grep "Mem:" | tr -s ' ' | cut -d ' ' -f 2)

# Genutzter Arbeitsspeicher
used_memory=$(free -h | grep "Mem:" | tr -s ' ' | cut -d ' ' -f 3)

# Verfügbare Speichermenge
available_memory=$(free -h | grep "Mem:" | tr -s ' ' | cut -d ' ' -f 7)

# Freie Speichermenge
free_memory=$(free -h | grep "Mem:" | tr -s ' ' | cut -d ' ' -f 4)

# Gesamtgröße des Dateisystems
total_filesystem=$(df -h / | sed -n '2s/  */ /gp' | cut -d ' ' -f 2)

# Belegter Speicher auf dem Dateisystem
used_filesystem=$(df -h / | sed -n '2s/  */ /gp' | cut -d ' ' -f 3)

# Freier Speicher auf dem Dateisystem
free_filesystem=$(df -h / | sed -n '2s/  */ /gp' | cut -d ' ' -f 4)

# Aktuelle Systemlaufzeit
uptime=$(uptime -p)

# Aktuelle Systemzeit
current_time=$(date +"%T")

# Ausgabe der Informationen
width=15
print_output() {
printf "Hostname des Systems:\t\t\t\t%${width}s%s\n" "" "$hostname"
printf "Betriebssystemversion:\t\t\t\t%${width}s%s\n" "" "$os_version"
printf "Modellname der CPU:\t\t\t\t%${width}s%s\n" "" "$cpu_model"
printf "Anzahl der CPU-Cores:\t\t\t\t%${width}s%s\n" "" "$cpu_cores"
printf "Gesamter Arbeitsspeicher:\t\t\t%${width}s%s\n" "" "$total_memory"
printf "Genutzter Arbeitsspeicher:\t\t\t%${width}s%s\n" "" "$used_memory"
printf "Verfügbare Speichermenge:\t\t\t%${width}s%s\n" "" "$available_memory"
printf "Freie Speichermenge:\t\t\t\t%${width}s%s\n" "" "$free_memory"
printf "Gesamtgröße des Dateisystems:\t\t\t%${width}s%s\n" "" "$total_filesystem"
printf "Belegter Speicher auf dem Dateisystem:\t\t%${width}s%s\n" "" "$used_filesystem"
printf "Freier Speicher auf dem Dateisystem:\t\t%${width}s%s\n" "" "$free_filesystem"
printf "Aktuelle Systemlaufzeit:\t\t\t%${width}s%s\n" "" "$uptime"
}

# Optionen verarbeiten
while getopts ":f" opt; do
  case $opt in
    f)
      output_file="${timestamp}-sys-${hostname}.info"
      ;;
    \?)
      echo "Ungültige Option: -$OPTARG" >&2
      ;;
  esac
done

# Ausgabe in Datei, falls angegeben
if [ -n "$output_file" ]; then
  printf "Hostname des Systems:\t\t\t\t%${width}s%s\n" "" "$hostname" >> "$output_file"
  printf "Betriebssystemversion:\t\t\t\t%${width}s%s\n" "" "$os_version" >> "$output_file"
  printf "Modellname der CPU:\t\t\t\t%${width}s%s\n" "" "$cpu_model" >> "$output_file"
  printf "Anzahl der CPU-Cores:\t\t\t\t%${width}s%s\n" "" "$cpu_cores" >> "$output_file"
  printf "Gesamter Arbeitsspeicher:\t\t\t%${width}s%s\n" "" "$total_memory" >> "$output_file"
  printf "Genutzter Arbeitsspeicher:\t\t\t%${width}s%s\n" "" "$used_memory" >> "$output_file"
  printf "Verfügbare Speichermenge:\t\t\t%${width}s%s\n" "" "$available_memory" >> "$output_file"
  printf "Freie Speichermenge:\t\t\t\t%${width}s%s\n" "" "$free_memory" >> "$output_file"
  printf "Gesamtgröße des Dateisystems:\t\t\t%${width}s%s\n" "" "$total_filesystem" >> "$output_file"
  printf "Belegter Speicher auf dem Dateisystem:\t\t%${width}s%s\n" "" "$used_filesystem" >> "$output_file"
  printf "Freier Speicher auf dem Dateisystem:\t\t%${width}s%s\n" "" "$free_filesystem" >> "$output_file"
  printf "Aktuelle Systemlaufzeit:\t\t\t%${width}s%s\n" "" "$uptime" >> "$output_file"
  echo "Erzeugte Datei: $output_file"
fi

print_output

