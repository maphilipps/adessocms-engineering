# Ticket Proposal Workflow

<required_reading>
Read before proceeding:
- references/feature-comparison.md
- references/acli-reference.md
- templates/jira-ticket.md
</required_reading>

<objective>
Create well-structured ticket proposals for review before creation.
Tickets are NEVER created directly - always proposed first.
</objective>

<jira_context>
- **Project**: DS (adesso CMS Design System)
- **Board**: https://adesso-app-mgt.atlassian.net/jira/software/projects/DS/boards/186
- **Issue Types**: Story, Task, Bug, Epic
- **CLI**: `acli` (Atlassian CLI) - siehe `references/acli-reference.md`

## Workflow

1. **Claude erstellt Ticket-Vorschlag** im Markdown-Format
2. **User reviewed** und gibt Freigabe ("approve") oder Änderungswünsche
3. **Claude erstellt Ticket via `acli`** nach Approval
4. **Claude teilt die neue Ticket-ID** (z.B. DS-123) mit
</jira_context>

<process>
## Step 1: Identify Ticket Need

Ask user what needs a ticket:
- New component from gap analysis?
- Bug fix?
- Enhancement to existing component?
- Documentation?
- Technical debt?

## Step 2: Gather Requirements

For each ticket, collect:
1. **What**: Clear description of the work
2. **Why**: Business value / user benefit
3. **Acceptance Criteria**: Definition of done
4. **Dependencies**: What needs to exist first?
5. **Effort**: T-shirt size (S/M/L/XL)

## Step 3: Draft Ticket Proposal

Use template format:

```markdown
## TICKET PROPOSAL (Pending Approval)

**Type**: Story | Task | Bug
**Summary**: [Component Name] - [Brief Description]
**Priority**: Critical | High | Medium | Low

### Description
[What and Why]

### Acceptance Criteria
- [ ] Component has .component.yml with full schema
- [ ] Component has .twig template
- [ ] Component has .stories.js with all variants
- [ ] Component passes ESLint/Stylelint
- [ ] Component is accessible (WCAG 2.1 AA)
- [ ] Component is responsive
- [ ] [Custom criteria...]

### Technical Notes
- Dependencies: [list]
- Related components: [list]
- Quartz reference: [link if applicable]

### Effort Estimate
- Size: S/M/L/XL
- Complexity: Low/Medium/High

---
**AWAITING APPROVAL** - Reply with "approve" to create or "modify" for changes
```

## Step 4: Present for Review

Show ticket proposal(s) to user and wait for:
- **"approve"** - Ticket via `acli` erstellen
- **"modify"** - Gewünschte Änderungen einarbeiten
- **"reject"** - Vorschlag verwerfen

## Step 5: Ticket via CLI erstellen

Nach Freigabe ("approve"):

1. **Description in temp-Datei schreiben** (für mehrzeilige Beschreibungen)
2. **Ticket via `acli` erstellen**
3. **Ticket-ID aus Output extrahieren und mitteilen**
4. **Roadmap aktualisieren** falls nötig

```bash
# Beispiel: Ticket erstellen
cat > /tmp/ticket-desc.md << 'EOF'
## Überblick
Implementierung der Button-Komponente als SDC.

## Acceptance Criteria
- [ ] Component hat .component.yml mit Schema
- [ ] Component hat .twig Template
- [ ] Component hat .stories.js
- [ ] Component ist WCAG 2.1 AA konform
EOF

acli jira workitem create \
  --project "DS" \
  --type "Story" \
  --summary "[Component] Button - Base implementation" \
  --description-file "/tmp/ticket-desc.md" \
  --label "component,frontend,sdc"
```
</process>

<ticket_types>
## Story (New Feature)
For new components or features. Include:
- User story format: "As a [user], I want [goal] so that [benefit]"
- Full acceptance criteria
- Design reference (Quartz/Figma if available)

## Task (Technical Work)
For refactoring, infrastructure, tooling. Include:
- Clear technical scope
- Why this work is needed
- Impact on other components

## Bug
For defects. Include:
- Steps to reproduce
- Expected vs actual behavior
- Severity/impact

## Epic
For large features spanning multiple tickets. Include:
- High-level goal
- List of child stories/tasks
- Success metrics
</ticket_types>

<success_criteria>
- Ticket has clear, actionable title
- Description explains what AND why
- Acceptance criteria are specific and testable
- Dependencies identified
- Effort estimated
- User has approved before any creation attempt
</success_criteria>
