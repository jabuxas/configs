export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.ghcup/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.config/emacs/bin:$PATH
export PATH=/sbin:$PATH
export PATH=$HOME/.local/share/nvim/mason/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export R2MOD_INSTALL_DIR="/games/SteamLibrary/steamapps/common/Risk of Rain 2"
export R2MOD_COMPAT_DIR="/games/SteamLibrary/steamapps/compatdata/632360"
export GTK_THEME=Everforest-Dark-BL

# ZSH_THEME="daivasmara"
ZSH_THEME="common"
zstyle ':omz:update' mode auto      # update automatically without asking

umask 002

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
plugins=(git fast-syntax-highlighting zsh-autosuggestions autojump)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#344146"

source $ZSH/oh-my-zsh.sh
unsetopt beep
alias ls="bash ~/scripts/elash.sh"
alias cat="bat"
alias v="nvim"
alias c="clear"
alias hi="pkill linux-wallpaperengine; loginctl hibernate"
alias sx="startx"
alias reboot="loginctl reboot"
alias poweroff="loginctl poweroff"
alias kitsune="cd ~/repos/kitsune && . ~/repos/venv/bin/activate"
alias sus="loginctl suspend-then-hibernate"
alias xsc="xclip -sel clip"
alias sw="swapon --show"
alias icat="kitty +kitten icat"
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
alias hr="date +'%Hh:%M, %d-%m-%Y'"
alias neofetch="fastfetch"

export BAT_THEME="Solarized (light)"
export FPATH="/hdd/docs/eza/completions/zsh:$FPATH"
export EDITOR=nvim
export PATH=$PATH:/yang/.spicetify

[ -f "/yang/.ghcup/env" ] && source "/yang/.ghcup/env" # ghcup-env

# if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#     dbus-run-session Hyprland
# fi
