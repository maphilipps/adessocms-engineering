# Workflow: Co-Plan with Gemini

<purpose>
Get Gemini's input during plan creation to catch gaps, improve structure, and ensure completeness.
</purpose>

<when_to_use>
- After drafting a plan in `/plan` workflow
- Before presenting plan to user for approval
- For complex features requiring thorough planning
</when_to_use>

<process>
## Step 1: Check Gemini Availability

```bash
if ! which gemini >/dev/null 2>&1; then
  echo "SKIP: Gemini not available, continuing without co-plan review"
  exit 0
fi
```

## Step 2: Prepare Plan for Review

Read the draft plan and prepare it for Gemini review:
- Full plan content
- Original user request
- Any constraints or requirements

## Step 3: Send Plan to Gemini

```bash
gemini -y "Review this plan for completeness and quality.

Check these aspects:
1. Are all acceptance criteria specific and testable?
2. Are there missing edge cases or error scenarios?
3. Is the technical approach sound for the stated requirements?
4. Are there obvious gaps, risks, or missing dependencies?
5. Is the scope appropriate (not too broad, not too narrow)?

Original Request:
[INSERT_ORIGINAL_REQUEST]

Draft Plan:
[INSERT_PLAN_CONTENT]

Provide:
- Overall assessment (Good/Needs Work/Major Issues)
- Specific improvements (bullet points)
- Missing elements (if any)
- Risk flags (if any)"
```

## Step 4: Integrate Feedback

Process Gemini's feedback:

**For improvements:**
- Update plan with valid suggestions
- Note changes made

**For disagreements:**
- Evaluate both perspectives
- Choose the better approach with reasoning
- Or present both options to user

**For missing elements:**
- Add missing sections if valid
- Explain why if intentionally omitted

## Step 5: Document Changes

Add a section to the plan noting co-author input:

```markdown
## Review Notes

**Co-Author Review:** Gemini CLI
**Status:** [Approved/Revised]
**Key Changes:**
- [Change 1 based on feedback]
- [Change 2 based on feedback]
```

## Step 6: Open in Typora (if available)

```bash
if [ -d "/Applications/Typora.app" ]; then
  open -a Typora "[PLAN_PATH]"
else
  open "[PLAN_PATH]"
fi
```
</process>

<success_criteria>
- Gemini reviewed the complete plan
- Valid feedback integrated
- Disagreements resolved or presented to user
- Plan quality improved
- Changes documented
- Plan opened in Typora if available
</success_criteria>
