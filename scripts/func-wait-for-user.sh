#!/usr/bin/env bash

readonly DOTFILES_ROOT CI

[[ -z "$DOTFILES_ROOT" ]] && echo 'Please set a variable $DOTFILES_ROOT or use Makefile!' && exit 1

source "$DOTFILES_ROOT/scripts/func-getc.sh"

wait_for_user() {
  if ! [ -z "${CI}" ]; then return; fi
  local c
  echo
  echo "Press RETURN to continue or any other key to abort"
  getc c
  # we test for \r and \n because some stuff does \r instead
  if ! [[ "$c" == $'\r' || "$c" == $'\n' ]]; then
    exit 1
  fi
  echo
  echo 'JUST DO IT!'
  echo
}
