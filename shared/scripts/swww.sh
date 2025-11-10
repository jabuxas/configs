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
        nord)
            FIRST=~/pics/wallpapers/ign_bratislava.png
            SECOND=~/pics/wallpapers/earth-in-space.png
            ;;
        rose)
            SECOND=~/pics/flower.jpg
            FIRST=~/pics/wallpapers/rose1.jpg
            ;;
        melange)
            FIRST=~/pics/wallpapers/melange2.png
            SECOND=~/pics/wallpapers/melange1.jpg
            ;;
        white)
            FIRST=~/pics/wallpapers/wh1.png
            SECOND=~/pics/wallpapers/wh2.jpg
            ;;
        solarized)
            FIRST=~/pics/wallpapers/sl6.jpg
            SECOND=~/pics/wallpapers/sl7.jpg
            ;;
        monochrome)
            FIRST=~/pics/wallpapers/monochrome-1.png
            SECOND=~/pics/wallpapers/monochrome-1.jpg
            ;;
        forest)
            FIRST=~/pics/wallpapers/ef1.jpg
            SECOND=~/pics/wallpapers/ef2.jpg
            ;;
        henna)
            # FIRST=~/pics/wallpapers/wallhaven-5yw7d8.jpg
            # SECOND=~/pics/wallpapers/wallhaven-5yw7d8.jpg

            FIRST=~/pics/wallpapers/diabao.jpg
            SECOND=~/pics/wallpapers/diabao.jpg
            ;;
        wal)
            FIRST=$(<~/.cache/wal/wal)
            SECOND=$(<~/.cache/wal/wal)
    esac
else
    FIRST=$1
    SECOND=$2
fi

if [ $(hostname -s) == gu ]; then
    SWWW_ARGS="--format xrgb"
fi

sleep 2
swww-daemon $SWWW_ARGS &
sleep 0.3

swww img -o HDMI-A-1 $FIRST
swww img -o HDMI-A-2 $FIRST
swww img -o eDP-1 $SECOND
swww img -o DP-3 $SECOND

# swww img -o DP-3 ~/pics/wallpapers/sl4.jpg
