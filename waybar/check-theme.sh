#!/usr/bin/env bash

THEME_FILE="$HOME/.cache/hyprland-theme"
DEFAULT_THEME="dark"

# Ensure the theme file exists
[ ! -f "$THEME_FILE" ] && echo "$DEFAULT_THEME" > "$THEME_FILE"

# Read the current theme
CURRENT_THEME=$(cat "$THEME_FILE")
if [ "$CURRENT_THEME" = "light" ]; then
    echo "☀︎"
else
    echo "☾"
fi