# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

**eastagile/claude-code-plugins** is a Claude Code plugin system with domain-specific developer workflows. Each plugin provides commands, agents, skills, and hooks for different development contexts.

## Architecture

### Core Principle: Skills as Single Source of Truth

```
Commands = thin loaders (user invokes via /plugin:command)
Agents   = thin loaders (autonomous execution in separate context)
Skills   = actual content (shared, lazy-loaded)
Hooks    = quality gates (pre/post edit validation)
```

### Plugin Structure

```
plugin-name/
├── .claude-plugin/plugin.json    # Plugin manifest
├── commands/                      # Thin loaders → load skills
│   └── command-name.md
├── agents/                        # Thin loaders → load skills (autonomous)
│   └── agent-name.md
├── skills/                        # Actual content (shared)
│   └── skill-name/SKILL.md
├── hooks/hooks.json               # PreToolUse/PostToolUse handlers
└── scripts/                       # Hook handler scripts
```

### Command/Agent Format (Thin Loader)

```markdown
---
description: What this command does
argument-hint: Expected arguments
skills: skill1, skill2
---

Load the `skill1` skill.

$ARGUMENTS
```

### Skill Format (Actual Content)

```markdown
---
name: skill-name
description: When to use this skill (for auto-discovery)
allowed-tools: Read, Grep, Glob  # Optional tool restrictions
---

# Skill Title

[High-level principles, key patterns, anti-patterns]
```

## Writing Guidelines

**Never over-engineer. Keep everything high-level and concise.**

### Skills (~50-80 lines)
- High-level principles only
- Key patterns and gotchas
- Anti-patterns to avoid
- NO tutorial-style content
- NO exhaustive examples
- NO full code walkthroughs

### Commands/Agents (~10 lines)
- Thin loaders only
- Just load the skill and pass arguments
- NO duplicated content from skills

### Hooks
- Single high-level reminder only
- NO detailed validation logic
- NO blocking on style preferences
- Example: "Check existing patterns before editing"

### General Principles
- If it feels like a tutorial, it's too long
- If it has multiple full code examples, simplify
- Principles > Examples
- What to do > How to do it step-by-step

## Hook System

Hooks validate quality before/after edits:

- **PreToolUse**: Remind about conventions before editing
- **PostToolUse**: Validate changes after editing

Hook scripts receive JSON via stdin with `tool_input`, return JSON with `systemMessage`.

Exit codes:
- `0`: Allow (optionally with message)
- `2`: Block with error message

## Claude Code documentation

- https://code.claude.com/docs/en/sub-agents
- https://code.claude.com/docs/en/skills
- https://code.claude.com/docs/en/hooks
