#!/usr/bin/env bash

[[ -z "$DOTFILES_ROOT" ]] && echo 'Please set a variable $DOTFILES_ROOT or use Makefile!' && exit 1

source "$DOTFILES_ROOT/scripts/func-wait-for-user.sh"

echo "You want to start the installation of tools with yum. Are you sure?"
wait_for_user;

sudo yum check-update

sudo yum install xclip -y
sudo yum install nano -y
sudo yum install htop -y

# Visual Studio Code on Linux
# https://code.visualstudio.com/docs/setup/linux
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
yum check-update
sudo yum install code -y

sudo yum autoremove
