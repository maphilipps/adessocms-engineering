---
name: tailwindplus-sdc-builder
description: |
  Build Drupal SDC components and Paragraphs using TailwindPlus templates. This skill
  integrates the TailwindPlus MCP server to browse, select, and convert TailwindPlus
  components into production-ready Drupal SDCs with matching Paragraph configurations.
  Use when the user requests a new component like "I need a hero", "create a features section",
  or "add a pricing table". The skill follows DRY principles by checking existing components first.
---

# TailwindPlus SDC Builder

Transform TailwindPlus components into production-ready Drupal SDCs with complete Paragraph
configurations, following adesso CMS patterns and best practices.

## Core Workflow

When a user requests a component (e.g., "I need a hero section"):

### Phase 1: DRY Check - What Already Exists?

**Wichtig**: Vor dem Erstellen neuer Komponenten bestehende prüfen:

```bash
# Check existing SDC components
ls web/themes/custom/adesso_cms_theme/components/

# Check existing Paragraph types
ddev drush config:list | grep paragraphs.paragraphs_type

# Check for similar patterns in the theme
grep -r "hero\|Hero" web/themes/custom/adesso_cms_theme/components/ --include="*.component.yml"
```

**Decision Tree:**
1. **Exact match exists** → Ask user if they want to extend/modify it
2. **Similar component exists** → Suggest reusing with variants
3. **Nothing similar** → Proceed to TailwindPlus selection

### Phase 2: TailwindPlus Component Selection

Use TailwindPlus MCP tools to find matching components:

```
# Step 1: Search for components by keyword
mcp__tailwindplus__search_component_names(search_term="hero")

# Step 2: Show user the matching options with category paths
# Example output:
# - Marketing.Hero Sections.Split with image
# - Marketing.Hero Sections.Simple centered
# - Marketing.Hero Sections.With angled image

# Step 3: Get component preview for user decision
mcp__tailwindplus__get_component_preview_by_full_name(
  full_name="Marketing.Hero Sections.Split with image",
  framework="html",
  tailwind_version="4",
  mode="system"
)

# Step 4: After user selection, get the code
mcp__tailwindplus__get_component_by_full_name(
  full_name="Marketing.Hero Sections.Split with image",
  framework="html",
  tailwind_version="4",
  mode="system"
)
```

**Present options to user with AskUserQuestion:**
- Show 3-5 most relevant TailwindPlus components
- Include category path for context
- Let user pick which template to use as base

### Phase 3: Generate SDC Structure

After user selects a TailwindPlus template, generate the complete SDC:

#### File Structure
```
components/{component-name}/
├── {component-name}.component.yml    # Schema (REQUIRED)
├── {component-name}.twig             # Template (REQUIRED)
├── {component-name}.tailwind.css     # Custom styles (if needed)
└── {component-name}.behavior.js      # Alpine.js behavior (if interactive)
```

#### Component Schema Pattern
```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/HEAD/core/assets/schemas/v1/metadata.schema.json
name: Component Name
status: stable
description: Brief description of what the component does

props:
  type: object
  properties:
    # Configuration props (not from Drupal fields)
    variant:
      type: string
      title: Variant
      enum: [default, highlight, dark]
      default: default
    alignment:
      type: string
      title: Alignment
      enum: [left, center, right]
      default: left

slots:
  # Drupal fields go into slots, not props!
  title:
    title: Title
    description: Heading text (h1-h6 handled by SDC)
  content:
    title: Content
    description: Main body content
  image:
    title: Image
    description: Media field content
  cta:
    title: Call to Action
    description: Button/link area
```

#### Twig Template Pattern
```twig
{#
/**
 * @file
 * SDC: {Component Name}
 *
 * Based on TailwindPlus: {TailwindPlus Component Path}
 */
#}

{# Defaults for props #}
{% set variant = variant|default('default') %}
{% set alignment = alignment|default('left') %}

{# Build dynamic classes #}
{% set wrapper_classes = [
  'c-component-name',
  'relative',
  variant == 'dark' ? 'bg-neutral-900 text-white' : 'bg-white text-neutral-900',
] %}

<section{{ attributes.addClass(wrapper_classes) }}>
  <div class="container">
    {# Slots - render Drupal fields directly #}
    {% if title %}
      <div class="mb-4">
        {{ title }}
      </div>
    {% endif %}

    {% if content %}
      <div class="prose max-w-none">
        {{ content }}
      </div>
    {% endif %}

    {% if image %}
      <figure class="mt-8">
        {{ image }}
      </figure>
    {% endif %}

    {% if cta %}
      <div class="mt-6">
        {{ cta }}
      </div>
    {% endif %}
  </div>
</section>
```

