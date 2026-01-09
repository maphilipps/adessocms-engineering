---
name: work
description: Execute implementation plans systematically with TodoWrite tracking and quality gates
argument-hint: "[plan file or task description]"
---

# /work - Systematic Implementation Workflow

Execute plans from `/plan` or implement features directly with proper tracking and quality gates.

## Workflow

### Phase 1: Setup

1. **Parse the Plan**: Extract tasks from plan file or create from description
2. **Create TodoWrite Items**: Convert all tasks to tracked todo items
3. **Setup Git Branch**: Create feature branch if not exists

```bash
git checkout -b feature/[feature-name]
```

### Phase 2: Implementation Loop

For each task in TodoWrite:

```
1. Mark task as in_progress (only ONE at a time)
2. Invoke appropriate skill based on task type:
   - PHP/Backend → Skill(skill: "drupal-backend")
   - SDC/Frontend → Skill(skill: "adessocms-frontend")
   - DevOps/CI → Skill(skill: "devops")
   - GitLab MR → Skill(skill: "gitlab")
   - GitHub PR → Skill(skill: "github")
3. Implement the change
4. Verify implementation works
5. Mark task as completed
6. Commit with meaningful message
7. Loop → next task
```

### Phase 3: Quality Gates (After Each Significant Change)

**MANDATORY: Run code-simplifier after implementation**

```
Task(subagent_type: "adessocms-engineering:specialists:code-simplifier")
  → Ensure code is minimal and simple
```

**Run linting:**
```bash
ddev exec phpcs --standard=Drupal,DrupalPractice web/modules/custom/[module]
```

### Phase 4: Verification

Before marking feature complete:

1. **Run Tests**:
```bash
ddev exec phpunit web/modules/custom/[module]/tests
```

2. **Visual Verification** (for UI changes):
```
Task(subagent_type: "adessocms-engineering:design:design-implementation-reviewer")
  → Verify UI matches design
```

3. **Cache Clear & Test**:
```bash
ddev drush cr
```

## Git Worktree Support (Optional)

For parallel feature development:

```bash
# Create worktree for feature
git worktree add ../project-feature-name feature/feature-name

# Work in worktree
cd ../project-feature-name

# Remove when done
git worktree remove ../project-feature-name
```

## TodoWrite Pattern

```javascript
TodoWrite({
  todos: [
    { content: "Create database schema", status: "completed", activeForm: "Creating database schema" },
    { content: "Implement service class", status: "in_progress", activeForm: "Implementing service class" },
    { content: "Add controller routes", status: "pending", activeForm: "Adding controller routes" },
    { content: "Write unit tests", status: "pending", activeForm: "Writing unit tests" }
  ]
})
```

## Skill Auto-Invocation

Based on file types being modified:

| Pattern | Skill |
|---------|-------|
| `.php`, `.module`, `.install` | `drupal-backend` |
| `.twig`, `*.sdc.yml` | `adessocms-frontend` |
| `composer.json`, `.ddev/` | `devops` |
| `.gitlab-ci.yml` | `gitlab` |
| `.github/workflows/` | `github` |

## Completion

When all tasks completed:
1. Run `/review` for comprehensive code review
2. Create PR/MR with summary of changes
3. Link to original plan/ticket
