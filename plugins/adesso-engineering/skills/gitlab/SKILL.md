---
name: gitlab
description: |
  GitLab operations - Merge Requests, CI pipelines, issues, glab CLI.
  Automatically invoked when feature.skill = "gitlab" in Ralph Loop.
---

<essential_principles>
## GitLab Operations

### 1. glab CLI First

Use `glab` CLI for all GitLab operations:

```bash
glab mr create              # Create MR
glab mr view <id>           # View MR
glab mr list                # List MRs
glab ci status              # Pipeline status
glab ci view                # View pipeline
glab issue create           # Create issue
```

### 2. MR Workflow

1. Create feature branch
2. Push changes
3. Create MR with glab
4. Wait for pipeline
5. Request review
6. Merge after approval

### 3. Pipeline Monitoring

```bash
glab ci status              # Current status
glab ci view                # Detailed view
glab ci trace               # Live logs
```
</essential_principles>

<intake>
**What would you like to do?**

1. Create a Merge Request
2. Check pipeline status
3. Debug failing pipeline
4. Create/manage issues
5. Something else

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Workflow |
|----------|----------|
| 1, "mr", "merge request", "create" | `workflows/create-mr.md` |
| 2, "pipeline", "ci", "status" | `workflows/pipeline-status.md` |
| 3, "debug", "failing", "fix pipeline" | `workflows/debug-pipeline.md` |
| 4, "issue", "issues" | `workflows/manage-issues.md` |
| 5, other | Clarify, then select workflow |
</routing>

<reference_index>
## References

- glab-commands.md - Complete glab CLI reference
- gitlab-ci-yaml.md - Pipeline configuration
- mr-templates.md - MR description templates
</reference_index>
