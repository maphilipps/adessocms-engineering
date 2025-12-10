# Workflow: Architecture Validation

<purpose>
Final strategic review by Gemini 3 Pro to validate complete implementation matches architecture, identify technical debt, and approve for production.
</purpose>

<when_to_use>
- End of `/work` workflow before creating PR
- After all tests pass and code is complete
- Before marking architecture bean as completed
</when_to_use>

<process>
## Step 1: Check Gemini Availability

```bash
if ! which gemini >/dev/null 2>&1; then
  echo "SKIP: Gemini not available, proceeding without final architecture validation"
  exit 0
fi
```

## Step 2: Prepare Final Review Package

```bash
# Get complete diff
git diff main...HEAD > /tmp/implementation-diff.txt

# Get all changed files
git diff --name-status main...HEAD > /tmp/changed-files.txt

# Get architecture doc
cat architecture/[feature-name]-architecture.md > /tmp/architecture.md

# Get checkpoint history
cat architecture/[feature-name]-checkpoints.md > /tmp/checkpoints.md
```

## Step 3: Send Final Validation Request

```bash
gemini -y "Final Architecture Validation

You designed the architecture for this feature. Now review the complete implementation.

ORIGINAL ARCHITECTURE:
$(cat /tmp/architecture.md)

CHECKPOINT HISTORY:
$(cat /tmp/checkpoints.md)

COMPLETE IMPLEMENTATION:
Changed files:
$(cat /tmp/changed-files.txt)

Implementation summary:
[CLAUDE_SUMMARY_OF_IMPLEMENTATION]

VALIDATION CHECKLIST:

## 1. Architecture Compliance
- [ ] All architectural decisions implemented as designed?
- [ ] Technology choices followed?
- [ ] Component structure matches design?

## 2. Trade-offs Validation
- [ ] Performance trade-offs acceptable?
- [ ] Simplicity vs flexibility balanced?
- [ ] Maintainability preserved?

## 3. System Coherence
- [ ] Components integrate properly?
- [ ] Data flow matches design?
- [ ] No architectural inconsistencies?

## 4. Technical Debt Assessment
- [ ] Acceptable technical debt level?
- [ ] Document any debt introduced
- [ ] Refactoring recommendations?

## 5. Production Readiness
- [ ] Scalable per design?
- [ ] Security requirements met?
- [ ] Performance acceptable?

Provide:
- **Overall Status:** ✅ Approved / ⚠️ Approved with Concerns / ❌ Rejected
- **Architecture Compliance Score:** 0-100%
- **Critical Issues:** Must-fix before merge
- **Recommendations:** Nice-to-have improvements
- **Technical Debt:** What was introduced and why acceptable/not
- **Approval Decision:** Go/No-Go for production
"
```

## Step 4: Parse Validation Results

Extract:
- Overall status
- Compliance score
- Critical issues (blocking)
- Recommendations (non-blocking)
- Technical debt assessment

## Step 5: Handle Results

### ✅ Approved (90-100% compliance, no critical issues)

```markdown
## ✅ Architecture Validation: APPROVED

**Compliance Score:** [SCORE]%
**Status:** Ready for production

Gemini's final assessment:
[SUMMARY]

**Proceed with PR creation.**
```

Update beans:
```bash
# Mark architecture bean as completed
beans update [architecture-bean-id] --status completed

# Add validation note to implementation bean
beans update [implementation-bean-id] \
  --description "$(cat <<EOF
...existing description...

## Architecture Validation ✅
- Compliance: [SCORE]%
- Approved by: Gemini 3 Pro Strategic Architect
- Date: [DATE]
EOF
)"
```

### ⚠️ Approved with Concerns (70-89% compliance)

```markdown
## ⚠️ Architecture Validation: APPROVED (with concerns)

**Compliance Score:** [SCORE]%
**Status:** Acceptable for merge, but improvements recommended

**Concerns:**
[WARNINGS]

**Recommendations:**
[IMPROVEMENTS]

**Technical Debt Introduced:**
[DEBT_LIST]

**Decision:** Proceed but create follow-up beans for improvements.
```

Create follow-up beans:
```bash
for concern in "${concerns[@]}"; do
  beans create "Tech Debt: $concern" \
    -t task \
    -p low \
    --link parent:[architecture-bean-id] \
    -s todo
done
```

### ❌ Rejected (<70% compliance or critical issues)

```markdown
## ❌ Architecture Validation: REJECTED

**Compliance Score:** [SCORE]%
**Status:** Not ready for production

**Critical Issues:**
[BLOCKING_ISSUES]

**Required Actions:**
1. [Fix 1]
2. [Fix 2]

DO NOT CREATE PR. Address critical issues first.
```

Update bean:
```bash
beans update [implementation-bean-id] --status in-progress
# Add critical issues as checklist items
```

## Step 6: Create Validation Report

Save to `architecture/[feature-name]-validation.md`:

```markdown
# Architecture Validation Report

**Feature:** [Name]
**Date:** [DATE]
**Validator:** Gemini 3 Pro
**Compliance Score:** [SCORE]%
**Decision:** ✅ Approved / ⚠️ Concerns / ❌ Rejected

## Summary

[OVERALL_ASSESSMENT]

## Architecture Compliance

[DETAILED_COMPLIANCE_CHECK]

## Trade-offs Analysis

[WERE_TRADEOFFS_RESPECTED]

## Technical Debt

[DEBT_INTRODUCED]

## Production Readiness

[GO_NO_GO_ASSESSMENT]

## Recommendations

[FUTURE_IMPROVEMENTS]

---

**Signature:** Gemini 3 Pro Strategic Architect
**Reviewed Files:** [COUNT] files, [LOC_CHANGED] lines changed
```

## Step 7: Update Architecture Bean

Mark as completed with validation results:

```bash
beans update [architecture-bean-id] --status completed

# Edit bean file to add validation summary
```
</process>

<success_criteria>
- Final validation completed
- Compliance score calculated
- Critical issues identified (if any)
- Validation report created
- Beans updated with results
- Decision made: Approve/Reject
</success_criteria>

<fallback_without_gemini>
If Gemini unavailable:
1. Claude does self-validation against architecture doc
2. Creates validation report (note: "Self-validated, Gemini unavailable")
3. Marks compliance as "Unknown" (proceed with caution)
4. Creates PR with note about missing strategic validation
</fallback_without_gemini>
