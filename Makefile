OS_NAME=$$(uname -s | tr [A-Z] [a-z])

export SHELL:=/bin/bash
export DOTFILES_ROOT?=$(PWD)

DOTFILES_LOGS=$(DOTFILES_ROOT)/logs
DATE=$$(date -u '+%Y-%m-%dT%H:%M:%S%z')
LOGGER = tee "$(DOTFILES_LOGS)/$(DATE)-$@.log" | tee "$(DOTFILES_LOGS)/$@.log"

.PHONY: deinit diff help init install

all: init install

logs:
	mkdir logs

deinit: logs ## Used for uninstallation of tools in the environment.
	@$(SHELL) "scripts/make-deinit-$(OS_NAME).sh" | $(LOGGER)

diff: logs ## Shows the difference between files in the repository and files in the home directory.
	@diff -r "$(HOME)" '$(PWD)/home' \
	| grep '$(PWD)/home' \
	| awk '{print $4}' \
	| while read -r line; do echo $$line; $$line; echo; done \
	| $(LOGGER)

help: ## Print this help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: logs ## Used for installation of tools to the environment.
	@$(SHELL) "scripts/make-init-$(OS_NAME).sh" | $(LOGGER)

install: logs ## Install environment with requiring confirmation.
	@make diff && $(SHELL) 'scripts/make-install.sh' | $(LOGGER)
