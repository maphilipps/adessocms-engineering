# adesso CMS Components for Landing Pages

Reference for available paragraph types and their fields in adesso CMS.

## Table of Contents
1. [Component Mapping](#component-mapping)
2. [Available Paragraphs](#available-paragraphs)
3. [Gap Analysis](#gap-analysis)
4. [Workarounds](#workarounds)

---

## Component Mapping

Map landing page concepts to adesso CMS paragraphs:

| Landing Page Concept | adesso CMS Paragraph | Notes |
|---------------------|---------------------|-------|
| Hero Section | `hero` | Full-featured with 2 CTAs |
| Benefits Grid | `card_group` + `card` | Use icon + title + text |
| Features List | `bullet` or `card_group` | Bullet for simple, cards for rich |
| Text + Image | `sidebyside` or `image_sidebyside` | Alternating layouts |
| Statistics/Numbers | `statistic` + `statistic_item` | For trust-building numbers |
| Testimonials | `sidebyside` with quote styling | No dedicated testimonial type* |
| Team/Contacts | `contact_directory` + `contact_item` | Department + phone grid |
| Trust Badges | `logo_collection` | For certifications, partner logos |
| FAQ | `accordion` + `accordion_item` | Collapsible Q&A |
| Lead Form | `embed` with Webform | Embed webform via block or iframe |
| Newsletter | `newsletter` | Built-in newsletter signup |
| Downloads | `download` + `download_item` | File downloads section |
| Video/Media | `media` or `embed` | Media for local, embed for external |
| Image Gallery | `gallery` | Lightbox gallery |
| Slider/Carousel | `slider` + `slider_item` | Full-width slides |
| Pricing Tables | `pricing` + `pricing_card` | Price comparison |
| Views Integration | `views` | For dynamic content lists |

---

## Available Paragraphs

### Hero
**Purpose**: Above-the-fold attention grabber with CTA

**Fields**:
| Field | Type | Purpose |
|-------|------|---------|
| field_hero_layout | Select | Layout variant |
| field_pre_headline | Text | Small text above H1 |
| field_heading | Text | Main H1 headline |
| field_sub_headline | Text | Below H1 (often hidden) |
| field_summary | Textarea | Supporting copy |
| field_link | Link | Primary CTA button |
| field_link2 | Link | Secondary CTA |
| field_media | Media | Background image/video |
| field_content_element_theme | Boolean | Theme toggle |

**Best Practice**: Always fill heading + summary + field_link minimum.

---

### Card Group + Card
**Purpose**: Grid of benefit/feature cards

**Card Group Fields**:
- field_card (Reference to card items)
- field_columns (Grid columns)
- field_content_element_theme

**Card Fields**:
- field_heading (Card title)
- field_summary (Card description)
- field_icon (Icon)
- field_link (Optional CTA)
- field_media (Optional image)

**Best Practice**: Use 3, 4, or 6 cards for clean grids. Always include icons.

---

### Sidebyside / Image Sidebyside
**Purpose**: Text + Image sections

**Fields**:
- field_heading
- field_summary / field_body
- field_media
- field_link
- field_layout (Image left/right)
- field_content_element_theme

**Best Practice**: Alternate image position for visual rhythm.

---

### Statistic
**Purpose**: Trust-building numbers/KPIs

**Statistic Item Fields**:
- field_stat_value (Number/text)
- field_stat_label (Description)
- field_icon (Optional)

**Best Practice**: Use 3-4 items. Include units (%, +, Jahre).

---

### Logo Collection
**Purpose**: Partner logos, certifications

**Fields**:
- field_heading
- field_logos (Multiple media)
- field_link (Optional link per logo)

**Best Practice**: Use for certifications section. Link to certificate PDFs.

---

### Contact Directory
**Purpose**: Department/team contact grid

**Contact Item Fields**:
- field_title (Department name)
- field_icon (Phone/department icon)
- field_link (tel: link)

**Best Practice**: Group by function (Disposition, Einkauf, Buchhaltung).

---

### Accordion
**Purpose**: FAQ sections, expandable content

**Accordion Item Fields**:
- field_heading (Question)
- field_body (Answer)

**Best Practice**: Use for FAQ. Keep answers concise.

---

### Embed
**Purpose**: External content (forms, videos, maps)

**Fields**:
- field_embed_code (HTML/iframe)
- field_heading (Optional title)

**Best Practice**: Use for Webform embeds, YouTube videos, maps.

---

### Newsletter
**Purpose**: Email signup

**Fields**:
- field_heading
- field_summary
- Newsletter form integration

**Best Practice**: Place before footer or after main content.

---

## Gap Analysis

### Missing Components for Optimal Landing Pages

| Component | Status | Workaround |
|-----------|--------|------------|
| **Testimonial/Quote** | ❌ Missing | Use `sidebyside` with quote styling, or `card` with customer photo |
| **CTA Banner** | ❌ Missing | Use `hero` with minimal content, or `sidebyside` with strong CTA |
| **Process Steps** | ❌ Missing | Use `card_group` with numbered icons (1, 2, 3) |
| **Comparison Table** | ❌ Missing | Use `text` with HTML table, or `pricing` for price comparison |
| **Video Hero** | ✅ Partial | `hero` supports video via field_media |
| **Team Grid with Photos** | ❌ Limited | `contact_directory` lacks photos; use `card_group` with person cards |
| **Trust Badges with Descriptions** | ✅ Partial | `logo_collection` for logos; add descriptions via `text` above |
| **Sticky CTA** | ❌ Missing | Requires theme/frontend implementation |
| **Social Proof Counter** | ❌ Missing | Use `statistic` for numbers |

### Recommended New Paragraphs

If developing new components, prioritize:

1. **Testimonial** (HIGH) - Customer quote with photo, name, company
2. **CTA Banner** (MEDIUM) - Full-width call-to-action section
3. **Process Steps** (MEDIUM) - Numbered step visualization
4. **Team Member** (LOW) - Person card with photo, role, contact

---

## Workarounds

### Creating Testimonials Without Dedicated Component

**Option A: Use Sidebyside**
```
Paragraph: sidebyside
- field_media: Customer photo
- field_heading: "Das sagen unsere Kunden"
- field_summary: "Quote text here..."
- Add customer name/company in summary
```

**Option B: Use Card Group**
```
Paragraph: card_group (1-2 columns)
- Card 1:
  - field_media: Customer photo
  - field_heading: Customer name
  - field_summary: Quote + Company
```

### Creating Process Steps

```
Paragraph: card_group (3-4 columns)
- Card 1: Icon="1" or step icon, Title="Kontakt aufnehmen"
- Card 2: Icon="2", Title="Beratungsgespräch"
- Card 3: Icon="3", Title="Partnerschaft starten"
```

### Creating CTA Banner

```
Paragraph: sidebyside (full-width theme)
- field_heading: "Bereit für den nächsten Schritt?"
- field_summary: Brief compelling text
- field_link: Primary CTA
- field_media: Subtle background or icon
- field_content_element_theme: dark/accent
```

### Lead Form Integration

```
Paragraph: embed
- field_heading: "Jetzt unverbindlich anfragen"
- field_embed_code: Webform block embed or iframe
```

Or use `block_reference` to embed a Webform block directly.
