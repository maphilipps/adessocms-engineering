# Compounding Engineering Plugin Development

## Versioning Requirements

**IMPORTANT**: Every change to this plugin MUST include updates to all three files:

1. **`.claude-plugin/plugin.json`** - Bump version using semver
2. **`CHANGELOG.md`** - Document changes using Keep a Changelog format
3. **`README.md`** - Verify/update component counts and tables

### Version Bumping Rules

- **MAJOR** (1.0.0 → 2.0.0): Breaking changes, major reorganization
- **MINOR** (1.0.0 → 1.1.0): New agents, commands, or skills
- **PATCH** (1.0.0 → 1.0.1): Bug fixes, doc updates, minor improvements

### Pre-Commit Checklist

Before committing ANY changes:

- [ ] Version bumped in `.claude-plugin/plugin.json`
- [ ] CHANGELOG.md updated with changes
- [ ] README.md component counts verified
- [ ] README.md tables accurate (agents, commands, skills)
- [ ] plugin.json description matches current counts

### Directory Structure

```
agents/
├── core/          # Core workflow agents (frontend-engineer, librarian, etc.)
├── review/        # Code review agents (code-simplicity, architecture, security)
├── research/      # Research agents (repo-analyst, best-practices, git-history)
├── design/        # Design agents (iterator, implementation-reviewer, figma-sync)
├── workflow/      # Workflow automation (lint, bug-validator, pr-resolver)
├── docs/          # Documentation agents (document-writer)
└── specialists/   # Drupal domain specialists (17 experts)

commands/
├── workflows/     # Core workflow commands (plan, work, review)
├── lfg.md         # Full autonomous workflow
├── spec.md        # Interview-based specification
├── compound.md    # Knowledge compounding
├── triage.md      # Finding triage
└── *.md           # Utility commands (generate-*, resolve-*)

skills/
├── adessocms-frontend/  # Meta-Skill: SDC, Tailwind, Twig, Alpine
├── drupal-backend/      # Meta-Skill: Entities, Services, Plugins
├── devops/              # Meta-Skill: DDEV, Composer, CI/CD
├── gitlab/              # MR, Pipelines, glab CLI
├── github/              # PR, Actions, gh CLI
├── file-todos/          # File-based todo tracking
├── compound-docs/       # Knowledge documentation
└── *.md                 # Other skills (standalone)
```

## Documentation

See `docs/solutions/plugin-versioning-requirements.md` for detailed versioning workflow.

---

## Compound Engineering Workflow (v4.0.0)

### Core Workflow

```
/plan               # Research + structured planning
      ↓
/deepen-plan        # Add implementation details (optional)
      ↓
/work               # TodoWrite-driven implementation
      ↓
/review             # Parallel specialist review
      ↓
/compound           # Document learnings
```

### Full Autonomous (/lfg)

Complete workflow from idea to PR:
```
/lfg "Feature description"
  → /plan → /deepen-plan → /work → /review
  → /resolve-todo-parallel → /playwright-test → /feature-video → PR
```

Requires `ralph-loop` plugin for autonomous execution.

---

### Phase 1: /plan

- Launches parallel research agents (repo-research-analyst, best-practices-researcher, framework-docs-researcher)
- Creates structured implementation plan
- Optionally uses `design-system-guardian` for UI decisions

### Phase 2: /work

- Uses TodoWrite for task tracking
- Supports git worktrees for parallel development
- Auto-invokes skills based on file types

**Skill Auto-Invocation:**

| File Type | Skill Invoked |
|-----------|---------------|
| SDC, Twig, Tailwind | `adessocms-frontend` |
| PHP, Module, Services | `drupal-backend` |
| DDEV, Composer, CI | `devops` |
| GitLab MR, Pipelines | `gitlab` |
| GitHub PR, Actions | `github` |

**Specialist Usage during Implementation:**

