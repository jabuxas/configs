bass source /etc/profile

fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/.local/share/nvim/mason/bin"

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /p/.ghcup/bin # ghcup-env
source "$HOME/.cargo/env.fish"
# source "$HOME/.cache/wal/colors.fish"

set -gx GPG_TTY (tty)
set -gx EDITOR "nvim"

set -gx FZF_DEFAULT_OPTS '--height 50% --layout=reverse --border --preview "bat --style=numbers --color=always {}"'

if test -z "$XDG_VTNR"; set XDG_VTNR 0; end
if test -z "$WAYLAND_DISPLAY" && test "$XDG_VTNR" -eq 1
    set -gx XDG_CURRENT_DESKTOP "sway"
    sway
end

if status is-interactive
    abbr -a cb "~/repos/cports/cbuild"
    abbr -a g "git"
    alias ls="bash ~/scripts/elash.sh"
    abbr -a l "ls -lah"
    abbr -a v "nvim"
    abbr -a hr "date +'%Hh:%M, %d-%m-%Y'"
    abbr -a ff "fastfetch"
    abbr -a feh "imv"
    abbr -a lg "lazygit"
    abbr -a cpr "cd ~/repos/cports-docker && docker compose run --build --rm cports"
    abbr -a cop "wl-copy"
    abbr -a cat "bat"
    abbr -a sus "systemctl suspend"
    abbr -a dom "docker compose -p "ciga-diario" -f CIGA-DIARIO-DEV-LOCALHOST.yml"
    abbr -a dcs "docker compose"
    abbr -a emackie "emacsclient --socket-name=/run/user/$(id -u)/emacs/server -nw"

    abbr -a b 'cd -'
    abbr -a .. 'cd ..'
    abbr -a ... 'cd ../..'
    abbr -a .... 'cd ../../..'

    abbr -a calc "bc"
    abbr -a please "sudo"
    abbr -a tokei "tokei --sort lines"

    abbr -a protontricks 'flatpak run com.github.Matoking.protontricks'
    abbr -a protontricks-launch 'flatpak run --command=protontricks-launch com.github.Matoking.protontricks'

    abbr -a generate_token "curl -u jabuxas https://paste.jabuxas.com | wl-copy"

    abbr -a deck "pkill steam; sleep 3; gamescope --mangoapp -e -- env STEAM_RUNTIME=1 steam -tenfoot -steamos3"
    abbr -a df "dysk"

    abbr -a rst "sudo ip link set enp4s0 down && sudo ip link set enp4s0 up && sudo systemctl restart NetworkManager && sudo ntpdate -b -u 0.gentoo.pool.ntp.org"

    abbr -a poweroff "systemctl poweroff"
    abbr -a reboot "systemctl reboot"
    abbr -a hi "systemctl hibernate"

    abbr -a '!*' --position anywhere --function last_history_arguments
    abbr -a !! --position anywhere --function last_history_item

    bind \cH backward-kill-word 
end


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
    fish_write normal "\n"

    if set -q SSH_CONNECTION
        fish_write green (whoami)
        fish_write normal "@"
        fish_write blue (hostname)
        fish_write normal " [ssh]:"
    end

    fish_write normal " "
    fish_write magenta (prompt_pwd --full-length-dirs=99999)

    fish_write normal "\n := "
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
