# Accessibility Checklist for SDCs

WCAG 2.1 Level AA requirements for Drupal Single Directory Components.

## Quick Reference Checklist

Use this checklist for every component:

### Structure & Semantics
- [ ] Uses semantic HTML elements (not just `<div>` and `<span>`)
- [ ] Heading hierarchy is logical (h1 → h2 → h3, no skips)
- [ ] Lists use `<ul>`, `<ol>`, or `<dl>` appropriately
- [ ] Tables have proper headers and captions
- [ ] Landmarks are used correctly (`<nav>`, `<main>`, `<aside>`)

### Keyboard Navigation
- [ ] All interactive elements are focusable
- [ ] Focus order follows visual/logical order
- [ ] Focus is visible and meets contrast requirements
- [ ] No keyboard traps exist
- [ ] Custom widgets support expected keyboard patterns

### ARIA Implementation
- [ ] ARIA is used only when HTML semantics insufficient
- [ ] All ARIA IDs are unique
- [ ] `aria-label` or `aria-labelledby` provided where needed
- [ ] States (`aria-expanded`, `aria-selected`) update correctly
- [ ] Live regions announce dynamic content

### Color & Contrast
- [ ] Text meets 4.5:1 contrast ratio (normal text)
- [ ] Large text meets 3:1 contrast ratio (18px+ or 14px+ bold)
- [ ] UI components meet 3:1 contrast ratio
- [ ] Information not conveyed by color alone
- [ ] Focus indicators meet 3:1 contrast ratio

### Images & Media
- [ ] Images have meaningful alt text
- [ ] Decorative images have empty alt (`alt=""`)
- [ ] Complex images have extended descriptions
- [ ] Videos have captions
- [ ] Audio has transcripts

### Forms
- [ ] All inputs have associated labels
- [ ] Error messages are descriptive
- [ ] Required fields are indicated
- [ ] Form validation is accessible
- [ ] Autocomplete attributes used correctly

### Motion & Animation
- [ ] Animations respect `prefers-reduced-motion`
- [ ] No content flashes more than 3 times per second
- [ ] Auto-playing content can be paused

## Semantic HTML Reference

### Choose the Right Element

| Need | Element | Example |
|------|---------|---------|
| Navigation | `<nav>` | Site menu, breadcrumbs |
| Main content | `<main>` | Primary page content |
| Article/post | `<article>` | Blog post, card content |
| Sidebar | `<aside>` | Related links, ads |
| Section with heading | `<section>` | Page sections |
| Clickable action | `<button>` | Toggles, actions |
| Link to another page | `<a href>` | Navigation links |
| Heading | `<h1>`-`<h6>` | Section titles |
| List of items | `<ul>`, `<ol>` | Navigation, features |
| Definition | `<dl>`, `<dt>`, `<dd>` | Glossaries, metadata |
| Time/date | `<time>` | Publication dates |
| Quotation | `<blockquote>`, `<q>` | Testimonials |

### Common Mistakes

```twig
{# BAD: Divs everywhere #}
<div class="card" onclick="navigate()">
  <div class="title">Heading</div>
  <div class="content">...</div>
</div>

{# GOOD: Semantic structure #}
<article class="card">
  <h3 class="title">Heading</h3>
  <div class="content">...</div>
  <a href="/destination" class="card-link">
    <span class="sr-only">Read more about Heading</span>
  </a>
</article>
```

## Keyboard Navigation Patterns

### Standard Keyboard Behaviors

| Component | Tab | Enter/Space | Escape | Arrows |
|-----------|-----|-------------|--------|--------|
| Button | Focus | Activate | - | - |
| Link | Focus | Navigate | - | - |
| Menu | Focus container | Open/select | Close | Navigate items |
| Tabs | Focus tab list | Select tab | - | Switch tabs |
| Modal | Focus first element | - | Close | - |
| Accordion | Focus header | Toggle | - | Navigate headers |
| Dropdown | Focus trigger | Open/select | Close | Navigate options |

### Focus Management in Twig

```twig
{# Unique IDs for ARIA relationships #}
{% set trigger_id = 'dropdown-trigger'|clean_unique_id %}
{% set menu_id = 'dropdown-menu'|clean_unique_id %}

<button
  id="{{ trigger_id }}"
  aria-haspopup="true"
  aria-expanded="false"
  aria-controls="{{ menu_id }}"
>
  Menu
</button>

<ul
  id="{{ menu_id }}"
  role="menu"
  aria-labelledby="{{ trigger_id }}"
  hidden
>
  <li role="menuitem"><a href="#">Item 1</a></li>
  <li role="menuitem"><a href="#">Item 2</a></li>
</ul>
```

