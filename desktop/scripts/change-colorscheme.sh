#!/bin/bash

WHITE_WIDE_WPP=~/pics/wallpapers/sl3.jpg
WHITE_NORMAL_WPP=~/pics/wallpapers/sl2.png

RED_WIDE_WPP=~/pics/wallpapers/bm5.jpg
RED_NORMAL_WPP=~/pics/wallpapers/bm3.png

CHOICE=$(tofi <$HOME/scripts/choices)


case "$CHOICE" in
    melange)
    ln -sf ~/.config/tmux/tmux-melange.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # waybar white css
    killall waybar; waybar -s ~/.config/waybar/style-solarized.css > /dev/null &

    # change wezterm theme
    sed -i 's/color_scheme = .*/color_scheme = "Gruvbox light, medium (base16)"/g' ~/.config/wezterm/wezterm.lua
    ;;
    white)
    ln -sf ~/.config/tmux/tmux-white.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # change wezterm theme
    sed -i 's/Fahrenheit/Solarized Light (Gogh)/g' ~/.config/wezterm/wezterm.lua
    
    # neofetch
    sed -i 's/red.jpg/rh.jpg/g' ~/.config/neofetch/config.conf
    sed -i '0,/cl3/{s/cl3/cl11/}' ~/.config/neofetch/config.conf

    # waybar white css
    killall waybar; waybar -s ~/.config/waybar/style-solarized.css > /dev/null &
    ;;
    red)
    # change tmux theme and reload
    ln -sf ~/.config/tmux/tmux-red.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # change wezterm theme
    sed -i 's/Solarized Light (Gogh)/Fahrenheit/g' ~/.config/wezterm/wezterm.lua

    # change neofetch pic (yes lmao)
    sed -i 's/rh.jpg/red.jpg/g' ~/.config/neofetch/config.conf
    sed -i '0,/cl11/{s/cl11/cl3/}' ~/.config/neofetch/config.conf

    # waybar black css
    killall waybar; waybar > /dev/null &
    ;;
    *)
    exit 0
    ;;
esac

echo $CHOICE > ~/colorscheme
