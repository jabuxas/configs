#!/bin/bash
sh ~/scripts/screenlayout.sh

nitrogen --restore &

nvidia-settings --load-config-only

trayer-srg -l --edge top --align right --SetDockType true --SetPartialStrut true \
  --expand true --width 9 --tint 0xFF181814 --height 27 --transparent false --distance 2 --margin 1 &

# /usr/bin/gentoo-pipewire-launcher &

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

setxkbmap br abnt2

xinput --set-prop 'pointer:''Gaming Mouse' 'libinput Accel Profile Enabled' 0, 1 
xinput --set-prop 'pointer:''Gaming Mouse' 'libinput Accel Speed' 0.1 

#pulseaudio --start

#picom &
# /home/klein/.local/bin/picom-pijulius -b --experimental-backends --animations --animation-for-open-window zoom --vsync &
/home/klein/.local/bin/picom-pijulius --experimental-backends --animations --animation-for-open-window zoom --glx-no-stencil --xrender-sync-fence -b &
# /home/klein/.local/bin/picom-jonaburg &

numlockx on 

mpd &

dunst &

lxqt-policykit-agent &

touch ~/tmp/touchy
rm -rf ~/tmp/*

#killall pasystray; pasystray & # killlall is needed in case you reset dwm, it will just spawn infinites pasystrays

/usr/bin/emacs --daemon &

#/home/lucas/.local/bin/idle &

#urxvtd --quiet --opendisplay --fork
#xrdb -merge ~/.Xresources

# otd &

#discord & # If using regular discord.
#flatpak run com.discordapp.Discord & # If using flatpak

#steam &

#nohup xwinwrap -g 1920x1080 -s -b -un -nf -ni -fdt -argb -st -ov -sp  -- mpv -wid WID --framedrop=vo --no-audio --really-quiet --panscan="1.0" /home/lucas/wpp\&stuff/wallpapers/Fireworks-Reflections.mp4 -loop 0 &
#nohup xwinwrap -g 1400x900+1920+180 -s -b -un -nf -ni -fdt -argb -st -ov -sp  -- mpv -wid WID --framedrop=vo --no-audio --really-quiet --panscan="1.0" /home/lucas/wpp\&stuff/kyoko_animated_wallpaper.mp4 -loop 0 
