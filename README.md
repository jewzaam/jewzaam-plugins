# jewzaam-plugins

Plugin marketplace for Claude Code.

## Plugins

| Plugin | Skills | Description |
|--------|--------|-------------|
| review | `/review:code`, `/review:skill` | Review and evaluate code, skills, and other artifacts |
| commit | `/commit:commit` | Commit staged changes with concise messages and proper attribution |
| fix | `/fix:fix` | Run make and fix issues, optionally in a submodule |
| summarize-transcript | `/summarize-transcript:summarize-transcript` | Create executive summary and detailed timeline from meeting transcripts |

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

## Upgrading

To pick up the latest changes, uninstall and reinstall:

```bash
/plugin uninstall <plugin>@jewzaam-plugins
/plugin install <plugin>@jewzaam-plugins
```

## Structure

Each plugin lives in `plugins/<name>/` with:
- `.claude-plugin/plugin.json` — Plugin metadata
- `skills/` — Skills (`<skill-name>/SKILL.md` files)
- `reference/` — Shared reference docs (optional)

## Validation

```bash
make validate
```
