---
name: refactor
description: Refactor code following strict order - Delete, Simplify, Optimize. Use when cleaning up code. Never optimize before simplifying. Never simplify before deleting
---

# Refactor Skill

Systematic code improvement following a strict priority order.

## The Golden Rule

**The order matters. Always follow: Delete → Simplify → Optimize**

Never optimize before simplifying. Never simplify before deleting.
The best optimization is often just deletion.

## Target Identification

If no target specified, analyze recent changes:
1. `git diff` for unstaged changes
2. `git diff --cached` for staged changes
3. `git diff HEAD~5` for recent commits

---

## Phase 1: DELETION (Highest Priority)

**Goal: Remove everything that isn't actively used.**

### Checklist

#### Dead Code
- [ ] Unused imports
- [ ] Unused variables and constants
- [ ] Unused functions and methods
- [ ] Unused classes
- [ ] Unreachable code branches (after return/throw/break)
- [ ] Commented-out code blocks

#### Redundant Code
- [ ] Duplicate implementations (keep one, delete others)
- [ ] Wrapper functions that add no value
- [ ] Unused configuration options
- [ ] Dead feature flags
- [ ] Obsolete compatibility shims

#### Noise
- [ ] Docstrings that repeat the function signature
- [ ] Comments explaining obvious code
- [ ] TODO comments for completed items
- [ ] FIXME comments for fixed issues
- [ ] Excessive logging that's never read

### Deletion Verification

After each deletion:
```bash
# Run tests
[project test command]

# Check for broken imports/references
[lint command or grep for the deleted item]
```

### Output: Deletion Phase

```
## Deleted Items
- [file:line] [what was deleted] - [why it was unused]

## Tests: PASS/FAIL
```

---

## Phase 2: SIMPLIFICATION (After Deletion)

**Goal: Make remaining code easier to understand.**

### Checklist

#### Flatten Complexity
- [ ] Replace nested if/else with early returns
- [ ] Replace complex boolean expressions with named variables
- [ ] Inline single-use helper functions
- [ ] Remove unnecessary abstractions

#### Reduce Indirection
- [ ] Inline trivial getters/setters
- [ ] Remove single-use wrapper classes
- [ ] Flatten unnecessary inheritance
- [ ] Replace complex factories with direct construction

#### Leverage Builtins
- [ ] Replace custom utilities with language builtins
- [ ] Replace custom loops with map/filter/reduce
- [ ] Use framework helpers (e.g., `get_object_or_404`)
- [ ] Replace manual parsing with standard library

#### Consolidate
- [ ] Merge similar functions with parameters
- [ ] Use `@pytest.mark.parametrize` for similar tests
- [ ] Group related constants
- [ ] Combine related small files

### Simplification Patterns

**Before: Nested conditionals**
```python
def process(data):
    if data:
        if data.is_valid:
            if data.status == 'active':
                return do_work(data)
    return None
```

**After: Early returns**
```python
def process(data):
    if not data:
        return None
    if not data.is_valid:
        return None
    if data.status != 'active':
        return None
    return do_work(data)
```

### Output: Simplification Phase

```
## Simplifications Applied
- [file:line] [before pattern] → [after pattern]

## Tests: PASS/FAIL
```

---

## Phase 3: OPTIMIZATION (Only After Simplification)

**Goal: Improve performance of already-clean code.**

### Prerequisites

- [ ] All deletion complete
- [ ] All simplification complete
- [ ] Tests passing
- [ ] Profiling data shows this is a bottleneck

### Checklist

#### Database/IO
- [ ] Add `select_related`/`prefetch_related` for N+1 queries
- [ ] Add database indexes for slow queries
- [ ] Batch operations instead of loops
- [ ] Add caching for repeated expensive operations

#### Algorithms
- [ ] Replace O(n²) with O(n log n) where it matters
- [ ] Use appropriate data structures (set for lookups, etc.)
- [ ] Avoid repeated calculations (memoize)

#### Memory
- [ ] Use generators instead of lists for large data
- [ ] Stream large files instead of loading entirely
- [ ] Clear references to large objects when done

### Optimization Verification

**REQUIRED: Measure before and after**

```python
# Before optimization
# Query count: X, Time: Y ms

# After optimization
# Query count: A, Time: B ms
# Improvement: X-A queries, Y-B ms saved
```

### Output: Optimization Phase

```
## Optimizations Applied
- [file:line] [what was optimized]
  - Before: [metric]
  - After: [metric]
  - Improvement: [percentage/absolute]

## Tests: PASS/FAIL
```

---

## Final Checklist

Before completing:
- [ ] All tests pass
- [ ] No new warnings from linter
- [ ] Changes are logically atomic (one concern per change)
- [ ] Each phase was done in order

## Philosophy

> "Perfection is achieved not when there is nothing more to add, but when there is nothing left to take away." — Antoine de Saint-Exupéry

---

*This skill covers more than listed. Apply these principles broadly.*