### Focus Trap for Modals

```javascript
class Modal extends ComponentInstance {
  init() {
    this.focusableElements = this.el.querySelectorAll(
      'a[href], button, textarea, input, select, [tabindex]:not([tabindex="-1"])'
    );
    this.firstFocusable = this.focusableElements[0];
    this.lastFocusable = this.focusableElements[this.focusableElements.length - 1];
  }

  trapFocus(e) {
    if (e.key !== 'Tab') return;

    if (e.shiftKey) {
      if (document.activeElement === this.firstFocusable) {
        e.preventDefault();
        this.lastFocusable.focus();
      }
    } else {
      if (document.activeElement === this.lastFocusable) {
        e.preventDefault();
        this.firstFocusable.focus();
      }
    }
  }

  open() {
    this.previousFocus = document.activeElement;
    this.el.hidden = false;
    this.firstFocusable.focus();
    document.addEventListener('keydown', this.trapFocus.bind(this));
  }

  close() {
    this.el.hidden = true;
    document.removeEventListener('keydown', this.trapFocus.bind(this));
    this.previousFocus?.focus();
  }
}
```

## ARIA Reference

### Common ARIA Attributes

```twig
{# Labels #}
aria-label="Close dialog"
aria-labelledby="heading-id"
aria-describedby="description-id"

{# States #}
aria-expanded="true|false"
aria-selected="true|false"
aria-checked="true|false|mixed"
aria-pressed="true|false"
aria-disabled="true"
aria-hidden="true"

{# Properties #}
aria-haspopup="true|menu|listbox|dialog"
aria-controls="element-id"
aria-owns="element-id"
aria-current="page|step|location|date|time|true"

{# Live regions #}
aria-live="polite|assertive|off"
aria-atomic="true|false"
aria-relevant="additions|removals|text|all"
```

### ARIA Roles for Custom Widgets

```twig
{# Tabs #}
<div role="tablist" aria-label="Content sections">
  <button role="tab" aria-selected="true" aria-controls="panel-1">Tab 1</button>
  <button role="tab" aria-selected="false" aria-controls="panel-2">Tab 2</button>
</div>
<div role="tabpanel" id="panel-1" aria-labelledby="tab-1">...</div>
<div role="tabpanel" id="panel-2" aria-labelledby="tab-2" hidden>...</div>

{# Alert #}
<div role="alert" aria-live="assertive">
  Error: Please fill in required fields.
</div>

{# Status #}
<div role="status" aria-live="polite">
  3 items added to cart.
</div>
```

## Color Contrast Requirements

### Minimum Contrast Ratios

| Content Type | Ratio | Example |
|--------------|-------|---------|
| Normal text (<18px) | 4.5:1 | Body copy, labels |
| Large text (≥18px or ≥14px bold) | 3:1 | Headings, large buttons |
| UI components | 3:1 | Button borders, form inputs |
| Focus indicators | 3:1 | Keyboard focus rings |

### Testing with Tailwind

```twig
{# GOOD: Using theme colors with guaranteed contrast #}
<p class="text-foreground bg-background">4.5:1+ contrast</p>
<p class="text-primary-foreground bg-primary">Designed for contrast</p>

{# CHECK: Custom color combinations #}
<p class="text-muted-foreground bg-muted">Verify contrast ratio</p>
```

### Color Blindness Considerations

Never rely on color alone:

```twig
{# BAD: Color only #}
<span class="text-red-500">Error</span>
<span class="text-green-500">Success</span>

{# GOOD: Color + icon + text #}
<span class="text-destructive flex items-center gap-2">
  <svg aria-hidden="true"><!-- X icon --></svg>
  <span>Error: Invalid input</span>
</span>

<span class="text-green-600 flex items-center gap-2">
  <svg aria-hidden="true"><!-- Check icon --></svg>
  <span>Success: Saved</span>
</span>
```

## Focus Indicators

### Visible Focus Styles

```twig
{# Standard focus ring using Tailwind #}
<button class="
  focus-visible:outline-none
  focus-visible:ring-2
  focus-visible:ring-ring
  focus-visible:ring-offset-2
  focus-visible:ring-offset-background
">
  Button
</button>
```

### Custom Focus Indicators

```css
@layer components {
  .custom-focus {
    @apply outline-none;
  }

  .custom-focus:focus-visible {
    @apply ring-2 ring-primary ring-offset-2;
    /* Ensure 3:1 contrast against background */
  }
}
```

