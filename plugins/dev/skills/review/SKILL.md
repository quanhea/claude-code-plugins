---
name: review
description: Code review practices. Use for reviewing code quality and finding issues
---

# Code Review

## Philosophy

- Simplify everything
- Prefer deletion over explanation
- One issue = one sentence
- Be kind, be specific

## Review Focus

1. **Correctness**: Does it work? Edge cases?
2. **Security**: Input validation? Auth checks?
3. **Performance**: N+1? Missing indexes?
4. **Maintainability**: Readable? Testable?

## What to Look For

- Logic errors and bugs
- Security vulnerabilities
- Missing error handling
- Code duplication
- Overly complex code
- Missing tests for critical paths

## What NOT to Nitpick

- Style preferences (use linters)
- Minor naming disagreements
- Alternative approaches that aren't better
- Hypothetical future requirements

## Giving Feedback

- Be specific: point to exact lines
- Explain why, not just what
- Suggest solutions
- Distinguish blocking vs nice-to-have
- Acknowledge good code too

## Review Checklist

- [ ] Understand the context/PR description
- [ ] Check the tests
- [ ] Read the code, not just diff
- [ ] Test locally if complex
- [ ] Check for security issues
- [ ] Verify error handling

## Anti-patterns

- Rubber-stamping without reading
- Blocking on style preferences
- Being harsh or dismissive
- Reviewing huge PRs as one

---

*This skill covers more than listed. Apply these principles broadly.*
