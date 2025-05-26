# .zshenv is used to define environment variables

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"   # config file
export HISTFILE="$ZDOTDIR/.zhistory"    # history file
export HISTSIZE=10000                   # maximum events for internal history
export SAVEHIST=10000                   # maximum events in history file

# zsh-z
export _Z_DATA="$XDG_DATA_HOME/z"

# tldr
export TLDR_CACHE_DIR="$XDG_DATA_HOME"

# PATH
export PATH="$PATH:/opt/homebrew/opt/llvm/bin"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="/usr/local/cuda/bin:$PATH"

# LLVM
export LLVM_DIR="$HOME/workspace/llvm-myriscv"

