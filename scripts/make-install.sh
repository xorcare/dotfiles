#!/usr/bin/env bash

[[ -z "$DOTFILES_ROOT" ]] && echo 'Please set a variable $DOTFILES_ROOT or use Makefile!' && exit 1

source "$DOTFILES_ROOT/scripts/func-wait-for-user.sh"

function install() {
	rsync --exclude '.git/' \
		--exclude '.DS_Store' \
		--exclude '.osx' \
		-avh --no-perms './home/' "$HOME";
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	install;
else
	echo "This may overwrite existing files in your home directory. Are you sure?"
	wait_for_user;
	install;
fi;
