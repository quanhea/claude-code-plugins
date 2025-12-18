---
name: debug
description: Add strategic DEBUG: statements to trace issues. Use when code produces unexpected results or when tracing execution flow. All debug statements use DEBUG: prefix for easy cleanup
---

# Debug Skill

Add strategic debug statements with `DEBUG:` prefix, then clean up when done.

## Usage Modes

- **Add debug statements**: Provide issue description
- **Cleanup**: Use argument `clean` to remove all DEBUG: statements

---

## Mode: Add Debug Statements

### Step 1: Detect Stack

| Stack | Debug Statement | Breakpoint |
|-------|-----------------|------------|
| Python | `print(f"DEBUG: {var=}")` | `breakpoint()` |
| JavaScript | `console.log('DEBUG:', var)` | `debugger;` |
| Flutter | `debugPrint('DEBUG: $var')` | IDE breakpoints |

### Step 2: Understand the Issue

1. What's the unexpected behavior?
2. What's the expected behavior?
3. What data needs inspection?

### Step 3: Strategic Placement

Add at these points:

**Entry points:**
```python
def process(order_id):
    print(f"DEBUG: process called with {order_id=}")
```

**Decision points:**
```python
if order.is_valid:
    print(f"DEBUG: valid, status={order.status}")
```

**Data transformations:**
```python
print(f"DEBUG: before transform: {data}")
result = transform(data)
print(f"DEBUG: after transform: {result}")
```

**API boundaries:**
```python
print(f"DEBUG: API request: {payload=}")
response = api.call(payload)
print(f"DEBUG: API response: {response.status_code}")
```

### Step 4: Format Rules

**ALWAYS:**
- Prefix with `DEBUG:`
- Include context (function/class name)
- Log actual values

**NEVER:**
- `print("DEBUG: here")` - useless
- Log sensitive data (passwords, tokens)

### Output

```markdown
## Debug Points Added

### Files Modified
- `file.py:45` - Entry point
- `file.py:52` - Decision point

### How to Trigger
[Steps to run and see output]

### Cleanup
Run `/dev:debug clean` when done.
```

---

## Mode: Cleanup

When argument is `clean`:

### Step 1: Find All DEBUG Statements

```bash
grep -rn "DEBUG:" --include="*.py" --include="*.ts" --include="*.dart" .
```

### Step 2: Remove Each Statement

- Lines with `print(f"DEBUG:` or `console.log('DEBUG:`
- `breakpoint()` calls
- `debugger;` statements

### Step 3: Verify

1. `grep -rn "DEBUG:"` returns 0 matches
2. Tests still pass

### Output

```markdown
## Cleanup Complete

### Removed
- `file.py:45` - DEBUG print
- `file.py:52` - breakpoint()

### Verification
- DEBUG grep: 0 matches
- Tests: PASS
```

---

*This skill covers more than listed. Apply these principles broadly.*
