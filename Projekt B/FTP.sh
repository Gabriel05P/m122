#!/bin/bash

# ...
# Vorheriger Code bleibt unverändert

# Stufe 5 - FTP-Transfer
ftp_server="52.86.56.4"
ftp_username="user21"
ftp_password="MH64GR33"

# Verbindung zum FTP-Server herstellen und Archivdatei hochladen
sftp "$ftp_username@$ftp_server" <<EOF
cd /remote/path/to/directory  # Ersetze "/remote/path/to/directory" mit dem Zielverzeichnis auf dem FTP-Server
put "$archive_filename"
EOF