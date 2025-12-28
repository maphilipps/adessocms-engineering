---
name: acms-work
description: Execute work plans efficiently while maintaining quality and finishing features
argument-hint: "[plan file path or task description]"
---

# Work Plan Execution Command

Execute a work plan efficiently while maintaining quality and finishing features.

## Core Principle

> **We want the simplest change possible. We don't care about migration. Code readability matters most, and we're happy to make bigger changes to achieve it.**

## Introduction

This command takes a work document (plan file or task description) and executes it systematically. The focus is on **shipping complete features** by understanding requirements quickly, following existing patterns, and maintaining quality throughout.

## Input Document

<input_document> #$ARGUMENTS </input_document>

## Execution Workflow

### Phase 1: Quick Start

1. **Read Plan and Clarify**

   - Read the work document completely
   - Review any references or links provided in the plan
   - If anything is unclear or ambiguous, ask clarifying questions NOW
   - Get user approval to proceed
   - **Do not skip this** - better to ask questions now than build the wrong thing

2. **Setup Environment**

   Choose your work style:

   **Option A: Live work on current branch**
   ```bash
   git checkout develop && git pull origin develop
   git checkout -b feature/<branch-name>
   ```

   **Option B: Parallel work with worktree (recommended for parallel development)**
   ```bash
   # Ask user first: "Work in parallel with worktree or on current branch?"
   # If worktree:
   Skill git-worktree
   ```

3. **Create Task List with TodoWrite**

   Break the plan into actionable tasks using TodoWrite:

   ```
   TodoWrite(todos=[
     {"content": "Task 1 from plan", "status": "pending", "activeForm": "Working on Task 1"},
     {"content": "Task 2 from plan", "status": "pending", "activeForm": "Working on Task 2"},
     {"content": "Write tests", "status": "pending", "activeForm": "Writing tests"},
     {"content": "Run quality checks", "status": "pending", "activeForm": "Running quality checks"}
   ])
   ```

### Phase 2: Execute

1. **Task Execution Loop**

   For each task in priority order:

   ```
   while (tasks remain):
     1. Mark task as in_progress in TodoWrite
     2. Read any referenced files from the plan
     3. Look for similar patterns in codebase
     4. Implement following existing conventions
     5. Write tests for new functionality
     6. Run tests after changes
     7. Mark task as completed in TodoWrite
   ```

2. **Follow Existing Patterns**

   - The plan should reference similar code - read those files first
   - Match naming conventions exactly
   - Reuse existing components where possible
   - Follow project coding standards (see CLAUDE.md)
   - When in doubt, grep for similar implementations

3. **Test Continuously**

   - Run relevant tests after each significant change
   - Don't wait until the end to test
   - Fix failures immediately
   - Add new tests for new functionality

4. **Figma Design Sync** (if applicable)

   For UI work with Figma designs:

   - Task figma-design-sync(component_description)

### Phase 3: Quality Check

1. **Run Core Quality Checks**

   Always run before submitting:

   ```bash
   # Run full test suite
   ddev phpunit                    # PHPUnit tests
   ddev theme test                 # Vitest/Storybook tests
   ddev exec npx playwright test   # E2E tests (if applicable)

   # Run linting
   ddev composer lint:php          # PHP coding standards
   ddev theme lint:js              # JavaScript linting
   ddev theme lint:css             # CSS/Tailwind linting
   ```

2. **Consider Reviewer Agents** (Optional)

   **Don't use by default.** Use reviewer agents only when:

   - Large refactor affecting many files (10+)
   - Security-sensitive changes (authentication, permissions, data access)
   - Performance-critical code paths
   - Complex algorithms or business logic
   - User explicitly requests thorough review

   For complex/risky changes, run in parallel:

   - Task drupal-specialist(changes)
   - Task security-sentinel(changes)
   - Task accessibility-specialist(changes)
   - Task performance-oracle(changes)

   For most features: **tests + linting + following patterns is sufficient.**

3. **Final Validation**
   - All TodoWrite tasks marked completed
   - All tests pass
   - Linting passes
   - Code follows existing patterns
   - Figma designs match (if applicable)
   - No console errors or warnings

### Phase 4: Ship It

1. **Create Commit**

   ```bash
   git add .
   git status  # Review what's being committed
   git diff --staged  # Check the changes

   # Commit with conventional format
   git commit -m "$(cat <<'EOF'
   feat(scope): description of what and why

   Brief explanation if needed.

   Co-Authored-By: Claude <noreply@anthropic.com>
   EOF
   )"
   ```

2. **Capture Screenshots for UI Changes** (if applicable)

   For any design changes, use **Claude in Chrome**:

   ```
   mcp__claude-in-chrome__tabs_context_mcp
   mcp__claude-in-chrome__resize_window(width=320, height=568, tabId=<tab_id>)  # Mobile
   mcp__claude-in-chrome__navigate(url="https://...", tabId=<tab_id>)
   mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)
   ```

   **Fallback (only if Claude in Chrome unavailable):** Use Playwright MCP

   Upload screenshots:
   ```bash
   curl -F "file=@screenshot.png" https://0x0.st
   ```

3. **Create Pull Request**

   ```bash
   git push -u origin feature/<branch-name>

   gh pr create --title "Feature: [Description]" --body "$(cat <<'EOF'
   ## Summary
   - What was built
   - Why it was needed

   ## Testing
   - Tests added/modified
   - Manual testing performed

   ## Screenshots
   [If applicable]

   Co-Authored-By: Claude <noreply@anthropic.com>
   EOF
   )"
   ```

4. **Notify User**
   - Summarize what was completed
   - Link to PR
   - Note any follow-up work needed

---

## Key Principles

### Start Fast, Execute Faster

- Get clarification once at the start, then execute
- Don't wait for perfect understanding - ask questions and move
- The goal is to **finish the feature**, not create perfect process

### The Plan is Your Guide

- Work documents should reference similar code and patterns
- Load those references and follow them
- Don't reinvent - match what exists

### Test As You Go

- Run tests after each change, not at the end
- Fix failures immediately
- Continuous testing prevents big surprises

### Quality is Built In

- Follow existing patterns
- Write tests for new code
- Run linting before pushing
- Use reviewer agents for complex/risky changes **only**

### Ship Complete Features

- Mark all TodoWrite tasks completed before moving on
- Don't leave features 80% done
- A finished feature that ships beats a perfect feature that doesn't

## Quality Checklist

Before creating PR, verify:

- [ ] All clarifying questions asked and answered
- [ ] All TodoWrite tasks marked completed
- [ ] Tests pass (`ddev phpunit`, `ddev theme test`)
- [ ] Linting passes (`ddev composer lint:php`)
- [ ] Code follows existing patterns
- [ ] Figma designs match implementation (if applicable)
- [ ] Screenshots captured and uploaded (for UI changes)
- [ ] Commit messages follow conventional format
- [ ] PR description includes summary and testing notes

## Common Pitfalls to Avoid

- **Analysis paralysis** - Don't overthink, read the plan and execute
- **Skipping clarifying questions** - Ask now, not after building wrong thing
- **Ignoring plan references** - The plan has links for a reason
- **Testing at the end** - Test continuously or suffer later
- **Forgetting TodoWrite** - Track progress or lose track of what's done
- **80% done syndrome** - Finish the feature, don't move on early
- **Over-reviewing simple changes** - Save reviewer agents for complex work
