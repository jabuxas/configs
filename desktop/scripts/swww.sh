#!/bin/bash
export SWWW_TRANSITION_STEP=90
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION=wipe
export SWWW_TRANSITION_ANGLE=30
export SWWW_TRANSITION_POS=center

CURRENT_THEME=$(cat ~/colorscheme)
if [[ -z "$1" ]]; then
    case "$CURRENT_THEME" in
        red)
            FIRST=~/pics/wallpapers/bm5.jpg
            SECOND=~/pics/wallpapers/bm3.png
        ;;
        melange) #todo
        ;;
        white) # todo
            FIRST=~/pics/wallpapers/sl3.jpg
            SECOND=~/pics/wallpapers/sl2.png
        ;;
    esac
else
    FIRST=$1
    SECOND=$2
fi


swww init &
sleep 0.3

swww img -o HDMI-A-1 $FIRST
swww img -o DP-3 $SECOND
