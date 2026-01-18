# Changelog

All notable changes to the fullstack-ai plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-01-18

### Added

- **`/lfg` command** - Re-enabled `/deepen-plan` step for comprehensive research before implementation
  - Provides deep analysis of requirements and technical approaches
  - Enhances plans with parallel research agents
  - Note: Token-intensive; users can skip by using `/workflows:plan` + `/workflows:work` directly

### Changed

- **Model Optimization** - Optimized agent model usage for cost efficiency (23 agents total)
  - **6 agents on Opus** (complex reasoning): `kieran-typescript-reviewer`, `architecture-strategist`, `security-sentinel`, `data-integrity-guardian`, `agent-native-reviewer`, `design-iterator`
  - **12 agents on Sonnet** (balanced): `nextjs-reviewer`, `julik-frontend-races-reviewer`, `performance-oracle`, `pattern-recognition-specialist`, `data-migration-expert`, `deployment-verification-agent`, `git-history-analyzer`, `framework-docs-researcher`, `best-practices-researcher`, `design-implementation-reviewer`, `figma-design-sync`, `spec-flow-analyzer`
  - **5 agents on Haiku** (fast & efficient): `code-simplicity-reviewer`, `lint`, `pr-comment-resolver`, `bug-reproduction-validator`, `repo-research-analyst`

- **`/workflows:review`** - Updated agent references for Next.js/TypeScript stack
  - Replaced non-existent Rails agents (`kieran-rails-reviewer`, `dhh-rails-reviewer`, `rails-turbo-expert`, `dependency-detective`, `code-philosopher`, `devops-harmony-analyst`)
  - Now uses: `kieran-typescript-reviewer`, `nextjs-reviewer`, `julik-frontend-races-reviewer`, `git-history-analyzer`, `pattern-recognition-specialist`, `architecture-strategist`, `security-sentinel`, `performance-oracle`, `data-integrity-guardian`, `agent-native-reviewer`, `code-simplicity-reviewer`

- **`/plan_review`** - Updated to use TypeScript/Next.js review agents
  - Now uses: `kieran-typescript-reviewer`, `nextjs-reviewer`, `architecture-strategist`, `code-simplicity-reviewer`, `agent-native-reviewer`

### Fixed

- Corrected agent count in documentation (23 agents, not 24)
- Removed all references to non-existent Rails-specific agents
- Updated specialist table in CLAUDE.md to include `julik-frontend-races-reviewer`

## [1.0.0] - 2025-01-15

### Added

#### MCP Servers (6)
- `ai-elements` - AI SDK component documentation and examples (https://registry.ai-sdk.dev/api/mcp)
- `shadcn` - ShadCN UI component management (`npx shadcn@latest mcp`)
- `agent-browser` - Vercel browser automation (`npx agent-browser`)
- `next-devtools` - Next.js dev server integration (`npx next-devtools-mcp@latest`)
- `chrome-devtools` - Chrome debugging and performance analysis (`npx chrome-devtools-mcp@latest`)
- `context7` - Library documentation lookup (https://mcp.context7.com/mcp)

#### Agents
- `nextjs-reviewer` - Next.js App Router patterns and best practices review

#### Skills
- `nextjs-frontend` - Next.js App Router, Server Components, ShadCN, Tailwind
- `ai-backend` - AI SDK backend integration (streaming, tools, RAG)
- `ai-elements` - Vercel AI Elements for chat interfaces
- `github` - GitHub CLI for PRs, issues, actions, releases

### Changed

- Forked from compound-engineering v2.26.3
- Restructured for Next.js/ShadCN/AI-SDK stack
- Updated `/lfg` command to skip deepen-plan step (too token intensive)
- Made `agent-native-reviewer` MANDATORY in all reviews
- Updated all agent references from `compound-engineering:` to `fullstack-ai:`

### Removed

#### Agents (Rails/Ruby specific)
- `dhh-rails-reviewer`
- `kieran-rails-reviewer`
- `kieran-python-reviewer`
- `every-style-editor`
- `ankane-readme-writer`

#### Skills (Rails/Ruby specific)
- `andrew-kane-gem-writer`
- `dhh-rails-style`
- `dspy-ruby`
- `every-style-editor`

### Summary

- 23 agents
- 23 commands
- 14 skills
- 6 MCP servers

### Technical Details

- Based on compound-engineering plugin architecture
- Maintains agent-native architecture principles
- Supports autonomous workflows with ralph-loop plugin
- Comprehensive TypeScript/Next.js tooling
- Full integration with Vercel development ecosystem
