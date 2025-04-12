#/usr/bin/env bash

# Check if hyprsunset is running
if pgrep -x "hyprsunset" > /dev/null; then
	pkill -x "hyprsunset"
	notify-send "Hyprsunset deactivated"
else
	hyprsunset &
	notify-send "Hyprsunset activated"
fi
