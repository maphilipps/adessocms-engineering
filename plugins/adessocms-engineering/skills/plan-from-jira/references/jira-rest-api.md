<overview>
Jira Cloud REST API v3 reference for ticket operations. Covers authentication, issue endpoints, and field handling for adesso Jira instances.
</overview>

<authentication>

<api_token>
**Personal Access Token (PAT) authentication:**

1. Create token at https://id.atlassian.com/manage-profile/security/api-tokens
2. Set environment variables:
```bash
export JIRA_EMAIL="user@adesso.de"
export JIRA_API_TOKEN="your-api-token"
```

3. Use with curl:
```bash
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://adesso-group-extern.atlassian.net/rest/api/3/issue/EABC-1234"
```
</api_token>

<check_credentials>
```bash
# Verify credentials work
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://adesso-group-extern.atlassian.net/rest/api/3/myself" | jq '.displayName'
```
</check_credentials>

</authentication>

<issue_endpoints>

<get_issue>
**Get single issue:**
```bash
SITE="adesso-group-extern.atlassian.net"
TICKET="EABC-1234"

# Basic
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET}"

# With expanded fields (recommended)
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET}?expand=renderedFields,names,changelog"

# With specific fields only
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET}?fields=summary,description,status,assignee"
```

**Expand options:**
- `renderedFields` - HTML-rendered description/comments
- `names` - Field name mappings
- `changelog` - Change history
- `transitions` - Available transitions
</get_issue>

<search_issues>
**Search with JQL:**
```bash
JQL="project = EABC AND status = 'In Progress'"
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/search" \
  -H "Content-Type: application/json" \
  -d "{\"jql\": \"${JQL}\", \"maxResults\": 50}"
```
</search_issues>

<comments>
**Get comments:**
```bash
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET}/comment"
```

**Add comment:**
```bash
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET}/comment" \
  -H "Content-Type: application/json" \
  -d '{"body": {"type": "doc", "version": 1, "content": [{"type": "paragraph", "content": [{"type": "text", "text": "Comment text"}]}]}}'
```
</comments>

<attachments>
**List attachments (included in issue response):**
```bash
echo "$TICKET_JSON" | jq '.fields.attachment[]'
```

**Download attachment:**
```bash
ATTACHMENT_URL=$(echo "$TICKET_JSON" | jq -r '.fields.attachment[0].content')
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" -o "filename.pdf" "$ATTACHMENT_URL"
```
</attachments>

<transitions>
**List available transitions:**
```bash
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET}/transitions"
```

**Transition issue:**
```bash
TRANSITION_ID="31"  # Get from transitions list
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET}/transitions" \
  -H "Content-Type: application/json" \
  -d "{\"transition\": {\"id\": \"${TRANSITION_ID}\"}}"
```
</transitions>

</issue_endpoints>

<json_parsing>

<extract_fields>
```bash
TICKET_JSON=$(curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET}?expand=renderedFields")

# Basic fields
TITLE=$(echo "$TICKET_JSON" | jq -r '.fields.summary')
STATUS=$(echo "$TICKET_JSON" | jq -r '.fields.status.name')
ASSIGNEE=$(echo "$TICKET_JSON" | jq -r '.fields.assignee.displayName // "Unassigned"')
REPORTER=$(echo "$TICKET_JSON" | jq -r '.fields.reporter.displayName')
PRIORITY=$(echo "$TICKET_JSON" | jq -r '.fields.priority.name // "None"')
ISSUE_TYPE=$(echo "$TICKET_JSON" | jq -r '.fields.issuetype.name')

# Arrays
LABELS=$(echo "$TICKET_JSON" | jq -r '.fields.labels | join(", ")')
COMPONENTS=$(echo "$TICKET_JSON" | jq -r '.fields.components | map(.name) | join(", ")')

# Description (API v3 uses Atlassian Document Format)
# Use renderedFields for HTML version
DESCRIPTION_HTML=$(echo "$TICKET_JSON" | jq -r '.renderedFields.description // ""')

# Or extract plain text from ADF
DESCRIPTION_TEXT=$(echo "$TICKET_JSON" | jq -r '
  .fields.description.content[]?.content[]?.text // ""
' | tr '\n' ' ')
```
</extract_fields>

