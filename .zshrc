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

# The following lines were added by compinstall
zstyle :compinstall filename '/home/nick/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Pager for yaourt search results
export PAGER="less -R"

# Use vim by default
export EDITOR="vim"

# Make sure txux starts in 256 colour mode
export TERM="xterm-256color"

# Initialise Ruby environment
eval "$(rbenv init -)"

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

# Use mycli instead of mysql
alias mysql="mycli --auto-vertical-output"

# Set a $GOPATH for the go package manager
export GOPATH=~/.go

# Tell racer where to find the rust source
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Binaries installed by cargo live here
CARGO_PATH=~/.cargo/bin

# Set up path variable
# go bin directory for stscreds, perl bin directory for ack
export PATH=$PATH:$CARGO_PATH:$GOPATH/bin:/usr/bin/vendor_perl:~/.local/bin:~/Development/adr-tools/src

eval "$(u --completion-script-zsh)"

alias kbo="kubectl --namespace=energy-back-office"
