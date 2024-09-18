if status --is-login
    fish_add_path ~/.local/bin
    fish_add_path "$HOME/.cargo/bin"

    set -gx BAT_THEME "Solarized (light)"
    set -gx EDITOR "nvim"
    set -gx DOCKER_HOST unix://$XDG_RUNTIME_DIR/podman/podman.sock

    if test -z "$WAYLAND_DISPLAY" && test "$XDG_VTNR" -eq 1
    set -gx XDG_CURRENT_DESKTOP "sway"
    sway
    end
end
if status is-interactive
    alias cb="~/repos/cports/cbuild"
    alias g="git"
    alias ls="bash ~/scripts/elash.sh"
    alias l="ls -lah"
    alias v="nvim"
    alias reboot="loginctl reboot"
    alias hr="date +'%Hh:%M, %d-%m-%Y'"
    alias hi="loginctl hibernate"
    alias ff="fastfetch"
    alias feh="imv"
    alias lg="lazygit"
    alias cpr="cd ~/repos/cports-docker && docker compose run --build --rm cports"
    alias cop="wl-copy"
    alias poweroff="loginctl poweroff"
    alias cat="bat"
end

function pst
    set -l file
    set -l use_ansifilter false

    if command -v ansifilter > /dev/null
        set use_ansifilter true
    end

    if command test -p /dev/stdin
        set file "/tmp/tmp.txt"
        if test $use_ansifilter = true
            ansifilter > $file
        else
            cat > $file
        end
    else if test -n "$argv[1]"
        set file "$argv[1]"
    end

    curl -F "file=@$file" -H "X-Auth: $(cat ~/.key)" https://paste.jabuxas.xyz

    if command test -p /dev/stdin
        rm "$file"
    end
end

function last_history_item
    echo $history[1]
end
function last_history_arguments
    set -l args (string split ' ' $history[1])
    echo $args[-1]
end
abbr -a '!*' --position anywhere --function last_history_arguments
abbr -a !! --position anywhere --function last_history_item