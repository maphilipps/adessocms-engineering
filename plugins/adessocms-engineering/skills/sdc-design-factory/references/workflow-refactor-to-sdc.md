# Workflow: Refactor Existing Code to SDC

Workflow for converting existing Twig templates or legacy components into proper SDC structure.

## Prerequisites

- Source template exists and renders correctly
- Understanding of what the template produces
- Target theme uses Mercury patterns

## Phase 1: Analysis

### Step 1.1: Identify Source Files

Locate all files related to the component:

```bash
# Find the template
ddev exec find web -name "*component-name*" -type f

# Check for related CSS
ddev exec grep -r "component-name" web/themes --include="*.css"

# Check for related JS
ddev exec grep -r "component-name" web/themes --include="*.js"

# Check for library definitions
ddev exec grep -r "component-name" web/themes --include="*.libraries.yml"
```

### Step 1.2: Document Current Structure

Map the existing implementation:

| File | Purpose | Keep/Refactor |
|------|---------|---------------|
| component.html.twig | Main template | Refactor to SDC |
| component.css | Styles | Convert to Tailwind |
| component.js | Behavior | Convert to ES6 module |
| theme.libraries.yml | Library def | Move to component.yml |

### Step 1.3: Identify Props and Slots

Analyze the template for:

**Variables used (become Props):**
```twig
{# Current usage #}
{{ title }}
{{ description }}
{{ image.url }}
{% if variant == 'large' %}
```

**Content areas (become Slots):**
```twig
{# Current content blocks #}
{{ content }}
{{ footer_content }}
{% block actions %}{% endblock %}
```

### Step 1.4: Identify Inline Styles

Find hardcoded values that need conversion:

```twig
{# Before: Inline styles to convert #}
style="background: #3b82f6"
style="padding: 20px 40px"
style="border-radius: 8px"

{# Before: Class-based but hardcoded #}
class="bg-blue-500"  {# Change to bg-primary #}
class="text-gray-900"  {# Change to text-foreground #}
```

## Phase 2: Create Design Philosophy

### Step 2.1: Reverse-Engineer the Design

Document the existing design's characteristics:

- What visual style does it have?
- What colors are used and why?
- What spacing patterns exist?
- What interaction states are present?

### Step 2.2: Write Improvement Philosophy

Create a philosophy that both documents current design and suggests improvements:

```markdown
# [Component] Design Philosophy

## Current State
The existing component uses [describe current approach].
Strengths: [list strengths]
Weaknesses: [list weaknesses]

## Target State
The refactored component will [describe improvements]:
- [Improvement 1]
- [Improvement 2]

## Visual Essence
[4-6 paragraph design philosophy for the improved component]
```

## Phase 3: Create SDC Structure

### Step 3.1: Create Component Directory

```bash
COMPONENT="component-name"
THEME="theme_name"
ddev exec mkdir -p "web/themes/custom/$THEME/components/$COMPONENT"
```

### Step 3.2: Create component.yml

Based on Phase 1 analysis:

```yaml
"$schema": "https://git.drupalcode.org/project/drupal/-/raw/10.1.x/core/modules/sdc/src/metadata.schema.json"
name: Component Name
group: [Appropriate Group]
status: stable
description: "[Description based on design philosophy]"

props:
  type: object
  required:
    - title  # Only if truly required
  properties:
    title:
      type: string
      title: Title
      description: "Main heading text"
      examples:
        - "Example Title"

    variant:
      type: string
      title: Variant
      enum:
        - default
        - large
        - compact
      default: default
      meta:enum:
        default: "Default size"
        large: "Large/featured"
        compact: "Compact/minimal"

    # Map all discovered variables...

slots:
  default:
    title: Content
    description: "Main content area"

  footer:
    title: Footer
    description: "Footer actions and links"

  # Map all discovered content areas...
```

### Step 3.3: Convert Template to SDC Twig

**Step A: Add props normalization**

```twig
{# At top of file #}
{% set component_title = title|default('') %}
{% set component_variant = variant|default('default') %}
{% set component_image = image|default({}) %}
```

**Step B: Convert hardcoded classes to CVA**

```twig
{# Before #}
<div class="component {% if variant == 'large' %}component--large{% else %}component--default{% endif %}">

{# After #}
{% set component = html_cva(
  base: [
    'component',
    'flex flex-col'
  ],
  variants: {
    variant: {
      default: 'p-4 text-base',
      large: 'p-6 md:p-8 text-lg',
      compact: 'p-2 text-sm'
    }
  }
) %}

<div class="{{ component.apply({variant: component_variant}) }}">
```

**Step C: Convert content areas to slots**

```twig
{# Before #}
<div class="content">
  {{ content }}
</div>
<div class="footer">
  {{ footer_content }}
</div>

{# After #}
<div class="content">
  {% block default %}{% endblock %}
</div>
{% set footer %}{% block footer %}{% endblock %}{% endset %}
{% if footer|trim is not empty %}
  <div class="footer">
    {{ footer }}
  </div>
{% endif %}
```

**Step D: Replace hardcoded colors with theme variables**

```twig
{# Before #}
class="bg-blue-500 text-white border-blue-600"

{# After #}
class="bg-primary text-primary-foreground border-primary/80"
```

**Step E: Add accessibility**

```twig
{# Before #}
<div class="card" onclick="navigate()">

{# After #}
<article class="card">
  {% if url %}
    <a href="{{ url }}" class="card-link">
      <span class="sr-only">Read more about {{ title }}</span>
    </a>
  {% endif %}
</article>
```

### Step 3.4: Convert CSS to Tailwind

