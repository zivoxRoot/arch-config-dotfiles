#!/usr/bin/bash

# NOTE: Original script from JaKooLit (https://github.com/JaKooLit) and Abhra00 (https://github.com/Abhra00/Hyprland-Wallust/blob/main/hypr/scripts/wallSelect.sh)

# Wallpapers Path
wallpaperDir="$HOME/Picture/wallpapers"
themesDir="$HOME/.config/rofi/wallpaper-select"

# Transition config
FPS=60
TYPE="grow"
DURATION=3
BEZIER="0.4,0.2,0.4,1.0"
TRANSITION_POS="0.7,0.7"
SWWW_PARAMS="--transition-fps ${FPS} --transition-type ${TYPE} --transition-duration ${DURATION} --transition-bezier ${BEZIER} --transition-pos ${TRANSITION_POS}"

# Retrieve image files as a list
PICS=($(find -L "${wallpaperDir}" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \) | sort ))

# Rofi command
rofiCommand="rofi -show -dmenu -theme ${themesDir}/wallpaper-select.rasi"

# Execute command according the wallpaper manager
executeCommand() {

	# Set the wallpaper
	if command -v swww &>/dev/null; then
		swww img "$1" ${SWWW_PARAMS}

	else
		notify-send "Wallpaper switch" "Swww is not installed"
		echo "Wallpaper switch : Swww is not installed"
		exit 1
	fi

	# Set the pywal16 theme
	wal -i "${1}" -n --cols16

	# Cache the current wallpaper for hyprlock to use it
	cp "${1}" "$HOME/.cache/current_wallpaper/current.jpg"

	# Reload waybar
	pkill waybar && waybar &

	# Reload tmux theme and reload tmux
	bash $HOME/.config/tmux/tmux_colors.sh
	tmux source $HOME/.config/tmux/tmux.conf

	# Copy the new theme file and reload the swaync theme
	cp $HOME/.cache/wal/colors-waybar.css $HOME/.config/swaync/theme.css
	swaync-client -rs

	# Notify the user
	wallpaper_name=$(basename "$file")
	notify-send -i "${wallpaper_name}" "Wallpaper-switcher" "Switching to ${file}"
}

# Show the images
menu() {
	for i in "${!PICS[@]}"; do
		printf "$(basename "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${PICS[$i]}\n"
	done
}

# If swww exists, start it
if command -v swww &>/dev/null; then
	swww query || swww init
fi

# Execution
main() {
	choice=$(menu | ${rofiCommand})

	# No choice case
	if [[ -z $choice ]]; then
		exit 0
	fi

	# Find the selected file
	for file in "${PICS[@]}"; do
		# Getting the file
		if [[ "$(basename "$file" | cut -d. -f1)" = "$choice" ]]; then
			selectedFile="$file"
			break
		fi
	done

	# Check the file and execute
	if [[ -n "$selectedFile" ]]; then
		executeCommand "${selectedFile}"
		return 0
	else
		notify-send "Wallpaper switch" "Image not found"
		echo "Wallpaper switch : Image not found."
		exit 1
	fi

}

# Check if rofi is already running
if pidof rofi > /dev/null; then
	pkill rofi
	exit 0
fi

main
