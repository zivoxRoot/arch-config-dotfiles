# Installation

There is a minimal installation script at this point but it may not work, so here are the steps to follow to install manually :
These steps are to perform with a minimal arch linux + hyprland config (e.g. after running archinstall)

## Install necessary packages

- go in **packages** and run `sudo pacman -S --needed -noconfirm - < pacman.txt`

- Install paru (may take a while) :

```Bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -rsi --noconfirm
```

- go in **packages** and run `paru -S --needed -noconfirm - < aur.txt`

> You may have problems with the `--noconfirm` flag if there is any conflicting package, if this is the case, remove this flag

## Copy the configuration

### Scripts

- Copy all scripts in **./scripts/** into **/usr/local/bin**

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

#### Telegram

- Go in settings > Chat settings > Chat wallpaper > Choose from file, then pick the file at **~/.cache/walogram/wal.tdesktop-theme**

### Following steps

- Add an ad blocker to the browser (e.g. uBlock Origin)
- Create a new ssh key and add it to your github account and test it
- Add your liked apps (, etc...)

Reboot and enjoy !

## Other things

- Enable bluetooth service : `sudo systemctl enable bluetooth.service & sudo systemctl start bluetooth.service`
- Remove [firefox], dolphin,
- Add necessary lines to .gitconfig

## Bug fixes

### 1. Swww

Since its 9.5 version, swww (wallpaper engine and daemon) doesn't work : it may work some times but most of the time it doesn't fill the full screen.
To fix this issue you should remove the swww package, and clone the repo locally to compile it yourself :

1. Go in https://github.com/LGFae/swww/ and click the **releases** tab : https://github.com/LGFae/swww/releases
2. Scroll to the 9.4 release and download the compressed file
3. Uncompress it and follow the indication in the swww's README to build the program
4. Copy the files **target/release/swww** and the **target/release/swww-daemon** in **/usr/local/bin** :

```bash
sudo cp target/release/swww /usr/local/bin
sudo cp target/release/swww-daemon /usr/local/bin
```

Restart the swww daemon and it should now work flawlessly !
