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
            FIRST=~/images/wallpapers/bm5.jpg
            SECOND=~/images/wallpapers/bm3.png
            ;;
        rose)
            SECOND=~/images/flower.jpg
            FIRST=~/images/wallpapers/rose1.jpg
            ;;
        melange)
            FIRST=~/images/wallpapers/melange2.png
            SECOND=~/images/wallpapers/melange1.jpg
            ;;
        white)
            FIRST=~/images/wallpapers/wh1.png
            SECOND=~/images/wallpapers/wh2.jpg
            ;;
        solarized)
            FIRST=~/images/wallpapers/sl6.jpg
            SECOND=~/images/wallpapers/sl7.jpg
            ;;
        monochrome)
            FIRST=~/images/wallpapers/monochrome-1.png
            SECOND=~/images/wallpapers/monochrome-1.jpg
            ;;
        forest)
            FIRST=~/images/wallpapers/ef1.jpg
            SECOND=~/images/wallpapers/ef2.jpg
    esac
else
    FIRST=$1
    SECOND=$2
fi


swww-daemon &
sleep 0.3

swww img -o HDMI-A-1 $FIRST
swww img -o DP-1 $SECOND
# swww img -o DP-3 ~/images/wallpapers/sl4.jpg
