#!/bin/bash

# NOTE: Script inspird by JaKooLit (https://github.com/JaKooLit) and Abhra00 (https://github.com/Abhra00)

iconsDir="$HOME/.config/rofi/launcher/assets"
rofiThemeFile="$HOME/.config/rofi/wallpaper-select/wallpaper-select.rasi"

# Rofi arguments
rofiArgs="rofi -show -dmenu -theme $rofiThemeFile"

# getPics retrieves image files as a list
getPics() {
	PICS=($(find -L "${iconsDir}" -type f \( -iname \*.jpg \) | sort ))
}

# Change the rofi theme
applyTheme() {

	choice=$(basename $selectedTheme | cut -d. -f1)

	# Remove the current rofi theme if it exists
	if [[ -e "$HOME/.config/rofi/launcher/current_launcher/current.rasi" ]]; then
		rm "$HOME/.config/rofi/launcher/current_launcher/current.rasi"
	fi

	# Copy the theme file into current_launcher folder
	cp "$HOME/.config/rofi/launcher/themes/${choice}.rasi" "$HOME/.config/rofi/launcher/current_launcher/current.rasi"

}

# Show the themes
displayThemes() {
	for i in "${!PICS[@]}"; do
		printf "$(basename "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${PICS[$i]}\n"
	done
}

launchSelector() {
	choice=$(displayThemes | ${rofiArgs})

	# No choice case
	if [[ -z $choice ]]; then
		exit 0
	fi

	# Find the selected theme
	for file in "${PICS[@]}"; do
		# Get the theme
		if [[ "$(basename "$file" | cut -d. -f1)" = "$choice" ]]; then
			selectedTheme="$file"
			break
		fi
	done

	# Check the theme and execute
	if [[ -n "$selectedTheme" ]]; then
		applyTheme "${selectedTheme}"
		return 0
	else
		notify-send "Rofi theme switcher" "The does not exist"
		exit 1
	fi
}

# Call the necessary functions
getPics

launchSelector
