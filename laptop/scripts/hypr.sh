#!/bin/bash
# init script

CURRENT_THEME=$(cat ~/colorscheme)

case "$CURRENT_THEME" in
    monochrome)
        killall waybar; waybar > /ðev/null & disown
    ;;
    fan)
        killall waybar; waybar -c ~/.config/waybar/config-white.jsonc -s ~/.config/waybar/style-white.css > /dev/null &
        # hyprctl keyword general:col.active_border  todo
        ;;
    *)
    exit 0
esac
