---
name: work
description: Execute work plans efficiently while maintaining quality and finishing features
argument-hint: "[plan file, specification, or todo file path]"
---

# Work Plan Execution Command

Execute a work plan efficiently while maintaining quality and finishing features.

## Introduction

This command takes a work document (plan, specification, or todo file) and executes it systematically. The focus is on **shipping complete features** by understanding requirements quickly, following existing patterns, and maintaining quality throughout.

## Input Document

<input_document> #$ARGUMENTS </input_document>

## Execution Workflow

### Phase 1: Quick Start

1. **Read Plan and Clarify**

   - Read the work document completely
   - Review any references or links provided in the plan
   - If anything is unclear or ambiguous, ask clarifying questions now
   - Get user approval to proceed
   - **Do not skip this** - better to ask questions now than build the wrong thing

2. **Setup Environment**

   Choose your work style:

   **Option A: Live work on current branch**
   ```bash
   git checkout main && git pull origin main
   git checkout -b feature-branch-name
   ```

   **Option B: Parallel work with worktree (recommended for parallel development)**
   ```bash
   # Ask user first: "Work in parallel with worktree or on current branch?"
   # If worktree:
   skill: git-worktree
   # The skill will create a new branch from main in an isolated worktree
   ```

   **Recommendation**: Use worktree if:
   - You want to work on multiple features simultaneously
   - You want to keep main clean while experimenting
   - You plan to switch between branches frequently

   Use live branch if:
   - You're working on a single feature
   - You prefer staying in the main repository

3. **Create/Load Task List**

   **If input is a Bean ID (e.g., `adesso-cms-xxxx`):**
   ```bash
   # Load the bean and mark as in-progress
   beans show <bean-id> --json
   beans update <bean-id> --status in-progress
   ```
   The bean's checklist becomes your task list.

   **If input is a plan file:**
   - Transfer plan to Beans using beans-maintainer (haiku):
     ```
     Task(subagent_type="adessocms-engineering:workflow:beans-maintainer",
          model="haiku",
          prompt="Create bean from plan file: <plan-file>.md

          Type: feature
          Priority: normal
          Status: in-progress

          Return bean ID.")
     ```
   - Then load the created bean as your task list

   **Fallback (no Beans):**
   - Use TodoWrite to break plan into actionable tasks
   - Include dependencies between tasks
   - Prioritize based on what needs to be done first
   - Include testing and quality check tasks
   - Keep tasks specific and completable

### Phase 2: Execute

1. **Task Execution Loop**

   For each task in priority order:

   ```
   while (tasks remain):
     - If using Beans: Check off item in bean markdown file
     - If using TodoWrite: Mark task as in_progress
     - Read any referenced files from the plan
     - Look for similar patterns in codebase
     - Implement following existing conventions
     - Write tests for new functionality
     - Run tests after changes
     - Mark task as completed (update bean file or TodoWrite)
   ```

   **Bean Checklist Updates:**
   When completing a checklist item in a Bean, edit the bean file directly:
   ```bash
   # Change from:  - [ ] Task description
   # To:           - [x] Task description
   ```
   Commit bean file changes alongside code changes.

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

   - Implement components following design specs
   - Use figma-design-sync agent iteratively to compare
   - Fix visual differences identified
   - Repeat until implementation matches design

5. **Track Progress**

   **If using Beans:**
   - Update bean checklist by editing the markdown file
   - For blockers, create a new bean and link with `--link blocks:<bean-id>`
   - For scope expansion, create child beans with `--link parent:<current-bean-id>`
   - Keep user informed of major milestones

   **If using TodoWrite:**
   - Keep TodoWrite updated as you complete tasks
   - Note any blockers or unexpected discoveries
   - Create new tasks if scope expands
   - Keep user informed of major milestones

### Phase 3: Quality Check

1. **Run Core Quality Checks**

   Always run before submitting:

   ```bash
   # Run full test suite
   ddev phpunit                    # PHPUnit tests
   ddev theme test                 # Vitest/Storybook tests
   ddev playwright test            # E2E tests

   # Run linting (per CLAUDE.md)
   ddev phpcs                      # PHP coding standards
   ddev eslint                     # JavaScript linting
   ddev stylelint                  # CSS/Tailwind linting
   ```

2. **Consider Reviewer Agents** (Optional)

   Use for complex, risky, or large changes:

   - **code-simplicity-reviewer**: Check for unnecessary complexity
   - **drupal-reviewer**: Verify Drupal coding standards and best practices
   - **dries-drupal-reviewer**: Brutally honest Drupal review
   - **twig-template-reviewer**: Verify Twig templates and SDC patterns
   - **drupal-theme-reviewer**: Theme implementations and libraries
   - **tailwind-reviewer**: Tailwind CSS v4 best practices
   - **accessibility-reviewer**: WCAG 2.1 Level AA compliance
   - **security-sentinel**: Scan for security vulnerabilities
   - **test-coverage-reviewer**: Review test quality and coverage

   Run reviewers in parallel with Task tool:

   ```
   Task(code-simplicity-reviewer): "Review changes for simplicity"
   Task(drupal-reviewer): "Check Drupal coding standards"
   Task(twig-template-reviewer): "Review Twig templates"
   ```

   Present findings to user and address critical issues.

