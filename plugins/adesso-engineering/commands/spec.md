---
name: spec
description: Interview-driven specification creation with in-depth questions to fully define features
argument-hint: "[SPEC.md path or feature description]"
---

# /spec - Interview-Based Specification Creation

Create comprehensive specifications through deep questioning and iterative refinement.

## Purpose

Transform vague feature requests into detailed, implementable specifications by:
1. Asking probing questions that go beyond the obvious
2. Identifying edge cases and error scenarios
3. Clarifying technical implementation details
4. Documenting decisions and rationale

## Workflow

### Phase 1: Initial Understanding

Read existing SPEC.md if provided, or gather initial requirements.

```markdown
## Current Understanding

**Feature**: [Name]
**Goal**: [What should it accomplish?]
**Users**: [Who benefits?]
**Success Criteria**: [How do we know it works?]
```

### Phase 2: Deep Interview

Use AskUserQuestion for systematic questioning:

#### User Experience Questions
- "What happens when the user is offline during this action?"
- "Should there be an undo/rollback capability? How many steps?"
- "What feedback does the user see during processing?"
- "How does this behave on mobile vs desktop?"

#### Technical Questions
- "What happens to in-progress data if the session expires?"
- "Should this work for anonymous users or only authenticated?"
- "Are there rate limits or quotas to consider?"
- "How should errors be logged and monitored?"

#### Edge Cases
- "What if the user submits the form twice quickly?"
- "How do we handle partial failures in multi-step processes?"
- "What's the maximum data size we need to support?"
- "How should concurrent edits be handled?"

#### Integration Questions
- "Does this need to integrate with external services?"
- "What cache invalidation is required?"
- "Are there SEO implications?"
- "How does this affect existing features?"

### Phase 3: Specification Document

Create comprehensive SPEC.md:

```markdown
# Feature Specification: [Name]

## Overview
[2-3 sentence summary]

## Background
[Why this feature is needed, business context]

## User Stories
- As a [role], I want [goal] so that [benefit]
- As a [role], I want [goal] so that [benefit]

## Functional Requirements

### Core Functionality
1. [Requirement 1]
2. [Requirement 2]

### User Interface
- [UI element 1]: [behavior]
- [UI element 2]: [behavior]

### Error Handling
| Error Condition | User Message | System Action |
|-----------------|--------------|---------------|
| [Error 1] | [Message] | [Action] |

## Technical Specifications

### Data Model
[Entity definitions, field types, relationships]

### API Endpoints
| Method | Path | Description |
|--------|------|-------------|
| POST | /api/... | [Description] |

### Permissions
| Role | Can View | Can Edit | Can Delete |
|------|----------|----------|------------|
| Anonymous | ❌ | ❌ | ❌ |
| Authenticated | ✅ | ❌ | ❌ |
| Admin | ✅ | ✅ | ✅ |

## Edge Cases & Decisions

### [Decision 1]
**Question**: [What was the question?]
**Decision**: [What did we decide?]
**Rationale**: [Why?]

## Out of Scope
- [Thing explicitly not included]
- [Future consideration]

## Testing Requirements
- [ ] Unit tests for [component]
- [ ] Integration tests for [workflow]
- [ ] E2E tests for [user journey]
- [ ] Accessibility audit

## Open Questions
- [ ] [Question still needing answer]
```

### Phase 4: Validation

Review spec with user for completeness:
- All user stories covered?
- Edge cases documented?
- Technical approach clear?
- Out of scope defined?

## Question Categories

| Category | Focus |
|----------|-------|
| **UX** | User journey, feedback, accessibility |
| **Technical** | Architecture, performance, security |
| **Edge Cases** | Failures, limits, concurrency |
| **Integration** | External systems, caching, SEO |
| **Business** | Priorities, constraints, timeline |

## Output

Creates or updates:
- `SPEC.md` in current directory or specified path
- Ready for `/plan` to create implementation plan

## Best Practices

1. **Ask non-obvious questions** - Don't ask what's already clear
2. **Probe deeper** - "What if..." and "How should..."
3. **Document decisions** - Record the "why" not just the "what"
4. **Identify unknowns** - Mark open questions clearly
5. **Stay focused** - Don't scope creep during spec phase
