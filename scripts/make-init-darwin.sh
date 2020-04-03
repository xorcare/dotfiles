#!/usr/bin/env bash

[[ -z "$DOTFILES_ROOT" ]] && echo 'Please set a variable $DOTFILES_ROOT or use Makefile!' && exit 1

source "$DOTFILES_ROOT/scripts/func-wait-for-user.sh"

echo "You want to start the installation of tools with Homebrew. Are you sure?"
wait_for_user;

if [ ! -x "$(command -v 'brew')" ]; then
	# Install Homebrew https://brew.sh
	file=$(mktemp)
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | tee "$file" | shasum --algorithm 256
	cat "$file" | shasum --algorithm 256 --check "$DOTFILES_ROOT/brew-install-sh-sha256.sum"
	/bin/bash -c "$(cat "$file")"
	unset file
else
	# Make sure we’re using the latest Homebrew.
	brew update
	# Upgrade any already-installed formulae.
	brew upgrade
fi;

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
brew cask install firefox

# Remove outdated versions from the cellar.
brew cleanup

echo "List installed packages with Homebrew"; echo

brew list -l; echo

echo "Presets of tools for the '$(uname -s)' family of operating systems installed!"
