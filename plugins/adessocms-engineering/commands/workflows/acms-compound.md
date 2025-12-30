---
name: acms-compound
description: Document a recently solved problem to compound your team's knowledge
argument-hint: "[optional: brief context about the fix]"
---

# /acms-compound

Document a recently solved problem in `docs/solutions/`.

## Core Principle

> **We want the simplest change possible. We don't care about migration. Code readability matters most, and we're happy to make bigger changes to achieve it.**

## Usage

```bash
/acms-compound                    # Document the most recent fix
/acms-compound [brief context]    # Provide additional context
```

## What It Does

1. **Analyze** the conversation for the solved problem
2. **Extract** root cause, solution, and prevention strategies
3. **Write** to `docs/solutions/[category]/[slug].md`

## Categories

- `build-errors/`
- `runtime-errors/`
- `performance-issues/`
- `security-issues/`
- `test-failures/`
- `ui-bugs/`

## Document Structure

```markdown
---
title: Brief descriptive title
category: performance-issues
tags: [drupal, caching, views]
date: 2025-01-15
---

# Problem
What went wrong (error messages, symptoms).

# Root Cause
Why it happened (technical explanation).

# Solution
How to fix it (code examples).

# Prevention
How to avoid it in future.
```

## When to Use

- After fixing a non-trivial bug
- After solving a problem that took research
- When you'd want to remember this solution later

## The Compound Effect

First fix: 30 min research → Document: 5 min → Next occurrence: 2 min lookup.

**Each documented solution makes the team smarter.**

---

## Session End: Land the Plane

Vor Session-Ende diese Schritte ausführen:

1. **File follow-up issues** für verbleibende Arbeit:
   ```bash
   bd create "Follow-up: <title>" -d "<notes>"
   ```

2. **Update Bead Status** (wenn Beads verwendet wurde):
   ```bash
   bd close <id> --reason "<reason>"  # wenn fertig
   ```

3. **Sync & Push** (MANDATORY):
   ```bash
   git pull --rebase
   bd sync
   git push
   ```

4. **Verify**:
   ```bash
   git status  # Muss "up to date with origin" zeigen
   ```

> **"Work is NOT complete until `git push` succeeds"**
