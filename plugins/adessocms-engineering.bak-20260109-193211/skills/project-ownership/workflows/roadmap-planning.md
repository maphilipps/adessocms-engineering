# Roadmap Planning Workflow

<required_reading>
Read before proceeding:
- references/feature-comparison.md
- templates/roadmap-item.md
</required_reading>

<objective>
Maintain a prioritized development roadmap for adesso CMS feature parity
with 1xInternet Quartz and beyond.
</objective>

<process>
## Step 1: Review Current State

1. Check existing roadmap file:
   ```bash
   cat /Users/marc.philipps/Sites/adesso-cms/.claude/skills/project-ownership/ROADMAP.md 2>/dev/null || echo "No roadmap exists yet"
   ```

2. Review gap analysis for priorities

3. Check Jira board for in-progress work:
   - Board: https://adesso-app-mgt.atlassian.net/jira/software/projects/DS/boards/186

## Step 2: Define Phases

Structure roadmap in phases:

### Phase 1: Foundation (Core UX)
- Essential components for basic site building
- Must-have for MVP parity

### Phase 2: Enhanced UX
- Components that improve editorial experience
- Search, navigation enhancements

### Phase 3: Advanced Features
- Complex components
- Integrations, specialized functionality

### Phase 4: Polish & Optimization
- Performance improvements
- Accessibility enhancements
- Design system documentation

## Step 3: Prioritization Criteria

Score each item (1-5) on:
1. **Business Value**: How much does this help users?
2. **Effort**: How complex to implement? (inverse: low effort = high score)
3. **Dependencies**: Can we build it now?
4. **Strategic Fit**: Aligns with product direction?

Priority = (Business Value * 2) + Effort + Dependencies + Strategic Fit

## Step 4: Update Roadmap

Format:
```markdown
# adesso CMS Development Roadmap

Last Updated: [DATE]

## Phase 1: Foundation (Q1 2025)
| Priority | Component | Status | Jira | Notes |
|----------|-----------|--------|------|-------|
| P1 | Tabs | Planned | DS-xxx | Core content org |
| P2 | Message | Planned | - | User feedback |
| ... | ... | ... | ... | ... |

## Phase 2: Enhanced UX (Q2 2025)
...

## Phase 3: Advanced Features (Q3 2025)
...

## Completed
| Component | Completed | Jira |
|-----------|-----------|------|
| ... | ... | ... |
```

## Step 5: Validate with User

Present roadmap and ask:
- "Does this priority order make sense?"
- "Any items to add/remove/reprioritize?"
- "Ready to create tickets for Phase 1?"
</process>

<success_criteria>
- Roadmap file exists and is current
- Items are prioritized with clear rationale
- Phases are realistic and sequenced correctly
- Dependencies are respected
- User has validated priorities
</success_criteria>
