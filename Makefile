.DEFAULT_GOAL:= install

OS_NAME=$(shell uname -s | tr [A-Z] [a-z])

export SHELL:=/bin/bash

# DOTFILES_ROOT only needed for auxiliary scripts located in the scripts directory.
export DOTFILES_ROOT?=$(PWD)

.PHONY: check diff-check diff install help install-software

diff: ## Shows the difference between files in the repository and files in the home directory.
	@diff --ignore-blank-lines \
	--recursive \
	--show-c-function \
	--exclude '.DS_Store' \
	'$(HOME)' '$(PWD)/home' \
	| grep -v 'Only in $(HOME):'

diff-check: diff ## Outputs a difference and exit with an error if there are differences.
	@find home -type f | while read filepath; do diff $${filepath} "$$HOME/$${filepath#"home"}" \
	|| exit 1 ; done

help: ## Print this help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install-software: ## Used for installation of tools to the environment.
	@'scripts/make-install-software-$(OS_NAME).sh'

install: diff ## Install environment with requiring confirmation.
	@'scripts/make-install.sh'

check: shfmt ## Static analysis files existing in repository.
	@if ! command -v 'shellcheck' &> /dev/null; then  \
  		echo "Please install shellcheck! See https://www.shellcheck.net"; exit 1;\
  	fi;
	@shellcheck --external-sources --source-path=home \
		home/.zsh_aliases \
		home/bin/* \
		home/.bashrc \
		home/.zshrc \
		home/.prompt \
		home/.bash_aliases \
		home/.exports \
		home/.bash_profile \
		home/.aliases
	@shellcheck --external-sources --source-path=scripts scripts/*.sh

shfmt:
	@if ! command -v 'shfmt' &> /dev/null; then  \
  		echo 'Please install shfmt! See https://github.com/mvdan/sh'; echo ''; \
  		echo 'go install mvdan.cc/sh/v3/cmd/shfmt@latest'; echo ''; \
  		exit 1; \
  	fi;
	@shfmt -l -w -d scripts/*.sh \
		home/.zsh_aliases \
		home/bin/* \
		home/.bashrc \
		home/.zshrc \
		home/.prompt \
		home/.bash_aliases \
		home/.exports \
		home/.bash_profile \
		home/.aliases
