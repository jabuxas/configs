#!/bin/bash

WHITE_WIDE_WPP=~/pics/wallpapers/sl3.jpg
WHITE_NORMAL_WPP=~/pics/wallpapers/sl2.png

RED_WIDE_WPP=~/pics/wallpapers/bm5.jpg
RED_NORMAL_WPP=~/pics/wallpapers/bm3.png
RED_WIDE_LIVE=2883426230
RED_NORMAL_LIVE=2011974721

MELANGE_WIDE_WPP=~/pics/wallpapers/melange1.png
MELANGE_NORMAL_WPP=~/pics/wallpapers/melange1.jpg
MELANGE_WIDE_LIVE=2980001176
MELANGE_NORMAL_LIVE=3033188884

SOLARIZED_WIDE_WPP=~/pics/wallpapers/solarized5.jpg
SOLARIZED_NORMAL_WPP=~/pics/wallpapers/solarized4.png

CHOICE=$(tofi <$HOME/scripts/choices)


case "$CHOICE" in
    solarized)
    ~/scripts/swww.sh $SOLARIZED_WIDE_WPP $SOLARIZED_NORMAL_WPP

    #change tmux theme
    ln -sf ~/.config/tmux/tmux-solarized.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # change wezterm theme
    sed -i 's/color_scheme = .*/color_scheme = "Solarized Dark (Gogh)"/g' ~/.config/wezterm/wezterm.lua

    # neofetch
    sed -i 's/image_source=.*/image_source="$HOME\/pics\/neofetch\/sol\/☆ICON☆.jpg"/g' ~/.config/neofetch/config.conf
    sed -i 's/{cl11}/{cl3}/' ~/.config/neofetch/config.conf

    # change tofi theme
    ln -sf ~/.config/tofi/solarized.conf ~/.config/tofi/theme.conf
    
    ;;
    melange)

    # i'll give linux-wppengine a try
    ~/scripts/swww.sh $MELANGE_WIDE_WPP $MELANGE_NORMAL_WPP

    #change tmux theme
    ln -sf ~/.config/tmux/tmux-melange.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # change wezterm theme
    sed -i 's/color_scheme = .*/color_scheme = "melange_light"/g' ~/.config/wezterm/wezterm.lua

    # neofetch
    sed -i 's/image_source=.*/image_source="$HOME\/pics\/neofetch\/melangium.jpg"/g' ~/.config/neofetch/config.conf

    # change tofi theme
    ln -sf ~/.config/tofi/melange.conf ~/.config/tofi/theme.conf

    ;;
    white)

    ln -sf ~/.config/tmux/tmux-white.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # change wezterm theme
    sed -i 's/color_scheme = .*/color_scheme = "Solarized Light (Gogh)"/g' ~/.config/wezterm/wezterm.lua
    
    # neofetch
    sed -i 's/image_source=.*/image_source="$HOME\/pics\/rh.jpg"/g' ~/.config/neofetch/config.conf
    sed -i 's/{cl11}/{cl3}/' ~/.config/neofetch/config.conf

    # change tofi theme
    ln -sf ~/.config/tofi/white.conf ~/.config/tofi/theme.conf

    ;;
    red)

    # wpp engine?
    ~/scripts/swww.sh $RED_WIDE_WPP $RED_NORMAL_WPP

    # change tmux theme and reload
    ln -sf ~/.config/tmux/tmux-red.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # change wezterm theme
    sed -i 's/color_scheme = .*/color_scheme = "Fahrenheit"/g' ~/.config/wezterm/wezterm.lua

    # change neofetch pic (yes lmao)
    sed -i 's/image_source=.*/image_source="$HOME\/pics\/red.jpg"/g' ~/.config/neofetch/config.conf
    sed -i '{cl11}/{cl3}/' ~/.config/neofetch/config.conf

    # change tofi theme
    ln -sf ~/.config/tofi/red.conf ~/.config/tofi/theme.conf

    ;;
    *)

    exit 0
    ;;
esac

echo $CHOICE > ~/colorscheme
hyprctl reload
