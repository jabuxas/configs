#!/bin/bash
name="$HOME/pics/screenshots/screenshot-$(date -Iseconds | cut -d '+' -f1).png"
if [[ $XDG_SESSION_TYPE == "x11" ]]; then
  maim -u -n -l -c 0.157,0.333,0.466,0.4 $name
  xclip -selection clipboard -t image/png $name
fi

if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
  grim $name
  $name
fi

