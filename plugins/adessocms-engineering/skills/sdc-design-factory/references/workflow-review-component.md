# Workflow: Review Component Design

Workflow for conducting a comprehensive design review of an SDC component.

## Prerequisites

- Component exists with all required files
- Component renders without errors
- Basic functionality works

## Phase 1: File Structure Review

### Step 1.1: Verify SDC Structure

Check that component follows Mercury conventions:

```bash
COMPONENT="component-name"
THEME_PATH="web/themes/custom/theme_name/components/$COMPONENT"

# Required files
ls -la "$THEME_PATH/$COMPONENT.component.yml"
ls -la "$THEME_PATH/$COMPONENT.twig"

# Optional files
ls -la "$THEME_PATH/$COMPONENT.tailwind.css" 2>/dev/null
ls -la "$THEME_PATH/$COMPONENT.js" 2>/dev/null
ls -la "$THEME_PATH/assets/" 2>/dev/null
```

### Step 1.2: Check for Anti-Patterns

Verify no forbidden files exist:

```bash
# Should NOT exist
ls "$THEME_PATH/$COMPONENT.libraries.yml" 2>/dev/null && echo "ERROR: Separate .libraries.yml found!"
ls "$THEME_PATH/$COMPONENT.css" 2>/dev/null && echo "WARNING: Raw CSS instead of Tailwind"
```

## Phase 2: Schema Review (component.yml)

### Step 2.1: Metadata Completeness

```yaml
# Required fields
"$schema": "..."  # ✓ Present?
name: "..."       # ✓ Descriptive name?
group: "..."      # ✓ Appropriate category?
description: "..." # ✓ Clear explanation?
```

### Step 2.2: Props Quality

For each prop, verify:

| Check | Question |
|-------|----------|
| Type | Is the correct JSON Schema type used? |
| Title | Is there a human-readable title? |
| Description | Is there a helpful description? |
| Default | Is there a sensible default value? |
| Examples | Are there realistic examples? |
| Enum | For strings, are valid options enumerated? |
| meta:enum | Are there UI-friendly labels? |

### Step 2.3: Required Props

Verify only truly required props are marked:

```yaml
props:
  type: object
  required:
    - variant  # Is this really required, or can it have a default?
  properties:
    # ...
```

### Step 2.4: Slots Documentation

```yaml
slots:
  default:
    title: "Content"         # ✓ Clear title?
    description: "Main..."   # ✓ Helpful description?
```

## Phase 3: Template Review (*.twig)

### Step 3.1: CVA Implementation

```twig
{# Check for proper CVA usage #}
{% set component = html_cva(
  base: [...],    # ✓ Base classes defined?
  variants: {...}, # ✓ All variants from schema?
  compound_variants: [...] # Optional: Complex combinations?
) %}
```

**Verify:**
- [ ] All props from schema have corresponding CVA variants
- [ ] Base classes include common styles (transition, focus, etc.)
- [ ] No manual class concatenation outside CVA

### Step 3.2: Props Normalization

```twig
{# At top of template #}
{% set variant = variant|default('primary') %}
{% set size = size|default('md') %}
```

**Verify:**
- [ ] All props have defaults matching schema
- [ ] Variable names are clear and consistent

### Step 3.3: Semantic HTML

**Check for anti-patterns:**

```twig
{# BAD #}
<div onclick="...">
<div class="button">
<span class="heading">

{# GOOD #}
<button type="button">
<article class="card">
<h2 class="heading">
```

### Step 3.4: Slot Implementation

```twig
{# Proper slot blocks #}
{% block default %}{% endblock %}

{# Conditional slot rendering #}
{% set header %}{% block header %}{% endblock %}{% endset %}
{% if header|trim is not empty %}
  <header>{{ header }}</header>
{% endif %}
```

## Phase 4: Accessibility Review

### Step 4.1: ARIA Implementation

Run through checklist:

- [ ] `aria-label` on icon-only buttons
- [ ] `aria-expanded` on toggles
- [ ] `aria-controls` linking triggers to content
- [ ] `aria-hidden="true"` on decorative elements
- [ ] Unique IDs via `|clean_unique_id`

### Step 4.2: Keyboard Navigation

Test in browser:

- [ ] Tab focuses all interactive elements
- [ ] Enter/Space activates buttons
- [ ] Escape closes modals/dropdowns
- [ ] Arrow keys navigate where expected
- [ ] No keyboard traps

### Step 4.3: Focus Indicators

```twig
{# Verify focus classes present #}
focus-visible:outline-none
focus-visible:ring-2
focus-visible:ring-ring
focus-visible:ring-offset-2
```

### Step 4.4: Color Contrast

Use axe DevTools or similar to verify:

- [ ] Text contrast ≥ 4.5:1 (normal) or ≥ 3:1 (large)
- [ ] UI component contrast ≥ 3:1
- [ ] Focus indicator contrast ≥ 3:1

