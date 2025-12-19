---
name: bd-work
description: Execute work plans efficiently while maintaining quality and finishing features
allowed-tools: ["Read", "Write", "Edit", "Glob", "Grep", "Bash", "Task", "TodoWrite", "AskUserQuestion"]
argument-hint: "[plan file path or 'continue' to resume]"
---

# BD-Work: Plan Execution Workflow

You are executing a structured implementation plan for a Laravel 12 + React 19 + Inertia.js application. Work systematically, maintain quality, and finish what you start.

## Execution Principles

1. **Follow the plan** - Execute steps in order unless blocked
2. **Track progress** - Use TodoWrite extensively
3. **Quality gates** - Run tests after each phase
4. **Commit often** - Small, logical commits
5. **Ask when blocked** - Don't guess, clarify

## Workflow

### 1. Load Plan

If plan file provided, read it. Otherwise, check for:
- `docs/plans/*.md` - Saved plans
- Recent `/bd-plan` output
- GitHub issue with implementation details

### 2. Initialize Progress

Create todos from plan steps:
```
- [ ] Phase 1: Backend
  - [ ] Create migration
  - [ ] Create model
  - [ ] Create Spatie DTO
  - [ ] Create controller
- [ ] Phase 2: Frontend
  ...
```

### 3. Execute Each Step

For each step:

1. **Mark as in_progress**
2. **Implement** following BD-App conventions:
   - Laravel: PSR-12, Laravel conventions
   - TypeScript: Strict mode, functional components
   - Inertia: Props via Spatie Data DTOs
3. **Verify** the implementation works
4. **Mark as completed**
5. **Commit** if logical checkpoint

### 4. Quality Gates

After each phase:

**Backend Phase:**
```bash
ddev exec ./vendor/bin/phpstan analyse
ddev exec ./vendor/bin/phpunit
```

**Frontend Phase:**
```bash
npm run typecheck
npm run lint
```

**Integration:**
```bash
npm run test:e2e
```

### 5. Handle Blockers

If blocked:
1. Document the blocker
2. Ask user for clarification
3. Note any assumptions made
4. Continue with unblocked items if possible

### 6. Completion

When all steps done:
1. Run full test suite
2. Update documentation if needed
3. Prepare commit message
4. Optionally run `/bd-review` on changes

## BD-App Conventions

### Creating a New Feature

**1. Migration:**
```bash
ddev exec php artisan make:migration create_[table]_table
```

**2. Model:**
```bash
ddev exec php artisan make:model [Name]
```

**3. Spatie Data DTO:**
Create in `app/Data/` with proper typing

**4. Controller:**
Return `Inertia::render()` with DTO props

**5. Inertia Page:**
Create in `resources/js/Pages/` with TypeScript

**6. Tests:**
- PHPUnit for backend
- Playwright for E2E

## Output

Progress updates via TodoWrite, commits at logical checkpoints, and a completion summary.
