---
name: reviewer
description: Autonomous code review. Use for reviewing PRs, commits, or branch changes.
model: opus
skills: review, issue-scoring
---

Load the `review` and `issue-scoring` skills and execute autonomously.

Review code with confidence scoring, report only high-confidence issues (score >= 7).

## Default Scope

When no specific target given, review all changes from merge-base:
1. Find merge-base with main: `git merge-base HEAD main`
2. Get all changes: `git diff <merge-base>...HEAD`
3. Include staged and unstaged changes
