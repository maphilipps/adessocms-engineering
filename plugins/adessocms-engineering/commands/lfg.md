---
name: lfg
description: Full autonomous engineering workflow - from plan to PR with video demonstration
argument-hint: "[feature description or JIRA ticket]"
---

# /lfg - Let's F***ing Go! (Full Autonomous Workflow)

Complete autonomous workflow from feature description to PR with video demonstration.

## Prerequisites

⚠️ **Requires external `ralph-loop` plugin for autonomous loop control**

## Workflow Sequence

```
1. /plan "$ARGUMENTS"           → Strategic planning with research
2. /deepen-plan                 → Add implementation details
3. /work                        → Systematic implementation
4. /review                      → Parallel specialist review
5. /resolve-todo-parallel       → Fix all findings
6. /compound                    → Document learnings
7. /playwright-test             → E2E verification
8. /feature-video               → Record demo for PR
9. Create PR with video         → Ship it!
```

## Phase 1: Planning

```
Skill(skill: "adessocms-engineering:workflows:plan", args: "$ARGUMENTS")
```

Research and create structured implementation plan.

## Phase 2: Deepen Plan

```
Skill(skill: "adessocms-engineering:deepen-plan")
```

Add implementation details, edge cases, test scenarios.

## Phase 3: Implementation

```
Skill(skill: "adessocms-engineering:workflows:work")
```

Execute the plan systematically with TodoWrite tracking.

## Phase 4: Review

```
Skill(skill: "adessocms-engineering:workflows:review")
```

Launch parallel specialist reviews.

## Phase 5: Resolve Findings

```
Skill(skill: "adessocms-engineering:resolve-todo-parallel")
```

Fix all review findings in parallel.

## Phase 6: Document Learnings

```
Skill(skill: "adessocms-engineering:compound")
```

Document solved problems and patterns in `docs/solutions/`.

## Phase 7: E2E Testing

```
Skill(skill: "adessocms-engineering:playwright-test")
```

Run Playwright E2E tests to verify functionality.

## Phase 8: Feature Video

```
Skill(skill: "adessocms-engineering:feature-video")
```

Record video demonstration of the feature.

## Phase 9: Create PR

Create PR with:
- Summary of changes
- Link to original ticket/description
- Embedded or linked feature video
- Test results

## Autonomous Mode

When used with ralph-loop plugin:

```
/ralph-loop "Complete the following workflow" --completion-promise "DONE"
  1. /lfg "$FEATURE_DESCRIPTION"
  2. Output <promise>DONE</promise> when PR is created
```

## Manual Mode

Can also be executed step-by-step with user approval at each phase.

## Exit Conditions

The workflow completes when:
- ✅ All tests pass (phpunit, playwright)
- ✅ All review findings resolved
- ✅ Feature video recorded
- ✅ PR created and ready for review

## Failure Handling

If any phase fails:
1. Log the failure in work log
2. Attempt to fix automatically
3. If unable to fix, pause and ask for guidance
4. Resume from failed phase after resolution
