---
name: acms-review
description: Perform exhaustive code reviews using multi-agent analysis and parallel execution
argument-hint: "[PR number, GitHub URL, branch name, or latest]"
---

# Review Command

Perform exhaustive code reviews using multi-agent analysis with appropriate model tiers.

## Introduction

<role>Senior Code Review Architect with expertise in security, performance, architecture, and quality assurance</role>

## Prerequisites

- Git repository with GitHub CLI (`gh`) installed and authenticated
- Clean main/master branch
- Proper permissions to access the repository

## Main Tasks

### 1. Determine Review Target & Setup (ALWAYS FIRST)

<review_target> #$ARGUMENTS </review_target>

**Immediate Actions:**

- [ ] Determine review type: PR number (numeric), GitHub URL, branch name, or empty (current branch)
- [ ] Check current git branch
- [ ] If ALREADY on the PR branch → proceed with analysis on current branch
- [ ] If DIFFERENT branch → `gh pr checkout <number>` or ask about worktree
- [ ] Fetch PR metadata: `gh pr view --json title,body,files,additions,deletions`
- [ ] Identify changed files and scope of review

### 2. Parallel Agent Reviews

Run ALL relevant agents **in parallel** with **model="sonnet"**:

```
# Core Drupal Review (ALWAYS)
Task(subagent_type="adessocms-engineering:review:drupal-reviewer", model="sonnet", prompt="Review PR: {pr_context}")
Task(subagent_type="adessocms-engineering:review:dries-drupal-reviewer", model="sonnet", prompt="Review PR: {pr_title}")

# Frontend (if Twig/CSS/JS changes)
Task(subagent_type="adessocms-engineering:review:twig-template-reviewer", model="sonnet", prompt="Review: {changes}")
Task(subagent_type="adessocms-engineering:review:tailwind-reviewer", model="sonnet", prompt="Review: {changes}")
Task(subagent_type="adessocms-engineering:review:storybook-reviewer", model="sonnet", prompt="Review: {changes}")
Task(subagent_type="adessocms-engineering:review:accessibility-reviewer", model="sonnet", prompt="Review: {changes}")
Task(subagent_type="adessocms-engineering:review:drupal-theme-reviewer", model="sonnet", prompt="Review: {changes}")

# Quality & Security (ALWAYS)
Task(subagent_type="adessocms-engineering:review:security-sentinel", model="sonnet", prompt="Security scan: {changes}")
Task(subagent_type="adessocms-engineering:review:test-coverage-reviewer", model="sonnet", prompt="Review: {changes}")
Task(subagent_type="adessocms-engineering:review:code-simplicity-reviewer", model="sonnet", prompt="Review: {changes}")

# Architecture (for significant changes)
Task(subagent_type="adessocms-engineering:review:architecture-strategist", model="sonnet", prompt="Review: {changes}")
Task(subagent_type="adessocms-engineering:review:performance-oracle", model="sonnet", prompt="Review: {changes}")
Task(subagent_type="adessocms-engineering:review:pattern-recognition-specialist", model="sonnet", prompt="Review: {changes}")

# Dependencies (if composer.json/package.json changed)
Task(subagent_type="adessocms-engineering:review:composer-dependency-reviewer", model="sonnet", prompt="Review: {changes}")

# Data (if database/entity changes)
Task(subagent_type="adessocms-engineering:review:data-integrity-guardian", model="sonnet", prompt="Review: {changes}")

# History context
Task(subagent_type="adessocms-engineering:research:git-history-analyzer", model="sonnet", prompt="Analyze: {pr_context}")
```

**Agent Selection Guide:**

| Change Type | Required Agents |
|-------------|-----------------|
| PHP/Module | drupal-reviewer, dries, security, test-coverage |
| Twig/Theme | twig-template, drupal-theme, accessibility |
| CSS/Tailwind | tailwind-reviewer, accessibility |
| JS/Alpine | storybook-reviewer (if applicable) |
| composer.json | composer-dependency-reviewer |
| Database/Entity | data-integrity-guardian |
| Large/Arch | architecture-strategist, performance-oracle |

### 3. Optional: Gemini Cross-Check

**Only if explicitly requested** OR for security-critical PRs:

```bash
# Check availability
which gemini >/dev/null 2>&1 || echo "Gemini not available - skipping"
```

If available and requested:

```
Task(subagent_type="adessocms-engineering:review:gemini-reviewer",
     model="sonnet",
     prompt="Cross-check findings:

     Findings Summary:
     {synthesized_findings}

     PR Context: {pr_title}")
```

### 4. Findings Synthesis

**Consolidate all agent reports:**

- [ ] Collect findings from all parallel agents
- [ ] Categorize by type: security, performance, architecture, quality
- [ ] Assign severity levels:
  - **P1 CRITICAL** - Security vulnerabilities, data corruption, breaking changes
  - **P2 IMPORTANT** - Performance issues, architectural concerns, reliability
  - **P3 NICE-TO-HAVE** - Minor improvements, code cleanup, optimizations
- [ ] Remove duplicate or overlapping findings
- [ ] Estimate effort for each finding (Small/Medium/Large)

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

- drupal-reviewer
- dries-drupal-reviewer
- security-sentinel
- [others...]

---

### Merge Recommendation

[ ] **APPROVED** - No P1 findings, ready to merge
[ ] **APPROVED WITH CONCERNS** - P2 findings should be addressed
[ ] **REQUEST CHANGES** - P1 findings must be fixed before merge
```

### 6. Next Steps

After presenting findings, offer options:

1. **Fix P1 Issues** - Start `/work` to address critical findings
2. **Create Issues** - Create GitHub issues for P2/P3 findings
3. **Approve PR** - If no P1 findings, approve the PR
4. **Request Gemini Review** - Get second opinion (if not already done)

---

## Model Selection

**CRITICAL: Always use appropriate model tiers to save tokens**

| Agent Category | Model | Reason |
|----------------|-------|--------|
| All review agents | sonnet | Capable for code review |
| Research agents | sonnet | Fast, sufficient |
| gemini-reviewer | sonnet | Orchestration only |

**NEVER use opus for review agents.** Sonnet is sufficient for code analysis.

## Parallel Execution

**CRITICAL: Run agents in parallel** to minimize review time.

Bad (sequential):
```
agent1 → wait → agent2 → wait → agent3
```

Good (parallel):
```
agent1 ┐
agent2 ├→ all complete → synthesize
agent3 ┘
```

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
- Dependency updates (just composer-dependency-reviewer)
