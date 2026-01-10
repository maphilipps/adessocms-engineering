# Migration Patterns

<overview>
Transformations from pre-Opus 4.5 patterns to current best practices.
Each pattern shows before/after with rationale.
</overview>

<pattern_markdown_to_xml>

## Pattern: Markdown Headings → XML Tags

**Era:** Pre-2024 skills used markdown headings
**Current:** Pure XML structure is standard

**Before:**
```markdown
---
name: my-skill
description: Does things
---

# Objective

Help users do the thing.

## Quick Start

Here's how to start:

1. First step
2. Second step

## Workflow

### Step 1: Setup

Configure the environment.

### Step 2: Execute

Run the commands.

## Success Criteria

- Thing works
- User happy
```

**After:**
```xml
---
name: my-skill
description: Does things
---

<objective>
Help users do the thing.
</objective>

<quick_start>
Here's how to start:

1. First step
2. Second step
</quick_start>

<workflow>
<step_1_setup>
Configure the environment.
</step_1_setup>

<step_2_execute>
Run the commands.
</step_2_execute>
</workflow>

<success_criteria>
- Thing works
- User happy
</success_criteria>
```

**Transformation rules:**
- `# Title` → `<title>` (lowercase, underscores for spaces)
- `## Section` → `<section>`
- `### Subsection` → `<subsection>` or nested tag
- Keep markdown formatting WITHIN tags (bold, lists, code)

</pattern_markdown_to_xml>

<pattern_add_success_criteria>

## Pattern: Missing Success Criteria → Add

**Era:** Early skills omitted completion conditions
**Current:** success_criteria is required

**Before:**
```xml
<workflow>
1. Do the thing
2. Check the result
</workflow>
```

**After:**
```xml
<workflow>
1. Do the thing
2. Check the result
</workflow>

<success_criteria>
- Output matches expected format
- No errors in console
- User confirms completion
</success_criteria>
```

**How to write good criteria:**
1. Make them verifiable (can be checked objectively)
2. Make them specific (not "works correctly")
3. Cover key outcomes (not every detail)

</pattern_add_success_criteria>

<pattern_verbose_to_concise>

## Pattern: Verbose → Concise

**Era:** Over-explanation was common
**Current:** Assume Claude is smart

**Before:**
```xml
<quick_start>
PDF files are a common file format used for sharing documents
across different platforms. They preserve formatting and are
widely used in business contexts. To extract text from PDF files,
we'll use a Python library called pdfplumber. This library is
specifically designed for extracting text, tables, and other
content from PDF documents.

First, you'll need to install pdfplumber using pip:
```bash
pip install pdfplumber
```

Next, you'll need to import the library at the top of your
Python file. Then, open the PDF file using the pdfplumber.open()
method. This returns a PDF object that you can work with.

Here's the complete code:
```python
import pdfplumber

with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
    print(text)
```

This code opens the PDF, extracts text from the first page,
and prints it to the console.
</quick_start>
```

**After:**
```xml
<quick_start>
Extract PDF text with pdfplumber:

```python
import pdfplumber

with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```

For scanned PDFs requiring OCR, use pdf2image with pytesseract.
</quick_start>
```

**Transformation rules:**
- Remove explanations of common concepts
- Remove step-by-step descriptions of obvious code
- Keep only actionable content
- Add notes for non-obvious edge cases

</pattern_verbose_to_concise>

<pattern_add_router>

## Pattern: Monolithic → Router Pattern

**Era:** Single large SKILL.md with everything
**Current:** Router pattern for complex skills

**Before:**
```xml
<objective>
This skill handles multiple tasks related to widgets.
</objective>

<creating_widgets>
[200 lines of widget creation instructions]
</creating_widgets>

<editing_widgets>
[150 lines of widget editing instructions]
</editing_widgets>

<deleting_widgets>
[100 lines of widget deletion instructions]
</deleting_widgets>

<widget_best_practices>
[150 lines of best practices]
</widget_best_practices>
```

**After:**
```
widget-skill/
├── SKILL.md (router)
├── workflows/
│   ├── create-widget.md
│   ├── edit-widget.md
│   └── delete-widget.md
└── references/
    └── best-practices.md
```

**SKILL.md becomes:**
```xml
<essential_principles>
[Key principles that always apply - inline]
</essential_principles>

<intake>
What would you like to do with widgets?

1. Create a widget
2. Edit an existing widget
3. Delete a widget

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Action | Workflow |
|----------|--------|----------|
| 1, "create" | Create new widget | workflows/create-widget.md |
| 2, "edit" | Edit widget | workflows/edit-widget.md |
| 3, "delete" | Delete widget | workflows/delete-widget.md |
</routing>
```

**Transformation rules:**
- Essential principles stay inline (required)
- Each major workflow → separate file
- Reference content → references/ directory
- SKILL.md becomes router under 200 lines

</pattern_add_router>

<pattern_split_long_skill>

## Pattern: >500 Lines → Split

**Era:** Everything in one file
**Current:** Progressive disclosure with references

**Identification:**
```bash
wc -l skills/*/SKILL.md | awk '$1 > 500'
```

**Strategy:**

1. **Identify content types:**
   - Procedures → workflows/
   - Domain knowledge → references/
   - Output formats → templates/
   - Executable code → scripts/

2. **Keep in SKILL.md:**
   - YAML frontmatter
   - Essential principles (inline)
   - Intake/routing (if router)
   - Quick reference summary
   - Indexes to other files

3. **Split rules:**
   - Each workflow: 50-150 lines
   - Each reference: 100-300 lines
   - SKILL.md: under 200 lines ideal, max 500

</pattern_split_long_skill>

<pattern_inline_principles>

## Pattern: External Principles → Inline

**Era:** Principles in separate reference file
**Current:** Essential principles inline in SKILL.md

**Before:**
```
skill/
├── SKILL.md
└── references/
    └── principles.md  # ← Skippable!
```

**After:**
```xml
<!-- In SKILL.md -->
<essential_principles>
[Previously in references/principles.md]
[Now inline and cannot be skipped]
</essential_principles>
```

**Why this matters:**
- Reference files are loaded on-demand
- Essential principles must ALWAYS apply
- Inline ensures they're never skipped

</pattern_inline_principles>

<pattern_third_person_description>

## Pattern: First/Second Person → Third Person

**Era:** Descriptions used "I" or "you"
**Current:** Third person with trigger phrases

**Before:**
```yaml
description: I help you work with PDFs. You can use me to extract text,
  merge files, or convert formats.
```

**After:**
```yaml
description: Processes PDF documents for text extraction, merging, and
  format conversion. Use when working with PDF files, extracting text
  from documents, or combining multiple PDFs into one.
```

**Transformation rules:**
- Remove "I", "you", "we", "me"
- Start with what it does (verb phrase)
- Add "Use when..." with specific triggers
- Include concrete scenarios

</pattern_third_person_description>

<migration_checklist>

## Migration Checklist

Before migration:
- [ ] Read entire skill to understand scope
- [ ] Identify all patterns needing migration
- [ ] Plan file splits if needed

During migration:
- [ ] Convert markdown headings → XML tags
- [ ] Add missing success_criteria
- [ ] Remove verbose explanations
- [ ] Move essential principles inline
- [ ] Split >500 line files
- [ ] Add router pattern if multiple workflows
- [ ] Update description to third person

After migration:
- [ ] Re-run audit to verify improvement
- [ ] Test skill with real usage
- [ ] Update any documentation references

</migration_checklist>
