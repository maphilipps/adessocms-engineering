---
name: plan
description: Transform feature descriptions into structured implementation plans using parallel research agents
argument-hint: "[feature description or JIRA ticket]"
---

# /plan - Strategic Planning Workflow

Transform ideas and feature descriptions into detailed, actionable implementation plans.

## Workflow

### Phase 1: Research (Parallel)

Launch these research agents IN PARALLEL to gather context:

```
Task(subagent_type: "adessocms-engineering:research:repo-research-analyst")
  → Analyze codebase for existing patterns, conventions, similar implementations

Task(subagent_type: "adessocms-engineering:research:best-practices-researcher") 
  → Research external best practices for this type of feature

Task(subagent_type: "adessocms-engineering:research:framework-docs-researcher")
  → Look up relevant Drupal/framework documentation
```

### Phase 2: Design Consultation (If UI/UX involved)

```
Task(subagent_type: "adessocms-engineering:specialists:design-system-guardian")
  → Check design tokens, ensure consistency

Task(subagent_type: "adessocms-engineering:specialists:component-reuse-specialist")
  → Identify existing components to reuse
```

### Phase 3: Plan Synthesis

Based on research findings, create a structured plan:

```markdown
## Implementation Plan: [Feature Name]

### Overview
[Brief description of what we're building]

### Research Findings
- **Codebase Patterns**: [Key findings from repo-research-analyst]
- **Best Practices**: [External guidance from best-practices-researcher]
- **Framework Docs**: [Relevant documentation]

### Technical Approach
[High-level technical strategy]

### Tasks (Atomic)
1. [ ] Task 1 - [Description]
2. [ ] Task 2 - [Description]
...

### Files to Create/Modify
- `path/to/file.php` - [Purpose]
- `path/to/template.twig` - [Purpose]

### Dependencies
- [External dependencies]
- [Internal dependencies]

### Testing Strategy
- [ ] Unit tests for [component]
- [ ] Integration tests for [workflow]
- [ ] E2E tests with Playwright

### Risks & Mitigations
| Risk | Mitigation |
|------|------------|
| [Risk 1] | [Mitigation 1] |
```

### Phase 4: Plan Approval

Present the plan to the user for approval before proceeding to `/work`.

## Integration with /work

The plan output should be directly usable by `/work`:
- Tasks become TodoWrite items
- Files list guides implementation order
- Testing strategy informs verification steps

## Drupal-Specific Considerations

- Check `web/modules/custom/` for existing module patterns
- Review `web/themes/custom/*/components/` for SDC patterns
- Use `ddev drush cst` to check configuration status
- Consider cache tags and invalidation strategy
