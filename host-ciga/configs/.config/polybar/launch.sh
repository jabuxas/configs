#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
# Terminate already running bar instances
pkill polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
MONITOR=HDMI-1-1 polybar -c "$SCRIPTPATH/everforest.ini" 3>&1 | tee -a /tmp/polybar.log & disown
MONITOR=eDP polybar -c "$SCRIPTPATH/everforest.ini" 3>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
