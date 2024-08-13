HISTFILE=~/.zsh_history
SAVEHIST=3000000
HISTSIZE=3000000
setopt inc_append_history share_history

[[ -s /jbx/.autojump/etc/profile.d/autojump.sh ]] && source /jbx/.autojump/etc/profile.d/autojump.sh
. ~/docs/polyglot/polyglot.sh

export PATH=$PATH:~/go/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/jbx/.spicetify

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

export BAT_THEME="Solarized (dark)"
export EDITOR=nvim
export LS_COLORS="$(~/.local/bin/vivid generate solarized-dark)"
export TERMINAL=alacritty

autoload -U compinit && compinit -u
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#344146"
source ~/docs/zsh-autosuggestions/zsh-autosuggestions.zsh
source /jbx/docs/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    export XDG_CURRENT_DESKTOP="sway"
    dbus-run-session sway
fi
