#
# User configuration sourced by all shells (including non-interactive)
#

export PAGER="less -FRSX"  # Exit single page, allow colours, don't linewrap, leave output
export EDITOR="hx"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Tell racer where to find the rust source
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
CARGO_PATH=~/.cargo/bin               # Binaries installed by cargo live here

# Ensure we can find binaries installed with go get
GO_BINARY_PATH=~/.go/bin

export PATH=$PATH:$CARGO_PATH:$GO_BINARY_PATH

# Include stuff specific to this machine
[ -f .localrc ] && source .localrc
