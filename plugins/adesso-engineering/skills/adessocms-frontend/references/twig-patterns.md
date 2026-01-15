# Twig Patterns for SDC

## Overview

Twig templates in SDC components follow specific patterns for rendering, embedding, and data handling.

---

## Include vs Embed vs Include with Blocks

### Include

For simple components without slots:

```twig
{% include '<theme>:icon' with {
  name: 'arrow-right',
  size: 'md'
} only %}
```

### Embed

For components WITH slots (most common):

```twig
{% embed '<theme>:card' with {
  variant: 'elevated'
} %}
  {% block heading %}
    <h3>Card Title</h3>
  {% endblock %}

  {% block content %}
    <p>Card body content</p>
  {% endblock %}
{% endembed %}
```

### When to Use Which

| Pattern | Use When |
|---------|----------|
| `include` | No slots needed, just props |
| `embed` | Component has slots to fill |
| `include` + `only` | Isolate scope, prevent variable leakage |

---

## Slot Rendering

### Simple Slot

```twig
{# In component.twig #}
{% if heading %}
  <h2 class="text-2xl font-bold">
    {{ heading }}
  </h2>
{% endif %}
```

### Slot with Default

```twig
{% if cta %}
  {{ cta }}
{% else %}
  <a href="#" class="btn">Learn More</a>
{% endif %}
```

### Slot with Wrapper

```twig
{% if items %}
  <ul class="space-y-4">
    {{ items }}
  </ul>
{% endif %}
```

---

## Block Definitions

### In Component

```twig
{# hero.twig #}
<section class="hero">
  {% block heading %}
    {# Default content or empty #}
  {% endblock %}

  {% block content %}{% endblock %}

  {% block cta %}{% endblock %}
</section>
```

### Filling Blocks

```twig
{% embed '<theme>:hero' %}
  {% block heading %}
    <h1>Welcome</h1>
  {% endblock %}
{% endembed %}
```

---

## Attributes Handling

### Adding Classes

```twig
<div {{ attributes.addClass('my-component', 'p-4') }}>
```

### Combining with CVA

```twig
{% set wrapper = html_cva(
  base: ['component'],
  variants: { variant: { primary: 'bg-primary' } }
) %}

<div {{ attributes.addClass(wrapper.apply({variant: variant})) }}>
```

### Preserving Attributes

```twig
{# Keep all passed attributes #}
<div {{ attributes }}>

{# Add to existing attributes #}
<div {{ attributes.addClass('extra-class') }}>
```

---

## Conditional Rendering

### If/Else

```twig
{% if variant == 'dark' %}
  <div class="bg-gray-900 text-white">
{% else %}
  <div class="bg-white text-gray-900">
{% endif %}
```

### Ternary

```twig
<div class="{{ size == 'lg' ? 'p-8' : 'p-4' }}">
```

### Default Filter

```twig
{{ title|default('Untitled') }}
```

---

## Loops

### Simple Loop

```twig
{% for item in items %}
  <div class="item">{{ item }}</div>
{% endfor %}
```

### Loop with Index

```twig
{% for item in items %}
  <div class="{{ loop.first ? 'first' : '' }} {{ loop.last ? 'last' : '' }}">
    {{ loop.index }}: {{ item }}
  </div>
{% endfor %}
```

### Empty Check

```twig
{% for item in items %}
  {{ item }}
{% else %}
  <p>No items found</p>
{% endfor %}
```

---

## Filters

### Common Filters

```twig
{{ title|upper }}           {# UPPERCASE #}
{{ text|striptags }}        {# Remove HTML #}
{{ html|raw }}              {# Output raw HTML (careful!) #}
{{ items|length }}          {# Count items #}
{{ text|trim }}             {# Remove whitespace #}
{{ date|date('Y-m-d') }}    {# Format date #}
```

### Drupal-Specific Filters

```twig
{{ 'Hello @name'|t({'@name': name}) }}  {# Translation #}
{{ content|render }}                      {# Render array #}
{{ content|without('field_x') }}          {# Exclude field #}
```

---

## Macros

### Define Macro

```twig
{% macro button(text, url, variant = 'primary') %}
  <a href="{{ url }}" class="btn btn-{{ variant }}">
    {{ text }}
  </a>
{% endmacro %}
```

### Use Macro

```twig
{% import _self as ui %}

{{ ui.button('Click me', '/path', 'secondary') }}
```

---

## Component Composition

### Nested Components

```twig
{# card-grid.twig #}
<div class="grid grid-cols-3 gap-6">
  {% for card in cards %}
    {% embed '<theme>:card' with card %}
      {% block content %}
        {{ card.content }}
      {% endblock %}
    {% endembed %}
  {% endfor %}
</div>
```

### Slot Forwarding

```twig
{# Pass slot content through #}
{% embed '<theme>:wrapper' %}
  {% block content %}
    {{ content }}  {# Forward the slot #}
  {% endblock %}
{% endembed %}
```

---

## Debugging

```twig
{# Dump variable #}
{{ dump(variable) }}

{# Dump all available variables #}
{{ dump() }}

{# Check if variable exists #}
{% if variable is defined %}
```

---

## Best Practices

1. **Use `only` keyword** - Prevent variable scope leakage
2. **Check for empty** - Always handle missing slots gracefully
3. **Keep logic minimal** - Complex logic belongs in preprocess
4. **Use semantic blocks** - Name blocks for their content purpose
5. **Leverage CVA** - Don't write conditional classes manually
