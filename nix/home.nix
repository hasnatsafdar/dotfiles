{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nix/config";
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Directories symlinked into ~/.config/
  configs = {
    alacritty = "alacritty";
    aria2      = "aria2";
    btop       = "btop";
    cava       = "cava";
    dunst      = "dunst";
    fastfetch  = "fastfetch";
    kitty      = "kitty";
    nushell    = "nushell";
    nvim       = "nvim";
    ohmyposh   = "ohmyposh";
    picom      = "picom";
    tmux       = "tmux";
    xmobar     = "xmobar";
    xmonad     = "xmonad";
    yazi       = "yazi";
    zathura    = "zathura";
    zsh        = "zsh";
  };
in

{
  imports = [
    ./modules/pkgs.nix
  ];

  # =========================================================================
  # HOME
  # =========================================================================

  home.username      = "hxt";
  home.homeDirectory = "/home/hxt";
  home.stateVersion  = "25.11";

  # =========================================================================
  # DOTFILES (symlinked from ~/nix/config/)
  # =========================================================================

  xdg.configFile = builtins.mapAttrs
    (_name: subpath: {
      source    = mkSymlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  # =========================================================================
  # PROGRAMS
  # =========================================================================

  programs.git = {
    enable    = true;
    userName  = "hasnatsafdar";
    userEmail = "hasnat.professional@gmail.com";
  };
}
