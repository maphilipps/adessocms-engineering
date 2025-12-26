# Alpine.js Patterns for adesso CMS

## Available Alpine.js Plugins

adesso CMS includes these Alpine plugins:
- **Alpine.js 3.x** - Core library
- **@alpinejs/collapse** - Smooth accordion animations
- **@alpinejs/anchor** - Dropdown positioning

## Basic Setup

Alpine directives are added directly to HTML elements. No separate JS file needed for simple interactions.

```twig
<div x-data="{ open: false }">
  <button @click="open = !open">Toggle</button>
  <div x-show="open">Content</div>
</div>
```

## Common Patterns

### Dropdown Menu (Hover)

```twig
<div class="relative"
     x-data="{ open: false }"
     @mouseenter="open = true"
     @mouseleave="open = false">

  <button class="flex items-center gap-1">
    Menu
    <svg class="size-4 transition-transform" :class="open ? 'rotate-180' : ''">
      <!-- chevron icon -->
    </svg>
  </button>

  <div class="absolute top-full left-0 mt-2 min-w-48 bg-white shadow-xl z-50"
       x-show="open"
       x-transition:enter="transition ease-out duration-200"
       x-transition:enter-start="opacity-0 -translate-y-2"
       x-transition:enter-end="opacity-100 translate-y-0"
       x-transition:leave="transition ease-in duration-150"
       x-transition:leave-start="opacity-100 translate-y-0"
       x-transition:leave-end="opacity-0 -translate-y-2"
       x-cloak>
    <a href="#" class="block px-4 py-2 hover:bg-neutral-50">Item 1</a>
    <a href="#" class="block px-4 py-2 hover:bg-neutral-50">Item 2</a>
  </div>
</div>
```

### Dropdown Menu (Click)

```twig
<div class="relative"
     x-data="{ open: false }"
     @click.outside="open = false">

  <button @click="open = !open"
          :aria-expanded="open"
          aria-haspopup="true">
    Menu
  </button>

  <div class="absolute top-full right-0 mt-1 min-w-40 bg-white shadow-xl rounded-lg z-50"
       x-show="open"
       x-transition
       x-cloak
       role="menu">
    <a href="#" class="block px-4 py-2" role="menuitem">Item 1</a>
    <a href="#" class="block px-4 py-2" role="menuitem">Item 2</a>
  </div>
</div>
```

### Mobile Menu (Slide-in Panel)

```twig
<nav x-data="{ mobileMenuOpen: false }">
  {# Toggle button #}
  <button @click="mobileMenuOpen = true"
          class="lg:hidden"
          :aria-expanded="mobileMenuOpen"
          aria-controls="mobile-menu">
    <svg><!-- hamburger icon --></svg>
    <span class="sr-only">{{ 'Open menu'|t }}</span>
  </button>

  {# Mobile panel wrapper #}
  <div class="lg:hidden"
       x-show="mobileMenuOpen"
       @keydown.escape.window="mobileMenuOpen = false"
       x-cloak>

    {# Backdrop #}
    <div class="fixed inset-0 bg-black/60 z-40"
         x-show="mobileMenuOpen"
         x-transition:enter="transition-opacity ease-out duration-300"
         x-transition:enter-start="opacity-0"
         x-transition:enter-end="opacity-100"
         x-transition:leave="transition-opacity ease-in duration-200"
         @click="mobileMenuOpen = false">
    </div>

    {# Slide-in panel #}
    <div id="mobile-menu"
         class="fixed top-0 right-0 bottom-0 w-full max-w-sm bg-white z-50 overflow-y-auto"
         x-show="mobileMenuOpen"
         x-transition:enter="transition ease-out duration-300"
         x-transition:enter-start="translate-x-full"
         x-transition:enter-end="translate-x-0"
         x-transition:leave="transition ease-in duration-200"
         x-transition:leave-start="translate-x-0"
         x-transition:leave-end="translate-x-full">

      <button @click="mobileMenuOpen = false"
              class="absolute top-4 right-4"
              aria-label="{{ 'Close menu'|t }}">
        <svg><!-- close icon --></svg>
      </button>

      {# Menu content #}
      <nav class="p-6">
        <!-- menu items -->
      </nav>
    </div>
  </div>
</nav>
```

### Accordion with x-collapse

```twig
<div class="divide-y">
  {% for item in items %}
    <div x-data="{ expanded: {{ loop.first ? 'true' : 'false' }} }">
      <button @click="expanded = !expanded"
              class="flex w-full items-center justify-between py-4"
              :aria-expanded="expanded">
        <span class="h-xl">{{ item.title }}</span>
        <svg class="size-5 transition-transform duration-200"
             :class="expanded ? 'rotate-180' : ''"
             fill="currentColor" viewBox="0 0 20 20">
          <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"/>
        </svg>
      </button>

      <div x-show="expanded" x-collapse>
        <div class="pb-4 text-neutral-600">
          {{ item.content }}
        </div>
      </div>
    </div>
  {% endfor %}
</div>
```

### Tabs

