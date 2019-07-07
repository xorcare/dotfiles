#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
[ ! -x "$(command -v 'sha256sum')" ] && ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install Bash 4.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

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

brew cask install jetbrains-toolbox
brew cask install visual-studio-code
brew cask install vlc
brew cask install 1password
brew cask install skype

# Remove outdated versions from the cellar.
brew cleanup