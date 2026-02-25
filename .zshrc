# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%} %b "

export EDITOR=nvim
export MANPAGER='nvim +Man!'
export FZF_CTRL_T_OPTS="--preview 'eza --icons --color=always {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons --color=always {}'"
export PATH="$HOME/.local/bin:$PATH"

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
# bindkey -v
# bindkey '^f' autosuggest-accept
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
export KEYTIMEOUT=1

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^x' edit-command-line

# # Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

y-widget() {
  y
}

zle -N y-widget
bindkey '\eo' y-widget

# Fuzzy find stuff and open in vim
fzf-preview-widget() {
  find . -type f | fzf \
    --preview 'bat --style=numbers --color=always --line-range :500 {}' \
    --bind "enter:become($EDITOR {})"
}
zle -N fzf-preview-widget
bindkey '\ef' fzf-preview-widget

# Auto ls on cd
cx() {
  cd "$@" || return
  eza -lh --icons=always --group-directories-first | head -n 50
}

### ARCHIVE EXTRACTION
# usage: ex <file>
function ex {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "ex: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# aliases

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Core utils
alias vi='nvim'
alias cat='bat'

alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Safer delete
# alias rm='mv -t ~/.local/share/Trash/files/'

# eza
alias ls='eza -lh --icons --group-directories-first'
alias la='eza -lah --icons --group-directories-first'
alias lt='eza -T --icons'

# tltt (too long to type)
alias brc='nvim ~/.config/xmobar/xmobarrc'
alias cfg='nvim ~/nix/configuration.nix'
alias drc='nvim ~/projects/dwm/config.h'
alias df='df -h -x squashfs -x tmpfs -x devtmfs'
alias extip='curl icanhazip.com'
alias f="fzf --preview='bat --color=always {}'"
alias gp='gopass'
alias i='sudo dnf install -y'
alias is='sudo dnf search'
alias lsmount='mount | column -t'
alias ld='lazydocker'
alias lg='lazygit'
alias lemmein='ssh haxnethost@192.168.122.143'
alias mdwm='cd ~/projects/dwm; sudo make clean install; cd -';
alias nrs='sudo nixos-rebuild switch --flake ~/nix#nixos'
alias speedtest='speedtest-cli --bytes'
alias s='BROWSER=w3m ddgr'
alias t='tmux new -s'
alias update='sudo dnf update -y'
alias vf="nvim \$(fzf --preview 'bat --color=always --style=numbers {}')"
alias xrc='nvim ~/.config/xmonad/xmonad.hs'

alias mpvyt="mpv --quiet \
  --msg-level=all=no \
  --ytdl-format='bestvideo[height<=720]+bestaudio/best[height<=720]' \
  --hwdec=auto --profile=fast"

# Fastfetch
alias ff='fastfetch -c examples/13'
alias ffn='fastfetch -c ~/.config/fastfetch/25.jsonc'
alias ffs='fastfetch -c ~/.config/fastfetch/fastfetch.jsonc'

# fzf keybindings
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# ff --logo arch
nitch

# Load aliases and shortcuts if existent.
# [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
# [ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load zsh-syntax-highlighting; should be last.
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source ~/.config/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh 2>/dev/null
source ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh 2>/dev/null
