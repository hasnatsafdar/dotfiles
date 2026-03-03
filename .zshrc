autoload -U colors && colors
# Enable colors and change prompt:
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%} %b "

export EDITOR=nvim
export MANPAGER='nvim +Man!'
export FZF_CTRL_T_OPTS="--preview 'eza --icons --color=always {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons --color=always {}'"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Hist Options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd

# Basic auto/tab complete:
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons $realpath'
autoload -U compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# vi mode
bindkey -v
# bindkey -M viins 'jj' vi-cmd-mode
bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
# bindkey -e
export KEYTIMEOUT=1

# Edit line in vim with ctrl-x:
autoload edit-command-line; zle -N edit-command-line
bindkey '^x' edit-command-line

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Load aliases and shortcuts if existent.
# [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"
[ -f "$HOME/.config/zsh/functionrc" ] && source "$HOME/.config/zsh/functionrc"

# Load zsh-syntax-highlighting; should be last.
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source ~/.config/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh 2>/dev/null
source ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh 2>/dev/null
