# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("$HOME/.zsh/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

# ~/.zshrc: interactive zsh configuration

setopt APPEND_HISTORY HIST_IGNORE_ALL_DUPS SHARE_HISTORY

bindkey -e
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Shift-select mode
zle_highlight=(region:standout)

shift-select-init() { ((REGION_ACTIVE)) || zle set-mark-command; }

for w in {forward,backward}-char {forward,backward}-word {beginning,end}-of-line; do
  eval "shift-select-$w() { shift-select-init; zle $w; }"
  zle -N shift-select-$w
done

bindkey '^[[1;2D' shift-select-backward-char    # Shift+Left
bindkey '^[[1;2C' shift-select-forward-char     # Shift+Right
bindkey '^[[1;6D' shift-select-backward-word    # Ctrl+Shift+Left
bindkey '^[[1;6C' shift-select-forward-word     # Ctrl+Shift+Right
bindkey '^[[1;2H' shift-select-beginning-of-line # Shift+Home
bindkey '^[[1;2F' shift-select-end-of-line      # Shift+End

# Deselect on unshifted movement
deselect() { REGION_ACTIVE=0; zle $1; }
for w in forward-char backward-char forward-word backward-word beginning-of-line end-of-line; do
  eval "deselect-$w() { deselect $w; }"
  zle -N deselect-$w
done
bindkey '^[[D' deselect-backward-char
bindkey '^[[C' deselect-forward-char
bindkey '^[[1;5D' deselect-backward-word
bindkey '^[[1;5C' deselect-forward-word
bindkey '^[[H' deselect-beginning-of-line
bindkey '^[[F' deselect-end-of-line

HISTSIZE=1000
SAVEHIST=2000
HISTFILE="$HOME/.zsh_history"

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -x /usr/bin/dircolors ]; then
  if [ -r "$HOME/.dircolors" ]; then
    eval "$(dircolors -b "$HOME/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi

  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(fc -ln -1)"'

if [ -f "$HOME/.bash_aliases" ]; then
  . "$HOME/.bash_aliases"
fi

alias lx='eza -lagBmMU'
alias xl='eza -lagBmMU'
alias lxg='eza -lagBmMU --git'
alias lxr='eza -lagBmMU --git-repos'
alias bat='batcat'
alias CT='rclone_mount CT'
alias crt='cool-retro-term'
alias tempdir='out="$(mktemp -d)" && cd "$out"'
alias scrn='cbonsai -SM6L50'
alias gs='git status'
alias vim='nvim'
alias lg='lazygit'
alias gl='lazygit'
alias claer='clear'
alias p='dc px'
alias x='dc wi'
alias m='dc model'
alias wp='dc pilot'

[ -f "$HOME/.config/shell/private-aliases.sh" ] && . "$HOME/.config/shell/private-aliases.sh"

if command -v xhost >/dev/null 2>&1 && [ -n "${DISPLAY:-}" ]; then
  xhost +SI:localuser:"$USER" >/dev/null 2>&1
fi

autoload -Uz compinit
compinit

autoload -Uz bashcompinit
bashcompinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export NVM_DIR="$HOME/.nvm"
load_nvm() {
  unfunction nvm node npm npx codex 2>/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

nvm() {
  load_nvm
  nvm "$@"
}

node() {
  load_nvm
  node "$@"
}

npm() {
  load_nvm
  npm "$@"
}

npx() {
  load_nvm
  npx "$@"
}

codex() {
  load_nvm
  codex "$@"
}

eval -- "$("$HOME/.cargo/bin/starship" init zsh --print-full-init)"
eval "$(zoxide init --cmd dc zsh)"
