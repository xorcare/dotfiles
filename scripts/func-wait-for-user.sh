#!/usr/bin/env bash

readonly DOTFILES_ROOT CI

[[ -z "$DOTFILES_ROOT" ]] && echo "Please set a variable \$DOTFILES_ROOT or use Makefile!" && exit 1

# shellcheck source=func-getc.sh
source "$DOTFILES_ROOT/scripts/func-getc.sh"

wait_for_user() {
  if [ -n "${CI}" ]; then return; fi
  local c
  echo
  echo "Press RETURN to continue or any other key to abort"
  getc c
  # we test for \r and \n because some stuff does \r instead
  if ! [[ "$c" == $'\r' || "$c" == $'\n' ]]; then
    echo
    echo 'THE PROCESS WAS INTERRUPTED AT THE BEHEST OF THE USER!'
    echo
    exit 1
  fi
  echo
  echo 'JUST DO IT!'
  echo
}
