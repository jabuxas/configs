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
  curl -F'file=@'"${save_dir}/${save_file}" -Fsecret= https://paste.jabuxas.xyz | wl-copy
}

function print_error
{
cat << "EOF"
    ./screenshot.sh <action>
    ...valid actions are...
        p : print all screens
        s : snip current screen
        sf : snip current screen (frozen)
        m : print focused monitor
EOF
}

case $1 in
p)  # print all outputs
    ~/.local/bin/grimblast copysave screen $temp_screenshot && swappy -f $temp_screenshot ;;
s)  # drag to manually snip an area / click on a window to print it
    ~/.local/bin/grimblast copysave area $temp_screenshot && swappy -f $temp_screenshot ;;
sf)  # frozen screen, drag to manually snip an area / click on a window to print it
    ~/.local/bin/grimblast --freeze copysave area $temp_screenshot && swappy -f $temp_screenshot ;;
m)  # print focused monitor
    ~/.local/bin/grimblast copysave output $temp_screenshot && swappy -f $temp_screenshot ;;
t)  #upload to 0x0.st temporarily
    ~/.local/bin/grimblast copysave area $temp_screenshot && swappy -f $temp_screenshot && upload ;;
*)  # invalid option
    print_error ;;
esac

rm "$temp_screenshot"
