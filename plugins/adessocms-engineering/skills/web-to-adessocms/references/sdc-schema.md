# SDC Schema Reference for adesso CMS

## Directory Structure

```
component-name/
├── component-name.component.yml  # Schema definition (REQUIRED)
├── component-name.twig           # Template (REQUIRED)
├── component-name.stories.js     # Storybook stories (REQUIRED)
├── component-name.css            # Component styles (optional)
├── component-name.behavior.js    # Drupal behaviors (optional)
└── templates/                    # Drupal template overrides (optional)
    └── *.html.twig
```

## component.yml Template

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/10.1.x/core/modules/sdc/src/metadata.schema.json
name: Component Name
description: Brief description of what the component does

props:
  type: object
  properties:
    # String prop
    title:
      type: string
      title: Title
      description: The main title text

    # Boolean prop
    show_icon:
      type: boolean
      title: Show Icon
      description: Whether to display the icon
      default: true

    # Enum prop (variants)
    variant:
      type: string
      title: Variant
      description: Visual variant
      enum: [default, primary, secondary, dark]
      default: default

    # Array of objects
    items:
      type: array
      title: Items
      description: List of items to display
      items:
        type: object
        properties:
          title:
            type: string
          url:
            type: string
          description:
            type: string

    # Nested object
    cta:
      type: object
      title: Call to Action
      properties:
        url:
          type: string
        text:
          type: string
        style:
          type: string
          enum: [primary, border]

# Optional: Define slots for nested content
slots:
  content:
    title: Content
    description: Main content slot

# Optional: Override library dependencies
libraryOverrides:
  css:
    component:
      component-name.css: {}
  dependencies:
    - core/drupal
```

## Twig Template Pattern

```twig
{#
/**
 * @file
 * Component Name - Brief description
 *
 * Props:
 * - title: Main title
 * - variant: Visual variant (default, primary, secondary)
 * - items: Array of items [{title, url}]
 */
#}

{# Set defaults #}
{% set variant = variant|default('default') %}

{# Compute classes based on variant #}
{% set base_classes = 'component-name' %}
{% set variant_classes = {
  'default': 'bg-white text-neutral-900',
  'primary': 'bg-primary text-white',
  'dark': 'bg-black text-white',
} %}

<div class="{{ base_classes }} {{ variant_classes[variant] }} {{ modifier|default('') }}">
  <div class="container">

    {% if title %}
      <h2 class="h-3xl mb-6">{{ title }}</h2>
    {% endif %}

    {# Slot for nested content #}
    {% block content %}{% endblock %}

    {# Loop through items #}
    {% if items|length > 0 %}
      <div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        {% for item in items %}
          <a href="{{ item.url }}" class="block p-4 hover:bg-neutral-50 transition-colors">
            <h3 class="h-xl">{{ item.title }}</h3>
            {% if item.description %}
              <p class="p-sm text-neutral-600 mt-2">{{ item.description }}</p>
            {% endif %}
          </a>
        {% endfor %}
      </div>
    {% endif %}

  </div>
</div>
```

## Storybook Story Pattern

```javascript
// phpcs:ignoreFile
import Component from './component-name.twig';

/**
 * Component description for Storybook docs
 */
const meta = {
  title: 'Category/ComponentName',  // e.g., 'Editorial/Hero', 'General/Button'
  component: Component,
  tags: ['autodocs'],
  parameters: {
    layout: 'fullscreen',  // or 'centered', 'padded'
  },
  argTypes: {
    variant: {
      control: 'select',
      options: ['default', 'primary', 'dark'],
      description: 'Visual variant',
    },
    title: {
      control: 'text',
      description: 'Main title',
    },
  },
};
export default meta;

// Sample data
const sampleItems = [
  { title: 'Item 1', url: '/item-1', description: 'Description 1' },
  { title: 'Item 2', url: '/item-2', description: 'Description 2' },
  { title: 'Item 3', url: '/item-3', description: 'Description 3' },
];

/**
 * Default state
 */
export const Default = {
  args: {
    title: 'Component Title',
    variant: 'default',
    items: sampleItems,
  },
};

/**
 * Primary variant
 */
export const Primary = {
  args: {
    ...Default.args,
    variant: 'primary',
  },
};

/**
 * Dark variant
 */
export const Dark = {
  args: {
    ...Default.args,
    variant: 'dark',
  },
  parameters: {
    backgrounds: { default: 'dark' },
  },
};

/**
 * Without items
 */
export const Minimal = {
  args: {
    title: 'Minimal Example',
    variant: 'default',
  },
};
```

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Component folder | kebab-case | `site-header`, `card-group` |
| Props | snake_case | `show_logo`, `cta_text` |
| CSS classes | Tailwind + BEM-like | `claroty-header__nav` |
| Storybook title | Category/PascalCase | `Editorial/Hero`, `General/SiteHeader` |
| Story exports | PascalCase | `Default`, `WithAnnouncement` |

## Storybook Categories

Use these categories for organization:
- `Editorial/` - Content-focused (Hero, Text, Accordion)
- `General/` - Base elements (Button, Badge, Heading)
- `Layout/` - Page structure (BentoGrid, Carousel)
- `Navigation/` - Nav components (SiteHeader, SiteFooter, MainMenu)
