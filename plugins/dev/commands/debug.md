---
description: Add DEBUG: statements, breakpoints, and cleanup afterwards
argument-hint: Issue to debug, code area to trace, or "clean" to remove
skills: debug
---

Choose execution mode:

**Skill (interactive)** - Use when:
- Known issue location, quick debug
- Want to guide statement placement
- Iterative debugging session

**Agent (autonomous)** - Use when:
- Unknown root cause, needs tracing
- Multiple code paths to instrument
- Want comprehensive coverage

Ask the user which mode to use, then either load the `debug` skill or spawn the `debugger` agent.

$ARGUMENTS
