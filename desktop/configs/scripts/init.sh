#!/bin/bash
sh ~/screenlayout.sh
gentoo-pipewire-launcher &
spotifyd &
setxkbmap -option ctrl:nocaps br abnt2
xinput --set-prop 'pointer:''Gaming Mouse' 'libinput Accel Profile Enabled' 0, 1 && xinput --set-prop 'pointer:''Gaming Mouse' 'libinput Accel Speed' 0.5
dunst &
lxqt-policykit-agent &
touch ~/tmp/touchy && rm -rf ~/tmp/*
otd &
gsettings set org.gnome.desktop.interface icon-theme Win10Sur-black-dark & gsettings set org.gnome.desktop.interface gtk-theme Numix-BLACK-Pomegranate & gsettings set org.gnome.desktop.interface cursor-theme Simp1e
corectrl --minimize-systray &
gammastep -t 4500:3500 -l -23.5475:-46.63611 -b 1.0:0.5 &

xset -dpms
setterm -blank 0 -powerdown 0

xset s off
