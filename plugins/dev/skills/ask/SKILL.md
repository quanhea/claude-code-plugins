---
name: ask
description: Read-only Q&A about the codebase. Use when user asks questions about code structure, implementation, or conventions. No files modified
allowed-tools: Read, Grep, Glob, WebSearch, WebFetch
---

# Ask Skill

Get answers about the codebase. **No files will be modified.**

---

## Process

### Step 1: Understand the Question

Categorize:
- **Location:** Where is X? How do I find Y?
- **Explanation:** How does X work? What does Y do?
- **Convention:** What pattern should I follow for X?
- **Comparison:** What's the difference between X and Y?
- **Debugging:** Why might X be happening?

### Step 2: Search

Use read-only tools:
- `Glob` - Find files by pattern
- `Grep` - Search for code patterns
- `Read` - Examine file contents
- `WebSearch` - External documentation
- `WebFetch` - Fetch specific docs

### Step 3: Answer

Provide:
- **Direct answer** first
- **Code references** with `file:line`
- **Relevant snippets** when helpful
- **Related context** if useful

---

## Response Format

```markdown
## Answer

[Direct, concise answer]

## Details

[Expanded explanation with file:line references]

## Code Reference

```python
# path/to/file.py:45
[relevant code snippet]
```

## Related
- `path/to/related.py` - [why relevant]
- [Link to external docs if applicable]
```

---

## Constraints

**This skill will NOT:**
- Edit any files
- Write new files
- Run bash commands that modify state
- Make commits

**If changes needed, suggest:**
- `/dev:tdd` - For test-driven changes
- `/dev:refactor` - For code cleanup
- `/dev:domain` - For documentation

---

*This skill covers more than listed. Apply these principles broadly.*
