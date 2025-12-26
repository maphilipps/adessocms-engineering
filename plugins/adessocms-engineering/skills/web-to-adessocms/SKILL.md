---
name: web-to-adessocms
description: Convert website UI components to adesso CMS SDC components with Tailwind v4 and Alpine.js. Use when the user wants to "copy", "clone", "replicate", or "convert" a UI element from a website (navigation, hero, footer, cards, etc.) into the adesso CMS theme. Triggers include "copy the navigation from [URL]", "replicate this hero section", "convert this component", "make a component like [website]", or "kopiere von [URL]".
---

# Web to adesso CMS Component Converter

Convert website UI components into adesso CMS Single Directory Components (SDC) that work in Drupal - not just Storybook.

## Core Principle

**Drupal First**: The component MUST render correctly in Drupal. Storybook is optional documentation, not the target.

## Workflow

### Phase 1: Research & Analysis

#### Step 1.1: Check Existing Components

**CRITICAL**: Before creating a new component, check what exists:

```bash
ls web/themes/custom/adesso_cms_theme/components/
```

Key existing components:
- `site-header` - Navigation header (dark/light themes, mega menu, mobile menu)
- `hero` - Hero sections with variants
- `page-header` - Combined header + hero
- `site-footer` - Footer with menu integration
- `card-group` - Card layouts
- `accordion` - Collapsible content
- `sidebyside` - Two-column layouts

**Decision**: Extend existing OR create new? Prefer extending.

#### Step 1.2: Capture Target Component

Use webapp-testing skill (Playwright) or browser tools to:

1. Navigate to source URL
2. Screenshot at 3 breakpoints:
   - Mobile: 375px width
   - Tablet: 768px width
   - Desktop: 1280px width
3. Extract HTML structure
4. Note interactive behaviors

```python
# Example Playwright extraction
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()
    page.goto('https://example.com')
    page.wait_for_load_state('networkidle')

    # Screenshots
    for w, name in [(375, 'mobile'), (768, 'tablet'), (1280, 'desktop')]:
        page.set_viewport_size({'width': w, 'height': 800})
        page.screenshot(path=f'/tmp/{name}.png')

    # HTML extraction
    header_html = page.locator('header').inner_html()
    print(header_html)
    browser.close()
```

#### Step 1.3: Document Requirements

Create analysis:
- Layout structure (grid, flex, positioning)
- Typography (map to project classes)
- Colors (map to project palette)
- Interactive elements (dropdowns, mobile menu)
- Responsive breakpoints
- Data requirements (menu items, config, etc.)

### Phase 2: Map to Project Conventions

#### Step 2.1: Typography Classes

Use existing classes from `adesso.css`:

```twig
{# Headings - responsive sizing #}
.h-xs    {# 0.875rem uppercase #}
.h-base  {# 1rem #}
.h-lg    {# 1rem → 1.125rem #}
.h-xl    {# 1.125rem → 1.25rem #}
.h-2xl   {# 1.25rem → 1.5rem #}
.h-3xl   {# 1.5rem → 2rem #}
.h-4xl   {# 1.5rem → 2.5rem #}
.h-5xl   {# 2rem → 3rem #}
.h-6xl   {# 2.5rem → 3.75rem #}
.h-7xl   {# 3rem → 4.75rem #}

{# Paragraphs #}
.p-xs    {# 0.75rem #}
.p-sm    {# 0.875rem #}
.p-base  {# 1rem #}
.p-lg    {# 1rem → 1.125rem #}
.p-xl    {# 1.125rem → 1.25rem #}
.p-2xl   {# 1.125rem → 1.5rem #}
```

#### Step 2.2: Button Classes

```twig
.btn           {# Primary filled (lime/gold) #}
.btn-border    {# Outlined button #}
.btn-sm        {# Smaller size #}
.btn-xs        {# Extra small #}
```

#### Step 2.3: Layout Classes

```twig
.container     {# max-width: 80rem, responsive padding #}
.rich-text     {# Typography rhythm for content #}
```

#### Step 2.4: Color Variables

```css
/* Primary */
--color-primary: #bbb629;         /* Venneker lime/gold */
--color-primary-400: #d5d639;
--color-primary-600: #9a9522;

/* Neutrals (Slate-based) */
--color-neutral-50 through --color-neutral-950

/* Section accents */
--color-venneker-gruppe: #bbb629;
--color-venneker-viehhandel: #4e994e;
--color-venneker-logistik: #4d7f7f;
--color-venneker-natur: #c37570;
```

### Phase 3: Create SDC Component

#### Step 3.1: File Structure

```
components/[name]/
├── [name].component.yml  # REQUIRED: Schema
├── [name].twig           # REQUIRED: Template
├── [name].css            # OPTIONAL: Custom styles
├── [name].behavior.js    # OPTIONAL: Drupal behaviors
```

**Note**: Stories are OPTIONAL. Focus on Drupal integration first.

#### Step 3.2: Component Schema (.component.yml)

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/11.x/core/modules/sdc/src/metadata.schema.json
name: Component Name
description: Brief description
status: stable

props:
  type: object
  properties:
    # Configuration props
    theme:
      type: string
      title: Theme
      enum: [dark, light]
      default: dark

    # Content props (from Drupal)
    title:
      type: string
      title: Title

    # Complex data
    menu_items:
      type: array
      items:
        type: object
        properties:
          title:
            type: string
          url:
            type: string
          below:
            type: array

slots:
  content:
    title: Content
    description: Main content area

libraryOverrides:
  dependencies:
    - core/drupal
