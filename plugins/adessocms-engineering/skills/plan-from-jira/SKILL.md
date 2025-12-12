---
name: plan-from-jira
description: Fetches Jira ticket details via REST API and creates an implementation plan. Use when given a Jira URL like https://adesso-group-extern.atlassian.net/browse/EABC-1234 or ticket key like EABC-1234. Automatically creates a feature branch with ticket number.
---

<essential_principles>

<principle name="api-token-auth">
Use Jira REST API with Personal Access Token (PAT) for all operations.

**Required environment variables:**
- `JIRA_EMAIL` - Your Atlassian account email
- `JIRA_API_TOKEN` - Personal Access Token from https://id.atlassian.com/manage-profile/security/api-tokens

Check if configured:
```bash
[[ -n "$JIRA_EMAIL" && -n "$JIRA_API_TOKEN" ]] && echo "OK" || echo "Missing JIRA credentials"
```

**Token erstellen:**
1. https://id.atlassian.com/manage-profile/security/api-tokens
2. "Create API token" klicken
3. Label vergeben (z.B. "Claude Code")
4. Token kopieren und in Shell-Config speichern:
```bash
export JIRA_EMAIL="marc.philipps@adesso.de"
export JIRA_API_TOKEN="your-token-here"
```
</principle>

<principle name="branch-convention">
Always include ticket number in branch name:
- Format: `{ticket-key}-{slug}` (e.g., `EABC-3619-user-authentication`)
- Slug from ticket title, lowercase, hyphens instead of spaces
- Max 50 chars for slug portion
</principle>

<principle name="plan-integration">
After fetching ticket, invoke `/plan` with structured ticket data. The plan must reference the ticket number for traceability.
</principle>

</essential_principles>

<objective>
Fetch Jira ticket information via REST API and create an implementation plan. Supports extended field set including attachments, subtasks, linked issues, and comments. Automatically creates a Git feature branch following naming conventions.
</objective>

<quick_start>
Given a Jira URL or ticket key:

1. **Parse ticket key** from URL (e.g., `EABC-3619` from `https://adesso-group-extern.atlassian.net/browse/EABC-3619`)
2. **Check API credentials** are set (`JIRA_EMAIL`, `JIRA_API_TOKEN`)
3. **Fetch ticket** via REST API
4. **Create branch** with ticket number: `git checkout -b EABC-3619-feature-slug`
5. **Invoke /plan** with ticket context

```bash
# Fetch ticket with all fields
TICKET_KEY="EABC-3619"
SITE="adesso-group-extern.atlassian.net"

curl -s -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  "https://${SITE}/rest/api/3/issue/${TICKET_KEY}?expand=renderedFields,names,changelog"
```
</quick_start>

<intake>
Provide a Jira ticket URL or key:

**Examples:**
- `https://adesso-group-extern.atlassian.net/browse/EABC-3619`
- `EABC-3619`

**Wait for input, then follow workflow in `workflows/process-ticket.md`**
</intake>

<routing>
| Input | Action |
|-------|--------|
| Jira URL | Extract ticket key and site, proceed to workflow |
| Ticket key (e.g., EABC-1234) | Use default site (adesso-group-extern), proceed to workflow |
| "setup", "configure", "token" | Show API token setup instructions |
| Other | Ask for valid Jira ticket reference |

**After identifying ticket, read and follow `workflows/process-ticket.md`**
</routing>

<reference_index>
All domain knowledge in `references/`:

**API:** jira-rest-api.md - REST API endpoints, authentication, field handling
</reference_index>

<workflows_index>
| Workflow | Purpose |
|----------|---------|
| process-ticket.md | Main workflow: fetch ticket, create branch, invoke /plan |
</workflows_index>

<success_criteria>
- API credentials configured (JIRA_EMAIL, JIRA_API_TOKEN)
- Ticket data fetched successfully (title, description, acceptance criteria, etc.)
- Git branch created with ticket number prefix
- `/plan` invoked with complete ticket context
- Plan file created referencing ticket number
</success_criteria>
