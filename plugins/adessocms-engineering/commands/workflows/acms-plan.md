---
name: acms-plan
description: Transform feature descriptions into well-structured project plans with iterative user feedback
argument-hint: "[feature description, bug report, or improvement idea]"
---

# Create Implementation Plan (Interactive)

Transform feature descriptions, bug reports, or improvement ideas into well-structured, reviewable project plans **through iterative collaboration**.

## About This Command

This command creates a **documented implementation plan** saved to `plans/<slug>.md` through **step-by-step collaboration**. Each phase is presented for feedback before proceeding.

> ⚠️ **Do not use `EnterPlanMode` tool!**
> This command writes a Markdown plan file. Never call the `EnterPlanMode` tool.
> Always write the plan to `plans/<slug>.md` using the Write tool.

**Workflow Ecosystem:**

```
/acms-plan  →  /plan_review  →  /acms-work  →  /acms-review  →  /acms-compound
   ↓              ↓               ↓              ↓               ↓
 Create      Get feedback    Implement      Review PR      Document
  plan       from agents      the plan       changes       learnings
```

**Note:** This command writes a Markdown file - it does NOT use Claude's `EnterPlanMode` tool. The output is always a `plans/<slug>.md` file that can be reviewed, edited, and tracked in version control.

---

## Input

<feature_description> #$ARGUMENTS </feature_description>

**If empty:** Ask the user what they want to plan. Do not proceed without a clear feature description.

---

## Interactive Planning Process

### Phase 1: Understand the Task → GET FEEDBACK

**Analyze what's being asked:**

1. What is the core feature/fix being requested?
2. What Drupal components are involved? (modules, entities, fields, views, etc.)
3. Are there external systems or integrations?
4. What is the expected user outcome?

**Present understanding to user:**

```
AskUserQuestion(questions=[{
  "question": "Here's my understanding of the task: [SUMMARY]. Is this correct?",
  "header": "Scope",
  "options": [
    {"label": "Yes, proceed", "description": "Understanding is correct"},
    {"label": "Needs adjustment", "description": "I'll provide corrections"}
  ],
  "multiSelect": false
}])
```

**STOP and wait for user confirmation before proceeding.**

### Phase 2: Research & DRY Analysis → GET FEEDBACK

**Search for existing solutions:**

```bash
# Find existing SDC components
find web/themes/custom -name "*.component.yml" -exec basename {} .component.yml \;

# Search by keyword in components
grep -rl "keyword" web/themes/custom/*/components/

# Check similar implementations
grep -r "similar_pattern" web/modules/custom/
```

**Consult specialists in parallel:**

```
Task(subagent_type="adessocms-engineering:specialists:drupal-specialist", prompt="Pattern for: {task}?")
Task(subagent_type="adessocms-engineering:specialists:sdc-specialist", prompt="Structure for: {component}?")
```

**Present findings to user:**

```markdown
## Research Findings

### Existing Components Found
- `my_theme:button` - Could be reused for [purpose]
- `my_theme:card` - Needs new variant for [purpose]

### Similar Implementations
- `web/modules/custom/example/` - Uses pattern X

### Specialist Recommendations
- Drupal: [recommendation]
- SDC: [recommendation]

### DRY Assessment
- Reuse: [components to leverage]
- Extend: [variants to add]
- Create: [new components needed, with justification]
```

```
AskUserQuestion(questions=[{
  "question": "Do these findings look correct? Should I investigate anything else?",
  "header": "Research",
  "options": [
    {"label": "Looks good", "description": "Proceed with technical approach"},
    {"label": "Investigate more", "description": "I'll specify what to research"},
    {"label": "Adjust findings", "description": "I'll provide corrections"}
  ],
  "multiSelect": false
}])
```

**STOP and wait for user feedback before proceeding.**

### Phase 3: Technical Approach → GET FEEDBACK

**Based on research, propose the technical approach:**

```markdown
## Proposed Technical Approach

### Architecture Decision
[High-level approach and why]

### Implementation Strategy
1. [Step 1 - what and why]
2. [Step 2 - what and why]
3. [Step 3 - what and why]

### Files to Create/Modify
| File | Action | Purpose |
|------|--------|---------|
| `path/to/file` | Create/Modify | [why] |

### Risks & Considerations
- [Risk 1] - Mitigation: [approach]
- [Risk 2] - Mitigation: [approach]
```

```
AskUserQuestion(questions=[{
  "question": "Does this technical approach make sense? Any concerns?",
  "header": "Approach",
  "options": [
    {"label": "Approved", "description": "Proceed to detailed steps"},
    {"label": "Need changes", "description": "I'll specify adjustments"},
    {"label": "Alternative approach", "description": "Let's discuss other options"}
  ],
  "multiSelect": false
}])
```

