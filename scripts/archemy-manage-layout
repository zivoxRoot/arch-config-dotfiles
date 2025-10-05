#!/usr/bin/env bash

# Find the primary keyboard name
DEVICE=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .name' | head -n 1)
if [ -n "$DEVICE" ]; then
    hyprctl switchxkblayout "$DEVICE" next
else
    echo "No primary keyboard found."
fi
