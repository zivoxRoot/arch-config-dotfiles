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

# Additional config
THEME_FILE="$HOME/.cache/hyprland-theme"
DEFAULT_THEME="dark"
CURRENT_THEME=""

# Rofi arguments
rofiArgs="rofi -show -dmenu -theme $rofiThemeFile"

# getPics retrieves image files as a list, restricted to top-level directory
getPics() {
    # Find files, prioritizing JPG/JPEG over PNG/GIF
    PICS=($(find -L "${wallpapersDir}" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | sort))
    # Deduplicate based on base name, preferring JPG/JPEG
    declare -A seen
    declare -A file_map
    for pic in "${PICS[@]}"; do
        base_name=$(basename "$pic" | cut -d. -f1)
        ext=$(echo "${pic##*.}" | tr '[:upper:]' '[:lower:]')
        # Prioritize JPG/JPEG over PNG/GIF
        if [[ -z "${seen[$base_name]}" || "$ext" == "jpg" || "$ext" == "jpeg" ]]; then
            seen[$base_name]=1
            file_map[$base_name]="$pic"
        fi
    done
    unique_pics=()
    for base_name in "${!file_map[@]}"; do
        unique_pics+=("${file_map[$base_name]}")
    done
    # Sort to maintain consistent order
    IFS=$'\n' unique_pics=($(sort <<<"${unique_pics[*]}"))
    unset IFS
    PICS=("${unique_pics[@]}")
}

# updateIconFolder checks that all wallpapers in $wallpapersDir have a corresponding icon in $iconsDir
updateIconFolder() {
    # Create a map of wallpapers by base name, prioritizing JPG/JPEG
    declare -A wallpaper_map
    for file in "$wallpapersDir"/*.{jpg,jpeg,png,gif}; do
        [[ -e "$file" ]] || continue # Skip if no files are found
        base_name=$(basename "$file" | cut -d. -f1)
        ext=$(echo "${file##*.}" | tr '[:upper:]' '[:lower:]')
        # Store file, preferring JPG/JPEG
        if [[ -z "${wallpaper_map[$base_name]}" || "$ext" == "jpg" || "$ext" == "jpeg" ]]; then
            wallpaper_map[$base_name]="$file"
        fi
    done

    # Generate icons for each unique wallpaper
    for base_name in "${!wallpaper_map[@]}"; do
        file="${wallpaper_map[$base_name]}"
        ext=$(echo "${file##*.}" | tr '[:upper:]' '[:lower:]')
        # Check if the icon exists in $iconsDir (icons are always JPG)
        if [[ ! -e "$iconsDir/$base_name.jpg" ]]; then
            notify-send "Wallpaper switcher" "Converting $base_name to icon"
            # Convert to JPG icon (use first frame for GIF)
            if [[ "$ext" == "gif" ]]; then
                magick "$file[0]" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "$iconsDir/$base_name.jpg"
            else
                magick "$file" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "$iconsDir/$base_name.jpg"
            fi
        fi
    done

    # Remove icons without a corresponding wallpaper
    for file in "$iconsDir"/*.jpg; do
        [[ -e "$file" ]] || continue # Skip if no icons are found
        base_name=$(basename "$file" .jpg)
        if [[ -z "${wallpaper_map[$base_name]}" ]]; then
            notify-send "Wallpaper switcher" "Deleting icon $base_name.jpg"
            rm "$iconsDir/$base_name.jpg"
        fi
    done

    # Reload the wallpapers list
    getPics
}

# Execute command according to the wallpaper manager
applyWallpaper() {
    # Set the wallpaper
    if command -v swww &>/dev/null; then
        # Get the actual wallpaper from $wallpapersDir and set it
        wallpaperName=$(basename "$1")
        wallpaperToSet=$(find "${wallpapersDir}" -maxdepth 1 -name "$wallpaperName")
        swww img "$wallpaperToSet" ${SWWW_PARAMS}
    else
        notify-send "Wallpaper switcher" "Swww is not installed"
        exit 1
    fi

    # Set the pywal16 theme
    if [ "$CURRENT_THEME" = "light" ]; then
        wal -i "${1}" -l -n --cols16
        echo "LIGHT MODE"
    else
        wal -i "${1}" -n --cols16
        echo "DARK MODE"
    fi

    # Notify the user
    wallpaper_name=$(basename "$1" | cut -d. -f1)
    notify-send -i "${1}" "Wallpaper-switcher" "Switching to ${wallpaper_name}"

    # Cache the current wallpaper for hyprlock
    mkdir -p "$HOME/.cache/current_wallpaper"
    ext=$(echo "${wallpaperName##*.}" | tr '[:upper:]' '[:lower:]')
    case "$ext" in
        jpg|jpeg)
            cp "${1}" "$HOME/.cache/current_wallpaper/current.jpg"
            ;;
        png)
            magick "${1}" -quality 90 "$HOME/.cache/current_wallpaper/current.jpg"
            ;;
        gif)
            magick "${1}[0]" -quality 90 "$HOME/.cache/current_wallpaper/current.jpg"
            ;;
        *)
            notify-send "Wallpaper switcher" "Unsupported file format: $ext"
            exit 1
            ;;
    esac

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
}

# Show the images
displayWallpapers() {
    for i in "${!PICS[@]}"; do
        # Use the icon (JPG) in $iconsDir, based on base name
        base_name=$(basename "${PICS[$i]}" | cut -d. -f1)
        iconFile="$iconsDir/$base_name.jpg"
        printf "$base_name\x00icon\x1f${iconFile}\n"
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
    # Ensure ImageMagick is installed
    if ! command -v magick &>/dev/null; then
        notify-send "Wallpaper switcher" "ImageMagick is not installed"
        exit 1
    fi

    # Ensure both folders exist
    if [[ ! -d "$wallpapersDir" || ! -d "$iconsDir" ]]; then
        notify-send "Wallpaper switcher" "One or both folders don't exist..."
        exit 1
    fi

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

# Ensure the theme file exists
[ ! -f "$THEME_FILE" ] && echo "$DEFAULT_THEME" > "$THEME_FILE"
# Read the current theme
CURRENT_THEME=$(cat "$THEME_FILE")

# Check the necessary folders exist, and create them if they do not
if [ ! -d "$wallpapersDir" ]; then
    mkdir -p "$wallpapersDir"
    echo "Created folder: $wallpapersDir" >> ~/.wallpaper-select.log
else
    echo "Folder already exists: $wallpapersDir" >> ~/.wallpaper-select.log
fi
if [ ! -d "$iconsDir" ]; then
    mkdir -p "$iconsDir"
    echo "Created folder: $iconsDir" >> ~/.wallpaper-select.log
else
    echo "Folder already exists: $iconsDir" >> ~/.wallpaper-select.log
fi

# Call the main function
main