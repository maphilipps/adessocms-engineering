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
| **Exploratory** (find, research) | `Task Explore` parallel | None |
| **New Feature** | Full workflow | `/acms-plan` |
| **Bug Fix** | Abbreviated workflow | `/acms-work` |
| **Complex/Risky** | Full workflow + Oracle | `/acms-plan` + Oracle |
| **Ambiguous** | ONE clarifying question | Then classify |

## Core Agents

Use the full Task syntax with `subagent_type`:

| Agent | Usage | When to Use |
|-------|-------|-------------|
| **Oracle** | `Task(subagent_type="adessocms-engineering:core:oracle", prompt="...")` | After 3 failures, architecture decisions, hard debugging |
| **Librarian** | `Task(subagent_type="adessocms-engineering:core:librarian", prompt="...")` | Documentation lookup, evidence-based answers |
| **Frontend Engineer** | `Task(subagent_type="adessocms-engineering:core:frontend-engineer", prompt="...")` | Visual changes, UI/UX, Tailwind, Alpine.js |
| **Document Writer** | `Task(subagent_type="adessocms-engineering:core:document-writer", prompt="...")` | README, API docs, user guides |

## Specialist Agents

Use for domain-specific expertise (format: `plugin:category:agent-name`):

- `Task(subagent_type="adessocms-engineering:specialists:drupal-specialist", prompt="...")` - Drupal APIs, hooks, services
- `Task(subagent_type="adessocms-engineering:specialists:sdc-specialist", prompt="...")` - Single Directory Components
- `Task(subagent_type="adessocms-engineering:specialists:twig-specialist", prompt="...")` - Twig templates, filters
- `Task(subagent_type="adessocms-engineering:specialists:tailwind-specialist", prompt="...")` - Tailwind CSS, theming
- `Task(subagent_type="adessocms-engineering:specialists:accessibility-specialist", prompt="...")` - WCAG 2.1 AA compliance
- `Task(subagent_type="adessocms-engineering:specialists:security-sentinel", prompt="...")` - Security review, vulnerabilities

## Research Agents

For parallel research and analysis:

- `Task(subagent_type="adessocms-engineering:research:repo-research-analyst", prompt="...")` - Codebase research
- `Task(subagent_type="adessocms-engineering:research:best-practices-researcher", prompt="...")` - External best practices
- `Task(subagent_type="adessocms-engineering:research:framework-docs-researcher", prompt="...")` - Framework documentation
- `Task(subagent_type="adessocms-engineering:research:git-history-analyzer", prompt="...")` - Git history analysis

## Failure Protocol

After 3 consecutive failures on any task:
1. **STOP** - Don't try a 4th time
2. **Revert** - Undo any partial changes
3. **Consult Oracle**:
   ```
   Task(subagent_type="adessocms-engineering:core:oracle", prompt="Problem: {description}\nAttempts: {what tried}\nErrors: {messages}")
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
