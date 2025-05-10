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

### Kitty & waybar & bat & fastfetch & swaync & rofi & nvim & wlogout
- Copy **kitty** to **~/.config/kitty**
- Copy **waybar** to **~/.config/waybar**
- Copy **bat** to **~/.config/bat**
- Copy **fastfetch** to **~/.config/fastfetch**
- Copy **swaync** to **~/.config/swaync**
    - Reload swaync with `pkill swaync && swaync &`
- Copy **rofi** to **~/.config/rofi**
- Copy **nvim** to **~/.config/nvim**
- Copy **wlogout** to **~/.config/wlogout**

### Ohmyposh & zsh & tmux
- Copy **ohmyposh** to **~/.config/ohmyposh**
- Copy **.zshrc** to **~**
- Copy **zsh** to **~/.config/zsh**
- Change shell to zsh with `chsh -s /bin/zsh`
- Type `zsh` to use zsh in the current session
    - Reboot and open a terminal for zsh to start and install its dependencies
- Copy **tmux** to **~/.config/tmux**
- Run `tmux source-file ~/.config/tmux/tmux.conf`

### VS Code
- Copy **vscode/keybindings.json** into **~/.config/Code/User**
- Copy **vscode/settings.json** into **~/.config/Code/User**
- Run `xargs -n 1 code --install-extension < vscode/extensions.txt``

### Manual steps

#### Pywalfox
- Add pywalfox to zen browser (or any firefox based browser)
- Click on the freshly installed extensions and click "fetch pywal colors"

### Following steps
- Add an ad blocker to the browser (e.g. uBlock Origin)
- Create a new ssh key and add it to your github account and test it

Reboot and enjoy !
