# Installation

There is no installation script at this point, so here are the steps to follow :
These steps are to perform with a minimal arch linux + hyprland config (e.g. after running archinstall)

## Install necessary packages
- go in **packages** and run `sudo pacman -S --needed -noconfirm - < pacman.txt`

- Install paru (may take a while) :
```Bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

- go in **packages** and run `paru -S --needed -noconfirm - < aur.txt`

> You may have problems with the `--noconfirm` flag if there is any conflicting package, if this is the case, remove this flag

## Copy the configuration

### Wallpapers
- Copy **Wallpapers** into **~/Pictures/Wallpapers**

### Wal & hypr
- Copy **wal** into **~/.config/wal**
- Use `wal -i youWallpaper` to generate a color config
- Copy **hypr** into **~/.config/hypr**

### Kitty & waybar & bat & fastfetch & swaync & rofi & nvim
- Copy **kitty** to **~/.config/kitty**
- Copy **waybar** to **~/.config/waybar**
- Copy **bat** to **~/.config/bat**
- Copy **swaync** to **~/.config/swaync**
- Copy **rofi** to **~/.config/rofi**
- Copy **nvim** to **~/.config/nvim**

### Ohmyposh & zsh
- Copy **ohmyposh** to **~/.config/ohmyposh**
- Copy **.zshrc** to **~**
- Copy **zsh** to **~/.config/zsh**
- Change shell to zsh with `chsh -s /bin/zsh`
- Reboot and open a terminal for zsh to start and install its dependencies

Reboot and enjoy !
