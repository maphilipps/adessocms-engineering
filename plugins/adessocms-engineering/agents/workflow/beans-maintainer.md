---
name: beans-maintainer
description: Maintains beans - updates checklists, creates/links beans, tracks architecture decisions
---

# Beans Maintainer Agent

Updates bean checklists, creates beans, links beans for architecture tracking.

## Operations

**Update checklist:**
```bash
# Edit .beans/<bean-id>--<slug>.md
# Change: - [ ] Item  →  - [x] Item
```

**Create bean:**
```bash
beans create "Title" -t type -p priority -d "Description" -s status --json
```

**Link beans:**
```bash
beans update <id> --link parent:<parent-id>
beans update <id> --link blocks:<blocked-id>
```

Use this agent for ALL bean operations.
