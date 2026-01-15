# SDC Standards for adesso CMS

## Directory Structure

Every component MUST follow this structure:

```
components/
└── [component-name]/
    ├── [component-name].component.yml  # REQUIRED: Schema
    ├── [component-name].twig           # REQUIRED: Template
    ├── [component-name].stories.js     # REQUIRED: Storybook
    ├── [component-name].css            # OPTIONAL: Styles
    ├── [component-name].js             # OPTIONAL: Behavior
    └── README.md                       # RECOMMENDED: Docs
```

## Naming Conventions

- **Directory**: `kebab-case` (e.g., `card-group`)
- **Files**: Match directory name exactly
- **Drupal ID**: `adesso_cms_theme:[component-name]`

## Schema Requirements (.component.yml)

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/11.x/core/modules/sdc/src/metadata.schema.json
name: Component Name
description: Clear description of what this component does
status: stable | experimental | deprecated

props:
  type: object
  required:
    - required_prop
  properties:
    prop_name:
      type: string
      title: Human Readable Name
      description: What this prop does
      default: default_value
      # For enums:
      enum:
        - option1
        - option2

slots:
  default:
    title: Default Slot
    description: Main content area
  named_slot:
    title: Named Slot
    description: Secondary content

libraryOverrides:
  css:
    component:
      [component-name].css: {}
  js:
    [component-name].js: {}
  dependencies:
    - core/drupal
    - adesso_cms_theme/global
```

## Template Requirements (.twig)

```twig
{#
/**
 * @file
 * Component: [Component Name]
 *
 * Available variables:
 * - prop_name: Description of prop
 */
#}

{# Set defaults #}
{% set prop_name = prop_name ?? 'default' %}

{# Build classes #}
{% set classes = [
  'c-component-name',
  modifier ? 'c-component-name--' ~ modifier,
] %}

<div {{ attributes.addClass(classes) }}>
  {# Component content #}
  {{ slot_name }}
</div>
```

### Template Rules

1. **Always set defaults** for optional props
2. **Use BEM naming**: `c-[component]`, `c-[component]__[element]`, `c-[component]--[modifier]`
3. **Use attributes object** for class management
4. **Escape user content** with `|e` or `{{ content }}`
5. **Document variables** in file header comment

## Storybook Requirements (.stories.js)

```javascript
/**
 * @file
 * Storybook stories for [Component Name].
 */

export default {
  title: 'Components/[Category]/[Name]',
  tags: ['autodocs'],
  parameters: {
    layout: 'centered', // or 'fullscreen', 'padded'
  },
  argTypes: {
    prop_name: {
      control: 'text', // text, select, boolean, number, color, object
      description: 'Description of prop',
      table: {
        type: { summary: 'string' },
        defaultValue: { summary: 'default' },
      },
    },
  },
};

// Default story (REQUIRED)
export const Default = {
  args: {
    prop_name: 'Example value',
  },
};

// Variant stories
export const WithModifier = {
  args: {
    ...Default.args,
    modifier: 'variant',
  },
};

// Edge cases
export const Empty = {
  args: {
    prop_name: '',
  },
};

export const LongContent = {
  args: {
    prop_name: 'Very long content that might cause layout issues...',
  },
};
```

### Story Categories

- `Components/Atoms/[Name]`
- `Components/Molecules/[Name]`
- `Components/Organisms/[Name]`
- `Sections/[Name]`
- `Regions/[Name]`

## CSS Standards

```css
/**
 * @file
 * Styles for [Component Name].
 */

/* Use Tailwind utilities via @apply when appropriate */
.c-component-name {
  @apply flex flex-col gap-4;
}

/* Custom styles when Tailwind doesn't cover it */
.c-component-name__element {
  /* Custom property for theming */
  --component-spacing: theme('spacing.4');
}

/* Modifier classes */
.c-component-name--large {
  @apply text-lg;
}
```

### CSS Rules

1. **Prefer Tailwind** utilities in templates
2. **Use @apply** sparingly in CSS files
3. **BEM naming** for custom classes
4. **CSS custom properties** for theming
5. **No `!important`** unless absolutely necessary

## JavaScript Standards (.js)

```javascript
/**
 * @file
 * Behavior for [Component Name].
 */

(function (Drupal) {
  'use strict';

  /**
   * Component behavior.
   *
   * @type {Drupal~behavior}
   */
  Drupal.behaviors.componentName = {
    attach: function (context, settings) {
      // Use once() to prevent multiple attachments
      once('component-name', '.c-component-name', context).forEach(
        function (element) {
          // Initialize component
          initComponent(element);
        }
      );
    },
    detach: function (context, settings, trigger) {
      // Cleanup if needed
    },
  };

  /**
   * Initialize component.
   *
   * @param {HTMLElement} element
   *   The component element.
   */
  function initComponent(element) {
    // Component logic
  }
})(Drupal);
```

### JS Rules

1. **Use Drupal behaviors** pattern
2. **Use once()** to prevent duplicate initialization
3. **Avoid global scope** pollution
4. **Document functions** with JSDoc
5. **Handle detach** for AJAX/BigPipe

## Quality Checklist

Before considering a component complete:

### Structure
- [ ] All required files present
- [ ] Follows naming conventions
- [ ] Schema validates

### Code Quality
- [ ] Passes `ddev eslint`
- [ ] Passes `ddev stylelint`
- [ ] No console errors

### Storybook
- [ ] Default story works
- [ ] All props demonstrated
- [ ] Edge cases covered
- [ ] `ddev story-check` passes

### Accessibility
- [ ] Semantic HTML
- [ ] ARIA where needed
- [ ] Keyboard navigable
- [ ] Focus visible
- [ ] Color contrast OK

### Responsive
- [ ] Mobile layout works
- [ ] Tablet layout works
- [ ] Desktop layout works
- [ ] No horizontal scroll

### Integration
- [ ] Works in Drupal context
- [ ] Paragraph/block configured (if applicable)
- [ ] Caching appropriate
