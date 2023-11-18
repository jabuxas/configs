#!/bin/bash
if [[ $XDG_SESSION_TYPE == "x11" ]]; then
    maim -i $(xdotool getactivewindow) | xclip -sel clip -t image/png
fi
if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    if [[ $XDG_CURRENT_DESKTOP == "Hyprland" ]]; then
    window_info=$(hyprctl activewindow)
    coordinates=$(echo "$window_info" | grep -oP 'at: \K([0-9]+,[0-9]+)')
    size=$(echo "$window_info" | grep -oP 'size: \K([0-9]+,[0-9]+)')
    IFS=',' read -r x y <<< "$coordinates"
    IFS=',' read -r width height <<< "$size"
    grim -g "${x},${y} ${width}x${height}" ~/tmp/jabuxas.png
    wl-copy < ~/tmp/jabuxas.png
    fi

    if [[ $XDG_CURRENT_DESKTOP == "sway" ]]; then
    grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" ~/tmp/jabuxas.png
    xclip -sel clip ~/tmp/jabuxas.png
    wl-copy < ~/tmp/jabuxas.png
    fi
fi
