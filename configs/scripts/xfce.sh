#!/bin/bash

setxkbmap br abnt2

xinput --set-prop 'pointer:''Gaming Mouse' 'libinput Accel Profile Enabled' 0, 1 
xinput --set-prop 'pointer:''Gaming Mouse' 'libinput Accel Speed' 0.1 

pulseaudio --start

picom &

numlockx on 

mpd &

touch ~/tmp/touchy
rm -rf ~/tmp/*

/usr/bin/emacs --daemon &

otd &
