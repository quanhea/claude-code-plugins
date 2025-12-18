---
name: citation-validator
description: Validate citations in domain knowledge documents. Use after writing or editing files in domain_knowledge/ to ensure all claims have proper citations and all references are valid
allowed-tools: Read, Grep, WebFetch
---

# Citation Validator Skill

Validates that domain knowledge documentation has proper citations.

## When to Use

- After creating a new document in `domain_knowledge/`
- After editing existing domain documentation
- During review of domain knowledge files
- When `domain-knowledge-guard` hook flags missing citations

## Validation Rules

### Rule 1: All Claims Need Citations

Every factual statement must have a citation marker:
```markdown
# Valid
ACH transfers take 1-3 business days.[^1]

# Invalid - missing citation
ACH transfers take 1-3 business days.
```

### Rule 2: All Markers Need Definitions

Every `[^n]` must have a corresponding `[^n]:` in References:
```markdown
# Valid
Statement.[^1]

## References
[^1]: [Source](URL)

# Invalid - orphan marker
Statement.[^1]
## References
(no [^1] definition)
```

### Rule 3: All Definitions Need Markers

Every `[^n]:` definition must be used in the document:
```markdown
# Invalid - unused reference
## References
[^1]: [Source](URL)
[^2]: [Another Source](URL)  # Never used in text
```

### Rule 4: Links Must Be Accessible

Check that citation URLs are valid:
```markdown
# Validate
[^1]: [Stripe Docs](https://stripe.com/docs/api)
# Fetch URL to verify it's accessible
```

### Rule 5: Access Dates Required

Citations should include access date:
```markdown
# Good
[^1]: [Source](URL) - Accessed 2024-01-15

# Needs improvement
[^1]: [Source](URL)
```

## Validation Process

### Step 1: Extract Citations

Read the document and extract:
- All `[^n]` markers in text
- All `[^n]:` definitions in References

### Step 2: Cross-Reference

Check:
- Every marker has a definition
- Every definition has at least one marker
- No duplicate definitions

### Step 3: Validate URLs

For each citation URL:
- Check URL format is valid
- Optionally fetch to verify accessibility

### Step 4: Report Issues

Output validation results:

```markdown
## Citation Validation Report

### File: domain_knowledge/concepts/ach-processing.md

#### Issues Found
- Line 15: Claim without citation: "ACH is faster than wire transfers"
- Line 23: Orphan marker [^4] - no definition found
- Line 45: Unused reference [^7]
- [^2] URL returned 404: https://example.com/broken

#### Summary
- Total citations: 6
- Valid: 4
- Issues: 2
```

## Fix Suggestions

For common issues, provide fixes:

| Issue | Suggestion |
|-------|------------|
| Missing citation | Add `[^n]` and research source |
| Orphan marker | Add `[^n]:` definition or remove marker |
| Unused reference | Add usage or remove definition |
| Broken URL | Update URL or find alternative source |
| Missing access date | Add " - Accessed YYYY-MM-DD" |

## Example Validation

**Input document:**
```markdown
ACH is a batch processing system.[^1] It's faster than checks.

[^1]: [Nacha](https://nacha.org)
[^2]: [Federal Reserve](https://federalreserve.gov)
```

**Validation output:**
```
Issues:
1. Line 1: "It's faster than checks" - no citation
2. [^2] defined but never used
3. [^1] missing access date
```

---

*This skill covers more than listed. Apply these principles broadly.*
