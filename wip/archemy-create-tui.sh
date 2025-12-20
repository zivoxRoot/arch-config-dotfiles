#!/usr/bin/env bash

echo "Let's create a TUI app shortcut you can start with the app launcher"
echo -en "Name > "
read -r APP_NAME
if [[ -z "$APP_NAME" ]]; then
	echo "You must provide an app name"
fi

echo -en "Executable > "
read -r APP_EXECUTABLE
if [[ -z "$APP_EXECUTABLE" ]]; then
	echo "You must provide an app executable"
fi

DESKTOP_FILE="$HOME/.local/share/applications/$APP_NAME.desktop"

cat >"$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Name=$APP_NAME
Comment=$APP_NAME
Exec="kitty --title='TUI app' -e $APP_EXECUTABLE"
Icon=utilities-terminal
Terminal=false
Type=Application
StartupNotify=true
EOF

update-desktop-database $HOME/.local/share/applications

echo -e "You can now find $APP_NAME using the app launcher"
