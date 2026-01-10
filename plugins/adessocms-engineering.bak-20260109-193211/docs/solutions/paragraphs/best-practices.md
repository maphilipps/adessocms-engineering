# Paragraphs Best Practices - Quick Reference

> ⚠️ **HUMAN QUICK REFERENCE** - Nicht für Claude!
> Claude nutzt `@agent-paragraphs-specialist` direkt (enthält alle Best Practices).
> Dieses Doc ist für Entwickler zur schnellen manuellen Referenz.
>
> **Source:** Extracted from `agents/specialists/paragraphs-specialist.md`

---

## Golden Rules

1. **Niemals `.value` in Templates** - Immer `{{ content.field_name }}`
2. **Kein Render Array Destructuring** - Keine `content.field_image.0['#item']`
3. **SDC kontrolliert Markup** - Semantic HTML in SDC, nicht in Paragraph Templates
4. **Cache Metadata erhalten** - Render Arrays enthalten Cache Tags
5. **Preprocess für Logik** - Komplexe Logik gehört in `.theme`, nicht in Twig
6. **Field Templates nur wenn nötig** - Mit SDC meist überflüssig

---

## Field Access Pattern

### ❌ FALSCH - Bricht Caching
```twig
{{ paragraph.field_title.value }}
{{ paragraph.field_body.0.value }}
{{ content.field_image.0['#item'].entity.uri.value }}
```

### ✅ RICHTIG - Erhält Cache Metadata
```twig
{{ content.field_title }}
{{ content.field_body }}
{{ content.field_image }}
```

---

## Paragraph → SDC Integration

### Embed (für Slot-Blocks)
```twig
{# paragraph--hero.html.twig #}
{% embed 'my_theme:hero' with {
  variant: content.field_variant|render|trim,
} only %}
  {% block image %}
    {{ content.field_image }}
  {% endblock %}
  {% block title %}
    {{ content.field_title }}
  {% endblock %}
  {% block content %}
    {{ content.field_body }}
  {% endblock %}
{% endembed %}
```

### Include (ohne Slot-Blocks)
```twig
{# paragraph--button.html.twig #}
{{ include('my_theme:button', {
  label: content.field_label|render|trim,
  variant: content.field_variant|render|trim,
}, with_context = false) }}
```

---

## Scalar Values für Props

```twig
{# render|trim für saubere Strings #}
{% set variant = content.field_variant|render|trim %}
{% set title = content.field_title|render|striptags|trim %}
```

**Oder besser in Preprocess:**
```php
function my_theme_preprocess_paragraph__hero(&$variables) {
  $paragraph = $variables['paragraph'];
  $variables['variant'] = $paragraph->get('field_variant')->value ?? 'default';
}
```

---

## Field Templates - Wann nutzen?

### Mit SDC: Meist NICHT nötig

```twig
{# paragraph--hero.html.twig - SDC kontrolliert alles #}
{% embed 'my_theme:hero' only %}
  {% block title %}
    {{ content.field_title }}
  {% endblock %}
{% endembed %}
```

### Ohne SDC: Field Template für Custom Markup

```twig
{# field--paragraph--field-title--hero.html.twig #}
{% for item in items %}
  <h2 class="hero__title">{{ item.content }}</h2>
{% endfor %}
```

### Field Template delegiert an SDC

```twig
{# field--paragraph--field-title--hero.html.twig #}
{% for item in items %}
  {{ include('my_theme:heading', {
    heading_html_tag: 'h2',
    heading_utility_classes: ['hero__title'],
    content: item.content
  }, with_context = false) }}
{% endfor %}
```

---

## Preprocess Best Practices

```php
function my_theme_preprocess_paragraph__hero(array &$variables): void {
  $paragraph = $variables['paragraph'];

  // Scalar values für SDC props
  $variables['variant'] = $paragraph->get('field_variant')->value ?? 'default';
  $variables['alignment'] = $paragraph->get('field_alignment')->value ?? 'left';

  // Computed values
  $variables['has_image'] = !$paragraph->get('field_image')->isEmpty();

  // Cache tags für referenzierte Entities
  if ($media = $paragraph->get('field_image')->entity) {
    $variables['#cache']['tags'][] = 'media:' . $media->id();
  }
}
```

---

## ❌ Häufige Fehler

| Fehler | Problem | Lösung |
|--------|---------|--------|
| `paragraph.field_title.value` | Bypasses Cache | `content.field_title` |
| `content.field_image.0['#item']` | Loses Cache Metadata | `content.field_image` |
| `<h2>` in Field Template | Semantic HTML außerhalb SDC | SDC Heading Component |
| Complex `{% if %}` in Template | Schwer wartbar | In Preprocess verschieben |
| Keine Cache Tags für Media | Stale Content | `#cache tags` in Preprocess |

---

## View Modes für Varianten

Statt komplexer Template-Logik:
1. View Mode erstellen (Admin → Structure → Display modes)
2. Display konfigurieren pro View Mode
3. Paragraphs View Modes Modul für Selection

---

## Hilfreiche Module

| Modul | Funktion |
|-------|----------|
| **SDC Display** | SDC als Field Formatter |
| **UI Patterns** | SDC in Display Suite |
| **Paragraph SDC** | Paragraph Type für beliebige SDC |
| **Paragraphs View Modes** | View Mode Selection im Content |

---

## Quick Checklist vor Commit

- [ ] Kein `.value` Access in Templates?
- [ ] Kein Render Array Destructuring?
- [ ] Fields via `{{ content.field_name }}`?
- [ ] Semantic HTML nur in SDC?
- [ ] `{% embed %}` mit `only`?
- [ ] `|render|trim` für Scalar Props?
- [ ] Cache Tags in Preprocess für Media?
- [ ] Komplexe Logik in Preprocess?

---

## Weitere Details

→ Vollständige Dokumentation: `agents/specialists/paragraphs-specialist.md`
