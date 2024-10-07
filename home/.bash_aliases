# shellcheck shell=bash

if [ -f "${HOME}/.aliases" ]; then
    # shellcheck source=.aliases
    . ~/.aliases
fi

# Reload bash profile
alias sss="source ~/.bashrc"
