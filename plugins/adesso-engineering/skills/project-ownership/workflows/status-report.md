# Status Report Workflow

<objective>
Provide a comprehensive overview of adesso CMS development progress,
including component parity, quality metrics, and upcoming work.
</objective>

<process>
## Step 1: Gather Metrics

```bash
# Count components
COMP_DIR="/Users/marc.philipps/Sites/adesso-cms/web/themes/custom/adesso_cms_theme/components"
TOTAL=$(ls -d "$COMP_DIR"/*/ 2>/dev/null | wc -l)
echo "Total components: $TOTAL"

# Count with stories
WITH_STORY=$(find "$COMP_DIR" -name "*.stories.js" | wc -l)
echo "With Storybook: $WITH_STORY"

# Count with schema
WITH_SCHEMA=$(find "$COMP_DIR" -name "*.component.yml" | wc -l)
echo "With Schema: $WITH_SCHEMA"
```

## Step 2: Calculate Parity

Reference: Quartz has ~60+ components across categories

Current coverage:
- Atoms: X/15
- Molecules: X/14
- Organisms: X/7
- Search: X/9
- Sections: X/15
- Regions: X/3

## Step 3: Check Recent Activity

```bash
# Recent component changes
cd /Users/marc.philipps/Sites/adesso-cms
git log --oneline -20 --all -- "web/themes/custom/adesso_cms_theme/components/"
```

## Step 4: Review Jira Status

Direct user to check:
- Board: https://adesso-app-mgt.atlassian.net/jira/software/projects/DS/boards/186
- In Progress items
- Blocked items
- Recently completed

## Step 5: Generate Status Report

```markdown
# adesso CMS Status Report

**Date**: [DATE]
**Reporter**: Claude (project-ownership skill)

---

## Executive Summary

[1-2 sentence overview of current state]

## Metrics

### Component Inventory
| Metric | Count | Target | % |
|--------|-------|--------|---|
| Total Components | X | 60 | X% |
| With Storybook | X | X | X% |
| With Schema | X | X | X% |
| Quality Passing | X | X | X% |

### Feature Parity (vs Quartz)
| Category | adesso | Quartz | Gap |
|----------|--------|--------|-----|
| Atoms | X | 15 | X |
| Molecules | X | 14 | X |
| Organisms | X | 7 | X |
| Search | X | 9 | X |
| **Total** | X | 60+ | X |

## Progress This Period

### Completed
- [List completed items]

### In Progress
- [List active work]

### Blocked
- [List blockers and needed actions]

## Upcoming Priorities

1. [Priority 1]
2. [Priority 2]
3. [Priority 3]

## Risks & Issues

| Risk | Impact | Mitigation |
|------|--------|------------|
| ... | ... | ... |

## Recommendations

1. [Recommendation 1]
2. [Recommendation 2]

---

*Next status review: [DATE]*
```
</process>

<success_criteria>
- Current metrics captured
- Progress clearly communicated
- Blockers identified
- Priorities stated
- Actionable recommendations made
</success_criteria>
