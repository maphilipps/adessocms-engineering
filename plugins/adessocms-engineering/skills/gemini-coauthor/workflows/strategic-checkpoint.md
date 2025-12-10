# Workflow: Strategic Checkpoint

<purpose>
Gemini 3 Pro provides strategic oversight during implementation to ensure Claude's code aligns with the approved architecture and catches architectural violations early.
</purpose>

<when_to_use>
- During `/work` workflow after implementing each major component
- Before committing significant changes
- When Claude deviates from original architecture
- At 25%, 50%, 75% implementation milestones
</when_to_use>

<gemini_role>
**Gemini 3 Pro = Strategic Overseer**
- Verify alignment with architecture
- Catch architectural violations
- Warn about performance/security concerns
- Validate trade-offs are being respected
- Identify technical debt being introduced
</gemini_role>

<process>
## Step 1: Check Gemini Availability

```bash
if ! which gemini >/dev/null 2>&1; then
  echo "SKIP: Gemini not available, continuing without strategic oversight"
  exit 0
fi
```

## Step 2: Gather Implementation Context

Collect:
- Original architecture document
- Current git diff
- Files changed
- Tests written

## Step 3: Send Checkpoint Request to Gemini

```bash
gemini -y "You are the Strategic Architect reviewing implementation progress.

ORIGINAL ARCHITECTURE:
$(cat architecture/[feature-name]-architecture.md)

IMPLEMENTATION SO FAR:
Files changed:
[GIT_DIFF_STAT]

Key changes:
[GIT_DIFF_SUMMARY]

CHECKPOINT QUESTIONS:

1. **Architecture Alignment:** Does this implementation follow the approved architecture?
2. **Trade-offs Respected:** Are the documented trade-offs being respected?
3. **Violations:** Any architectural violations or anti-patterns?
4. **Performance:** Any performance concerns based on the approach?
5. **Security:** Any security considerations missed?
6. **Technical Debt:** Is technical debt being introduced? Acceptable or not?

Provide:
- ✅ What's aligned with architecture
- ⚠️ Warnings (concerns but acceptable)
- ❌ Violations (must fix before continuing)
- 💡 Suggestions for improvement

Format as brief, actionable feedback.
"
```

## Step 4: Analyze Gemini's Feedback

Categories:
- **✅ Aligned:** Continue
- **⚠️ Warnings:** Note but proceed
- **❌ Violations:** STOP, fix before continuing
- **💡 Suggestions:** Optional improvements

## Step 5: Handle Results

**If violations found (❌):**
```markdown
## ⛔ Strategic Checkpoint Failed

Gemini identified architectural violations:

[VIOLATIONS]

**Action Required:** Fix violations before proceeding.

Claude: Please address these violations now.
```

**If only warnings (⚠️):**
```markdown
## ⚠️ Strategic Checkpoint: Warnings

Gemini flagged concerns:

[WARNINGS]

**Proceed with caution.** Consider addressing in cleanup phase.
```

**If aligned (✅):**
```markdown
## ✅ Strategic Checkpoint Passed

Implementation aligns with architecture. Continue.
```

## Step 6: Update Bean Checklist

Mark checkpoint in bean file:
```markdown
- [x] Strategic checkpoint 1: Passed ✅
```

Or if violations:
```markdown
- [ ] Strategic checkpoint 1: Failed ❌ - Violations found
  - Fix: [violation description]
```

## Step 7: Log Checkpoint

Append to `architecture/[feature-name]-checkpoints.md`:
```markdown
## Checkpoint [N] - [Date]

**Files Reviewed:** [list]
**Status:** ✅ Passed / ⚠️ Warnings / ❌ Failed

**Gemini Feedback:**
[feedback]

**Actions Taken:**
[what was done]
```
</process>

<checkpoint_frequency>
Run checkpoints at:
1. **25% complete:** After foundation (models, basic structure)
2. **50% complete:** After core logic implemented
3. **75% complete:** After frontend/integration work
4. **100% complete:** Final validation before PR

Or trigger manually if:
- Claude unsure about approach
- Major refactoring needed
- Performance-critical code written
- Security-sensitive changes made
</checkpoint_frequency>

<success_criteria>
- Checkpoint run at appropriate milestone
- Gemini feedback received and categorized
- Violations addressed before proceeding
- Bean checklist updated
- Checkpoint logged
</success_criteria>

<fallback_without_gemini>
If Gemini unavailable:
1. Claude does self-review against architecture doc
2. Logs "Self-checkpoint (Gemini unavailable)"
3. Continues (less strategic validation)
</fallback_without_gemini>
