---
description: Review code changes for issues
argument-hint: [pr URL] | [commit] | [branch] | (default: all changes from base)
skills: review, issue-scoring
---

Choose execution mode:

**Skill (interactive)** - Use when:
- Quick review of small changes
- Want to discuss findings interactively
- Reviewing specific files

**Agent (autonomous)** - Use when:
- Full PR review
- Comprehensive branch review
- Want complete report without interaction

Ask the user which mode to use, then either load the `review` and `issue-scoring` skills or spawn the `reviewer` agent.

## Scope Options

- `pr <URL>` - Review a GitHub PR
- `commit <sha>` - Review a specific commit
- `head` - Review HEAD commit only
- `branch [name]` - Compare branch to main
- (no args) - All changes from merge-base with main (commits + staged + unstaged)

$ARGUMENTS
