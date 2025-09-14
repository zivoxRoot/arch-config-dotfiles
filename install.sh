# This is the new installation script for my dotfiles!! Should work!

echo "# 0. Preparing system"
CONFIG_DIR=$(pwd)
echo $CONFIG_DIR
echo "Installing git..."
sudo pacman -S git

# Install base packages
echo "# 1. INSTALLING BASE PACKAGES"
cd $CONFIG_DIR/packages
sudo pacman -S --needed -noconfirm - < pacman.txt

# Installing paru
echo "# 2. INSTALLING PARU"
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -rsi --noconfirm

# Installing AUR packages
echo "\n\n# 3. INSTALLING AUR PACKAGES"
cd $CONFIG_DIR/packages
paru -S - < aur.txt

# Copying the configuration
echo "# 4. COPYING THE CONFIGURATION"
cd $CONFIG_DIR

echo "Copying wallpapers..."
mkdir -p ~/Pictures
cp -r wallpapers ~/Pictures/Wallpapers

echo "Copying wal..."
cp -r wal ~/.config/

echo "Copying hypr..."
rm ~/.config/hypr/* && cp -r hypr/* ~/.config/hypr

echo "Copying kitty..."
cp -r hypr ~/.config/

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

echo "Copying VSCodium configuration..."
mkdir -p ~/.config/VSCodium/User/
cp vscodium/keybindings.json ~/.config/VSCodium/User
cp vscodium/settings.json ~/.config/VSCodium/User
echo "Installing VSCodium extensions..."
xargs -n 1 codium --install-extension < vscodium/extensions.txt

# Last configuration
echo "# 5. LAST CONFIGURATIONS"
echo "Changing user shell to zsh..."
chsh -s /bin/zsh

echo "Enbling bluetooth..."
sudo systemctl enable bluetooth.service

# Next recommended steps
echo "# 6. NEXT STEPS"