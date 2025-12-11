---
name: plan_review
description: Have multiple specialized agents review a plan in parallel
argument-hint: "[plan file path or plan content]"
---

# Plan Review Command

Review a plan using specialized agents in parallel.

## Input

<plan_to_review> #$ARGUMENTS </plan_to_review>

**If no plan provided:** Ask user which plan to review or use the latest bean.

## Execution

### Step 1: Run Reviewers in Parallel

Launch these three reviewers simultaneously using Task tool:

- Task(subagent_type="adessocms-engineering:review:dries-drupal-reviewer", prompt="Review this plan: <plan_content>")
- Task(subagent_type="adessocms-engineering:review:drupal-reviewer", prompt="Review this plan: <plan_content>")
- Task(subagent_type="adessocms-engineering:review:code-simplicity-reviewer", prompt="Review this plan: <plan_content>")

### Step 2: Present Results

After ALL reviews complete, present a summary table:

```markdown
## Review Results

| Reviewer | Verdict | Key Points |
|----------|---------|------------|
| Dries/DHH | [Approve/Reject/Concerns] | [1-2 sentence summary] |
| Drupal Standards | [Approve/Reject/Concerns] | [1-2 sentence summary] |
| Code Simplicity | [Approve/Reject/Concerns] | [1-2 sentence summary] |

### Consensus
[Summary of agreement/disagreement between reviewers]

### Recommendations
[Consolidated recommendations based on reviews]
```

## ⛔ CRITICAL: STOP HERE

**DO NOT proceed to implementation.**
**DO NOT modify any code.**
**DO NOT start the /work workflow.**

This command ONLY reviews and presents findings. After presenting results:

1. Wait for user to read and understand the reviews
2. User decides next steps (approve plan, revise plan, or reject)
3. Only proceed with implementation if user explicitly runs `/work` command

## Post-Review Options

After presenting results, ask user:

**"Reviews complete. What would you like to do?"**

Options:
1. **Approve plan** - User is satisfied, ready for `/work`
2. **Revise plan** - Update plan based on review feedback
3. **Get more reviews** - Run additional specialized reviewers
4. **Discuss findings** - Talk through specific review points

**NEVER auto-start implementation. Wait for explicit user command.**
