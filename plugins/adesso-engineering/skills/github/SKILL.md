---
name: github
description: |
  GitHub operations - Pull Requests, Actions, issues, gh CLI.
  Automatically invoked when feature.skill = "github" in Ralph Loop.
---

<essential_principles>
## GitHub Operations

### 1. gh CLI First

Use `gh` CLI for all GitHub operations:

```bash
gh pr create                # Create PR
gh pr view <id>             # View PR
gh pr list                  # List PRs
gh run list                 # List workflow runs
gh run view <id>            # View run details
gh issue create             # Create issue
```

### 2. PR Workflow

1. Create feature branch
2. Push changes
3. Create PR with gh
4. Wait for Actions
5. Request review
6. Merge after approval

### 3. Actions Monitoring

```bash
gh run list                 # Recent runs
gh run view <id>            # Run details
gh run watch <id>           # Live status
```
</essential_principles>

<intake>
**What would you like to do?**

1. Create a Pull Request
2. Check Actions status
3. Debug failing workflow
4. Create/manage issues
5. Something else

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Workflow |
|----------|----------|
| 1, "pr", "pull request", "create" | `workflows/create-pr.md` |
| 2, "actions", "workflow", "status" | `workflows/actions-status.md` |
| 3, "debug", "failing", "fix workflow" | `workflows/debug-actions.md` |
| 4, "issue", "issues" | `workflows/manage-issues.md` |
| 5, other | Clarify, then select workflow |
</routing>

<reference_index>
## References

- gh-commands.md - Complete gh CLI reference
- github-actions.md - Actions workflow syntax
- pr-templates.md - PR description templates
</reference_index>
