# Quality Review Workflow

<required_reading>
Read before proceeding:
- references/sdc-standards.md
- references/coding-guidelines.md
</required_reading>

<objective>
Ensure components meet adesso CMS quality standards for SDC structure,
coding standards, accessibility, and scalability.
</objective>

<process>
## Step 1: Identify Review Target

Ask user:
- "Which component(s) should I review?"
- Or: "Review all components?"

## Step 2: SDC Structure Check

For each component, verify required files:

```bash
COMP_DIR="/Users/marc.philipps/Sites/adesso-cms/web/themes/custom/adesso_cms_theme/components"

for comp in "$COMP_DIR"/*/; do
  name=$(basename "$comp")
  echo "=== $name ==="

  # Required files
  [ -f "$comp/$name.component.yml" ] && echo "✅ Schema" || echo "❌ Missing schema"
  [ -f "$comp/$name.twig" ] && echo "✅ Template" || echo "❌ Missing template"
  [ -f "$comp/$name.stories.js" ] && echo "✅ Story" || echo "❌ Missing story"

  # Optional but recommended
  [ -f "$comp/$name.css" ] && echo "📝 Has CSS" || echo "⚪ No CSS"
  [ -f "$comp/$name.js" ] && echo "📝 Has JS" || echo "⚪ No JS"
  [ -f "$comp/README.md" ] && echo "📝 Has README" || echo "⚪ No README"
done
```

## Step 3: Schema Validation

Check .component.yml files:
- Has valid $schema reference
- Defines name and description
- Props have proper types
- Required props marked
- Slots documented if used

## Step 4: Code Quality

Run linters:
```bash
cd /Users/marc.philipps/Sites/adesso-cms
ddev eslint
ddev stylelint
ddev phpcs
```

## Step 5: Storybook Validation

```bash
ddev story-check
```

Verify each story:
- Has default variant
- Shows all prop variations
- Includes edge cases (empty, long text, etc.)
- Has accessibility controls

## Step 6: Accessibility Check

For each component:
- Semantic HTML used
- ARIA attributes where needed
- Keyboard navigable
- Color contrast sufficient
- Focus states visible

## Step 7: Generate Quality Report

```markdown
## Quality Review Report - [DATE]

### Summary
- Components reviewed: X
- Passing: Y
- Issues found: Z

### Component Status

| Component | Schema | Template | Story | Lint | A11y | Overall |
|-----------|--------|----------|-------|------|------|---------|
| accordion | ✅ | ✅ | ✅ | ✅ | ✅ | PASS |
| badge | ✅ | ✅ | ❌ | ✅ | ✅ | NEEDS WORK |
| ... | ... | ... | ... | ... | ... | ... |

### Issues to Address

#### Critical (Blocks release)
1. [component]: [issue]

#### Important (Should fix)
1. [component]: [issue]

#### Minor (Nice to fix)
1. [component]: [issue]

### Recommendations
1. ...
```

## Step 8: Propose Fixes

For issues found:
- "Shall I create tickets for these issues?"
- "Should I fix [specific issue] now?"
</process>

<quality_gates>
## Must Pass (Required)
- ✅ .component.yml exists with valid schema
- ✅ .twig template exists
- ✅ .stories.js exists with default story
- ✅ No ESLint/Stylelint errors
- ✅ Renders without console errors

## Should Pass (Recommended)
- 📝 All props documented in schema
- 📝 Multiple story variants
- 📝 README with usage examples
- 📝 Accessibility tested
- 📝 Responsive design verified
</quality_gates>

<success_criteria>
- All components inventoried
- Quality status documented
- Issues categorized by severity
- Actionable recommendations provided
- User informed of next steps
</success_criteria>
