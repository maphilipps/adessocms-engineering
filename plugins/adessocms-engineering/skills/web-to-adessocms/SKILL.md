---
name: web-to-adessocms
description: Convert website UI components to adesso CMS SDC components with Tailwind v4 and Alpine.js. Use when the user wants to "copy", "clone", "replicate", or "convert" a UI element from a website (navigation, hero, footer, cards, etc.) into the adesso CMS theme. Triggers include "copy the navigation from [URL]", "replicate this hero section", "convert this component", "make a component like [website]", or "kopiere von [URL]".
---

# Web to adesso CMS Component Converter

Convert website UI components into adesso CMS Single Directory Components (SDC) by **actually visiting the website and extracting the source code**.

## Core Principles

1. **Browser-First**: Always navigate to the URL and extract real HTML/CSS
2. **Tailwind-Aware**: Source sites use Tailwind, so extract and adapt classes directly
3. **Drupal-First**: Component MUST work in Drupal, not just Storybook

---

## ⚡ Parallelization Mindset

Run these in parallel where possible:
- Screenshots at multiple breakpoints
- HTML extraction + CSS extraction
- Existing component check + source analysis

---

## Phase 1: Navigate & Extract (AUTOMATED)

### Step 1.1: Open Browser and Navigate

```
mcp__claude-in-chrome__tabs_context_mcp
mcp__claude-in-chrome__tabs_create_mcp
mcp__claude-in-chrome__navigate(url="[SOURCE_URL]", tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="wait", duration=3, tabId=<tab_id>)
```

### Step 1.2: Take Screenshots at All Breakpoints

Run in parallel:

```
# Desktop (1280px)
mcp__claude-in-chrome__resize_window(width=1280, height=900, tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)

# Tablet (768px)
mcp__claude-in-chrome__resize_window(width=768, height=1024, tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)

# Mobile (375px)
mcp__claude-in-chrome__resize_window(width=375, height=812, tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)
```

### Step 1.3: Extract HTML of Target Component

Use JavaScript to extract the specific component's HTML:

```
mcp__claude-in-chrome__javascript_tool(
  tabId=<tab_id>,
  action="javascript_exec",
  text="document.querySelector('[SELECTOR]').outerHTML"
)
```

**Common selectors:**
- Header/Nav: `header`, `nav`, `[role="navigation"]`, `.header`, `.navbar`
- Hero: `.hero`, `[class*="hero"]`, `main > section:first-child`
- Footer: `footer`, `.footer`, `[role="contentinfo"]`
- Cards: `.card`, `[class*="card"]`, `article`

### Step 1.4: Extract Tailwind Classes Used

```
mcp__claude-in-chrome__javascript_tool(
  tabId=<tab_id>,
  action="javascript_exec",
  text=`
    const element = document.querySelector('[SELECTOR]');
    const allElements = element.querySelectorAll('*');
    const classes = new Set();

    // Collect all classes
    allElements.forEach(el => {
      el.classList.forEach(cls => classes.add(cls));
    });
    element.classList.forEach(cls => classes.add(cls));

    // Filter for Tailwind-like classes
    const tailwindClasses = [...classes].filter(cls =>
      /^(flex|grid|block|inline|hidden|absolute|relative|fixed|sticky|w-|h-|p-|m-|text-|bg-|border-|rounded-|shadow-|opacity-|z-|gap-|space-|justify-|items-|self-|col-|row-|overflow-|transition|duration-|ease-|transform|translate-|rotate-|scale-|hover:|focus:|active:|group-|sm:|md:|lg:|xl:|2xl:)/.test(cls)
    );

    JSON.stringify({
      allClasses: [...classes],
      tailwindClasses: tailwindClasses,
      count: classes.size
    }, null, 2)
  `
)
```

### Step 1.5: Extract Computed Styles for Key Elements

