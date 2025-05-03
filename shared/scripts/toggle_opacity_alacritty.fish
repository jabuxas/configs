#!/usr/bin/env fish

# Check if alacritty.toml exists; if not, raise an alert and exit
if not test -f ~/.config/alacritty/alacritty.toml
    notify-send "alacritty.toml does not exist"
    exit 0
end

# Fetch opacity from alacritty.toml
set opacity (awk '$1 == "opacity" && $2 == "=" {print $3; exit}' ~/.config/alacritty/alacritty.toml)

# Assign toggle opacity value
switch $opacity
    case 1
        set toggle_opacity 0.95
    case '*'
        set toggle_opacity 1
end

# Replace opacity value in alacritty.toml
sed -i -- "s/opacity = $opacity/opacity = $toggle_opacity/" ~/.config/alacritty/alacritty.toml

