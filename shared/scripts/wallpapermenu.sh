#!/usr/bin/env bash

# forked from BreadOnPenguins
# slightly scuffed wallpaper picker menu for use with pywal - uses nsxiv if installed, otherwise uses dmenu

FOLDER=~/pics/wallpapers # wallpaper folder
SCRIPT=~/scripts/post-wal.sh # script to run after wal for refreshing programs, etc.



# If no image is selected, pick random
menu () {
	if command -v sxiv >/dev/null; then 
		CHOICE=$(sxiv -otb "$FOLDER"/*)
	else 
		CHOICE=$(nsxiv -otb "$FOLDER"/*)
	fi

	if [ -z "$CHOICE" ]; then
		wal -i "$FOLDER" ${WAL_ARGS} -a 90 -o $SCRIPT
	else
		wal -i "$CHOICE" ${WAL_ARGS} -a 90 -o $SCRIPT
	fi
}

case "$#" in
		0) menu ;;
		1) WAL_ARGS="-l" menu ;;
		*) exit 0 ;;
esac

# If given arguments:
# First argument will be used by pywal as wallpaper/dir path
# Second will be used as theme (use wal --theme to view built-in themes)

