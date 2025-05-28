#!/usr/bin/env bash

# Wallpapers Path
wallpapersDir="$HOME/Pictures/Wallpapers"
iconsDir="$HOME/.cache/wallpaper-select"
rofiThemeFile="$HOME/.config/rofi/wallpaper-select/wallpaper-select.rasi"

# Transition config
FPS=60
TYPE="grow"
DURATION=3
BEZIER="0.4,0.2,0.4,1.0"
TRANSITION_POS="0.7,0.7"
SWWW_PARAMS="--transition-fps ${FPS} --transition-type ${TYPE} --transition-duration ${DURATION} --transition-bezier ${BEZIER} --transition-pos ${TRANSITION_POS}"

# Rofi arguments
rofiArgs="rofi -show -dmenu -theme $rofiThemeFile"

# getPics retrieves image files as a list
getPics() {
	PICS=($(find -L "${iconsDir}" -type f \( -iname \*.jpg \) | sort))
}

# updateIconFolder checks that all wallpapers in $wallpapersDir have a corresponding icon in $iconsDir and that all icons have a corresponding wallpaper
updateIconFolder() {

	# Loop through the $wallpapersDir
	for file in "$wallpapersDir"/*.jpg; do
		[[ -e "$file" ]] || continue # Skip if no jpg file being found

		# Extract filename
		filename=$(basename "$file")

		# Check if the file exists in $iconsDir
		if [[ ! -e "$iconsDir/$filename" ]]; then
			notify-send "Wallpaper switcher" "Converting $filename to icon"

			# Use imageMagick to copy and strip the wallpaper to an icon and put it in $iconsDir
			magick "$wallpapersDir/$filename" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "$iconsDir/$filename"
		fi
	done

	# Loop through the icons and remove the ones that don't have their corresponding wallpaper anymore
	for file in "$iconsDir"/*.jpg; do

		# Extract filename
		filename=$(basename "$file")

		# Check that the wallpaper exists in $iconsDir
		if [[ ! -e "$wallpapersDir/$filename" ]]; then
			notify-send "Wallpaper switcher" "Deleting icon $filename"
			rm "$iconsDir/$filename"
		fi
	done

	# Reload the wallpapers list
	getPics
}

# Execute command according the wallpaper manager
applyWallpaper() {

	# Set the wallpaper
	if command -v swww &>/dev/null; then
		# Get the actual wallpaper from $wallpapersDir and set it
		wallpaperName=$(basename "$1")
		wallpaperToSet=$(find "${wallpapersDir}" -name "$wallpaperName")
		swww img "$wallpaperToSet" ${SWWW_PARAMS}
	else
		notify-send "Wallpaper switcher" "Swww is not installed"
		exit 1
	fi

	# Set the pywal16 theme
	wal -i "${1}" -n --cols16

	# Cache the current wallpaper for hyprlock and rofi to use it
	mkdir $HOME/.cache/current_wallpaper
	cp "${1}" "$HOME/.cache/current_wallpaper/current.jpg"

	# Copy the new theme file and reload the swaync theme
	cp $HOME/.cache/wal/colors-waybar.css $HOME/.config/swaync/theme.css
	swaync-client -rs &

	# Reload waybar
	pkill waybar && waybar &

	# Reload telegram colors and restart telegram
	walogram -B
	# pkill -f telegram-desktop
	# telegram-desktop &

	# Update the neovim colorscheme
	nvim --server ~/.cache/nvim-server --remote-send "<Esc>:lua vim.cmd('colorscheme pywal16')<CR>"

	# Reload tmux theme and reload tmux
	bash $HOME/.config/tmux/tmux_colors.sh
	tmux source $HOME/.config/tmux/tmux.conf

	# Copy the new theme file for zathura
	cp $HOME/.cache/wal/zathurarc $HOME/.config/zathura/

	# Notify the user
	wallpaper_name=$(basename "$file" | cut -d. -f1)
	notify-send -i "${file}" "Wallpaper-switcher" "Switching to ${wallpaper_name}"
}

# Show the images
displayWallpapers() {
	for i in "${!PICS[@]}"; do
		printf "$(basename "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${PICS[$i]}\n"
	done
}

# Execution
launchSelector() {
	choice=$(displayWallpapers | ${rofiArgs})

	# No choice case
	if [[ -z $choice ]]; then
		exit 0
	fi

	# Find the selected file
	for file in "${PICS[@]}"; do
		# Get the file
		if [[ "$(basename "$file" | cut -d. -f1)" = "$choice" ]]; then
			selectedFile="$file"
			break
		fi
	done

	# Check the file and execute
	if [[ -n "$selectedFile" ]]; then
		applyWallpaper "${selectedFile}"
		return 0
	else
		notify-send "Wallpaper switch" "Image not found"
		exit 1
	fi
}

# Check that the dependencies exist and call the necessary functions
main() {

	# Ensure both folder exist
	if [[ ! -d "$wallpapersDir" || ! -d "$iconsDir" ]]; then
		notify-send "Wallpaper switcher" "One or both folders don't exist..."
		exit 1
	fi

	# Ensure both folder exist
	# if [[ ! -d "$iconsDir" ]]; then
	# mkdir $HOME/.cache/$iconsDir
	# fi
	# if [[ ! -d "$wallpapersDir" ]]; then
	# notify-send "Wallpaper switcher" "Put some JPG images in ~/Pictures/Wallpapers to get started"
	# exit 1
	# fi

	# If swww exists, start it
	if command -v swww &>/dev/null; then
		swww query || swww init
	fi

	# Check if rofi is already running
	if pidof rofi >/dev/null; then
		pkill rofi
		exit 0
	fi

	getPics

	updateIconFolder

	launchSelector
}

# Check the necessary folders exist, and create them if they do not
if [ ! -d "$wallpapersDir" ]; then
	mkdir -p "$wallpapersDir"
	log_message "Created folder: $wallpapersDir"
else
	log_message "Folder already exists: $wallpapersDir"
fi
if [ ! -d "$iconsDir" ]; then
	mkdir -p "$iconsDir"
	log_message "Created folder: $iconsDir"
else
	log_message "Folder already exists: $iconsDir"
fi

# Call the main function
main
