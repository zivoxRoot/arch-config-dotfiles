#/bin/bash

# NOTE: This script changes the rofi launcher look.
# It is ran by **$HOME/.config/hypr/**.
# It remove the **./current_launcer/current.rasi** and copy the chosen launcher look in **./current_launcer/current.rasi**.

CHOICE=$(echo -e "Horizontal launcher\nVertical launcher\nLarge launcher\nGrid launcher\nEasy launcher\nSimple launcher\nFull screen launcher\nLong grid launcher" | rofi -dmenu -theme $HOME/.config/rofi/launcher/current_launcher/current.rasi)

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
	"Grid launcher")
		rm "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		cp "$HOME/.config/rofi/launcher/grid_launcher.rasi" "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		;;
	"Easy launcher")
		rm "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		cp "$HOME/.config/rofi/launcher/easy_launcher.rasi" "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		;;
	"Simple launcher")
		rm "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		cp "$HOME/.config/rofi/launcher/simple_launcher.rasi" "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		;;
	"Full screen launcher")
		rm "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		cp "$HOME/.config/rofi/launcher/fullscreen_launcher.rasi" "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		;;
	"Long grid launcher")
		rm "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		cp "$HOME/.config/rofi/launcher/long_grid_launcher.rasi" "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
		;;
esac
