---
name: bd-review
description: Perform exhaustive code reviews using multi-agent analysis and parallel execution
allowed-tools: ["Read", "Glob", "Grep", "Bash", "Task", "TodoWrite"]
argument-hint: "[file path, PR number, or 'staged' for staged changes]"
---

# BD-Review: Multi-Agent Code Review

You are orchestrating a comprehensive code review for a Laravel 12 + React 19 + Inertia.js application using specialized review agents.

## Review Scope

Determine what to review:
- **Staged changes**: `git diff --cached`
- **PR**: Fetch PR diff via `gh pr diff [number]`
- **Specific files**: Review provided file paths
- **Recent commits**: `git diff HEAD~N`

## Agent Selection

Based on the files changed, select appropriate agents:

### Always Include
- `architecture-strategist` - Overall architecture review
- `code-simplicity-reviewer` - Complexity analysis

### For PHP/Laravel Files (*.php)
- `laravel-reviewer` - Laravel best practices
- `laravel-security-sentinel` - Security vulnerabilities
- `laravel-performance-oracle` - Performance issues
- `eloquent-data-guardian` - Database integrity

### For TypeScript/React Files (*.tsx, *.ts)
- `typescript-react-reviewer` - TypeScript/React patterns
- `react-inertia-reviewer` - Inertia.js patterns

### For Migrations
- `laravel-migration-expert` - Migration safety

### For Spatie Data DTOs
- `spatie-data-reviewer` - DTO patterns

### For shadcn Components
- `shadcn-implementation-reviewer` - UI implementation

## Execution

1. **Identify changed files**:
```bash
git diff --name-only HEAD~1
```

2. **Categorize by type**:
- PHP files → Laravel reviewers
- TSX/TS files → React reviewers
- Migration files → Migration expert

3. **Launch agents in parallel** using Task tool with appropriate subagent_type

4. **Collect findings** and deduplicate

5. **Prioritize issues**:
- 🔴 Critical (security, data loss)
- 🟠 High (bugs, performance)
- 🟡 Medium (best practices)
- 🟢 Low (style, minor improvements)

## Output Format

```markdown
# Code Review Results

## Summary
- Files reviewed: X
- Agents used: Y
- Issues found: Z (X critical, Y high, Z medium)

## Critical Issues 🔴
[Must fix before merge]

## High Priority 🟠
[Should fix]

## Medium Priority 🟡
[Consider fixing]

## Recommendations 🟢
[Nice to have]

## Positive Observations ✨
[What's done well]
```

## Post-Review

Ask user:
- "Should I create GitHub issues for critical items?"
- "Should I auto-fix any issues?"
