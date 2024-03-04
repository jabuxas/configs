#!/bin/bash
# init script

CURRENT_THEME=$(cat ~/colorscheme)

case "$CURRENT_THEME" in
    solarized)
        killall waybar; waybar -s ~/.config/waybar/style-solarized.css > /dev/null &
        # hyprctl keyword general:col.active_border  todo
    ;;
    melange) 
        killall waybar; waybar -s ~/.config/waybar/style-melange.css > /dev/null &
        hyprctl keyword general:col.active_border "rgba(7892bdff) rgba(6e9b72ff) 45deg"
    ;;
    white)
        killall waybar; waybar -s ~/.config/waybar/style-solarized-light.css > /dev/null &
        # hyprctl keyword general:col.active_border  todo
    ;;
    red) 
        killall waybar; waybar > /dev/null &
        hyprctl keyword general:col.active_border "rgba(ff0038ee) rgba(33e2c5ee) 45deg"
    ;;
    *)
    exit 0
esac
