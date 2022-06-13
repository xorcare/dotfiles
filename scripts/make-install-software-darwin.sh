#!/usr/bin/env bash

[[ -z "$DOTFILES_ROOT" ]] && echo "Please set a variable \$DOTFILES_ROOT or use Makefile!" && exit 1

# shellcheck source=func-wait-for-user.sh
source "$DOTFILES_ROOT/scripts/func-wait-for-user.sh"

echo "You want to start the installation of software with Homebrew. Are you sure?"
wait_for_user

set -x

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

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff \
  sfnt2woff-zopfli \
  woff2
brew tap homebrew/cask-fonts
brew install --cask \
  font-fira-code \
  font-fira-mono \
  font-fira-sans

# Install other useful binaries.
brew install git
brew install tig
brew install git-lfs
brew install htop
brew install wget
brew install transmission
brew install shellcheck
brew install ffmpeg

# Lightweight and flexible command-line JSON processor.
# NOTE: it's need for working scripts from home/bin.
brew install jq

# This is required for the pprof tool to work.
# https://stackoverflow.com/questions/26216628/go-pprof-not-working-properly
brew install graphviz

brew install --cask jetbrains-toolbox
brew install --cask visual-studio-code
brew install --cask vlc
brew install --cask firefox

# Use ImageMagick® to create, edit, compose, or convert bitmap images. It
# can read and write images in a variety of formats (over 200) including
# PNG, JPEG, GIF, HEIC, TIFF, DPX, EXR, WebP, Postscript, PDF, and SVG.
# ImageMagick can resize, flip, mirror, rotate, distort, shear and
# transform images, adjust image colors, apply various special effects,
# or draw text, lines, polygons, ellipses and Bézier curves.
# https://imagemagick.org
brew install imagemagick

# The minimal, blazing-fast, and infinitely customizable prompt for any shell!
# https://starship.rs
brew install starship

# Just hold the ⌘-Key a bit longer to get a list of all active short cuts of
# the current application. It's as simple as that.
# https://mediaatelier.com/CheatSheet
brew install --cask cheatsheet

# KeePassXC - Cross-Platform Password Manager
# Never forget a password again.
# Securely store passwords using industry standard encryption, quickly
# auto-type them into desktop applications, and use our browser extension
# to log into websites.
# https://keepassxc.org
brew install --cask keepassxc

# Postgres C API library.
brew install libpq

# Install GPG Suite (without GPGMail) for comfort work with command line
# tools and signing commits.
brew install gpg-suite-no-mail

# Remove outdated versions from the cellar.
brew cleanup

echo "List installed packages with Homebrew"
echo

brew list --formula
echo

echo "Presets of tools for the '$(uname -s)' family of operating systems installed!"
