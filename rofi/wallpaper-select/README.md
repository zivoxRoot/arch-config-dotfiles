# Wallpaper selector

The **wallpaper-select.sh** file is called from the **$HOME/.config/hypr/conf/keybindings.conf** to present a good UI when changing wallpaper. It uses the rofi configuration **$HOME/.config/rofi/wallpaper-select.rofi**, which sources the pywal16 colors.
This script is also responsible for reloading the pywal16 colors according to the new wallpaper.

---

## How it works

The **./wallpaper-select.sh** file is called from **$HOME/.config/hypr/conf/keybindings.conf** to change the current wallpaper and theme. It uses the **./wallpaper-select.rasi** file for the rasi menu appearance.

This wallpaper switcher :

1. Takes the JPG files in **$HOME/.config/hypr/conf/keybindings.conf**, and convert them to icons (stored in **$HOME/.cache/wallpaper-select/**), to display them in the rofi menu.

1. Checks that all the wallpapers have their corresponding icons, else it creates them.

1. Display the rofi menu for the user to choose a wallpaper

1. Update :
    - the wallpaper
    - the pywal theme
    - waybar
    - tmux
    - swaync
    - pywalfox
    - vsCode

## Sources

originally written by : JaKooLit - https://github.com/JaKooLit
rewritten by : Abhra00 - https://github.com/Abhra00

I personnaly saw this theme in HyDE's dotfiles (https://github.com/HyDE-Project/HyDE) and took this script in Abhra00's dotfiles before mofifying it myself.