```twig
<div x-data="{ activeTab: 'tab1' }">
  {# Tab buttons #}
  <div class="flex gap-2 border-b" role="tablist">
    {% for tab in tabs %}
      <button @click="activeTab = '{{ tab.id }}'"
              class="px-4 py-2 -mb-px border-b-2 transition-colors"
              :class="activeTab === '{{ tab.id }}'
                ? 'border-primary text-primary'
                : 'border-transparent text-neutral-600 hover:text-neutral-900'"
              role="tab"
              :aria-selected="activeTab === '{{ tab.id }}'"
              aria-controls="panel-{{ tab.id }}">
        {{ tab.title }}
      </button>
    {% endfor %}
  </div>

  {# Tab panels #}
  {% for tab in tabs %}
    <div x-show="activeTab === '{{ tab.id }}'"
         x-transition:enter="transition ease-out duration-200"
         x-transition:enter-start="opacity-0"
         x-transition:enter-end="opacity-100"
         id="panel-{{ tab.id }}"
         role="tabpanel"
         class="py-4">
      {{ tab.content }}
    </div>
  {% endfor %}
</div>
```

### Search Toggle

```twig
<div x-data="{ searchOpen: false }"
     @keydown.window.slash.prevent="searchOpen = true; $nextTick(() => $refs.searchInput.focus())"
     @keydown.escape.window="searchOpen = false">

  <button @click="searchOpen = !searchOpen"
          :aria-expanded="searchOpen"
          aria-label="{{ 'Toggle search'|t }}">
    <svg><!-- search icon --></svg>
  </button>

  <div class="absolute top-full left-0 right-0 bg-white shadow-xl p-6"
       x-show="searchOpen"
       x-transition
       x-cloak>
    <form action="/search" method="get" role="search">
      <input x-ref="searchInput"
             type="search"
             name="keys"
             placeholder="{{ 'Search...'|t }}"
             class="w-full h-14 px-6 text-lg border-2 focus:border-primary"
             autocomplete="off">
    </form>
    <p class="mt-2 text-sm text-neutral-500">
      {{ 'Press "/" to open, "Esc" to close'|t }}
    </p>
  </div>
</div>
```

### Language Picker

```twig
<div class="relative"
     x-data="{ open: false }"
     @click.outside="open = false">

  <button @click="open = !open"
          class="flex items-center gap-2"
          :aria-expanded="open"
          aria-haspopup="listbox">
    <svg><!-- globe icon --></svg>
    <span>{{ current_language|upper }}</span>
  </button>

  <div class="absolute top-full right-0 mt-1 min-w-32 bg-white shadow-xl rounded-lg overflow-hidden"
       x-show="open"
       x-transition
       x-cloak
       role="listbox"
       aria-label="{{ 'Select language'|t }}">
    {% for lang in language_options %}
      <a href="{{ lang.url }}"
         class="block px-4 py-2 hover:bg-neutral-100 {{ lang.code == current_language ? 'bg-neutral-100 font-semibold' : '' }}"
         role="option"
         {% if lang.code == current_language %}aria-selected="true"{% endif %}>
        {{ lang.name }}
      </a>
    {% endfor %}
  </div>
</div>
```

## Key Directives Reference

| Directive | Purpose |
|-----------|---------|
| `x-data` | Initialize component state |
| `x-show` | Toggle visibility (keeps in DOM) |
| `x-if` | Conditional rendering (removes from DOM) |
| `x-cloak` | Hide until Alpine initializes |
| `x-transition` | Animate enter/leave |
| `x-collapse` | Accordion collapse animation (plugin) |
| `@click` | Click event handler |
| `@mouseenter/@mouseleave` | Hover events |
| `@keydown.escape` | Keyboard events |
| `@click.outside` | Click outside element |
| `@click.away` | Alias for click.outside |
| `:class` | Dynamic class binding |
| `:aria-expanded` | Dynamic ARIA attributes |
| `x-ref` | Element reference |
| `$refs` | Access referenced elements |
| `$nextTick` | Run after DOM update |

## Accessibility Requirements

```twig
{# Always include proper ARIA attributes #}
<button :aria-expanded="open" aria-haspopup="true">
<div role="menu">
<div role="tablist">
<button role="tab" :aria-selected="active">
<div role="tabpanel">
<div role="listbox">
<a role="option" :aria-selected="selected">

{# Escape key should close overlays #}
@keydown.escape.window="open = false"

{# Manage focus #}
x-ref="input"
$nextTick(() => $refs.input.focus())
```

## Animation Timing Guidelines

| Use Case | Duration |
|----------|----------|
| Quick feedback (hover states) | 150ms |
| Standard transitions (dropdowns) | 200ms |
| Slide panels (mobile menu) | 300ms |
| Complex animations | 300-500ms |

## Best Practices

1. **Use `x-cloak`** on all hidden elements to prevent flash of unstyled content
2. **Always add ARIA** attributes for accessibility
3. **Escape key** should close all overlays
4. **Click outside** should close dropdowns
5. **Focus management** - set focus when opening modals/search
6. **Reduced motion** - respect `prefers-reduced-motion`