| Change Type | Specialists |
|-------------|-------------|
| PHP/Module | `drupal-specialist`, `security-sentinel` |
| Twig/Theme | `twig-specialist`, `drupal-theme-specialist` |
| SDC Components | `sdc-specialist` |
| CSS/Tailwind | `tailwind-specialist` |
| Tests | `test-coverage-specialist` |
| Database/Migrations | `data-integrity-guardian` |
| Performance-critical | `performance-oracle` |
| **Before every commit** | `code-simplifier` |

### Phase 3: /review

- Launches 10+ specialists in parallel
- Creates file-todos for findings in `todos/` directory
- Uses `/triage` for one-by-one resolution

### Phase 4: /compound

- Documents solved problems in `docs/solutions/`
- Builds cumulative knowledge base
- Uses YAML frontmatter for categorization

---

### Meta-Skills (v4.0.0)

**5 consolidated skills with Domain Expertise Pattern:**

| Meta-Skill | Description | Files |
|------------|-------------|-------|
| `adessocms-frontend` | SDC, Tailwind v4, Twig, Alpine.js | 15 files |
| `drupal-backend` | Entities, Services, Plugins, Config | 20 files |
| `devops` | DDEV, Composer, CI/CD | 9 files |
| `gitlab` | glab CLI, MRs, Pipelines | 8 files |
| `github` | gh CLI, PRs, Actions | 8 files |

### Agent Categories (40 total)

**Review Agents (6):** `code-simplicity-reviewer`, `architecture-strategist`, `security-sentinel`, `performance-oracle`, `data-integrity-guardian`, `pattern-recognition-specialist`

**Research Agents (4):** `repo-research-analyst`, `best-practices-researcher`, `framework-docs-researcher`, `git-history-analyzer`

**Design Agents (3):** `design-iterator`, `design-implementation-reviewer`, `figma-design-sync`

**Workflow Agents (4):** `bug-reproduction-validator`, `lint`, `pr-comment-resolver`, `spec-flow-analyzer`

**Docs Agents (1):** `document-writer`

**Core Agents (5):** `frontend-engineer`, `librarian`, `reviewer-selector`, `skill-invoker`, `agent-native-reviewer`

**Drupal Specialists (17):**
- **Core:** `drupal-specialist`, `drupal-theme-specialist`, `paragraphs-specialist`
- **Frontend:** `twig-specialist`, `sdc-specialist`, `tailwind-specialist`, `storybook-specialist`
- **Quality:** `accessibility-specialist`, `test-coverage-specialist`
- **Architecture:** `component-reuse-specialist`
- **Data:** `composer-specialist`
- **Design:** `design-system-guardian`

---

## Auto-Invoke Rules (MANDATORY)

### During Implementation (/work)

When working on features, Claude MUST invoke skills based on file types:

```
SDC/Twig/Tailwind work → Skill(skill: "adessocms-frontend")
PHP/Module work        → Skill(skill: "drupal-backend")
DDEV/CI work          → Skill(skill: "devops")
GitLab work           → Skill(skill: "gitlab")
GitHub work           → Skill(skill: "github")
```

### After Implementation: code-simplifier (MANDATORY)

After completing ANY implementation task, Claude MUST automatically invoke
the code-simplifier agent to ensure code is minimal and simple.

**This applies to:**
- After /work completes a feature
- After any significant code changes (5+ lines)
- Before committing changes

**Invoke with:** `Task(subagent_type: "code-simplifier", prompt: "Review and simplify the changes I just made")`

**This is MANDATORY, not optional. No exceptions.**

### During Review (/review)

Invoke specialists based on file types changed:

| File Pattern | Specialists to Invoke |
|--------------|----------------------|
| `.php`, `.module` | `drupal-specialist`, `security-sentinel` |
| `.twig` | `twig-specialist` |
| `*.sdc.yml`, SDC folders | `sdc-specialist` |
| `.tailwind.css`, Tailwind | `tailwind-specialist` |
| Theme files | `drupal-theme-specialist` |
| All changes | `architecture-strategist`, `accessibility-specialist` |

**Launch specialists IN PARALLEL** using multiple Task tool calls in a single message.
