# Tailwind v4 Integration for SDCs

Complete guide for integrating Tailwind CSS v4 with Drupal SDC components.

## Main CSS Entry Point

Create `src/main.css` as the entry point:

```css
@import "tailwindcss";

/* Component imports */
@import "../components/button/button.tailwind.css";
@import "../components/card/card.tailwind.css";
@import "../components/navbar/navbar.tailwind.css";

/* Theme configuration */
@theme inline {
  /* Colors from CSS custom properties */
  --color-background: var(--background);
  --color-foreground: var(--foreground);
  --color-primary: var(--primary);
  --color-primary-foreground: var(--primary-foreground);
  --color-secondary: var(--secondary);
  --color-secondary-foreground: var(--secondary-foreground);
  --color-muted: var(--muted);
  --color-muted-foreground: var(--muted-foreground);
  --color-accent: var(--accent);
  --color-accent-foreground: var(--accent-foreground);
  --color-destructive: var(--destructive);
  --color-border: var(--border);
  --color-input: var(--input);
  --color-ring: var(--ring);

  /* Typography */
  --font-sans: var(--font-sans);
  --font-serif: var(--font-serif);
  --font-mono: var(--font-mono);

  /* Spacing & Sizing */
  --spacing: 4px;
  --radius-sm: calc(var(--radius) - 4px);
  --radius-md: calc(var(--radius) - 2px);
  --radius-lg: var(--radius);
  --radius-xl: calc(var(--radius) + 4px);
}

/* Base layer - resets and defaults */
@layer base {
  *,
  ::after,
  ::before {
    border-color: var(--color-border);
  }

  body {
    @apply bg-background text-foreground;
    font-feature-settings: "rlig" 1, "calt" 1;
  }

  /* Focus visible for all interactive elements */
  :focus-visible {
    @apply outline-none ring-2 ring-ring ring-offset-2 ring-offset-background;
  }
}

/* Component layer - reusable component styles */
@layer components {
  /* Screen reader only utility */
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
}

/* Utilities layer - custom utilities */
@layer utilities {
  /* Responsive heading utilities */
  .heading-responsive-6xl {
    @apply text-4xl md:text-5xl xl:text-6xl;
  }

  .heading-responsive-5xl {
    @apply text-3xl md:text-4xl xl:text-5xl;
  }

  .heading-responsive-4xl {
    @apply text-2xl md:text-3xl xl:text-4xl;
  }

  /* Text balance for headings */
  .text-balance {
    text-wrap: balance;
  }

  /* Container utilities */
  .container-narrow {
    @apply max-w-3xl mx-auto px-4 md:px-6;
  }

  .container-wide {
    @apply max-w-7xl mx-auto px-4 md:px-6 lg:px-8;
  }
}
```

## Theme CSS Variables

Create `src/theme.css` for runtime theming (no rebuild needed):

```css
:root {
  /* Light theme colors */
  --background: oklch(0.99 0 0);
  --foreground: oklch(0.13 0.028 261.692);

  --primary: oklch(0.55 0.2 260);
  --primary-foreground: oklch(0.99 0 0);

  --secondary: oklch(0.95 0.01 260);
  --secondary-foreground: oklch(0.2 0.02 260);

  --muted: oklch(0.95 0.01 260);
  --muted-foreground: oklch(0.5 0.02 260);

  --accent: oklch(0.95 0.03 260);
  --accent-foreground: oklch(0.2 0.02 260);

  --destructive: oklch(0.55 0.2 25);

  --border: oklch(0.9 0.01 260);
  --input: oklch(0.9 0.01 260);
  --ring: oklch(0.55 0.2 260);

  /* Typography */
  --font-sans: system-ui, -apple-system, sans-serif;
  --font-serif: Georgia, Cambria, serif;
  --font-mono: ui-monospace, monospace;

  /* Spacing */
  --radius: 0.5rem;
}

/* Dark theme */
.dark,
[data-theme="dark"] {
  --background: oklch(0.13 0.028 261.692);
  --foreground: oklch(0.95 0.01 260);

  --primary: oklch(0.7 0.15 260);
  --primary-foreground: oklch(0.13 0.028 261.692);

  --secondary: oklch(0.2 0.02 260);
  --secondary-foreground: oklch(0.95 0.01 260);

  --muted: oklch(0.2 0.02 260);
  --muted-foreground: oklch(0.65 0.02 260);

  --accent: oklch(0.25 0.03 260);
  --accent-foreground: oklch(0.95 0.01 260);

  --destructive: oklch(0.6 0.2 25);

  --border: oklch(0.25 0.02 260);
  --input: oklch(0.25 0.02 260);
  --ring: oklch(0.7 0.15 260);
}

/* System preference dark mode */
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    --background: oklch(0.13 0.028 261.692);
    --foreground: oklch(0.95 0.01 260);
    /* ... rest of dark theme variables */
  }
}
```

## Component-Specific CSS

Create `component-name.tailwind.css` for component-specific styles:

```css
@layer components;

/* Component-specific styles that can't be expressed with utilities */
.navbar--menu:not(.navbar--menu--open) {
  @apply hidden md:flex;
}

.navbar--menu--open {
  @apply fixed inset-0 z-50 flex flex-col bg-background;
}

/* Custom animations */
.accordion--content {
  display: grid;
  grid-template-rows: 0fr;
  transition: grid-template-rows 300ms ease-out;
}

.accordion--content[data-open="true"] {
  grid-template-rows: 1fr;
}

.accordion--content > div {
  overflow: hidden;
}
```

