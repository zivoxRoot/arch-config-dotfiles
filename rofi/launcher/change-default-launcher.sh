#/bin/bash

# NOTE: This script changes the rofi launcher look.
# It is ran by **$HOME/.config/hypr/**.
# It remove the **./current_launcer/current.rasi** and copy the chosen launcher look in **./current_launcer/current.rasi**.

CHOICE=$(echo -e "Horizontal launcher\nVertical launcher\nLarge launcher" | rofi -dmenu -p "Choose your rofi theme" -theme $HOME/.config/rofi/launcher/current_launcher/current.rasi)

case "$CHOICE" in
	"Horizontal launcher")
		rm "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		cp "$HOME/.config/rofi/launcher/horizontal_launcher.rasi" "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		;;
	"Vertical launcher")
		rm "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		cp "$HOME/.config/rofi/launcher/vertical_launcher.rasi" "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		;;
	"Large launcher")
		rm "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		cp "$HOME/.config/rofi/launcher/large_launcher.rasi" "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		;;
esac
