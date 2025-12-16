---
name: acms-plan
description: Transform feature descriptions into well-structured project plans following conventions
argument-hint: "[feature description, bug report, or improvement idea]"
---

# Create a plan for a new feature or bug fix

**Note: The current year is 2025.**

## Feature Description

<feature_description> #$ARGUMENTS </feature_description>

**If the feature description above is empty, ask the user:** "What would you like to plan? Please describe the feature, bug fix, or improvement you have in mind."

Do not proceed until you have a clear feature description from the user.

---

## Planning Instructions

### 1. Analyze the Task

First, understand what's being asked:
- What is the core feature/fix being requested?
- What Drupal components are involved?
- Are there external systems or integrations?
- What files/modules need to be modified?

### 1b. DRY Analysis (ALWAYS)

**Before designing new components or abstractions, search for existing solutions:**

```bash
# Find existing SDC components
find web/themes/custom -name "*.component.yml" -exec basename {} .component.yml \;

# Search by keyword
grep -rl "button\|heading\|card" web/themes/custom/*/components/

# Check component usage
grep -r "include('my_theme:" web/themes/custom/*/templates/
```

**DRY Questions:**
- Does an existing component handle this? → Use it, add variant if needed
- Can we extend an existing pattern? → Prefer variants over new components
- Will this be used 3+ times? → Only then consider new abstraction
- Is there duplicate code that should be extracted? → Note for refactoring

### 2. Consult Specialists for Guidance

**For complex tasks, consult the relevant specialists to get correct patterns BEFORE implementing:**

| Task Type | Specialist | Usage |
|-----------|------------|-------|
| Drupal modules/services | `drupal-specialist` | API patterns, DI, caching |
| SDC components | `sdc-specialist` | Props vs slots, schemas |
| Twig templates | `twig-specialist` | Attributes, translations |
| Tailwind styling | `tailwind-specialist` | v4 syntax, responsive |
| Accessibility | `accessibility-specialist` | WCAG compliance |
| Security-sensitive | `security-sentinel` | Auth, input handling |
| Paragraphs | `paragraphs-specialist` | Field templates, SDC integration |

```
# Example: Get guidance before implementing
Task(subagent_type="adessocms-engineering:specialists:sdc-specialist",
     model="sonnet",
     prompt="How should I implement a card component with image slot and variant prop?")
```

### 3. Use Research Tools

**For web-based research (analyzing live websites, comparing designs, extracting HTML/CSS):**

```
Skill(skill="dev-browser")
```

The dev-browser skill provides browser automation for:
- Navigating to websites and taking screenshots
- Extracting HTML structure and CSS
- Comparing designs between sites
- Discovering page elements via ARIA snapshots
- Testing UI interactions

**For codebase research:**
- Use Grep/Glob to find relevant files
- Use Read to examine existing code patterns
- Check existing components in `web/themes/custom/*/components/`

**For Drupal documentation:**
- Use Context7 MCP for up-to-date Drupal docs
- Check contrib module documentation

### 4. Create the Plan

Write a comprehensive plan to `plans/<slug>.md` with this structure:

```markdown
---
date: YYYY-MM-DD
feature: [Short feature name]
---

# [feat|fix|refactor]: [Feature Title]

## Summary
[2-3 sentence description of what will be built/fixed]

## Research Findings

### [Source 1 - e.g., "Claroty.com Header Analysis"]
[Key findings from research]

### [Source 2 - e.g., "Existing Codebase Patterns"]
[Relevant patterns found in repo]

## Technical Approach
[How we will implement this - based on research findings]

## Specialist Guidance Required
[Which specialists should be consulted during implementation]

| Phase | Specialist | Purpose |
|-------|------------|---------|
| [Phase] | [specialist-name] | [Why needed] |

## Component Reuse Analysis (DRY)

### Existing Components to Leverage
- `my_theme:button` - [usage notes]
- `my_theme:heading` - [add variant if needed]
- `my_theme:card` - [base for new cards]

### New Components Required (with justification)
- `my_theme:feature-icon` - [why existing components insufficient, 3+ uses expected]

### Variants to Add to Existing Components
- `heading`: 'feature' variant - [description]
- `button`: 'outline' variant - [description]

## Implementation Steps

### Phase 1: [Phase Name]
- [ ] Step 1
- [ ] Step 2

### Phase 2: [Phase Name]
- [ ] Step 1
- [ ] Step 2

## Files to Modify/Create
- `path/to/file1.php` - [what changes]
- `path/to/file2.twig` - [what changes]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## References
- [Relevant links]
```

### 5. Open in Typora

After writing the plan:

```bash
open -a Typora "plans/<slug>.md"
```

---

## Example: Website Component Migration

When planning to migrate components from one website to another (like header/hero from claroty.com):

1. **Use dev-browser skill** to:
   - Navigate to source site and capture screenshots
   - Extract HTML structure using getAISnapshot()
   - Document CSS classes and styling
   - Identify all variants (e.g., hero variants)

2. **Analyze existing codebase** for:
   - Current component structure
   - Existing styling patterns (Tailwind classes)
   - Drupal field mappings
   - Icon handling (UI Icons module)

3. **Compare and document**:
   - What matches current implementation
   - What needs to be created new
   - What styling needs to change

4. **Create detailed implementation plan** with:
   - Component-by-component breakdown
   - Field mappings
   - CSS/Tailwind adjustments
   - Testing checklist

---

## Post-Plan Options

After creating the plan, offer:

1. **Start `/work`** - Begin implementing
2. **Run `/plan_review`** - Get feedback from reviewers
3. **Create Issue** - Create in GitHub/Linear
4. **Refine** - Add more detail to specific sections