**STOP and wait for user approval before proceeding.**

### Phase 4: Detailed Implementation Steps → GET FEEDBACK

**Break down into specific, actionable steps:**

```markdown
## Implementation Steps

### Phase 1: [Name] (estimated: X files)
- [ ] Step 1.1 - [specific action with file path]
- [ ] Step 1.2 - [specific action with file path]
- [ ] Step 1.3 - Write tests for [functionality]

### Phase 2: [Name] (estimated: X files)
- [ ] Step 2.1 - [specific action with file path]
- [ ] Step 2.2 - [specific action with file path]
- [ ] Step 2.3 - Write tests for [functionality]

### Phase 3: Quality & Polish
- [ ] Run all tests
- [ ] Accessibility verification
- [ ] Code review preparation
```

```
AskUserQuestion(questions=[{
  "question": "Are these implementation steps clear and complete?",
  "header": "Steps",
  "options": [
    {"label": "Looks complete", "description": "Proceed to acceptance criteria"},
    {"label": "Add more detail", "description": "I'll specify what needs expansion"},
    {"label": "Reorder steps", "description": "I'll suggest a different sequence"}
  ],
  "multiSelect": false
}])
```

**STOP and wait for user feedback before proceeding.**

### Phase 5: Acceptance Criteria → GET FEEDBACK

**Define how we know when it's done:**

```markdown
## Acceptance Criteria

### Functional Requirements
- [ ] [Specific, testable criterion]
- [ ] [Specific, testable criterion]

### Quality Requirements
- [ ] All existing tests still pass
- [ ] New functionality has test coverage
- [ ] Accessibility verified (WCAG 2.1 AA)
- [ ] No console errors or warnings

### User Experience
- [ ] [UX criterion if applicable]
```

```
AskUserQuestion(questions=[{
  "question": "Are these acceptance criteria sufficient?",
  "header": "Criteria",
  "options": [
    {"label": "Complete", "description": "Write the final plan"},
    {"label": "Add criteria", "description": "I'll specify what's missing"},
    {"label": "Adjust criteria", "description": "I'll provide changes"}
  ],
  "multiSelect": false
}])
```

**STOP and wait for user approval before writing the final plan.**

### Phase 6: Write Final Plan

**Only after all phases are approved, create the plan file at `plans/<slug>.md`:**

```markdown
---
date: YYYY-MM-DD
feature: [Short feature name]
status: draft
---

# [feat|fix|refactor]: [Feature Title]

## Summary

[2-3 sentence description of what will be built/fixed and WHY]

## Research Findings

### Existing Codebase Patterns
[Relevant patterns found in repo - be specific with file paths]

### External Research
[Key findings from web research, documentation, etc.]

### Specialist Guidance
[Summary of specialist recommendations]

## Technical Approach

[How we will implement this - based on research findings]

## Component Reuse Analysis (DRY)

### Existing Components to Leverage
| Component | Usage | Notes |
|-----------|-------|-------|
| `my_theme:button` | Primary CTA | Existing variant sufficient |
| `my_theme:heading` | Section titles | Add 'feature' variant |

### New Components Required
| Component | Justification | Expected Uses |
|-----------|---------------|---------------|
| `my_theme:feature-icon` | No existing icon component | 5+ locations |

### Variants to Add
- `heading`: Add 'feature' variant for feature headers
- `button`: Add 'outline' variant for secondary actions

## Implementation Steps

### Phase 1: [Phase Name]
- [ ] Step 1 - [specific action]
- [ ] Step 2 - [specific action]
- [ ] Step 3 - [specific action]

### Phase 2: [Phase Name]
- [ ] Step 1 - [specific action]
- [ ] Step 2 - [specific action]

## Files to Modify/Create

| File | Action | Description |
|------|--------|-------------|
| `path/to/file.php` | Modify | Add new service method |
| `path/to/new.twig` | Create | New template for feature |

## Acceptance Criteria

- [ ] [Specific, testable criterion]
- [ ] [Specific, testable criterion]
- [ ] All tests pass
- [ ] Accessibility verified (WCAG 2.1 AA)

## Testing Strategy

- [ ] Unit tests for [specific functionality]
- [ ] Integration tests for [specific flows]
- [ ] E2E tests for [specific user journeys]
- [ ] Storybook stories for [components]

## Recommended Agents for Implementation

### Core Agents
| Agent | When to Use | Task Syntax |
|-------|-------------|-------------|
| [e.g., Oracle] | [e.g., If stuck after 3 attempts] | `Task(subagent_type="adessocms-engineering:core:oracle", prompt="...")` |

### Specialist Agents
| Agent | When to Use | Task Syntax |
|-------|-------------|-------------|
| [e.g., drupal-specialist] | [e.g., For Drupal API patterns] | `Task(subagent_type="adessocms-engineering:specialists:drupal-specialist", prompt="...")` |
| [e.g., sdc-specialist] | [e.g., For SDC component structure] | `Task(subagent_type="adessocms-engineering:specialists:sdc-specialist", prompt="...")` |
| [e.g., accessibility-specialist] | [e.g., For WCAG compliance checks] | `Task(subagent_type="adessocms-engineering:specialists:accessibility-specialist", prompt="...")` |

### Research Agents
| Agent | When to Use | Task Syntax |
|-------|-------------|-------------|
| [e.g., framework-docs-researcher] | [e.g., For Drupal/Tailwind docs] | `Task(subagent_type="adessocms-engineering:research:framework-docs-researcher", prompt="...")` |

> **Note:** Use `/acms-work` to execute this plan. It will automatically consult the recommended agents during implementation.

## References

- [Relevant documentation links]
- [Similar implementations in codebase]
```

