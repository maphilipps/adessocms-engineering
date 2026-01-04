# SDC Schema Patterns

Complete examples for different component types.

## Basic Component with Variants

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/HEAD/core/assets/schemas/v1/metadata.schema.json
name: Button
status: stable
description: A versatile button component with multiple variants

props:
  type: object
  properties:
    variant:
      type: string
      title: Variant
      description: Visual style of the button
      enum: [primary, secondary, ghost, outline]
      default: primary
    size:
      type: string
      title: Size
      enum: [sm, md, lg]
      default: md
    disabled:
      type: boolean
      title: Disabled
      default: false
    full_width:
      type: boolean
      title: Full Width
      default: false

slots:
  content:
    title: Button Content
    description: Text or icon content for the button
```

## Hero Section with Multiple Slots

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/HEAD/core/assets/schemas/v1/metadata.schema.json
name: Hero Section
status: stable
description: A hero section with title, content, image, and CTA

props:
  type: object
  properties:
    variant:
      type: string
      title: Layout Variant
      enum: [centered, split-left, split-right, overlay]
      default: centered
    theme:
      type: string
      title: Color Theme
      enum: [light, dark]
      default: light
    min_height:
      type: string
      title: Minimum Height
      enum: [auto, half, full]
      default: auto

slots:
  eyebrow:
    title: Eyebrow
    description: Small text above the title
  title:
    title: Title
    description: Main heading (use heading component inside)
  subtitle:
    title: Subtitle
    description: Secondary heading or description
  content:
    title: Content
    description: Main body content
  image:
    title: Image
    description: Hero image or media
  cta_primary:
    title: Primary CTA
    description: Main call-to-action button/link
  cta_secondary:
    title: Secondary CTA
    description: Secondary action button/link
```

## Card Component with Nested Children

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/HEAD/core/assets/schemas/v1/metadata.schema.json
name: Card
status: stable
description: A flexible card component for various content types

props:
  type: object
  properties:
    variant:
      type: string
      title: Card Variant
      enum: [default, horizontal, featured, compact]
      default: default
    clickable:
      type: boolean
      title: Entire Card Clickable
      default: false
    aspect_ratio:
      type: string
      title: Image Aspect Ratio
      enum: ['16/9', '4/3', '1/1', 'auto']
      default: '16/9'

slots:
  media:
    title: Media
    description: Card image or video
  header:
    title: Header
    description: Card header area (badges, categories)
  title:
    title: Title
    description: Card title
  content:
    title: Content
    description: Card body content
  footer:
    title: Footer
    description: Card footer (actions, meta info)
```

## List/Collection Component with Items

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/HEAD/core/assets/schemas/v1/metadata.schema.json
name: Card Group
status: stable
description: A grid of cards with configurable columns

props:
  type: object
  properties:
    columns:
      type: integer
      title: Number of Columns
      minimum: 1
      maximum: 6
      default: 3
    gap:
      type: string
      title: Gap Size
      enum: [sm, md, lg, xl]
      default: md
    equal_height:
      type: boolean
      title: Equal Height Cards
      default: true

slots:
  header:
    title: Section Header
    description: Title and description above the cards
  items:
    title: Cards
    description: Card components (use paragraph reference field)
  footer:
    title: Section Footer
    description: CTA or additional content below cards
```

## Form Component

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/HEAD/core/assets/schemas/v1/metadata.schema.json
name: Newsletter Form
status: stable
description: Email newsletter signup form

props:
  type: object
  properties:
    variant:
      type: string
      title: Layout Variant
      enum: [inline, stacked]
      default: inline
    show_privacy:
      type: boolean
      title: Show Privacy Checkbox
      default: true
    button_text:
      type: string
      title: Submit Button Text
      default: Subscribe

slots:
  title:
    title: Form Title
    description: Heading above the form
  description:
    title: Description
    description: Explanatory text
  form:
    title: Form Content
    description: Drupal form render array
  success_message:
    title: Success Message
    description: Message shown after successful submission
```

## Interactive Component (with Alpine.js)

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/HEAD/core/assets/schemas/v1/metadata.schema.json
name: Accordion
status: stable
description: Collapsible accordion with multiple items

props:
  type: object
  properties:
    allow_multiple:
      type: boolean
      title: Allow Multiple Open
      description: Allow multiple items to be open simultaneously
      default: false
    default_open:
      type: integer
      title: Default Open Item
      description: Index of initially open item (0 = first, -1 = none)
      default: 0

slots:
  items:
    title: Accordion Items
    description: Nested accordion_item paragraphs

libraryOverrides:
  dependencies:
    - core/drupal
```

## Nested Item Component

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/HEAD/core/assets/schemas/v1/metadata.schema.json
name: Accordion Item
status: stable
description: Single accordion item (child of accordion)

props:
  type: object
  properties:
    icon:
      type: string
      title: Icon Name
      description: Optional icon before title

slots:
  title:
    title: Item Title
    description: Clickable header text
  content:
    title: Item Content
    description: Expandable content area
```

## Media Component

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/HEAD/core/assets/schemas/v1/metadata.schema.json
name: Media
status: stable
description: Responsive media wrapper for images and videos

props:
  type: object
  properties:
    aspect_ratio:
      type: string
      title: Aspect Ratio
      enum: ['auto', '1/1', '4/3', '16/9', '21/9']
      default: auto
    loading:
      type: string
      title: Loading Strategy
      enum: [eager, lazy]
      default: lazy
    object_fit:
      type: string
      title: Object Fit
      enum: [cover, contain, fill, none]
      default: cover

slots:
  media:
    title: Media Content
    description: Image or video from Drupal media field
  caption:
    title: Caption
    description: Optional caption below media
```
