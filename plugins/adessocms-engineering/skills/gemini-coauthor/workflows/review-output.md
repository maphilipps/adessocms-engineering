# Workflow: Review Output with Gemini

<purpose>
Cross-check review findings from `/plan_review` or `/review` with Gemini to catch missed issues or false positives.
</purpose>

<when_to_use>
- After `/plan_review` agents return findings
- After `/review` produces code review results
- When review findings seem incomplete or questionable
</when_to_use>

<process>
## Step 1: Check Gemini Availability

```bash
if ! which gemini >/dev/null 2>&1; then
  echo "SKIP: Gemini not available, continuing without cross-check"
  exit 0
fi
```

## Step 2: Prepare Review Summary

Collect all review findings:
- Agent name and findings
- Severity levels
- Recommendations

## Step 3: Send to Gemini for Cross-Check

```bash
gemini -y "Cross-check these code/plan review findings.

For each finding, assess:
1. Is this a valid concern? (Yes/No/Partially)
2. Is the severity appropriate? (Too High/Correct/Too Low)
3. Are there any FALSE POSITIVES we should dismiss?
4. Are there MISSED ISSUES not covered by these findings?

Review Findings:
[INSERT_FINDINGS_SUMMARY]

Original Content Being Reviewed:
[INSERT_CONTENT_SUMMARY]

Provide:
- Validated findings (confirmed issues)
- Disputed findings (with reasoning)
- Additional findings (missed by original review)
- Severity adjustments (if any)"
```

## Step 4: Synthesize Results

Combine Claude's agent findings with Gemini's cross-check:

**Confirmed Issues:**
- Issues both Claude agents and Gemini agree on
- High confidence, should be addressed

**Disputed Issues:**
- Issues where Gemini disagrees with severity or validity
- Present both perspectives to user

**Additional Issues:**
- New issues Gemini identified
- Add to findings list

**False Positives:**
- Issues Gemini flags as not valid
- Remove or downgrade

## Step 5: Present Consolidated Report

```markdown
## Review Cross-Check Results

**Original Findings:** [X] issues from [Y] agents
**After Cross-Check:** [Z] validated issues

### Confirmed (High Confidence)
- [Issue 1] - Severity: P1
- [Issue 2] - Severity: P2

### Disputed (Needs Human Decision)
| Issue | Claude Says | Gemini Says |
|-------|-------------|-------------|
| [Issue] | P1 - Critical | P3 - Minor |

### Additional Findings (from Gemini)
- [New issue not caught by original review]

### Dismissed (False Positives)
- [Issue originally flagged but deemed invalid]
```
</process>

<success_criteria>
- All review findings cross-checked
- False positives identified and explained
- Additional issues caught
- Severity levels validated
- Consolidated report presented to user
</success_criteria>
