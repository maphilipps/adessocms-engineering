# Changelog

All notable changes to the fullstack-ai plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
