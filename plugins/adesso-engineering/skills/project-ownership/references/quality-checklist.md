# adesso CMS Quality Checklist

## Comprehensive Quality Standards

This checklist covers ALL aspects of component and feature quality.

---

## 1. SDC Structure (Atomic Design)

### Atomic Design Hierarchy

| Level | Description | Examples |
|-------|-------------|----------|
| **Atoms** | Basic building blocks | button, badge, icon, heading, link, spinner |
| **Molecules** | Groups of atoms | card, accordion-item, form-field, media-text |
| **Organisms** | Complex UI sections | header, footer, card-group, hero, menu |
| **Templates** | Page layouts | page-layout, sidebar-layout |
| **Pages** | Specific instances | homepage, article-page |

### Component Placement Rules

```
components/
├── atoms/           # Or flat with naming convention
│   ├── button/
│   ├── badge/
│   └── icon/
├── molecules/
│   ├── card/
│   ├── accordion-item/
│   └── media-text/
├── organisms/
│   ├── header/
│   ├── card-group/
│   └── hero/
└── templates/
    └── page-layout/
```

### Checklist
- [ ] Component categorized correctly (atom/molecule/organism)
- [ ] Atoms don't contain other components (except icons)
- [ ] Molecules composed of atoms only
- [ ] Organisms can contain atoms, molecules, other organisms
- [ ] Clear composition hierarchy documented

---

## 2. Translations (i18n)

### Requirements

Every user-facing string MUST be translatable.

#### In Twig Templates
```twig
{# CORRECT - Translatable #}
<button>{{ 'Read more'|t }}</button>
<span>{{ 'Items: @count'|t({'@count': count}) }}</span>

{# WRONG - Not translatable #}
<button>Read more</button>
```

#### In JavaScript
```javascript
// CORRECT - Use Drupal.t()
const label = Drupal.t('Load more');
const message = Drupal.t('@count items found', { '@count': count });

// WRONG - Hardcoded
const label = 'Load more';
```

#### In PHP
```php
// CORRECT
$this->t('Submit');
$this->formatPlural($count, '1 item', '@count items');

// WRONG
'Submit';
```

### Checklist
- [ ] All UI text uses `|t` filter in Twig
- [ ] All JS strings use `Drupal.t()`
- [ ] All PHP strings use `$this->t()`
- [ ] Placeholders use proper format (`@var`, `%var`, `:var`)
- [ ] Config labels are translatable
- [ ] No hardcoded text in templates

---

## 3. Paragraph Templates

### Standard Structure

Every paragraph type MUST have:

```
recipes/adesso_cms_paragraphs/config/install/
├── paragraphs.paragraphs_type.[name].yml    # Paragraph type
├── field.storage.paragraph.field_*.yml      # Field storage
├── field.field.paragraph.[name].field_*.yml # Field instance
├── core.entity_form_display.paragraph.[name].default.yml
└── core.entity_view_display.paragraph.[name].default.yml
```

### Paragraph Naming Convention

| Type | Machine Name | Display Name |
|------|--------------|--------------|
| Text | `text` | Text |
| Hero | `hero` | Hero Banner |
| Card Group | `card_group` | Card Group |
| Side by Side | `sidebyside` | Side by Side |

### Required Fields (All Paragraphs)

| Field | Machine Name | Type | Purpose |
|-------|--------------|------|---------|
| Heading | `field_heading` | string | Section title |
| Subheading | `field_subheading` | string | Optional subtitle |
| Background | `field_background` | list | Light/Dark/Primary |
| Spacing | `field_spacing` | list | None/Small/Medium/Large |

### Paragraph ↔ SDC Mapping

```yaml
# In paragraph preprocess or template
{{ include('adesso_cms_theme:hero', {
  heading: content.field_heading,
  subheading: content.field_subheading,
  background: paragraph.field_background.value,
}) }}
```

### Checklist
- [ ] Paragraph type has config YAML
- [ ] All fields have proper labels (translatable)
- [ ] Form display configured
- [ ] View display configured
- [ ] Maps to corresponding SDC
- [ ] Consistent field naming across paragraphs
- [ ] Help text provided for editors

---

## 4. Multi-Column Layouts

### Layout Options

Every section component SHOULD support:

| Columns | Use Case |
|---------|----------|
| 1 column | Full-width content |
| 2 columns | Side-by-side, 50/50 or 60/40 |
| 3 columns | Card grids, features |
| 4 columns | Logo grids, small items |

### Implementation Pattern

```yaml
# component.yml
props:
  properties:
    columns:
      type: string
      title: Columns
      default: '1'
      enum:
        - '1'
        - '2'
        - '3'
        - '4'
    column_ratio:
      type: string
      title: Column Ratio
      default: 'equal'
      enum:
        - 'equal'
        - '60-40'
        - '40-60'
        - '70-30'
        - '30-70'
```

