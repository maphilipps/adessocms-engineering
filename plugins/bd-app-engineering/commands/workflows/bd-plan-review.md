---
name: bd-plan-review
description: Review implementation plans with specialized agents based on plan content
allowed-tools: ["Read", "Glob", "Grep", "Task", "TodoWrite"]
argument-hint: "[plan file path or plan content]"
---

# Plan Review: Multi-Agent Analysis

You are reviewing an implementation plan for a Laravel 12 + React 19 + Inertia.js application. Analyze the plan content and select appropriate reviewers.

## Plan Analysis

First, read and understand the plan:
1. What features/changes are proposed?
2. Which layers are affected? (Backend, Frontend, Database, API)
3. What technologies are involved?

## Agent Selection

Based on plan content, select appropriate reviewers:

### Always Include
- `code-simplicity-reviewer` - Is this over-engineered? YAGNI check

### If Plan Involves Backend/Laravel
- `taylor-otwell-reviewer` - Is this "the Laravel way"?
- `laravel-security-sentinel` - Security implications

### If Plan Involves Frontend/React
- `react-inertia-reviewer` - Inertia patterns correct?
- `typescript-react-reviewer` - Type safety considerations

### If Plan Involves Data Layer
- `spatie-data-reviewer` - DTO design review

### If Plan Involves UI Components
- `shadcn-implementation-reviewer` - Component selection

## Execution

1. **Read the plan** to understand scope
2. **Categorize by domain**:
   - Backend changes → Laravel reviewers
   - Frontend changes → React reviewers
   - Database/Models → Data reviewers
3. **Launch selected agents in parallel** using Task tool
4. **Synthesize feedback** into actionable recommendations

## Review Criteria

Each reviewer should assess:

### Feasibility
- Can this be implemented as described?
- Are there technical blockers?

### Simplicity
- Is this the simplest approach?
- Are we over-engineering?

### Best Practices
- Does it follow Laravel/React conventions?
- Are there better patterns?

### Risks
- Security concerns?
- Performance implications?
- Maintenance burden?

### Missing Elements
- What's not covered but should be?
- Edge cases not considered?

## Output Format

```markdown
# Plan Review Results

## Summary
- Plan: [name/description]
- Reviewers consulted: [list]
- Overall assessment: ✅ Approve / ⚠️ Needs Changes / ❌ Rethink

## Strengths
- [What's good about this plan]

## Concerns

### Critical ❌
[Must address before implementation]

### Important ⚠️
[Should address]

### Suggestions 💡
[Nice to have improvements]

## Recommended Changes
1. [Specific change with rationale]
2. [Another change]

## Questions for Clarification
- [Anything unclear in the plan]
```

## Post-Review

After presenting findings:
- "Should I update the plan with these recommendations?"
- "Do you want me to proceed with implementation using /bd-work?"
