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
├── workflows/  # Core workflow commands (/plan, /review, /work, /compound)
└── *.md        # Utility commands

skills/
└── *.md        # All skills at root level
```

## Documentation

See `docs/solutions/plugin-versioning-requirements.md` for detailed versioning workflow.

---

## adesso CMS Engineering Workflow

### Hauptworkflow

```
/acms-spec          # Spezifikation erstellen (optional mit Research)
      ↓
CC Plan Mode        # Native Claude Code Planung
      ↓
CC Implementation   # Native Claude Code Umsetzung
      ↓
/acms-review        # Parallel Specialist Review
      ↓
/acms-compound      # Learnings extrahieren
```

### /acms-spec (mit optionalem Research)

Nach dem Interview fragt `/acms-spec` ob Research Agents gestartet werden sollen:
- `repo-research-analyst` - Codebase Patterns und Konventionen
- `librarian` - Externe Dokumentation mit Permalinks
- `design-system-guardian` - UI/Design: existierende Komponenten und Tokens

### CC Plan Mode - Specialist Usage

Wenn du in Plan Mode wechselst, nutze unsere Agents:

**Phase 1 (Explore):**
```
Task(subagent_type="adessocms-engineering:research:repo-research-analyst", ...)
Task(subagent_type="adessocms-engineering:core:librarian", ...)
```

**Phase 2 (Design) - für große Änderungen:**
```
Task(subagent_type="adessocms-engineering:specialists:architecture-strategist", ...)
```

**Plan Output:**
- Schreibe Plan nach `plans/<feature>.md`
- Öffne in Typora: `open -a Typora plans/<feature>.md`

### CC Implementation - Specialist Usage

Während der Implementation, nutze Specialists basierend auf Change Type:

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

### Nach Implementation

1. `/acms-review` - Parallel Specialist Review basierend auf geänderten Dateien
2. `/acms-compound` - Learnings und Patterns extrahieren
3. Git commit + push

### Verfügbare Specialists (18+)

**Drupal Core:** `drupal-specialist`, `drupal-theme-specialist`, `paragraphs-specialist`
**Frontend:** `twig-specialist`, `sdc-specialist`, `tailwind-specialist`, `storybook-specialist`
**Quality:** `security-sentinel`, `accessibility-specialist`, `test-coverage-specialist`
**Architecture:** `architecture-strategist`, `performance-oracle`, `code-simplifier`
**Data:** `data-integrity-guardian`, `composer-specialist`
**Design:** `design-system-guardian`, `component-reuse-specialist`
