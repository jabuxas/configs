#!/usr/bin/env fish
set CURRENT_THEME (cat ~/colorscheme)
echo $CURRENT_THEME

set wpp1_white ~/pics/wallpapers/sl3.jpg
set wpp2_white ~/pics/wallpapers/sl2.png

set wpp1_solarized ~/pics/wallpapers/sl6.jpg
set wpp2_solarized ~/pics/wallpapers/sl7.jpg


switch $CURRENT_THEME
    case solarized
        echo changing to white ...
        sed -i 's|solarized-dark.toml|white.toml|' ~/.config/alacritty/alacritty.toml
        pkill waybar; waybar -s ~/.config/waybar/style-white.css &> /dev/null & disown
        ~/scripts/swww.sh $wpp1_white $wpp2_white
        echo white > ~/colorscheme
    case white
        echo changing to solarized ...
        sed -i 's|white.toml|solarized-dark.toml|' ~/.config/alacritty/alacritty.toml
        pkill waybar; waybar &> /dev/null & disown
        ~/scripts/swww.sh $wpp1_solarized $wpp2_solarized
        echo solarized > ~/colorscheme
    case '*'
        echo mmmm what?
end

swaymsg reload
