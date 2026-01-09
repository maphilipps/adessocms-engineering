# SDC (Single Directory Component) Structure

## Overview

SDC is Drupal's component architecture. Each component is self-contained in a single directory with all its assets.

---

## Directory Structure

```
web/themes/custom/<theme>/components/
└── <component-name>/
    ├── <component-name>.component.yml  # Required: Schema definition
    ├── <component-name>.twig           # Required: Template
    ├── <component-name>.tailwind.css   # Optional: Styles
    └── <component-name>.js             # Optional: JavaScript (Alpine.js)
```

### File Naming

- **Kebab-case** for component names: `hero-banner`, `card-grid`, `feature-list`
- All files in directory share the same base name
- No separate `.libraries.yml` - use `libraryOverrides` in component.yml

---

## component.yml Schema

```yaml
# hero.component.yml
name: Hero
status: stable  # experimental, stable, deprecated
group: Components  # Grouping in component library

props:
  type: object
  properties:
    variant:
      type: string
      enum: ['default', 'centered', 'split']
      default: 'default'
      title: Variant
      description: Layout variant for the hero
    theme:
      type: string
      enum: ['light', 'dark']
      default: 'light'
    size:
      type: string
      enum: ['sm', 'md', 'lg']
      default: 'md'

slots:
  heading:
    title: Heading
    description: Main heading text
  subheading:
    title: Subheading
    description: Optional subheading
  media:
    title: Media
    description: Image or video content
  cta:
    title: Call to Action
    description: Button or link

libraryOverrides:
  css:
    component:
      hero.tailwind.css: {}
  js:
    hero.js: {}
  dependencies:
    - core/drupal
    - <theme>/alpine
```

---

## Prop Types

| Type | Example | Use For |
|------|---------|---------|
| `string` | `'default'` | Text values, enum choices |
| `boolean` | `true/false` | Feature toggles |
| `number` | `42` | Counts, sizes |
| `array` | `['a', 'b']` | Multiple values |
| `object` | `{key: value}` | Complex nested data |

### Enum Pattern

```yaml
variant:
  type: string
  enum: ['primary', 'secondary', 'outline']
  default: 'primary'
```

### Required Props

```yaml
props:
  type: object
  required:
    - variant
  properties:
    variant:
      type: string
```

---

## Slot Definition

Slots receive content from Drupal fields or other sources.

```yaml
slots:
  # Simple slot
  content:
    title: Content
    description: Main body content

  # Slot with type hint
  items:
    title: Items
    description: List of feature items
    type: array
```

---

## Library Overrides

**No separate `.libraries.yml` needed!** Define in component.yml:

```yaml
libraryOverrides:
  css:
    component:
      # Relative to component directory
      <component>.tailwind.css: {}
  js:
    <component>.js: {}
  dependencies:
    - core/drupal
    - core/once
    - <theme>/alpine
```

---

## Using Components

### In Twig Templates

```twig
{% embed '<theme>:<component>' with {
  variant: 'centered',
  theme: 'dark'
} %}
  {% block heading %}
    <h1>Welcome</h1>
  {% endblock %}
  {% block content %}
    <p>Body text here</p>
  {% endblock %}
{% endembed %}
```

### In Preprocess

```php
function <theme>_preprocess_paragraph__hero(&$variables) {
  $variables['#attached']['library'][] = '<theme>/<component>';
}
```

### Direct Include

```twig
{% include '<theme>:<component>' with {
  variant: 'split'
} only %}
```

---

## Best Practices

1. **One component = one directory** - Keep everything together
2. **Use slots for content** - Never hardcode field content
3. **Use props for configuration** - Variants, themes, sizes
4. **CVA for variants** - No manual class concatenation
5. **Keep components small** - Compose larger layouts from smaller components
