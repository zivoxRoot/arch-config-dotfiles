#!/usr/bin/env bash

ACCENT='\033[35m'
DEFAULT='\033[0m'

# Get user validation
clear
echo -e "\n\n${ACCENT} ░▒▓██████▓▒░░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓███████▓▒░"
echo -e "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ "
echo -e "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ "
echo -e "░▒▓████████▓▒░▒▓███████▓▒░░▒▓█▓▒░      ░▒▓████████▓▒░       ░▒▓██████▓▒░       ░▒▓████████▓▒░░▒▓██████▓▒░░▒▓███████▓▒░░▒▓███████▓▒░  "
echo -e "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ "
echo -e "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ "
echo -e "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ "

echo -e "\n\nWelcome to the installation script for my arch linux X hyprland dotfiles!"
echo -e "The script will handle the installation for you. You will be prompted a few time to enter your password${DEFAULT}"

echo -en "\nContinue? (Y/n) "
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
	echo "Proceding with the installation..."
else
	echo "Installation aborted..."
	exit 1
fi

# Preparing the system
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 0. PREPARING THE SYSTEM"
echo -e "└─────────────────────────${DEFAULT}\n"

CONFIG_DIR=$(pwd)
echo $CONFIG_DIR

# Install base packages
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 1. INSTALLING BASE PACKAGES"
echo -e "└─────────────────────────${DEFAULT}\n"

cd $CONFIG_DIR/packages
sudo pacman -S --needed --noconfirm - < pacman.txt

# Installing paru
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 2. INSTALLING PARU"
echo -e "└─────────────────────────${DEFAULT}\n"

git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -rsi --noconfirm

# Installing AUR packages
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 3. INSTALLING AUR PACKAGES"
echo -e "└─────────────────────────${DEFAULT}\n"

cd $CONFIG_DIR/packages
paru -S - < aur.txt

# Copying the configuration
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 4. COPYING THE CONFIGURATION"
echo -e "└─────────────────────────${DEFAULT}\n"

cd $CONFIG_DIR

echo "Copying wallpapers..."
mkdir -p ~/Pictures
cp -r Wallpapers ~/Pictures/

echo "Copying wal..."
cp -r wal ~/.config/

echo "Copying hypr..."
rm ~/.config/hypr/* && cp -r hypr/* ~/.config/hypr

echo "Copying kitty..."
cp -r kitty ~/.config/

echo "Copying waybar..."
cp -r waybar ~/.config/

echo "Copying bat..."
cp -r bat ~/.config/

echo "Copying fastfetch..."
cp -r fastfetch ~/.config/

echo "Copying swaync..."
cp -r swaync ~/.config/

echo "Copying rofi..."
cp -r rofi ~/.config/

echo "Copying nvim..."
cp -r nvim ~/.config/

echo "Copying wlogout..."
cp -r wlogout ~/.config/

echo "Copying ohmyposh..."
cp -r ohmyposh ~/.config/

echo "Copying zsh..."
cp -r zsh ~/.config/

echo "Copying tmux..."
cp -r tmux ~/.config/

echo "Copying zshrc..."
cp .zshrc ~

echo "Copying gitconfig..."
cp .gitconfig ~

echo "Copying VSCodium configuration..."
mkdir -p ~/.config/VSCodium/User/
cp vscodium/keybindings.json ~/.config/VSCodium/User
cp vscodium/settings.json ~/.config/VSCodium/User
echo "Installing VSCodium extensions..."
xargs -n 1 codium --install-extension < vscodium/extensions.txt

# Last configuration
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 5. LAST CONFIGURATIONS"
echo -e "└─────────────────────────${DEFAULT}\n"

echo "Changing user shell to zsh..."
chsh -s /bin/zsh

echo "Enbling bluetooth..."
sudo systemctl enable bluetooth.service

# Next recommended steps
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 6. NEXT STEPS"
echo -e "└─────────────────────────${DEFAULT}\n"
