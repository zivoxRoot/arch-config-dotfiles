#/bin/sh

# This script start the swayidle daemon so we have an automatic lockscreen and screen off 
sleep 3
notify-send "Hellooooooooo"

swayidle -w timeout 10 notify-send "Hello everybody !!!!!!!" timeout 180 'hyprlock' timeout 240 'notify-send "Screen locking in 1 minute !!"' timeout 300 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' # lock after 3 mins, notify the user after 4mins, sleep after 5 mins
