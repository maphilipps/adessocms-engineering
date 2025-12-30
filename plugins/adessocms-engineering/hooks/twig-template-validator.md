---
event: PostToolUse
tools:
  - Write
  - Edit
match_path: "**/*.twig"
---

# Twig Template Validator Hook

Validiere Twig Templates nach Schreiben/Bearbeiten.

## Validation Checks

### 1. Kein `.value` Access

```twig
{# ❌ FALSCH #}
{{ paragraph.field_title.value }}
{{ node.field_body.0.value }}

{# ✅ RICHTIG #}
{{ content.field_title }}
```

**Regex Pattern:** `\.(field_\w+)\.value` oder `\.0\.value`

### 2. Kein Render Array Destructuring

```twig
{# ❌ FALSCH #}
{{ content.field_image.0['#item'].entity.uri.value }}

{# ✅ RICHTIG #}
{{ content.field_image }}
```

**Pattern:** `\['#\w+'\]` in field access

### 3. Semantic HTML nur in SDC

In `paragraph--*.html.twig` oder `field--*.html.twig`:

```twig
{# ❌ FALSCH - <h2> gehört in SDC #}
<h2 class="hero__title">{{ content.field_title }}</h2>

{# ✅ RICHTIG - SDC kontrolliert Markup #}
{{ include('my_theme:heading', {
  heading_html_tag: 'h2',
  content: content.field_title
}, with_context = false) }}
```

**Pattern:** `<h[1-6]` in paragraph/field templates

### 4. `with_context = false` bei Include

```twig
{# ❌ FALSCH - Context leaking #}
{{ include('my_theme:button', { label: 'Click' }) }}

{# ✅ RICHTIG #}
{{ include('my_theme:button', { label: 'Click' }, with_context = false) }}
```

### 5. `only` bei Embed

```twig
{# ❌ FALSCH - Context leaking #}
{% embed 'my_theme:card' %}

{# ✅ RICHTIG #}
{% embed 'my_theme:card' only %}
```

### 6. Defaults für Props (in SDC Templates)

```twig
{# ❌ FALSCH - Kann undefined sein #}
<div class="card--{{ variant }}">

{# ✅ RICHTIG #}
{% set variant = variant|default('default') %}
<div class="card--{{ variant }}">
```

## Bei Problemen

```
⚠️ Twig Validation Warning:

1. Line 12: .value access detected
   → Use {{ content.field_name }} instead

2. Line 25: <h2> in paragraph template
   → Move semantic HTML to SDC component

3. Line 18: embed without 'only'
   → Add 'only' to prevent context leaking

📖 See: docs/solutions/sdc/best-practices.md
📖 See: docs/solutions/paragraphs/best-practices.md
```

Informiere den User über die Probleme und biete an, sie zu beheben.
