#!/usr/bin/env bash

# Get current brightness percentage
BRIGHTNESS=$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%')

# Set notification parameters
NOTIF_ID=1001  # Unique ID for brightness notification
ICON="display-brightness-symbolic"
URGENCY="normal"
TIMEOUT=1500  # Notification timeout in milliseconds
MESSAGE="Brightness: ${BRIGHTNESS}%"

# Send or update notification
notify-send -h int:transient:1 -r $NOTIF_ID -u $URGENCY -t $TIMEOUT -i $ICON \
    -h int:value:$BRIGHTNESS -h string:synchronous:brightness "$MESSAGE"
