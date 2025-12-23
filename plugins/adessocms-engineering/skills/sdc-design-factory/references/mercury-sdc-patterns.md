# Mercury SDC Patterns Reference

Complete reference for Single Directory Component patterns based on the Mercury Drupal theme.

## Component File Structure

Every SDC follows this exact structure within `components/`:

```
component-name/
├── component-name.component.yml    # Metadata & Schema (REQUIRED)
├── component-name.twig             # Template (REQUIRED)
├── component-name.tailwind.css     # Component-specific CSS (optional)
├── component-name.js               # JavaScript behavior (optional)
└── assets/                         # Example images/media (optional)
    └── example.jpg
```

## Component.yml Schema

### Basic Structure

```yaml
"$schema": "https://git.drupalcode.org/project/drupal/-/raw/10.1.x/core/modules/sdc/src/metadata.schema.json"
name: Component Name
group: Base|Layout|Card|Hero|Navigation|Form|Content
status: stable
description: "Brief description of the component's purpose"
```

### Props Definition

Props define the component's configurable properties:

```yaml
props:
  type: object
  required:
    - variant
  properties:
    variant:
      type: string
      title: Style Variant
      description: "Visual style of the component"
      enum:
        - primary
        - secondary
        - ghost
      default: primary
      examples:
        - primary
      meta:enum:
        primary: "Primary (filled)"
        secondary: "Secondary (outlined)"
        ghost: "Ghost (minimal)"

    size:
      type: string
      title: Size
      enum: [sm, md, lg]
      default: md
      examples: [md]

    disabled:
      type: boolean
      title: Disabled State
      default: false

    icon:
      type: string
      title: Icon Name
      description: "Heroicon name (e.g., 'arrow-right')"
```

### Slots Definition

Slots define areas where content can be injected:

```yaml
slots:
  default:
    title: Content
    description: "Main content area"

  header:
    title: Header
    description: "Optional header content"

  footer:
    title: Footer
    description: "Optional footer content"

  icon_slot:
    title: Icon Slot
    description: "Custom icon or media"
```

### Media Props with JSON Schema References

For image/media props, use Canvas module references:

```yaml
props:
  properties:
    image:
      $ref: json-schema-definitions://canvas.module/image
      title: Image
      type: object
      examples:
        - src: "assets/example.jpg"
          width: 1200
          height: 900
          alt: "Example image description"
```

### Library Overrides

Define JavaScript and CSS dependencies:

```yaml
libraryOverrides:
  js:
    component-name.js:
      attributes:
        type: module
  css:
    component:
      component-name.tailwind.css: {}
```

## CVA (Class Variance Authority) Deep Dive

### Basic CVA Usage

```twig
{% set component = html_cva(
  base: [
    'inline-flex items-center justify-center',
    'font-medium transition-all duration-200'
  ],
  variants: {
    variant: {
      primary: 'bg-primary text-primary-foreground',
      secondary: 'bg-secondary text-secondary-foreground'
    },
    size: {
      sm: 'h-8 px-3 text-sm',
      md: 'h-10 px-4 text-base',
      lg: 'h-12 px-6 text-lg'
    }
  }
) %}
```

### Applying CVA Classes

```twig
{# Basic application #}
<div class="{{ component.apply({variant: variant, size: size}) }}">

{# With additional classes #}
<div class="{{ component.apply({variant: variant}, 'mt-4 custom-class') }}">

{# With conditional classes #}
{% set extra_classes = disabled ? 'opacity-50 cursor-not-allowed' : '' %}
<div class="{{ component.apply({variant: variant}, extra_classes) }}">
```

### Compound Variants

For combinations of variants that need special treatment:

```twig
{% set card = html_cva(
  base: ['rounded-lg border'],
  variants: {
    variant: {
      elevated: 'shadow-lg',
      flat: 'shadow-none',
      outlined: 'border-2'
    },
    interactive: {
      yes: 'cursor-pointer',
      no: ''
    }
  },
  compound_variants: [
    {
      variant: ['elevated'],
      interactive: ['yes'],
      class: 'hover:shadow-xl transition-shadow'
    },
    {
      variant: ['outlined'],
      interactive: ['yes'],
      class: 'hover:border-primary'
    }
  ]
) %}
```

### Boolean Props to CVA Keys

Convert boolean props to CVA-compatible strings:

