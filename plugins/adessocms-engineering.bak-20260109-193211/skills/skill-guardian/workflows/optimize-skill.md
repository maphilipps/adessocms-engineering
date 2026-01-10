# Workflow: Optimize Skill

<required_reading>
**Read these reference files NOW:**
1. `references/official-best-practices.md`
2. `references/anti-patterns-checklist.md`
</required_reading>

<objective>
Apply improvements to a skill based on audit findings.
All changes require explicit user approval.
</objective>

<process>

## Step 1: Get Audit Results

Either:
- Use results from previous audit (if just ran)
- Run `workflows/audit-skill-deep.md` first

Confirm skill name and issues list with user.

## Step 2: Group Issues by Severity

**Critical (must fix):**
- Missing YAML frontmatter
- Invalid name format
- Missing required XML tags
- Broken file references

**High (should fix):**
- Markdown headings in body
- SKILL.md over 500 lines
- Missing success_criteria
- Essential principles in separate file

**Medium (recommended):**
- Verbose explanations
- Missing router pattern for complex skill
- Inconsistent XML tag naming
- Redundant content

**Low (polish):**
- Description could be more specific
- Minor formatting issues
- Could add more trigger phrases

## Step 3: Present Optimization Plan

For each issue, show:

```markdown
### Issue #1: [Title]
**Severity:** Critical | High | Medium | Low
**Location:** SKILL.md:42
**Current:**
```
[current code]
```

**Proposed:**
```
[fixed code]
```

**Rationale:** [Why this fix follows best practices]
```

## Step 4: Get Approval

Ask: "Apply fixes?"

Options:
1. **Apply all** - Apply all fixes at once
2. **One by one** - Review each fix individually
3. **Critical only** - Apply only critical fixes
4. **Cancel** - No changes

## Step 5: Apply Fixes

For each approved fix:
1. Show the change being made
2. Apply the edit
3. Confirm success

## Step 6: Verify

After all fixes applied:
1. Re-run audit checklist
2. Show new score vs old score
3. List any remaining issues

```markdown
## Optimization Complete

**Before:** 65/100 (⚠️ Needs Improvement)
**After:** 92/100 (✅ Excellent)

**Changes applied:**
- Converted 5 markdown headings to XML tags
- Added success_criteria section
- Fixed YAML description to third person

**Remaining:**
- None (or list remaining low-priority items)
```

</process>

<safety>
**Never auto-apply changes.** Always show before/after and get approval.
**Create backup** by reading full file before modifications.
**Verify each edit** succeeded before proceeding to next.
</safety>

<success_criteria>
- Issues grouped by severity
- Each fix shown with before/after preview
- User approved changes explicitly
- Fixes applied cleanly
- Re-audit shows improved score
- No regressions introduced
</success_criteria>
