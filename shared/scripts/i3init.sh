#!/bin/sh
setxkbmap us intl ctrl:nocaps

nvidia-settings -a "[gpu:0]/GpuPowerMizerMode=1"

xrandr --output eDP --primary --mode 1920x1080 --rate 144 --pos 0x0 --rotate normal --output HDMI-1-0 --mode 2560x1080 --rate 75 --pos 1920x0 --rotate normal
