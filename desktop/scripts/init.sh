#!/bin/bash
autorandr tv_off
pkill spotifyd; spotifyd &
setxkbmap -option ctrl:nocaps br abnt2
xinput --set-prop 'pointer:''Gaming Mouse' 'libinput Accel Profile Enabled' 0, 1 && xinput --set-prop 'pointer:''Gaming Mouse' 'libinput Accel Speed' 0.5
pkill dunst; dunst &
pkill lxqt-policykit-agent; lxqt-policykit-agent &
touch ~/tmp/touchy && rm -rf ~/tmp/*
pkill otd; otd-daemon &
pkill corectrl; corectrl --minimize-systray &
pkill syncthing; syncthing &
tmux kill-session -t weechat; ~/scripts/weechat.sh
pkill pipewire; pkill wireplumber; pkill pipewire-pulse; pipewire & wireplumber & pipewire-pulse
pkill emacs; emacs --daemon &
pkill gammastep; gammastep -t 4500:3500 -l -23.5475:-46.63611 -b 1.0:0.6 &
~/.local/bin/picom-ibhagwan -b --experimental-backends
