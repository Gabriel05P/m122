#!/bin/bash

# Funktion zur Ausgabe der Informationen
print_output() {
  width=15
  printf "%-${width}s%s\n" "Hostname des Systems:" "$hostname"
  printf "%-${width}s%s\n" "Betriebssystemversion:" "$os_version"
  printf "%-${width}s%s\n" "Modellname der CPU:" "$cpu_model"
  printf "%-${width}s%s\n" "Anzahl der CPU-Cores:" "$cpu_cores"
  printf "%-${width}s%s\n" "Gesamter Arbeitsspeicher:" "$total_memory"
  printf "%-${width}s%s\n" "Genutzter Arbeitsspeicher:" "$used_memory"
  printf "%-${width}s%s\n" "Verfügbare Speichermenge:" "$available_memory"
  printf "%-${width}s%s\n" "Freie Speichermenge:" "$free_memory"
  printf "%-${width}s%s\n" "Gesamtgröße des Dateisystems:" "$total_filesystem"
  printf "%-${width}s%s\n" "Belegter Speicher auf dem Dateisystem:" "$used_filesystem"
  printf "%-${width}s%s\n" "Freier Speicher auf dem Dateisystem:" "$free_filesystem"
  printf "%-${width}s%s\n" "Aktuelle Systemlaufzeit:" "$uptime"
}

# Hostname des Systems
hostname=$(hostname)

# Betriebssystemversion
os_version=$(grep "PRETTY_NAME" /etc/os-release | cut -d "=" -f 2 | tr -d '"')

# Modellname der CPU
cpu_model=$(grep "model name" /proc/cpuinfo | head -n 1 | cut -d ":" -f 2 | sed 's/^[ \t]*//')

# Anzahl der CPU-Cores
cpu_cores=$(grep "cpu cores" /proc/cpuinfo | head -n 1 | cut -d ":" -f 2 | sed 's/^[ \t]*//')

# Gesamter Arbeitsspeicher
memory_info=$(free -h | grep "Mem:")
total_memory=$(echo "$memory_info" | awk '{print $2}')
used_memory=$(echo "$memory_info" | awk '{print $3}')
available_memory=$(echo "$memory_info" | awk '{print $7}')
free_memory=$(echo "$memory_info" | awk '{print $4}')

# Gesamtgröße des Dateisystems
filesystem_info=$(df -h / | sed -n '2s/  */ /gp')
total_filesystem=$(echo "$filesystem_info" | awk '{print $2}')
used_filesystem=$(echo "$filesystem_info" | awk '{print $3}')
free_filesystem=$(echo "$filesystem_info" | awk '{print $4}')

# Aktuelle Systemlaufzeit
uptime=$(uptime -p)

# Ausgabe der Informationen
print_output