```twig
{% set grid_classes = {
  '1': 'grid-cols-1',
  '2': 'grid-cols-1 md:grid-cols-2',
  '3': 'grid-cols-1 md:grid-cols-2 lg:grid-cols-3',
  '4': 'grid-cols-2 md:grid-cols-4',
} %}

<div class="grid gap-6 {{ grid_classes[columns] }}">
  {{ content }}
</div>
```

### Responsive Behavior

| Breakpoint | 2-col | 3-col | 4-col |
|------------|-------|-------|-------|
| Mobile (<640px) | 1 col | 1 col | 2 col |
| Tablet (640-1024px) | 2 col | 2 col | 2 col |
| Desktop (>1024px) | 2 col | 3 col | 4 col |

### Checklist
- [ ] Grid/flex layout used
- [ ] Column count configurable
- [ ] Responsive breakpoints defined
- [ ] Gap spacing consistent
- [ ] Alignment options (if needed)
- [ ] Tested at all breakpoints

---

## 5. Consistent Styling

### Spacing Scale

Use Tailwind spacing consistently:

| Name | Tailwind | Use |
|------|----------|-----|
| none | `0` | No spacing |
| xs | `1` / `2` | Tight, inline |
| sm | `3` / `4` | Compact |
| md | `6` / `8` | Standard |
| lg | `12` / `16` | Sections |
| xl | `20` / `24` | Hero, large gaps |

### Section Spacing

```twig
{% set spacing_classes = {
  'none': 'py-0',
  'small': 'py-8 md:py-12',
  'medium': 'py-12 md:py-16',
  'large': 'py-16 md:py-24',
} %}
```

### Background Variants

```twig
{% set bg_classes = {
  'light': 'bg-white text-gray-900',
  'dark': 'bg-gray-900 text-white',
  'primary': 'bg-primary-600 text-white',
  'muted': 'bg-gray-100 text-gray-900',
} %}
```

### Checklist
- [ ] Uses standard spacing scale
- [ ] Consistent section padding
- [ ] Background variants work
- [ ] Typography scale followed
- [ ] Color palette adhered to

---

## 6. Accessibility (A11y)

### WCAG 2.1 AA Requirements

| Criterion | Requirement |
|-----------|-------------|
| 1.1.1 | Non-text content has alt text |
| 1.3.1 | Semantic HTML structure |
| 1.4.3 | Contrast ratio 4.5:1 (text) |
| 1.4.11 | Contrast ratio 3:1 (UI) |
| 2.1.1 | Keyboard accessible |
| 2.4.7 | Focus visible |
| 4.1.2 | ARIA roles/properties |

### Checklist
- [ ] Semantic HTML elements used
- [ ] Headings in correct order
- [ ] Images have alt text
- [ ] Links have descriptive text
- [ ] Form fields have labels
- [ ] Color contrast sufficient
- [ ] Focus states visible
- [ ] Keyboard navigation works
- [ ] ARIA where needed (not over-used)
- [ ] Tested with screen reader

---

## 7. Performance

### Checklist
- [ ] Images lazy loaded
- [ ] Proper image sizes/srcset
- [ ] Minimal JS in critical path
- [ ] CSS inlined or async
- [ ] No layout shifts (CLS)
- [ ] Fast LCP (<2.5s)
- [ ] Fast FID (<100ms)

---

## 8. Documentation

### Component README

Every component SHOULD have:

```markdown
# Component Name

## Description
What this component does.

## Usage
```twig
{{ include('adesso_cms_theme:component', {
  prop: 'value',
}) }}
```

## Props
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| ... | ... | ... | ... |

## Variants
- Default
- Large
- Dark

## Accessibility
- Keyboard: Tab to navigate
- Screen reader: Announces as...

## Related
- Similar component
- Parent component
```

### Checklist
- [ ] README.md in component folder
- [ ] Props documented
- [ ] Usage example provided
- [ ] Variants listed
- [ ] A11y notes included

---

## Master Checklist Summary

### Before Component is "Done"

**Structure**
- [ ] Follows Atomic Design hierarchy
- [ ] All required files present
- [ ] Correct naming conventions

**Code Quality**
- [ ] Passes all linters
- [ ] No console errors
- [ ] Translations complete

**Visual**
- [ ] Storybook stories complete
- [ ] All variants covered
- [ ] Responsive at all breakpoints
- [ ] Multi-column works (if applicable)

**Integration**
- [ ] Paragraph type configured (if applicable)
- [ ] Maps correctly to SDC
- [ ] Works in Drupal context

**Quality**
- [ ] Accessible (WCAG 2.1 AA)
- [ ] Performant
- [ ] Documented
