---
description: Create/update project context for Claude Code (claude_code_context/)
argument-hint: init | update [area] | add [area] | status
skills: context
---

Choose execution mode:

**Skill (interactive)** - Use when:
- Quick status check
- Small targeted update
- Want to review before changes

**Agent (autonomous)** - Use when:
- Full project initialization
- Comprehensive context update
- Multi-area generation

Ask the user which mode to use, then either load the `context` skill or spawn the `context` agent.

$ARGUMENTS
