---
name: issue-scoring
description: Confidence-based issue filtering. Use to prioritize review findings
---

# Issue Scoring

## Purpose

Eliminate false alarms by scoring issues on confidence. Only report high-confidence issues.

## Scoring Framework

| Score | Confidence | Action |
|-------|------------|--------|
| 9-10 | Critical bug, security vulnerability | MUST FIX |
| 7-8 | Logic error, likely performance issue | SHOULD FIX |
| 5-6 | Style, minor improvement | CONSIDER |
| 1-4 | Subjective, nitpick | SKIP |

**Only report issues with score >= 7**

## Score 9-10 Examples

- SQL injection vulnerability
- Authentication bypass
- Data loss scenarios
- Null pointer in critical path
- Resource leaks

## Score 7-8 Examples

- Missing error handling for likely failures
- N+1 query in hot path
- Race condition potential
- Missing validation on public API
- Incorrect business logic

## Score 5-6 Examples

- Could be slightly more readable
- Minor performance improvement
- Alternative approach exists
- Missing optional test case

## Score 1-4 Examples (SKIP)

- Naming preference
- Comment style
- Line length
- Import order
- Hypothetical edge case

## Applying Scores

Ask yourself:
1. How confident am I this is actually a problem?
2. What's the impact if I'm wrong?
3. Would I bet money on this being an issue?

If uncertain, lower the score. Report fewer, higher-quality findings.

---

*This skill covers more than listed. Apply these principles broadly.*
