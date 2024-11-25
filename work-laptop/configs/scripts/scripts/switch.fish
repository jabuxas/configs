#!/usr/bin/env fish
set CURRENT_THEME (cat ~/colorscheme)
echo $CURRENT_THEME

set wpp1_white ~/pics/white2.jpg
set wpp2_white ~/pics/white.jpg

set wpp1_solarized ~/pics/black.jpg
set wpp2_solarized ~/pics/black2.jpg

swaymsg reload

switch $CURRENT_THEME
    case black
        echo changing to white ...
        gsettings set org.gnome.desktop.interface gtk-theme "Windows-95"
        gsettings set org.gnome.desktop.interface icon-theme "nineicons-redux-v0.6"
        sed -i 's|black.toml|white.toml|' ~/.config/alacritty/alacritty.toml
        ln -sf ~/.config/tmux/themes/tmux-white.conf ~/.config/tmux/theme.conf
        tmux source ~/.config/tmux/tmux.conf
        pkill waybar; waybar -s ~/.config/waybar/style-white.css &> /dev/null & disown
        ~/scripts/swww.sh $wpp1_white $wpp2_white
        echo white > ~/colorscheme
        swaymsg shadows enable
    case white
        echo changing to black...
        gsettings set org.gnome.desktop.interface gtk-theme "Material-Black-Blueberry-LA"
        gsettings set org.gnome.desktop.interface icon-theme "We10X-black-dark"
        swaymsg client.focused "#ffffff #ffffff #c1c1c1"
        swaymsg client.focused_inactive "#c1c1c1 #212121 #cecece"
        sed -i 's|white.toml|black.toml|' ~/.config/alacritty/alacritty.toml
        ln -sf ~/.config/tmux/themes/tmux-monochrome.conf ~/.config/tmux/theme.conf
        tmux source ~/.config/tmux/tmux.conf
        pkill waybar; waybar &> /dev/null & disown
        ~/scripts/swww.sh $wpp1_solarized $wpp2_solarized
        echo black > ~/colorscheme
        swaymsg shadows disable
    case '*'
        echo mmmm what?
end
