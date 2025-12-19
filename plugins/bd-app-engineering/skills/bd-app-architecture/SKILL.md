---
name: BD-App Architecture
description: Use this skill when working on the BD-App project to understand the architecture, conventions, and patterns. Triggers for architecture questions, implementation guidance, or when onboarding to the project.
version: 1.0.0
---

# BD-App Architecture Reference

This skill provides comprehensive knowledge of the BD-App platform architecture for audit automation.

## Tech Stack Overview

| Layer | Technology | Purpose |
|-------|------------|---------|
| Backend | Laravel 12, PHP 8.4 | API, Business Logic, Queue |
| Frontend | React 19, TypeScript | User Interface |
| Bridge | Inertia.js | SPA without REST API |
| UI | shadcn/ui, Tailwind v4 | Component Library |
| Real-Time | Laravel Reverb, Echo | WebSocket Communication |
| Worker | Node.js, Claude SDK | AI Agent Execution |
| Database | PostgreSQL | Primary Data Store |
| Cache/Queue | Redis | Queues, Pub/Sub, Cache |

## Core Architecture Principle

**No REST API** - Data flows through Inertia.js:

```
User Action → Inertia Request → Laravel Controller
                                      ↓
                              Inertia::render()
                                      ↓
                              Spatie Data DTO
                                      ↓
React Page ← Inertia Response ← Page Props
```

## Directory Structure

```
bd-app/
├── app/
│   ├── Actions/           # Single-purpose operations
│   │   ├── Agents/        # Agent-related actions
│   │   └── Projects/      # Project operations
│   ├── Data/              # Spatie Data DTOs
│   │   └── Sections/      # Report section DTOs
│   ├── Events/            # Broadcast events
│   ├── Http/Controllers/  # Inertia controllers
│   ├── Jobs/              # Queue jobs
│   ├── Models/            # Eloquent models
│   │   └── Sections/      # Section models
│   └── Services/          # Business logic
├── resources/js/
│   ├── Pages/             # Inertia pages
│   ├── Components/        # React components
│   │   ├── ui/            # shadcn/ui
│   │   └── Report/        # Report-specific
│   └── types/             # TypeScript types
├── worker/                # Node.js Agent Worker
│   └── src/
│       ├── agents/        # Agent configs
│       ├── tools/         # Agent tools
│       └── schemas/       # Zod output schemas
└── database/migrations/
```

## Agent Workflow

### Phases
1. **Qualification** - Lead qualification
2. **Research** - Company, market, competitor analysis
3. **Audit** - Technical audits (tech stack, performance, a11y, SEO, content)
4. **Evaluation** - CMS recommendation, effort, TCO, team, migration plan
5. **Output** - PDF export

### Communication Flow
```
Laravel Job → Redis LPUSH → Node.js Worker
                              ↓
                         Claude SDK
                              ↓
Laravel Job ← Redis LPUSH ← Result
     ↓
Spatie Data DTO → Database
     ↓
Broadcast Event → Laravel Echo → React reload
```

## Key Conventions

### Controllers
- Return `Inertia::render()` with Spatie Data DTOs
- Use Form Requests for validation
- Keep thin - delegate to Actions/Services

### Forms
- Use Inertia `useForm` hook
- Submit via `router.post/put/delete`
- Handle errors from `errors` prop

### Real-Time Updates
- Events implement `ShouldBroadcast`
- Use private channels for auth data
- React uses Echo + `router.reload({ only: [...] })`

### Testing
- PHPUnit for backend
- Playwright for E2E
- Test Spatie Data transformations

## Documentation

- Architecture: `/ARCHITECTURE.md`
- Data Model: `/docs/DATENMODELL.md`
- Agent Configs: `/worker/src/agents/`
