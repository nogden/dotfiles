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

# Pager for yaourt search results
export PAGER="less -R"

# Use vim by default
export EDITOR="vim"

# Make sure txux starts in 256 colour mode
export TERM="xterm-256color"

# Command line emacs
alias emacs="emacs -nw --no-desktop"

# Tunneling proxy
alias proxy_tunnel="ssh -C2qTnN -D"

# Make watch work with aliases
alias watch="watch "

# Tell racer where to find the rust source
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Binaries installed by cargo live here
CARGO_PATH=~/.cargo/bin

# Set up path variable
# go bin directory for stscreds, perl bin directory for ack
export PATH=$PATH:$CARGO_PATH
