# Rofi launcher

The colors are sourced from pywal16.

The rofi launcher is used in :

**$HOME/.config/hypr/conf/keybindings.conf**

**$HOME/.config/hypr/scripts/logout-menu.sh**

**./change-default-launcher.sh**

---

## Files

**./current_launcher/current.rasi** --> The currently used rofi launcher, dynamically changed by **./change-default-launcher.sh**

**./change-default-launcher.sh** --> A bash script that open a rofi menu to select which rofi launcher you want, then apply it by deleting the **./current_launcher/current.rasi** file and copying the selected launcher in **./current_launcher/current.rasi**
