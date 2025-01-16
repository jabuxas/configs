#!/usr/bin/env sh

save_dir="$HOME/pics/screenshots"
save_file="screenshot-$(date -Iseconds | cut -d '+' -f1).png"
temp_screenshot="/tmp/screenshot.png"

mkdir -p "$save_dir"

upload() {
    curl -F'file=@'"${temp_screenshot}" \
         -Fsecret= \
         -H "X-Auth: $(cat ~/.key)" \
         https://paste.jabuxas.xyz | xclip -selection clipboard
}

print_error() {
cat << "EOF"
    ./x-print.sh <action>
    ...valid actions are...
        p : print all screens
        s : snip current screen
        m : print focused monitor
        t : tmp print
        w : current window
EOF
}

case $1 in
    p)  # print all screens
        maim "$temp_screenshot" && \
        xclip -selection clipboard -t image/png < "$temp_screenshot"
        ;;
        
    s)  # select area to screenshot
        maim -s "$temp_screenshot" && \
        xclip -selection clipboard -t image/png < "$temp_screenshot"
        ;;
        
    m)  # screenshot focused monitor
        focused_monitor=$(fish /home/lucas/scripts/current_monitor.fish)
        maim -g "$(xrandr --query | grep "$focused_monitor" | grep -oP '\d+x\d+\+\d+\+\d+')" "$temp_screenshot" && \
        xclip -selection clipboard -t image/png < "$temp_screenshot"
        ;;
        
    t)  # upload to paste
        maim -s "$temp_screenshot" && \
        xclip -selection clipboard -t image/png < "$temp_screenshot" && \
        upload
        ;;
        
    w)  # current window
        active_window=$(xdotool getactivewindow)
        maim -i "$active_window" "$temp_screenshot" && \
        xclip -selection clipboard -t image/png < "$temp_screenshot"
        ;;
        
    *)  # invalid option
        print_error
        exit 1
        ;;
esac

# Save and cleanup
cp "$temp_screenshot" "${save_dir}/${save_file}"
rm "$temp_screenshot"
