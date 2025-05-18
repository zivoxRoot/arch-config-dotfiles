#!/usr/bin/env bash

HOME_DIR=$HOME
CONFIG_DIR=$XDG_CONFIG_HOME
BASE_DIR=$(pwd)

echo $CONFIG_DIR

# Exit on any error
set -e

# Greet the user and check if he wants to proceed
# echo "Hello ! Welcome to the installation script !"
# read -p "Do you want to continue ? (Y/n)" answer
#
# if [ $answer == "" ] && [ $answer == "n" ]; then
# 	echo "YES"
# else
# 	echo "Aborting the installation"
# fi

# Update the system
echo "Updating the system..."
sudo pacman -Syu --noconfirm

# Install the packages
echo "Installing the official packages..."
cd packages
sudo pacman -S --needed --noconfirm - <pacman.txt

# Install paru AUR helper if not present
if ! command -v paru &>/dev/null; then
    echo "Installing paru AUR helper"
    sudo pacman -S --needed --noconfirm base-devel
    cd ~ && git clone https://aur.archlinux.org/paru-bin.git
    cd ~/paru-bin/ && makepkg -rsi --noconfirm
    cd ~ && rm -Rf ~/paru-bin/
else
    echo "Detected paru as AUR helper"
fi

cd ${BASE_DIR}/"packages"
echo "Installing the AUR packages..."
paru -S --needed - <aur.txt

cd $BASE_DIR
# Copy the wallpapers
echo "Copying the wallpapers..."
mkdir ${HOME_DIR}/"Pictures/"
cp -r Wallpapers ${HOME_DIR}/"Pictures/"

# NOTE: Here it doesn't work
# Wal
echo "Copying wal..."
cp -r wal $CONFIG_DIR

# Hypr
echo "Copying hypr..."
cp -r hypr $CONFIG_DIR
