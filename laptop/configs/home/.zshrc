HISTFILE=~/.zsh_history
SAVEHIST=3000000
HISTSIZE=3000000
setopt inc_append_history share_history

[[ -s /jbx/.autojump/etc/profile.d/autojump.sh ]] && source /jbx/.autojump/etc/profile.d/autojump.sh
. ~/docs/polyglot/polyglot.sh

. ~/.cargo/env

export PATH=$PATH:~/go/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.spicetify
export PATH=$PATH:~/.local/share/gem/ruby/3.3.0/bin

alias v=nvim
alias ls="~/scripts/elash.sh"
alias la="ls -la"
alias l="ls -lah"
alias ll="ls -lh"
alias sudo="doas"
alias cat="bat"
alias ff="fastfetch"
alias feh="imv"
alias reboot="loginctl reboot"
alias poweroff="loginctl poweroff"
alias hi="loginctl hibernate"
alias lg="lazygit"
alias g="git"
alias cop="wl-copy"
alias kvm="~/scripts/kvm.sh & disown"
alias eix="apk search"

export BAT_THEME="Solarized (dark)"
export EDITOR=nvim
export LS_COLORS="$(vivid generate solarized-dark)"
export TERMINAL=alacritty
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock

autoload -U compinit && compinit -u
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zmodload zsh/complist
autoload -Uz history-search-end
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#344146"
source ~/docs/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/docs/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/docs/zsh-history-substring-search/zsh-history-substring-search.zsh

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

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    export XDG_CURRENT_DESKTOP="sway"
    sway
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
