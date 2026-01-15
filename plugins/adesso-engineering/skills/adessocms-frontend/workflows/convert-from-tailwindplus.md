# Convert TailwindPlus Template to SDC

## Required Reading
Before starting, load:
- `../references/sdc-structure.md` - Target structure
- `../references/slots-vs-props.md` - Mapping template to slots/props
- `../references/cva-patterns.md` - Variant conversion

---

## Input Gathering

Ask user:
1. **What type of component?** (hero, features, pricing, etc.)
2. **Preferred style?** (Browse TailwindPlus together)
3. **Required variants?** (dark/light, sizes, layouts)
4. **Drupal integration?** (Paragraph type, fields needed)

---

## Process

### Step 1: Search TailwindPlus

```
mcp__plugin_adessocms-engineering_tailwindplus__search_component_names(search_term="<type>")
```

Or list all:
```
mcp__plugin_adessocms-engineering_tailwindplus__list_component_names()
```

### Step 2: Preview Options

Get preview for promising components:

```
mcp__plugin_adessocms-engineering_tailwindplus__get_component_preview_by_full_name(
  full_name="<full.dotted.path>",
  framework="html",
  tailwind_version="4",
  mode="system"
)
```

**Mode guide:**
- Application UI / Marketing → `light`, `dark`, or `system`
- eCommerce → `none`

### Step 3: Get Component Code

Once user selects:

```
mcp__plugin_adessocms-engineering_tailwindplus__get_component_by_full_name(
  full_name="<full.dotted.path>",
  framework="html",
  tailwind_version="4",
  mode="system"
)
```

### Step 4: Analyze for SDC Conversion

From the TailwindPlus HTML, identify:

**Content Elements → SLOTS:**
- Headlines, paragraphs → `heading`, `content`
- Images → `image`, `media`
- Lists → `items` (compound slot)
- CTAs → `cta`, `actions`

**Variation Points → PROPS:**
- Color schemes → `theme: 'light' | 'dark'`
- Layout options → `layout: 'centered' | 'split'`
- Size variations → `size: 'sm' | 'md' | 'lg'`

### Step 5: Create CVA Definition

Convert inline Tailwind variations to CVA:

```twig
{% set section = html_cva(
  base: ['py-24', 'sm:py-32'],
  variants: {
    theme: {
      light: 'bg-white text-gray-900',
      dark: 'bg-gray-900 text-white'
    },
    layout: {
      centered: 'text-center mx-auto max-w-2xl',
      split: 'grid lg:grid-cols-2 gap-16'
    }
  }
) %}
```

### Step 6: Build SDC Files

Follow standard structure:

```
components/<name>/
├── <name>.component.yml
├── <name>.twig
└── <name>.tailwind.css (if needed)
```

### Step 7: Create Paragraph Type (Optional)

If this component needs a Drupal Paragraph:

```bash
# List existing paragraph types for reference
ddev drush config:get paragraphs.paragraphs_type.<similar> --format=yaml
```

Create via Drupal UI or config:
1. Machine name matching component
2. Fields for each slot
3. Display configuration

### Step 8: Create Field Templates

For each field that feeds a slot:

```twig
{# field--paragraph--field-heading--<paragraph>.html.twig #}
{% for item in items %}
  {{ item.content }}
{% endfor %}
```

### Step 9: Build and Verify

```bash
ddev theme build && ddev drush cr
```

Visual verification at multiple breakpoints:
- Desktop (1280px)
- Tablet (768px)
- Mobile (375px)

---

## TailwindPlus MCP Reference

| Task | Tool |
|------|------|
| Search components | `search_component_names` |
| List all | `list_component_names` |
| Get code | `get_component_by_full_name` |
| Get preview | `get_component_preview_by_full_name` |
| Server info | `list_tailwindplus_information` |

---

## Anti-Patterns

❌ **NEVER** use React/Vue code - always request `framework="html"`
❌ **NEVER** forget to specify `tailwind_version="4"` for new projects
❌ **NEVER** hardcode TailwindPlus sample content - map to slots
❌ **NEVER** copy icons inline - use Drupal icon system or SVG sprites

---

## Success Criteria

- [ ] Component matches TailwindPlus preview
- [ ] All content mapped to slots
- [ ] CVA handles all variants
- [ ] Responsive behavior verified
- [ ] Paragraph integration works (if applicable)
