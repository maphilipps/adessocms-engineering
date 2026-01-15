---
name: workflows:review
description: Exhaustive multi-agent code review with parallel specialists and file-todos tracking
argument-hint: "[branch, PR URL, or file paths]"
---

# /review - Comprehensive Code Review Workflow

Launch parallel specialist agents for exhaustive code review, tracking all findings with file-todos.

## Workflow

### Phase 1: Determine Scope

Identify what to review:
- Current branch diff vs main: `git diff main...HEAD`
- Specific PR: Fetch PR diff
- Specific files: Review those files

```bash
# Get changed files
git diff --name-only main...HEAD
```

### Phase 2: Invoke File-Todos Skill

Initialize file-based todo tracking for review findings:

```
Skill(skill: "file-todos")
```

This creates `todos/` directory with tracking files.

### Phase 3: Launch Parallel Review Agents

**CRITICAL: Launch ALL relevant agents IN PARALLEL using multiple Task calls in a single message**

Based on file types changed, launch appropriate specialists:

#### For PHP/Module Changes:
```
Task(subagent_type: "adessocms-engineering:specialists:drupal-specialist")
Task(subagent_type: "adessocms-engineering:specialists:security-sentinel")
Task(subagent_type: "adessocms-engineering:review:architecture-strategist")
Task(subagent_type: "adessocms-engineering:review:performance-oracle")
```

#### For Theme/Frontend Changes:
```
Task(subagent_type: "adessocms-engineering:specialists:drupal-theme-specialist")
Task(subagent_type: "adessocms-engineering:specialists:twig-specialist")
Task(subagent_type: "adessocms-engineering:specialists:sdc-specialist")
Task(subagent_type: "adessocms-engineering:specialists:tailwind-specialist")
Task(subagent_type: "adessocms-engineering:specialists:accessibility-specialist")
```

#### For Database/Data Changes:
```
Task(subagent_type: "adessocms-engineering:review:data-integrity-guardian")
```

#### For All Reviews (MANDATORY):
```
Task(subagent_type: "adessocms-engineering:review:code-simplicity-reviewer")
Task(subagent_type: "adessocms-engineering:specialists:test-coverage-specialist")
```

### Phase 4: Collect Findings

Each agent creates findings in file-todos format:

```markdown
# todos/review-[agent-name].md

## Findings

### HIGH: [Finding Title]
- **File**: `path/to/file.php:123`
- **Issue**: [Description]
- **Recommendation**: [How to fix]
- **Status**: pending

### MEDIUM: [Finding Title]
...
```

### Phase 5: Consolidate & Triage

After all agents complete:

1. Run `/triage` to go through findings one-by-one
2. Prioritize by severity (HIGH → MEDIUM → LOW)
3. Mark false positives as `wont_fix`
4. Create actionable items for valid findings

## Review Agent Responsibilities

| Agent | Focus Area |
|-------|------------|
| `code-simplicity-reviewer` | Over-engineering, unnecessary complexity |
| `architecture-strategist` | Design patterns, boundaries, coupling |
| `security-sentinel` | OWASP Top 10, input validation, access control |
| `performance-oracle` | N+1 queries, caching, memory usage |
| `data-integrity-guardian` | Migrations, constraints, transactions |
| `drupal-specialist` | Drupal APIs, hooks, best practices |
| `drupal-theme-specialist` | Theme hooks, preprocess, libraries |
| `twig-specialist` | Template security, performance |
| `sdc-specialist` | Component structure, props, slots |
| `tailwind-specialist` | CSS utility usage, v4 patterns |
| `accessibility-specialist` | WCAG 2.1 AA compliance |
| `test-coverage-specialist` | Test quality, coverage gaps |

## Output Format

```markdown
## Code Review Summary

### Statistics
- Files Reviewed: X
- Findings: Y (Z high, A medium, B low)
- Agents Used: [list]

### High Priority Findings
1. [Finding 1]
2. [Finding 2]

### Action Items
- [ ] Fix [issue 1]
- [ ] Address [issue 2]

### Approved Patterns
- [Pattern that was done well]
```

## Integration with /triage

Run `/triage` after review to:
- Process findings one-by-one
- Update status (pending → ready → completed)
- Skip false positives
