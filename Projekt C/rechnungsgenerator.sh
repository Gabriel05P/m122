#!/bin/bash

data_file="x-ressourcen/rechnung23003.data"
csv_file="rechnung23003.csv"

# Extrahiere Informationen aus der .data-Datei
invoice_info=$(head -n 1 "$data_file" | tr ';' '\n')
origin_info=$(sed -n '2p' "$data_file" | tr ';' '\n')
customer_info=$(sed -n '3p' "$data_file" | tr ';' '\n')
invoice_items=$(tail -n +4 "$data_file")

invoice_number=$(echo "$invoice_info" | sed -n '1p')
order_number=$(echo "$invoice_info" | sed -n '2p')
location=$(echo "$invoice_info" | sed -n '3p')
date=$(echo "$invoice_info" | sed -n '4p')
time=$(echo "$invoice_info" | sed -n '5p')
payment_terms=$(echo "$invoice_info" | sed -n '6p')

origin_type=$(echo "$origin_info" | sed -n '1p')
origin_account=$(echo "$origin_info" | sed -n '2p')
origin_reference=$(echo "$origin_info" | sed -n '3p')
origin_name=$(echo "$origin_info" | sed -n '4p')
origin_address=$(echo "$origin_info" | sed -n '5p')
origin_city=$(echo "$origin_info" | sed -n '6p')
origin_vat=$(echo "$origin_info" | sed -n '7p')
origin_email=$(echo "$origin_info" | sed -n '8p')

customer_type=$(echo "$customer_info" | sed -n '1p')
customer_account=$(echo "$customer_info" | sed -n '2p')
customer_name=$(echo "$customer_info" | sed -n '3p')
customer_address=$(echo "$customer_info" | sed -n '4p')
customer_city=$(echo "$customer_info" | sed -n '5p')

# Erstelle die CSV-Datei
echo "Rechnung_$invoice_number;Auftrag_$order_number;$location;$date;$time;$payment_terms" > "$csv_file"
echo "Herkunft;$origin_account;$origin_reference;$origin_name;$origin_address;$origin_city;$origin_vat;$origin_email" >> "$csv_file"
echo "Endkunde;$customer_account;;$customer_name;$customer_address;$customer_city" >> "$csv_file"

echo "$invoice_items" >> "$csv_file"

echo "Die Datei '$csv_file' wurde erfolgreich erstellt."
