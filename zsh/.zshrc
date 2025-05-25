# common options
setopt HIST_SAVE_NO_DUPS
setopt globdots
# unsetopt CASE_GLOB

# alias
alias ls='ls --color=auto'
alias la='ls --color=auto -A'

# directory stack
setopt AUTO_PUSHD                                 # push current directory
setopt PUSHD_IGNORE_DUPS                          # do not store duplicates in the stack
setopt PUSHD_SILENT                               # do not print the directory stack after push or pop
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# zsh vi mode
bindkey -v
bindkey -v '^?' backward-delete-char              # backspace before cursor after leaving normal mode
export KEYTIMEOUT=1
# source $ZDOTDIR/cursor_mode                       # change cursor
zmodload zsh/complist                             # must be done bofore completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[' undo
bindkey -M menuselect 'f' vi-insert

# edit command in neovim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# I really need text object and surround in zsh? I can edit command in neovim...
# text object
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# surrounding
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"         # must be done bofore completion

# ls color config, vivid is installed by brew
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# zsh-completions plugin, installed by brew
fpath=($(brew --prefix)/share/zsh-completions $fpath)

# fzf
source <(fzf --zsh)
source $XDG_CONFIG_HOME/catppuccin/catppuccin-fzf-mocha.sh

# completion
setopt MENU_COMPLETE
autoload -U compinit; compinit
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zstyle ':completion:*' menu select
# Now, use fzf-tab, not select menu
# zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:descriptions' format '-- %d --'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format '%F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' squeeze-slashes true

# fzf-tab
source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# zsh-bd, must after compinit
source $ZDOTDIR/plugins/bd/bd.zsh

# z, installed by brew
source $(brew --prefix)/etc/profile.d/z.sh

# zsh-syntax-highlighing plugin, installed by brew
source $XDG_CONFIG_HOME/catppuccin/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions, installed by brew
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^Y' autosuggest-accept

# prompt
eval "$(starship init zsh)"

# yadm completion takes long time
# __git_files () {
#   _wanted files expl 'local files' _files 
# }
