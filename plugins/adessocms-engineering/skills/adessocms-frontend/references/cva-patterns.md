# CVA (Class Variance Authority) Patterns

## Overview

CVA provides type-safe variant management for Tailwind classes. In Drupal/Twig, use the `html_cva()` function.

---

## Basic Syntax

```twig
{% set button = html_cva(
  base: ['inline-flex', 'items-center', 'font-medium', 'rounded'],
  variants: {
    variant: {
      primary: 'bg-primary text-white hover:bg-primary/90',
      secondary: 'bg-secondary text-secondary-foreground',
      outline: 'border border-input bg-transparent hover:bg-accent'
    },
    size: {
      sm: 'h-9 px-3 text-sm',
      md: 'h-10 px-4 text-base',
      lg: 'h-12 px-6 text-lg'
    }
  },
  defaultVariants: {
    variant: 'primary',
    size: 'md'
  }
) %}

<button class="{{ button.apply({variant: variant, size: size}) }}">
  {{ slot }}
</button>
```

---

## Key Concepts

### Base Classes
Always applied, regardless of variants:

```twig
base: ['flex', 'items-center', 'transition-colors']
```

### Variant Axes
Each axis is a dimension of variation:

```twig
variants: {
  variant: { ... },   # Visual style
  size: { ... },      # Dimensions
  state: { ... }      # State-based styling
}
```

### Default Variants
Fallback when no value provided:

```twig
defaultVariants: {
  variant: 'primary',
  size: 'md'
}
```

---

## Compound Variants

Apply classes when multiple conditions match:

```twig
{% set alert = html_cva(
  base: ['p-4', 'rounded-lg'],
  variants: {
    type: {
      info: 'bg-blue-50 text-blue-900',
      warning: 'bg-yellow-50 text-yellow-900',
      error: 'bg-red-50 text-red-900'
    },
    hasIcon: {
      true: 'pl-12',
      false: ''
    }
  },
  compoundVariants: [
    {
      type: 'error',
      hasIcon: true,
      class: 'border-l-4 border-red-500'
    },
    {
      type: 'warning',
      hasIcon: true,
      class: 'border-l-4 border-yellow-500'
    }
  ]
) %}
```

---

## Boolean Variants

For toggle states:

```twig
{% set card = html_cva(
  base: ['rounded-lg', 'p-6'],
  variants: {
    elevated: {
      true: 'shadow-lg',
      false: 'shadow-none border'
    },
    interactive: {
      true: 'cursor-pointer hover:shadow-xl transition-shadow',
      false: ''
    }
  }
) %}

<div class="{{ card.apply({elevated: true, interactive: true}) }}">
```

---

## Responsive Variants

Combine CVA with Tailwind responsive prefixes:

```twig
{% set container = html_cva(
  base: ['mx-auto', 'px-4', 'sm:px-6', 'lg:px-8'],
  variants: {
    width: {
      narrow: 'max-w-2xl',
      default: 'max-w-4xl',
      wide: 'max-w-6xl',
      full: 'max-w-full'
    }
  }
) %}
```

---

## Component Examples

### Button Component

```twig
{% set btn = html_cva(
  base: [
    'inline-flex', 'items-center', 'justify-center',
    'font-medium', 'rounded-md',
    'focus:outline-none', 'focus:ring-2', 'focus:ring-offset-2',
    'disabled:opacity-50', 'disabled:cursor-not-allowed',
    'transition-colors'
  ],
  variants: {
    variant: {
      primary: 'bg-primary text-primary-foreground hover:bg-primary/90 focus:ring-primary',
      secondary: 'bg-secondary text-secondary-foreground hover:bg-secondary/80',
      destructive: 'bg-destructive text-destructive-foreground hover:bg-destructive/90',
      outline: 'border border-input bg-background hover:bg-accent hover:text-accent-foreground',
      ghost: 'hover:bg-accent hover:text-accent-foreground',
      link: 'text-primary underline-offset-4 hover:underline'
    },
    size: {
      sm: 'h-9 px-3 text-sm',
      md: 'h-10 px-4 text-sm',
      lg: 'h-11 px-8 text-base',
      icon: 'h-10 w-10'
    }
  },
  defaultVariants: {
    variant: 'primary',
    size: 'md'
  }
) %}
```

### Card Component

```twig
{% set card = html_cva(
  base: ['rounded-lg', 'bg-card', 'text-card-foreground'],
  variants: {
    variant: {
      default: 'border shadow-sm',
      elevated: 'shadow-lg',
      outline: 'border-2'
    },
    padding: {
      none: '',
      sm: 'p-4',
      md: 'p-6',
      lg: 'p-8'
    }
  },
  defaultVariants: {
    variant: 'default',
    padding: 'md'
  }
) %}
```

---

## Best Practices

1. **Keep base minimal** - Only truly shared classes
2. **Use semantic variant names** - `primary` not `blue`
3. **Group related classes** - All hover states together
4. **Default to most common** - Set sensible defaults
5. **Avoid class duplication** - Don't repeat across variants

---

## Anti-Patterns

### ❌ Manual Class Concatenation

```twig
{# WRONG #}
<div class="{{ variant == 'dark' ? 'bg-gray-900' : 'bg-white' }}">
```

### ✅ CVA Apply

```twig
{# CORRECT #}
<div class="{{ component.apply({theme: variant}) }}">
```

### ❌ Inline Conditionals

```twig
{# WRONG #}
<button class="btn {% if large %}btn-lg{% endif %}">
```

### ✅ Size Variant

```twig
{# CORRECT #}
<button class="{{ btn.apply({size: large ? 'lg' : 'md'}) }}">
```
