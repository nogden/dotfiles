#
# User configuration sourced by interactive shells
#

# Make sure tmux starts in 256 colour mode
export TERM="screen-256color"

# If not running interactively, do not do anything
# otherwise, use tmux
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt appendhistory beep
bindkey -e
# End of lines configured by zsh-newuser-install

# Match for completion ignoring case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
setopt COMPLETE_ALIASES
autoload -Uz compinit && compinit

# Make up and down arrows perform a history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

alias ls='ls --color=auto'

eval "$(starship init zsh)"
