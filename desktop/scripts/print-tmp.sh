#!/bin/bash
tmp="$HOME/tmp/tmp.png"
if [[ $XDG_SESSION_TYPE == "x11" ]]; then
  maim -u -s "$tmp" 
  curl -F'file=@'"${tmp}" https://0x0.st | xclip -sel clip
fi

if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
  grim -g "$(slurp)" $tmp
  curl -F'file=@'"${tmp}" -H 'X-Auth: '$(cat ~/.key) https://paste.jabuxas.xyz | wl-copy
fi
