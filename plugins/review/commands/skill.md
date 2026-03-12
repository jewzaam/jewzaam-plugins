---
description: Review Claude Code skill files (SKILL.md) and plugin command files for quality, clarity, and effectiveness as LLM instructions. Trigger phrases include "review this skill", "review the skill", "audit skill quality", "check skill effectiveness".
allowed-tools: Agent, Read, Glob, Grep, Write
argument-hint: "[path-to-skill-or-directory]"
---

## Name
review:skill

## Synopsis
```
/review:skill [path]
```

# Skill Review

## Purpose

Evaluate SKILL.md and command `.md` files for effectiveness as LLM-consumed instructions. Skills are not documentation for humans — they are structured prompts that guide an LLM through a task. Review them on that basis.

## Constraints

- **Read-only analysis.** Never modify the skill files being reviewed.
- **No execution.** Do not invoke or test skills. Analysis is static.
- **Output a review file.** Write findings to `Review-skill.md` at the project root (or the root of the path provided). Overwrite if it exists.

## Process

### 1. Locate Skills

- If an argument points to a single SKILL.md or command `.md`, review that file.
- If an argument points to a directory, find all SKILL.md and command `.md` files within it recursively.
- If no argument, find all SKILL.md and command `.md` files from the current working directory recursively.

### 2. Analyze Each Skill

For each file, evaluate against the dimensions below. Read the full file before assessing.

#### Frontmatter Correctness

- `name` / `## Name` — Present, concise, follows naming conventions (lowercase, colon-delimited namespaces for commands).
- `description` — Present, accurately describes when the skill triggers. Contains trigger phrases or conditions.
- `allowed-tools` — Present if applicable, lists only tools the skill actually uses. No missing tools, no unnecessary tools.
- `argument-hint` — Present if the skill accepts arguments. Absent if it does not.
- No unknown or misspelled frontmatter keys.

#### Instruction Clarity

- **Unambiguous directives** — Each step tells the LLM exactly what to do. No vague phrases like "consider the context" or "use good judgment" without specifying what that means.
- **Decision logic is explicit** — Conditionals have clear predicates. "If X, do Y. Otherwise, do Z." not "Handle X appropriately."
- **No implicit knowledge assumed** — The skill does not rely on the LLM "knowing" domain conventions unless it states them. If a convention matters, the skill defines it.
- **Ordering is intentional** — Steps are sequenced so that information needed later is gathered first.

#### Redundancy and Repetition

- **No repeated instructions** — The same directive should not appear in multiple sections. If a rule appears in both "Process" and "Critical Rules", one instance should be removed or the sections should cross-reference.
- **No redundant constraints** — Constraints that are logical consequences of other constraints should be eliminated. Example: "Never run pip" is redundant if "Never install dependencies" is already stated.
- **Consolidate related rules** — Rules scattered across sections that address the same concern should be grouped.
- **DRY principle** — If the same pattern or template appears more than once, it should be defined once and referenced.

#### Completeness

- **Happy path covered** — The skill describes the normal execution flow end-to-end.
- **Error paths covered** — The skill states what to do when expected failures occur (file not found, tool fails, ambiguous input).
- **Edge cases addressed** — Boundary conditions relevant to the task are handled (empty input, no results, conflicting arguments).
- **Output specification** — The skill defines what its output looks like (file format, location, structure) or what it presents to the user.

#### Prompt Engineering Quality

- **Specificity over generality** — Concrete examples and templates are preferred over abstract descriptions.
- **Negative examples when useful** — "Do NOT do X" is included where a common LLM failure mode exists for the task.
- **Critical rules are prominent** — The most important constraints are visually distinct (bold, separate section, repeated emphasis) and placed where the LLM will attend to them.
- **Section hierarchy aids attention** — Headings break the skill into scannable chunks. No wall-of-text paragraphs.
- **Templates and examples reduce ambiguity** — Where output format matters, a template or example is provided rather than a prose description alone.

#### Scope Discipline

- **Single responsibility** — The skill does one thing well. It does not try to handle multiple unrelated tasks.
- **No feature creep** — The skill does not include optional behaviors, configurable modes, or "nice to have" features that dilute the core instruction.
- **Clear boundaries** — The skill states what it does NOT do when the boundary is non-obvious.

### 3. Cross-Skill Analysis (multi-skill reviews only)

When reviewing multiple skills, also assess:

- **Consistency** — Do skills in the same namespace follow the same structural patterns? Same heading conventions? Same constraint style?
- **Overlap** — Do any two skills partially duplicate each other's scope? If so, is the boundary clear?
- **Naming** — Are skill names consistent with their actual behavior? Do namespaced skills (e.g., `review:code`, `review:skill`) share a coherent namespace meaning?

### 4. Write Review Document

Write findings to `Review-skill.md` with this structure:

```markdown
# Skill Review

## TL;DR
<3-5 sentence summary of overall skill quality and key issues>

## Skills Reviewed

| Skill | File | Verdict |
|-------|------|---------|
| name  | path | Good / Needs Work / Poor |

## Findings

### Critical
<Issues that will cause the LLM to misinterpret or fail the task>

### Important
<Issues that degrade skill effectiveness or produce inconsistent results>

### Suggestions
<Improvements that would make the skill clearer or more maintainable>

### Strengths
<What the skill(s) do well>

## Per-Skill Details

### <skill-name>

#### Frontmatter
<findings>

#### Clarity
<findings>

#### Redundancy
<findings>

#### Completeness
<findings>

#### Prompt Engineering
<findings>

#### Scope
<findings>
```

All findings must reference specific lines or sections of the file. No vague complaints.

### 5. Present Summary

After writing the review document, present the TL;DR and critical/important findings to the user. Reference the review document for full details.

## Critical Rules

- **NEVER modify skill files** — this is a review, not a fix
- **All findings need specific references** — quote the problematic text or cite the section
- **Severity must be justified** — explain the impact on LLM behavior, not just stylistic preference
- **Evaluate as LLM instructions, not human documentation** — readability for humans is irrelevant; clarity for the model is what matters

## Next Steps: Dynamic Evaluation

Static analysis identifies structural and prompt engineering issues in the skill text.
For dynamic evaluation — running the skill against test prompts, grading outputs, and
A/B comparison — use the Anthropic `skill-creator` plugin:

1. Install: `/plugin install skill-creator@claude-plugins-official`
2. Run: `/skill-creator` and choose "Run tests and evaluations for a skill"

The skill-creator provides automated test runners, grading agents, benchmark aggregation,
and an eval viewer for iterative skill improvement.
