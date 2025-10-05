#/usr/bin/env bash

choices="Performance\nBalanced\nPower saver"

# Show the rofi dmenu
selection=$(echo -e "$choices" | rofi -dmenu -p -i -theme $HOME/.config/rofi/launcher/current_theme/theme.rasi)

# Match the selection
case "$selection" in
	"Performance")
		powerprofilesctl set performance
		notify-send "Power profile" "Switch to Performance"
		;;
	"Balanced")
		powerprofilesctl set balanced
		notify-send "Power profile" "Switch to Balanced"
		;;
	"Power saver")
		powerprofilesctl set power-saver
		notify-send "Power profile" "Switch to Power saver"
		;;
	*)
		notify-send "No valid choice made..."
		;;
esac