```
mcp__claude-in-chrome__javascript_tool(
  tabId=<tab_id>,
  action="javascript_exec",
  text=`
    const element = document.querySelector('[SELECTOR]');
    const styles = window.getComputedStyle(element);

    JSON.stringify({
      backgroundColor: styles.backgroundColor,
      color: styles.color,
      fontFamily: styles.fontFamily,
      fontSize: styles.fontSize,
      fontWeight: styles.fontWeight,
      padding: styles.padding,
      margin: styles.margin,
      display: styles.display,
      flexDirection: styles.flexDirection,
      gap: styles.gap,
      maxWidth: styles.maxWidth
    }, null, 2)
  `
)
```

### Step 1.6: Extract Interactive Behavior Hints

```
mcp__claude-in-chrome__javascript_tool(
  tabId=<tab_id>,
  action="javascript_exec",
  text=`
    const element = document.querySelector('[SELECTOR]');

    // Check for Alpine.js
    const hasAlpine = element.querySelector('[x-data]') !== null;
    const alpineData = [...element.querySelectorAll('[x-data]')].map(el => ({
      data: el.getAttribute('x-data'),
      show: el.getAttribute('x-show'),
      click: el.getAttribute('@click') || el.getAttribute('x-on:click')
    }));

    // Check for dropdowns/toggles
    const hasDropdowns = element.querySelectorAll('[class*="dropdown"], [class*="menu"], [aria-expanded]').length > 0;

    // Check for mobile menu
    const hasMobileMenu = element.querySelector('[class*="mobile"], [class*="hamburger"], button[aria-label*="menu"]') !== null;

    JSON.stringify({
      hasAlpine,
      alpineData,
      hasDropdowns,
      hasMobileMenu
    }, null, 2)
  `
)
```

---

## Phase 2: Analyze Extracted Code

### Step 2.1: Check Existing adesso CMS Components

```bash
ls web/themes/custom/adesso_cms_theme/components/
```

**Key existing components:**
- `site-header` - Navigation (dark/light, mega menu, mobile)
- `hero` - Hero sections with variants
- `page-header` - Combined header + hero
- `site-footer` - Footer with menu integration
- `card-group` - Card layouts
- `accordion` - Collapsible content

**Decision:** Extend existing OR create new? Prefer extending.

### Step 2.2: Map Extracted Tailwind to adesso CMS Classes

| Source Tailwind | adesso CMS Equivalent |
|-----------------|----------------------|
| `text-sm`, `text-base`, `text-lg` | `.p-sm`, `.p-base`, `.p-lg` |
| `text-xl`, `text-2xl`, `text-3xl` | `.h-xl`, `.h-2xl`, `.h-3xl` |
| `max-w-7xl`, `mx-auto`, `px-4` | `.container` |
| `bg-gray-*`, `bg-slate-*` | `bg-neutral-*` |
| `text-gray-*`, `text-slate-*` | `text-neutral-*` |
| `bg-green-*`, `bg-lime-*` | `bg-primary` / `bg-primary-*` |

### Step 2.3: Document Extraction Results

```markdown
## Extraction Results

### Screenshots
- Desktop (1280px): [captured]
- Tablet (768px): [captured]
- Mobile (375px): [captured]

### HTML Structure
[Extracted HTML]

### Tailwind Classes Used
[List of classes]

### Computed Styles
- Background: [color]
- Text: [color]
- Font: [family, size, weight]

### Interactive Elements
- Alpine.js: [yes/no]
- Dropdowns: [yes/no]
- Mobile menu: [yes/no]

### Recommended Approach
- [ ] Extend existing component: [name]
- [ ] Create new component: [name]
```

---

## Phase 3: Create SDC Component

### Step 3.1: File Structure

```
components/[name]/
├── [name].component.yml  # REQUIRED: Schema
├── [name].twig           # REQUIRED: Template
├── [name].css            # OPTIONAL: Custom styles (from extracted CSS)
```

### Step 3.2: Convert HTML to Twig

