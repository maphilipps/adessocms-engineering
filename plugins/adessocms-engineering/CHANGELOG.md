# Changelog

## [1.6.0] - 2025-12-11

### Added - Plan Triage Agent for Token Optimization

**New orchestrator agent that right-sizes planning effort based on task complexity.**

### Added

- **plan-triage agent** - Opus-based orchestrator that classifies tasks and acts accordingly
  - TRIVIAL: Writes minimal plan with commands (no research agents)
  - SIMPLE: Writes checklist plan (no research agents)
  - COMPLEX: Spawns research agents in parallel, synthesizes comprehensive plan
- **Consistent markdown output** - ALL classifications produce `plans/<slug>.md`

### Changed

- `/plan` workflow: Now delegates entirely to plan-triage agent
  - Single agent invocation instead of hardcoded 3 parallel research agents
  - Research agents only spawned for COMPLEX tasks
  - Plan file always created and opened in Typora

### Token Savings

| Task Type | Before (v1.5) | After (v1.6) | Savings |
|-----------|---------------|--------------|---------|
| TRIVIAL (install module) | ~150k tokens | ~15k tokens | 90% |
| SIMPLE (add field) | ~150k tokens | ~25k tokens | 83% |
| COMPLEX (SSO integration) | ~150k tokens | ~150k tokens | 0% (appropriate) |

### Example Classifications

| Task | Classification | Research Agents |
|------|----------------|-----------------|
| "Install drupal/memcache" | TRIVIAL | None |
| "Add phone field to contact" | SIMPLE | None |
| "Implement Azure AD SSO" | COMPLEX | 3 parallel |

---

## [1.5.0] - 2025-12-11

### Changed - Token Optimization & Simplified Architecture

**BREAKING: Major simplification for token efficiency**

This release removes ~50,000 tokens of overhead per workflow cycle by eliminating Beans and simplifying Gemini integration.

### Removed

- **Beans System** - Replaced with native TodoWrite for task tracking
- **beans-maintainer agent** - No longer needed
- **gemini-coauthor skill** - Replaced with simple CLI agents
- **Strategic Checkpoints** - Removed 4x Gemini calls during /work
- **Opus model tier** - All agents now use Sonnet or Haiku

### Added

- **gemini-brainstorm agent** - Simple CLI-based architecture brainstorming (optional)
- **gemini-reviewer agent** - Simple CLI-based review cross-check (optional)

### Modified

- `/plan` workflow: Uses TodoWrite instead of Beans, Gemini is optional
- `/work` workflow: Uses TodoWrite, no strategic checkpoints, simpler flow
- `/review` workflow: Direct markdown output instead of Beans, Gemini optional
- **Critical agents**: Removed model field (inherits session model)
  - dries-drupal-reviewer, security-sentinel, performance-oracle, architecture-strategist
- **Standard agents**: Changed from Opus to Sonnet
  - design-iterator: opus → sonnet

### Token Savings

| Component | Before | After | Savings |
|-----------|--------|-------|---------|
| Beans (per cycle) | ~30,000 | 0 | -30,000 |
| Gemini Checkpoints | ~20,000 | 0-2,000 | -18,000+ |
| Opus Agents (5x) | ~25,000 | ~8,000 | -17,000 |
| **Total** | ~75,000 | ~10,000 | **~65,000** |

### Model Tier Strategy (EveryInc-Style)

| Model | Count | Use Case |
|-------|-------|----------|
| *(none)* | 8 | Critical analysis, design review - inherits session model |
| sonnet | 14 | Standard reviews, external research |
| haiku | 6 | Local research, simple tasks, CLI |

### Gemini Integration

Gemini is now **optional and non-blocking**:
- Only invoked when explicitly requested
- Uses simple CLI: `gemini -m gemini-3-pro-preview -p "..." --output-format json`
- Failures are ignored (graceful degradation)

### Migration

1. Remove any Beans hooks from `~/.claude/settings.json`
2. TodoWrite now handles all task tracking
3. Gemini agents are opt-in, not automatic

---

## [1.4.0] - 2025-12-10

### Changed - Architecture-First with Gemini 3 Pro

**Note: This version was superseded by 1.5.0 due to high token usage.**

- Gemini 3 Pro as Strategic Architect
- Beans integration for task tracking
- Strategic checkpoints during /work

---

# Changelog

All notable changes to the adessocms-engineering plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2024-12-08

