---
name: acms-review
description: Perform exhaustive code reviews using multi-agent analysis and parallel execution
argument-hint: "[PR number, GitHub URL, branch name, or latest]"
---

# Review Command

Perform exhaustive code reviews using multi-agent analysis.

## Introduction

<role>Senior Code Review Architect with expertise in security, performance, architecture, and quality assurance</role>

## Prerequisites

- Git repository with GitHub CLI (`gh`) installed and authenticated
- Clean main/master branch
- Proper permissions to access the repository

## Main Tasks

### 1. Determine Review Target & Setup

<review_target> #$ARGUMENTS </review_target>

**Immediate Actions:**

- [ ] Determine review type: PR number (numeric), GitHub URL, branch name, or empty (current branch)
- [ ] Check current git branch
- [ ] If ALREADY on the PR branch → proceed with analysis on current branch
- [ ] If DIFFERENT branch → `gh pr checkout <number>` or ask about worktree
- [ ] Fetch PR metadata: `gh pr view --json title,body,files,additions,deletions`
- [ ] Identify changed files and scope of review

### 2. Parallel Specialist Reviews

Run ALL relevant specialists **in parallel at the same time**:

**Core Drupal Review (ALWAYS):**
- Task drupal-specialist(pr_context)
- Task dries-drupal-specialist(pr_context)

**SDC & Paragraphs (if component changes):**
- Task sdc-specialist(changes)
- Task paragraphs-specialist(changes)

**DRY & Component Reuse (ALWAYS for frontend):**
- Task component-reuse-specialist(changes)

**Frontend (if Twig/CSS/JS changes):**
- Task twig-specialist(changes)
- Task tailwind-specialist(changes)
- Task storybook-specialist(changes)
- Task accessibility-specialist(changes)
- Task drupal-theme-specialist(changes)

**Quality & Security (ALWAYS):**
- Task security-sentinel(changes)
- Task test-coverage-specialist(changes)
- Task code-quality-specialist(changes)

**Agent-Native (for new features):**
- Task agent-native-reviewer(changes)

**Architecture (for significant changes):**
- Task architecture-strategist(changes)
- Task performance-oracle(changes)
- Task pattern-recognition-specialist(changes)

**Dependencies (if composer.json/package.json changed):**
- Task composer-specialist(changes)

**Data (if database/entity changes):**
- Task data-integrity-guardian(changes)

**History context:**
- Task git-history-analyzer(pr_context)

**Specialist Selection Guide:**

| Change Type | Required Specialists |
|-------------|----------------------|
| PHP/Module | drupal-specialist, dries-drupal-specialist, security-sentinel, test-coverage-specialist |
| Twig/Theme | twig-specialist, drupal-theme-specialist, accessibility-specialist, component-reuse-specialist |
| SDC Components | sdc-specialist, component-reuse-specialist, storybook-specialist |
| Paragraphs | paragraphs-specialist, sdc-specialist |
| CSS/Tailwind | tailwind-specialist, accessibility-specialist, component-reuse-specialist |
| JS/Alpine | storybook-specialist (if applicable) |
| composer.json | composer-specialist |
| Database/Entity | data-integrity-guardian |
| Large/Arch | architecture-strategist, performance-oracle |
| New Features | agent-native-reviewer |
| ALL PRs | code-simplifier (after synthesis) |

### 3. Findings Synthesis

**Consolidate all agent reports:**

- [ ] Collect findings from all parallel agents
- [ ] Categorize by type: security, performance, architecture, quality
- [ ] Assign severity levels:
  - **P1 CRITICAL** - Security vulnerabilities, data corruption, breaking changes
  - **P2 IMPORTANT** - Performance issues, architectural concerns, reliability
  - **P3 NICE-TO-HAVE** - Minor improvements, code cleanup, optimizations
- [ ] Remove duplicate or overlapping findings
- [ ] Estimate effort for each finding (Small/Medium/Large)

### 4. Simplification Review (MANDATORY)

**After synthesizing findings, run the code-simplifier:**

- Task code-simplifier(changes)

**The code-simplifier checks for:**
- Unnecessary complexity and over-engineering
- YAGNI violations (You Aren't Gonna Need It)
- Premature abstractions
- Dead code and unused variables
- Opportunities to reduce LOC while maintaining functionality

Add simplification findings to P2 or P3 categories.

### 5. Review Summary Report

Present findings as markdown:

```markdown
## Code Review Complete

**Review Target:** PR #XXXX - [PR Title]
**Branch:** [branch-name]
**Files Changed:** [count]

---

### Findings Summary

- **Total Findings:** [X]
- **P1 CRITICAL:** [count] - BLOCKS MERGE
- **P2 IMPORTANT:** [count] - Should Fix
- **P3 NICE-TO-HAVE:** [count] - Enhancements

---

### P1 - Critical (BLOCKS MERGE)

#### [Finding Title]
- **Location:** `file.php:42`
- **Issue:** [Description]
- **Fix:** [Proposed solution]
- **Effort:** Small/Medium/Large

---

### P2 - Important

#### [Finding Title]
- **Location:** `file.php:78`
- **Issue:** [Description]
- **Fix:** [Proposed solution]

---

### P3 - Nice-to-Have

- [ ] [Finding 1]
- [ ] [Finding 2]

---

### Review Agents Used

- drupal-specialist
- dries-drupal-specialist
- security-sentinel
- code-simplifier
- [others...]

---

### Merge Recommendation

[ ] **APPROVED** - No P1 findings, ready to merge
[ ] **APPROVED WITH CONCERNS** - P2 findings should be addressed
[ ] **REQUEST CHANGES** - P1 findings must be fixed before merge
```

### 6. Next Steps

After presenting findings, offer options:

1. **Fix P1 Issues** - Start `/acms-work` to address critical findings
2. **Create Issues** - Create GitHub issues for P2/P3 findings
3. **Approve PR** - If no P1 findings, approve the PR

---

## Severity Guidelines

### P1 - CRITICAL (Blocks Merge)

- SQL injection, XSS, authentication bypass
- Data corruption or loss
- Breaking changes without migration
- Critical accessibility failures (keyboard traps)
- Memory leaks or resource exhaustion

### P2 - IMPORTANT (Should Fix)

- Performance issues (N+1 queries, missing cache)
- Missing error handling
- Incomplete test coverage for new code
- Accessibility issues (missing labels, contrast)
- Code that violates Drupal standards

### P3 - NICE-TO-HAVE (Enhancement)

- Code style improvements
- Documentation updates
- Minor refactoring opportunities
- Optimization suggestions
- Nice-to-have tests

## When to Use Full Review

**Use full multi-agent review for:**
- PRs with 10+ files changed
- Security-sensitive changes
- Architectural changes
- New features
- Changes by junior developers

**Use minimal review for:**
- Documentation-only changes
- Simple bug fixes
- Config changes
- Dependency updates (just composer-specialist)
