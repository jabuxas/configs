#!/bin/bash

WHITE_NORMAL_WPP=~/pics/min.png
MONOCHROME_NORMAL_WPP=~/pics/monochrome-1.png

CHOICE=$(tofi <$HOME/scripts/choices)


case "$CHOICE" in
    monochrome)
    ~/scripts/swww.sh $MONOCHROME_NORMAL_WPP


    ln -sf ~/.config/tmux/tmux-monochrome.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    sed -i 's/color_scheme = .*/color_scheme = "monochrome_glorb"/g' ~/.config/wezterm/wezterm.lua

    sed -i 's/image_source=.*/image_source="$HOME\/pics\/mono.jpg"/g' ~/.config/neofetch/config.conf

    ln -sf ~/.config/tofi/monochrome.conf ~/.config/tofi/theme.conf

    ;;

    fan)
    ~/scripts/swww.sh $WHITE_NORMAL_WPP

    #change tmux theme
    ln -sf ~/.config/tmux/tmux-white.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # change wezterm theme
    sed -i 's/color_scheme = .*/color_scheme = "catppuccin-latte"/g' ~/.config/wezterm/wezterm.lua

    # neofetch
    sed -i 's/image_source=.*/image_source="$HOME\/pics\/neofetch\/sol\/light.jpg"/g' ~/.config/neofetch/config.conf
    # sed -i 's/{cl11}/{cl3}/' ~/.config/neofetch/config.conf

    # change tofi theme
    ln -sf ~/.config/tofi/white.conf ~/.config/tofi/theme.conf
    
    ;;
    *)

    exit 0
    ;;
esac

echo $CHOICE > ~/colorscheme
hyprctl reload
