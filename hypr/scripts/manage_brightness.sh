#!/usr/bin/env bash

# Configuration
STEP=5 # Brightness adjustment step (percentage for laptop, units for external)

# Get current brightness percentage
BRIGHTNESS=$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%')

# Set notification parameters
NOTIF_ID=1001 # Unique ID for brightness notification
ICON="display-brightness-symbolic"
URGENCY="normal"
TIMEOUT=1500 # Notification timeout in milliseconds
MESSAGE="Brightness: ${BRIGHTNESS}%"

# Function to send or update notification
notify_brightness() {
    notify-send -h int:transient:1 -r $NOTIF_ID -u $URGENCY -t $TIMEOUT -i $ICON \
        -h int:value:$BRIGHTNESS -h string:synchronous:brightness "$MESSAGE"
}

# Function to detect laptop monitor
get_laptop_monitor() {
    # Look for common laptop monitor names (eDP, LVDS, etc.)
    hyprctl monitors -j | jq -r '.[] | select(.name | test("eDP|LVDS")) | .name' | head -n 1
}

# Function to detect external monitor DDC/CI display number
get_external_display() {
    # Get the first DDC/CI-capable monitor
    ddcutil detect | grep -oP 'Display \K\d+' | head -n 1
}

# Get monitor information
LAPTOP_MONITOR=$(get_laptop_monitor)
EXTERNAL_DISPLAY=$(get_external_display)

# Check if monitors are detected
if [ -z "$LAPTOP_MONITOR" ] && [ -z "$EXTERNAL_DISPLAY" ]; then
    echo "Error: No monitors detected."
    exit 1
fi

# Get current laptop brightness (if available)
if [ -n "$LAPTOP_MONITOR" ]; then
    MAX_BRIGHTNESS=$(brightnessctl max)
    CURRENT_BRIGHTNESS=$(brightnessctl get)
    BRIGHTNESS_PERCENT=$(bc -l <<<"($CURRENT_BRIGHTNESS / $MAX_BRIGHTNESS) * 100")
    BRIGHTNESS_PERCENT=${BRIGHTNESS_PERCENT%.*} # Remove decimal part
else
    # Fallback: Use external monitor brightness if no laptop monitor
    if [ -n "$EXTERNAL_DISPLAY" ]; then
        BRIGHTNESS_PERCENT=$(ddcutil --display="$EXTERNAL_DISPLAY" getvcp 10 | grep -oP 'current value =\s*\K\d+')
    else
        echo "Error: No brightness source available."
        exit 1
    fi
fi

# Adjust brightness based on argument (+ or -)
if [[ "$1" == "+" ]]; then
    # Increase brightness
    NEW_BRIGHTNESS_PERCENT=$((BRIGHTNESS_PERCENT + STEP))
    if [ "$NEW_BRIGHTNESS_PERCENT" -gt 100 ]; then
        NEW_BRIGHTNESS_PERCENT=100
    fi
elif [[ "$1" == "-" ]]; then
    # Decrease brightness
    NEW_BRIGHTNESS_PERCENT=$((BRIGHTNESS_PERCENT - STEP))
    if [ "$NEW_BRIGHTNESS_PERCENT" -lt 0 ]; then
        NEW_BRIGHTNESS_PERCENT=0
    fi
else
    echo "Usage: $0 [+|-]"
    exit 1
fi

# Apply brightness to laptop monitor (if available)
if [ -n "$LAPTOP_MONITOR" ]; then
    brightnessctl set "$NEW_BRIGHTNESS_PERCENT%" >/dev/null
fi

# Apply brightness to external monitor (if available)
if [ -n "$EXTERNAL_DISPLAY" ]; then
    ddcutil --display="$EXTERNAL_DISPLAY" setvcp 10 "$NEW_BRIGHTNESS_PERCENT" >/dev/null
fi

# Send notification
notify_brightness "$NEW_BRIGHTNESS_PERCENT"
