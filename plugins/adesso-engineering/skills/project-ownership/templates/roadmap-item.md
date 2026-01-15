# Roadmap Item Template

## Standard Format

```markdown
| Priority | Component | Category | Status | Jira | Effort | Dependencies | Notes |
|----------|-----------|----------|--------|------|--------|--------------|-------|
| P1 | [name] | [atom/molecule/organism] | [status] | DS-XXX | [S/M/L] | [deps] | [notes] |
```

## Status Values

- **Planned** - In roadmap, not started
- **In Progress** - Active development
- **Review** - In code review
- **Testing** - QA/testing phase
- **Done** - Completed and merged
- **Blocked** - Waiting on dependency
- **Deferred** - Postponed to later phase

## Priority Levels

- **P1** - Critical path, blocks other work
- **P2** - High value, should do soon
- **P3** - Medium value, nice to have
- **P4** - Low priority, future consideration

## Detailed Item Format

```markdown
### [Component Name]

**Priority**: P1 | P2 | P3 | P4
**Category**: Atom | Molecule | Organism | Section | Region
**Status**: Planned | In Progress | Done
**Jira**: DS-XXX (link)

#### Description
[What this component does and why it's needed]

#### Business Value
[How this helps users/editors]

#### Quartz Reference
[Link to Quartz Storybook if applicable]

#### Dependencies
- [Component 1]
- [Component 2]

#### Effort Estimate
- Size: S/M/L/XL
- Complexity: Low/Medium/High
- Team: [who will work on it]

#### Target Phase
Phase 1 | Phase 2 | Phase 3 | Phase 4

#### Notes
[Any additional context]
```

## Phase Template

```markdown
## Phase X: [Name] (Target: [Quarter/Date])

### Goals
- [Goal 1]
- [Goal 2]

### Components

| Priority | Component | Status | Effort | Owner |
|----------|-----------|--------|--------|-------|
| P1 | ... | ... | ... | ... |

### Dependencies
- [External dependency 1]
- [Technical prerequisite 1]

### Risks
- [Risk 1]: [Mitigation]

### Success Criteria
- [ ] [Measurable outcome]
```
