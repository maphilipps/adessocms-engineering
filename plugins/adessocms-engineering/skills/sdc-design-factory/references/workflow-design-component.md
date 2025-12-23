# Workflow: Design New SDC Component

Complete workflow for creating a new Single Directory Component from scratch using the
philosophy-first approach.

## Prerequisites

Before starting, ensure:
- Theme uses Mercury patterns or compatible SDC structure
- Tailwind v4 is configured with `@theme inline`
- CVA Twig extension is installed (`cva:cva` dependency)
- Component folder structure exists: `components/`

## Phase 1: Discovery & Requirements

### Step 1.1: Clarify Component Purpose

Ask and document:

1. **What is this component?** (card, button, hero, navigation, etc.)
2. **Where will it be used?** (homepage, article pages, sidebar, etc.)
3. **What content does it display?** (text, images, icons, media, etc.)
4. **What variations are needed?** (sizes, colors, orientations, states)
5. **What interactions does it have?** (hover, click, expand, navigate)

### Step 1.2: Identify Similar Components

Search existing components for patterns:

```bash
# Find similar components in theme
ddev exec find web/themes/custom/*/components -name "*.component.yml" | head -20

# Check Mercury for reference implementations
# https://git.drupalcode.org/project/mercury/-/tree/1.x/components
```

### Step 1.3: Define Props & Slots

Create initial prop and slot inventory:

| Prop | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| variant | string enum | yes | primary | Visual style |
| size | string enum | no | md | Component size |
| ... | ... | ... | ... | ... |

| Slot | Required | Description |
|------|----------|-------------|
| default | yes | Main content |
| header | no | Optional header |
| ... | ... | ... |

## Phase 2: Design Philosophy

### Step 2.1: Write the Aesthetic Manifesto

Create a 4-6 paragraph design philosophy. Reference `references/design-philosophy-guide.md` for
detailed guidance.

**Required sections:**

1. **Visual Essence** - Core visual idea and emotional quality
2. **Form & Space** - Shapes, proportions, negative space
3. **Color & Material** - Color relationships, surface qualities
4. **Motion & Interaction** - Hover states, transitions, feedback
5. **Craftsmanship Standard** - Quality expectations, attention to detail

### Step 2.2: Extract Design Tokens

From the philosophy, identify specific values:

```yaml
design_tokens:
  # From "generous horizontal padding"
  padding_x: px-4 md:px-5 lg:px-6

  # From "10px border radius for approachable feel"
  border_radius: rounded-lg

  # From "200ms transitions for responsiveness"
  transition: transition-all duration-200

  # From "subtle shadow for elevation"
  shadow: shadow-sm hover:shadow-md
```

### Step 2.3: Map Variants to CVA

Translate design concepts to CVA structure:

```yaml
cva_variants:
  variant:
    primary: "bg-primary text-primary-foreground"
    secondary: "bg-secondary text-secondary-foreground"
    ghost: "bg-transparent hover:bg-accent"

  size:
    sm: "h-8 px-3 text-sm"
    md: "h-10 px-4 text-base"
    lg: "h-12 px-6 text-lg"
```

## Phase 3: Component Generation

### Step 3.1: Create Component Directory

```bash
COMPONENT_NAME="component-name"
THEME_PATH="web/themes/custom/theme_name"

ddev exec mkdir -p "$THEME_PATH/components/$COMPONENT_NAME"
```

### Step 3.2: Generate component.yml

Use template from `assets/component.yml.template`:

```yaml
"$schema": "https://git.drupalcode.org/project/drupal/-/raw/10.1.x/core/modules/sdc/src/metadata.schema.json"
name: Component Name
group: Base|Layout|Card|Hero
status: stable
description: "[From design philosophy - visual essence paragraph]"

props:
  type: object
  required:
    - variant
  properties:
    variant:
      type: string
      title: Style Variant
      enum: [primary, secondary, ghost]
      default: primary
      meta:enum:
        primary: "Primary style"
        secondary: "Secondary style"
        ghost: "Ghost style"

    size:
      type: string
      title: Size
      enum: [sm, md, lg]
      default: md

slots:
  default:
    title: Content
    description: "Main content area"
```

### Step 3.3: Generate component.twig

Use template from `assets/component.twig.template`:

```twig
{#
/**
 * @file
 * Component Name component.
 *
 * [Brief description from design philosophy]
 */
#}

{# Props normalization #}
{% set component_variant = variant|default('primary') %}
{% set component_size = size|default('md') %}

{# CVA definition #}
{% set component = html_cva(
  base: [
    'relative flex',
    'transition-all duration-200'
  ],
  variants: {
    variant: {
      primary: 'bg-primary text-primary-foreground',
      secondary: 'bg-secondary text-secondary-foreground',
      ghost: 'bg-transparent hover:bg-accent'
    },
    size: {
      sm: 'p-3 text-sm',
      md: 'p-4 text-base',
      lg: 'p-6 text-lg'
    }
  }
) %}

{# Component markup #}
<div class="{{ component.apply({variant: component_variant, size: component_size}) }}">
  {% block default %}{% endblock %}
</div>
```