```twig
{% set is_disabled = disabled|default(false) ? 'yes' : 'no' %}
{% set has_icon = icon is not empty ? 'yes' : 'no' %}

{% set button = html_cva(
  base: [...],
  variants: {
    disabled: {
      yes: 'opacity-50 cursor-not-allowed pointer-events-none',
      no: ''
    },
    hasIcon: {
      yes: 'gap-2',
      no: ''
    }
  }
) %}

<button class="{{ button.apply({disabled: is_disabled, hasIcon: has_icon}) }}">
```

## Twig Template Patterns

### Variable Normalization

Always normalize props with defaults at the top:

```twig
{# Props normalization #}
{% set component_variant = variant|default('primary') %}
{% set component_size = size|default('md') %}
{% set is_disabled = disabled|default(false) %}
{% set button_label = label|default('Click me') %}
{% set button_url = url|default('') %}
{% set has_url = button_url is not empty and button_url != 'No URL' %}
```

### Component Includes

```twig
{# Include another SDC #}
{{ include('@theme_name/components/icon/icon.twig', {
  icon: icon_name,
  size: 'md',
  class: 'shrink-0'
}, with_context: false) }}

{# Shorthand with namespace #}
{% include 'theme_name:button' with {
  variant: 'primary',
  label: 'Submit'
} only %}
```

### Slot Rendering with Conditionals

```twig
{# Capture slot content #}
{% set header_content %}
  {% block header %}{% endblock %}
{% endset %}

{# Render only if slot has content #}
{% if header_content|trim is not empty %}
  <header class="mb-4">
    {{ header_content }}
  </header>
{% endif %}

{# Main slot (always renders) #}
<div class="content">
  {% block default %}{% endblock %}
</div>
```

### Unique IDs for Accessibility

```twig
{% set accordion_id = 'accordion'|clean_unique_id %}
{% set panel_id = 'panel'|clean_unique_id %}

<button
  id="{{ accordion_id }}"
  aria-controls="{{ panel_id }}"
  aria-expanded="false"
>
  {{ title }}
</button>
<div
  id="{{ panel_id }}"
  aria-labelledby="{{ accordion_id }}"
  role="region"
>
  {% block content %}{% endblock %}
</div>
```

### Class Array Handling

```twig
{# Handle both array and string class formats #}
{% set additional_classes = classes|default('') %}
{% if additional_classes is iterable %}
  {% set additional_classes = additional_classes|join(' ') %}
{% endif %}

<div class="{{ base_classes }} {{ additional_classes }}">
```

## JavaScript Pattern (ES6 Modules)

### ComponentInstance Base Pattern

```javascript
import { ComponentType, ComponentInstance } from "../../lib/component.js";

class Accordion extends ComponentInstance {
  init() {
    // Cache DOM elements
    this.trigger = this.el.querySelector('[data-accordion-trigger]');
    this.content = this.el.querySelector('[data-accordion-content]');

    // Bind events
    this.trigger.addEventListener('click', () => this.toggle());
    this.trigger.addEventListener('keydown', (e) => this.handleKeydown(e));

    // Initialize state
    this.isOpen = this.el.dataset.defaultOpen === 'true';
  }

  toggle() {
    this.isOpen = !this.isOpen;
    this.trigger.setAttribute('aria-expanded', this.isOpen);
    this.content.hidden = !this.isOpen;
  }

  handleKeydown(e) {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      this.toggle();
    }
  }
}

// Auto-instantiation with selector
new ComponentType(Accordion, "accordion", "[data-accordion]");
```

### Accessing Component Instances

```javascript
// Access all instances
window.mercuryComponents.accordion.instances

// Access specific instance
const accordion = window.mercuryComponents.accordion.instances[0];
accordion.toggle();
```

## Naming Conventions

| Item | Convention | Example |
|------|------------|---------|
| Component folder | kebab-case | `hero-billboard` |
| Component files | Same as folder | `hero-billboard.component.yml` |
| CSS classes (BEM-like) | Component prefix | `.hero-billboard--content` |
| Props | snake_case | `button_variant` |
| Twig variables | snake_case | `{% set is_active = ... %}` |
| JavaScript classes | PascalCase | `class HeroBillboard` |
| JavaScript IDs | camelCase | `const heroId = ...` |
| Groups | PascalCase | `group: Hero` |
