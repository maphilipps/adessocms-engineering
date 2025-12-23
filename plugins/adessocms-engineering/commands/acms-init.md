---
name: acms-init
description: Initialize project with adesso CMS Engineering workflow (Sisyphus orchestration, Oracle escalation, core agents)
allowed-tools: [Read, Write, Edit, Bash(mkdir:*), Bash(git:*)]
---

# /acms-init Command

Initialize this project for adesso CMS Engineering workflow.

## Your Task

Create or update `.claude/CLAUDE.md` with the Sisyphus orchestration pattern and core agent instructions.

## Implementation Steps

1. **Check if `.claude/` directory exists**, create if not:
   ```bash
   mkdir -p .claude
   ```

2. **Read existing `.claude/CLAUDE.md`** if it exists

3. **Write/Update `.claude/CLAUDE.md`** with the following content (preserve any existing custom sections):

```markdown
# Project CLAUDE.md - adesso CMS Engineering

## Workflow: Sisyphus Orchestration

For EVERY request, classify intent and act accordingly:

| Request Type | Action | Entry Point |
|--------------|--------|-------------|
| **Trivial** (typo, rename) | Direct tools only | None |
| **Exploratory** (find, research) | `Task(subagent_type="Explore")` parallel | None |
| **New Feature** | Full workflow | `/acms-plan` |
| **Bug Fix** | Abbreviated workflow | `/acms-work` |
| **Complex/Risky** | Full workflow + Oracle | `/acms-plan` + Oracle |
| **Ambiguous** | ONE clarifying question | Then classify |

## Core Agents

Always use full `subagent_type` paths:

| Agent | subagent_type | Model | When to Use |
|-------|---------------|-------|-------------|
| **Oracle** | `adessocms-engineering:core:oracle` | Opus | After 3 failures, architecture decisions, hard debugging |
| **Librarian** | `adessocms-engineering:core:librarian` | Sonnet | Documentation lookup, evidence-based answers |
| **Frontend Engineer** | `adessocms-engineering:core:frontend-engineer` | Sonnet | Visual changes, UI/UX, Tailwind, Alpine.js |
| **Document Writer** | `adessocms-engineering:core:document-writer` | Sonnet | README, API docs, user guides |

## Specialist Agents

Use for domain-specific expertise:

- `adessocms-engineering:specialists:drupal-specialist` - Drupal APIs, hooks, services
- `adessocms-engineering:specialists:sdc-specialist` - Single Directory Components
- `adessocms-engineering:specialists:twig-specialist` - Twig templates, filters
- `adessocms-engineering:specialists:tailwind-specialist` - Tailwind CSS, theming
- `adessocms-engineering:specialists:accessibility-specialist` - WCAG 2.1 AA compliance
- `adessocms-engineering:specialists:security-sentinel` - Security review, vulnerabilities

## Failure Protocol

After 3 consecutive failures on any task:
1. **STOP** - Don't try a 4th time
2. **Revert** - Undo any partial changes
3. **Consult Oracle**:
   ```
   Task(
     subagent_type="adessocms-engineering:core:oracle",
     model="opus",
     prompt="Problem: {description}\nAttempts: {what tried}\nErrors: {messages}"
   )
   ```

## Compound Triggers

Document learnings after:
- Problem solved
- Non-trivial fix completed
- Pattern discovered
- Oracle consultation resolved

Use `/acms-compound` to capture learnings.

## Commands Reference

| Command | Purpose |
|---------|---------|
| `/acms-plan` | Create implementation plan |
| `/acms-work` | Execute work plan |
| `/acms-review` | Review PR with specialists |
| `/acms-compound` | Document learnings |

## Philosophy

> "Work, delegate, verify, ship, LEARN."
```

4. **Confirm initialization**:
   - Report what was created/updated
   - Suggest next steps (e.g., run `/acms-plan` for first feature)

## Notes

- Preserve any existing custom content in CLAUDE.md
- Add the adesso CMS Engineering section at the beginning
- Create backup of existing CLAUDE.md if it has significant content
