#!/bin/bash

input_file="MOCK_DATA.csv"
email_count=0
output_file="$(date +"%Y-%m-%d_%H-%M")_mailimports.csv"

letters_folder="$(date +"%Y-%m-%d_%H-%M")_letters"
mkdir "$letters_folder"

letter_template=$(cat <<EOF
Technische Berufsschule Zürich
Ausstellungsstrasse 70
8005 Zürich

Zürich, den $(date +"%d.%m.%Y")

[Vorname] [Nachname]
[Strasse] [StrNummer]
[Postleitzahl] [Ort]

Liebe:r [Vorname],

Es freut uns, Sie im neuen Schuljahr begrüßen zu dürfen.

Damit Sie am ersten Tag sich in unsere Systeme einloggen können, erhalten Sie hier Ihre neue E-Mail-Adresse und Ihr Initialpasswort, das Sie beim ersten Login ändern müssen.

E-Mail-Adresse:   [GenerierteEmailadresse]
Passwort:       [GeneriertesPasswort]


Mit freundlichen Grüßen,

Gabriel Pervorfi
(TBZ-IT-Service)


admin.it@tbz.ch, Abt. IT: +41 44 446 96 60
EOF
)

sanitize_string() {
  local string="$1"
  string=$(echo "$string" | iconv -f utf-8 -t ascii//TRANSLIT)
  string=$(echo "$string" | tr -cd '[:alnum:].')

  echo "$string"
}

declare -A name_counts
IFS=',' read -r _ < "$input_file"

while IFS=',' read -r _ firstname lastname _ street strnum zip city; do
  email_count=$((email_count + 1))
  sanitized_firstname=$(sanitize_string "$firstname")
  sanitized_lastname=$(sanitize_string "$lastname")

  email_address="${sanitized_firstname,,}.${sanitized_lastname,,}@edu.tbz.ch"
  password=$(openssl rand -base64 12)

  formatted_entry="[$email_address];[$password]"
  echo "$formatted_entry" >> "$output_file"

  letter_contents=$(sed -e "s/\[DATE]/$(date +"%d.%m.%Y")/g" \
    -e "s/\[Vorname]/$firstname/g" \
    -e "s/\[Nachname]/$lastname/g" \
    -e "s/\[Strasse]/$street/g" \
    -e "s/\[StrNummer]/$strnum/g" \
    -e "s/\[Postleitzahl]/$zip/g" \
    -e "s/\[Ort]/$city/g" \
    -e "s/\[GenerierteEmailadresse]/$email_address/g" \
    -e "s/\[GeneriertesPasswort]/$password/g" \
    -e "s/\[IhrVorname]/YourFirstName/g" \
    -e "s/\[IhrNachname]/YourLastName/g" <<< "$letter_template")
  letter_filename="$(date +"%Y-%m-%d_%H-%M")_$email_address.brf"
  echo "$letter_contents" > "$letters_folder/$letter_filename"
done < <(tail -n +2 "$input_file")

archive_filename="$(date +"%Y-%m-%d_%H-%M")_newMails.zip"
zip -r "$archive_filename" "$output_file" "$letters_folder"

my_email="your_email@example.com"
friend_email="friend_email@example.com"
email_subject="New TBZ Mail Addresses $email_count"

{
  echo "From: $my_email"
  echo "Subject: $email_subject"
  echo "MIME-Version: 1.0"
  echo "Content-Type: multipart/mixed; boundary=boundary_string"
  echo ""
  echo "--boundary_string"
  echo "Content-Type: text/plain; charset=utf-8"
  echo ""
  echo "Dear Friend,"
  echo ""
  echo "The email address generation is complete."
  echo "A total of $email_count addresses have been generated."
  echo ""
  echo "If you have any questions, please contact me at $my_email."
  echo ""
  echo "Regards,"
  echo "Gabriel Pervorfi"
  echo ""
  echo "--boundary_string"
  echo "Content-Type: application/octet-stream"
  echo "Content-Disposition: attachment; filename=\"$archive_filename\""
  echo "Content-Transfer-Encoding: base64"
  echo ""
  base64 -w 0 "./$archive_filename"
  echo ""
  echo "--boundary_string--"
} | ssmtp "$friend_email"
