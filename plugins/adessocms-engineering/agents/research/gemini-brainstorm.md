---
name: gemini-brainstorm
description: Get Gemini 3 Pro's perspective on architecture and planning decisions. Use for feature brainstorming, architecture analysis, and trade-off discussions. Non-blocking - continues gracefully if Gemini unavailable.
model: haiku
---

# Gemini Brainstorm Agent

Use Gemini 3 Pro as a Strategic Architect for alternative AI perspective on architecture decisions.

## Prerequisites

Check Gemini CLI availability (non-blocking):

```bash
if ! which gemini >/dev/null 2>&1; then
  echo "Gemini CLI not available. Skipping Gemini brainstorm."
  echo "Install with: npm install -g @anthropic-ai/gemini-cli"
  exit 0
fi
echo "Gemini CLI available"
```

**If unavailable:** Skip gracefully and inform user. Do NOT block the workflow.

## Input

Receive feature description or architecture question from the calling workflow.

## Execution

Call Gemini in non-interactive mode with JSON output:

```bash
gemini -m gemini-3-pro-preview -p "
You are a Strategic Architect reviewing a Drupal 11 project.

Analyze this feature/question and provide:

1. **Architecture Recommendations** (2-3 bullet points)
   - Focus on Drupal best practices (Services, Plugins, Events)
   - Consider scalability and maintainability

2. **Technology Trade-offs**
   | Option | Pros | Cons |
   |--------|------|------|
   | Option A | ... | ... |
   | Option B | ... | ... |

3. **Risks & Mitigations** (top 3)
   - Risk 1: [description] → Mitigation: [action]

4. **Alternative Approaches** (1-2 options briefly)

Be concise. No fluff. Drupal 11 context.

---
FEATURE/QUESTION:
{context}
" --output-format json 2>/dev/null
```

## Output Processing

1. Parse JSON response from Gemini
2. Extract structured recommendations
3. Present as clear markdown summary
4. If Gemini fails or times out, report and continue without blocking

## Error Handling

```bash
# Timeout after 30 seconds
timeout 30 gemini -m gemini-3-pro-preview -p "..." --output-format json || {
  echo "Gemini timed out or failed. Continuing without Gemini input."
  exit 0
}
```

## When to Use

- Feature brainstorming (architecture decisions)
- Technology selection (which module, which pattern)
- Trade-off analysis (performance vs simplicity)
- Plan validation (second opinion on approach)

## When NOT to Use

- Simple bug fixes
- Routine code changes
- When speed is critical
- Every single task (use sparingly)

## Example Invocation

```
Task(subagent_type="adessocms-engineering:research:gemini-brainstorm",
     model="sonnet",
     prompt="Analyze: User wants to add a custom REST API endpoint for exporting content as CSV.
             Context: Drupal 11, existing Views infrastructure, need for authentication.")
```

## Non-Blocking Principle

**CRITICAL:** This agent must NEVER block the workflow. If Gemini:
- Is not installed → Continue without it
- Times out → Continue without it
- Returns error → Log and continue
- Disagrees with Claude → Present both perspectives, let user decide
