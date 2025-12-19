---
name: bd-compound
description: Document a recently solved problem to compound your team's knowledge
allowed-tools: ["Read", "Write", "Edit", "Glob", "Grep", "Bash", "Task", "AskUserQuestion"]
argument-hint: "[problem description or 'recent' for last solved issue]"
---

# BD-Compound: Knowledge Compounding

You are documenting a solved problem to compound the team's engineering knowledge. Every problem solved should make future similar problems easier.

## Philosophy

> "Compounding Engineering: Each unit of work makes subsequent work easier."

When you solve a problem:
1. **Document it** - So others don't repeat the investigation
2. **Extract patterns** - Identify reusable solutions
3. **Update guides** - Improve documentation
4. **Create automation** - If it can be automated, do it

## Workflow

### 1. Identify the Problem

Ask user or analyze recent git history:
- What problem was solved?
- What was the root cause?
- How was it discovered?
- How was it fixed?

### 2. Research Context

Use agents in parallel:
- `git-history-analyzer` - Find related commits
- `repo-research-analyst` - Find similar patterns in codebase

### 3. Document the Solution

Create documentation in appropriate location:

**For Bug Fixes:**
```markdown
# Bug: [Title]

## Symptoms
[How the bug manifested]

## Root Cause
[Why it happened]

## Solution
[How it was fixed]

## Prevention
[How to prevent similar issues]

## Related
[Links to commits, issues, docs]
```

**For New Patterns:**
```markdown
# Pattern: [Name]

## Problem
[What problem this solves]

## Solution
[The pattern/approach]

## Example
[Code example]

## When to Use
[Applicability]

## BD-App Specifics
[How this applies to our stack]
```

### 4. Update Existing Docs

Check if this affects:
- `ARCHITECTURE.md` - Architecture decisions
- `docs/DATENMODELL.md` - Data model
- Agent instructions - Should agents know this?
- Skills - Should this become a skill reference?

### 5. Consider Automation

Ask:
- Can this check be automated? → Add to linting/tests
- Is this a common task? → Create a command
- Do agents need this knowledge? → Update agent instructions

### 6. Create Artifacts

Based on analysis:
- Save to `docs/knowledge/[topic].md`
- Update relevant CLAUDE.md sections
- Create GitHub issue for follow-up automation if needed

## Output

A documented solution that compounds team knowledge:
- Clear problem description
- Reusable solution
- Updated documentation
- Optional: automation suggestions
