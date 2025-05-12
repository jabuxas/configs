#!/bin/bash

WALLPAPER=$(<~/.cache/wal/wal)

export SWWW_TRANSITION_STEP=90
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION=wipe
export SWWW_TRANSITION_ANGLE=30
export SWWW_TRANSITION_POS=center

swww img -o HDMI-A-1 "$WALLPAPER" &
swww img -o DP-3 "$WALLPAPER" &

tmux source ~/.config/tmux/tmux.conf &

~/.local/bin/pywalfox update &

pkill waybar; waybar -c ~/.config/waybar/config.jsonc 2>/dev/null & disown
