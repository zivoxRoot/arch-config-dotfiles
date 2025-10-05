#!/usr/bin/env bash

# Check for screenshot type argument
SHOT_TYPE="${1:-region}" # Default to 'region' if no argument provided

# Validate the screenshot type
case "$SHOT_TYPE" in
    region|window|output)
        HYPRSHOT_MODE="$SHOT_TYPE"
        ;;
    fullscreen)
        HYPRSHOT_MODE="output" # Fullscreen maps to output in Hyprshot
        ;;
    *)
        notify-send "Invalid screenshot type" "Using region mode. Valid types: region, window, fullscreen"
        HYPRSHOT_MODE="region"
        ;;
esac

# Define output directory and filename
OUTPUT_DIR="$HOME/Pictures/Screenshots"
FILENAME="Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"
FILEPATH="$OUTPUT_DIR/$FILENAME"

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Take screenshot with Hyprshot and save to FILEPATH
hyprshot -m "$HYPRSHOT_MODE" -o "$OUTPUT_DIR" -f "$FILENAME"

# Sleep for satty to be able to access the screenshot
sleep 0.2

# Check if the screenshot was saved successfully
if [ -f "$FILEPATH" ]; then
    # Open the screenshot in Satty
    satty --filename "$FILEPATH" --output-filename "$FILEPATH" --init-tool brush --copy-command wl-copy
else
    notify-send "Screenshot failed" "Hyprshot could not save the screenshot."
    exit 1
fi
