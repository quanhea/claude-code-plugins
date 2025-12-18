---
name: domain
description: Build domain knowledge documentation with mandatory citations. Use when developer needs to understand business concepts, industry terms, third-party integrations, or regulatory requirements. All claims require citations
allowed-tools: Read, Grep, Glob, WebSearch, WebFetch, Write, Edit
---

# Domain Knowledge Skill

A developer cannot code what they don't understand. Build comprehensive domain knowledge documentation with **mandatory citations** for every claim.

## Core Principle

**Assume the developer knows NOTHING about the industry.**

Explain concepts from first principles. Don't assume familiarity with:
- Industry terminology
- Business processes
- Regulatory requirements
- Third-party service behaviors
- Domain-specific patterns

---

## Phase 1: Check Existing Knowledge

### Step 1: Search `domain_knowledge/`

First, check if documentation already exists:

```
Glob: domain_knowledge/**/*.md
Grep: [topic keywords] in domain_knowledge/
```

If found:
- Read existing documentation
- Identify gaps or outdated information
- Update rather than duplicate

### Step 2: Identify Knowledge Type

Categorize the topic:

| Type | Description | Example |
|------|-------------|---------|
| **Concept** | Industry term or business concept | "What is ACH processing?" |
| **Process** | Business workflow or procedure | "How does loan underwriting work?" |
| **Integration** | 3rd party API or service | "How does Stripe Connect work?" |
| **Regulation** | Compliance or legal requirement | "What is PCI-DSS compliance?" |
| **Entity** | Business object or data model | "What is a beneficiary in wire transfers?" |

---

## Phase 2: Research (Citation Required)

### Step 1: Primary Sources

**MANDATORY: Use WebSearch and WebFetch extensively.**

For each topic, search for:
1. **Official documentation** - Primary source (most authoritative)
2. **API references** - For integrations
3. **Regulatory documents** - For compliance topics
4. **Industry standards** - ISO, RFC, etc.

### Step 2: Citation Format

**Every factual claim MUST have a citation.**

```markdown
ACH transfers typically take 1-3 business days to complete.[^1]

[^1]: [Nacha - ACH Network](https://www.nacha.org/ach-network)
```

### Citation Rules

1. **No citation = Don't include the claim**
2. Prefer official/primary sources over blogs
3. Include access date for time-sensitive information
4. Link to specific pages, not just homepages
5. If information conflicts between sources, note the discrepancy

### Step 3: Source Priority

1. **Official documentation** (API docs, company docs)
2. **Regulatory/standards bodies** (Nacha, PCI SSC, ISO)
3. **Reputable technical sources** (MDN, official tutorials)
4. **Industry publications** (with author and date)
5. **Avoid**: Random blogs, Stack Overflow answers, undated content

---

## Phase 3: Document Structure

### File Location

```
domain_knowledge/
├── concepts/
│   └── [topic-slug].md
├── processes/
│   └── [topic-slug].md
├── integrations/
│   └── [service-name]/
│       ├── overview.md
│       ├── authentication.md
│       └── webhooks.md
├── regulations/
│   └── [regulation-name].md
└── entities/
    └── [entity-name].md
```

### Document Template

```markdown
# [Topic Title]

**Last Updated:** [YYYY-MM-DD]
**Author:** Claude Code Domain Agent

## Overview

[2-3 sentence summary with citations]

## Key Concepts

### [Concept 1]
[Explanation with citation][^1]

### [Concept 2]
[Explanation with citation][^2]

## How It Works

[Step-by-step explanation with citations]

1. [Step 1][^3]
2. [Step 2][^4]

## Relevance to This Project

[How this domain knowledge applies to the codebase]

- `path/to/relevant/code.py` - [Why it matters]

## Common Pitfalls

- [Pitfall 1][^5]
- [Pitfall 2][^6]

## Related Topics

- [[related-topic-1]]
- [[related-topic-2]]

## References

[^1]: [Source Title](URL) - Accessed [Date]
[^2]: [Source Title](URL) - Accessed [Date]
...
```

---

## Phase 4: Integration Documentation (For 3rd Parties)

When documenting a third-party integration, include:

### Authentication
- Auth method (OAuth, API key, etc.)
- Token refresh procedures
- Scopes/permissions needed

### API Behavior
- Rate limits (with citation)
- Pagination patterns
- Error codes and meanings
- Webhook event types

### Testing
- Sandbox/test environment details
- Test credentials handling
- Mock data patterns

---

## Quality Checklist

Before completing:
- [ ] Every factual claim has a citation
- [ ] All citations link to accessible sources
- [ ] File is in correct `domain_knowledge/` subdirectory
- [ ] Document follows the template structure
- [ ] Related code files are linked
- [ ] Related topics are cross-referenced

---

*This skill covers more than listed. Apply these principles broadly.*
