---
name: tdd
description: TDD workflow with strict style consistency. Use for test-driven development following Red/Green/Refactor phases. Enforces pattern matching before writing any code
---

# TDD Workflow

Test-Driven Development with **strict style consistency** as the primary principle.

## Core Philosophy

**Style consistency is MORE important than personal preference.**
- Before writing ANY code, find existing patterns in the project
- Match naming, structure, and conventions EXACTLY
- When in doubt, copy existing patterns verbatim

## Phase Detection

Determine current phase based on context:
- **No tests exist** → Red Phase (write tests first)
- **Tests exist but fail** → Green Phase (implement code)
- **Tests pass** → Refactor Phase (simplify)

---

## MANDATORY: Pattern Retrieval (Before ANY Code)

**STOP. Before writing any code, you MUST complete these steps:**

### Step 1: Load Project Guidelines

Search for and read these files (in order):
1. `CLAUDE.md` - Primary project guidelines
2. `CONTRIBUTING.md` - Contribution standards
3. `.github/CONTRIBUTING.md` - GitHub contribution guide
4. `docs/DEVELOPMENT.md` or similar

If found, these guidelines are **LAW**. Follow them exactly.

### Step 2: Find Similar Patterns

Use the `pattern-matcher` skill to find 2-3 similar examples:

**For Tests:**
```
Search patterns:
- Test files in same directory/module
- Tests for similar features (CRUD, auth, API, etc.)
- Fixture/factory patterns used
- Assertion styles
```

**For Implementation:**
```
Search patterns:
- Similar models/views/services/components
- Same architectural layer (controller, service, repository)
- Similar business logic
```

### Step 3: Extract Style Rules

Document the patterns you found:
- File naming convention
- Class/function naming convention
- Import organization
- Test structure (setup, action, assertions)
- Error handling patterns
- Comment/docstring style (or lack thereof)

---

## Red Phase: Write Minimal Tests

**Principle: Write the LEAST code that fails for the RIGHT reason.**

### Process

1. **Identify the public interface** - What will external code call?
2. **Write ONE test** for the primary happy path
3. **Run tests** - Confirm they fail with the expected error
4. **Add edge cases ONLY if critical** (auth, validation, errors)

### Anti-Patterns to AVOID

- Writing tests for internal/private functions
- Testing implementation details
- Creating multiple similar tests upfront
- Over-testing before knowing the implementation
- Adding "just in case" tests

### Output: Red Phase

```
## Test Plan
- [ ] [Single sentence describing what's being tested]

## Test Code
[Minimal test file following project patterns]

## Run Command
[Project's test command]

## Expected Failure
[The error message that SHOULD appear]
```

---

## Green Phase: Minimal Implementation

**Principle: Write the LEAST code that makes tests pass.**

### Process

1. **Read the failing tests** - Understand exactly what's expected
2. **Implement the minimum** - No extra features, no "future-proofing"
3. **Run tests** - Confirm they pass
4. **Stop immediately** - Don't add anything not tested

### Anti-Patterns to AVOID

- Adding error handling for untested scenarios
- Creating abstractions "for later"
- Adding configuration options not required
- Writing code "while you're in there"

### Output: Green Phase

```
## Implementation
[Files created/modified with minimal code]

## Test Results
[All tests passing]
```

---

## Refactor Phase: Simplify Ruthlessly

**Principle: Delete > Simplify > Optimize (in that order)**

### Deletion Checklist

- [ ] Unused imports
- [ ] Unused variables/functions
- [ ] Dead code branches
- [ ] Redundant comments
- [ ] Duplicate logic

### Simplification Checklist

- [ ] Extract repeated code (only if 3+ occurrences)
- [ ] Inline single-use abstractions
- [ ] Replace complex conditionals with early returns
- [ ] Use language/framework builtins

### Verification

After EACH change:
1. Run tests - they must still pass
2. If tests fail, revert immediately

### Output: Refactor Phase

```
## Changes Made
[List of simplifications]

## Test Results
[All tests still passing]
```

---

*This skill covers more than listed. Apply these principles broadly.*