### Added

- **New Skill**: `generate-user-handbook` - Generiert vollständige Benutzerhandbücher für Drupal-Backends
  - Automatisches Login und Screenshot-Erstellung via Playwright
  - MkDocs Material Theme mit deutscher Lokalisierung
  - Schritt-für-Schritt Anleitungen für technisch unbedarfte Nutzer
  - 3 Workflows: generate-handbook, capture-section, update-handbook
  - Umfangreiche References für Schreibstil und Screenshot-Guidelines
- **New Command**: `/generate-user-handbook` - Startet die Handbuch-Generierung

---

## [1.1.0] - 2024-12-08

### Added

- **New Skill**: `create-drupal-case-study` - Generate Drupal.org case study submissions
  - Analyzes project codebase (composer.json, modules, theme, config)
  - Asks targeted questions about client, goals, and outcomes
  - Creates structured sections ready for Drupal.org submission
  - Optional Playwright-based screenshot capture of live sites
- **New Command**: `/create-drupal-case-study` - Invoke case study generation skill

---

## [1.0.0] - 2024-12-07

Initial release of the adessocms-engineering plugin, forked from compound-engineering and adapted for Drupal 11 development.

### Added

**9 New Drupal-Specific Agents**

*Review Agents*
- `drupal-reviewer` - Drupal coding standards, API usage, and best practices
- `dries-drupal-reviewer` - Brutally honest Drupal review from Dries Buytaert's perspective
- `twig-template-reviewer` - Twig templates, security, Drupal patterns, SDC
- `drupal-theme-reviewer` - Theme implementations, SDC, preprocess functions, libraries
- `tailwind-reviewer` - Tailwind CSS v4 syntax, Vite integration, Drupal theming
- `storybook-reviewer` - Storybook stories, SDC integration, interaction tests
- `accessibility-reviewer` - WCAG 2.1 Level AA, ARIA, semantic HTML, keyboard nav
- `composer-dependency-reviewer` - Composer dependencies, security, Drupal contrib
- `test-coverage-reviewer` - PHPUnit, Kernel, Functional, Playwright, Vitest coverage

**4 Drupal Skills from grasmash/drupal-claude-skills**
- `drupal-at-your-fingertips` - Comprehensive Drupal patterns (50+ topics)
- `drupal-config-mgmt` - Configuration management best practices
- `drupal-contrib-mgmt` - Contrib module management and patching
- `drupal-ddev` - DDEV integration and workflows
- `ivangrynenko-cursorrules-drupal` - Drupal security guidelines (OWASP)

### Changed

- **Plugin renamed** from `compound-engineering` to `adessocms-engineering`
- **Keywords updated** for Drupal, PHP, Twig, Tailwind, Storybook
- **MCP Servers** retained: Playwright and Context7 (useful for all projects)

### Removed

**7 Language-Specific Agents** (Rails/Ruby/Python/TypeScript)
- `kieran-rails-reviewer`
- `kieran-python-reviewer`
- `kieran-typescript-reviewer`
- `dhh-rails-reviewer`
- `julik-frontend-races-reviewer`
- `ankane-readme-writer`
- `every-style-editor`

**5 Language-Specific Skills** (Ruby)
- `andrew-kane-gem-writer`
- `dhh-ruby-style`
- `dspy-ruby`
- `every-style-editor`
- `gemini-imagegen`

### Summary

| Component | Original | adessocms | Change |
|-----------|----------|-----------|--------|
| Agents | 24 | 26 | +2 (9 new, -7 removed) |
| Commands | 19 | 19 | unchanged |
| Skills | 11 | 11 | +5 Drupal, -5 Ruby |
| MCP Servers | 2 | 2 | unchanged |

### Tech Stack Focus

This plugin is optimized for:
- **CMS**: Drupal 11.x
- **Backend**: PHP 8.3, MariaDB
- **Frontend**: Vite, Tailwind CSS v4, Flowbite
- **Components**: Single Directory Components (SDC)
- **Testing**: PHPUnit, Playwright, Vitest, Storybook
- **Dev Environment**: DDEV

---

## Acknowledgments

Based on [compound-engineering](https://github.com/EveryInc/every-marketplace) by Kieran Klaassen and Every.to.

Drupal skills integrated from [drupal-claude-skills](https://github.com/grasmash/drupal-claude-skills) by Matthew Grasmick.
