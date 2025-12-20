#!/usr/bin/env bash

# Fichier temporaire
IMG="/tmp/cts_$(date +%s).png"

# 1. Sélection de zone et capture
grim -g "$(slurp)" "$IMG"

# 2. Upload vers Google Lens (Google Images recherche par image)
# Google Lens accepte l'upload direct via POST multipart
RESPONSE=$(curl -s -X POST \
  -H "Content-Type: multipart/form-data" \
  -F "encoded_image=@${IMG}" \
  -F "image_url=" \
  "https://lens.google.com/upload")

# 3. Extraire l'URL de redirection
URL=$(echo "$RESPONSE" | grep -o 'https[^"]\+')

# 4. Ouvrir le navigateur
if [[ -n "$URL" ]]; then
    xdg-open "$URL"
else
    notify-send "Circle to Search" "Upload failed"
fi
