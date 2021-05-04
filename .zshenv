#
# User configuration sourced by all shells (including non-interactive)
#

export PAGER="less -S"                # -S => Don't linewrap
export EDITOR="vim"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

alias emacs="emacs -nw --no-desktop"  # Command line emacs
alias proxy_tunnel="ssh -C2qTnN -D"   # Tunneling proxy
alias watch="watch "                  # Make watch work with aliases

# Tell racer where to find the rust source
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
CARGO_PATH=~/.cargo/bin               # Binaries installed by cargo live here

# Ensure we can find binaries installed with go get
GO_BINARY_PATH=~/.go/bin

export PATH=$PATH:$CARGO_PATH:$GO_BINARY_PATH

# Include stuff specific to this machine
[ -f .localrc ] && source .localrc
