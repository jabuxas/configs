#!/bin/bash

GTKDARK="Numix-BLACK-Pomegranate"
GTKLIGHT="Orchis-Teal"


case "$1" in
    light)
	gsettings set org.gnome.desktop.interface color-scheme prefer-light
	gsettings set org.gnome.desktop.interface gtk-theme "$GTKLIGHT"
    ;;
    dark) 
	gsettings set org.gnome.desktop.interface color-scheme prefer-dark
 	gsettings set org.gnome.desktop.interface gtk-theme "$GTKDARK"
    ;;
    *) exit 0
    ;;
esac
