# Field Templates for SDC Slots

## Overview

Field templates bridge Drupal fields to SDC slots. They extract field content and pass it to components.

---

## Template Naming Convention

```
field--<entity-type>--<field-name>--<bundle>.html.twig
```

Examples:
- `field--paragraph--field-heading--hero.html.twig`
- `field--node--field-image--article.html.twig`
- `field--paragraph--field-items--card-grid.html.twig`

---

## Basic Field Template

### Simple Text Field

```twig
{# field--paragraph--field-heading--hero.html.twig #}
{% for item in items %}
  {{ item.content }}
{% endfor %}
```

### With Wrapper Removal

```twig
{# Remove default field wrapper, just output content #}
{% for item in items %}
  {{ item.content }}
{% endfor %}
```

### Preserving Attributes

```twig
{# Keep field attributes for accessibility #}
{% for item in items %}
  <span {{ item.attributes }}>{{ item.content }}</span>
{% endfor %}
```

---

## Field Type Patterns

### Text Fields

```twig
{# Plain text #}
{% for item in items %}
  {{ item.content }}
{% endfor %}
```

### Rich Text / Body

```twig
{# Formatted text with HTML #}
{% for item in items %}
  {{ item.content }}
{% endfor %}
```

### Image Fields

```twig
{# Image with responsive settings #}
{% for item in items %}
  {{ item.content }}
{% endfor %}
```

### Link Fields

```twig
{# Link with title and URL #}
{% for item in items %}
  {{ item.content }}
{% endfor %}

{# Or access link properties directly #}
{% for item in items %}
  <a href="{{ item.content['#url'] }}" {{ item.attributes }}>
    {{ item.content['#title'] }}
  </a>
{% endfor %}
```

### Entity Reference (Paragraphs)

```twig
{# Render referenced paragraphs #}
{% for item in items %}
  {{ item.content }}
{% endfor %}
```

---

## Slot Mapping Strategy

### From Field to Slot

```
Drupal Field                    SDC Slot
─────────────────────────────────────────
field_heading        →        {{ heading }}
field_body           →        {{ content }}
field_image          →        {{ media }}
field_link           →        {{ cta }}
field_items          →        {{ items }}
```

### In Paragraph Template

```twig
{# paragraph--hero.html.twig #}
{% embed 'theme:hero' with {
  variant: content.field_variant|render|trim,
  theme: content.field_theme|render|trim
} %}
  {% block heading %}
    {{ content.field_heading }}
  {% endblock %}

  {% block content %}
    {{ content.field_body }}
  {% endblock %}

  {% block media %}
    {{ content.field_image }}
  {% endblock %}

  {% block cta %}
    {{ content.field_link }}
  {% endblock %}
{% endembed %}
```

---

## Multi-Value Fields

### As List Items

```twig
{# field--paragraph--field-features--feature-list.html.twig #}
<ul class="feature-list">
  {% for item in items %}
    <li>{{ item.content }}</li>
  {% endfor %}
</ul>
```

### As Grid

```twig
{# Let component handle the grid #}
{% for item in items %}
  {{ item.content }}
{% endfor %}
```

### With Index

```twig
{% for item in items %}
  <div data-index="{{ loop.index }}">
    {{ item.content }}
  </div>
{% endfor %}
```

---

## Props from Fields

### Select/List Fields → Props

```twig
{# paragraph--hero.html.twig #}
{% set variant_value = content.field_variant|render|striptags|trim %}

{% embed 'theme:hero' with {
  variant: variant_value
} %}
```

### Boolean Fields → Props

```twig
{% set is_reversed = content.field_reversed|render|striptags|trim == '1' %}

{% embed 'theme:sidebyside' with {
  reversed: is_reversed
} %}
```

---

## Cache Considerations

### Always Bubble Cache

Field templates automatically bubble cache metadata. Don't override this:

```twig
{# DON'T do this - breaks caching #}
{% set heading = content.field_heading|render %}
<h1>{{ heading }}</h1>

{# DO this - cache bubbles correctly #}
{{ content.field_heading }}
```

### Conditional Rendering

```twig
{# Safe - field still renders (with metadata) even if visually hidden #}
{% if content.field_heading|render|striptags|trim %}
  <h1>{{ content.field_heading }}</h1>
{% endif %}
```

---

## Template Suggestions

Check available suggestions with Twig debugging:

```yaml
# services.yml
parameters:
  twig.config:
    debug: true
```

Then in browser source:
```html
<!-- THEME DEBUG -->
<!-- FILE NAME SUGGESTIONS:
   * field--paragraph--field-heading--hero.html.twig
   * field--paragraph--field-heading.html.twig
   * field--paragraph.html.twig
   * field--field-heading.html.twig
   * field--text.html.twig
   * field.html.twig
-->
```

---

## Best Practices

1. **Keep field templates minimal** - Just pass content through
2. **Let SDC handle styling** - No classes in field templates
3. **Maintain cache bubbling** - Don't store rendered content in variables
4. **Use most specific template** - Include bundle name for paragraph fields
5. **Test with Twig debug** - Verify correct template is used