## Form Accessibility

### Label Association

```twig
{% set input_id = 'email'|clean_unique_id %}
{% set error_id = 'email-error'|clean_unique_id %}

<div class="form-field">
  <label for="{{ input_id }}" class="form-label">
    Email
    <span class="text-destructive" aria-hidden="true">*</span>
    <span class="sr-only">(required)</span>
  </label>

  <input
    type="email"
    id="{{ input_id }}"
    name="email"
    required
    aria-required="true"
    aria-invalid="{{ has_error ? 'true' : 'false' }}"
    aria-describedby="{{ has_error ? error_id : '' }}"
    autocomplete="email"
    class="form-input {{ has_error ? 'border-destructive' : '' }}"
  >

  {% if has_error %}
    <p id="{{ error_id }}" class="form-error text-destructive">
      Please enter a valid email address.
    </p>
  {% endif %}
</div>
```

### Form Validation

```javascript
class FormField extends ComponentInstance {
  init() {
    this.input = this.el.querySelector('input');
    this.error = this.el.querySelector('[data-error]');

    this.input.addEventListener('invalid', (e) => {
      e.preventDefault();
      this.showError(this.input.validationMessage);
    });

    this.input.addEventListener('input', () => {
      if (this.input.validity.valid) {
        this.clearError();
      }
    });
  }

  showError(message) {
    this.error.textContent = message;
    this.error.hidden = false;
    this.input.setAttribute('aria-invalid', 'true');
    // Announce to screen readers
    this.error.setAttribute('role', 'alert');
  }

  clearError() {
    this.error.hidden = true;
    this.input.setAttribute('aria-invalid', 'false');
    this.error.removeAttribute('role');
  }
}
```

## Motion & Animation

### Respecting User Preferences

```css
@layer utilities {
  .transition-default {
    transition-property: color, background-color, border-color, transform, opacity;
    transition-timing-function: ease-out;
    transition-duration: 200ms;
  }
}

@media (prefers-reduced-motion: reduce) {
  .transition-default {
    transition-duration: 0.01ms !important;
  }

  .animate-* {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
  }
}
```

### In Twig/JavaScript

```twig
<div
  class="transition-default"
  data-animate="{{ not prefers_reduced_motion }}"
>
```

```javascript
const prefersReducedMotion = window.matchMedia(
  '(prefers-reduced-motion: reduce)'
).matches;

if (!prefersReducedMotion) {
  // Run animations
}
```

## Screen Reader Text

### Visually Hidden Class

```css
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border-width: 0;
}
```

### Usage Examples

```twig
{# Icon-only button #}
<button class="p-2">
  <svg aria-hidden="true" class="w-5 h-5"><!-- Close icon --></svg>
  <span class="sr-only">Close menu</span>
</button>

{# "Read more" with context #}
<a href="/article/1">
  Read more<span class="sr-only"> about {{ article_title }}</span>
</a>

{# Skip link #}
<a href="#main-content" class="sr-only focus:not-sr-only focus:absolute focus:p-4 focus:bg-background">
  Skip to main content
</a>
```

## Testing Tools

### Automated Testing

- **axe DevTools** - Browser extension for WCAG testing
- **WAVE** - Web accessibility evaluation tool
- **Lighthouse** - Chrome DevTools accessibility audit
- **Pa11y** - Command-line accessibility testing

### Manual Testing

1. **Keyboard only** - Navigate entire component with Tab, Enter, Space, Escape, Arrows
2. **Screen reader** - Test with VoiceOver (Mac), NVDA (Windows), or Orca (Linux)
3. **Zoom** - Test at 200% and 400% zoom
4. **High contrast** - Test with Windows High Contrast mode
5. **Color blindness** - Use simulators to check color-only information

### Testing Checklist

```markdown
## Accessibility Testing for [Component Name]

### Keyboard
- [ ] Can focus all interactive elements with Tab
- [ ] Focus order is logical
- [ ] Focus indicator is visible
- [ ] Enter/Space activates buttons and links
- [ ] Escape closes modals/dropdowns
- [ ] Arrow keys work for menus/tabs

### Screen Reader
- [ ] Component role announced correctly
- [ ] Labels read appropriately
- [ ] State changes announced
- [ ] No confusing announcements

### Visual
- [ ] Text contrast 4.5:1+
- [ ] UI component contrast 3:1+
- [ ] Works at 200% zoom
- [ ] No horizontal scroll at 320px width
```
