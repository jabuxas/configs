#!/bin/bash

sleep 2
pkill -f /usr/libexec/xdg-desktop-portal\*
sleep 1
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 1
exec /usr/libexec/xdg-desktop-portal
