#!/bin/bash

WALLPAPER=$(<~/.cache/wal/wal)

export SWWW_TRANSITION_STEP=90
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION=wipe
export SWWW_TRANSITION_ANGLE=30
export SWWW_TRANSITION_POS=center

swww img -o HDMI-A-1 "$WALLPAPER" &
swww img -o DP-2 "$WALLPAPER" &

tmux source ~/.config/tmux/tmux.conf &

~/.local/bin/pywalfox update &

pkill waybar; waybar -c ~/.config/waybar/config.jsonc 2>/dev/null & disown

cp ~/.cache/wal/colors-anki.json ~/.var/app/net.ankiweb.Anki/data/Anki2/addons21/688199788/themes/Pywal.json
