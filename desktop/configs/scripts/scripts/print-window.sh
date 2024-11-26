#!/bin/bash
swpy_dir="${XDG_CONFIG_HOME:-$HOME/.config}/swappy"
save_dir="$HOME/pics/screenshots"
save_file="screenshot-$(date -Iseconds | cut -d '+' -f1).png"
temp_screenshot="/tmp/screenshot.png"

mkdir -p $save_dir
mkdir -p $swpy_dir
echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" > $swpy_dir/config
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
    rm $temp_screenshot
    grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" $temp_screenshot
    wl-copy < ~/tmp/jabuxas.png
    swappy -f $temp_screenshot
    fi
fi
