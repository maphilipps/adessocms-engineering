# SDC Best Practices - Quick Reference

> ⚠️ **HUMAN QUICK REFERENCE** - Nicht für Claude!
> Claude nutzt `@agent-sdc-specialist` direkt (enthält alle Best Practices).
> Dieses Doc ist für Entwickler zur schnellen manuellen Referenz.
>
> **Source:** Extracted from `agents/specialists/sdc-specialist.md`

---

## Golden Rules

1. **Slots für HTML, Props für Daten** - Render Arrays → Slot, Scalar Values → Prop
2. **Kein Prop Drilling** - Keine `image_url`, `image_alt` Props, sondern `image` Slot
3. **Schema ist Pflicht** - Jede Komponente braucht valides `$schema`
4. **Defaults setzen** - `{% set variant = variant|default('default') %}`
5. **`with_context = false`** - Bei `include` immer angeben
6. **`only`** - Bei `{% embed %}` immer angeben
7. **Semantic HTML nur in SDC** - `<h1>`-`<h6>`, `<figure>`, etc. gehören in die Komponente, nicht in Drupal Templates

---

## Props vs Slots Entscheidung

| Verwende Props für | Verwende Slots für |
|--------------------|-------------------|
| Strings, Numbers, Booleans | HTML Content |
| Variant/Size/State | Nested Components |
| Validierbare Werte | Render Arrays von Drupal |
| Einfache Objekte | Flexibler Content |

---

## Minimales component.yml

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/HEAD/core/assets/schemas/v1/metadata.schema.json
name: Component Name
status: stable
description: Was die Komponente macht

props:
  type: object
  properties:
    variant:
      type: string
      title: Variant
      enum: [default, highlight]
      default: default

slots:
  content:
    title: Content
    description: Main content area
```

---

## Twig Pattern

```twig
{# Defaults für Props #}
{% set variant = variant|default('default') %}

{# CSS-Klassen mit Attributes #}
{% set classes = [
  'card',
  variant ? 'card--' ~ variant,
] %}

<article{{ attributes.addClass(classes) }}>
  {# Slot rendern (enthält Cache-Metadata) #}
  {% if content %}
    {{ content }}
  {% endif %}
</article>
```

---

## Integration: Twig Include vs Embed

### Include (nur Props, keine Block-Slots)
```twig
{{ include('my_theme:button', {
  label: 'Click me',
  variant: 'primary',
}, with_context = false) }}
```

### Include (Props + Slot als Variable)
```twig
{{ include('my_theme:heading', {
  heading_html_tag: 'h2',
  heading_utility_classes: ['hero__title'],
  content: content.field_title
}, with_context = false) }}
```

### Embed (für Block-Slots)
```twig
{% embed 'my_theme:card' with {
  variant: 'default',
} only %}
  {% block media %}
    {{ content.field_image }}
  {% endblock %}
  {% block content %}
    {{ content.body }}
  {% endblock %}
{% endembed %}
```

---

## ❌ Häufige Fehler

| Fehler | Problem | Lösung |
|--------|---------|--------|
| `{{ node.field_image.entity.uri.value }}` | Bricht Caching | `{{ image }}` Slot |
| Props für `link_url`, `link_text` | Prop Drilling | `link` Slot |
| `<h2>` in Drupal Template | Semantic HTML außerhalb SDC | Heading-Component nutzen |
| `{% embed %}` ohne `only` | Context-Leaking | `{% embed 'x' only %}` |
| Kein Default für Prop | Undefined Error | `variant\|default('default')` |

---

## Heading Component Pattern

**Semantic HTML Tags nur in SDC!**

```twig
{# paragraph--hero.html.twig - WRONG #}
<h2 class="hero__title">{{ content.field_title }}</h2>

{# paragraph--hero.html.twig - CORRECT #}
{{ include('my_theme:heading', {
  heading_html_tag: 'h2',
  heading_utility_classes: ['hero__title'],
  content: content.field_title
}, with_context = false) }}
```

---

## Quick Checklist vor Commit

- [ ] `$schema` Reference vorhanden?
- [ ] Props haben `type`, `title`, `description`?
- [ ] HTML/Render Arrays als Slots (nicht Props)?
- [ ] `{% set x = x|default(...) %}` für alle Props?
- [ ] `with_context = false` bei includes?
- [ ] `only` bei embeds?
- [ ] Semantic HTML (`<h1>`-`<h6>`) nur in SDC?

---

## Weitere Details

→ Vollständige Dokumentation: `agents/specialists/sdc-specialist.md`
