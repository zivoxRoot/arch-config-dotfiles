#!/bin/bash

# NOTE: This script loads the color from pywal16 and generate a color scheme for tmux

# Load pywal colors
[ -f "$HOME/.cache/wal/colors.sh" ] && . "$HOME/.cache/wal/colors.sh"

# Generate the config
cat <<EOF > "$HOME/.config/tmux/colors.conf"

# Left side
set -g status-left " \
#[fg=color14,bg=color0]#[bg=color4,fg=color15] #S #[fg=color14,bg=color0] \
 "

# Right side
set -g status-right "#[fg=color14,bg=color0]#[bg=color4,fg=color15] #(cat /sys/class/power_supply/BAT0/capacity)% #[fg=color14,bg=color0]\
#[fg=color14,bg=color0] #[bg=color0] #[bg=color4,fg=color15] %Y-%m-%d #[fg=color14,bg=color0]\
#[fg=color14,bg=color0] #[bg=color0] #[bg=color4,fg=color15] %H:%M #[fg=color14,bg=color0]"

# Window styling
setw -g window-status-format " \
#[fg=color13]#[bg=color8,fg=color13] #I:#W #[fg=color13,bg=color0] \
"
setw -g window-status-current-format " \
#[fg=color14]#[bg=color11,fg=color15] #I:#W #[fg=color14,bg=color0] \
"
setw -g window-status-style "bg=color0,fg=color14"
setw -g window-status-current-style "bg=color0,fg=color14"

# Global background color
set -g status-style bg=color0
EOF
