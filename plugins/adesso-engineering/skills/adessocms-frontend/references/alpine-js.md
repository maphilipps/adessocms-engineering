# Alpine.js Patterns for SDC

## Overview

Alpine.js provides lightweight interactivity for SDC components. It's the recommended approach for client-side behavior in adesso CMS themes.

---

## Setup

### Library Definition

```yaml
# <theme>.libraries.yml
alpine:
  js:
    https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js:
      type: external
      attributes:
        defer: true
```

### Component Dependency

```yaml
# component.component.yml
libraryOverrides:
  js:
    component.js: {}
  dependencies:
    - <theme>/alpine
```

---

## Basic Patterns

### Component Data

```js
// component.js
document.addEventListener('alpine:init', () => {
  Alpine.data('componentName', () => ({
    // Reactive state
    isOpen: false,
    count: 0,

    // Computed (getter)
    get doubled() {
      return this.count * 2
    },

    // Methods
    toggle() {
      this.isOpen = !this.isOpen
    },

    increment() {
      this.count++
    },

    // Lifecycle
    init() {
      console.log('Component initialized')
    }
  }))
})
```

### In Twig

```twig
<div x-data="componentName">
  <button @click="toggle">
    Toggle
  </button>

  <div x-show="isOpen" x-transition>
    Content revealed
  </div>

  <p>Count: <span x-text="count"></span></p>
  <button @click="increment">+1</button>
</div>
```

---

## Common Interactions

### Toggle/Accordion

```twig
<div x-data="{ open: false }">
  <button
    @click="open = !open"
    :aria-expanded="open"
  >
    <span x-text="open ? 'Close' : 'Open'"></span>
  </button>

  <div
    x-show="open"
    x-collapse
    x-cloak
  >
    Collapsible content
  </div>
</div>
```

### Tabs

```js
Alpine.data('tabs', () => ({
  activeTab: 0,

  isActive(index) {
    return this.activeTab === index
  },

  setActive(index) {
    this.activeTab = index
  }
}))
```

```twig
<div x-data="tabs">
  <div role="tablist">
    {% for tab in tabs %}
      <button
        role="tab"
        :aria-selected="isActive({{ loop.index0 }})"
        @click="setActive({{ loop.index0 }})"
        :class="isActive({{ loop.index0 }}) ? 'active' : ''"
      >
        {{ tab.label }}
      </button>
    {% endfor %}
  </div>

  {% for tab in tabs %}
    <div
      role="tabpanel"
      x-show="isActive({{ loop.index0 }})"
    >
      {{ tab.content }}
    </div>
  {% endfor %}
</div>
```

### Dropdown/Menu

```twig
<div x-data="{ open: false }" @click.outside="open = false">
  <button @click="open = !open">
    Menu
  </button>

  <div
    x-show="open"
    x-transition:enter="transition ease-out duration-100"
    x-transition:enter-start="opacity-0 scale-95"
    x-transition:enter-end="opacity-100 scale-100"
    x-transition:leave="transition ease-in duration-75"
    x-transition:leave-start="opacity-100 scale-100"
    x-transition:leave-end="opacity-0 scale-95"
    class="absolute mt-2 w-48 bg-white shadow-lg rounded"
  >
    <a href="#">Item 1</a>
    <a href="#">Item 2</a>
  </div>
</div>
```

### Modal/Dialog

```js
Alpine.data('modal', () => ({
  open: false,

  show() {
    this.open = true
    document.body.classList.add('overflow-hidden')
  },

  close() {
    this.open = false
    document.body.classList.remove('overflow-hidden')
  }
}))
```

```twig
<div x-data="modal">
  <button @click="show">Open Modal</button>

  <div
    x-show="open"
    x-trap.inert.noscroll="open"
    @keydown.escape.window="close"
    class="fixed inset-0 z-50"
  >
    <div
      class="fixed inset-0 bg-black/50"
      @click="close"
    ></div>

    <div class="relative bg-white p-6 rounded-lg">
      <h2>Modal Title</h2>
      <p>Modal content</p>
      <button @click="close">Close</button>
    </div>
  </div>
</div>
```

---

## Directives Reference

### Core Directives

| Directive | Purpose |
|-----------|---------|
| `x-data` | Define component scope |
| `x-init` | Run on initialization |
| `x-show` | Toggle visibility |
| `x-if` | Conditional render (removes from DOM) |
| `x-for` | Loop rendering |
| `x-text` | Set text content |
| `x-html` | Set HTML content |
| `x-bind` / `:` | Bind attributes |
| `x-on` / `@` | Event listeners |
| `x-model` | Two-way binding |
| `x-ref` | Element reference |

### Modifiers

```twig
{# Event modifiers #}
@click.prevent      {# preventDefault #}
@click.stop         {# stopPropagation #}
@click.outside      {# Click outside element #}
@click.once         {# Only fire once #}
@click.debounce     {# Debounce handler #}

{# Key modifiers #}
@keydown.enter
@keydown.escape
@keydown.arrow-up
```

### Transitions

```twig
x-transition                    {# Default fade #}
x-transition.duration.500ms     {# Custom duration #}
x-transition.opacity            {# Opacity only #}
x-transition.scale              {# Scale effect #}

{# Custom transitions #}
x-transition:enter="..."
x-transition:enter-start="..."
x-transition:enter-end="..."
x-transition:leave="..."
x-transition:leave-start="..."
x-transition:leave-end="..."
```

---

## Plugins

### x-collapse

```twig
<div x-show="open" x-collapse>
  Smoothly collapsing content
</div>
```

### x-trap (Focus Trap)

```twig
<div x-trap="modalOpen">
  {# Focus trapped within this element #}
</div>
```

---

## Best Practices

1. **Register components globally** - Use `Alpine.data()` for reusable logic
2. **Keep state minimal** - Only track what changes
3. **Use x-cloak** - Prevent flash of unstyled content
4. **Accessibility first** - Add ARIA attributes
5. **Debounce expensive operations** - Use `.debounce` modifier
6. **Clean up** - Use `destroy()` for cleanup if needed

---

## Anti-Patterns

❌ **Don't mix with jQuery** - Choose one approach
❌ **Don't overuse x-html** - Security risk with user content
❌ **Don't forget x-cloak** - Causes flicker on load
❌ **Don't nest x-data unnecessarily** - Keep hierarchy flat
