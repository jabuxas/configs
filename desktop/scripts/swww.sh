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
        melange)
            FIRST=~/pics/wallpapers/melange2.png
            SECOND=~/pics/wallpapers/melange1.jpg
        ;;
        white) # todo
            FIRST=~/pics/wallpapers/sl3.jpg
            SECOND=~/pics/wallpapers/sl2.png
        ;;
    solarized)
        FIRST=~/pics/wallpapers/solarized5.jpg
        SECOND=~/pics/wallpapers/solarized4.png
    ;;
    monochrome)
        FIRST=~/pics/wallpapers/monochrome-1.png
        SECOND=~/pics/wallpapers/monochrome-1.jpg
    ;;
forest)
    FIRST=~/pics/wallpapers/ef1.jpg
    SECOND=~/pics/wallpapers/ef2.jpg
    esac
else
    FIRST=$1
    SECOND=$2
fi


swww-daemon &
sleep 0.3

swww img -o HDMI-A-1 $FIRST
swww img -o DP-2 $SECOND
swww img -o DP-3 ~/pics/wallpapers/cottage.jpg
