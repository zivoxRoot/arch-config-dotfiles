#!/usr/bin/env bash

LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap' | head -n 1)
case "$LAYOUT" in
    "Russian") echo "Ru" ;;
    "French") echo "Fr" ;;
    *) echo "$LAYOUT ?" ;;
esac
