{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nix/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Standard .config/directory
  configs = {
    alacritty = "alacritty";
    aria2 = "aria2";
    btop = "btop";
    cava = "cava";
    dunst = "dunst";
    fastfetch = "fastfetch";
    kitty = "kitty";
    nushell = "nushell";
    nvim = "nvim";
    ohmyposh = "ohmyposh";
    picom = "picom";
    tmux = "tmux";
    xmobar = "xmobar";
    xmonad = "xmonad";
    yazi = "yazi";
    zathura = "zathura";
    zsh="zsh";
  };
in

{
  home.username = "hxt";
  home.homeDirectory = "/home/hxt";
  programs.git.enable = true;
  home.stateVersion = "25.11";

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];
}
