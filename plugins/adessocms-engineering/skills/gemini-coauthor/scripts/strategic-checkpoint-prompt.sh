#!/bin/bash
# Strategic Checkpoint Prompt Generator for Gemini 3 Pro
# Usage: ./strategic-checkpoint-prompt.sh <checkpoint-number> <architecture-doc> <implementation-diff>

set -euo pipefail

CHECKPOINT="${1:-}"
ARCH_DOC="${2:-}"
IMPL_DIFF="${3:-}"

if [[ -z "$CHECKPOINT" ]] || [[ -z "$ARCH_DOC" ]]; then
  echo "Error: Checkpoint number and architecture doc required"
  echo "Usage: $0 <checkpoint-number> <architecture-doc> [implementation-diff]"
  exit 1
fi

CHECKPOINT_LABELS=(
  "Foundation (25%)"
  "Core Logic (50%)"
  "Integration (75%)"
  "Complete (100%)"
)

LABEL="${CHECKPOINT_LABELS[$((CHECKPOINT-1))]}"

# Generate strategic checkpoint prompt for Gemini
cat <<EOF
You are the Strategic Architect reviewing implementation progress against your original architecture design.

CHECKPOINT: $CHECKPOINT - $LABEL

ORIGINAL ARCHITECTURE:
$(cat "$ARCH_DOC")

IMPLEMENTATION SO FAR:
$IMPL_DIFF

STRATEGIC VALIDATION QUESTIONS:

## 1. Architecture Alignment
- Is the implementation following the architectural design?
- Are the technology decisions being respected?
- Is the component structure matching the design?

## 2. Trade-offs Validation
- Are the documented trade-offs being honored?
- Any unexpected complexity introduced?
- Performance vs simplicity balance maintained?

## 3. Violations Check
- Any architectural patterns violated?
- Any anti-patterns introduced?
- Any shortcuts that compromise the design?

## 4. Performance & Security
- Performance considerations addressed?
- Security requirements implemented?
- Proper input validation and sanitization?

## 5. Technical Debt Assessment
- Acceptable technical debt level?
- Debt properly documented?
- Refactoring needed before continuing?

CATEGORIZE YOUR FEEDBACK:

✅ **Aligned** - Implementation matches architecture, continue as-is
⚠️ **Warnings** - Minor concerns, proceed with caution
❌ **Violations** - Critical issues, STOP and fix before continuing
💡 **Suggestions** - Optional improvements for consideration

OUTPUT FORMAT:

## Checkpoint $CHECKPOINT - $LABEL

**Overall Status:** ✅/⚠️/❌

### Architecture Alignment
[Your assessment]

### Trade-offs
[Your assessment]

### Violations (if any)
[List critical issues]

### Performance & Security
[Your assessment]

### Technical Debt
[Current debt level and acceptability]

### Recommendations
[Prioritized list of actions]

---

**Decision:** [Continue / Fix Issues / Major Refactor Needed]

If violations (❌) detected, implementation MUST stop and fix issues before proceeding.
EOF
