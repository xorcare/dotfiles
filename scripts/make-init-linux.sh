#!/usr/bin/env bash

[ -z "$DOTFILES_ROOT" ] && echo 'Please set a variable $DOTFILES_ROOT or use Makefile!' && exit 1

[ -x "$(command -v 'apt')" ] && $SHELL "$DOTFILES_ROOT/scripts/make-init-linux-apt.sh" && exit $?
[ -x "$(command -v 'yum')" ] && $SHELL "$DOTFILES_ROOT/scripts/make-init-linux-yum.sh" && exit $?

sudo locale-gen en_US.UTF-8
sudo locale-gen ru_RU.UTF-8

echo "Nothing to do!"