## OKLCH Color System

Tailwind v4 uses OKLCH for perceptually uniform colors:

```
oklch(L C H)
│    │ │
│    │ └── Hue: 0-360 (color wheel position)
│    └──── Chroma: 0-0.4 (saturation)
└───────── Lightness: 0-1 (0=black, 1=white)
```

### OKLCH Advantages

1. **Perceptual uniformity** - Colors look equally bright
2. **Predictable modifications** - Darken/lighten by adjusting L
3. **Consistent saturation** - Same chroma = same vibrancy
4. **Wide gamut support** - P3 displays get full color range

### Common Color Patterns

```css
/* Primary color with variants */
--primary: oklch(0.55 0.2 260);           /* Base */
--primary-hover: oklch(0.5 0.2 260);      /* Darker */
--primary-light: oklch(0.7 0.15 260);     /* Lighter */
--primary-foreground: oklch(0.99 0 0);    /* White text */

/* Neutral grays (very low chroma) */
--gray-50: oklch(0.98 0.005 260);
--gray-100: oklch(0.95 0.01 260);
--gray-200: oklch(0.9 0.01 260);
--gray-900: oklch(0.2 0.02 260);
```

## Build Configuration

### package.json Scripts

```json
{
  "scripts": {
    "dev": "tailwindcss --input ./src/main.css --watch --output ./build/main.min.css",
    "build": "tailwindcss --input ./src/main.css --minify --output ./build/main.min.css",
    "format": "prettier --write \"**/*.{css,js,twig}\""
  },
  "devDependencies": {
    "tailwindcss": "^4.0.0",
    "prettier": "^3.0.0",
    "prettier-plugin-tailwindcss": "^0.6.0"
  }
}
```

## Responsive Breakpoints

Tailwind v4 default breakpoints:

| Prefix | Min Width | CSS |
|--------|-----------|-----|
| `sm` | 640px | `@media (min-width: 640px)` |
| `md` | 768px | `@media (min-width: 768px)` |
| `lg` | 1024px | `@media (min-width: 1024px)` |
| `xl` | 1280px | `@media (min-width: 1280px)` |
| `2xl` | 1536px | `@media (min-width: 1536px)` |

### Mobile-First Pattern

```twig
<div class="
  {# Mobile first (no prefix) #}
  px-4 py-6 text-base

  {# Tablet #}
  md:px-6 md:py-8 md:text-lg

  {# Desktop #}
  lg:px-8 lg:py-12 lg:text-xl

  {# Wide screens #}
  xl:px-12 xl:py-16
">
```

## Dark Mode Implementation

### Class-Based Toggle

```twig
{# Component with dark mode classes #}
<div class="
  bg-white text-gray-900
  dark:bg-gray-900 dark:text-white

  border border-gray-200
  dark:border-gray-700
">
```

### Using CSS Variables (Preferred)

```twig
{# Uses theme variables that auto-switch #}
<div class="bg-background text-foreground border-border">
```

### JavaScript Theme Toggle

```javascript
// Toggle dark mode
function toggleDarkMode() {
  const html = document.documentElement;
  const isDark = html.classList.toggle('dark');
  localStorage.setItem('theme', isDark ? 'dark' : 'light');
}

// Initialize from localStorage or system preference
function initTheme() {
  const stored = localStorage.getItem('theme');
  const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

  if (stored === 'dark' || (!stored && prefersDark)) {
    document.documentElement.classList.add('dark');
  }
}
```

## Animation Utilities

```css
@layer utilities {
  .animate-fade-in {
    animation: fade-in 300ms ease-out;
  }

  .animate-slide-up {
    animation: slide-up 300ms ease-out;
  }

  .animate-scale-in {
    animation: scale-in 200ms ease-out;
  }
}

@keyframes fade-in {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes slide-up {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes scale-in {
  from {
    opacity: 0;
    transform: scale(0.95);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}
```

## Typography Scale

```twig
{# Heading scale #}
<h1 class="text-4xl md:text-5xl xl:text-6xl font-bold tracking-tight">
<h2 class="text-3xl md:text-4xl font-semibold tracking-tight">
<h3 class="text-2xl md:text-3xl font-semibold">
<h4 class="text-xl md:text-2xl font-medium">
<h5 class="text-lg font-medium">
<h6 class="text-base font-medium">

{# Body text #}
<p class="text-base leading-7 text-muted-foreground">
<p class="text-sm leading-6 text-muted-foreground">
<p class="text-lg leading-8">
```

## Spacing System

Tailwind's spacing scale (based on 4px):

| Class | Value | Pixels |
|-------|-------|--------|
| `p-1` | 0.25rem | 4px |
| `p-2` | 0.5rem | 8px |
| `p-3` | 0.75rem | 12px |
| `p-4` | 1rem | 16px |
| `p-6` | 1.5rem | 24px |
| `p-8` | 2rem | 32px |
| `p-12` | 3rem | 48px |
| `p-16` | 4rem | 64px |

### Section Spacing Pattern

```twig
<section class="py-16 md:py-24 lg:py-32">
  <div class="container-wide space-y-12 md:space-y-16">
    {# Content #}
  </div>
</section>
```
