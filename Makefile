# claude-skills Makefile
# Submodule management for Claude Code skills

.PHONY: init deinit help
.DEFAULT_GOAL := help

help:
	@echo "claude-skills submodule management"
	@echo ""
	@echo "Targets:"
	@echo "  init    - Initialize and update all submodules"
	@echo "  deinit  - Deinitialize submodules and clear cache (clean slate)"

init:
	git submodule update --init --recursive
	git submodule update --remote
	git submodule foreach 'git checkout main'

deinit:
	@echo "Deinitializing all submodules..."
	git submodule deinit -f --all
	@echo "Removing submodule cache..."
	rm -rf .git/modules/*
	@echo "Done. Run 'make init' to reinitialize."
