# 1xINTERNET Paragraph Types - Complete Field Reference

Demo: https://41043c2cd16280e.qaack.1xinter.net (trydrupal/trydrupal)

## Standard Fields (All Paragraphs)

Every paragraph type has these configuration fields:

| Field | Type | Options |
|-------|------|---------|
| **Theme** | Select | Default, Light, Dark |
| **Top Spacing** | Select | None, Small, Large |
| **Bottom Spacing** | Select | None, Small, Large |
| **Width** | Select | Full screen, Wide width, Content width, Text width |
| **Columns** | Select | 1, 2, 3, 4 (where applicable) |

---

## 1. Accordion

**Purpose**: FAQ-style collapsible content sections

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Enable search | Checkbox | No | Adds search box to filter accordion items |
| Accordion Items | Nested paragraphs | Yes | Collection of Accordion Item paragraphs |

### Accordion Item (Nested)
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Title | Text | Yes | Clickable header text |
| Content | Rich text | Yes | Expanded content (supports AI generation, Add Image) |

### Frontend Component
```html
<qz-accordion search="true|false" singleExpand="true|false">
  <article>
    <h3 data-part="invoker">
      <button>Title <qz-icon name="plus" opener></qz-icon><qz-icon name="minus" closer></qz-icon></button>
    </h3>
    <div data-part="content">Content</div>
  </article>
</qz-accordion>
```

---

## 2. Anchor

**Purpose**: Navigation anchor points for in-page linking

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Title | Text | Yes | Display title |
| Anchor | Text | Yes | Anchor ID (URL hash) |

### Frontend Output
```html
<a id="anchor-id" name="anchor-id"></a>
```

---

## 3. Block Reference

**Purpose**: Embed Drupal blocks in content

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Block | Select dropdown | Yes | Available blocks |

### Available Blocks
- AI Chatbot
- Events (listing)
- News (listing)
- Search
- Webform
- Newsletter signup
- Social Media

---

## 4. Custom Entity Reference

**Purpose**: Reference custom entity types

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Entity | Select dropdown | Yes | Entity type to embed |

### Available Entity Types
- Quote
- Teaser Text with Image

---

## 5. Dynamic List

**Purpose**: Auto-generated content listings

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Content Type | Select | Yes | News, Events, etc. |
| Display Mode | Select | Yes | Teaser, Card, List |
| Limit | Number | No | Max items to display |
| Sort | Select | No | Date, Title, etc. |

---

## 6. Facts (Statistics)

**Purpose**: Animated number counters with descriptions

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Fact Items | Nested paragraphs | Yes | Collection of Fact Item paragraphs |

### Fact Item (Nested)
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Number | Number | Yes | The main statistic value |
| Decimals | Number | No | Decimal places to show |
| Radix point | Text | No | Decimal separator character |
| Prefix | Text | No | Text before number (e.g., "$") |
| Suffix | Text | No | Text after number (e.g., "%", "+") |
| Image | Media | No | Optional icon/image |
| Title | Rich text | Yes | Fact label (AI supported) |
| Description | Rich text | No | Additional description |
| Link | Link | No | Optional CTA link |
| Small | Checkbox | No | Use compact display |
| Background | Checkbox | No | Show background styling |

### Frontend Component
```html
<qz-fact prefix="$" suffix="M" number="150" decimals="1">
  <img slot="icon" src="..." />
  <span slot="title">Revenue</span>
  <span slot="description">Annual growth</span>
</qz-fact>
```

---

## 7. File

**Purpose**: File download links

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Media | Media reference | Yes | File media entity |

---

## 8. Gallery

**Purpose**: Image gallery/grid

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Media | Media reference (multiple) | Yes | Image media entities |

---

## 9. Grid

**Purpose**: Container for nested paragraph grid layouts

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Sections | Nested paragraphs | Yes | Any paragraph types |

**Note**: This is a container paragraph that enables grid layouts of other paragraphs.

---

## 10. Headline

**Purpose**: Standalone headline/heading

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Text | Text | Yes | Heading text |
| Level | Select | No | H1, H2, H3, H4, H5, H6 |
| Alignment | Select | No | Left, Center, Right |

---

## 11. Iframe

**Purpose**: External embed via iframe

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| URL | URL | Yes | Embed URL |
| Height | Number | No | Frame height in pixels |
| Width | Number | No | Frame width (or "100%") |

---

## 12. Image

**Purpose**: Single image display

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Media | Media reference | Yes | Image media entity |
| Caption | Text | No | Image caption |
| Link | Link | No | Make image clickable |

