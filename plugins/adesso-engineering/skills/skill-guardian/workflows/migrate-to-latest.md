# Workflow: Migrate to Latest Patterns

<required_reading>
**Read these reference files NOW:**
1. `references/migration-patterns.md`
2. `references/official-best-practices.md`
</required_reading>

<objective>
Update skills from pre-Opus 4.5 patterns to current best practices.
Apply transformations with before/after preview.
</objective>

<process>

## Step 1: Identify Migration Candidates

Signs of outdated patterns:
- Markdown headings (#, ##, ###) in SKILL.md body
- Missing `<success_criteria>` tag
- Verbose explanations where concise would work
- Complex skill without router pattern (intake/routing)
- SKILL.md over 500 lines without references/
- Essential principles in separate file instead of inline
- Missing third-person description

Scan skills:
```bash
# Find markdown headings in SKILL.md bodies
grep -l "^#" skills/*/SKILL.md

# Find skills over 500 lines
wc -l skills/*/SKILL.md | awk '$1 > 500'

# Find skills without success_criteria
grep -L "success_criteria" skills/*/SKILL.md
```

## Step 2: Select Skill to Migrate

Present candidates:
```
Skills needing migration:

1. skill-a - Markdown headings, no success_criteria
2. skill-b - Over 600 lines, needs split
3. skill-c - Verbose explanations

Which skill to migrate? (number, name, or "all")
```

## Step 3: Analyze Current State

For selected skill:
1. Read full SKILL.md
2. Identify all outdated patterns
3. Plan transformations needed

## Step 4: Apply Migrations

### Migration: Markdown → XML

**Pattern:** `## Section Name` → `<section_name>`

Before:
```markdown
## Quick Start

Here's how to get started...

## Workflow

1. First step
2. Second step
```

After:
```xml
<quick_start>
Here's how to get started...
</quick_start>

<workflow>
1. First step
2. Second step
</workflow>
```

### Migration: Add Success Criteria

**Pattern:** Add `<success_criteria>` section if missing

Insert before closing of SKILL.md:
```xml
<success_criteria>
- [Verifiable outcome 1]
- [Verifiable outcome 2]
- [Verifiable outcome 3]
</success_criteria>
```

### Migration: Verbose → Concise

**Pattern:** Remove unnecessary explanation

Before:
```
PDF files are a common file format used for documents. To extract
text from them, we'll use a Python library called pdfplumber.
First, you'll need to import the library...
```

After:
```
Extract PDF text with pdfplumber:
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
```

### Migration: Split Long SKILL.md

**Pattern:** Move detailed content to references/

1. Keep essential principles inline (required)
2. Move detailed procedures → workflows/
3. Move domain knowledge → references/
4. Keep SKILL.md as router under 500 lines

### Migration: Add Router Pattern

**Pattern:** Complex skill needs intake/routing

Add:
```xml
<intake>
What would you like to do?

1. [Option A]
2. [Option B]
3. [Option C]

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Action | Workflow |
|----------|--------|----------|
| 1, "a" | [Description] | workflows/option-a.md |
| 2, "b" | [Description] | workflows/option-b.md |
| 3, "c" | [Description] | workflows/option-c.md |
</routing>
```

## Step 5: Preview Changes

Show before/after for each transformation:

```markdown
### Transformation #1: Markdown → XML

**Lines affected:** 15-42

**Before:**
[snippet]

**After:**
[snippet]

Apply this change? [y/n]
```

## Step 6: Apply with Approval

For each approved transformation:
1. Apply the edit
2. Verify syntax is valid
3. Show confirmation

## Step 7: Verify Migration

After all transformations:
1. Re-run audit checklist
2. Compare old vs new score
3. Confirm skill works correctly

```markdown
## Migration Complete: skill-name

**Before:** 62/100 (⚠️ Needs Improvement)
**After:** 88/100 (✅ Good)

**Transformations applied:**
- Converted 8 markdown headings to XML tags
- Added success_criteria section
- Reduced verbosity by 40%
- Split into router pattern with 3 workflows

**Skill is now Opus 4.5 compatible.**
```

</process>

<success_criteria>
- Outdated patterns identified
- Migration plan created with before/after
- User approved each transformation
- Changes applied cleanly
- Re-audit shows improved score
- Skill follows current best practices
</success_criteria>
