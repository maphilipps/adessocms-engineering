# Build SDC Component from Scratch

## Required Reading
Before starting, load:
- `../references/sdc-structure.md` - File structure and naming
- `../references/slots-vs-props.md` - Decision guide
- `../references/cva-patterns.md` - Variant styling

---

## Input Gathering

Ask user:
1. **Component name** (kebab-case, e.g., `hero`, `card-grid`, `feature-list`)
2. **What content will it display?** (→ determines slots)
3. **What variations are needed?** (→ determines props/CVA)
4. **Any interactivity?** (→ determines Alpine.js need)

---

## Process

### Step 1: Locate Theme

```bash
# Find the custom theme
ddev exec find web/themes/custom -name "*.info.yml" -type f | head -1
```

Theme path pattern: `web/themes/custom/<theme_name>/`

### Step 2: Create Component Directory

```bash
THEME="<theme_name>"
COMPONENT="<component-name>"
mkdir -p web/themes/custom/${THEME}/components/${COMPONENT}
```

### Step 3: Create component.yml

```yaml
# <component>.component.yml
name: <Component Name>
status: stable
group: Components

props:
  type: object
  properties:
    variant:
      type: string
      enum: ['default', 'highlight']
      default: 'default'
    # Add config props here - NEVER content

slots:
  heading:
    title: Heading
    description: The main heading (from field)
  content:
    title: Content
    description: Body content (from field)
  # Add slots for ALL field content

libraryOverrides:
  css:
    component:
      <component>.tailwind.css: {}
  # Optional JS:
  # js:
  #   <component>.js: {}
```

### Step 4: Create Twig Template

```twig
{# <component>.twig #}
{% set wrapper = html_cva(
  base: ['component', '<component>'],
  variants: {
    variant: {
      default: 'bg-background',
      highlight: 'bg-primary/5'
    }
  }
) %}

<div {{ attributes.addClass(wrapper.apply({variant: variant})) }}>
  {% if heading %}
    <h2 class="text-2xl font-bold">
      {{ heading }}
    </h2>
  {% endif %}

  {% if content %}
    <div class="prose mt-4">
      {{ content }}
    </div>
  {% endif %}
</div>
```

### Step 5: Create Tailwind CSS (if needed)

```css
/* <component>.tailwind.css */
@import "tailwindcss";

/* Component-specific utilities if needed */
```

### Step 6: Create Alpine.js (if interactive)

```js
// <component>.js
document.addEventListener('alpine:init', () => {
  Alpine.data('<componentName>', () => ({
    // State
    isOpen: false,

    // Methods
    toggle() {
      this.isOpen = !this.isOpen
    }
  }))
})
```

### Step 7: Build and Cache Clear

```bash
ddev theme build && ddev drush cr
```

### Step 8: Visual Verification

```
mcp__claude-in-chrome__tabs_context_mcp
mcp__claude-in-chrome__navigate(url="https://<project>.ddev.site/...", ...)
mcp__claude-in-chrome__computer(action="screenshot", ...)
```

---

## Anti-Patterns

❌ **NEVER** put field content in props
```yaml
# WRONG
props:
  title:
    type: string  # This should be a SLOT!
```

❌ **NEVER** use manual class concatenation
```twig
{# WRONG #}
<div class="{{ variant == 'highlight' ? 'bg-primary' : 'bg-white' }}">
```

❌ **NEVER** forget cache tags in preprocess
```php
// If you preprocess, always add cache tags/contexts
```

---

## Success Criteria

- [ ] component.yml validates (no schema errors)
- [ ] Component renders in browser
- [ ] All variants work correctly
- [ ] Cache clears without errors
- [ ] Visual verification screenshot taken
