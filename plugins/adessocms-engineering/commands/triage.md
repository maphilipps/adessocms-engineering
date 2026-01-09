---
name: triage
description: Process review findings one-by-one, updating status and prioritizing action items
argument-hint: "[todos directory or empty for default]"
---

# /triage - Finding Triage Workflow

Process pending findings from `/review` one-by-one, making decisions and updating status.

## Workflow

### Phase 1: Load Findings

Read all pending findings from file-todos:

```bash
# Find all pending items
grep -r "status: pending" todos/
```

Or use the file-todos skill:
```
Skill(skill: "file-todos")
```

### Phase 2: Process One-by-One

For each pending finding:

1. **Display the Finding**:
```markdown
## Finding: [Title]
- **Severity**: HIGH/MEDIUM/LOW
- **File**: `path/to/file.php:123`
- **Issue**: [Description]
- **Recommendation**: [Suggested fix]
```

2. **Ask for Decision**:
```
AskUserQuestion({
  questions: [{
    question: "How should we handle this finding?",
    header: "Triage",
    options: [
      { label: "Fix Now", description: "Address this immediately" },
      { label: "Fix Later", description: "Mark as ready for future fix" },
      { label: "Won't Fix", description: "False positive or acceptable" },
      { label: "Need Info", description: "Requires more investigation" }
    ],
    multiSelect: false
  }]
})
```

3. **Update Status**:

| Decision | New Status | Action |
|----------|------------|--------|
| Fix Now | `in_progress` | Implement fix immediately |
| Fix Later | `ready` | Add to backlog |
| Won't Fix | `wont_fix` | Document reason |
| Need Info | `blocked` | Note what's needed |

### Phase 3: Handle "Fix Now" Items

When user chooses "Fix Now":

1. Mark finding as `in_progress`
2. Navigate to the file
3. Implement the fix
4. Run relevant linting/tests
5. Mark as `completed`
6. Move to next finding

### Phase 4: Summary

After processing all findings:

```markdown
## Triage Summary

### Processed: X findings

| Status | Count |
|--------|-------|
| Completed | Y |
| Ready (backlog) | Z |
| Won't Fix | A |
| Blocked | B |

### Next Steps
- [ ] [Remaining action items]
```

## Status Flow

```
pending → in_progress → completed
       ↘ ready (backlog)
       ↘ wont_fix
       ↘ blocked
```

## File-Todos Format

```markdown
# todos/review-findings.md

## Finding 1
- **id**: finding-001
- **severity**: HIGH
- **status**: pending
- **file**: src/Service/MyService.php:45
- **issue**: Missing null check
- **recommendation**: Add null coalescing

## Finding 2
- **id**: finding-002
- **severity**: MEDIUM
- **status**: completed
- **file**: src/Controller/MyController.php:123
- **issue**: Unused variable
- **recommendation**: Remove or use
- **resolution**: Removed unused variable in commit abc123
```

## Integration

- Runs after `/review` completes
- Updates file-todos status
- Can trigger immediate fixes
- Creates backlog for deferred items

## Commands

```bash
# View all pending
grep -r "status: pending" todos/

# View by severity
grep -B2 "severity: HIGH" todos/

# Count by status
grep -c "status: completed" todos/*
```
