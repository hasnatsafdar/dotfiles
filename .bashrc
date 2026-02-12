# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

export EDITOR=nvim
export MANPAGER='nvim +Man!'
export FZF_CTRL_T_OPTS="--preview 'ls --color=always {}'"
export FZF_ALT_C_OPTS="--preview 'ls --color=always {}'"

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
# export PAGER=most

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

PS1='\[\e[32m\]┌──(\[\e[94;1m\]\u\[\e[94m\]@\[\e[94m\]\h\[\e[0;32m\])-[\[\e[38;5;46;1m\]\w\[\e[0;32m\]] [\[\e[32m\]0\[\e[32m\]]\n\[\e[32m\]╰─\[\e[94;1m\]  \[\e[0m\]'

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

# aliases

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Core utils
alias vi='/bin/nvim'
alias cat='/bin/bat'

alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Safer delete
alias rm='/bin/mv -t ~/.local/share/Trash/files/'

# Auto ls on cd
cx() {
  cd "$@" || return
  eza -lh --icons=always --group-directories-first | head -n 50 | lolcat
}

# eza
alias ls='eza -lh --icons --group-directories-first'
alias la='eza -lah --icons --group-directories-first'
alias lt='eza -T --icons'

# QoL
alias xrc='nvim ~/.xmonad/xmonad.hs'
alias brc='nvim ~/.config/xmobar/xmobarrc'
alias df='df -h -x squashfs -x tmpfs -x devtmfs'
alias lsmount='mount | column -t'
alias extip='curl icanhazip.com'
alias speedtest='speedtest-cli --bytes'
alias f="fzf --preview='bat --color=always {}'"
alias vf="nvim \$(fzf --preview 'bat --color=always --style=numbers {}')"
alias i='sudo dnf install -y'
alias is='sudo dnf search'
alias ld='lazydocker'
alias lg='lazygit'
alias lemmein='ssh haxnethost@192.168.122.143'
alias s='BROWSER=w3m ddgr'

alias mpvyt="mpv --quiet \
  --msg-level=all=no \
  --ytdl-format='bestvideo[height<=720]+bestaudio/best[height<=720]' \
  --hwdec=auto --profile=fast"

# Fastfetch
alias ff='fastfetch -c examples/13'
alias ffn='fastfetch --logo nixos -c examples/10'
alias ffs='fastfetch -c ~/.config/fastfetch/fastfetch.jsonc'

# Yazi setup
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# fzf keybindings
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

eval "$(fzf --bash)"
eval "$(zoxide init --cmd cd bash)"

ff
