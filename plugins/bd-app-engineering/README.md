# BD-App Engineering Plugin

AI-powered development toolkit for the BD-App platform - a Laravel 12 + React 19 + Inertia.js application for audit automation.

## Tech Stack

| Layer | Technology |
|-------|------------|
| **Backend** | Laravel 12, PHP 8.4, Spatie Data DTOs |
| **Frontend** | React 19, Inertia.js, shadcn/ui, TypeScript, Tailwind v4 |
| **Real-Time** | Laravel Reverb, Laravel Echo |
| **Worker** | Node.js, Claude Agent SDK |
| **Database** | PostgreSQL, Redis |
| **Testing** | PHPUnit, Playwright |

## Components

- **30 Agents** - Code review, research, workflow, design, BD-App specialists
- **19 Commands** - `/bd-plan`, `/bd-review`, `/bd-work`, `/bd-compound`, and more
- **15 Skills** - Laravel patterns, Inertia.js, Spatie Data, Claude Agent SDK
- **4 MCP Servers** - Playwright, Context7, shadcn, Laravel Boost (optional)

## MCP Servers

### Always Active

These MCP servers work immediately:

| Server | Purpose |
|--------|---------|
| **playwright** | E2E testing, browser automation |
| **context7** | Framework documentation lookup |
| **shadcn** | UI component discovery & installation |

### Optional: Laravel Boost

Laravel Boost provides Laravel-specific tools (schema inspection, tinker, docs search).

**Prerequisites:**
```bash
# In your Laravel project
ddev composer require laravel/boost --dev
ddev exec php artisan boost:install
```

**Activate in Claude Code:**
```bash
# For DDEV projects
claude mcp add -s local -t stdio laravel-boost ddev exec php artisan boost:mcp

# For non-DDEV projects
claude mcp add -s local -t stdio laravel-boost php artisan boost:mcp
```

## Installation

The plugin is available in the adessocms-marketplace:

```bash
# Via marketplace (when published)
claude plugins install adessocms-marketplace/bd-app-engineering

# Or local development
claude --plugin-dir ~/.claude/plugins/marketplaces/adessocms-marketplace/plugins/bd-app-engineering
```

## Core Workflows

### `/bd-plan` - Feature Planning
Transform feature ideas into structured GitHub issues with research and acceptance criteria.

### `/bd-review` - Code Review
Multi-agent code review with Laravel, React, Security, Performance specialists.

### `/bd-work` - Execute Plans
Systematically execute plans with task tracking and quality checks.

### `/bd-compound` - Knowledge Capture
Document solved problems to compound team knowledge.

## Agent Categories

### Review Agents (12)
- `laravel-reviewer` - Laravel best practices
- `react-inertia-reviewer` - React + Inertia patterns
- `typescript-react-reviewer` - TypeScript code review
- `laravel-security-sentinel` - Security vulnerability scanning
- `laravel-performance-oracle` - Performance optimization
- `eloquent-data-guardian` - Database integrity
- And more...

### Specialists (6)
- `inertia-specialist` - Inertia.js patterns
- `spatie-data-reviewer` - Spatie Data DTOs
- `laravel-reverb-specialist` - WebSocket patterns
- `claude-agent-sdk-specialist` - Agent SDK development
- `redis-pubsub-specialist` - Redis communication
- `audit-agent-developer` - BD-App audit agents

### Research Agents (4)
- `laravel-react-docs-researcher` - Documentation lookup
- `best-practices-researcher` - Best practices
- `git-history-analyzer` - Git analysis
- `repo-research-analyst` - Repository analysis

### Workflow Agents (4)
- `bd-app-bug-validator` - Bug reproduction
- `bd-app-lint` - PHP + TypeScript linting
- `pr-comment-resolver` - PR comment resolution
- `spec-flow-analyzer` - Specification analysis

### Design Agents (2)
- `shadcn-implementation-reviewer` - shadcn/ui implementation
- `design-iterator` - Design refinement

## Skills

### BD-App Specific
- `bd-app-architecture` - Architecture reference
- `inertia-patterns` - Inertia.js best practices
- `spatie-data-patterns` - Spatie Data DTOs
- `laravel-reverb-patterns` - WebSocket patterns
- `claude-agent-sdk` - Agent SDK development

### Development Standards
- `laravel-style` - Laravel coding standards
- `typescript-react-style` - React + TypeScript standards
- `tailwind-patterns` - Tailwind CSS v4
- `testing-patterns` - PHPUnit + Playwright
- `database-patterns` - PostgreSQL + Eloquent

## License

MIT
