# Changelog

## [1.4.0] - 2025-12-10

### Changed - Architecture-First with Gemini 3 Pro

**BREAKING: Gemini role completely redesigned**

- **Gemini 3 Pro = Strategic Architect** (architecture, system design, oversight)
- **Claude Opus 4.5 = Implementation Expert** (code, details, execution)

### Added

- `architecture-design.md`: Gemini designs system architecture FIRST in /plan
- `strategic-checkpoint.md`: Gemini provides oversight during /work (25%, 50%, 75%, 100%)
- `architecture-validation.md`: Final Go/No-Go decision before PR
- `beans-maintainer` agent: Manages bean operations (checklists, links, architecture tracking)

### Modified

- `/plan` workflow: Gemini creates architecture before Claude plans implementation
- `/work` workflow: Strategic checkpoints at 25/50/75/100% completion
- `gemini-coauthor` skill: Updated for Strategic Architect role
- Beans integration: Architecture beans link to implementation beans

### Benefits

- **Better architecture decisions**: Gemini 3 Pro INCREDIBLE at system design
- **Strategic oversight**: Catches architectural violations during implementation
- **Token optimization**: Gemini handles strategy, Claude handles code
- **Graceful fallback**: Works without Gemini (Claude does everything)

### Migration

- Old approach: Gemini verified after Claude planned
- New approach: Gemini architects before Claude implements

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
