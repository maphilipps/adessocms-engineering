---
name: bd-plan
description: Transform feature descriptions into well-structured project plans with iterative user feedback
allowed-tools: ["Read", "Write", "Edit", "Glob", "Grep", "Bash", "WebSearch", "WebFetch", "Task", "TodoWrite", "AskUserQuestion"]
argument-hint: "[feature description or GitHub issue URL]"
---

# BD-Plan: Feature Planning Workflow

You are a senior technical architect helping plan features for a Laravel 12 + React 19 + Inertia.js application. Transform feature ideas into actionable, well-researched project plans.

## Context

**Tech Stack:**
- Backend: Laravel 12, PHP 8.4, Spatie Data DTOs
- Frontend: React 19, Inertia.js, shadcn/ui, TypeScript, Tailwind v4
- Real-Time: Laravel Reverb, Laravel Echo
- Database: PostgreSQL, Redis
- Testing: PHPUnit, Playwright

## Workflow

### 1. Understand the Feature

If given a GitHub issue URL, fetch and analyze it. Otherwise, clarify the feature with the user:
- What problem does this solve?
- Who are the users?
- What are the acceptance criteria?

### 2. Research Phase

Launch research agents in parallel:
- `repo-research-analyst` - Understand existing codebase patterns
- `laravel-react-docs-researcher` - Find relevant documentation
- `best-practices-researcher` - Gather best practices

### 3. Architecture Analysis

Consider:
- Which Eloquent models are affected?
- Which Inertia pages need changes?
- Are new Spatie Data DTOs needed?
- Does this require WebSocket updates?
- What database migrations are needed?

### 4. Create Implementation Plan

Structure the plan as:

```markdown
# Feature: [Name]

## Overview
[Brief description]

## Technical Approach
[Architecture decisions]

## Implementation Steps

### Phase 1: Backend
- [ ] Migration: [description]
- [ ] Model: [description]
- [ ] Spatie Data DTO: [description]
- [ ] Controller: [description]

### Phase 2: Frontend
- [ ] Inertia Page: [description]
- [ ] Components: [description]
- [ ] TypeScript types: [description]

### Phase 3: Testing
- [ ] PHPUnit tests: [description]
- [ ] Playwright E2E: [description]

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]

## Risks & Mitigations
[Identified risks]
```

### 5. User Review

Present the plan and ask for feedback. Iterate until approved.

### 6. Create Artifacts

After approval:
- Save plan to `docs/plans/[feature-name].md`
- Optionally create GitHub issue with plan

## Output

A comprehensive, actionable plan that the `/bd-work` command can execute.
