{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # --- Terminals ---
    alacritty
    kitty

    # --- Browsers ---
    brave
    qutebrowser

    # --- Editors & Notes ---
    emacs
    obsidian
    mermaid-cli

    # --- Media ---
    ffmpeg
    yt-dlp
    mpv
    cava
    mpd
    mpc
    rmpc
    kdePackages.kdenlive
    obs-studio
    blender
    audacity
    gimp

    # --- File Management ---
    thunar
    yazi
    lf
    ncdu

    # --- WM / Desktop Utils ---
    xmobar
    polybar
    rofi
    dunst
    libnotify
    lxappearance
    picom
    xwallpaper
    nitrogen
    hyprpaper
    swww

    # --- CLI Utils ---
    tealdeer
    wikiman
    fastfetch
    btop
    bat
    oh-my-posh
    eza
    pywal16
    nitch
    fortune
    cowsay
    figlet
    lolcat

    # --- Web / Search ---
    ddgr
    w3m
    buku

    # --- Dev Workflow ---
    lazygit
    lazydocker
    lazynpm
    tmux
    fzf
    zoxide
    stow

    # --- GPG / Passwords ---
    pam_gnupg
    gpg-tui
    pinentry-curses
    pass
    passExtensions.pass-otp
    gopass

    # --- Email ---
    neomutt
    mutt-wizard
    isync
    msmtp

    # --- Downloads & Sync ---
    aria2
    varia
    rsync
    localsend

    # --- Documents & Images ---
    imagemagick
    zbar
    zathura
    ghostscript
    tectonic
    ueberzugpp
    flameshot
    maim

    # --- Time & Productivity ---
    clock-rs
    calcurse

    # --- Dev Languages & Tools ---
    nodejs_24
    python315
    hugo
    haskell-language-server
    luarocks
    lua-language-server
    tree-sitter

    # --- Input ---
    kanata

    # --- Nix Dev ---
    nil
    nixpkgs-fmt

    # --- Personal CLI Tools ---
    nushell
    vim
    wget
    unzip
    bc
    xclip
    ripgrep
    fd
    nix-output-monitor
  ];
}
