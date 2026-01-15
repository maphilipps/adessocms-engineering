# Add Variant to Existing Component

## Required Reading
Before starting, load:
- `../references/cva-patterns.md` - CVA syntax and patterns
- `../references/tailwind-v4.md` - Tailwind class reference

---

## Input Gathering

Ask user:
1. **Which component?** (name or path)
2. **What variant to add?** (theme, size, layout, state)
3. **Variant values?** (e.g., `primary`, `secondary`, `outline`)
4. **Expected visual differences?** (colors, spacing, structure)

---

## Process

### Step 1: Read Existing Component

```bash
# Find component
find web/themes/custom -name "<component>.component.yml" -type f
```

Read current files:
- `<component>.component.yml` - Current props schema
- `<component>.twig` - Current CVA setup

### Step 2: Analyze Current CVA

Look for existing `html_cva()` call:

```twig
{% set button = html_cva(
  base: ['...existing base classes...'],
  variants: {
    variant: {
      primary: '...',
      secondary: '...'
    }
    {# We'll add new variant axis here #}
  }
) %}
```

### Step 3: Update component.yml

Add new prop to schema:

```yaml
props:
  type: object
  properties:
    # Existing props...

    # NEW: Add variant prop
    <new_variant>:
      type: string
      enum: ['value1', 'value2', 'value3']
      default: 'value1'
      title: <Variant Title>
      description: <What this variant controls>
```

### Step 4: Update CVA in Twig

Add new variant axis:

```twig
{% set component = html_cva(
  base: ['existing', 'base', 'classes'],
  variants: {
    {# Existing variants #}
    existingVariant: {
      option1: '...',
      option2: '...'
    },

    {# NEW: Add variant axis #}
    <new_variant>: {
      value1: 'classes for value1',
      value2: 'classes for value2',
      value3: 'classes for value3'
    }
  },

  {# Optional: Compound variants for combinations #}
  compoundVariants: [
    {
      variant: 'primary',
      <new_variant>: 'value1',
      class: 'special-combination-classes'
    }
  ]
) %}
```

### Step 5: Update Template Usage

Ensure the new prop is passed to CVA apply:

```twig
<div class="{{ component.apply({
  existingVariant: existingVariant,
  <new_variant>: <new_variant>
}) }}">
```

### Step 6: Build and Test

```bash
ddev theme build && ddev drush cr
```

### Step 7: Visual Verification

Test each variant value:

```
mcp__claude-in-chrome__navigate(url="<component_url>?variant=value1", ...)
mcp__claude-in-chrome__computer(action="screenshot", ...)
```

Repeat for each variant value.

---

## CVA Pattern Reference

### Simple Variants
```twig
{% set btn = html_cva(
  base: ['inline-flex', 'font-medium'],
  variants: {
    size: {
      sm: 'h-8 px-3 text-sm',
      md: 'h-10 px-4 text-base',
      lg: 'h-12 px-6 text-lg'
    }
  }
) %}
```

### Boolean Variants
```twig
{% set card = html_cva(
  base: ['rounded-lg', 'p-4'],
  variants: {
    elevated: {
      true: 'shadow-lg',
      false: 'shadow-none border'
    }
  }
) %}
```

### Compound Variants
```twig
{% set alert = html_cva(
  base: ['p-4', 'rounded'],
  variants: {
    type: { info: 'bg-blue-50', warning: 'bg-yellow-50' },
    dismissible: { true: 'pr-12', false: '' }
  },
  compoundVariants: [
    { type: 'warning', dismissible: true, class: 'border-l-4 border-yellow-500' }
  ]
) %}
```

---

## Anti-Patterns

❌ **NEVER** add variants without updating component.yml schema
❌ **NEVER** use conditional classes outside CVA
❌ **NEVER** create variants that should be slots (content differences)
❌ **NEVER** forget default values for new props

---

## Success Criteria

- [ ] component.yml schema updated with new prop
- [ ] CVA variants defined for all values
- [ ] Default value works correctly
- [ ] Each variant value renders correctly
- [ ] No breaking changes to existing usage