```

#### Step 3.3: Twig Template

```twig
{#
/**
 * @file
 * Component: [Name]
 */
#}

{# Defaults #}
{% set theme = theme|default('dark') %}
{% set is_dark = theme == 'dark' %}

{# Dynamic classes #}
{% set wrapper_classes = [
  'c-component-name',
  is_dark ? 'bg-black text-white' : 'bg-white text-neutral-900',
] %}

<div {{ attributes.addClass(wrapper_classes) }}>
  <div class="container">
    {# Use project typography #}
    {% if title %}
      <h2 class="h-3xl">{{ title }}</h2>
    {% endif %}

    {# Render slots #}
    {{ content }}
  </div>
</div>
```

#### Step 3.4: Alpine.js Interactivity

Standard patterns:

```twig
{# Toggle/Dropdown #}
<div x-data="{ open: false }">
  <button @click="open = !open">Toggle</button>
  <div x-show="open" x-cloak x-transition>Content</div>
</div>

{# Desktop hover menu #}
<div x-data="{ open: false }"
     @mouseenter="open = true"
     @mouseleave="open = false">
  <a href="#">Menu Item</a>
  <div x-show="open" x-cloak
       x-transition:enter="transition ease-out duration-200"
       x-transition:enter-start="opacity-0 -translate-y-2"
       x-transition:enter-end="opacity-100 translate-y-0">
    Dropdown content
  </div>
</div>

{# Mobile menu with backdrop #}
<div x-data="{ mobileMenuOpen: false }">
  <button @click="mobileMenuOpen = true">Open</button>

  {# Backdrop #}
  <div x-show="mobileMenuOpen"
       @click="mobileMenuOpen = false"
       class="fixed inset-0 bg-black/60 z-40">
  </div>

  {# Panel #}
  <div x-show="mobileMenuOpen"
       x-transition:enter="transition ease-out duration-300"
       x-transition:enter-start="translate-x-full"
       x-transition:enter-end="translate-x-0"
       class="fixed top-0 right-0 w-full max-w-sm bg-white z-50">
    <button @click="mobileMenuOpen = false">Close</button>
  </div>
</div>
```

### Phase 4: Drupal Integration

#### Step 4.1: Preprocess Hook (if needed)

For components needing Drupal data (menus, config, blocks):

```php
// adesso_cms_theme.theme

/**
 * Implements hook_preprocess_HOOK().
 */
function adesso_cms_theme_preprocess_[component_name](&$variables) {
  // Menu data
  $menu_tree = \Drupal::menuTree();
  $parameters = $menu_tree->getCurrentRouteMenuTreeParameters('main');
  $tree = $menu_tree->load('main', $parameters);
  $manipulators = [
    ['callable' => 'menu.default_tree_manipulators:checkAccess'],
    ['callable' => 'menu.default_tree_manipulators:generateIndexAndSort'],
  ];
  $tree = $menu_tree->transform($tree, $manipulators);
  $variables['menu_items'] = $menu_tree->build($tree)['#items'] ?? [];

  // Theme settings
  $variables['logo'] = theme_get_setting('logo.url');
  $variables['site_name'] = \Drupal::config('system.site')->get('name');
  $variables['front_page'] = Url::fromRoute('<front>')->toString();
}
```

#### Step 4.2: Template Override (for blocks/regions)

If component replaces a Drupal template, create override:

```twig
{# templates/block/block--system-menu-block--main.html.twig #}
{% include 'adesso_cms_theme:site-header' with {
  menu_items: content['#items'],
  logo: logo,
  site_name: site_name,
} %}
```

### Phase 5: Validate in Drupal

**CRITICAL: Test in actual Drupal site, not just Storybook!**

#### Step 5.1: Build Theme

```bash
ddev theme build
ddev drush cr
```

#### Step 5.2: Browser Verification

Use webapp-testing skill to verify:

```python
page.goto('https://project.ddev.site')
page.wait_for_load_state('networkidle')

# Verify component renders
assert page.locator('.c-component-name').count() > 0

# Test interactivity
page.click('button.menu-toggle')
assert page.locator('.mobile-menu').is_visible()

# Screenshot for comparison
page.screenshot(path='/tmp/drupal-result.png')
```

#### Step 5.3: Verification Checklist

- [ ] Component renders in Drupal (not 404 or broken)
- [ ] Drupal data displays (menu items, config values)
- [ ] Links work (proper Drupal URL handling)
- [ ] Images render (Drupal file paths)
- [ ] Mobile menu works
- [ ] Desktop dropdowns work
- [ ] Keyboard navigation works
- [ ] No console errors

### Phase 6: Document Result

After successful validation:

1. Take final screenshots at all breakpoints
2. Note any deviations from source design
3. Document Drupal integration requirements
4. Optional: Create Storybook story if needed for team documentation

## Quick Reference

### Commands

```bash
# Build theme CSS/JS
ddev theme build

# Clear Drupal cache
ddev drush cr

# Start Storybook (optional)
ddev theme storybook

# Check for errors
ddev drush ws
```

### File Locations

```
web/themes/custom/adesso_cms_theme/
├── components/          # SDC components
├── templates/           # Drupal template overrides
├── src/css/adesso.css   # Main stylesheet
├── adesso_cms_theme.theme  # Preprocess hooks
```

### Common Issues

1. **x-cloak elements flash** - Ensure `[x-cloak] { display: none !important; }` in CSS
2. **Menu items empty** - Check preprocess hook, verify menu exists in Drupal
3. **Styles missing** - Run `ddev theme build`, check Tailwind content scanning
4. **Links broken** - Use `{{ url }}` from Drupal, not hardcoded paths
