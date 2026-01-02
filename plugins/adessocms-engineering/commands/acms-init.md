---
name: acms-init
description: Initialize project with adesso CMS Engineering workflow
allowed-tools: [Read, Write, Edit, Bash(mkdir:*), Bash(git:*)]
---

# /acms-init Command

Initialize this project for adesso CMS Engineering workflow.

## Your Task

Create or update `.claude/CLAUDE.md` with the core workflow and agent instructions.

## Implementation Steps

1. **Check if `.claude/` directory exists**, create if not:
   ```bash
   mkdir -p .claude
   ```

2. **Read existing `.claude/CLAUDE.md`** if it exists

3. **Write/Update `.claude/CLAUDE.md`** with the following content (preserve any existing custom sections):

```markdown
# Project CLAUDE.md - adesso CMS Engineering

## Workflow Commands

| Command | Purpose |
|---------|---------|
| `/acms-plan` | Create implementation plan with research agents |
| `/acms-review` | Review code with specialist agents |
| `/acms-work` | Execute work plan |
| `/acms-compound` | Document learnings |

**Workflow:** Plan → Review → Work → Review → Compound

## Agent Categories

### Specialists (Domain Expertise)

Use for domain-specific expertise (format: `adessocms-engineering:specialists:<name>`):

- `drupal-specialist` - Drupal APIs, hooks, services
- `sdc-specialist` - Single Directory Components
- `twig-specialist` - Twig templates, filters
- `tailwind-specialist` - Tailwind CSS, theming
- `accessibility-specialist` - WCAG 2.1 AA compliance
- `security-sentinel` - Security review, vulnerabilities
- `architecture-strategist` - Architecture decisions
- `performance-oracle` - Performance analysis

### Research Agents (Parallel Analysis)

- `repo-research-analyst` - Codebase research (local)
- `librarian` - External docs, framework research, best practices (consolidated)
- `git-history-analyzer` - Git history analysis

### Core Agents

- `frontend-engineer` - Visual changes, UI/UX, Tailwind, Alpine.js
- `document-writer` - README, API docs, user guides

## Usage Example

```
Task(subagent_type="adessocms-engineering:specialists:drupal-specialist", prompt="...")
Task(subagent_type="adessocms-engineering:research:repo-research-analyst", prompt="...")
```

## Compound Triggers

Document learnings after:
- Problem solved
- Non-trivial fix completed
- Pattern discovered

Use `/acms-compound` to capture learnings.

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