### Step 3.4: Generate CSS (if needed)

Create `component-name.tailwind.css` only if utilities can't express the styling:

```css
@layer components;

.component-name--specific-state {
  @apply relative overflow-hidden;
}

.component-name--animation {
  animation: component-fade-in 300ms ease-out;
}

@keyframes component-fade-in {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}
```

### Step 3.5: Generate JavaScript (if needed)

Create `component-name.js` for interactive behavior:

```javascript
import { ComponentType, ComponentInstance } from "../../lib/component.js";

class ComponentName extends ComponentInstance {
  init() {
    // Cache DOM elements
    this.trigger = this.el.querySelector('[data-trigger]');

    // Bind events
    if (this.trigger) {
      this.trigger.addEventListener('click', () => this.handleClick());
    }
  }

  handleClick() {
    // Handle interaction
  }
}

new ComponentType(ComponentName, "component-name", "[data-component-name]");
```

Add to component.yml:

```yaml
libraryOverrides:
  js:
    component-name.js:
      attributes:
        type: module
```

## Phase 4: Accessibility Implementation

### Step 4.1: Add Semantic Structure

Replace generic elements with semantic HTML:

```twig
{# Before #}
<div class="card" onclick="navigate()">

{# After #}
<article class="card">
  <a href="{{ url }}" class="card-link">
    <span class="sr-only">Read more about {{ title }}</span>
  </a>
</article>
```

### Step 4.2: Add ARIA Attributes

```twig
{% set trigger_id = 'trigger'|clean_unique_id %}
{% set content_id = 'content'|clean_unique_id %}

<button
  id="{{ trigger_id }}"
  aria-expanded="false"
  aria-controls="{{ content_id }}"
>
  {{ label }}
</button>

<div
  id="{{ content_id }}"
  aria-labelledby="{{ trigger_id }}"
  hidden
>
  {% block content %}{% endblock %}
</div>
```

### Step 4.3: Ensure Keyboard Navigation

Add keyboard handlers in JavaScript:

```javascript
handleKeydown(e) {
  switch (e.key) {
    case 'Enter':
    case ' ':
      e.preventDefault();
      this.toggle();
      break;
    case 'Escape':
      this.close();
      break;
  }
}
```

### Step 4.4: Add Focus Indicators

```twig
class="
  focus-visible:outline-none
  focus-visible:ring-2
  focus-visible:ring-ring
  focus-visible:ring-offset-2
"
```

## Phase 5: Responsive Implementation

### Step 5.1: Mobile-First Base

Start with mobile styles, add breakpoint modifiers:

```twig
class="
  {# Mobile (default) #}
  flex flex-col gap-4 p-4 text-base

  {# Tablet #}
  md:flex-row md:gap-6 md:p-6 md:text-lg

  {# Desktop #}
  lg:gap-8 lg:p-8

  {# Wide screens #}
  xl:p-12
"
```

### Step 5.2: Test All Breakpoints

Verify component at:
- 320px (mobile portrait)
- 375px (mobile)
- 640px (sm breakpoint)
- 768px (md breakpoint)
- 1024px (lg breakpoint)
- 1280px (xl breakpoint)
- 1536px (2xl breakpoint)

## Phase 6: Quality Assurance

### Step 6.1: Visual Review

- [ ] Matches design philosophy aesthetic
- [ ] All variants render correctly
- [ ] Hover/focus states visible
- [ ] Dark mode works
- [ ] No layout breaks at any viewport

### Step 6.2: Code Review

- [ ] Follows Mercury conventions
- [ ] CVA used for all variants
- [ ] No hardcoded colors/sizes
- [ ] Props properly typed
- [ ] Slots documented

### Step 6.3: Accessibility Audit

- [ ] axe DevTools shows no violations
- [ ] Keyboard navigation works
- [ ] Screen reader announces correctly
- [ ] Contrast ratios pass

### Step 6.4: Storybook Story

Create a story for the component:

```javascript
export default {
  title: 'Components/ComponentName',
  component: ComponentName,
  argTypes: {
    variant: {
      control: 'select',
      options: ['primary', 'secondary', 'ghost']
    },
    size: {
      control: 'select',
      options: ['sm', 'md', 'lg']
    }
  }
};

export const Default = {
  args: {
    variant: 'primary',
    size: 'md'
  }
};

export const AllVariants = () => `
  <div class="space-y-4">
    ${['primary', 'secondary', 'ghost'].map(v => `
      <component-name variant="${v}">Variant: ${v}</component-name>
    `).join('')}
  </div>
`;
```

## Output Artifacts

After completing this workflow, the following files should exist:

```
components/component-name/
├── component-name.component.yml
├── component-name.twig
├── component-name.tailwind.css (if needed)
├── component-name.js (if interactive)
├── DESIGN-PHILOSOPHY.md (optional, for documentation)
└── assets/
    └── example.jpg (if media props exist)
```
