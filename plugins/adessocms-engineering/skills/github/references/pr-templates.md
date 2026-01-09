# Pull Request Templates Reference

## Standard Template

`.github/pull_request_template.md`:

```markdown
## Summary

Brief description of what this PR does.

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

## Multiple Templates

Speichere verschiedene Templates in `.github/PULL_REQUEST_TEMPLATE/`:

### feature.md

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

### API Changes

- [ ] New endpoints added
- [ ] Existing endpoints modified
- [ ] No API changes

## Testing

### How to Test

1. Step 1
2. Step 2
3. Expected result

## Dependencies

- Requires PR #XX to be merged first

## Deployment Notes

Special instructions for deployment.
```

### bug.md

```markdown
## Bug Fix

### Original Issue

Fixes #

### Root Cause

Description of what was causing the bug.

### Solution

Description of how it was fixed.

## Reproduction Steps (Before)

1. Step 1
2. Step 2
3. Bug appears

## Verification Steps (After)

1. Step 1
2. Step 2
3. Bug is gone ✓

## Tests

- [ ] Added test that reproduces the bug
- [ ] Test passes with fix

## Risk Assessment

- [ ] Low risk - isolated change
- [ ] Medium risk - affects multiple areas
- [ ] High risk - core functionality
```

### hotfix.md

```markdown
## 🚨 HOTFIX

### Severity

- [ ] Critical - Production down
- [ ] High - Major functionality broken
- [ ] Medium - Significant but not blocking

### Problem

What is broken in production.

### Fix

What this PR changes to fix it.

### Testing Done

- [ ] Tested locally
- [ ] Tested on staging

### Deployment

- [ ] Can be deployed immediately
- [ ] Requires database migration
- [ ] Requires config change

### Reviewers

Urgent review needed from: @lead

### Rollback Plan

If issues occur after deployment:
1. Revert this PR
2. Run rollback script
```

---

## Template mit Queryliste

Um ein Template zu verlinken:

```
https://github.com/owner/repo/compare/main...branch?template=bug.md
```

---

## Automatische Labels

Mit GitHub Actions:

```yaml
# .github/workflows/pr-labeler.yml
name: PR Labeler

on:
  pull_request:
    types: [opened]

jobs:
  label:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/labeler@v4
        with:
          repo-token: ${{ secrets.GITHUB_TOKEN }}
```

```yaml
# .github/labeler.yml
frontend:
  - 'web/themes/**'
  - '**/*.css'
  - '**/*.js'

backend:
  - 'web/modules/**'
  - '**/*.php'
```