### Step 4.5: Screen Reader Testing

- [ ] Component announces correctly in VoiceOver/NVDA
- [ ] Dynamic content updates announced
- [ ] No redundant or confusing announcements

## Phase 5: Visual Design Review

### Step 5.1: Design Philosophy Alignment

If design philosophy exists, verify component matches:

- [ ] Form & space as described
- [ ] Color usage as specified
- [ ] Motion matches philosophy
- [ ] Craftsmanship quality achieved

### Step 5.2: Anti-Pattern Check

Verify absence of:

- [ ] Centered everything (asymmetry used intentionally)
- [ ] Generic purple gradients
- [ ] Uniform rounded corners
- [ ] Generic Inter font
- [ ] Overlapping without z-index
- [ ] Hardcoded colors
- [ ] Inline styles

### Step 5.3: State Completeness

All states present and visible:

- [ ] Default/rest state
- [ ] Hover state
- [ ] Focus state
- [ ] Active/pressed state
- [ ] Disabled state (if applicable)
- [ ] Loading state (if applicable)
- [ ] Error state (if applicable)

### Step 5.4: Responsive Behavior

Test at all breakpoints:

| Breakpoint | Width | Check |
|------------|-------|-------|
| Mobile | 320px | Readable, usable |
| Mobile | 375px | No overflow |
| sm | 640px | Tablet transition |
| md | 768px | Proper layout |
| lg | 1024px | Desktop layout |
| xl | 1280px | Wide screen |
| 2xl | 1536px | No stretching |

### Step 5.5: Dark Mode

- [ ] Component works in dark mode
- [ ] Colors from theme variables
- [ ] Sufficient contrast maintained
- [ ] Images/media handle dark mode

## Phase 6: Code Quality Review

### Step 6.1: CVA Best Practices

```twig
{# ✓ Arrays for base classes #}
base: [
  'class-one',
  'class-two'
]

{# ✓ Objects for variants #}
variants: {
  size: {
    sm: '...',
    md: '...'
  }
}
```

### Step 6.2: No Hardcoded Values

Search for anti-patterns:

```twig
{# BAD #}
style="color: #3b82f6"
class="text-[#3b82f6]"
class="w-[342px]"

{# GOOD #}
class="text-primary"
class="w-full max-w-sm"
```

### Step 6.3: JavaScript Quality (if applicable)

```javascript
// ✓ ES6 module
import { ComponentType, ComponentInstance } from "../../lib/component.js";

// ✓ Proper class structure
class Component extends ComponentInstance {
  init() { /* setup */ }
  destroy() { /* cleanup */ }
}

// ✓ Proper registration
new ComponentType(Component, "name", "[data-selector]");
```

### Step 6.4: CSS Quality (if applicable)

```css
/* ✓ Layer declaration */
@layer components;

/* ✓ Component-scoped selectors */
.component-name--modifier { }

/* ✓ Using @apply for Tailwind */
.complex-style {
  @apply flex items-center gap-2;
}
```

## Phase 7: Documentation Review

### Step 7.1: Component Description

```yaml
description: |
  [Clear explanation of purpose]
  [When to use]
  [Key variants and their purposes]
```

### Step 7.2: Prop Descriptions

Each prop should explain:
- What it controls
- When to change from default
- Any constraints or gotchas

### Step 7.3: Example Assets

If component uses media:
- [ ] Example images in `assets/`
- [ ] Proper dimensions
- [ ] Appropriate file sizes

## Review Summary Template

```markdown
# Component Review: [Component Name]

## Overview
- **Status:** [Pass / Needs Work / Major Issues]
- **Reviewer:** [Name]
- **Date:** [Date]

## File Structure
- [ ] component.yml present
- [ ] twig template present
- [ ] No forbidden files

## Schema (component.yml)
- [ ] Metadata complete
- [ ] Props well-defined
- [ ] Slots documented

## Template (*.twig)
- [ ] CVA properly implemented
- [ ] Props normalized
- [ ] Semantic HTML
- [ ] Slots correct

## Accessibility
- [ ] ARIA attributes
- [ ] Keyboard navigation
- [ ] Focus indicators
- [ ] Contrast passes

## Visual Design
- [ ] Matches philosophy
- [ ] No anti-patterns
- [ ] All states present
- [ ] Responsive complete
- [ ] Dark mode works

## Code Quality
- [ ] CVA best practices
- [ ] No hardcoded values
- [ ] Clean JavaScript
- [ ] Proper CSS

## Issues Found
1. [Issue description] - [Severity: Critical/Major/Minor]
2. ...

## Recommendations
1. [Specific improvement suggestion]
2. ...
```

## Output

After completing this workflow:

- [ ] Review summary document created
- [ ] Issues logged with severity
- [ ] Recommendations provided
- [ ] Follow-up tasks identified
