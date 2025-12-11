---
name: plan
description: Transform feature descriptions into well-structured project plans following conventions
argument-hint: "[feature description, bug report, or improvement idea]"
---

# Create a plan for a new feature or bug fix

**Note: The current year is 2025.**

## Feature Description

<feature_description> #$ARGUMENTS </feature_description>

**If the feature description above is empty, ask the user:** "What would you like to plan? Please describe the feature, bug fix, or improvement you have in mind."

Do not proceed until you have a clear feature description from the user.

---

## Execution: Single Agent Orchestration

**Invoke the Plan Triage Agent** which will:
1. Classify task complexity (TRIVIAL / SIMPLE / COMPLEX)
2. For TRIVIAL: Return execution commands directly
3. For SIMPLE: Create minimal plan directly
4. For COMPLEX: Spawn research agents, synthesize findings, create comprehensive plan

```
Task(subagent_type="adessocms-engineering:workflow:plan-triage",
     model="opus",
     prompt="Plan this task: {feature_description}

     Context from CLAUDE.md:
     - DDEV-first development (all commands via ddev)
     - Drupal 10 project
     - Custom modules in web/modules/custom/
     - Theme: eab_2024 with Vite/TailwindCSS/Alpine.js

     Your job:
     1. Classify as TRIVIAL, SIMPLE, or COMPLEX
     2. Act accordingly:
        - TRIVIAL: Return ddev commands to execute
        - SIMPLE: Create minimal checklist plan
        - COMPLEX: Spawn research agents in parallel, then create comprehensive plan

     For COMPLEX tasks, spawn these agents IN PARALLEL:
     - adessocms-engineering:research:repo-research-analyst
     - adessocms-engineering:research:best-practices-researcher
     - adessocms-engineering:research:framework-docs-researcher

     Then synthesize findings into a plan at plans/<slug>.md and open in Typora.")
```

---

## What the Triage Agent Handles

### TRIVIAL Tasks (No Plan Needed)
- Module installation/enabling
- Cache operations
- Config export/import
- Simple drush commands
- Obvious syntax fixes

**Result:** Direct execution commands returned

### SIMPLE Tasks (Minimal Plan)
- Field additions to content types
- View creation
- Template updates
- Form modifications
- Menu/routing changes

**Result:** Quick checklist created directly by triage agent

### COMPLEX Tasks (Full Research)
- External integrations (APIs, SSO, payment)
- Security-sensitive features
- Architectural changes
- Data migrations
- Custom module development
- Multi-component features

**Result:** Research agents spawned, comprehensive plan created

---

## Post-Plan Options

After the triage agent completes, it will present options:

1. **Start `/work`** - Begin implementing
2. **Run `/plan_review`** - Get feedback from reviewers
3. **Create Issue** - Create in GitHub/Linear
4. **Simplify** - Reduce detail level

---

**IMPORTANT:** This command delegates ALL work to the plan-triage agent. Do not manually invoke research agents.
