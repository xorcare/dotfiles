#!/usr/bin/env bash

[[ -z "$DOTFILES_ROOT" ]] && echo 'Please set a variable $DOTFILES_ROOT or use Makefile!' && exit 1

source "$DOTFILES_ROOT/scripts/func-wait-for-user.sh"

echo "You want to start the installation of tools with apt. Are you sure?"
wait_for_user

sudo apt-get update

sudo apt install xclip -y
sudo apt install nano -y
sudo apt install htop -y

# Visual Studio Code on Linux
# https://code.visualstudio.com/docs/setup/linux
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code -y
sudo apt install shellcheck
# Lightweight and flexible command-line JSON processor.
# NOTE: it's need for working scripts from home/bin.
sudo apt install jq

sudo apt autoremove
