#!/usr/bin/env bash

# forked from BreadOnPenguins
# slightly scuffed wallpaper picker menu for use with pywal - uses nsxiv if installed, otherwise uses dmenu

FOLDER=~/pics/wallpapers # wallpaper folder
SCRIPT=~/scripts/post-wal.sh # script to run after wal for refreshing programs, etc.



menu () {
		if command -v nsxiv >/dev/null; then 
				CHOICE=$(nsxiv -otb $FOLDER/*)
		else 
				CHOICE=$(sxiv -otb $FOLDER/*)
		fi

case $CHOICE in
		Random) wal -i "$FOLDER" ${WAL_ARGS} -a 90 -o $SCRIPT ;; # dmenu random option
		*.*) wal -i "$CHOICE" ${WAL_ARGS} -a 90 -o $SCRIPT ;;
		*) exit 0 ;;
esac
}

case "$#" in
		0) menu ;;
		1) WAL_ARGS="-l" menu ;;
		*) exit 0 ;;
esac

# If given arguments:
# First argument will be used by pywal as wallpaper/dir path
# Second will be used as theme (use wal --theme to view built-in themes)

