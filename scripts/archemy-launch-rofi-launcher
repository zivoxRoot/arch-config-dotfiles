#/bin/bash

# NOTE: This script simply launch a rofi menu using the current rofi theme stored in **./current_theme/theme.rasi**
# It checks if there is a **theme.rasi** file, if not it default to another theme.

# Check that current_theme folder exists
if [[ ! -e $HOME/.config/rofi/launcher/current_theme ]]; then
	mkdir $HOME/.config/rofi/launcher/current_theme
fi

# Check that theme.rasi exist
if [[ ! -e $HOME/.config/rofi/launcher/current_theme/theme.rasi ]]; then
	notify-send "Rofi launcher" "No rofi theme found, copying default theme"
	cp ./themes/horizontal.rasi ./current_theme/theme.rasi
fi

# Launch rofi
rofi -show drun -theme $HOME/.config/rofi/launcher/current_theme/theme.rasi
