# Merge Request Templates Reference

## Standard Template

`.gitlab/merge_request_templates/Default.md`:

```markdown
## Summary

Brief description of what this MR does.

## Changes

- Change 1
- Change 2
- Change 3

## Related Issues

Closes #

## Type of Change

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to change)
- [ ] Documentation update

## Testing

- [ ] Unit tests added/updated
- [ ] Manual testing done
- [ ] E2E tests pass

## Screenshots (if applicable)

## Checklist

- [ ] Code follows project style guidelines
- [ ] Self-review of code completed
- [ ] Documentation updated
- [ ] No new warnings generated
```

---

## Feature Template

`.gitlab/merge_request_templates/Feature.md`:

```markdown
## Feature Description

### User Story

As a [user type], I want [goal] so that [benefit].

### Acceptance Criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Implementation Details

### Files Changed

- `path/to/file.php` - Description
- `path/to/other.php` - Description

### Database Changes

- [ ] Migrations added
- [ ] No database changes

### Configuration Changes

- [ ] Config exported
- [ ] No config changes

## Testing

### Unit Tests

```bash
ddev exec phpunit --filter TestName
```

### Manual Testing Steps

1. Step 1
2. Step 2
3. Expected result

## Dependencies

- Depends on MR !XX
- Requires module `drupal/xxx`

## Deployment Notes

Special instructions for deployment (if any).
```

---

## Bug Fix Template

`.gitlab/merge_request_templates/Bug.md`:

```markdown
## Bug Description

### Original Issue

Fixes #

### Root Cause

Describe what was causing the bug.

### Solution

Describe how the bug was fixed.

## Reproduction Steps (Before Fix)

1. Step 1
2. Step 2
3. Bug appears

## Verification Steps (After Fix)

1. Step 1
2. Step 2
3. Bug is fixed ✓

## Tests Added

- [ ] Unit test that reproduces the bug
- [ ] Test passes with fix
- [ ] No regression in related functionality

## Risk Assessment

- [ ] Low - Isolated change
- [ ] Medium - Affects multiple components
- [ ] High - Core functionality change

## Rollback Plan

If issues arise, describe rollback steps.
```

---

## Hotfix Template

`.gitlab/merge_request_templates/Hotfix.md`:

```markdown
## 🚨 HOTFIX

### Severity

- [ ] Critical - Production down
- [ ] High - Major functionality broken
- [ ] Medium - Significant issue

### Issue

Brief description of the production issue.

### Fix

What was changed to fix the issue.

### Tested On

- [ ] Local
- [ ] Staging
- [ ] Production (if applicable)

### Approvers

@lead @senior-dev

### Deployment Checklist

- [ ] Notify team in Slack
- [ ] Deploy to staging
- [ ] Verify fix on staging
- [ ] Deploy to production
- [ ] Verify fix on production
- [ ] Monitor logs for issues
```

---

## Verwendung

```bash
# Interaktiv mit Template-Auswahl
glab mr create -i

# Template automatisch (wenn Default.md existiert)
glab mr create --fill
```
