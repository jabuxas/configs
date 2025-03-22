export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.ghcup/bin:$PATH
export PATH=/sbin:$PATH
export PATH=$HOME/.local/share/nvim/mason/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export R2MOD_INSTALL_DIR="/games/SteamLibrary/steamapps/common/Risk of Rain 2"
export R2MOD_COMPAT_DIR="/games/SteamLibrary/steamapps/compatdata/632360"
export GTK_THEME=NumixSolarizedDarkCyan

. "$HOME/.cargo/env"

# ZSH_THEME="daivasmara"
ZSH_THEME="common"
zstyle ':omz:update' mode auto      # update automatically without asking

umask 002

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
plugins=(git fast-syntax-highlighting zsh-autosuggestions autojump zsh-vi-mode)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#344146"

source $ZSH/oh-my-zsh.sh
unsetopt beep
alias ls="bash ~/scripts/elash.sh"
alias cat="bat"
alias v="nvim"
alias c="clear"
alias hi="pkill linux-wallpaperengine; systemctl hibernate"
alias sx="startx"
alias reboot="systemctl reboot"
alias poweroff="systemctl poweroff"
alias kitsune="cd ~/repos/kitsune && . ~/repos/venv/bin/activate"
alias sus="systemctl suspend-then-hibernate"
alias xsc="xclip -sel clip"
alias sw="swapon --show"
alias icat="kitty +kitten icat"
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
alias hr="date +'%Hh:%M, %d-%m-%Y'"
alias neofetch="fastfetch"
alias kvm="sh ~/scripts/kvm.sh"
alias windows="sudo grub-set-default 0; sudo grub-reboot 'Microsoft Windows UEFI/GPT'; systemctl reboot"
alias ff="fastfetch"
alias feh="imv"
alias cop="wl-copy"
alias lg="lazygit"
alias cpr="cd ~/repos/cports-docker && docker compose run --build --rm cports"

export BAT_THEME="Solarized (light)"
export FPATH="/hdd/docs/eza/completions/zsh:$FPATH"
export EDITOR=nvim
export PATH=$PATH:/yang/.spicetify

eval `dircolors /yang/docs/dircolors.256dark`

[ -f "/yang/.ghcup/env" ] && source "/yang/.ghcup/env" # ghcup-env

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    export XDG_CURRENT_DESKTOP="sway"
    sway
fi

pst() {
  local file

  if [[ -p /dev/stdin ]]; then
    file=$(mktemp)
    cat > "$file"
  elif [[ -n $1 ]]; then
    file="$1"
  else
    echo "Usage: pst [file]"
    return 1
  fi
  
  curl -F "file=@$file" -H "X-Auth: $(cat ~/.key)" https://paste.jabuxas.xyz
  
  if [[ -p /dev/stdin ]]; then
    rm "$file"
  fi
}



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/yang/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/yang/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/yang/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/yang/tmp/google-cloud-sdk/completion.zsh.inc'; fi


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/yang/.opam/opam-init/init.zsh' ]] || source '/yang/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