<subtasks>
```bash
# Get subtask keys
SUBTASKS=$(echo "$TICKET_JSON" | jq -r '.fields.subtasks[]?.key')

# Get subtask summaries with status
echo "$TICKET_JSON" | jq -r '.fields.subtasks[]? | "\(.key): \(.fields.summary) [\(.fields.status.name)]"'
```
</subtasks>

<issue_links>
```bash
# Get linked issues
echo "$TICKET_JSON" | jq -r '
  .fields.issuelinks[]? |
  "\(.type.name): \(.inwardIssue.key // .outwardIssue.key) - \(.inwardIssue.fields.summary // .outwardIssue.fields.summary)"
'
```
</issue_links>

<comments_parse>
```bash
# Parse comments from issue (if included)
echo "$TICKET_JSON" | jq -r '
  .fields.comment.comments[]? |
  "[\(.created | split("T")[0])] \(.author.displayName):\n\(.body.content[]?.content[]?.text // "[rich content]")\n"
'
```
</comments_parse>

<custom_fields>
```bash
# Story points (common custom field)
STORY_POINTS=$(echo "$TICKET_JSON" | jq -r '.fields.customfield_10016 // "Not set"')

# Sprint
SPRINT=$(echo "$TICKET_JSON" | jq -r '.fields.customfield_10020[]?.name // "No sprint"')

# List all custom fields
echo "$TICKET_JSON" | jq '.fields | keys[] | select(startswith("customfield"))'
```
</custom_fields>

</json_parsing>

<adesso_instances>

<eabc_instance>
**Energie-Atlas Bayern CMS:**
- Site: `adesso-group-extern.atlassian.net`
- Project: `EABC`
- URL pattern: `https://adesso-group-extern.atlassian.net/browse/EABC-{number}`
- API base: `https://adesso-group-extern.atlassian.net/rest/api/3`
</eabc_instance>

<internal_instance>
**adesso internal:**
- Site: `adesso-app-mgt.atlassian.net`
- Various projects
- API base: `https://adesso-app-mgt.atlassian.net/rest/api/3`
</internal_instance>

</adesso_instances>

<error_handling>

<common_errors>
| Error | Cause | Solution |
|-------|-------|----------|
| 401 Unauthorized | Invalid/expired token | Create new token at id.atlassian.com |
| 404 Not Found | Wrong site or ticket doesn't exist | Verify site and ticket key |
| 403 Forbidden | No permission to view issue | Check project access |
| Rate limit exceeded | Too many requests | Add delays between requests |
</common_errors>

<error_check>
```bash
# Check for API errors in response
if echo "$TICKET_JSON" | jq -e '.errorMessages' > /dev/null 2>&1; then
  echo "ERROR: $(echo "$TICKET_JSON" | jq -r '.errorMessages[]')"
  exit 1
fi

# Check HTTP status
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET}")
if [[ "$HTTP_STATUS" != "200" ]]; then
  echo "HTTP Error: $HTTP_STATUS"
  exit 1
fi
```
</error_check>

</error_handling>

<tips>

<always_expand>
Always use `?expand=renderedFields` for human-readable description/comments:
```bash
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET}?expand=renderedFields"
```
</always_expand>

<adf_to_text>
API v3 uses Atlassian Document Format (ADF) for rich text. To get plain text:
```bash
# Use renderedFields for HTML
echo "$TICKET_JSON" | jq -r '.renderedFields.description'

# Or recursively extract text from ADF
echo "$TICKET_JSON" | jq -r '
  [.fields.description | .. | .text? // empty] | join(" ")
'
```
</adf_to_text>

<batch_fetch>
```bash
# Fetch multiple issues at once via search
curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/search" \
  -H "Content-Type: application/json" \
  -d '{"jql": "key in (EABC-1234, EABC-1235, EABC-1236)", "maxResults": 100}'
```
</batch_fetch>

</tips>
