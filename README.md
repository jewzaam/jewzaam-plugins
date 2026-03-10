# claude-skills

Meta-repo managing Claude Code skills as git submodules.

## Skills

| Skill | Description |
|-------|-------------|
| [commit](https://github.com/jewzaam/claude-skill-commit) | Commit staged changes with concise messages and proper attribution |
| [fix](https://github.com/jewzaam/claude-skill-fix) | Run make and fix issues, optionally in a submodule |
| [review](https://github.com/jewzaam/claude-skill-review) | Review, assess, or audit a codebase or implementation |
| [summarize-transcript](https://github.com/jewzaam/claude-skill-summarize-transcript) | Summarize a Claude conversation transcript |

## Usage

```bash
make init     # Initialize and update all submodules
make deinit   # Deinitialize submodules and clear cache
make help     # Show available targets
```

## Structure

Each skill lives in its own upstream repo and is included here as a submodule. Claude Code discovers skills by scanning subdirectories for `SKILL.md` files.
