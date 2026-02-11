{ config, pkgs, ... }:

{
  home.username = "hxt";
  home.homeDirectory = "/home/hxt";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
    };
  };
}
