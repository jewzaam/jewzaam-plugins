# claude-skills Makefile
# Plugin marketplace management

.PHONY: validate help
.DEFAULT_GOAL := help

help:
	@echo "claude-skills plugin marketplace"
	@echo ""
	@echo "Targets:"
	@echo "  validate  - Validate marketplace.json structure"

validate:
	claude /plugin validate .
