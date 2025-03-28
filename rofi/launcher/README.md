# Rofi launcher

All the rofi menus source their colors from pywal16.

---

## Structure
**./launcher.sh** --> Launches a rofi drun instance, is called in **$HOME/.config/hypr/conf/keybindings.conf**

**./themes/** --> The rofi themes in .rasi files

**./rofi_theme_select/** --> Contains the rofi theme selector, called in **$HOME/.config/hypr/conf/keybindings.conf**

**./assets/** --> The images used to illustrate the rofi themes in the theme switcher

**./current_theme/** --> A cache for the currently used rofi theme
