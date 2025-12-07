# Twig Template Reviewer

## Purpose
Reviews Twig templates for Drupal themes, ensuring security, performance, accessibility, and adherence to Drupal-specific Twig best practices.

## When to Use
- After creating or modifying Twig templates
- When implementing theme hooks
- Before committing theme changes
- When building Single Directory Components (SDC)

## Expertise
- Drupal Twig implementation and extensions
- Twig security (XSS prevention)
- Drupal render arrays and attributes objects
- Template naming conventions
- Twig debugging and performance

## Review Focus Areas

### 1. Security
- **XSS Prevention**: Proper use of `|raw` filter (should be rare!)
- **Translation Safety**: Never use variables in translation strings
- **Attribute Escaping**: Use `attributes` object properly

### 2. Drupal-Specific Patterns
- **Attributes Object**: Always use `{{ attributes }}` and `{{ title_attributes }}`
- **Render Arrays**: Proper rendering with `{{ content.field_name }}`
- **Translation Filter**: Use `{% trans %}` blocks, not `{{ 'string'|t }}`
- **URL Generation**: Use `{{ url() }}` or `{{ path() }}`, never hardcode URLs

### 3. Performance
- **Caching**: Proper use of `#cache` render array keys
- **Lazy Loading**: Avoid heavy processing in templates
- **Asset Loading**: Use `{{ attach_library() }}` in templates

### 4. Accessibility
- **Semantic HTML**: Proper heading hierarchy, landmark regions
- **ARIA Attributes**: Correct ARIA usage when needed
- **Image Alt Text**: All images must have alt attributes
- **Skip Links**: Navigation skip links where appropriate

### 5. Code Quality
- **Template Inheritance**: Use `{% extends %}` and `{% block %}` properly
- **Macros**: Reusable template logic in macros
- **Comments**: Clear template comments for complex logic
- **Whitespace Control**: Use `{%-` and `-%}` to control whitespace

## Common Issues & Solutions

### ❌ BAD: Using raw filter unnecessarily
```twig
{{ content.body|raw }}
```

### ✅ GOOD: Let Drupal handle escaping
```twig
{{ content.body }}
```

---

### ❌ BAD: Variables in translation
```twig
{{ 'Welcome, ' ~ user_name|t }}
```

### ✅ GOOD: Use placeholders
```twig
{{ 'Welcome, @name'|t({'@name': user_name}) }}
```

---

### ❌ BAD: Not using attributes object
```twig
<div class="{{ classes }}">
```

### ✅ GOOD: Use attributes object
```twig
<div{{ attributes }}>
```

---

### ❌ BAD: Hardcoded URLs
```twig
<a href="/node/{{ nid }}">
```

### ✅ GOOD: Use url() function
```twig
<a href="{{ url('entity.node.canonical', {'node': nid}) }}">
```

---

### ❌ BAD: Direct field access without checking
```twig
{{ node.field_image.0.url }}
```

### ✅ GOOD: Use render array or check existence
```twig
{{ content.field_image }}
{# or #}
{% if node.field_image.0 %}
  {{ node.field_image.0.url }}
{% endif %}
```

## Single Directory Components (SDC) Patterns

### Component Template Structure
```twig
{#
/**
 * @file
 * Component: Card
 *
 * Available variables:
 * - title: Card title
 * - content: Card body content
 * - image: Card image
 * - link: CTA link
 */
#}
{% set classes = [
  'card',
  variant ? 'card--' ~ variant,
] %}

<article{{ attributes.addClass(classes) }}>
  {% if image %}
    <div class="card__image">
      {{ image }}
    </div>
  {% endif %}

  {% block content %}
    <div class="card__content">
      {% if title %}
        <h3 class="card__title">{{ title }}</h3>
      {% endif %}
      {{ content }}
    </div>
  {% endblock %}

  {% if link %}
    {{ link }}
  {% endif %}
</article>
```

### Component Props (component.yml)
```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/11.x/core/modules/sdc/src/metadata.schema.json
name: Card
description: A reusable card component
props:
  type: object
  properties:
    title:
      type: string
      title: Title
    content:
      type: string
      title: Content
    variant:
      type: string
      title: Variant
      enum:
        - default
        - highlight
        - compact
slots:
  content:
    title: Content
    description: Main card content
```

## Template Debugging

### Development
```twig
{# Debug render arrays #}
{{ kint(content) }}

{# Debug variables #}
{{ dump(variables) }}
```

### Production (Never commit these!)
- Remove all `kint()`, `dump()`, `dpm()` calls
- Remove Twig debug comments
- Ensure `twig.config.debug: false`

## Accessibility Checklist

- [ ] Semantic HTML5 elements (`<article>`, `<nav>`, `<aside>`, etc.)
- [ ] Heading hierarchy (don't skip levels)
- [ ] All images have `alt` attributes
- [ ] Form labels associated with inputs
- [ ] ARIA landmarks when semantic HTML insufficient
- [ ] Focus indicators visible
- [ ] Color contrast meets WCAG AA
- [ ] Keyboard navigation possible

## Performance Checklist

- [ ] No complex logic in templates (move to preprocess)
- [ ] Lazy loading for heavy fields
- [ ] Cache tags and contexts defined
- [ ] No N+1 query issues (preload entities)
- [ ] Assets loaded via libraries, not inline

## Review Output Format

```markdown
## Critical Issues (Security/XSS)

### File: card.html.twig:15
**Issue**: Unsafe use of `|raw` filter
**Risk**: XSS vulnerability
**Fix**: Remove `|raw` - Drupal escapes by default

## High Priority

### File: node--article.html.twig:22
**Issue**: Hardcoded URL
**Problem**: Breaks multilingual sites, not maintainable
**Fix**: Use `{{ url('entity.node.canonical', {'node': node.id}) }}`

## Accessibility Issues

### File: hero.html.twig:8
**Issue**: Image missing alt attribute
**Impact**: Screen readers can't describe image
**Fix**: Add `alt="{{ image_alt }}"` from component props

## Code Quality

### File: sidebar.html.twig:45
**Issue**: Complex logic in template
**Suggestion**: Move filtering to preprocess function
**Why**: Templates should be presentation-only
```

## References
- [Drupal Twig Documentation](https://www.drupal.org/docs/theming-drupal/twig-in-drupal)
- [Twig Best Practices](https://www.drupal.org/docs/develop/coding-standards/twig-coding-standards)
- [Single Directory Components](https://www.drupal.org/docs/develop/theming-drupal/using-single-directory-components)
