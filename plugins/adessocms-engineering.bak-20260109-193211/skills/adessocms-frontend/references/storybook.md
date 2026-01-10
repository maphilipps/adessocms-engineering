# Storybook for SDC Components

## Overview

Storybook provides isolated component development and documentation for SDC components.

---

## Story File Location

```
web/themes/custom/<theme>/components/<component>/
├── <component>.component.yml
├── <component>.twig
├── <component>.tailwind.css
└── <component>.stories.yml    # Storybook stories
```

---

## Basic Story Structure

### YAML Stories (Recommended)

```yaml
# button.stories.yml
title: Components/Button
component: button

stories:
  - name: Primary
    args:
      variant: primary
      size: md
    slots:
      default: Click me

  - name: Secondary
    args:
      variant: secondary
      size: md
    slots:
      default: Secondary Action

  - name: Large
    args:
      variant: primary
      size: lg
    slots:
      default: Large Button
```

### With Multiple Slots

```yaml
# card.stories.yml
title: Components/Card
component: card

stories:
  - name: Default
    args:
      variant: default
    slots:
      heading: Card Title
      content: |
        <p>Card body content goes here. Can include
        multiple paragraphs and HTML.</p>
      footer: |
        <button class="btn">Action</button>

  - name: Featured
    args:
      variant: featured
    slots:
      heading: Featured Item
      content: Special featured content
      media: |
        <img src="https://picsum.photos/400/200" alt="Featured">
```

---

## Args (Props)

### Basic Props

```yaml
stories:
  - name: Example
    args:
      variant: primary      # Enum prop
      size: lg              # Enum prop
      disabled: true        # Boolean prop
      count: 5              # Number prop
```

### With Controls

```yaml
# Define argTypes for Storybook controls
argTypes:
  variant:
    control: select
    options:
      - primary
      - secondary
      - outline
  size:
    control: radio
    options:
      - sm
      - md
      - lg
  disabled:
    control: boolean
```

---

## Slots

### Simple Text Slot

```yaml
slots:
  heading: Simple heading text
```

### HTML Slot

```yaml
slots:
  content: |
    <p>First paragraph</p>
    <p>Second paragraph with <strong>bold</strong> text</p>
```

### Nested Component Slot

```yaml
slots:
  cta: |
    {% include '<theme>:button' with {
      variant: 'primary'
    } %}
      {% block default %}Click Here{% endblock %}
    {% endinclude %}
```

---

## Story Variants

### All Variants Grid

```yaml
# button.stories.yml
title: Components/Button

stories:
  # Variant showcase
  - name: All Variants
    docs:
      description: All button variants at a glance
    template: |
      <div class="grid grid-cols-3 gap-4">
        {% for v in ['primary', 'secondary', 'outline', 'ghost', 'destructive'] %}
          {% include '<theme>:button' with { variant: v } %}
            {% block default %}{{ v|capitalize }}{% endblock %}
          {% endinclude %}
        {% endfor %}
      </div>

  # Size showcase
  - name: All Sizes
    template: |
      <div class="flex items-end gap-4">
        {% for s in ['sm', 'md', 'lg'] %}
          {% include '<theme>:button' with { size: s } %}
            {% block default %}Size {{ s }}{% endblock %}
          {% endinclude %}
        {% endfor %}
      </div>
```

---

## Documentation

### Story Description

```yaml
stories:
  - name: Primary
    docs:
      description: |
        The primary button is used for main call-to-action elements.

        ## Usage Guidelines
        - Use only one primary button per section
        - Place in prominent position
        - Keep label concise (2-4 words)
```

### Component Description

```yaml
# At top of stories file
title: Components/Button
component: button
docs:
  description: |
    Buttons trigger actions or navigation.

    ## Variants
    - **Primary**: Main CTA
    - **Secondary**: Alternative actions
    - **Outline**: Subtle actions
    - **Ghost**: Minimal visual weight
```

---

## Accessibility Testing

### Include A11y Addon

```yaml
stories:
  - name: Accessible Button
    args:
      variant: primary
    slots:
      default: Submit Form
    parameters:
      a11y:
        config:
          rules:
            - id: color-contrast
              enabled: true
```

---

## Responsive Stories

### Mobile vs Desktop

```yaml
stories:
  - name: Mobile View
    parameters:
      viewport:
        defaultViewport: mobile1
    args:
      layout: stacked

  - name: Desktop View
    parameters:
      viewport:
        defaultViewport: desktop
    args:
      layout: grid
```

---

## Story Organization

### Grouping by Category

```yaml
# Atoms
title: Atoms/Button

# Molecules
title: Molecules/Card

# Organisms
title: Organisms/Header

# Templates
title: Templates/Article
```

### Subgrouping

```yaml
title: Components/Forms/Input
title: Components/Forms/Select
title: Components/Forms/Checkbox
```

---

## Running Storybook

```bash
# Start development server
ddev exec npm run storybook

# Build static site
ddev exec npm run build-storybook
```

---

## Best Practices

1. **Cover all variants** - Story for each enum value
2. **Show edge cases** - Long text, empty states
3. **Test accessibility** - Enable a11y checks
4. **Document usage** - Add description to stories
5. **Keep stories isolated** - No external dependencies
6. **Use realistic content** - Not "Lorem ipsum"

---

## Checklist for New Component

- [ ] `<component>.stories.yml` created
- [ ] Default story exists
- [ ] All variants have stories
- [ ] All sizes have stories
- [ ] Edge cases covered (empty, long text)
- [ ] Documentation added
- [ ] Accessibility reviewed
