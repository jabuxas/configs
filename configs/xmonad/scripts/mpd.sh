#!/bin/sh

mpt=$(mpc current -f %title%)
mpa=$(mpc current -f %artist%)
icon1=' '
icon2=''
echo "$icon2 $mpa - $icon1 $mpt"


