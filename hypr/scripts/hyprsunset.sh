#/bin/sh

# Check if hyprsunset is running
if pgrep -x "hyprsunset" > /dev/null; then
	# If running, kill it
	pkill -x "hyprsunset"
	notify-send "Hyprsunset deactivated"
else
	# If not running, start it
	hyprsunset &
	notify-send "Hyprsunset activated"
fi
