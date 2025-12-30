---
event: PostToolUse
tools:
  - Write
  - Edit
match_path: "**/paragraph--*.html.twig"
---

# Paragraph Template Validator Hook

Spezifische Validierung für Paragraph Templates.

## Validation Checks

### 1. Kein direkter Entity Access

```twig
{# ❌ FALSCH #}
{{ paragraph.field_title.value }}
{{ paragraph.field_image.entity.uri.value }}

{# ✅ RICHTIG #}
{{ content.field_title }}
{{ content.field_image }}
```

### 2. SDC Integration Pattern

Paragraph Templates sollten an SDC delegieren:

```twig
{# ✅ EMPFOHLEN: embed für Slot-basierte SDC #}
{% embed 'my_theme:hero' with {
  variant: content.field_variant|render|trim,
} only %}
  {% block title %}{{ content.field_title }}{% endblock %}
  {% block content %}{{ content.field_body }}{% endblock %}
{% endembed %}
```

### 3. Keine Semantic HTML Tags

Paragraph Templates sollten KEINE `<h1>`-`<h6>`, `<figure>`, `<blockquote>` etc. enthalten:

```twig
{# ❌ FALSCH - Markup gehört in SDC #}
<section class="hero">
  <h2>{{ content.field_title }}</h2>
  <figure>{{ content.field_image }}</figure>
</section>

{# ✅ RICHTIG - SDC kontrolliert Markup #}
{% embed 'my_theme:hero' only %}
  {% block title %}{{ content.field_title }}{% endblock %}
  {% block image %}{{ content.field_image }}{% endblock %}
{% endembed %}
```

### 4. Scalar Props korrekt extrahieren

```twig
{# Für Props die Strings brauchen #}
{% set variant = content.field_variant|render|trim %}

{# Oder in Preprocess (besser) #}
```

### 5. Cache Metadata erhalten

Slots müssen komplette Render Arrays erhalten:

```twig
{# ✅ RICHTIG - Cache metadata bleibt erhalten #}
{% block image %}
  {{ content.field_image }}
{% endblock %}

{# ❌ FALSCH - Cache metadata verloren #}
{% block image %}
  <img src="{{ paragraph.field_image.entity.uri.value }}">
{% endblock %}
```

## Bei Problemen

```
⚠️ Paragraph Template Validation:

1. Line 5: Direct entity access
   → Use {{ content.field_name }} to preserve cache metadata

2. Line 12: <h2> tag in paragraph template
   → Delegate to SDC component for semantic HTML

3. Line 8: Missing 'only' in embed
   → Add 'only' to prevent context leaking

📖 See: docs/solutions/paragraphs/best-practices.md
```

Informiere den User und biete Korrekturen an.