**Legacy CSS:**
```css
.component {
  display: flex;
  flex-direction: column;
  padding: 1rem;
  background-color: #ffffff;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.component:hover {
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

.component--large {
  padding: 1.5rem;
}
```

**Converted to CVA:**
```twig
{% set component = html_cva(
  base: [
    'flex flex-col',
    'bg-background',
    'rounded-lg shadow-sm',
    'hover:shadow-md transition-shadow'
  ],
  variants: {
    variant: {
      default: 'p-4',
      large: 'p-6'
    }
  }
) %}
```

**Complex CSS that can't be expressed in utilities:**
```css
/* component-name.tailwind.css */
@layer components;

.component--animation {
  animation: component-fade 300ms ease-out;
}

@keyframes component-fade {
  from { opacity: 0; }
  to { opacity: 1; }
}
```

### Step 3.5: Convert JavaScript to ES6 Module

**Legacy JavaScript:**
```javascript
(function ($, Drupal) {
  Drupal.behaviors.componentName = {
    attach: function (context) {
      $('.component', context).once('component').each(function () {
        var $this = $(this);
        $this.find('.trigger').on('click', function () {
          $this.toggleClass('open');
        });
      });
    }
  };
})(jQuery, Drupal);
```

**Converted to ES6 Module:**
```javascript
import { ComponentType, ComponentInstance } from "../../lib/component.js";

class ComponentName extends ComponentInstance {
  init() {
    this.trigger = this.el.querySelector('.trigger');

    if (this.trigger) {
      this.trigger.addEventListener('click', () => this.toggle());
    }
  }

  toggle() {
    this.el.classList.toggle('open');
  }
}

new ComponentType(ComponentName, "component-name", ".component");
```

Add to component.yml:
```yaml
libraryOverrides:
  js:
    component-name.js:
      attributes:
        type: module
```

## Phase 4: Migration

### Step 4.1: Update Template References

Find all places using the old template:

```bash
ddev exec grep -r "component-name" web --include="*.twig"
ddev exec grep -r "component_name" web --include="*.twig"
```

Update to use SDC:

```twig
{# Before #}
{% include '@theme/templates/component-name.html.twig' with {
  title: node.title.value,
  content: content
} %}

{# After #}
{% embed 'theme_name:component-name' with {
  title: node.title.value,
  variant: 'default'
} %}
  {% block default %}
    {{ content }}
  {% endblock %}
{% endembed %}
```

### Step 4.2: Update Preprocess Functions

If preprocess functions exist, update variable names to match new props:

```php
// Before
function theme_preprocess_component_name(&$variables) {
  $variables['image_url'] = $variables['image']['#uri'];
}

// After - may no longer be needed if template handles this
// Or update to use new prop names
function theme_preprocess_sdc_theme_name__component_name(&$variables) {
  // SDC preprocessing if still needed
}
```

### Step 4.3: Remove Legacy Files

After confirming SDC works:

```bash
# Archive old files (don't delete immediately)
ddev exec mkdir -p web/themes/custom/theme_name/_deprecated
ddev exec mv web/themes/custom/theme_name/templates/component-name.html.twig web/themes/custom/theme_name/_deprecated/
ddev exec mv web/themes/custom/theme_name/css/component-name.css web/themes/custom/theme_name/_deprecated/

# Remove library definitions
# Edit theme.libraries.yml to remove component-name entry
```

## Phase 5: Testing

### Step 5.1: Visual Regression

Compare before and after:

```bash
# Take screenshots of pages using the component
# Before refactor
ddev exec drush scr screenshot-pages.php --output=before/

# After refactor
ddev exec drush scr screenshot-pages.php --output=after/

# Compare
# Use visual diff tool
```

### Step 5.2: Functional Testing

- [ ] Component renders without errors
- [ ] All variants display correctly
- [ ] Slots accept content properly
- [ ] JavaScript behavior works
- [ ] Responsive breakpoints work

### Step 5.3: Accessibility Testing

- [ ] Keyboard navigation works
- [ ] Focus indicators visible
- [ ] Screen reader announces correctly
- [ ] Contrast ratios pass

## Common Conversion Patterns

### Pattern: Drupal render arrays to props

```twig
{# Before: Render array access #}
{{ image['#uri'] }}
{{ link['#url'] }}
{{ title['#markup'] }}

{# After: Simplified props #}
{{ image.src }}
{{ url }}
{{ title }}
```

### Pattern: Drupal attributes to classes

```twig
{# Before #}
<div{{ attributes.addClass('component') }}>

{# After #}
<div class="{{ component.apply({variant: variant}) }}{{ attributes ? ' ' ~ attributes.class : '' }}"
     {{ attributes|without('class') }}>
```

### Pattern: Drupal content to slots

```twig
{# Before #}
{{ content.field_body }}
{{ content.field_image }}

{# After - as slots #}
{% block body %}
  {{ content.field_body }}
{% endblock %}

{% block media %}
  {{ content.field_image }}
{% endblock %}
```

## Rollback Plan

If issues arise:

1. **Keep deprecated files** for 1 sprint
2. **Document migration** with git commits
3. **Feature flag** if possible:
   ```twig
   {% if use_sdc_components %}
     {% include 'theme:component' %}
   {% else %}
     {% include '@theme/legacy/component.html.twig' %}
   {% endif %}
   ```

## Output Checklist

After completing this workflow:

- [ ] SDC directory created with all files
- [ ] component.yml has complete schema
- [ ] Twig template uses CVA
- [ ] CSS converted to Tailwind
- [ ] JavaScript converted to ES6 module
- [ ] All template references updated
- [ ] Legacy files archived (not deleted yet)
- [ ] Visual regression verified
- [ ] Functional testing passed
- [ ] Accessibility verified
