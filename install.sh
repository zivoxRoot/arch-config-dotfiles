#!/usr/bin/env bash

ACCENT='\033[35m'
SECONDARY='\033[33m'
DEFAULT='\033[0m'
REPO_DIR=$(pwd)
CONFIG_DIR="$REPO_DIR"/config

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
echo "The script will handle the installation for you, it will install some packages, and copy some configuration files onto your system. You will be prompted a few time to enter your password"
echo -e "⚠ Backup all your personal configuration files!${DEFAULT}"

echo -en "\nContinue? (Y/n) "
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
	echo "Proceding with the installation..."
else
	echo "Installation aborted..."
	exit 1
fi

# Install base packages
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 1/5 INSTALLING BASE PACKAGES"
echo -e "└─────────────────────────${DEFAULT}\n\n"

cd $REPO_DIR/packages
sudo pacman -S --needed --noconfirm - < pacman.txt

# Installing paru
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 2/5 INSTALLING PARU"
echo -e "└─────────────────────────${DEFAULT}\n\n"

git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -rsi --noconfirm

# Installing AUR packages
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 3/5 INSTALLING AUR PACKAGES"
echo -e "└─────────────────────────${DEFAULT}\n\n"

cd $REPO_DIR/packages
paru -S - < aur.txt

# Copying the configuration
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 4/5 COPYING THE CONFIGURATION"
echo -e "└─────────────────────────${DEFAULT}\n\n"

echo "Copying scripts..."
sudo mkdir -p /usr/local/bin/
sudo cp scripts/* /usr/local/bin/

echo "Copying wallpapers..."
mkdir -p ~/Pictures
cp -r Wallpapers ~/Pictures/

echo "Copying zshrc..."
cp .zshrc ~
echo "Changing user shell to zsh..."
chsh -s /bin/zsh

echo "Copying gitconfig..."
cp .gitconfig ~

echo "Copying the NEXT STEPS file..."
cp NEXT_STEPS.md ~

# COPYING EVERITHING THAT GOES IN .config
cd $CONFIG_DIR

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

echo "Copying tmux..."
cp -r tmux ~/.config/

echo "Copying zsh..."
cp -r zsh ~/.config/

echo "Copying VSCode configuration..."
mkdir -p ~/.config/Code/User/
cp code/keybindings.json ~/.config/Code/User
cp code/settings.json ~/.config/Code/User
echo "Installing VSCode extensions..."
xargs -n 1 code --install-extension < code/extensions.txt

# Set a default wallpaper
swww img ${HOME}/Pictures/Wallpapers/A_car_with_luggage_on_top_of_it.jpg
wal -i ${HOME}/Pictures/Wallpapers/A_car_with_luggage_on_top_of_it.jpg

# Recommended next steps
echo -e "\n\n${ACCENT}┌─────────────────────────"
echo -e "│ 5/5 RECOMMENDED NEXT STEPS"
echo -e "└─────────────────────────${DEFAULT}\n\n"

echo -e "${ACCENT}A 'next recommended steps' file has been created at ~/NEXT_STEPS.md for your usage, delete this file once you are done with it :) (TIPS: Read the next steps using 'glow ~/NEXT_STEPS')${DEFAULT}\n"
echo -e "${ACCENT}STRONGLY RECOMMENDED: Reboot your system to have all changes take effect. Run 'sudo reboot now'${DEFAULT}"
