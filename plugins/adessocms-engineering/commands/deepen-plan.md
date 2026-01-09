---
name: deepen-plan
description: Add implementation details, edge cases, and test scenarios to an existing plan
argument-hint: "[plan file path or empty for current plan]"
---

# /deepen-plan - Plan Enhancement Workflow

Take an existing plan from `/plan` and add detailed implementation guidance.

## Purpose

Transform high-level plans into actionable implementation guides by:
1. Adding specific file changes with code snippets
2. Identifying edge cases and error handling
3. Specifying test scenarios
4. Clarifying dependencies and order of operations

## Workflow

### Phase 1: Read Existing Plan

Load the plan created by `/plan` and identify areas needing detail.

### Phase 2: For Each Task, Add

#### Implementation Details
```markdown
### Task: [Name]

**Files to Create/Modify:**
- `web/modules/custom/mymodule/src/Service/MyService.php`
  - Add `processItem()` method
  - Inject `EntityTypeManager` dependency
  
**Code Approach:**
\`\`\`php
public function processItem(int $id): array {
  // 1. Load entity
  // 2. Validate state
  // 3. Process
  // 4. Return result
}
\`\`\`

**Edge Cases:**
- Entity not found → throw EntityNotFoundException
- Invalid state → return error array with code
- Processing timeout → implement retry with backoff

**Tests:**
- Unit: Test processItem with valid input
- Unit: Test processItem with invalid entity
- Integration: Test full workflow
```

### Phase 3: Add Sequence Diagram

For complex workflows:

```markdown
## Sequence

\`\`\`mermaid
sequenceDiagram
    participant U as User
    participant C as Controller
    participant S as Service
    participant D as Database
    
    U->>C: POST /api/process
    C->>S: processItem(id)
    S->>D: Load entity
    D-->>S: Entity data
    S->>S: Validate & process
    S-->>C: Result
    C-->>U: JSON response
\`\`\`
```

### Phase 4: Dependency Order

```markdown
## Implementation Order

1. **Database schema** (no dependencies)
   - Create migration
   - Add entity definition

2. **Service class** (depends on: 1)
   - Implement core logic
   - Add unit tests

3. **Controller** (depends on: 2)
   - Add route
   - Add form/API handling

4. **Frontend** (depends on: 3)
   - Add Twig template
   - Add Alpine.js behavior
```

### Phase 5: Risk Assessment

```markdown
## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Performance under load | Medium | High | Add caching, test with load |
| Data migration issues | Low | High | Test migration on staging copy |
| Breaking existing API | Medium | Medium | Add versioning, deprecate old |
```

### Phase 6: Test Plan

```markdown
## Test Plan

### Unit Tests
| Test | Class | Method | Assertion |
|------|-------|--------|-----------|
| Valid input | MyServiceTest | testProcessItem | Returns expected array |
| Invalid entity | MyServiceTest | testProcessItemNotFound | Throws exception |

### Integration Tests
| Test | Flow | Verification |
|------|------|--------------|
| Full workflow | User → API → DB | Entity state changes correctly |

### E2E Tests (Playwright)
| Test | Steps | Expected |
|------|-------|----------|
| Submit form | Fill form, click submit | Success message, redirect |
| Error handling | Submit invalid, see error | Error displayed, form retained |
```

## Output

Enhanced plan with:
- ✅ Specific file changes
- ✅ Code approach/snippets
- ✅ Edge case handling
- ✅ Implementation order
- ✅ Risk mitigation
- ✅ Detailed test plan

## Integration

After `/deepen-plan`:
1. Plan is ready for `/work`
2. Tasks are atomic and clear
3. Order of execution is defined
4. Tests are specified upfront
