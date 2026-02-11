#!/usr/bin/env bash

set -e # exit on error

echo "======================================"
echo " Git Setup & SSH Configuration Script "
echo "======================================"
echo

# 1. Install Git
read -p "Do you want to install Git? (y/n): " install_git
if [[ "$install_git" == "y" || "$install_git" == "Y" ]]; then
  sudo apt update
  sudo apt install -y git
else
  echo "Skipping Git installation."
fi

echo

# 2. Git user configuration
read -p "Enter your Git username: " GIT_NAME
read -p "Enter your Git email: " GIT_EMAIL

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

echo
echo "Git configured as:"
git config --global --list
echo

# 3. SSH key setup
read -p "Do you want to generate a new SSH key for GitHub? (y/n): " gen_ssh
if [[ "$gen_ssh" == "y" || "$gen_ssh" == "Y" ]]; then

  SSH_KEY="$HOME/.ssh/id_ed25519"

  if [[ -f "$SSH_KEY" ]]; then
    echo "⚠️ SSH key already exists at $SSH_KEY"
    read -p "Overwrite existing key? (y/n): " overwrite
    if [[ "$overwrite" != "y" && "$overwrite" != "Y" ]]; then
      echo "Keeping existing SSH key."
    else
      ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$SSH_KEY"
    fi
  else
    ssh-keygen -t ed25519 -C "$GIT_EMAIL"
  fi

  echo
  echo "Starting ssh-agent..."
  eval "$(ssh-agent -s)"

  ssh-add "$SSH_KEY"

  echo
  echo "======================================"
  echo " Your GitHub SSH Public Key "
  echo "======================================"
  cat "$SSH_KEY.pub"
  echo
  echo "👉 Copy the above key and add it to:"
  echo "   https://github.com/settings/keys"
else
  echo "Skipping SSH key setup."
fi

echo
echo "✅ Git setup complete!"
