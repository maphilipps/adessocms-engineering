# Tailwind CSS v4 Integration

## Overview

Tailwind v4 introduces CSS-first configuration with `@theme` directive. This reference covers the v4 patterns used in adesso CMS themes.

---

## Setup

### Main CSS File

```css
/* styles.css */
@import "tailwindcss";

@theme inline {
  /* Custom colors from CSS variables */
  --color-primary: var(--primary);
  --color-primary-foreground: var(--primary-foreground);
  --color-secondary: var(--secondary);
  --color-secondary-foreground: var(--secondary-foreground);

  /* Custom spacing */
  --spacing-section: 6rem;
  --spacing-section-sm: 4rem;

  /* Custom fonts */
  --font-sans: var(--font-family-sans);
  --font-heading: var(--font-family-heading);
}
```

### Vite Configuration

```js
// vite.config.js
import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  plugins: [tailwindcss()],
  build: {
    outDir: 'dist',
    rollupOptions: {
      input: 'src/styles.css',
      output: {
        assetFileNames: '[name][extname]'
      }
    }
  }
});
```

---

## @theme Directive

### Inline Theme (Recommended)

```css
@theme inline {
  --color-brand: #3b82f6;
  --font-display: "Inter", sans-serif;
}
```

### Reference Theme

```css
@theme reference {
  /* Only for IDE autocompletion, not output */
  --color-brand: #3b82f6;
}
```

---

## Color System

### Using CSS Variables

Define in `:root` (usually in a base CSS file):

```css
:root {
  --primary: 220 90% 56%;
  --primary-foreground: 0 0% 100%;
  --secondary: 220 14% 96%;
  --secondary-foreground: 220 9% 46%;
  --background: 0 0% 100%;
  --foreground: 222 47% 11%;
  --muted: 220 14% 96%;
  --muted-foreground: 220 9% 46%;
  --accent: 220 14% 96%;
  --accent-foreground: 222 47% 11%;
  --destructive: 0 84% 60%;
  --destructive-foreground: 0 0% 100%;
  --border: 220 13% 91%;
  --input: 220 13% 91%;
  --ring: 220 90% 56%;
}
```

Map to Tailwind in `@theme`:

```css
@theme inline {
  --color-primary: hsl(var(--primary));
  --color-primary-foreground: hsl(var(--primary-foreground));
  /* ... */
}
```

### Using Colors

```html
<div class="bg-primary text-primary-foreground">
  Primary button
</div>

<div class="bg-secondary text-secondary-foreground">
  Secondary element
</div>
```

---

## Typography

### Font Families

```css
@theme inline {
  --font-sans: "Inter", ui-sans-serif, system-ui, sans-serif;
  --font-heading: "Montserrat", ui-sans-serif, sans-serif;
  --font-mono: "JetBrains Mono", ui-monospace, monospace;
}
```

```html
<h1 class="font-heading text-4xl font-bold">Heading</h1>
<p class="font-sans text-base">Body text</p>
<code class="font-mono text-sm">Code</code>
```

### Font Sizes

Tailwind v4 default scale:

| Class | Size |
|-------|------|
| `text-xs` | 0.75rem |
| `text-sm` | 0.875rem |
| `text-base` | 1rem |
| `text-lg` | 1.125rem |
| `text-xl` | 1.25rem |
| `text-2xl` | 1.5rem |
| `text-3xl` | 1.875rem |
| `text-4xl` | 2.25rem |

---

## Spacing

### Custom Spacing Values

```css
@theme inline {
  --spacing-18: 4.5rem;
  --spacing-section: 6rem;
}
```

```html
<section class="py-section">
  <!-- 6rem padding top/bottom -->
</section>
```

### Container

```css
@theme inline {
  --container-3xl: 1600px;
}
```

---

## Breakpoints

Default Tailwind v4 breakpoints:

| Prefix | Min Width |
|--------|-----------|
| `sm:` | 640px |
| `md:` | 768px |
| `lg:` | 1024px |
| `xl:` | 1280px |
| `2xl:` | 1536px |

### Usage

```html
<div class="px-4 sm:px-6 lg:px-8">
  Responsive padding
</div>

<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
  Responsive grid
</div>
```

---

## Dark Mode

### Class-based (Recommended)

```html
<html class="dark">
  <body class="bg-background text-foreground">
    <div class="bg-card dark:bg-card">
      Content adapts automatically with CSS variables
    </div>
  </body>
</html>
```

### With CSS Variables

```css
:root {
  --background: 0 0% 100%;
  --foreground: 222 47% 11%;
}

.dark {
  --background: 222 47% 11%;
  --foreground: 0 0% 100%;
}
```

---

## Component CSS

For component-specific styles:

```css
/* hero.tailwind.css */
@import "tailwindcss";

/* Component-specific utilities if truly needed */
.hero-gradient {
  background: linear-gradient(
    to bottom,
    theme(colors.primary / 10%),
    transparent
  );
}
```

---

## Build Commands

```bash
# Development (watch mode)
ddev exec npm run dev

# Production build
ddev theme build
# or
ddev exec npm run build
```

---

## Migration from v3

| Tailwind v3 | Tailwind v4 |
|-------------|-------------|
| `tailwind.config.js` | `@theme` in CSS |
| `@tailwind base;` | `@import "tailwindcss";` |
| `theme.extend.colors` | `@theme inline { --color-* }` |
| PostCSS plugin | Vite plugin preferred |
