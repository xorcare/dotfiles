#!/usr/bin/env bash

# exit when any command fails
set -e

echo 'For bash prompt to work correctly, you need to install the project https://starship.rs'
echo 'You can do this with the command:'
echo "    sh -c \"\$(curl -fsSL https://starship.rs/install.sh)"
echo 'or by visiting the site:'
echo '    https://starship.rs/#quick-install'

sudo locale-gen en_US.UTF-8
sudo locale-gen ru_RU.UTF-8

[ -z "$DOTFILES_ROOT" ] && echo "Please set a variable \$DOTFILES_ROOT or use Makefile!" && exit 1

[ -x "$(command -v 'apt')" ] && $SHELL "$DOTFILES_ROOT/scripts/make-install-software-linux-apt.sh" || exit $?
[ -x "$(command -v 'yum')" ] && $SHELL "$DOTFILES_ROOT/scripts/make-install-software-linux-yum.sh" || exit $?

echo "Nothing to do!"
exit 0
