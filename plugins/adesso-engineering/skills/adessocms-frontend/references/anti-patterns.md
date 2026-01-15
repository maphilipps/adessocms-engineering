# Anti-Patterns to Avoid

## Overview

Common mistakes in SDC development that lead to bugs, maintenance issues, and poor performance.

---

## Content in Props

### ❌ Wrong: Field Content as Prop

```yaml
# WRONG - component.yml
props:
  properties:
    title:
      type: string
    description:
      type: string
```

```twig
{# WRONG - paragraph template #}
{% include '<theme>:card' with {
  title: content.field_title|render|striptags,
  description: content.field_description|render|striptags
} %}
```

**Problems:**
- Breaks cache bubbling
- Loses field formatter settings
- Translation issues

### ✅ Correct: Content as Slots

```yaml
# CORRECT
slots:
  title:
    title: Title
  description:
    title: Description
```

```twig
{# CORRECT #}
{% embed '<theme>:card' %}
  {% block title %}
    {{ content.field_title }}
  {% endblock %}
  {% block description %}
    {{ content.field_description }}
  {% endblock %}
{% endembed %}
```

---

## Manual Class Concatenation

### ❌ Wrong: Conditional Classes in Template

```twig
{# WRONG #}
<div class="card
  {{ variant == 'featured' ? 'bg-primary text-white' : 'bg-white text-gray-900' }}
  {{ size == 'lg' ? 'p-8' : 'p-4' }}
  {{ bordered ? 'border' : '' }}
">
```

**Problems:**
- Hard to maintain
- Easy to miss combinations
- No type safety

### ✅ Correct: CVA Variants

```twig
{# CORRECT #}
{% set card = html_cva(
  base: ['card', 'rounded-lg'],
  variants: {
    variant: {
      default: 'bg-white text-gray-900',
      featured: 'bg-primary text-white'
    },
    size: {
      md: 'p-4',
      lg: 'p-8'
    },
    bordered: {
      true: 'border',
      false: ''
    }
  }
) %}

<div class="{{ card.apply({variant: variant, size: size, bordered: bordered}) }}">
```

---

## Missing Default Values

### ❌ Wrong: No Defaults

```yaml
# WRONG
props:
  properties:
    variant:
      type: string
      enum: ['primary', 'secondary']
    # No default!
```

```twig
{# Will break if variant not passed #}
<button class="{{ btn.apply({variant: variant}) }}">
```

### ✅ Correct: Sensible Defaults

```yaml
# CORRECT
props:
  properties:
    variant:
      type: string
      enum: ['primary', 'secondary']
      default: 'primary'
```

```twig
{# Also handle in template #}
<button class="{{ btn.apply({variant: variant|default('primary')}) }}">
```

---

## Hardcoded Content

### ❌ Wrong: Content in Template

```twig
{# WRONG #}
<section class="hero">
  <h1>Welcome to Our Website</h1>
  <p>We are the best company in the world.</p>
  <a href="/contact" class="btn">Contact Us</a>
</section>
```

### ✅ Correct: Slots for All Content

```twig
{# CORRECT #}
<section class="hero">
  {% if heading %}
    <h1>{{ heading }}</h1>
  {% endif %}
  {% if content %}
    {{ content }}
  {% endif %}
  {% if cta %}
    {{ cta }}
  {% endif %}
</section>
```

---

## Breaking Cache Bubbling

### ❌ Wrong: Storing Rendered Content

```twig
{# WRONG - breaks cache metadata #}
{% set rendered_title = content.field_title|render %}
{% set stripped_title = rendered_title|striptags|trim %}

{% if stripped_title %}
  <h1>{{ stripped_title }}</h1>
{% endif %}
```

### ✅ Correct: Render Inline

```twig
{# CORRECT - cache bubbles properly #}
{% if content.field_title|render|striptags|trim %}
  <h1>{{ content.field_title }}</h1>
{% endif %}
```

---

## Inline Styles

### ❌ Wrong: Style Attribute

```twig
{# WRONG #}
<div style="background-color: {{ color }}; padding: 20px;">
```

### ✅ Correct: Tailwind Classes or CSS Variables

```twig
{# CORRECT - via CVA #}
<div class="{{ wrapper.apply({color: color, padding: 'lg'}) }}">

{# Or CSS variables #}
<div class="bg-[--custom-color]" style="--custom-color: {{ color }}">
```

---

## Missing Accessibility

### ❌ Wrong: No ARIA

```twig
{# WRONG #}
<div x-data="{ open: false }">
  <button @click="open = !open">Toggle</button>
  <div x-show="open">Content</div>
</div>
```

### ✅ Correct: With ARIA

```twig
{# CORRECT #}
<div x-data="{ open: false }">
  <button
    @click="open = !open"
    :aria-expanded="open"
    aria-controls="panel-1"
  >
    Toggle
  </button>
  <div
    id="panel-1"
    x-show="open"
    role="region"
  >
    Content
  </div>
</div>
```

---

## Separate Library Files

### ❌ Wrong: Separate libraries.yml

```
components/card/
├── card.component.yml
├── card.twig
├── card.css
└── card.libraries.yml   # WRONG - extra file
```

### ✅ Correct: libraryOverrides in component.yml

```yaml
# In card.component.yml
libraryOverrides:
  css:
    component:
      card.css: {}
```

---

## Global CSS in Components

### ❌ Wrong: Global Styles

```css
/* card.css - WRONG */
body {
  font-family: sans-serif;
}

.container {
  max-width: 1200px;
}
```

### ✅ Correct: Component-Scoped

```css
/* card.css - CORRECT */
/* Only styles specific to this component */
.card-custom-animation {
  /* ... */
}
```

---

## Checklist Before Commit

- [ ] All field content uses slots, not props
- [ ] CVA handles all variant logic
- [ ] All props have default values
- [ ] No hardcoded content
- [ ] Cache bubbling not broken
- [ ] No inline styles
- [ ] Accessibility attributes present
- [ ] No separate .libraries.yml
- [ ] CSS is component-scoped
