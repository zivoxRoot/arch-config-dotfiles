#!/usr/bin/env bash

# Define the menu options
CLEAR_OPTION="Clear History"
OPEN_MENU_OPTION="Open Clipboard Menu"

# Show rofi menu with the options
selected=$(echo -e "$CLEAR_OPTION\n$OPEN_MENU_OPTION" | rofi -dmenu -theme $HOME/.config/rofi/widgets/clipboard-menu/clipboard-menu.rasi)

# Handle the selection
if [ -n "$selected" ]; then
    if [ "$selected" = "$CLEAR_OPTION" ]; then
        cliphist wipe
        notify-send "Clipboard" "History cleared"
    elif [ "$selected" = "$OPEN_MENU_OPTION" ]; then
        # Open the main clipboard menu
		rofi -modi clipboard:$HOME/.config/rofi/widgets/clipboard-menu/clipboard-menu.sh -show clipboard -show-icons -theme $HOME/.config/rofi/widgets/clipboard-menu/clipboard-menu.rasi
    fi
fi