### Phase 4: Generate Paragraph Configuration

After SDC is created, generate the matching Paragraph type configuration:

#### Paragraph Type YAML
```yaml
# paragraphs.paragraphs_type.{component_name}.yml
langcode: en
status: true
dependencies: {}
id: {component_name}
label: 'Component Name'
description: 'Description for editors'
icon_default: null
icon_uuid: null
behavior_plugins: {}
```

#### Required Field Configurations

For each slot in the SDC, determine the appropriate Drupal field:

| SDC Slot | Field Type | Suggested Config |
|----------|------------|------------------|
| `title` | `string` | Text (plain) field |
| `content` | `text_long` | Text (formatted, long) |
| `image` | `entity_reference` | Media reference (image) |
| `cta` | `link` | Link field with title |
| `items` | `entity_reference_revisions` | Paragraph reference (nested) |

Generate field storage and field config YAMLs:

```yaml
# field.storage.paragraph.field_title.yml
langcode: en
status: true
dependencies:
  module:
    - paragraphs
id: paragraph.field_title
field_name: field_title
entity_type: paragraph
type: string
settings:
  max_length: 255
  is_ascii: false
  case_sensitive: false
cardinality: 1
```

```yaml
# field.field.paragraph.{component_name}.field_title.yml
langcode: en
status: true
dependencies:
  config:
    - field.storage.paragraph.field_title
    - paragraphs.paragraphs_type.{component_name}
id: paragraph.{component_name}.field_title
field_name: field_title
entity_type: paragraph
bundle: {component_name}
label: Title
description: ''
required: false
translatable: true
default_value: []
default_value_callback: ''
settings: {}
```

### Phase 5: Generate Paragraph Template

Create the paragraph template that connects to the SDC:

```twig
{# paragraph--{component-name}.html.twig #}
{% embed 'adesso_cms_theme:{component-name}' with {
  variant: content.field_variant|render|trim|default('default'),
  alignment: content.field_alignment|render|trim|default('left'),
} only %}
  {% block title %}
    {{ content.field_title }}
  {% endblock %}
  {% block content %}
    {{ content.field_body }}
  {% endblock %}
  {% block image %}
    {{ content.field_image }}
  {% endblock %}
  {% block cta %}
    {{ content.field_link }}
  {% endblock %}
{% endembed %}
```

## Decision Guidelines

### When to Create New vs Extend Existing

| Scenario | Action |
|----------|--------|
| Exact component exists | Extend with new variant |
| Similar layout exists | Add props for differences |
| Completely new pattern | Create new SDC |
| Minor styling difference | Use Tailwind utility classes |

### Props vs Slots Decision

| Use Props | Use Slots |
|-----------|-----------|
| Variant selection | Any Drupal field content |
| Boolean toggles | Media/images |
| Size/spacing options | Text/HTML content |
| Theme selection | Nested components |

## Best Practices Reminders

### SDC Rules
- **Slots for HTML, Props for config** - Never use props for content from Drupal
- **No prop drilling** - Don't use `image_url`, `image_alt`; use `image` slot
- **Defaults required** - `{% set x = x|default('value') %}` for all props
- **`with_context = false`** - Always on includes
- **`only`** - Always on embeds

### Paragraph Rules
- **Never `.value` in templates** - Always `{{ content.field_name }}`
- **No render array destructuring** - No `content.field_image.0['#item']`
- **Complex logic in preprocess** - Not in Twig
- **Cache tags for media** - Add in preprocess function

## Reference Files

Load these for detailed patterns:
- `references/sdc-schema-patterns.md` - Complete schema examples
- `references/paragraph-field-mapping.md` - Field type recommendations
- `references/tailwindplus-component-map.md` - Common component mappings
