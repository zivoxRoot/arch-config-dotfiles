#!/usr/bin/env bash

# Set notification parameters
NOTIF_ID=1002     # Unique ID for hyprsunset notification
URGENCY="normal"
TIMEOUT=1500      # Notification timeout in milliseconds

# Check if hyprsunset is running
if pgrep -x "hyprsunset" > /dev/null; then
    # Hyprsunset is running, kill it
    pkill -x "hyprsunset"
    MESSAGE="Night light deactivated"
    ICON="weather-clear-symbolic"
else
    # Hyprsunset is not running, start it
    hyprsunset &
    MESSAGE="Night light activated"
    ICON="weather-clear-night-symbolic"
fi

# Send or update notification
notify-send -h int:transient:1 -r $NOTIF_ID -u $URGENCY -t $TIMEOUT -i $ICON \
    -h string:synchronous:hyprsunset "$MESSAGE"