3. **Final Validation**
   - All tasks marked completed (Bean checklist or TodoWrite)
   - If using Beans: `beans update <bean-id> --status completed`
   - All tests pass
   - Linting passes
   - Code follows existing patterns
   - Figma designs match (if applicable)
   - No console errors or warnings

### Phase 3: Strategic Oversight (Gemini 3 Pro)

**Gemini provides strategic checkpoints during implementation:**

#### Checkpoint 1: Foundation (25% complete)

After models/basic structure:

```bash
if which gemini >/dev/null 2>&1; then
  Skill(skill="adessocms-engineering:gemini-coauthor")
  # Select: Strategic Checkpoint
fi
```

Gemini verifies:
- Architecture alignment
- Technology choices respected
- No architectural violations

**If violations:** STOP, fix before continuing

#### Checkpoint 2: Core Logic (50% complete)

After business logic implemented:

```bash
Skill(skill="adessocms-engineering:gemini-coauthor")
# Strategic Checkpoint
```

Gemini checks:
- Trade-offs being respected
- Performance concerns
- Security considerations

#### Checkpoint 3: Integration (75% complete)

After frontend/integration:

```bash
Skill(skill="adessocms-engineering:gemini-coauthor")
# Strategic Checkpoint
```

Gemini validates:
- System coherence
- Integration points
- Technical debt level

#### Final Validation (100% complete)

Before creating PR:

```bash
Skill(skill="adessocms-engineering:gemini-coauthor")
# Architecture Validation (option 3)
```

Gemini provides:
- Compliance score (0-100%)
- Go/No-Go decision
- Critical issues (if any)
- Technical debt assessment

**Results:**
- ✅ 90-100%: Approved, proceed
- ⚠️ 70-89%: Approved with concerns, create follow-up beans
- ❌ <70%: Rejected, fix critical issues

**If Gemini unavailable:** Claude does self-validation (less strategic)

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

   🤖 Generated with [Claude Code](https://claude.com/claude-code)

   Co-Authored-By: Claude <noreply@anthropic.com>
   EOF
   )"
   ```

2. **Capture Screenshots for UI Changes** (if applicable)

   For any design changes, new views, or UI modifications:

   ```bash
   # Start the dev server if not already running
   ddev theme dev  # Vite HMR server

   # Use Playwright to take screenshots at mobile width (320px)
   # Navigate to relevant pages and capture before/after states
   ```

   Using Playwright MCP tools:
   - `browser_resize` to set mobile viewport (320x568 or similar)
   - `browser_navigate` to go to affected pages
   - `browser_snapshot` to check page state
   - `browser_take_screenshot` to capture images

   Then upload screenshots using the imgup skill:
   ```bash
   # Upload to 0x0.st (recommended, no API key needed)
   curl -F "file=@screenshot-before.png" https://0x0.st
   curl -F "file=@screenshot-after.png" https://0x0.st
   ```

   Include the URLs in your PR description.

3. **Create Pull Request**

   ```bash
   git push -u origin feature-branch-name

   gh pr create --title "Feature: [Description]" --body "$(cat <<'EOF'
   ## Summary
   - What was built
   - Why it was needed
   - Key decisions made

   ## Testing
   - Tests added/modified
   - Manual testing performed

   ## Before / After Screenshots
   | Before | After |
   |--------|-------|
   | ![before](URL) | ![after](URL) |

   ## Figma Design
   [Link if applicable]

   🤖 Generated with [Claude Code](https://claude.com/claude-code)
   EOF
   )"
   ```

4. **Notify User**
   - Summarize what was completed
   - Link to PR
   - Note any follow-up work needed
   - Suggest next steps if applicable

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
- Use reviewer agents for complex/risky changes only

### Ship Complete Features

- Mark all tasks completed before moving on
- Don't leave features 80% done
- A finished feature that ships beats a perfect feature that doesn't

## Quality Checklist

Before creating PR, verify:

- [ ] All clarifying questions asked and answered
- [ ] All TodoWrite tasks marked completed
- [ ] Tests pass (run `ddev phpunit`, `ddev theme test`)
- [ ] Linting passes (run `ddev phpcs`, `ddev eslint`, `ddev stylelint`)
- [ ] Code follows existing patterns
- [ ] Figma designs match implementation (if applicable)
- [ ] Before/after screenshots captured and uploaded (for UI changes)
- [ ] Commit messages follow conventional format
- [ ] PR description includes summary, testing notes, and screenshots

## When to Use Reviewer Agents

**Don't use by default.** Use reviewer agents only when:

- Large refactor affecting many files (10+)
- Security-sensitive changes (authentication, permissions, data access)
- Performance-critical code paths
- Complex algorithms or business logic
- User explicitly requests thorough review

For most features: tests + linting + following patterns is sufficient.

## Common Pitfalls to Avoid

- **Analysis paralysis** - Don't overthink, read the plan and execute
- **Skipping clarifying questions** - Ask now, not after building wrong thing
- **Ignoring plan references** - The plan has links for a reason
- **Testing at the end** - Test continuously or suffer later
- **Forgetting TodoWrite** - Track progress or lose track of what's done
- **80% done syndrome** - Finish the feature, don't move on early
- **Over-reviewing simple changes** - Save reviewer agents for complex work
