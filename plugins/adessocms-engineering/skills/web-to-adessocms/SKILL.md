---
name: web-to-adessocms
description: Convert website UI components to adesso CMS SDC components with Tailwind v4 and Alpine.js. Use when the user wants to "copy", "clone", "replicate", or "convert" a UI element from a website (navigation, hero, footer, cards, etc.) into the adesso CMS theme. Triggers include "copy the navigation from [URL]", "replicate this hero section", "convert this component", "make a component like [website]", or "kopiere von [URL]".
---

# Web to adesso CMS Component Converter

Convert website UI components into adesso CMS Single Directory Components (SDC) by **actually visiting the website and extracting the source code**.

## Core Principles

1. **Claude in Chrome**: ALWAYS use `mcp__claude-in-chrome__*` tools. Playwright MCP is ONLY a last-resort fallback!
2. **Browser-First**: Always navigate to the URL and extract real HTML/CSS
3. **Tailwind-Aware**: Source sites use Tailwind, so extract and adapt classes directly
4. **Drupal-First**: Component MUST work in Drupal, not just Storybook
5. **Slots-First**: ALWAYS prefer slots over props for content. Props are ONLY for configuration (theme, variant, size)
6. **Field Templates**: Override field templates to fill component slots - this is how Drupal content flows into SDC

---

## 🌐 Browser Tool Priority

```
┌─────────────────────────────────────────────────────────────┐
│  1. Claude in Chrome (PRIMARY - ALWAYS USE FIRST)           │
│     mcp__claude-in-chrome__tabs_context_mcp                 │
│     mcp__claude-in-chrome__navigate                         │
│     mcp__claude-in-chrome__javascript_tool                  │
│     mcp__claude-in-chrome__computer (screenshot, wait)      │
│     mcp__claude-in-chrome__resize_window                    │
├─────────────────────────────────────────────────────────────┤
│  2. Playwright MCP (FALLBACK ONLY)                          │
│     ⚠️ Only use if Chrome extension is unavailable          │
│     mcp__plugin_adessocms-engineering_pw__*                 │
└─────────────────────────────────────────────────────────────┘
```

**Why Chrome First?**
- Direct browser control via extension
- Better JavaScript execution context
- More reliable for complex sites
- Consistent with other adesso CMS workflows

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

### Step 3.2: Slots vs Props Decision (CRITICAL)

**⚠️ THIS IS MANDATORY - Always follow this decision tree:**

| Content Type | Use | Reason |
|--------------|-----|--------|
| Text from Drupal fields | **SLOT** | Field templates render the content |
| Images from Drupal | **SLOT** | Field templates handle responsive images |
| Links/Buttons | **SLOT** | Field templates provide proper link handling |
| Rich text/WYSIWYG | **SLOT** | Field templates handle formatting |
| Menu items | **SLOT** | Menu block renders the items |
| Theme (dark/light) | **PROP** | Configuration, not content |
| Variant (primary/secondary) | **PROP** | Configuration, not content |
| Size (sm/md/lg) | **PROP** | Configuration, not content |
| Boolean flags | **PROP** | Configuration, not content |
| Layout options | **PROP** | Configuration, not content |

**Rule of Thumb:**
- 🔴 **NEVER** use props for content that comes from Drupal fields
- 🟢 **ALWAYS** use slots for field content → override field templates
- 🟢 **ONLY** use props for configuration/settings

### Step 3.3: Convert HTML to Twig

**Rules:**
1. Keep Tailwind classes that work with our config
2. Replace color classes with adesso CMS variables
3. Replace typography classes with adesso CMS classes
4. Add `{{ attributes }}` to root element
5. **Content → SLOTS** (not props!)
6. **Configuration → PROPS**
7. Keep Alpine.js patterns (we use Alpine too!)

**Before (extracted):**
```html
<section class="bg-slate-900 text-white py-24">
  <div class="max-w-7xl mx-auto px-4">
    <span class="text-lime-500 uppercase">Tagline</span>
    <h1 class="text-5xl font-bold mt-4">Hero Headline</h1>
    <p class="text-xl mt-6 text-gray-300">Description text here</p>
    <a href="/cta" class="mt-8 bg-lime-500 px-6 py-3 rounded">Get Started</a>
  </div>
</section>
```

**After (Twig with SLOTS):**
```twig
{% set theme = theme|default('dark') %}
{% set is_dark = theme == 'dark' %}

<section {{ attributes.addClass([
  'c-hero',
  is_dark ? 'bg-neutral-900 text-white' : 'bg-white text-neutral-900'
]) }}>
  <div class="container py-24">
    {# SLOT: Tagline - filled by field template #}
    {% if tagline %}
      <div class="text-primary uppercase">
        {{ tagline }}
      </div>
    {% endif %}

    {# SLOT: Headline - filled by field template #}
    {% if headline %}
      <div class="h-5xl font-bold mt-4">
        {{ headline }}
      </div>
    {% endif %}

    {# SLOT: Description - filled by field template #}
    {% if description %}
      <div class="p-xl mt-6 text-neutral-300">
        {{ description }}
      </div>
    {% endif %}

    {# SLOT: CTA - filled by field template #}
    {% if cta %}
      <div class="mt-8">
        {{ cta }}
      </div>
    {% endif %}
  </div>
</section>
```

### Step 3.4: Create Component Schema (Slots-First)

**⚠️ CRITICAL: Define slots for ALL content, props ONLY for configuration:**

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/11.x/core/modules/sdc/src/metadata.schema.json
name: Hero Section
description: Converted from [SOURCE_URL]
status: stable

# PROPS = Configuration ONLY
props:
  type: object
  properties:
    theme:
      type: string
      enum: [dark, light]
      default: dark
      title: Theme
      description: Color theme for the hero section
    size:
      type: string
      enum: [sm, md, lg]
      default: md
      title: Size
      description: Vertical padding size

