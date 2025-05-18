#!/usr/bin/env bash

# Exit on any error and enable debug tracing
set -e

# Define variables with fallbacks
HOME_DIR="${HOME_DIR:-$HOME}"
CONFIG_DIR="${CONFIG_DIR:-${HOME}/.config}"
BASE_DIR="$(pwd)"
PACKAGE_DIR="${BASE_DIR}/packages"
PACMAN_LIST="${PACKAGE_DIR}/pacman.txt"
AUR_LIST="${PACKAGE_DIR}/aur.txt"
WALLPAPERS_SRC="${BASE_DIR}/wallpapers"
WALLPAPERS_DEST="${HOME_DIR}/Pictures/Wallpapers"
WAL_SRC="${BASE_DIR}/wal"
WAL_DEST="${CONFIG_DIR}/wal"
HYPR_SRC="${BASE_DIR}/hypr"
HYPR_DEST="${CONFIG_DIR}/hypr"

# Function to log messages with timestamps
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >&2
}

# Function to check if a command exists
check_command() {
    if ! command -v "$1" &>/dev/null; then
        log_message "Error: Command '$1' not found."
        exit 1
    fi
}

# Function to check if a file or directory exists
check_path() {
    local path="$1"
    if [[ ! -e "$path" ]]; then
        log_message "Error: '$path' does not exist."
        exit 1
    fi
}

# Function to create a directory with error handling
create_dir() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        log_message "Creating directory '$dir'..."
        if ! mkdir -p "$dir"; then
            log_message "Error: Failed to create directory '$dir'."
            exit 1
        fi
    fi
}

# Function to copy a directory with error handling
copy_dir() {
    local src="$1"
    local dest="$2"
    local name="$3"

    check_path "$src"
    create_dir "$(dirname "$dest")"

    log_message "Copying '$name' from '$src' to '$dest'..."
    if ! cp -r "$src" "$dest" 2>/dev/null; then
        log_message "Error: Failed to copy '$name'."
        exit 1
    fi
    log_message "Successfully copied '$name'."
}

# Function to execute a command with logging
execute_command() {
    log_message "Executing: $1"
    if ! eval "$1"; then
        log_message "Error: Command failed: $1"
        exit 1
    fi
}

# Greet the user and prompt for confirmation
log_message "Hello! Welcome to the installation script!"
read -p "Do you want to continue? (Y/n): " answer
case "${answer:-y}" in
[Yy] | [Yy][Ee][Ss])
    log_message "Proceeding with installation..."
    ;;
*)
    log_message "Aborting the installation."
    exit 0
    ;;
esac

# Update the system
execute_command "sudo pacman -Syu --noconfirm"

# Install official packages
check_path "$PACMAN_LIST"
cd "$PACKAGE_DIR" || {
    log_message "Error: Cannot change to $PACKAGE_DIR."
    exit 1
}
execute_command "sudo pacman -S --needed --noconfirm - < $PACMAN_LIST"

# Install paru AUR helper if not present
if ! command -v paru &>/dev/null; then
    log_message "Installing paru AUR helper..."
    execute_command "sudo pacman -S --needed --noconfirm base-devel"
    cd ~ || {
        log_message "Error: Cannot change to home directory."
        exit 1
    }
    execute_command "git clone https://aur.archlinux.org/paru-bin.git"
    cd ~/paru-bin/ || {
        log_message "Error: Cannot change to ~/paru-bin/."
        exit 1
    }
    execute_command "makepkg -rsi --noconfirm"
    cd ~ || {
        log_message "Error: Cannot change to home directory."
        exit 1
    }
    execute_command "rm -Rf ~/paru-bin/"
else
    log_message "Detected paru as AUR helper."
fi

# Install AUR packages
check_path "$AUR_LIST"
cd "$PACKAGE_DIR" || {
    log_message "Error: Cannot change to $PACKAGE_DIR."
    exit 1
}
execute_command "paru -S --needed - < $AUR_LIST"

# Return to base directory
cd "$BASE_DIR" || {
    log_message "Error: Cannot change to $BASE_DIR."
    exit 1
}

# Copy wallpapers
copy_dir "$WALLPAPERS_SRC" "$WALLPAPERS_DEST" "Wallpapers"

# Copy wal
copy_dir "$WAL_SRC" "$WAL_DEST" "wal"

# Start swww daemon and set first wallpaper
log_message "Starting swww daemon and setting wallpaper..."
pkill swww || true
swww-daemon &
sleep 1

# first_wallpaper=$(find "$WALLPAPERS_DEST" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" \) | sort | head -n 1)
first_wallpaper=$(find "$WALLPAPERS_DEST" -maxdepth 1 -type f \( -iname "*.jpg" \) | sort | head -n 1)
if [[ -n "$first_wallpaper" ]]; then
    log_message "Setting wallpaper: ${first_wallpaper##*/}"
    swww img "$first_wallpaper"
    wal -i "$first_wallpaper" -n --cols16
else
    log_message "No images found in $WALLPAPERS_DEST."
fi

# Delete the original hypr folder and copy the new one
rm -r "$HYPR_DEST" && copy_dir "$HYPR_SRC" "$HYPR_DEST" "hypr"

# Copy kitty
copy_dir "${BASE_DIR}/kitty" "${CONFIG_DIR}/kitty" "kitty"

# Copy waybar
copy_dir "${BASE_DIR}/waybar" "${CONFIG_DIR}/waybar" "waybar"

# Copy bat
copy_dir "${BASE_DIR}/bat" "${CONFIG_DIR}/bat" "bat"

# Copy fastfetch
copy_dir "${BASE_DIR}/fastfetch" "${CONFIG_DIR}/fastfetch" "fastfetch"

# Copy swaync
copy_dir "${BASE_DIR}/swaync" "${CONFIG_DIR}/swaync" "swaync"

# Copy rofi
copy_dir "${BASE_DIR}/rofi" "${CONFIG_DIR}/rofi" "rofi"

# Copy nvim
copy_dir "${BASE_DIR}/nvim" "${CONFIG_DIR}/nvim" "nvim"

# Copy wlogout
copy_dir "${BASE_DIR}/wlogout" "${CONFIG_DIR}/wlogout" "wlogout"

log_message "Installation and configuration process completed successfully."