**Rules:**
1. Keep Tailwind classes that work with our config
2. Replace color classes with adesso CMS variables
3. Replace typography classes with adesso CMS classes
4. Add `{{ attributes }}` to root element
5. Convert hardcoded content to props/slots
6. Keep Alpine.js patterns (we use Alpine too!)

**Before (extracted):**
```html
<header class="bg-slate-900 text-white">
  <div class="max-w-7xl mx-auto px-4 py-6">
    <h1 class="text-3xl font-bold">Company Name</h1>
    <nav class="flex gap-4">
      <a href="/about">About</a>
      <a href="/contact">Contact</a>
    </nav>
  </div>
</header>
```

**After (Twig):**
```twig
{% set theme = theme|default('dark') %}
{% set is_dark = theme == 'dark' %}

<header {{ attributes.addClass([
  'c-site-header',
  is_dark ? 'bg-neutral-900 text-white' : 'bg-white text-neutral-900'
]) }}>
  <div class="container py-6">
    {% if site_name %}
      <h1 class="h-3xl font-bold">{{ site_name }}</h1>
    {% endif %}

    {% if menu_items %}
      <nav class="flex gap-4">
        {% for item in menu_items %}
          <a href="{{ item.url }}">{{ item.title }}</a>
        {% endfor %}
      </nav>
    {% endif %}
  </div>
</header>
```

### Step 3.3: Create Component Schema

Based on extracted dynamic content:

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/11.x/core/modules/sdc/src/metadata.schema.json
name: Component Name
description: Converted from [SOURCE_URL]
status: stable

props:
  type: object
  properties:
    theme:
      type: string
      enum: [dark, light]
      default: dark
    # Add props based on extracted content

slots:
  content:
    title: Content
```

---

## Phase 4: Validate in Drupal

### Step 4.1: Build and Clear Cache

```bash
ddev theme build
ddev drush cr
```

### Step 4.2: Visual Comparison with Chrome

```
# Navigate to Drupal site
mcp__claude-in-chrome__navigate(url="https://[PROJECT].ddev.site", tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="wait", duration=2, tabId=<tab_id>)

# Take comparison screenshots at same breakpoints
mcp__claude-in-chrome__resize_window(width=1280, height=900, tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)

# Check console for errors
mcp__claude-in-chrome__read_console_messages(tabId=<tab_id>, onlyErrors=true)
```

### Step 4.3: Verification Checklist

- [ ] Component renders in Drupal
- [ ] Visual appearance matches source
- [ ] Responsive behavior works
- [ ] Interactive elements work (dropdowns, mobile menu)
- [ ] No console errors
- [ ] Tailwind classes compile correctly

---

## Quick Reference

### JavaScript Extraction Snippets

**Get all HTML:**
```javascript
document.querySelector('[SELECTOR]').outerHTML
```

**Get all classes:**
```javascript
[...document.querySelector('[SELECTOR]').querySelectorAll('*')].flatMap(el => [...el.classList])
```

**Get inline styles:**
```javascript
document.querySelector('[SELECTOR]').getAttribute('style')
```

**Get SVG icons:**
```javascript
[...document.querySelectorAll('svg')].map(svg => svg.outerHTML)
```

### Common Component Selectors

| Component | Try These Selectors |
|-----------|---------------------|
| Header | `header`, `nav`, `.header`, `.navbar`, `[role="banner"]` |
| Hero | `.hero`, `main > section:first-child`, `[class*="hero"]` |
| Footer | `footer`, `.footer`, `[role="contentinfo"]` |
| Card | `.card`, `article`, `[class*="card"]` |
| Button | `.btn`, `button`, `[class*="button"]` |

### Color Mapping

| Tailwind Default | adesso CMS |
|-----------------|------------|
| `gray-50` - `gray-950` | `neutral-50` - `neutral-950` |
| `slate-50` - `slate-950` | `neutral-50` - `neutral-950` |
| Green/Lime accents | `primary` / `primary-*` |
