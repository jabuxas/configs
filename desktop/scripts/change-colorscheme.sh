#!/bin/bash
CURRENT_THEME=$(readlink ~/.config/tmux/theme.conf)

WHITE_WIDE_WPP=~/pics/wallpapers/sl3.jpg
WHITE_NORMAL_WPP=~/pics/wallpapers/sl2.png

RED_WIDE_WPP=~/pics/wallpapers/bm5.jpg
RED_NORMAL_WPP=~/pics/wallpapers/bm3.png

if [[ $CURRENT_THEME == *tmux-white.conf ]]; then
    # change wallpaper
    ~/scripts/swww.sh $RED_WIDE_WPP $RED_NORMAL_WPP


    # change tmux theme and reload
    ln -sf ~/.config/tmux/tmux-red.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # change wezterm theme
    sed -i 's/Solarized Light (Gogh)/Fahrenheit/g' ~/.config/wezterm/wezterm.lua

    # change nvim theme
    sed -i 's/zed = true/zed = false/g' ~/.config/nvim/lua/custom/plugins/colorscheme.lua
    sed -i 's/-- h/h/g' ~/.config/nvim/lua/custom/plugins/bufferline.lua

    # change neofetch pic (yes lmao)
    sed -i 's/rh.jpg/red.jpg/g' ~/.config/neofetch/config.conf
    sed -i '0,/cl11/{s/cl11/cl3/}' ~/.config/neofetch/config.conf

    # waybar black css
    killall waybar; waybar > /dev/null &
else
    # change wpp
    ~/scripts/swww.sh $WHITE_WIDE_WPP $WHITE_NORMAL_WPP

    # change tmux theme and reload
    ln -sf ~/.config/tmux/tmux-white.conf ~/.config/tmux/theme.conf
    tmux source-file ~/.config/tmux/tmux.conf

    # change wezterm theme
    sed -i 's/Fahrenheit/Solarized Light (Gogh)/g' ~/.config/wezterm/wezterm.lua

    # change nvim theme
    sed -i 's/zed = false/zed = true/g' ~/.config/nvim/lua/custom/plugins/colorscheme.lua
    sed -i 's/highlights/-- highlights/g' ~/.config/nvim/lua/custom/plugins/bufferline.lua
    
    # neofetch
    sed -i 's/red.jpg/rh.jpg/g' ~/.config/neofetch/config.conf
    sed -i '0,/cl3/{s/cl3/cl11/}' ~/.config/neofetch/config.conf

    # waybar white css
    killall waybar; waybar -s ~/.config/waybar/style-solarized.css > /dev/null &
fi
