.DEFAULT_GOAL:= install

OS_NAME=$$(uname -s | tr [A-Z] [a-z])

export SHELL:=/bin/bash
# DOTFILES_ROOT only needed for auxiliary scripts located in the scripts directory.
export DOTFILES_ROOT?=$(PWD)

DATE=$$(date -u '+%Y-%m-%dT%H:%M:%S%z')
HOSTNAME=$$(uname -n)
WHOAMI=$(shell whoami)
LATEST_LOG_FILE_NAME=by $(WHOAMI) on $(HOSTNAME) exec make $@.log
LOGGER = tee "logs/$(DATE) $(LATEST_LOG_FILE_NAME)" | tee "logs/latest $(LATEST_LOG_FILE_NAME)"

.PHONY: deinitialize diff help initialize install check

logs:
	mkdir logs
installers:
	mkdir installers

deinitialize: logs ## Used for uninstallation of tools in the environment.
	@$(SHELL) "scripts/make-deinit-$(OS_NAME).sh" | $(LOGGER)

diff: logs ## Shows the difference between files in the repository and files in the home directory.
	@diff --ignore-blank-lines \
	--recursive \
	--show-c-function \
	--exclude '.DS_Store' \
	'$(HOME)' '$(PWD)/home' \
	| grep -v 'Only in $(HOME):' \
	| $(LOGGER)

diff-check: diff ## Outputs a difference and exit with an error if there are differences.
	@find home -type f | while read filepath; do diff $${filepath} "$$HOME/$${filepath#"home"}" \
	|| exit 1 ; done

help: ## Print this help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

initialize: logs installers ## Used for installation of tools to the environment.
	@$(SHELL) "scripts/make-init-$(OS_NAME).sh" | $(LOGGER)

install: logs ## Install environment with requiring confirmation.
	@make diff && $(SHELL) 'scripts/make-install.sh' | $(LOGGER)

check:
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
