#!/usr/bin/env bash

[[ -z "$DOTFILES_ROOT" ]] && echo "Please set a variable \$DOTFILES_ROOT or use Makefile!" && exit 1

# shellcheck source=func-wait-for-user.sh
source "$DOTFILES_ROOT/scripts/func-wait-for-user.sh"

echo "List installed packages with Homebrew"
echo

brew list -l
echo

echo "You want to start the initial removing of tools with brew. Are you sure?"
wait_for_user

echo "If you want to restore all tools after uninstallation, use the following command:"
echo "brew install $(brew list | tr '\n' ' ')"

brew remove --ignore-dependencies --force "$(brew list)"

# Remove outdated versions from the cellar.
brew cleanup
echo

echo "Presets of tools for the '$(uname -s)' family of operating systems removed!"
