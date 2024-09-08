if status --is-login
    fish_add_path ~/.local/bin

    set -gx BAT_THEME "Solarized (light)"
    set -gx EDITOR "nvim"

    if test -z "$WAYLAND_DISPLAY" && test "$XDG_VTNR" -eq 1
    set -gx XDG_CURRENT_DESKTOP "sway"
    sway
    end
end
if status is-interactive
    alias ls="bash ~/scripts/elash.sh"
    alias v="nvim"
    alias reboot="systemctl reboot"
    alias hr="date +'%Hh:%M, %d-%m-%Y'"
    alias ff="fastfetch"
    alias feh="imv"
    alias lg="lazygit"
    alias cpr="cd ~/repos/cports-docker && docker compose run --build --rm cports"
    alias cop="wl-copy"
    alias poweroff="systemctl poweroff"
    alias cat="bat"
end

function pst
    set -l file
    set -l use_ansifilter false

    if command -v ansifilter > /dev/null
        set use_ansifilter true
    end

    if command test -p /dev/stdin
        set file (mktemp)
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
