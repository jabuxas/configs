#!/bin/bash
name="$HOME/pics/screenshots/screenshot-$(date -Iseconds | cut -d '+' -f1).png" 
if [[ $XDG_SESSION_TYPE == "x11" ]]; then
  maim -u -s $name 
  xclip -selection clipboard -t image/png $name
fi

if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
  grim -g "$(slurp)" $name
  xclip -selection clipboard -t image/png $name
  wl-copy < $name
fi

