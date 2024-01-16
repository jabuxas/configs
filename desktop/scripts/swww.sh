#!/bin/sh
SWWW_TRANSITION_STEP=1
SWWW_TRANSITION_FPS=60
SWWW_TRANSITION="grow"

swww-daemon &

current_theme=$(readlink ~/.config/tmux/theme.conf)

if [[ $current_theme == *tmux-white.conf ]]; then
    swww img -o DP-3 ~/pics/wallpapers/HOLY.png
    swww img -o HDMI-A-1 ~/pics/wallpapers/okw\ tf.jpg
else 
    swww img -o DP-3 ~/pics/wallpapers/a\ carnival.jpg
    swww img -o HDMI-A-1 ~/pics/wallpapers/the\ true\ old\ god.jpg
fi
