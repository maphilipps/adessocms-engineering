# Tailwind v4 Patterns for adesso CMS

## adesso CMS Utility Classes

### Typography - Headings (use these instead of raw Tailwind)

```twig
{# Responsive heading classes - mobile → desktop #}
<h1 class="h-7xl">3rem → 4.75rem</h1>
<h2 class="h-6xl">2.5rem → 3.75rem</h2>
<h3 class="h-5xl">2rem → 3rem</h3>
<h4 class="h-4xl">1.5rem → 2.5rem</h4>
<h5 class="h-3xl">1.5rem → 2rem</h5>
<h6 class="h-2xl">1.25rem → 1.5rem</h6>
<span class="h-xl">1.125rem → 1.25rem</span>
<span class="h-lg">1rem → 1.125rem</span>
<span class="h-base">1rem</span>
<span class="h-xs">0.875rem uppercase</span>
```

### Typography - Paragraphs

```twig
<p class="p-2xl">1.125rem → 1.5rem</p>
<p class="p-xl">1.125rem → 1.25rem</p>
<p class="p-lg">1rem → 1.125rem</p>
<p class="p-base">1rem</p>
<p class="p-sm">0.875rem</p>
<p class="p-xs">0.75rem</p>
```

### Buttons

```twig
{# Primary filled button #}
<a class="btn">Primary Button</a>

{# Outlined button (white border, transparent bg) #}
<a class="btn-border">Outlined Button</a>

{# Size variants #}
<a class="btn btn-sm">Small (2.5rem height)</a>
<a class="btn btn-xs">Extra Small (2rem height)</a>
```

### Container

```twig
{# Centered container with responsive padding #}
<div class="container">
  {# max-width: 80rem (1280px) #}
  {# padding: 1.5rem (mobile) → 2.5rem (tablet+) #}
</div>

{# Nested containers don't add extra padding #}
<div class="container">
  <div class="container">  {# No double padding #}
```

### Rich Text

```twig
{# Apply to wrapper for proper typography rhythm #}
<div class="rich-text">
  <h1>Auto-styled headings</h1>
  <p>Auto-styled paragraphs with spacing</p>
  <ul><li>Auto-styled lists</li></ul>
</div>

{# Custom rhythm spacing #}
<div class="rich-text" style="--rhythm: 2rem">
```

## CSS-to-Tailwind Conversion

### Layout

| CSS | Tailwind v4 |
|-----|-------------|
| `display: flex` | `flex` |
| `display: grid` | `grid` |
| `flex-direction: column` | `flex-col` |
| `justify-content: center` | `justify-center` |
| `justify-content: space-between` | `justify-between` |
| `align-items: center` | `items-center` |
| `gap: 16px` | `gap-4` |
| `position: absolute` | `absolute` |
| `position: relative` | `relative` |
| `position: sticky` | `sticky` |
| `position: fixed` | `fixed` |
| `inset: 0` | `inset-0` |
| `z-index: 50` | `z-50` |

### Spacing (1 unit = 4px)

| Pixels | Tailwind |
|--------|----------|
| 4px | `1` |
| 8px | `2` |
| 12px | `3` |
| 16px | `4` |
| 20px | `5` |
| 24px | `6` |
| 32px | `8` |
| 40px | `10` |
| 48px | `12` |
| 64px | `16` |
| 80px | `20` |
| 96px | `24` |

### Colors (use semantic names)

```twig
{# Primary colors #}
text-primary bg-primary border-primary
text-primary-400 bg-primary-600

{# Neutral scale (slate-based) #}
text-neutral-50 to text-neutral-950
bg-neutral-50 to bg-neutral-950

{# With opacity #}
text-white/80   {# 80% opacity #}
bg-black/60     {# 60% opacity #}
border-white/30 {# 30% opacity #}

{# Venneker brand colors #}
bg-venneker-gruppe      {# #bbb629 #}
bg-venneker-viehhandel  {# #4e994e #}
bg-venneker-logistik    {# #4d7f7f #}
bg-venneker-natur       {# #c37570 #}
```

### Responsive Breakpoints (Mobile-First)

```twig
{# Base → sm → md → lg → xl → 2xl #}
class="text-sm md:text-base lg:text-lg"
class="hidden lg:flex"
class="flex-col md:flex-row"
class="px-4 md:px-6 lg:px-8"
class="grid-cols-1 md:grid-cols-2 lg:grid-cols-3"
```

| Prefix | Min-width |
|--------|-----------|
| (none) | 0px |
| `sm:` | 640px |
| `md:` | 768px |
| `lg:` | 1024px |
| `xl:` | 1280px |
| `2xl:` | 1536px |

### Grid Layouts

```twig
{# Basic responsive grid #}
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

{# 12-column grid #}
<div class="grid grid-cols-12 gap-4">
  <div class="col-span-12 md:col-span-6 lg:col-span-4">
  <div class="md:col-start-2 md:col-span-10">
```

### State Variants

```twig
{# Hover #}
hover:bg-primary hover:text-white hover:scale-105

{# Focus (accessibility) #}
focus:outline-none focus:ring-2 focus:ring-primary

{# Active #}
active:scale-95

{# Disabled #}
disabled:opacity-50 disabled:cursor-not-allowed

{# Group hover (parent hover affects child) #}
<div class="group">
  <span class="group-hover:text-primary">
</div>
```

### Transitions

```twig
{# Transition properties #}
transition-colors      {# color, background-color, border-color #}
transition-transform   {# transform #}
transition-opacity     {# opacity #}
transition-all         {# all properties #}

{# Duration #}
duration-150 duration-200 duration-300

{# Transform #}
transform hover:scale-105
rotate-180
translate-x-full
-translate-y-2
```

### Common Component Patterns

**Card**:
```twig
<div class="bg-white shadow-lg rounded-lg p-6">
  <h3 class="h-xl mb-4">Title</h3>
  <p class="p-base text-neutral-600">Content</p>
</div>
```

**Navigation Link**:
```twig
<a class="text-sm font-semibold text-neutral-900 hover:text-primary transition-colors">
  Link Text
</a>
```

**Overlay/Backdrop**:
```twig
<div class="fixed inset-0 bg-black/60 z-40">
```

**Slide-in Panel**:
```twig
<div class="fixed top-0 right-0 bottom-0 w-full max-w-sm bg-white z-50">
```

### Dark/Light Theme Toggle

```twig
{% set is_dark = theme|default('dark') == 'dark' %}
{% set bg_class = is_dark ? 'bg-black' : 'bg-white' %}
{% set text_class = is_dark ? 'text-white' : 'text-neutral-900' %}
{% set text_muted = is_dark ? 'text-white/80' : 'text-neutral-600' %}
```

### Accessibility Classes

```twig
{# Screen reader only #}
<span class="sr-only">Hidden text for screen readers</span>

{# Focus visible (show on keyboard focus only) #}
focus:not-sr-only focus:absolute focus:top-0

{# Reduced motion #}
motion-reduce:transition-none
```

### Utility Layer Classes (adesso CMS specific)

```twig
{# Layer for absolute backgrounds #}
<div class="layer">  {# position: absolute; inset: 0; z-index: -1; #}

{# Mega menu styles #}
<div class="mega-menu">
<a class="mega-menu-small-links">
<div class="mega-menu-featured">

{# Header navigation #}
<a class="header-nav-link">  {# Has underline on hover #}
```
