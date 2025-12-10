# Workflow: Verify Implementation

<purpose>
Verify that an implementation fully satisfies the original plan's requirements and acceptance criteria.
</purpose>

<when_to_use>
- At the end of `/work` workflow before creating PR
- After major implementation milestones
- When user asks to verify completeness
</when_to_use>

<process>
## Step 1: Check Gemini Availability

```bash
if ! which gemini >/dev/null 2>&1; then
  echo "SKIP: Gemini not available, continuing without implementation verification"
  exit 0
fi
```

## Step 2: Gather Materials

Collect:
- Original plan file
- Git diff of implementation
- List of files changed
- Test results (if available)

```bash
# Get implementation diff
git diff main...HEAD > /tmp/implementation.diff

# Get list of changed files
git diff --name-only main...HEAD > /tmp/changed-files.txt
```

## Step 3: Send to Gemini for Verification

```bash
gemini -y "Compare this implementation against the original plan.

For each acceptance criterion in the plan:
1. Is it implemented? (Yes/No/Partial)
2. Where in the code? (file:line if Yes)
3. What's missing? (if No or Partial)

Original Plan:
[INSERT_PLAN_CONTENT]

Changed Files:
[INSERT_CHANGED_FILES]

Implementation Diff:
[INSERT_DIFF_SUMMARY]

Provide:
- Completion percentage (X%)
- Implemented items (with file references)
- Missing items (with what's needed)
- Partially implemented items (with gaps)
- Any scope creep (things done not in plan)"
```

## Step 4: Generate Verification Report

```markdown
## Implementation Verification Report

**Plan:** [plan-file-path]
**Branch:** [branch-name]
**Completion:** [X]%

### Acceptance Criteria Status

| Criterion | Status | Location |
|-----------|--------|----------|
| [AC 1] | ✅ Complete | `src/file.php:42` |
| [AC 2] | ⚠️ Partial | Missing error handling |
| [AC 3] | ❌ Missing | Not implemented |

### Missing Items

1. **[Missing Item 1]**
   - What's needed: [description]
   - Suggested approach: [suggestion]

2. **[Missing Item 2]**
   - What's needed: [description]
   - Suggested approach: [suggestion]

### Scope Creep (Items Not in Plan)

- [Item not originally planned but implemented]

### Recommendation

[READY TO MERGE / NEEDS WORK / MAJOR GAPS]
```

## Step 5: Handle Results

**If 100% Complete:**
- Proceed with PR creation
- Note verification passed

**If Partially Complete:**
- Present missing items to user
- Ask: "Complete these items now, or proceed with partial implementation?"
- Use `AskUserQuestion` for decision

**If Major Gaps:**
- List all missing items
- Recommend completing before PR
- Create TodoWrite items for missing work

## Step 6: Update Todo List

If items are missing, add them to TodoWrite:

```
- [ ] [Missing item 1 from verification]
- [ ] [Missing item 2 from verification]
```
</process>

<success_criteria>
- Plan and implementation compared
- All acceptance criteria checked
- Missing items identified with specifics
- Completion percentage calculated
- User informed of status
- Missing work added to todo list if applicable
</success_criteria>
