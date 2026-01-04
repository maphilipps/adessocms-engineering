# Paragraph Field Mapping Guide

How to map SDC slots to Drupal Paragraph fields.

## Field Type Reference

| SDC Slot Purpose | Drupal Field Type | Module | Notes |
|------------------|-------------------|--------|-------|
| Plain text | `string` | core | Max 255 chars, no formatting |
| Short formatted | `string_long` | core | Longer text, still single line |
| Rich text | `text_long` | text | Formatted with CKEditor |
| Summary + body | `text_with_summary` | text | For teasers |
| Single image | `entity_reference` | media | Reference to Media entity |
| Multiple images | `entity_reference` | media | Cardinality > 1 |
| Link/button | `link` | link | URL + title |
| Nested items | `entity_reference_revisions` | paragraphs | Child paragraphs |
| View reference | `viewsreference` | viewsreference | Embed a View |
| Block reference | `block_field` | block_field | Embed a Block |
| Boolean toggle | `boolean` | core | On/off settings |
| Select/dropdown | `list_string` | options | Predefined choices |
| Number | `integer` or `decimal` | core | Numeric values |

## Common Field Configurations

### Title Field (string)

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
translatable: true
```

### Body/Content Field (text_long)

```yaml
# field.storage.paragraph.field_body.yml
langcode: en
status: true
dependencies:
  module:
    - paragraphs
    - text
id: paragraph.field_body
field_name: field_body
entity_type: paragraph
type: text_long
settings: {}
cardinality: 1
translatable: true
```

### Image Field (media reference)

```yaml
# field.storage.paragraph.field_image.yml
langcode: en
status: true
dependencies:
  module:
    - media
    - paragraphs
id: paragraph.field_image
field_name: field_image
entity_type: paragraph
type: entity_reference
settings:
  target_type: media
cardinality: 1
translatable: true
```

```yaml
# field.field.paragraph.hero.field_image.yml
langcode: en
status: true
dependencies:
  config:
    - field.storage.paragraph.field_image
    - media.type.image
    - paragraphs.paragraphs_type.hero
  module:
    - media
id: paragraph.hero.field_image
field_name: field_image
entity_type: paragraph
bundle: hero
label: Image
required: false
translatable: true
settings:
  handler: 'default:media'
  handler_settings:
    target_bundles:
      image: image
    sort:
      field: _none
      direction: ASC
    auto_create: false
```

### Link Field

```yaml
# field.storage.paragraph.field_link.yml
langcode: en
status: true
dependencies:
  module:
    - paragraphs
    - link
id: paragraph.field_link
field_name: field_link
entity_type: paragraph
type: link
settings: {}
cardinality: 1
translatable: true
```

```yaml
# field.field.paragraph.cta.field_link.yml
langcode: en
status: true
dependencies:
  config:
    - field.storage.paragraph.field_link
    - paragraphs.paragraphs_type.cta
  module:
    - link
id: paragraph.cta.field_link
field_name: field_link
entity_type: paragraph
bundle: cta
label: Link
required: true
translatable: true
settings:
  link_type: 17  # Internal + External
  title: 1       # Required
```

### Nested Paragraphs (items)

```yaml
# field.storage.paragraph.field_items.yml
langcode: en
status: true
dependencies:
  module:
    - entity_reference_revisions
    - paragraphs
id: paragraph.field_items
field_name: field_items
entity_type: paragraph
type: entity_reference_revisions
settings:
  target_type: paragraph
cardinality: -1  # Unlimited
translatable: true
```

```yaml
# field.field.paragraph.accordion.field_items.yml
langcode: en
status: true
dependencies:
  config:
    - field.storage.paragraph.field_items
    - paragraphs.paragraphs_type.accordion
    - paragraphs.paragraphs_type.accordion_item
  module:
    - entity_reference_revisions
id: paragraph.accordion.field_items
field_name: field_items
entity_type: paragraph
bundle: accordion
label: Items
required: false
translatable: true
settings:
  handler: 'default:paragraph'
  handler_settings:
    negate: 0
    target_bundles:
      accordion_item: accordion_item
    target_bundles_drag_drop:
      accordion_item:
        enabled: true
        weight: 0