---

## 13. Image Text (Side-by-Side)

**Purpose**: Image alongside text content

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Media | Media reference | Yes | Image media entity |
| Text | Rich text | Yes | Content (AI supported) |
| Media Align | Select | No | Left, Right |
| Caption | Text | No | Image caption |

### Frontend Component
```html
<qz-media-text media-align="left|right" has-caption="true|false">
  <article slot="media"><img src="..." /></article>
  <div slot="caption">Caption</div>
  <h3>Heading</h3>
  <p>Text content</p>
</qz-media-text>
```

---

## 14. Link Preview

**Purpose**: Rich link card (auto-fetched metadata)

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| URL | URL | Yes | Link to preview |

---

## 15. Page Reference

**Purpose**: Link to internal page

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Page | Entity reference | Yes | Page node reference |

---

## 16. Remote Video

**Purpose**: YouTube/Vimeo embeds

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Video URL | URL | Yes | YouTube or Vimeo URL |

---

## 17. Slideshow

**Purpose**: Image/content carousel

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Slides | Nested paragraphs | Yes | Slide item paragraphs |
| Autoplay | Checkbox | No | Auto-advance slides |
| Navigation | Checkbox | No | Show prev/next buttons |

### Frontend Component
```html
<qz-slider autoplay="true" navigation="true">
  <qz-slide>Content 1</qz-slide>
  <qz-slide>Content 2</qz-slide>
</qz-slider>
```

---

## 18. Social Media

**Purpose**: Social media embed

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Platform | Select | No | Twitter, Facebook, Instagram, etc. |
| Embed Code | Textarea | Yes | Platform embed code |

---

## 19. Tabs

**Purpose**: Tabbed content sections

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Tab Items | Nested paragraphs | Yes | Collection of Tab Item paragraphs |

### Tab Item (Nested)
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Title | Text | Yes | Tab label |
| Content | Rich text | Yes | Tab panel content |

### Frontend Component
```html
<qz-tabs>
  <qz-tab label="Tab 1">Content 1</qz-tab>
  <qz-tab label="Tab 2">Content 2</qz-tab>
</qz-tabs>
```

---

## 20. Text

**Purpose**: Rich text content block

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Text | Rich text | Yes | WYSIWYG content (AI supported) |

---

## 21. Two Columns

**Purpose**: Side-by-side content layout

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Left Content | Rich text | Yes | Left column content |
| Right Content | Rich text | Yes | Right column content |

### Frontend Component
```html
<qz-two-column>
  <div slot="left">Left content</div>
  <div slot="right">Right content</div>
</qz-two-column>
```

---

## 22. Video

**Purpose**: Local video embed

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Media | Media reference | Yes | Video media entity |

---

## 23. Video Text

**Purpose**: Video alongside text content

### Fields
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Media | Media reference | Yes | Video media entity |
| Text | Rich text | Yes | Content (AI supported) |
| Media Align | Select | No | Left, Right |

---

## Section Wrapper Pattern

All paragraphs render within a section wrapper:

```html
<section class="section"
         data-spacing="top-[spacing] bottom-[spacing]"
         data-width="[width]"
         data-theme="[theme]">
  <div class="section-inner">
    <!-- Paragraph content -->
  </div>
</section>
```

### data-spacing Values
| Backend Value | data-spacing Attribute |
|---------------|------------------------|
| None | (no attribute) |
| Small (top) | "top-small" |
| Large (top) | "top-large" |
| Small (bottom) | "bottom-small" |
| Large (bottom) | "bottom-large" |
| Both Small | "top-small bottom-small" |
| Both Large | "top-large bottom-large" |

### data-width Values
| Backend Value | data-width Attribute |
|---------------|---------------------|
| Full screen | "full" |
| Wide width | "wide" |
| Content width | "default" |
| Text width | "narrow" |

### data-theme Values
| Backend Value | data-theme Attribute |
|---------------|---------------------|
| Default | (no attribute) |
| Light | "light" |
| Dark | "dark" |

---

## AI Features in Paragraphs

The following paragraph types support AI-assisted content:

| Paragraph | AI Feature | Location |
|-----------|------------|----------|
| Accordion Item | Text generation | Content field |
| Facts Item | Text generation | Title field |
| Image Text | Text generation | Text field |
| Text | Text generation | Text field |
| Video Text | Text generation | Text field |

AI features appear as:
- "Generate with AI" button in rich text fields
- Auto-generated alt text for images (separate feature)
