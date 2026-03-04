# ============================== ;
#              _                 ;
#      _______| |__  _ __ ___    ;
#     |_  / __| '_ \| '__/ __|   ;
#    _ / /\__ \ | | | | | (__    ;
#   (_)___|___/_| |_|_|  \___|   ;
#                                ;
# ============================== ;

# ╭─────────────────────────────────────────────╮
# │       Enable colors and change prompt       │
# ╰─────────────────────────────────────────────╯
# autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M \
# %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%} %b "

# ╭─────────────────────╮
# │       Exports       │
# ╰─────────────────────╯
export EDITOR=nvim
export MANPAGER='nvim +Man!'
export FZF_CTRL_T_OPTS="--preview 'eza --icons --color=always {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons --color=always {}'"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

# ╭─────────────────────────────────────╮
# │          History & Options          │
# ╰─────────────────────────────────────╯
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd

# ╭─────────────────────────────────────────────╮
# │              Auto/Tab complete              │
# ╰─────────────────────────────────────────────╯
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

# ╭──────────────────────────────────────────────╮
# │           Vi mode & Other Keybinds           │
# ╰──────────────────────────────────────────────╯
bindkey -v
bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
# bindkey -e
export KEYTIMEOUT=1

# Edit line in vim with ctrl-v:
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# ╭──────────────────────────────────────────────╮
# │  Source Zsh Plugins, Prompt & other configs  │
# ╰──────────────────────────────────────────────╯
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"
[ -f "$HOME/.config/zsh/functionrc" ] && source "$HOME/.config/zsh/functionrc"
[ -f "$HOME/.config/zsh/plugmgrrc" ] && source "$HOME/.config/zsh/plugmgrrc"

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/negligible.omp.json)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

add_plugin zsh-users/zsh-syntax-highlighting
add_plugin zsh-users/zsh-autosuggestions
add_plugin zsh-users/zsh-completions
add_plugin Aloxaf/fzf-tab
