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
├── review/     # Code review agents
├── research/   # Research and analysis agents
├── design/     # Design and UI agents
├── workflow/   # Workflow automation agents
└── docs/       # Documentation agents

commands/
├── workflows/  # Core workflow commands (/refine, /work, /review, /compound)
└── *.md        # Utility commands

skills/
├── adessocms-frontend/  # Meta-Skill: SDC, Tailwind, Twig, Alpine
│   ├── SKILL.md         # Router
│   ├── workflows/       # Build, Convert, Verify
│   └── references/      # Patterns, Anti-patterns
├── drupal-backend/      # Meta-Skill: Entities, Services, Plugins
├── devops/              # Meta-Skill: DDEV, Composer, CI/CD
├── gitlab/              # MR, Pipelines, glab CLI
├── github/              # PR, Actions, gh CLI
└── *.md                 # Other skills (standalone)
```

## Documentation

See `docs/solutions/plugin-versioning-requirements.md` for detailed versioning workflow.

---

## adesso CMS Engineering Workflow (v3.0.0)

### Ralph Loop - Hauptworkflow

```
/acms-refine        # Feature-List erstellen (Interview + Research)
      ↓
/acms-work          # Ralph Loop: Feature für Feature abarbeiten
      ↓
/acms-review        # Parallel Specialist Review
```

### Phase 1: /acms-refine

Erstellt `tasks/<task>/feature-list.json` mit atomaren Features:

```json
{
  "features": [
    {
      "id": "F001",
      "title": "Database schema",
      "type": "backend",
      "skill": "drupal-backend",
      "passes": false
    }
  ]
}
```

**Optional Research Agents:**
- `repo-research-analyst` - Codebase Patterns
- `librarian` - Externe Dokumentation
- `design-system-guardian` - UI/Design Tokens

### Phase 2: /acms-work (Ralph Loop)

Arbeitet Features ab mit **einem Feature pro Session**:

1. Lese `feature-list.json`
2. Wähle nächste Feature mit `passes: false`
3. Invoke passenden Skill automatisch
4. Implementiere + Teste
5. Setze `passes: true` + Commit
6. Loop → nächste Feature

**Skill Auto-Invocation basierend auf `feature.skill`:**

| skill | Invokes |
|-------|---------|
| `adessocms-frontend` | SDC, Tailwind, Twig, Alpine.js |
| `drupal-backend` | Entities, Services, Plugins, Config |
| `devops` | DDEV, Composer, CI/CD |
| `gitlab` | glab MR, Pipelines |
| `github` | gh PR, Actions |

### Specialist Usage während Implementation

| Change Type | Specialists |
|-------------|-------------|
| PHP/Module | `drupal-specialist`, `security-sentinel` |
| Twig/Theme | `twig-specialist`, `drupal-theme-specialist` |
| SDC Components | `sdc-specialist` |
| CSS/Tailwind | `tailwind-specialist` |
| Tests | `test-coverage-specialist` |
| Database/Migrations | `data-integrity-guardian` |
| Performance-kritisch | `performance-oracle` |
| **Vor jedem Commit** | `code-simplifier` |

### Phase 3: Nach Implementation

1. `/acms-review` - Parallel Specialist Review
2. Git commit + push

### Meta-Skills (v3.0.0)

**5 konsolidierte Skills mit Domain Expertise Pattern:**

| Meta-Skill | Beschreibung | Dateien |
|------------|--------------|---------|
| `adessocms-frontend` | SDC, Tailwind v4, Twig, Alpine.js | 15 files |
| `drupal-backend` | Entities, Services, Plugins, Config | 20 files |
| `devops` | DDEV, Composer, CI/CD | 9 files |
| `gitlab` | glab CLI, MRs, Pipelines | 8 files |
| `github` | gh CLI, PRs, Actions | 8 files |

### Specialist Agents (17)

**Drupal Core:** `drupal-specialist`, `drupal-theme-specialist`, `paragraphs-specialist`
**Frontend:** `twig-specialist`, `sdc-specialist`, `tailwind-specialist`, `storybook-specialist`
**Quality:** `security-sentinel`, `accessibility-specialist`, `test-coverage-specialist`
**Architecture:** `architecture-strategist`, `performance-oracle`
**Data:** `data-integrity-guardian`, `composer-specialist`
**Design:** `design-system-guardian`, `component-reuse-specialist`

---

## Auto-Invoke Rules (MANDATORY)

### During Implementation (/acms-work)

When `feature-list.json` specifies a skill, Claude MUST invoke it:

```
"skill": "adessocms-frontend" → Skill(skill: "adessocms-frontend")
"skill": "drupal-backend"    → Skill(skill: "drupal-backend")
"skill": "devops"            → Skill(skill: "devops")
"skill": "gitlab"            → Skill(skill: "gitlab")
"skill": "github"            → Skill(skill: "github")
```

### After Implementation: code-simplifier (MANDATORY)

After completing ANY implementation task, Claude MUST automatically invoke
the code-simplifier agent to ensure code is minimal and simple.

**This applies to:**
- After /acms-work completes a feature
- After any significant code changes (5+ lines)
- Before committing changes

**Invoke with:** `Task(subagent_type: "code-simplifier", prompt: "Review and simplify the changes I just made")`

**This is MANDATORY, not optional. No exceptions.**

### During Review (/acms-review)

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
