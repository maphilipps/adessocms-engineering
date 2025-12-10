#!/bin/bash
# Architecture Validation Prompt Generator for Gemini 3 Pro
# Usage: ./architecture-validation-prompt.sh <architecture-doc> <checkpoints-log> <complete-diff>

set -euo pipefail

ARCH_DOC="${1:-}"
CHECKPOINTS="${2:-}"
COMPLETE_DIFF="${3:-}"

if [[ -z "$ARCH_DOC" ]]; then
  echo "Error: Architecture document required"
  echo "Usage: $0 <architecture-doc> [checkpoints-log] [complete-diff]"
  exit 1
fi

# Generate final validation prompt for Gemini
cat <<EOF
You are the Strategic Architect performing final validation before production release.

This is your FINAL approval - be thorough and critical.

ORIGINAL ARCHITECTURE:
$(cat "$ARCH_DOC")

CHECKPOINT HISTORY:
$CHECKPOINTS

COMPLETE IMPLEMENTATION:
$COMPLETE_DIFF

FINAL VALIDATION CHECKLIST:

## 1. Architecture Compliance (0-100%)
- All architectural decisions implemented as designed?
- Technology choices followed throughout?
- Component structure matches the blueprint?
- Data flow implemented correctly?
- Integration points work as specified?

Score: __%

## 2. Trade-offs Validation
- Performance trade-offs acceptable in production?
- Simplicity vs flexibility balanced?
- Maintainability preserved?
- All documented trade-offs still valid?

Status: ✅/⚠️/❌

## 3. System Coherence
- Components integrate properly?
- No architectural inconsistencies?
- Naming and patterns consistent?
- Error handling complete?
- Logging and monitoring in place?

Status: ✅/⚠️/❌

## 4. Technical Debt Assessment
- Total debt level: [Low/Medium/High/Unacceptable]
- Debt properly documented?
- Debt items linked to follow-up beans?
- Any debt blocking production? [Yes/No]

List debt items:
1. [Item] - [Severity] - [Can defer: Yes/No]

## 5. Production Readiness
- Scalable per original design?
- Security requirements fully met?
- Performance acceptable for expected load?
- Tests cover critical paths?
- Documentation complete for handoff?

Status: ✅/⚠️/❌

---

OVERALL ASSESSMENT:

**Architecture Compliance Score:** __% (0-100)

**Status:** [Choose ONE]
- ✅ **APPROVED** (90-100%) - Ready for production
- ⚠️ **APPROVED with Concerns** (70-89%) - Acceptable but needs follow-up
- ❌ **REJECTED** (<70%) - Critical issues must be fixed

**Critical Issues (if any):**
[Issues that BLOCK production release]

**Recommendations:**
[Prioritized improvements for follow-up]

**Technical Debt Summary:**
[What was introduced and why it's acceptable/not]

**Final Decision:**
[APPROVE / APPROVE WITH CONDITIONS / REJECT]

If APPROVED: Mark architecture bean as completed, proceed with PR.
If APPROVED WITH CONCERNS: Create follow-up beans for improvements.
If REJECTED: List critical fixes needed before resubmission.

---

**Validator:** Gemini 3 Pro Strategic Architect
**Validation Date:** $(date +%Y-%m-%d)
**Compliance Score:** __%
**Status:** [✅/⚠️/❌]
EOF
