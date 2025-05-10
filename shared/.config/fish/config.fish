# bass source /etc/profile
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/go/bin"
source "$HOME/.cargo/env.fish"

set -gx EDITOR "nvim"
# set -gx BAT_THEME "Solarized (light)"
# set -gx SOLARIZED true
set -gx FZF_DEFAULT_OPTS '--height 50% --layout=reverse --border --preview "bat --style=numbers --color=always {}"'
if test -z "$XDG_VTNR"; set XDG_VTNR 0; end
if test -z "$WAYLAND_DISPLAY" && test "$XDG_VTNR" -eq 1
    set -gx XDG_CURRENT_DESKTOP "sway"
    dbus-run-session sway
end

if status is-interactive
    alias cb="~/repos/cports/cbuild"
    alias g="git"
    alias ls="bash ~/scripts/elash.sh"
    alias l="ls -lah"
    alias v="nvim"
    alias hr="date +'%Hh:%M, %d-%m-%Y'"
    alias ff="fastfetch"
    alias feh="imv"
    alias lg="lazygit"
    alias cpr="cd ~/repos/cports-docker && docker compose run --build --rm cports"
    alias cop="wl-copy"
    alias cat="bat"
    alias dom="docker compose -p "ciga-diario" -f CIGA-DIARIO-DEV-LOCALHOST.yml"
    alias emackie="emacsclient --socket-name=/run/user/$(id -u)/emacs/server -nw"

    alias calc="bc"
    alias please="sudo"
    alias tokei="tokei --sort lines"

    alias protontricks='flatpak run com.github.Matoking.protontricks'
    alias protontricks-launch='flatpak run --command=protontricks-launch com.github.Matoking.protontricks'

    alias generate_token="curl -u jabuxas https://paste.jabuxas.com | wl-copy"

    alias deck="pkill steam; sleep 3; gamescope --mangoapp -e -- steam -tenfoot -steamos3"
    alias df="dysk"
end


function set-power-aliases
    if type -q systemctl
        alias poweroff "systemctl poweroff"
        alias reboot "systemctl reboot"
        alias hi "systemctl hibernate"
    else if type -q loginctl
        alias poweroff "loginctl poweroff"
        alias reboot "loginctl reboot"
        alias hi "loginctl hibernate"
    else
        echo "Neither systemctl nor loginctl found."
    end
end

set-power-aliases

function heaven
   AUTH_KEY=(cat ~/.key) AUTH_PARAM='X-Auth' PASTEBIN_URL='https://paste.jabuxas.com' revelation
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

    curl -F "file=@$file" -H "X-Auth: $(cat ~/.key)" https://paste.jabuxas.com

    if command test -p /dev/stdin
        rm "$file"
    end
end

function ytb
    set -l file
    if test -n "$argv[1]"
        set file "$argv[1]"
    end

    cd ~/vids/youtube && yt-dlp -f 303+251 $file
end

function pstf
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

    curl -F "file=@$file" -Fsecret= -H "X-Auth: $(cat ~/.key)" https://paste.jabuxas.com

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

function switch_git_personal
    git config user.name "jabuxas"
    git config user.email "jabuxas@proton.me"
end

function switch_git_work
    git config user.name "lucas barbieri catarina"
    git config user.email "lucas.catarina@consorciociga.gov.br"
end

function fish_write
    set_color $argv[1]
    echo -en $argv[2]
    set_color normal
end

function fish_prompt
    fish_write normal "\n "
    fish_write magenta (prompt_pwd --full-length-dirs=99999)
    fish_write normal "\n := "
end
