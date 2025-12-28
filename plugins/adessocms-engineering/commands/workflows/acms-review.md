---
name: acms-review
description: Code review using parallel specialist agents
argument-hint: "[PR number, branch name, or 'latest']"
---

# /acms-review

Perform code reviews using parallel specialist agents.

## Core Principle

> **We want the simplest change possible. We don't care about migration. Code readability matters most, and we're happy to make bigger changes to achieve it.**

## Usage

```bash
/acms-review 123        # Review PR #123
/acms-review feature/x  # Review branch
/acms-review            # Review current branch
```

## Workflow

### 1. Setup

- Determine target (PR number, branch, or current)
- `gh pr view --json title,body,files,additions,deletions`
- Identify changed files

### 2. Run Specialists (Parallel)

Select based on changes:

| Change Type | Specialists |
|-------------|-------------|
| PHP/Module | drupal-specialist, security-sentinel, test-coverage-specialist |
| Twig/Theme | twig-specialist, accessibility-specialist |
| SDC | sdc-specialist, storybook-specialist |
| Paragraphs | paragraphs-specialist, sdc-specialist |
| CSS/Tailwind | tailwind-specialist, accessibility-specialist |
| composer.json | composer-specialist |
| Database | data-integrity-guardian |
| Large changes | architecture-strategist, performance-oracle |
| ALL reviews | code-simplifier (after synthesis) |

### 3. Synthesize Findings

Categorize by severity:

- **P1 CRITICAL** - Security, data corruption, breaking changes → BLOCKS MERGE
- **P2 IMPORTANT** - Performance, missing tests, accessibility → Should fix
- **P3 NICE-TO-HAVE** - Style, docs, minor refactoring → Enhancement

### 4. Report

```markdown
## Code Review: PR #XXX

**Files:** X | **P1:** X | **P2:** X | **P3:** X

### P1 - Critical (Blocks Merge)
- `file.php:42` - [Issue] → [Fix]

### P2 - Important
- `file.php:78` - [Issue] → [Fix]

### P3 - Nice-to-Have
- [ ] Minor improvement 1
- [ ] Minor improvement 2

### Recommendation
[ ] APPROVED | [ ] APPROVED WITH CONCERNS | [ ] REQUEST CHANGES
```

## Available Specialists

**17 specialists in `agents/specialists/`:**

accessibility, architecture-strategist, code-quality, component-reuse, composer, data-integrity-guardian, drupal, drupal-theme, paragraphs, pattern-recognition, performance-oracle, sdc, security-sentinel, storybook, tailwind, test-coverage, twig

**2 reviewers in `agents/review/`:**

agent-native-reviewer, code-simplifier

## Severity Guide

**P1 (Blocks):** SQL injection, XSS, data loss, keyboard traps
**P2 (Should fix):** N+1 queries, missing cache, no tests, a11y issues
**P3 (Nice-to-have):** Code style, docs, minor refactoring
