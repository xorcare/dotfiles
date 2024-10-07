#!/usr/bin/env bash

set -e # Enable exit on error.

[[ -z "$DOTFILES_ROOT" ]] && echo "Please set a variable \$DOTFILES_ROOT or use Makefile!" && exit 1

# shellcheck source=func-wait-for-user.sh
source "$DOTFILES_ROOT/scripts/func-wait-for-user.sh"

function install() {
    rsync --exclude '.git/' \
        --exclude '.DS_Store' \
        --exclude '.osx' \
        -avh --no-perms './home/' "$HOME"

    [ -d "$HOME/.ssh" ] && chmod 700 "$HOME/.ssh"
    [ -d "$HOME/.ssh/config.d" ] && chmod 700 "$HOME/.ssh/config.d"
    [ -f "$HOME/.ssh/config" ] && chmod 400 "$HOME/.ssh/config"
    [ -f "$HOME/.ssh/*.pub" ] && chmod 644 "$HOME/.ssh/*.pub"
    [ -f "$HOME/.ssh/authorized_keys" ] && chmod 600 "$HOME/.ssh/authorized_keys"
    [ -f "$HOME/.ssh/known_hosts" ] && chmod 600 "$HOME/.ssh/known_hosts"

    exit 0
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
    install
else
    echo "This may overwrite existing files in your home directory. Are you sure?"
    wait_for_user
    install
fi