# SLOTS = Content from Drupal fields
slots:
  tagline:
    title: Tagline
    description: Small text above headline (field_tagline)
  headline:
    title: Headline
    description: Main headline text (field_headline or title)
  description:
    title: Description
    description: Body text below headline (field_description or body)
  cta:
    title: Call to Action
    description: Button/link element (field_cta or field_link)
  media:
    title: Media
    description: Image or video (field_media or field_image)
```

### Step 3.5: Create Field Templates (MANDATORY)

**For EVERY slot, create a field template that fills it:**

```
templates/field/
├── field--node--field-tagline--[content-type].html.twig
├── field--node--field-headline--[content-type].html.twig
├── field--node--field-description--[content-type].html.twig
├── field--node--field-cta--[content-type].html.twig
└── field--node--field-media--[content-type].html.twig
```

**Example field template (`field--node--field-headline--hero.html.twig`):**

```twig
{#
/**
 * @file
 * Field template for hero headline.
 *
 * This template REMOVES all field wrappers and outputs clean content
 * for the SDC slot. The component handles all styling.
 */
#}
{% for item in items %}
  {{- item.content -}}
{% endfor %}
```

**Example for link field (`field--node--field-cta--hero.html.twig`):**

```twig
{#
/**
 * @file
 * Field template for hero CTA button.
 *
 * Renders link with component-specific classes.
 */
#}
{% for item in items %}
  <a href="{{ item.content['#url'] }}"
     class="inline-flex items-center gap-2 bg-primary text-white px-6 py-3 rounded-lg hover:bg-primary-600 transition-colors">
    {{ item.content['#title'] }}
    {% include '@adesso_cms_theme/icons/arrow-right.svg' %}
  </a>
{% endfor %}
```

**Example for media field (`field--node--field-media--hero.html.twig`):**

```twig
{#
/**
 * @file
 * Field template for hero media.
 *
 * Renders responsive image with proper image style.
 */
#}
{% for item in items %}
  {{ item.content|merge({
    '#image_style': 'hero_large',
    '#attributes': {
      'class': ['w-full', 'h-auto', 'rounded-xl']
    }
  }) }}
{% endfor %}
```

### Step 3.6: Integrate in Paragraph/Node Template

**How the component gets called with slots filled:**

```twig
{# paragraph--hero.html.twig #}
{% embed 'adesso_cms_theme:hero' with {
  theme: content.field_theme|render|trim ?: 'dark',
  size: content.field_size|render|trim ?: 'md',
} %}
  {% block tagline %}
    {{ content.field_tagline }}
  {% endblock %}

  {% block headline %}
    {{ content.field_headline }}
  {% endblock %}

  {% block description %}
    {{ content.field_description }}
  {% endblock %}

  {% block cta %}
    {{ content.field_cta }}
  {% endblock %}

  {% block media %}
    {{ content.field_media }}
  {% endblock %}
{% endembed %}
```

**Alternative using include (simpler but less explicit):**

```twig
{# paragraph--hero.html.twig #}
{% include 'adesso_cms_theme:hero' with {
  theme: content.field_theme|render|trim ?: 'dark',
  tagline: content.field_tagline,
  headline: content.field_headline,
  description: content.field_description,
  cta: content.field_cta,
  media: content.field_media,
} %}
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

**Component Structure:**
- [ ] All content uses SLOTS (not props)
- [ ] Props are ONLY used for configuration (theme, variant, size)
- [ ] Field templates exist for all slots
- [ ] Field templates remove wrapper markup

**Rendering:**
- [ ] Component renders in Drupal (not just Storybook!)
- [ ] Visual appearance matches source
- [ ] Responsive behavior works (all breakpoints)
- [ ] Interactive elements work (dropdowns, mobile menu)

**Technical:**
- [ ] No console errors
- [ ] Tailwind classes compile correctly
- [ ] No PHP errors in Drupal log
- [ ] Cache tags work (content updates reflect)

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

### Slots vs Props Quick Reference

```
┌─────────────────────────────────────────────────────────────┐
│                    SLOTS (Content)                          │
├─────────────────────────────────────────────────────────────┤
│ ✅ Text fields (title, headline, body)                      │
│ ✅ Rich text / WYSIWYG                                      │
│ ✅ Images / Media                                           │
│ ✅ Links / Buttons                                          │
│ ✅ Menu items                                               │
│ ✅ Any Drupal field content                                 │
│                                                             │
│ → Filled via field templates                                │
│ → Component just wraps with styling                         │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    PROPS (Configuration)                    │
├─────────────────────────────────────────────────────────────┤
│ ✅ theme: dark | light                                      │
│ ✅ variant: primary | secondary | outline                   │
│ ✅ size: sm | md | lg | xl                                  │
│ ✅ layout: horizontal | vertical | grid                     │
│ ✅ columns: 2 | 3 | 4                                       │
│ ✅ Boolean flags (show_icon, is_sticky, etc.)               │
│                                                             │
│ → Set in paragraph/node template                            │
│ → Often from list fields or boolean fields                  │
└─────────────────────────────────────────────────────────────┘
```

### Field Template Pattern

```twig
{# MINIMAL field template - removes all wrappers #}
{% for item in items %}
  {{- item.content -}}
{% endfor %}

{# With custom classes for links #}
{% for item in items %}
  <a href="{{ item.content['#url'] }}" class="btn btn-primary">
    {{ item.content['#title'] }}
  </a>
{% endfor %}

{# For media with image style #}
{% for item in items %}
  {{ item.content|merge({'#image_style': 'hero_large'}) }}
{% endfor %}
```
