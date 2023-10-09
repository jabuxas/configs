#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
MONITOR=DVI-D-0 polybar -c "$SCRIPTPATH/jabuxas.ini" 3>&1 | tee -a /tmp/polybar.log & disown
MONITOR=HDMI-A-0 polybar -c "$SCRIPTPATH/jabuxas.ini" 3>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
