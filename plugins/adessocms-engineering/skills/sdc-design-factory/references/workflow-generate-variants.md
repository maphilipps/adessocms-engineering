# Workflow: Generate CVA Variants

Workflow for extending an existing SDC component with additional CVA variants.

## Prerequisites

- Existing SDC component with CVA already implemented
- Clear requirement for new variants (sizes, colors, states, orientations)

## Phase 1: Analyze Existing Component

### Step 1.1: Read Current CVA Structure

```bash
# Find the component
ddev exec find web/themes -name "component-name.twig" -type f
```

Extract current CVA definition:

```twig
{% set current = html_cva(
  base: [...],
  variants: {
    variant: {...},
    size: {...}
  }
) %}
```

### Step 1.2: Identify Variant Gaps

Document what's missing:

| Variant Type | Current Values | Needed Values |
|--------------|----------------|---------------|
| variant | primary, secondary | + ghost, destructive |
| size | sm, md, lg | + xs, xl |
| orientation | - | vertical, horizontal |

## Phase 2: Design New Variants

### Step 2.1: Write Variant Philosophy

For each new variant, write a brief design rationale:

**Ghost Variant:**
> The ghost variant recedes into the background, appearing only on interaction.
> It uses transparent backgrounds with subtle hover states, perfect for
> secondary actions that shouldn't compete for attention.

**Destructive Variant:**
> The destructive variant signals danger or irreversibility. It uses the
> destructive color palette with high contrast, ensuring users notice
> before committing to dangerous actions.

### Step 2.2: Define Tailwind Classes

Map each new variant to specific classes:

```yaml
new_variants:
  variant:
    ghost:
      base: "bg-transparent text-foreground"
      hover: "hover:bg-accent hover:text-accent-foreground"
      active: "active:bg-accent/80"
      focus: "focus-visible:ring-ring"

    destructive:
      base: "bg-destructive text-destructive-foreground"
      hover: "hover:bg-destructive/90"
      active: "active:bg-destructive/80"
      focus: "focus-visible:ring-destructive"

  size:
    xs:
      height: "h-7"
      padding: "px-2"
      text: "text-xs"
      radius: "rounded"
      gap: "gap-1"

    xl:
      height: "h-14"
      padding: "px-8"
      text: "text-xl"
      radius: "rounded-2xl"
      gap: "gap-4"
```

### Step 2.3: Consider Compound Variants

Identify combinations that need special treatment:

```yaml
compound_variants:
  - condition:
      variant: destructive
      size: lg
    classes: "shadow-lg shadow-destructive/25"

  - condition:
      variant: ghost
      size: xs
    classes: "px-1" # Less padding for tiny ghost buttons
```

## Phase 3: Implementation

### Step 3.1: Update CVA Definition

Edit the Twig file:

```twig
{% set button = html_cva(
  base: [
    'inline-flex items-center justify-center',
    'font-medium transition-colors duration-200',
    'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2'
  ],
  variants: {
    variant: {
      primary: 'bg-primary text-primary-foreground hover:bg-primary/90',
      secondary: 'bg-secondary text-secondary-foreground hover:bg-secondary/80',
      {# NEW VARIANTS #}
      ghost: 'bg-transparent text-foreground hover:bg-accent hover:text-accent-foreground',
      destructive: 'bg-destructive text-destructive-foreground hover:bg-destructive/90'
    },
    size: {
      {# NEW SIZE #}
      xs: 'h-7 px-2 text-xs rounded gap-1',
      sm: 'h-8 px-3 text-sm rounded-md gap-1.5',
      md: 'h-10 px-4 text-base rounded-lg gap-2',
      lg: 'h-12 px-6 text-lg rounded-xl gap-2.5',
      {# NEW SIZE #}
      xl: 'h-14 px-8 text-xl rounded-2xl gap-4'
    }
  },
  compound_variants: [
    {
      variant: ['primary', 'secondary'],
      size: ['lg', 'xl'],
      class: 'shadow-md hover:shadow-lg'
    },
    {
      variant: ['destructive'],
      size: ['lg', 'xl'],
      class: 'shadow-lg shadow-destructive/25'
    },
    {
      variant: ['ghost'],
      size: ['xs'],
      class: 'px-1'
    }
  ]
) %}
```

### Step 3.2: Update component.yml Schema

Add new enum values:

```yaml
props:
  properties:
    variant:
      type: string
      title: Style Variant
      enum:
        - primary
        - secondary
        - ghost        # NEW
        - destructive  # NEW
      default: primary
      meta:enum:
        primary: "Primary - Main action"
        secondary: "Secondary - Supporting action"
        ghost: "Ghost - Minimal styling"           # NEW
        destructive: "Destructive - Danger action" # NEW

    size:
      type: string
      title: Size
      enum:
        - xs  # NEW
        - sm
        - md
        - lg
        - xl  # NEW
      default: md
      meta:enum:
        xs: "Extra Small (28px)"  # NEW
        sm: "Small (32px)"
        md: "Medium (40px)"
        lg: "Large (48px)"
        xl: "Extra Large (56px)"  # NEW
```

### Step 3.3: Add CSS for Complex Variants (if needed)

For variants requiring animations or pseudo-elements:

```css
@layer components;

/* Destructive variant pulsing effect */
.button--destructive-pulse {
  animation: destructive-pulse 2s ease-in-out infinite;
}

@keyframes destructive-pulse {
  0%, 100% { box-shadow: 0 0 0 0 rgb(var(--destructive) / 0.4); }
  50% { box-shadow: 0 0 0 8px rgb(var(--destructive) / 0); }
}
```

## Phase 4: Testing New Variants

### Step 4.1: Visual Verification

For each new variant, verify:

- [ ] Base state renders correctly
- [ ] Hover state is visible and appropriate
- [ ] Focus state has proper ring
- [ ] Active/pressed state provides feedback
- [ ] Disabled state is visually distinct

### Step 4.2: Cross-Variant Consistency

Check that new variants harmonize with existing:

```twig
{# Test grid of all combinations #}
<div class="grid grid-cols-5 gap-4">
  {% for variant in ['primary', 'secondary', 'ghost', 'destructive'] %}
    {% for size in ['xs', 'sm', 'md', 'lg', 'xl'] %}
      {% include 'theme:button' with {
        variant: variant,
        size: size,
        label: variant ~ ' ' ~ size
      } %}
    {% endfor %}
  {% endfor %}
</div>
```

### Step 4.3: Accessibility Check

For each new variant:

- [ ] Contrast ratio meets 4.5:1 (or 3:1 for large text)
- [ ] Focus indicator is visible against new backgrounds
- [ ] Disabled state still meets minimum contrast

### Step 4.4: Update Storybook

Add stories for new variants:

```javascript
export const AllVariants = () => html`
  <div class="flex flex-wrap gap-4">
    ${['primary', 'secondary', 'ghost', 'destructive'].map(variant => html`
      <button-component variant="${variant}">
        ${variant}
      </button-component>
    `)}
  </div>
`;

export const AllSizes = () => html`
  <div class="flex items-center gap-4">
    ${['xs', 'sm', 'md', 'lg', 'xl'].map(size => html`
      <button-component size="${size}">
        ${size}
      </button-component>
    `)}
  </div>
`;

export const DestructiveVariant = {
  args: {
    variant: 'destructive',
    label: 'Delete Account'
  }
};
```

## Phase 5: Documentation

### Step 5.1: Update Component Description

In component.yml, update the description to mention new variants:

```yaml
description: |
  Button component with five variants (primary, secondary, ghost, destructive)
  and five sizes (xs, sm, md, lg, xl). Use destructive variant for dangerous
  actions like deletion.
```

### Step 5.2: Add Usage Examples

Document when to use each variant:

```markdown
## Variant Usage

| Variant | When to Use |
|---------|-------------|
| primary | Main call-to-action, form submission |
| secondary | Supporting actions, cancel buttons |
| ghost | Inline actions, less prominent buttons |
| destructive | Delete, remove, dangerous operations |

## Size Usage

| Size | When to Use |
|------|-------------|
| xs | Compact UIs, table rows, tight spaces |
| sm | Secondary buttons, mobile interfaces |
| md | Standard buttons, forms (default) |
| lg | Hero CTAs, prominent actions |
| xl | Hero sections, marketing pages |
```

## Output Checklist

After completing this workflow:

- [ ] CVA definition includes all new variants
- [ ] component.yml schema updated with new enum values
- [ ] meta:enum labels provided for UI
- [ ] CSS file updated if complex variants needed
- [ ] All variants tested visually
- [ ] Accessibility verified for all variants
- [ ] Storybook stories added
- [ ] Documentation updated
