#!/usr/bin/env bash

[[ -z "$DOTFILES_ROOT" ]] && echo "Please set a variable \$DOTFILES_ROOT or use Makefile!" && exit 1

# shellcheck source=func-wait-for-user.sh
source "$DOTFILES_ROOT/scripts/func-wait-for-user.sh"

echo "You want to start the installation of tools with Homebrew. Are you sure?"
wait_for_user

# Downloads
curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install.sh' >"$DOTFILES_ROOT/installers/brew-install.sh"
curl -fsSL 'https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh' >"$DOTFILES_ROOT/installers/ohmyzsh-install.sh"
shasum --algorithm 256 installers/*
shasum --algorithm 256 --check "$DOTFILES_ROOT/installers-sha256.sum" || exit $?

$SHELL "$DOTFILES_ROOT/installers/ohmyzsh-install.sh" --skip-chsh

if [ ! -x "$(command -v 'brew')" ]; then
  # Install Homebrew https://brew.sh
  $SHELL "$DOTFILES_ROOT/installers/brew-install.sh"
else
  # Make sure we’re using the latest Homebrew.
  brew update
  # Upgrade any already-installed formulae.
  brew upgrade
fi

# Print Homebrew config for history.
brew config -d -v

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install command-line tools using Homebrew.

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
[ ! -x "$(command -v 'sha256sum')" ] && [ -f "${BREW_PREFIX}/bin/gsha256sum" ] && ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"
[ ! -x "$(command -v 'sha256sum')" ] && alias sha256sum='shasum --algorithm 256'

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install Bash 4.
brew install bash
brew install bash-completion2

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# The Heroku Command Line Interface (CLI) Download and install.
# https://devcenter.heroku.com/articles/heroku-cli
brew tap heroku/brew
brew install heroku

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff \
  sfnt2woff-zopfli \
  woff2
brew tap homebrew/cask-fonts
brew cask install \
  font-fira-code \
  font-fira-mono \
  font-fira-mono-for-powerline \
  font-fira-sans

# Install other useful binaries.
brew install git
brew install tig
brew install git-lfs
brew install htop
brew install wget
brew install tarsnap
brew install transmission
brew install shellcheck
# Lightweight and flexible command-line JSON processor.
# NOTE: it's need for working scripts from home/bin.
brew install jq

# This is required for the pprof tool to work.
# https://stackoverflow.com/questions/26216628/go-pprof-not-working-properly
brew install graphviz

brew cask install jetbrains-toolbox
brew cask install visual-studio-code
brew cask install vlc
brew cask install 1password
brew cask install skype
brew cask install firefox

# Just hold the ⌘-Key a bit longer to get a list of all active short cuts of
# the current application. It's as simple as that.
# https://mediaatelier.com/CheatSheet
brew cask install cheatsheet

# Flash OS images to SD cards & USB drives, safely and easily.
brew install balenaetcher

# Remove outdated versions from the cellar.
brew cleanup

echo "List installed packages with Homebrew"
echo

brew list -l
echo

echo "Presets of tools for the '$(uname -s)' family of operating systems installed!"
