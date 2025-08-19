#!/usr/bin/env bash

THEME_FILE="$HOME/.cache/hyprland-theme"
DEFAULT_THEME="dark"

# Set notification parameters
NOTIF_ID=1012     # Unique ID for hyprsunset notification
URGENCY="normal"
TIMEOUT=1500      # Notification timeout in milliseconds

# Ensure the theme file exists
[ ! -f "$THEME_FILE" ] && echo "$DEFAULT_THEME" > "$THEME_FILE"

# Read the current theme
CURRENT_THEME=$(cat "$THEME_FILE")

# Toggle the theme
if [ "$CURRENT_THEME" = "dark" ]; then
    NEW_THEME="light"
else
    NEW_THEME="dark"
fi

# Update the theme file
echo "$NEW_THEME" > "$THEME_FILE"

# Send or update notification
notify-send -h int:transient:1 -r $NOTIF_ID -u $URGENCY -t $TIMEOUT \
    "Theme switcher" "You just switched to ${NEW_THEME} theme"

# Switch the theme to $NEW_THEME
if [ "$NEW_THEME" = "light" ]; then
    wal -i ~/.cache/current_wallpaper/current.jpg -l -n --cols16
else
    wal -i ~/.cache/current_wallpaper/current.jpg -n --cols16
fi