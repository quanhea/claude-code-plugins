# Extreme Programming Claude Code Plugins

Domain-specific developer workflows with skills-based architecture.

## Installation

Add marketplace:

```sh
claude plugin marketplace add eastagile/claude-code-plugins
```

Install individual plugins:

```sh
claude plugin install dev@eastagile
```

## Available Plugins

### Dev (Core Workflows)

| Command | Description |
|---------|-------------|
| `/dev:tdd` | TDD workflow (Red/Green/Refactor) |
| `/dev:refactor` | Refactoring (Delete → Simplify → Optimize) |
| `/dev:review` | Code review for PRs, commits, or branches |
| `/dev:coverage` | Analyze and manage test coverage |
| `/dev:domain` | Domain knowledge documentation with citations |
| `/dev:debug` | Debug statement placement and cleanup |
| `/dev:describe` | Feature documentation with diagrams |
| `/dev:dive` | Deep dive into internals |
| `/dev:context` | Create/update project context for Claude Code |
| `/dev:ask` | Codebase Q&A (read-only) |

## Architecture

**Skills as Single Source of Truth**

```
Commands = thin loaders (user invokes via /plugin:command)
Agents   = thin loaders (autonomous execution)
Skills   = actual content (shared, lazy-loaded)
Hooks    = quality gates (high-level reminders only)
```

See `CLAUDE.md` for detailed architecture and writing guidelines.

## Contributing

Contributions welcome. Follow the writing guidelines in `CLAUDE.md`:
- Skills: high-level principles only
- Commands/Agents: thin loaders
- Hooks: Single high-level reminder
