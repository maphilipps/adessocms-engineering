# Slots vs Props Decision Guide

## The Golden Rule

> **Content from Drupal fields → SLOTS**
> **Configuration and styling options → PROPS**

---

## Decision Tree

```
Is this data from a Drupal field?
├── YES → Use SLOT
│   Examples: Title, body, image, link
│
└── NO → Is it a styling/layout choice?
    ├── YES → Use PROP
    │   Examples: variant, theme, size, layout
    │
    └── NO → Is it a boolean toggle?
        ├── YES → Use PROP
        │   Examples: showBorder, isReversed
        │
        └── NO → Probably a SLOT
```

---

## Use SLOTS For

| Content Type | Slot Name | Example Source |
|--------------|-----------|----------------|
| Headlines | `heading`, `title` | `field_heading` |
| Body text | `content`, `body` | `field_body` |
| Images | `image`, `media` | `field_image` |
| Links | `link`, `cta` | `field_link` |
| Rich text | `description` | `field_description` |
| Lists | `items` | Paragraph reference field |
| Buttons | `actions` | `field_cta` |
| Navigation | `menu` | Menu block |

### Why Slots for Content?

1. **Drupal's render pipeline** handles caching, access, translations
2. **Field formatters** can be changed without component changes
3. **Content editors** can modify without developer
4. **Cache tags** are properly bubbled up

---

## Use PROPS For

| Configuration | Prop Name | Values |
|---------------|-----------|--------|
| Visual variant | `variant` | `'primary'`, `'secondary'`, `'outline'` |
| Color theme | `theme` | `'light'`, `'dark'` |
| Size | `size` | `'sm'`, `'md'`, `'lg'` |
| Layout | `layout` | `'centered'`, `'split'`, `'stacked'` |
| Alignment | `align` | `'left'`, `'center'`, `'right'` |
| Boolean flags | `showIcon` | `true`, `false` |
| Spacing | `spacing` | `'tight'`, `'normal'`, `'loose'` |

### Why Props for Configuration?

1. **CVA integration** - props drive variant classes
2. **Type safety** - enums validate options
3. **Preprocess control** - PHP can set props based on context
4. **No render overhead** - simple values, no field pipeline

---

## Common Mistakes

### ❌ Wrong: Title as Prop

```yaml
# WRONG - content in prop
props:
  properties:
    title:
      type: string
```

```twig
{# WRONG #}
<h1>{{ title }}</h1>
```

### ✅ Correct: Title as Slot

```yaml
# CORRECT
slots:
  title:
    title: Title
```

```twig
{# CORRECT #}
<h1>{{ title }}</h1>
```

---

### ❌ Wrong: Variant as Slot

```yaml
# WRONG - config in slot
slots:
  variant:
    title: Variant
```

### ✅ Correct: Variant as Prop

```yaml
# CORRECT
props:
  properties:
    variant:
      type: string
      enum: ['primary', 'secondary']
```

---

## Hybrid Pattern: Slot with Prop Override

Sometimes you need both content AND styling for the same element:

```yaml
props:
  properties:
    headingSize:
      type: string
      enum: ['lg', 'xl', '2xl']
      default: 'xl'

slots:
  heading:
    title: Heading
```

```twig
{% set headingClasses = html_cva(
  base: ['font-bold'],
  variants: {
    size: {
      lg: 'text-lg',
      xl: 'text-xl',
      '2xl': 'text-2xl'
    }
  }
) %}

<h2 class="{{ headingClasses.apply({size: headingSize}) }}">
  {{ heading }}
</h2>
```

---

## Field Template → Slot Flow

```
field_heading (Drupal field)
      ↓
field--paragraph--field-heading--hero.html.twig
      ↓
{{ heading }} slot in hero.twig
```

### Field Template Example

```twig
{# field--paragraph--field-heading--hero.html.twig #}
{% for item in items %}
  {{ item.content }}
{% endfor %}
```

This keeps field data flowing through Drupal's render system into your component slots.
