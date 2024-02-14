#!/bin/bash

CURRENT_THEME=$(cat ~/colorscheme)
if [[ -z "$1" ]]; then
    case "$CURRENT_THEME" in
        red)
            FIRST=2883426230
            SECOND=2011974721
        ;;
        melange)
            FIRST=2980001176
            SECOND=3033188884
        ;;
        white) # todo
        ;;
    esac
else
    FIRST=$1
    SECOND=$2
fi

killall linux-wallpaperengine
linux-wallpaperengine --silent --no-audio-processing --disable-mouse --screen-root HDMI-A-1 $FIRST > /dev/null &
linux-wallpaperengine --silent --no-audio-processing --disable-mouse --screen-root DP-3 $SECOND > /dev/null &
