# Component Schema Patterns

JSON Schema patterns for SDC props and slots definitions.

## Schema Basics

Every component.yml must include the schema reference:

```yaml
"$schema": "https://git.drupalcode.org/project/drupal/-/raw/10.1.x/core/modules/sdc/src/metadata.schema.json"
```

## Props Type Patterns

### String Props

```yaml
props:
  properties:
    variant:
      type: string
      title: Style Variant
      description: "Visual style of the component"
      enum:
        - primary
        - secondary
        - ghost
        - destructive
      default: primary
      examples:
        - primary
      meta:enum:
        primary: "Primary - Main action"
        secondary: "Secondary - Supporting action"
        ghost: "Ghost - Minimal styling"
        destructive: "Destructive - Dangerous action"
```

### Enum with UI Labels

Use `meta:enum` to provide human-readable labels for Canvas/UI:

```yaml
size:
  type: string
  title: Size
  enum: [sm, md, lg, xl]
  default: md
  meta:enum:
    sm: "Small (32px)"
    md: "Medium (40px)"
    lg: "Large (48px)"
    xl: "Extra Large (56px)"
```

### Boolean Props

```yaml
props:
  properties:
    disabled:
      type: boolean
      title: Disabled
      description: "Prevents interaction when true"
      default: false

    full_width:
      type: boolean
      title: Full Width
      description: "Expands to fill container width"
      default: false
```

### Number Props

```yaml
props:
  properties:
    columns:
      type: integer
      title: Columns
      description: "Number of grid columns"
      minimum: 1
      maximum: 12
      default: 3

    aspect_ratio:
      type: number
      title: Aspect Ratio
      description: "Width to height ratio (e.g., 1.5 for 3:2)"
      minimum: 0.5
      maximum: 3
      default: 1.777
```

### String with Pattern Validation

```yaml
props:
  properties:
    color:
      type: string
      title: Custom Color
      description: "CSS color value"
      pattern: "^(#[0-9a-fA-F]{6}|rgb\\(|oklch\\().*"
      examples:
        - "#3b82f6"

    icon:
      type: string
      title: Icon Name
      description: "Heroicons icon name"
      pattern: "^[a-z-]+$"
      examples:
        - "arrow-right"
        - "chevron-down"
```

### Object Props (Nested)

```yaml
props:
  properties:
    author:
      type: object
      title: Author
      properties:
        name:
          type: string
          title: Name
        avatar:
          type: string
          title: Avatar URL
        role:
          type: string
          title: Role
      required:
        - name
```

### Array Props

```yaml
props:
  properties:
    tags:
      type: array
      title: Tags
      items:
        type: string
      minItems: 0
      maxItems: 10
      examples:
        - ["Design", "Development", "UX"]

    links:
      type: array
      title: Navigation Links
      items:
        type: object
        properties:
          label:
            type: string
          url:
            type: string
          active:
            type: boolean
        required:
          - label
          - url
```

## Media Props

### Image with Canvas Reference

```yaml
props:
  properties:
    image:
      $ref: json-schema-definitions://canvas.module/image
      title: Image
      type: object
      examples:
        - src: "assets/example.jpg"
          width: 1200
          height: 800
          alt: "Example image description"
```

### Video Reference

```yaml
props:
  properties:
    video:
      $ref: json-schema-definitions://canvas.module/video
      title: Video
      type: object
```

### Manual Image Schema (without Canvas)

```yaml
props:
  properties:
    image:
      type: object
      title: Image
      properties:
        src:
          type: string
          title: Source URL
        alt:
          type: string
          title: Alt Text
        width:
          type: integer
          title: Width
        height:
          type: integer
          title: Height
      required:
        - src
        - alt
```

## Slots Patterns

### Basic Slots

```yaml
slots:
  default:
    title: Content
    description: "Main content area"

  header:
    title: Header
    description: "Optional header content displayed above main content"

  footer:
    title: Footer
    description: "Optional footer content displayed below main content"
```

### Action Slots

```yaml
slots:
  actions:
    title: Actions
    description: "Action buttons or links"

  leading:
    title: Leading Content
    description: "Content before the main text (icon, avatar)"

  trailing:
    title: Trailing Content
    description: "Content after the main text (badge, arrow)"
```

### Media Slots

```yaml
slots:
  media:
    title: Media
    description: "Image, video, or other media content"

  thumbnail:
    title: Thumbnail
    description: "Small preview image"
```

## Required vs Optional Props

### Marking Required Props

```yaml
props:
  type: object
  required:
    - variant
    - label
  properties:
    variant:
      type: string
      title: Variant
      enum: [primary, secondary]

    label:
      type: string
      title: Label

    icon:
      type: string
      title: Icon
      # Not in required array = optional
```

## Conditional Props (oneOf/anyOf)

### Mutually Exclusive Options

```yaml
props:
  properties:
    link:
      oneOf:
        - type: string
          title: URL
          format: uri
        - type: object
          title: Route
          properties:
            name:
              type: string
            params:
              type: object
```

### Multiple Valid Formats

```yaml
props:
  properties:
    date:
      anyOf:
        - type: string
          format: date
          title: Date String
        - type: integer
          title: Unix Timestamp
```

## Default Values and Examples

### Comprehensive Examples

```yaml
props:
  properties:
    variant:
      type: string
      enum: [primary, secondary, ghost]
      default: primary
      examples:
        - primary
        - secondary

    label:
      type: string
      default: "Click me"
      examples:
        - "Submit"
        - "Learn More"
        - "Get Started"
```

## Complete Component Schema Example

```yaml
"$schema": "https://git.drupalcode.org/project/drupal/-/raw/10.1.x/core/modules/sdc/src/metadata.schema.json"
name: Card
group: Card
status: stable
description: "Versatile card component for displaying grouped content with optional media, actions, and various style variants."

props:
  type: object
  required:
    - variant
  properties:
    variant:
      type: string
      title: Style Variant
      enum:
        - elevated
        - outlined
        - filled
      default: elevated
      meta:enum:
        elevated: "Elevated - Floating with shadow"
        outlined: "Outlined - Border only"
        filled: "Filled - Solid background"

    orientation:
      type: string
      title: Orientation
      enum:
        - vertical
        - horizontal
      default: vertical
      meta:enum:
        vertical: "Vertical - Stacked layout"
        horizontal: "Horizontal - Side by side"

    interactive:
      type: boolean
      title: Interactive
      description: "Makes entire card clickable"
      default: false

    url:
      type: string
      title: Link URL
      description: "Destination when card is clicked (requires interactive: true)"
      format: uri

    image:
      $ref: json-schema-definitions://canvas.module/image
      title: Image
      type: object
      examples:
        - src: "assets/card-example.jpg"
          width: 800
          height: 600
          alt: "Card image"

    padding:
      type: string
      title: Content Padding
      enum: [none, sm, md, lg]
      default: md

slots:
  default:
    title: Content
    description: "Main card content"

  header:
    title: Header
    description: "Optional header above content"

  footer:
    title: Footer
    description: "Optional footer for actions"

  media:
    title: Media Slot
    description: "Custom media content (overrides image prop)"

libraryOverrides:
  css:
    component:
      card.tailwind.css: {}
```

## Schema Validation Tips

1. **Always include $schema** for IDE support
2. **Use title and description** for documentation
3. **Provide examples** for complex types
4. **Use meta:enum** for UI-friendly labels
5. **Set sensible defaults** for optional props
6. **Mark truly required props** explicitly
7. **Use format hints** (uri, date, email) where applicable
8. **Include assets/** examples for media props
