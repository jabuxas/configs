#!/bin/bash

WALLPAPER=$(<~/.cache/wal/wal)

swww img "$WALLPAPER"

tmux source ~/.config/tmux/tmux.conf

pkill waybar; waybar -c ~/.config/waybar/config.jsonc 2>/dev/null & disown
