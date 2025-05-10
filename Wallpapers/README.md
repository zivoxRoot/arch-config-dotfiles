# Wallpapers

This folder contains all the wallpapers for the config, it is originally meant to be stored in **$HOME/Pictures/wallpapers/**
The wallpaper selector will only show you the **JPG files** in the **$HOME/Pictures/wallpapers/**
You can back up your liked wallpapers that you don't want to use right now in **./unused/**.

---

## Conventions

- All wallpapers must have a descriptive name (no 'Img-1', 'Img-2', etc...)
- The first letter in uppercase (e.g. 'Wall.jpg', and no 'wall.jpg')
- Wallpapers' name with multiple words must be separated with a dash (e.g. 'Dark-wall', and no 'DarkWall')
- Put a multiple of 6 in the "currently used" wallpapers, because they are shown by 6 in the wallpaper selector

## File structure

**./unused/** -> folder for cool wallpaper you want to keep but not actively use.

## Why only JPG ?
The current config only supports JPG files for multiple reasons :

- Hyprlock uses the current wallpaper image as its own background, the current wallpaper is cached in $HOME/current_wallpaper/current.jpg, because when cached the wallpaper is renamed as 'current.jpg', we need jpg files in our wallpapers stock. To support other wallpaper formats you need to change the current hyprlock background solution.
- The wallpaper selector script only handle JPG files, it can be changed pretty easily to be able to use other formats, learn more in the readme at $HOME/.config/rofi/README.md
