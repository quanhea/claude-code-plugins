---
name: pattern-matcher
description: Find and extract coding patterns from the existing codebase. Use before writing new code to ensure style consistency. Auto-triggers when about to create new files or implement new features
allowed-tools: Read, Grep, Glob
---

# Pattern Matcher Skill

Find existing patterns in the codebase to ensure new code matches project conventions.

## When to Use

- Before writing new tests
- Before implementing new features
- Before adding new files
- When unsure about project conventions
- When `/tdd` command needs pattern retrieval

## Pattern Categories

### Test Patterns

Search for:
```
Glob: **/test*.py, **/*_test.py, **/tests/**/*.py
Glob: **/*.test.ts, **/*.spec.ts, **/tests/**/*.ts
Glob: **/test_*.dart, **/*_test.dart
```

Extract:
- Test file naming convention
- Test class/function naming
- Setup/teardown patterns
- Assertion styles
- Fixture/factory usage
- Mock/patch patterns

### Implementation Patterns

Search for similar components:
```
Grep: "class.*View" for Django views
Grep: "router\." for FastAPI routes
Grep: "app\.(get|post)" for Express routes
Grep: "const.*=.*\(\)" for React components
```

Extract:
- File structure
- Import organization
- Class/function structure
- Error handling
- Logging patterns
- Type annotations

### Configuration Patterns

Check for style guides:
```
Read: CLAUDE.md, CONTRIBUTING.md
Read: .eslintrc, .prettierrc, pyproject.toml
Read: setup.cfg, .flake8, .pylintrc
```

## Pattern Extraction Process

### Step 1: Find Similar Files

Based on what you're creating, find 2-3 similar examples:

| Creating | Search For |
|----------|------------|
| New model | Existing models in same app |
| New API endpoint | Similar endpoints (CRUD, auth) |
| New service | Existing services in same layer |
| New test | Tests for similar features |
| New component | Components with similar purpose |

### Step 2: Read and Analyze

For each similar file, extract:

```markdown
## Pattern: [Feature Type]

### Naming
- File: `snake_case.py` / `PascalCase.tsx`
- Class: `PascalCase`
- Function: `snake_case` / `camelCase`
- Test: `test_[function]_[scenario]`

### Structure
- Imports order: stdlib, third-party, local
- Class organization: attrs, __init__, public, private
- Function length: typically < 20 lines

### Conventions
- Error handling: [pattern observed]
- Logging: [pattern observed]
- Comments: [minimal / docstrings / none]
```

### Step 3: Create Pattern Summary

Output a concise pattern summary:

```markdown
## Pattern Summary for: [Feature Type]

### Must Match
- [ ] File naming: `test_[module].py`
- [ ] Test naming: `test_[function]_[scenario]`
- [ ] Use pytest fixtures from conftest.py
- [ ] Use factory_boy for model instances
- [ ] Assert with `assert` not `self.assertEqual`

### Examples Found
1. `tests/test_users.py:15` - User CRUD tests
2. `tests/test_orders.py:23` - Similar validation tests

### Code to Copy
```python
# From tests/test_users.py:15
@pytest.mark.django_db
class TestUserCreate:
    def test_create_user_success(self, api_client, user_factory):
        # Arrange
        data = {"email": "test@example.com"}

        # Act
        response = api_client.post("/api/users/", data)

        # Assert
        assert response.status_code == 201
```
```

## Example Searches

### For Django Test
```
Glob: **/tests/test_*.py
Grep: "@pytest.mark.django_db"
Grep: "def test_"
Read: conftest.py (for fixtures)
```

### For React Component
```
Glob: src/components/**/*.tsx
Grep: "export (default )?function"
Grep: "useState|useEffect"
Read: Similar component by feature
```

### For Express Route
```
Glob: src/routes/**/*.ts
Grep: "router\.(get|post|put|delete)"
Read: Similar resource routes
```

## Output Format

After pattern matching, provide:

```markdown
## Patterns for: [What You're Creating]

### Conventions to Follow
1. [Convention with file:line example]
2. [Convention with file:line example]

### Template
[Skeleton code matching the patterns]

### Anti-Patterns
[What NOT to do based on project style]
```

---

*This skill covers more than listed. Apply these principles broadly.*
