#!/bin/sh
SWWW_TRANSITION_STEP=1
SWWW_TRANSITION_FPS=60
SWWW_TRANSITION="grow"

swww-daemon &

sleep 0.5 && swww img -o DP-3 ~/pics/wallpapers/a\ carnival.jpg
swww img -o HDMI-A-1 ~/pics/wallpapers/the\ true\ old\ god.jpg
