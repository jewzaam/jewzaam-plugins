# jewzaam-plugins

Plugin marketplace for Claude Code.

## Plugins

| Plugin | Commands | Description |
|--------|----------|-------------|
| review | `/review:code`, `/review:skill` | Review and evaluate code, skills, and other artifacts |
| commit | `/commit` | Commit staged changes with concise messages and proper attribution |
| fix | `/fix` | Run make and fix issues, optionally in a submodule |
| summarize-transcript | `/summarize-transcript` | Create executive summary and detailed timeline from meeting transcripts |

## Installation

```bash
# Add the marketplace
/plugin marketplace add jewzaam/jewzaam-plugins

# Install plugins
/plugin install review@jewzaam-plugins
/plugin install commit@jewzaam-plugins
/plugin install fix@jewzaam-plugins
/plugin install summarize-transcript@jewzaam-plugins
```

## Structure

Each plugin lives in `plugins/<name>/` with:
- `.claude-plugin/plugin.json` — Plugin metadata
- `commands/` — Slash commands (`.md` files)
- `skills/` — Auto-triggered skills (`SKILL.md` files) (optional)
- `reference/` — Shared reference docs (optional)

## Validation

```bash
make validate
```
