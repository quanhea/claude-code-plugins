---
name: coverage
description: Analyze and manage test coverage. Use when targeting specific coverage goals or improving test coverage systematically
---

# Test Coverage

Systematically analyze and increase test coverage by finding gaps and writing tests through the public API only.

## Core Philosophy

**Test through the public API, never internals.**
- All coverage must come from testing public interfaces
- If code can't be reached via public API, it's dead code
- Delete dead code or mark with `# pragma: no cover` if defensive

**Bottom-up for complex units:**
- Map dependency tree (leaf → root)
- Cover leaf dependencies first (easiest to isolate)
- Work up - each level builds on covered lower levels

## Process

### 1. Check Project Guidelines

Find test guidelines in `CLAUDE.md`, `CONTRIBUTING.md`, or docs. If none, use similar existing tests as reference.

### 2. Identify Target

Parse the arguments to determine:
- **Target file/module**: Specific path or infer from context
- **Coverage goal**: Percentage if provided, otherwise meaningful improvement

### 3. Run Coverage Analysis

Find the project's coverage command in `Makefile`, `pyproject.toml`, `package.json`, or `README`. Run with detailed output showing missing lines/branches.

### 4. Analyze Coverage Report

Examine output for:
- **Statement coverage**: Lines not executed (Missing column)
- **Branch coverage**: Untested conditionals (partial branches)
- **Function coverage**: Functions never called

### 5. Prioritize Gaps

Focus on (in order):
1. **Critical business logic** - Core functionality without tests
2. **Error handling** - except/catch blocks, validation failures
3. **Edge cases** - Empty inputs, boundaries, null/None handling
4. **Conditional branches** - Untested if/else paths

Skip:
- Trivial getters/setters
- Framework boilerplate
- Code requiring excessive mocking

### 6. Strategic Coverage for Large Units

When targeting high coverage on units with many dependencies:

1. **Map dependencies** - List from leaf (no deps) to root (public unit)
2. **Cover bottom-up** - Start with leaves, work up the tree
3. **Branch-by-branch** - Note uncovered branches, create minimal input per branch
4. **Track incrementally** - Re-run coverage after each test, confirm targets hit
5. **Hard-to-reach code** - Mock/patch to force error conditions

### 7. Write Tests

Add tests following project patterns:
- Minimal test per uncovered path
- Use existing fixtures/factories
- Follow project naming conventions
- **Never import internals** - only public API

### 8. Verify Increase

Re-run coverage and compare before/after percentages.

### 9. Dead Code Check (When Coverage Plateaus)

If coverage won't increase further:

1. **Trace call sites** - For each uncovered line, find all paths that could reach it
2. **Build reachability table** - Document each line with evidence
3. **Resolve**:
   - Remove dead code (redundant checks)
   - Add `# pragma: no cover` (defensive safeguards)
   - Accept current % as real coverage

## Output Format

```
## Initial Coverage
- Statement: X%
- Branch: X%

## Coverage Gaps Found
[List of uncovered lines/branches with brief description]

## Tests Added
[New test cases with rationale]

## Final Coverage
- Statement: X% → Y%
- Branch: X% → Y%
- Target achieved: Yes/No
```
