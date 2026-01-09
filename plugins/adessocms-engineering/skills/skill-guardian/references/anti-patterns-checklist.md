# Anti-Patterns Checklist

<overview>
Common problems to flag during skill audits. Each anti-pattern includes identification criteria and recommended fix.
</overview>

<critical_anti_patterns>

## Critical Issues (Must Fix)

### Missing YAML Frontmatter
**Identify:** SKILL.md doesn't start with `---`
**Impact:** Skill won't be properly indexed or triggered
**Fix:** Add valid YAML frontmatter with name and description

### Invalid Name Format
**Identify:** Name contains uppercase, underscores, spaces, or special characters
**Impact:** Inconsistent with ecosystem conventions
**Fix:** Convert to lowercase-with-hyphens

### Missing Required Tags
**Identify:** No `<objective>` or `<essential_principles>` tag
**Impact:** Skill lacks clear purpose statement
**Fix:** Add objective defining what skill does

### Broken File References
**Identify:** SKILL.md references workflows/ or references/ files that don't exist
**Impact:** Skill will fail when trying to load missing files
**Fix:** Create missing files or remove broken references

</critical_anti_patterns>

<high_anti_patterns>

## High Priority Issues (Should Fix)

### Markdown Headings in Body
**Identify:** Lines starting with `#`, `##`, `###` after YAML frontmatter
**Impact:** Inconsistent with XML structure standard
**Fix:** Convert to XML tags: `# Title` → `<title>`

### SKILL.md Over 500 Lines
**Identify:** `wc -l SKILL.md` returns >500
**Impact:** Too much content loaded at once, violates progressive disclosure
**Fix:** Split into workflows/ and references/ files

### Missing Success Criteria
**Identify:** No `<success_criteria>` or `<when_successful>` tag
**Impact:** No verifiable completion conditions
**Fix:** Add success_criteria with specific, verifiable outcomes

### Skippable Principles
**Identify:** Essential principles in separate file (e.g., `references/principles.md`)
**Impact:** Can be skipped if reference not loaded
**Fix:** Move essential principles inline in SKILL.md

### Complex Skill Without Router
**Identify:** Multiple workflows/features but no `<intake>` or `<routing>`
**Impact:** User doesn't know what options exist
**Fix:** Add router pattern with intake question and routing table

</high_anti_patterns>

<medium_anti_patterns>

## Medium Priority Issues (Recommended)

### Verbose Explanations
**Identify:** Paragraphs explaining common programming concepts
**Example:** "PDF files are a common file format used for documents..."
**Impact:** Wastes tokens on information Claude already knows
**Fix:** Remove explanations, keep only actionable content

### Vague Steps
**Identify:** Instructions like "handle appropriately" or "do the thing"
**Impact:** Claude must guess what to do
**Fix:** Provide specific, actionable instructions

### Untestable Criteria
**Identify:** Success criteria like "user is satisfied" or "works correctly"
**Impact:** Cannot verify if skill succeeded
**Fix:** Replace with specific, observable outcomes

### Redundant Content
**Identify:** Same information appears in multiple places
**Impact:** Wastes tokens, creates maintenance burden
**Fix:** Consolidate to single source of truth

### Inconsistent Tag Names
**Identify:** Using `<goal>` in one skill, `<objective>` in another
**Impact:** Reduces consistency across skill ecosystem
**Fix:** Standardize on official tag names

### Deeply Nested References
**Identify:** Reference files that link to other reference files
**Impact:** Progressive disclosure breaks down
**Fix:** Flatten to max one level deep from SKILL.md

</medium_anti_patterns>

<low_anti_patterns>

## Low Priority Issues (Polish)

### Description Lacks Triggers
**Identify:** Description says what but not when
**Example:** "Works with PDFs" vs "Use when processing PDF files"
**Fix:** Add specific trigger phrases

### Not Third Person
**Identify:** Description uses "I", "you", "we"
**Example:** "I help you with..." or "You can use this to..."
**Fix:** Rewrite in third person: "Use when..." or "This skill..."

### Missing Quick Start
**Identify:** No immediate actionable guidance
**Impact:** User must read entire skill to get started
**Fix:** Add `<quick_start>` with minimal working example

### Unnecessary Comments
**Identify:** Comments explaining obvious code
**Impact:** Token waste
**Fix:** Remove obvious comments, keep only non-obvious context

### Poor File Organization
**Identify:** Mix of workflows and references in root directory
**Impact:** Harder to navigate skill structure
**Fix:** Organize into workflows/, references/, templates/

</low_anti_patterns>

<detection_patterns>

## Detection Commands

```bash
# Find markdown headings in SKILL.md bodies
grep -n "^#" skills/*/SKILL.md

# Find skills over 500 lines
wc -l skills/*/SKILL.md | awk '$1 > 500'

# Find skills without success_criteria
grep -L "success_criteria" skills/*/SKILL.md

# Find skills without YAML frontmatter
head -1 skills/*/SKILL.md | grep -v "^---"

# Find potentially verbose content
grep -c "you should\|you can\|you will" skills/*/SKILL.md

# Find broken references
grep -h "workflows/\|references/" skills/*/SKILL.md | \
  while read line; do
    # Check if referenced file exists
  done
```

</detection_patterns>

<severity_guide>

## Severity Classification

| Severity | Definition | Action |
|----------|------------|--------|
| **Critical** | Skill is broken or won't function | Must fix immediately |
| **High** | Violates core best practices | Should fix soon |
| **Medium** | Suboptimal but functional | Recommended to fix |
| **Low** | Minor polish items | Nice to have |

</severity_guide>
