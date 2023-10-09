#!/bin/bash
if [[ $XDG_SESSION_TYPE == "x11" ]]; then
    maim -i $(xdotool getactivewindow) | xclip -sel clip -t image/png
fi
if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" ~/tmp/jabuxas.png
    xclip -sel clip ~/tmp/jabuxas.png
    wl-copy < ~/tmp/jabuxas.png
fi
