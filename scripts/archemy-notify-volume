#!/usr/bin/env bash

# Get current volume and mute status using wpctl
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | cut -d. -f1)
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "true" || echo "false")

# Set notification parameters
NOTIF_ID=1000  # Unique ID for volume notification
ICON="audio-volume-high-symbolic"
URGENCY="normal"
TIMEOUT=1500  # Notification timeout in milliseconds

# Adjust icon and message based on mute status
if [ "$MUTED" = "true" ]; then
    MESSAGE="Muted"
    VOLUME=0
    ICON="audio-volume-muted-symbolic"
    URGENCY="critical"
else
    MESSAGE="Volume: ${VOLUME}%"
fi

# Send or update notification
notify-send -h int:transient:1 -r $NOTIF_ID -u $URGENCY -t $TIMEOUT -i $ICON \
    -h int:value:$VOLUME -h string:synchronous:volume "$MESSAGE"