### Phase 7: Open and Offer Next Steps

**After writing the plan:**

```bash
open -a Typora "plans/<slug>.md"
```

**Present options to user:**

```
AskUserQuestion(questions=[{
  "question": "Plan created! What would you like to do next?",
  "header": "Next",
  "options": [
    {"label": "Agent Review", "description": "Run /plan_review for specialist feedback"},
    {"label": "Start Work", "description": "Run /acms-work to implement"},
    {"label": "Create Issue", "description": "Create GitHub/Linear issue"},
    {"label": "Done for now", "description": "Review plan later"}
  ],
  "multiSelect": false
}])
```

---

## Specialist Selection Guide

| Task Type | Specialist | Purpose |
|-----------|------------|---------|
| Drupal modules/services | `drupal-specialist` | API patterns, DI, caching |
| SDC components | `sdc-specialist` | Props vs slots, schemas |
| Twig templates | `twig-specialist` | Attributes, translations |
| Tailwind styling | `tailwind-specialist` | v4 syntax, responsive |
| Accessibility | `accessibility-specialist` | WCAG compliance |
| Security-sensitive | `security-sentinel` | Auth, input handling |
| Paragraphs | `paragraphs-specialist` | Field templates, SDC integration |
| Architecture | `architecture-strategist` | System design decisions |

**Usage:** Use the full Task syntax with subagent_type:
```
Task(subagent_type="adessocms-engineering:specialists:drupal-specialist", prompt="Your question here")
```

The `subagent_type` format is: `plugin-name:agent-category:agent-name`

---

## Interactive Flow Summary

```
┌─────────────────────────────────────────────────────────────────┐
│  Phase 1: Understand Task                                       │
│  → Present summary → GET FEEDBACK → Adjust if needed            │
├─────────────────────────────────────────────────────────────────┤
│  Phase 2: Research & DRY Analysis                               │
│  → Search codebase → Consult specialists → Present findings     │
│  → GET FEEDBACK → Investigate more if needed                    │
├─────────────────────────────────────────────────────────────────┤
│  Phase 3: Technical Approach                                    │
│  → Propose architecture → Files to change → Risks               │
│  → GET FEEDBACK → Adjust approach if needed                     │
├─────────────────────────────────────────────────────────────────┤
│  Phase 4: Implementation Steps                                  │
│  → Detailed steps → Estimates → Dependencies                    │
│  → GET FEEDBACK → Add detail if needed                          │
├─────────────────────────────────────────────────────────────────┤
│  Phase 5: Acceptance Criteria                                   │
│  → Define done → Quality requirements → UX criteria             │
│  → GET FEEDBACK → Adjust criteria if needed                     │
├─────────────────────────────────────────────────────────────────┤
│  Phase 6: Write Plan                                            │
│  → Create plans/<slug>.md with all approved content             │
├─────────────────────────────────────────────────────────────────┤
│  Phase 7: Next Steps                                            │
│  → Open in Typora → Offer /plan_review, /acms-work, etc.        │
└─────────────────────────────────────────────────────────────────┘
```

---

## Common Pitfalls to Avoid

- **Rushing through phases** - Each feedback point is valuable, don't skip them
- **Skipping DRY analysis** - Always check for existing components first
- **Not consulting specialists** - Get guidance before designing complex patterns
- **Vague acceptance criteria** - Make them specific and testable
- **Missing file list** - Be explicit about what will be created/modified
- **Forgetting testing strategy** - Include tests in the plan from the start
- **Over-engineering** - Plan for what's needed, not hypothetical future needs
- **Ignoring user feedback** - Adjust the plan based on each feedback round
