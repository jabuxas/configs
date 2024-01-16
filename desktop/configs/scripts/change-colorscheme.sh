#!/bin/bash
current_theme=$(readlink ~/.config/tmux/theme.conf)

if [[ $current_theme == *tmux-white.conf ]]; then
    # change wallpaper
    swww img -o DP-3 ~/pics/wallpapers/a\ carnival.jpg
    swww img -o HDMI-A-1 ~/pics/wallpapers/the\ true\ old\ god.jpg

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
else
    # change wpp
    swww img -o DP-3 ~/pics/wallpapers/HOLY.png
    swww img -o HDMI-A-1 ~/pics/wallpapers/okw\ tf.jpg

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
fi
