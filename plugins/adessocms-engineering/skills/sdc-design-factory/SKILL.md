---
name: sdc-design-factory
description: |
  Creates stunningly beautiful SDC (Single Directory Components) for Drupal using Mercury patterns,
  CVA (Class Variance Authority) for variants, and Tailwind v4. This skill applies a philosophy-first
  design approach where an aesthetic manifesto is created before any code, ensuring museum-quality
  craftsmanship. Use this skill when creating new Drupal components, designing UI elements with
  multiple variants, or refactoring existing code to SDC structure. Triggers on requests like
  "create a hero component", "design a card SDC", "make a beautiful button component", or
  "refactor this to SDC".
---

# SDC Design Factory

Transform component ideas into production-ready, visually stunning Single Directory Components
following Mercury patterns and professional design principles.

## Core Philosophy

**Philosophy Before Code**: Every component begins with an aesthetic manifesto—a 4-6 paragraph
design philosophy describing form, space, color, and composition. This ensures intentional,
cohesive design rather than ad-hoc styling decisions.

**Craftsmanship Standard**: Every component must appear meticulously crafted, as if produced by
a master artisan. No AI-slop patterns: avoid centered-everything layouts, purple gradients,
uniform rounded corners, or generic Inter font.

**CVA-First Variants**: All styling variants use `html_cva()` in Twig—never manual class lists.
This ensures systematic, maintainable variant management.

## Quick Start

To create a new SDC component:

1. Define the component purpose and use cases
2. Create the Design Philosophy (aesthetic manifesto)
3. Generate the component structure using Mercury patterns
4. Implement CVA variants for all style variations
5. Add accessibility attributes and responsive behavior
6. Test with Storybook and Playwright

## Workflow Selection

When triggered, determine the appropriate workflow:

| User Intent | Workflow |
|-------------|----------|
| Create new component from scratch | `references/workflow-design-component.md` |
| Add variants to existing component | `references/workflow-generate-variants.md` |
| Copy/adapt from Tailwind Showcase | `references/workflow-copy-showcase.md` |
| Review component design quality | `references/workflow-review-component.md` |
| Convert existing code to SDC | `references/workflow-refactor-to-sdc.md` |

## Essential Principles

### 1. Mercury SDC Structure

Every component follows this exact structure:

```
components/
└── component-name/
    ├── component-name.component.yml    # Schema (required)
    ├── component-name.twig             # Template (required)
    ├── component-name.tailwind.css     # Styles (optional)
    ├── component-name.js               # Behavior (optional)
    └── assets/                         # Images (optional)
        └── example.jpg
```

**No separate .libraries.yml** - Library definitions go in component.yml via `libraryOverrides`.

### 2. CVA Pattern (Class Variance Authority)

All variant styling uses the `html_cva()` Twig function:

```twig
{% set button = html_cva(
  base: [
    'inline-flex items-center justify-center',
    'font-medium transition-colors duration-200',
    'focus-visible:outline-none focus-visible:ring-2'
  ],
  variants: {
    variant: {
      primary: 'bg-primary text-primary-foreground hover:bg-primary/90',
      secondary: 'bg-secondary text-secondary-foreground hover:bg-secondary/80',
      ghost: 'hover:bg-accent hover:text-accent-foreground'
    },
    size: {
      sm: 'h-9 px-3 text-sm rounded-md',
      md: 'h-10 px-4 text-base rounded-lg',
      lg: 'h-11 px-6 text-lg rounded-xl'
    }
  },
  compound_variants: [
    {
      variant: ['primary'],
      size: ['lg'],
      class: 'shadow-lg'
    }
  ]
) %}

<button class="{{ button.apply({variant: variant, size: size}) }}">
```

### 3. Tailwind v4 Integration

Use modern Tailwind v4 syntax with `@theme inline`:

```css
@import "tailwindcss";

@theme inline {
  --color-primary: var(--primary);
  --color-primary-foreground: var(--primary-foreground);
  --color-secondary: var(--secondary);
  --font-sans: var(--font-sans);
  --radius-lg: var(--radius);
}

@layer components {
  .component-specific-style {
    @apply relative flex;
  }
}
```

### 4. Accessibility Requirements

Every component must include:

- Semantic HTML elements (`<button>`, `<nav>`, `<article>`, not just `<div>`)
- ARIA attributes where needed (`aria-label`, `aria-expanded`, `aria-controls`)
- Keyboard navigation support (Enter, Space, Escape, Arrow keys)
- Focus indicators (`focus-visible:ring-2 focus-visible:ring-offset-2`)
- Color contrast meeting WCAG 2.1 AA (4.5:1 for text, 3:1 for UI)
- Screen reader text for icon-only buttons (`.sr-only` class)

### 5. Responsive Design

Mobile-first approach with consistent breakpoints:

```twig
{# Example responsive classes #}
'text-base md:text-lg xl:text-xl'
'grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4'
'px-4 md:px-6 lg:px-8'
```

## Anti-Patterns to Avoid

**DO NOT create components with:**

- Centered layouts everywhere (use intentional asymmetry)
- Purple gradients (choose purposeful color palettes)
- Uniform border-radius on everything (vary radius by context)
- Generic Inter font (select typography with intention)
- Overlapping elements without clear z-index management
- Missing hover/focus/active states
- Hardcoded colors (use CSS custom properties)
- Inline styles (use Tailwind classes)

## Reference Files

For detailed implementation guidance, load the appropriate reference:

| Reference | Content |
|-----------|---------|
| `references/mercury-sdc-patterns.md` | Complete Mercury component structure, CVA deep-dive |
| `references/tailwind-v4-integration.md` | Tailwind v4 setup, @theme, layers |
| `references/design-philosophy-guide.md` | Writing aesthetic manifestos |
| `references/component-schema-patterns.md` | JSON Schema for props/slots |
| `references/accessibility-checklist.md` | WCAG 2.1 AA requirements |

## Asset Templates

Use templates in `assets/` as starting points:

| Template | Usage |
|----------|-------|
| `assets/component.yml.template` | Component schema with props/slots |
| `assets/component.twig.template` | Twig template with CVA pattern |
| `assets/component.tailwind.css.template` | Layer-based CSS structure |
| `assets/component.js.template` | ES6 module with ComponentInstance |
| `assets/design-philosophy.md.template` | Aesthetic manifesto structure |

## Component Categories

SDCs are organized into groups for UI consistency:

| Group | Components |
|-------|------------|
| **Base** | Button, Icon, Heading, Text, Link, Badge |
| **Form** | Input, Select, Checkbox, Radio, Textarea |
| **Layout** | Section, Container, Grid, Stack, Divider |
| **Navigation** | Navbar, Breadcrumb, Tabs, Pagination |
| **Card** | Card, CardIcon, CardTestimonial, CardPricing |
| **Hero** | HeroBillboard, HeroSplit, HeroCentered |
| **Content** | Accordion, Modal, Tooltip, Dropdown |

## Quality Checklist

Before finalizing any component:

- [ ] Design philosophy documented
- [ ] CVA variants implemented for all style variations
- [ ] Props defined with proper JSON Schema types
- [ ] Slots documented with titles and descriptions
- [ ] Responsive behavior tested at all breakpoints
- [ ] Accessibility attributes complete
- [ ] Dark mode support implemented
- [ ] Keyboard navigation functional
- [ ] Focus states visible and consistent
- [ ] No hardcoded colors or sizes
- [ ] Component renders in Storybook
- [ ] Example assets included if needed
