# Workflow: Process Jira Ticket

<required_reading>
**Read this reference file NOW:**
1. references/jira-rest-api.md
</required_reading>

<process>

## Step 1: Parse Ticket Key and Site

Extract ticket key and site from input:

**URL pattern:** `https://{SITE}/browse/{TICKET_KEY}`
**Direct key:** `EABC-1234`, `ABC-123`

```bash
# Extract from URL
URL="https://adesso-group-extern.atlassian.net/browse/EABC-3619"
SITE=$(echo "$URL" | grep -oP '(?<=https://)[^/]+')
TICKET_KEY=$(echo "$URL" | grep -oE '[A-Z]+-[0-9]+')

echo "Site: $SITE"
echo "Ticket: $TICKET_KEY"
```

**Default site:** `adesso-group-extern.atlassian.net`

## Step 2: Check API Credentials

Verify environment variables are set:

```bash
if [[ -z "$JIRA_EMAIL" || -z "$JIRA_API_TOKEN" ]]; then
  echo "ERROR: Missing JIRA credentials"
  echo "Set these environment variables:"
  echo "  export JIRA_EMAIL='your-email@adesso.de'"
  echo "  export JIRA_API_TOKEN='your-api-token'"
  echo ""
  echo "Create token at: https://id.atlassian.com/manage-profile/security/api-tokens"
  exit 1
fi
echo "Credentials OK: $JIRA_EMAIL"
```

## Step 3: Fetch Ticket Data

Use Jira REST API v3 to fetch the ticket:

```bash
TICKET_KEY="EABC-3619"
SITE="adesso-group-extern.atlassian.net"

# Fetch with expanded fields
TICKET_JSON=$(curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET_KEY}?expand=renderedFields,names,changelog")

# Check for errors
if echo "$TICKET_JSON" | jq -e '.errorMessages' > /dev/null 2>&1; then
  echo "ERROR: $(echo "$TICKET_JSON" | jq -r '.errorMessages[]')"
  exit 1
fi
```

**Parse JSON output with jq:**
```bash
# Extract fields
TITLE=$(echo "$TICKET_JSON" | jq -r '.fields.summary')
STATUS=$(echo "$TICKET_JSON" | jq -r '.fields.status.name')
ASSIGNEE=$(echo "$TICKET_JSON" | jq -r '.fields.assignee.displayName // "Unassigned"')
REPORTER=$(echo "$TICKET_JSON" | jq -r '.fields.reporter.displayName')
LABELS=$(echo "$TICKET_JSON" | jq -r '.fields.labels | join(", ")')
COMPONENTS=$(echo "$TICKET_JSON" | jq -r '.fields.components | map(.name) | join(", ")')

# Description (ADF format in API v3 - use renderedFields for HTML)
DESCRIPTION_HTML=$(echo "$TICKET_JSON" | jq -r '.renderedFields.description // ""')
```

## Step 4: Fetch Comments

Comments are included in ticket or fetch separately:

```bash
# Comments from separate endpoint
COMMENTS_JSON=$(curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET_KEY}/comment")

# Parse comments
echo "$COMMENTS_JSON" | jq -r '
  .comments[]? |
  "[\(.created)] \(.author.displayName): \(.body.content[]?.content[]?.text // "[complex content]")"
'
```

## Step 5: Fetch Subtasks and Links

Subtasks and issue links are included in the main ticket JSON:

```bash
# Subtasks
SUBTASKS=$(echo "$TICKET_JSON" | jq -r '.fields.subtasks[]?.key' | tr '\n' ' ')

# Subtask details
echo "$TICKET_JSON" | jq -r '.fields.subtasks[]? | "\(.key): \(.fields.summary) [\(.fields.status.name)]"'

# Issue links
echo "$TICKET_JSON" | jq -r '
  .fields.issuelinks[]? |
  "\(.type.name): \(.inwardIssue.key // .outwardIssue.key)"
'

# Fetch details for each subtask if needed
for subtask in $SUBTASKS; do
  curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
    "https://${SITE}/rest/api/3/issue/${subtask}" | jq '.fields.summary, .fields.status.name'
done
```

## Step 6: Fetch Attachments

```bash
# List attachments
echo "$TICKET_JSON" | jq -r '.fields.attachment[]? | "\(.filename) (\(.size) bytes) - \(.content)"'
```

## Step 7: Create Git Branch

Create feature branch with ticket number:

```bash
TICKET_KEY="EABC-3619"
TITLE="User Authentication Feature"

# Generate slug from title
SLUG=$(echo "$TITLE" | \
  tr '[:upper:]' '[:lower:]' | \
  sed 's/[^a-z0-9äöüß]/-/g' | \
  sed 's/--*/-/g' | \
  sed 's/^-//' | \
  sed 's/-$//' | \
  cut -c1-50)

# Create branch from develop
git checkout develop
git pull origin develop
git checkout -b "${TICKET_KEY}-${SLUG}"

echo "Created branch: ${TICKET_KEY}-${SLUG}"
```

## Step 8: Prepare Plan Context

Structure ticket data for `/plan`:

```markdown
# Plan: {TICKET_KEY} - {TITLE}

## Ticket Information
- **Key:** {TICKET_KEY}
- **URL:** https://{SITE}/browse/{TICKET_KEY}
- **Status:** {STATUS}
- **Assignee:** {ASSIGNEE}
- **Reporter:** {REPORTER}
- **Labels:** {LABELS}
- **Components:** {COMPONENTS}

## Description
{DESCRIPTION}

## Acceptance Criteria
{ACCEPTANCE_CRITERIA_FROM_DESCRIPTION_OR_CUSTOM_FIELD}

## Subtasks
{SUBTASK_LIST_WITH_STATUS}

## Linked Issues
{LINKED_ISSUES_WITH_RELATIONSHIP}

## Comments (latest)
{RECENT_COMMENTS}

## Attachments
{ATTACHMENT_LIST}
```

## Step 9: Invoke /plan

Use SlashCommand tool to invoke `/plan` with the structured context:

```
/adessocms-engineering:workflows:plan {STRUCTURED_TICKET_CONTEXT}
```

The plan should:
- Use filename: `plans/{TICKET_KEY}-implementation.md`
- Reference ticket URL for traceability
- Break down work based on acceptance criteria
- Consider subtasks as potential work items
- Open plan in Typora for review

</process>

<success_criteria>
This workflow is complete when:
- [ ] Ticket key and site parsed from input
- [ ] API credentials verified (JIRA_EMAIL, JIRA_API_TOKEN)
- [ ] Ticket data fetched via REST API
- [ ] Subtasks and linked issues identified (if any)
- [ ] Git branch created with pattern `{TICKET_KEY}-{slug}`
- [ ] /plan invoked with complete ticket context
- [ ] Plan file created at `plans/{TICKET_KEY}-*.md`
- [ ] Plan opened in Typora
</success_criteria>
