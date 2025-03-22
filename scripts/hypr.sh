#!/bin/bash
# init script

CURRENT_THEME=$(cat ~/colorscheme)

case "$CURRENT_THEME" in
    forest)
        pkill waybar; waybar -c ~/.config/waybar/dwm.jsonc \
            -s ~/.config/waybar/dwm-forest.css > /dev/null &
        # hyprctl keyword general:col.active_border  todo
    ;;
    monochrome)
        pkill waybar; waybar -c ~/.config/waybar/dwm.jsonc \
            -s ~/.config/waybar/dwm.css > /dev/null &
        # hyprctl keyword general:col.active_border  todo
    ;;
    solarized)
        pkill waybar; waybar -s ~/.config/waybar/style-solarized.css > /dev/null &
        # hyprctl keyword general:col.active_border  todo
    ;;
    melange) 
        pkill waybar; waybar -s ~/.config/waybar/style-melange.css > /dev/null &
        hyprctl keyword general:col.active_border "rgba(7892bdff) rgba(6e9b72ff) 45deg"
    ;;
    white)
        pkill waybar; waybar -s ~/.config/waybar/style-solarized-light.css > /dev/null &
        # hyprctl keyword general:col.active_border  todo
    ;;
    red) 
        pkill waybar; waybar > /dev/null &
        hyprctl keyword general:col.active_border "rgba(ff0038ee) rgba(33e2c5ee) 45deg"
    ;;
    *)
    exit 0
esac
