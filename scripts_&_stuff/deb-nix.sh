#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y

sudo apt install -y \
  git neovim curl build-essential

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
sudo systemctl reboot

nix-shell -p nix-info --run "nix-info -m"

# Go to:
https://github.com/settings/personal-access-tokens
# Gen and copy token.f
# Then do (add your token here)
echo "access-tokens = github.com=github_pat_REDACTED" | sudo tee -a /etc/nix/nix.conf

# To use the flakes goodies.
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

sudo systemctl restart nix-daemon

# If you already have nix dotfiles then just git clone and run home-manager switch in that directory, else:

mkdir Nix-Home
cd Nix-Home/
nix run home-manager -- init --switch .
home-manager switch --flake .#haxnet
