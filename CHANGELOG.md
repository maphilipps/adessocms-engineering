# Changelog

All notable changes to the adessocms-engineering plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
