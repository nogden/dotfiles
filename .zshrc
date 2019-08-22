#
# User configuration sourced by interactive shells
#

# Define zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

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

autoload -Uz promptinit
  promptinit
  prompt gitster

export PAGER="less -R"                # Was used by yaourt, is it still needed?
export EDITOR="vim"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

alias emacs="emacs -nw --no-desktop"  # Command line emacs
alias proxy_tunnel="ssh -C2qTnN -D"   # Tunneling proxy
alias watch="watch "                  # Make watch work with aliases

# Tell racer where to find the rust source
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
CARGO_PATH=~/.cargo/bin               # Binaries installed by cargo live here

export PATH=$PATH:$CARGO_PATH
