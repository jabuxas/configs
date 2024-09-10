#!/usr/bin/env sh

swpy_dir="${XDG_CONFIG_HOME:-$HOME/.config}/swappy"
save_dir="$HOME/pics/screenshots"
save_file="screenshot-$(date -Iseconds | cut -d '+' -f1).png"
temp_screenshot="/tmp/screenshot.png"

mkdir -p $save_dir
mkdir -p $swpy_dir
echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" > $swpy_dir/config

upload ()
{
    curl -F'file=@'"${save_dir}/${save_file}" -H 'X-Auth: '$(cat ~/.key) https://paste.jabuxas.xyz | wl-copy
}

function print_error
{
cat << "EOF"
    ./way-print.sh <action>
    ...valid actions are...
        p : print all screens
        s : snip current screen
        m : print focused monitor
        t : tmp print
        cw: current window
EOF
}

case $1 in
p)  # print all outputs
    grim $temp_screenshot && swappy -f $temp_screenshot ;;
s)  # drag to manually snip an area / click on a window to print it
    grim -g "$(slurp)" $temp_screenshot && swappy -f $temp_screenshot ;;
m)  # print focused monitor
    grim -o $(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).output') $temp_screenshot && swappy -f $temp_screenshot ;;
t)  #upload to paste temporarily
    grim -g "$(slurp)" $temp_screenshot && swappy -f $temp_screenshot && upload ;;
cw) #current window
    ~/.local/bin/print-window.sh ;;
*)  # invalid option
    print_error ;;
esac

rm "$temp_screenshot"
