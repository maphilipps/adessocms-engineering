---
name: workflows:compound
description: Document solved problems to compound engineering knowledge for future reference
argument-hint: "[problem category or empty for current context]"
---

# /workflows:compound - Knowledge Compounding Workflow

Capture solved problems, patterns, and learnings to build cumulative engineering knowledge.

## Purpose

Every solved problem is an opportunity to compound knowledge. This command:
1. Extracts the essence of what was learned
2. Documents it in a searchable format
3. Makes it available for future reference
4. Prevents re-solving the same problems

## Workflow

### Phase 1: Identify the Learning

What was just solved?
- Bug fix with non-obvious solution
- Pattern that works well in this codebase
- Configuration that took time to figure out
- Integration approach that succeeded
- Performance optimization technique

### Phase 2: Create Documentation

Create documentation in `docs/solutions/` with this structure:

```
docs/solutions/
├── drupal/
│   ├── caching-strategies.md
│   ├── entity-access-patterns.md
│   └── migration-techniques.md
├── frontend/
│   ├── sdc-patterns.md
│   ├── tailwind-v4-migration.md
│   └── alpine-integration.md
├── devops/
│   ├── ddev-configuration.md
│   └── ci-cd-patterns.md
└── troubleshooting/
    ├── common-errors.md
    └── debugging-techniques.md
```

### Phase 3: Document Format

```markdown
# [Problem/Pattern Title]

## Context
When does this apply? What triggers this situation?

## Problem
What was the issue? What made it tricky?

## Solution
Step-by-step solution with code examples.

## Why It Works
Explanation of the underlying cause/mechanism.

## Related
- Links to related docs
- Drupal.org references
- Stack Overflow threads

## Tags
`#drupal` `#caching` `#performance`
```

### Phase 4: Cross-Reference

Update relevant files to reference the new documentation:
- Add link in CLAUDE.md if broadly applicable
- Reference from related solution docs
- Tag appropriately for searchability

## Example Documentation

```markdown
# Entity Access Bypass for Admin Operations

## Context
When performing bulk operations in custom modules where
the user has already been verified as admin.

## Problem
Entity access checks on every operation cause N+1 
permission lookups, slowing batch processes.

## Solution
\`\`\`php
// Temporarily bypass access checks for trusted operations
$entities = \Drupal::entityTypeManager()
  ->getStorage('node')
  ->loadMultiple($nids);

// Process with access bypass
$access_handler = \Drupal::entityTypeManager()
  ->getAccessControlHandler('node');
  
foreach ($entities as $entity) {
  // Bypass only after verifying admin context
  if ($this->currentUser->hasPermission('administer nodes')) {
    // Direct operation without per-entity access check
    $entity->setPublished();
    $entity->save();
  }
}
\`\`\`

## Why It Works
Access checks are expensive when done per-entity.
Pre-verifying admin permission once allows safe bypass
for bulk operations.

## Related
- [Drupal Entity Access API](https://drupal.org/docs/...)
- [Performance Optimization Guide](../performance/...)

## Tags
`#drupal` `#entity` `#performance` `#access`
```

## Categories

| Category | Use For |
|----------|---------|
| `drupal/` | Drupal-specific patterns, APIs, hooks |
| `frontend/` | SDC, Twig, Tailwind, Alpine patterns |
| `devops/` | DDEV, CI/CD, deployment patterns |
| `troubleshooting/` | Error solutions, debugging techniques |
| `architecture/` | Design decisions, ADRs |
| `testing/` | Test patterns, mocking strategies |

## Integration

This documentation is automatically searchable by:
- `repo-research-analyst` agent during `/plan`
- `librarian` agent for documentation lookup
- Future developers via grep/search