```

### Variant/Select Field

```yaml
# field.storage.paragraph.field_variant.yml
langcode: en
status: true
dependencies:
  module:
    - options
    - paragraphs
id: paragraph.field_variant
field_name: field_variant
entity_type: paragraph
type: list_string
settings:
  allowed_values:
    - { value: default, label: Default }
    - { value: highlight, label: Highlight }
    - { value: dark, label: Dark }
cardinality: 1
translatable: false
```

## Slot-to-Field Mapping Examples

### Hero Section

| SDC Slot | Paragraph Field | Field Type |
|----------|-----------------|------------|
| `eyebrow` | `field_eyebrow` | string |
| `title` | `field_title` | string |
| `subtitle` | `field_subtitle` | string |
| `content` | `field_body` | text_long |
| `image` | `field_image` | entity_reference (media) |
| `cta_primary` | `field_link` | link |
| `cta_secondary` | `field_link_secondary` | link |

### Card Group

| SDC Slot | Paragraph Field | Field Type |
|----------|-----------------|------------|
| `header` | `field_title`, `field_body` | string, text_long |
| `items` | `field_items` | entity_reference_revisions |
| `footer` | `field_link` | link |

### Accordion

| SDC Slot | Paragraph Field | Field Type |
|----------|-----------------|------------|
| `items` | `field_items` | entity_reference_revisions |

### Accordion Item (nested)

| SDC Slot | Paragraph Field | Field Type |
|----------|-----------------|------------|
| `title` | `field_title` | string |
| `content` | `field_body` | text_long |

## Form Display Configuration

```yaml
# core.entity_form_display.paragraph.hero.default.yml
langcode: en
status: true
dependencies:
  config:
    - field.field.paragraph.hero.field_body
    - field.field.paragraph.hero.field_image
    - field.field.paragraph.hero.field_link
    - field.field.paragraph.hero.field_title
    - field.field.paragraph.hero.field_variant
    - paragraphs.paragraphs_type.hero
  module:
    - link
    - media_library
    - text
id: paragraph.hero.default
targetEntityType: paragraph
bundle: hero
mode: default
content:
  field_title:
    type: string_textfield
    weight: 0
    region: content
    settings:
      size: 60
      placeholder: ''
    third_party_settings: {}
  field_body:
    type: text_textarea
    weight: 1
    region: content
    settings:
      rows: 5
      placeholder: ''
    third_party_settings: {}
  field_image:
    type: media_library_widget
    weight: 2
    region: content
    settings:
      media_types:
        - image
    third_party_settings: {}
  field_link:
    type: link_default
    weight: 3
    region: content
    settings:
      placeholder_url: ''
      placeholder_title: ''
    third_party_settings: {}
  field_variant:
    type: options_select
    weight: 4
    region: content
    settings: {}
    third_party_settings: {}
hidden: {}
```

## View Display Configuration

```yaml
# core.entity_view_display.paragraph.hero.default.yml
langcode: en
status: true
dependencies:
  config:
    - field.field.paragraph.hero.field_body
    - field.field.paragraph.hero.field_image
    - field.field.paragraph.hero.field_link
    - field.field.paragraph.hero.field_title
    - field.field.paragraph.hero.field_variant
    - paragraphs.paragraphs_type.hero
  module:
    - link
    - text
id: paragraph.hero.default
targetEntityType: paragraph
bundle: hero
mode: default
content:
  field_title:
    type: string
    weight: 0
    region: content
    label: hidden
    settings:
      link_to_entity: false
    third_party_settings: {}
  field_body:
    type: text_default
    weight: 1
    region: content
    label: hidden
    settings: {}
    third_party_settings: {}
  field_image:
    type: entity_reference_entity_view
    weight: 2
    region: content
    label: hidden
    settings:
      view_mode: default
      link: false
    third_party_settings: {}
  field_link:
    type: link
    weight: 3
    region: content
    label: hidden
    settings:
      trim_length: null
      url_only: false
      url_plain: false
      rel: ''
      target: ''
    third_party_settings: {}
hidden:
  field_variant: true
```
