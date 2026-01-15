# Changelog

All notable changes to the adesso-engineering plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-15

### Initial Release - Drupal Engineering Specialization

Complete migration from compound-engineering (Rails-focused) to adesso-engineering (Drupal-focused).

### Added

**New Agent Categories:**
- **Core Agents (6):** `frontend-engineer`, `librarian`, `document-writer`, `reviewer-selector`, `skill-invoker`, `gemini-frontend`
- **Drupal Specialists (17):** Domain experts for Drupal development
  - Core: `drupal-specialist`, `drupal-theme-specialist`, `paragraphs-specialist`
  - Frontend: `twig-specialist`, `sdc-specialist`, `tailwind-specialist`, `storybook-specialist`
  - Quality: `accessibility-specialist`, `test-coverage-specialist`
  - Architecture: `component-reuse-specialist`, `architecture-strategist`, `agent-native-reviewer`
  - Data: `composer-specialist`, `data-integrity-guardian`
  - Security/Performance: `security-sentinel`, `performance-oracle`
  - Design: `design-system-guardian`

**New Meta-Skills (Domain Expertise Pattern):**
- `adessocms-frontend` - SDC, Tailwind v4, Twig, Alpine.js (15 files)
- `drupal-backend` - Entities, Services, Plugins, Config, Migrations (20 files)
- `devops` - DDEV, Composer, CI/CD, Docker (9 files)
- `github` - gh CLI, PRs, Actions (8 files)
- `gitlab` - glab CLI, MRs, Pipelines (8 files)

**New Specialized Skills:**
- `adesso-styleguide` - adesso corporate design compliance
- `ivangrynenko-cursorrules-drupal` - Drupal security patterns (OWASP)
- `create-drupal-case-study` - Drupal.org case study generation
- `landing-page-optimizer` - AIDA framework conversion patterns
- `plan-from-jira` - Jira ticket integration
- `project-ownership` - Product ownership patterns
- `skill-guardian` - Skill governance and auditing
- `generate-user-handbook` - User documentation generation

**New Commands:**
- `/init` - Initialize Drupal project with DDEV
- `/spec` - Interview-based specification creation
- `/prime` - Prepare context for development
- `/playwright-test` - Run Playwright E2E tests
- `/create-drupal-case-study` - Generate Drupal case studies
- `/plan-from-jira` - Create plans from Jira tickets
- Image generation commands (7): flat-illustration, gradient-mesh, isometric-3d, line-art, realistic-photo, watercolor, user-handbook

**New MCP Servers:**
- `exa` - AI-powered web search for Drupal research
- `grep` - GitHub code search for module examples
- `tailwindplus` - TailwindCSS component browser

### Removed

**Rails/Generic Agents:**
- `deployment-verification-agent` (Rails schema migrations)
- `dhh-rails-reviewer` (37signals/DHH philosophy)
- `kieran-rails-reviewer` (Rails conventions)
- `kieran-python-reviewer` (Python domain)
- `kieran-typescript-reviewer` (TypeScript domain)
- `julik-frontend-races-reviewer` (Stimulus.js races)
- `ankane-readme-writer` (Ruby gem READMEs)
- `every-style-editor` (Every.to style)

**Rails/Generic Skills:**
- `agent-browser` (Vercel CLI)
- `andrew-kane-gem-writer` (Ruby gems)
- `dhh-rails-style` (Rails style)
- `dspy-ruby` (Ruby LLM patterns)
- `every-style-editor` (Every.to blog style)
- `frontend-design` (Generic UI)
- `git-worktree` (Generic git)
- `rclone` (S3 upload)
- `skill-creator` (Generic skill creation)

**Platform-Specific Commands:**
- `/test-browser` (Vercel-specific)
- `/xcode-test` (iOS-specific)
- `/agent-native-audit` (Generic)
- `/plan_review` (Duplicate)

### Changed

**Retained & Enhanced:**
- Review Agents (3): `code-simplicity-reviewer`, `data-migration-expert`, `pattern-recognition-specialist`
- Research Agents (4): `repo-research-analyst`, `best-practices-researcher`, `framework-docs-researcher`, `git-history-analyzer`
- Design Agents (3): `design-iterator`, `design-implementation-reviewer`, `figma-design-sync`
- Workflow Agents (4): `bug-reproduction-validator`, `lint`, `pr-comment-resolver`, `spec-flow-analyzer`

**Utility Skills (5):**
- `agent-native-architecture` - AI agent patterns
- `compound-docs` - Knowledge documentation
- `create-agent-skills` - Skill creation guidance
- `file-todos` - File-based todo tracking
- `gemini-imagegen` - Image generation

### Summary

- **37 agents** (6 core + 17 specialists + 3 review + 4 research + 3 design + 4 workflow)
- **32 commands** (4 workflow + 6 Drupal + 13 utility + 7 image + 2 docs)
- **18 skills** (5 meta + 8 specialized + 5 utility)
- **4 MCP servers** (context7, exa, grep, tailwindplus)

---

## Migration Notes

This plugin is a complete domain specialization of compound-engineering for Drupal 11 development at adesso SE.

**Key Architecture Changes:**
1. Replaced language-specific reviewers (Rails, Python, TypeScript) with domain specialists (Drupal, Twig, SDC, etc.)
2. Added Meta-Skill Domain Expertise Pattern with router-based skills containing workflows/ and references/
3. Restructured agents into core/, specialists/, review/, research/, design/, workflow/
4. Added auto-invoke rules for skills based on file types

**Migration from adessocms-engineering:**
- Imported 17 specialist agents
- Imported 6 core meta-agents
- Imported 13 Drupal-specific skills
- Imported 13 Drupal-specific commands
- Added 3 additional MCP servers
