#!/bin/bash

WHITE_WIDE_WPP=~/pics/wallpapers/sl3.jpg
WHITE_NORMAL_WPP=~/pics/wallpapers/sl2.png

RED_WIDE_WPP=~/pics/wallpapers/bm5.jpg
RED_NORMAL_WPP=~/pics/wallpapers/bm3.png
RED_WIDE_LIVE=2883426230
RED_NORMAL_LIVE=2011974721

MELANGE_WIDE_LIVE=2980001176
MELANGE_NORMAL_LIVE=3033188884

CHOICE=$(tofi <$HOME/scripts/choices)


case "$CHOICE" in
    melange)

    # i'll give linux-wppengine a try
    ~/scripts/wppengine.sh $MELANGE_WIDE_LIVE $MELANGE_NORMAL_LIVE

    #change tmux theme
    ln -sf ~/.config/tmux/tmux-melange.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # waybar white css
    killall waybar; waybar -s ~/.config/waybar/style-solarized.css > /dev/null &

    # change wezterm theme
    sed -i 's/color_scheme = .*/color_scheme = "Gruvbox light, medium (base16)"/g' ~/.config/wezterm/wezterm.lua

    # change waybar theme
    killall waybar; waybar -s ~/.config/waybar/style-melange.css > /dev/null &

    # neofetch
    sed -i 's/image_source=.*/image_source="$HOME\/pics\/neofetch\/melangium.jpg"/g' ~/.config/neofetch/config.conf


    ;;
    white)

    ln -sf ~/.config/tmux/tmux-white.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # change wezterm theme
    sed -i 's/color_scheme = .*/color_scheme = "Solarized Light (Gogh)"/g' ~/.config/wezterm/wezterm.lua
    
    # neofetch
    sed -i 's/image_source=.*/image_source="$HOME\/pics\/rh.jpg"/g' ~/.config/neofetch/config.conf
    sed -i '0,/cl3/{s/cl3/cl11/}' ~/.config/neofetch/config.conf

    # waybar white css
    killall waybar; waybar -s ~/.config/waybar/style-solarized.css > /dev/null &

    ;;
    red)

    # wpp engine?
    ~/scripts/wppengine.sh $RED_WIDE_LIVE $RED_NORMAL_LIVE

    # change tmux theme and reload
    ln -sf ~/.config/tmux/tmux-red.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # change wezterm theme
    sed -i 's/color_scheme = .*/color_scheme = "Fahrenheit"/g' ~/.config/wezterm/wezterm.lua

    # change neofetch pic (yes lmao)
    sed -i 's/image_source=.*/image_source="$HOME\/pics\/red.jpg"/g' ~/.config/neofetch/config.conf
    sed -i '0,/cl11/{s/cl11/cl3/}' ~/.config/neofetch/config.conf

    # waybar black css
    killall waybar; waybar > /dev/null &
    ;;
    *)
    exit 0
    ;;
esac

echo $CHOICE > ~/colorscheme
