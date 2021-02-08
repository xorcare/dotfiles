# Dotfiles

## Install preferences

**Only for macOS.** If you haven't installed Xcode or the command line tools yet, use
`xcode-select --install` to download and install them, or check the Apple developer site.

```bash
make install
```

In macOS Catalina, the default interactive shell is now zsh. To update your account to use bash
please run `chsh-s/bin/bash`. For more information, please visit
https://support.apple.com/kb/HT208050.

### Optional, install oh-my-zsh

Use the command from the official site [oh-my-zsh](https://ohmyz.sh/#install)

```bash
/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Installing software (SW)

### Install macOS dependencies

Homebrew must be installed to correctly install the software for macOS use the command from the
official site [Homebrew](https://brew.sh)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Installing SW

Installs software using scripts described in the **scripts** directory, for software installation on
macOS using the brew tool, for Linux standard package managers with the addition of third party
repositories.

```bash
make install-software
```

Running this command can lead to the execution of irreversible actions on your system, since fully
clean the system of installed software with the ability to reliably determine what exactly was
installed by the command and which intermediate files could not be created seems possible.

## Undo changes

An automated rollback of changes is not provided, you can try to manually analyze changes made to
the system or will be restored from a backup copy if you have one, and you can analyze the logs in
the logs directory.
