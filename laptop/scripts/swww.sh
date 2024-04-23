#!/bin/bash
export SWWW_TRANSITION_STEP=90
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION=wipe
export SWWW_TRANSITION_ANGLE=30
export SWWW_TRANSITION_POS=center

CURRENT_THEME=$(cat ~/colorscheme)
if [[ -z "$1" ]]; then
    case "$CURRENT_THEME" in
    monochrome)
        FIRST=~/pics/monochrome-1.png
        ;;
    fan)
        FIRST="~/pics/min.png"
    esac
else
    FIRST=$1
fi


swww-daemon --format xrgb &
sleep 0.3

swww img $FIRST
