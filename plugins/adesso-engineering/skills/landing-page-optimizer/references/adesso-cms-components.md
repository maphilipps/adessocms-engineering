# adesso CMS Components for Landing Pages

Reference for available paragraph types and their fields in adesso CMS.

**Last Updated**: Based on Venneker project paragraphs (January 2026)

## Table of Contents
1. [Component Mapping](#component-mapping)
2. [Core Paragraphs](#core-paragraphs)
3. [Testimonials & Social Proof](#testimonials--social-proof)
4. [Features & Process](#features--process)
5. [Team & Contact](#team--contact)
6. [Layout & Structure](#layout--structure)
7. [Media & Content](#media--content)
8. [Gap Analysis](#gap-analysis)

---

## Component Mapping

Map landing page concepts to adesso CMS paragraphs:

| Landing Page Concept | adesso CMS Paragraph | Notes |
|---------------------|---------------------|-------|
| **Hero Section** | `hero` | Full-featured with 2 CTAs, Eyebrow text |
| **Benefits Grid** | `card_group` + `card` | Use icon + title + text |
| **Features Grid** | `feature_grid` + `feature_item` | Dedicated feature display |
| **Feature Showcase** | `feature_showcase` + `feature_showcase_item` | Rich feature presentation |
| **Process Steps** | `process_steps` + `process_step` | ✅ Dedicated component! |
| **Text + Image** | `sidebyside` or `image_sidebyside` | Alternating layouts |
| **Statistics/Numbers** | `statistic` + `statistic_item` | Trust-building numbers |
| **Testimonials** | `testimonial` or `testimonial_grid` | ✅ Dedicated component! |
| **Testimonial Quotes** | `testimonial_side_by_side` | Quote with image |
| **CTA Banner** | `cta_banner` | ✅ Dedicated component! |
| **Team/Contacts** | `contact_directory` + `contact_item` | Department + phone grid |
| **Team Showcase** | `team_showcase` or `team_by_division` | Team with photos |
| **Trust Badges** | `logo_collection` | Partner logos |
| **Certifications** | `certificate_grid` + `certificate_item` | ✅ Dedicated component! |
| **FAQ** | `accordion` + `accordion_item` | Collapsible Q&A |
| **Lead Form** | `embed` or `block_reference` | Webform integration |
| **Newsletter** | `newsletter` | Built-in newsletter signup |
| **Downloads** | `download` + `download_item` | File downloads section |
| **Video/Media** | `media` or `embed` | Media for local, embed for external |
| **Image Gallery** | `gallery` | Lightbox gallery |
| **Slider/Carousel** | `slider` + `slider_item` or `carousel` | Full-width slides |
| **Pricing Tables** | `pricing` + `pricing_card` | Price comparison |
| **Bento Grid** | `bento_grid` + `bento_grid_item` | Modern asymmetric grid |
| **Division Showcase** | `division_showcase` + `division_item` | Business areas |
| **Service Highlights** | `service_highlights` + `service_highlight_item` | Service overview |
| **Dual Content** | `dual_content` | Two-column content |
| **Roadmap** | `roadmap` | Timeline/roadmap display |
| **Location Showcase** | `location_showcase` | Standorte |
| **Views Integration** | `views` | Dynamic content lists |

---

## Core Paragraphs

### Hero
**Purpose**: Above-the-fold attention grabber with CTA

**Fields**:
| Field | Type | Purpose |
|-------|------|---------|
| field_hero_layout | Select | Layout variant (fullscreen, conversion, studio) |
| field_pre_headline | Text | Eyebrow text above H1 (NEW: for target audience) |
| field_heading | Text | Main H1 headline (3 outcomes) |
| field_sub_headline | Text | Below H1 |
| field_summary | Textarea | Supporting copy + CTA Subtext |
| field_link | Link | Primary CTA button |
| field_link2 | Link | Secondary CTA |
| field_media | Media | Background image/video |
| field_content_element_theme | Boolean | Theme toggle |

**Best Practice**:
- Use `field_pre_headline` for Eyebrow text ("Für Landwirte in NRW")
- Include CTA Subtext in `field_summary` ("Unverbindlich anfragen")
- Always fill heading + summary + field_link minimum

---

### CTA Banner ✅
**Purpose**: Full-width call-to-action section

**Fields**:
- field_heading (Strong headline)
- field_summary (Benefit-focused subtext)
- field_link (Primary CTA)
- field_background (Background style)
- field_buttons (Multiple CTAs)

**Best Practice**:
- Use for Final CTA section before footer
- Include trust boosters in summary
- High contrast button styling

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

### Accordion
**Purpose**: FAQ sections, expandable content

**Accordion Item Fields**:
- field_heading (Question)
- field_body (Answer - use bullets, bold key terms)

**Best Practice**:
- Use for FAQ with conversion links in answers
- Keep answers concise and skimmable
- Add "Book a call" links within answers

---

## Testimonials & Social Proof

### Testimonial ✅
**Purpose**: Customer quote with attribution

**Fields**:
- field_quote (The testimonial text)
- field_author_name (Customer name)
- field_author_title (Role/Title)
- field_author_company (Company name)
- field_media (Customer photo)
- field_date (Date for freshness)

**Best Practice**:
- Include photo, name, title, company
- Add recent dates (fresh testimonials feel more honest)
- Bold key results in quotes

---

### Testimonial Grid ✅
**Purpose**: Multiple testimonials in grid layout

**Fields**:
- field_testimonials (Reference to testimonial items)
- field_heading (Stage-setting headline)
- field_columns (Grid layout)

**Best Practice**:
- Use headline like "Loved by 500+ Landwirte" not "Testimonials"
- Show 3 testimonials for balance
- End with CTA button

---

### Testimonial Side by Side ✅
**Purpose**: Large quote with image

**Fields**:
- field_quote
- field_media (Large customer photo)
- field_author_name
- field_author_title

**Best Practice**: Use for featured/hero testimonial.

---

### Certificate Grid ✅
**Purpose**: Certifications with descriptions

**Certificate Item Fields**:
- field_media (Certificate logo)
- field_heading (Certificate name)
- field_summary (What it certifies)
- field_link (Link to certificate PDF)

**Best Practice**: Show 3-6 certifications. Include brief descriptions.

---

### Logo Collection
**Purpose**: Partner logos, client logos

**Fields**:
- field_heading
- field_logos (Multiple media)
- field_link (Optional link per logo)

**Best Practice**: Use in hero for trust bar, or separate section.

---

## Features & Process

### Feature Grid ✅
**Purpose**: Grid of features with icons

**Feature Item Fields**:
- field_icon
- field_heading (Feature title)
- field_summary (Feature description)

**Best Practice**: Use 3-6 features. Keep titles scannable.

---

### Feature Showcase ✅
**Purpose**: Rich feature presentation with media

**Feature Showcase Item Fields**:
- field_media (Feature image/video)
- field_heading
- field_summary
- field_link

**Best Practice**: Alternate image positions for visual rhythm.

---

### Process Steps ✅
**Purpose**: Numbered step visualization (How It Works)

**Process Step Fields**:
- field_step_number (1, 2, 3...)
- field_heading (Step title)
- field_summary (Step description)
- field_icon (Optional icon)

**Best Practice**:
- Use 3-5 steps maximum
- Clear, action-oriented titles
- "Kontakt aufnehmen" → "Beratung" → "Partnerschaft"

---

### Service Highlights ✅
**Purpose**: Service overview section

**Service Highlight Item Fields**:
- field_media
- field_heading
- field_summary
- field_link

**Best Practice**: Use for category/overview pages.

---

## Team & Contact

### Contact Directory
**Purpose**: Department/team contact grid

**Contact Item Fields**:
- field_title (Department name)
- field_icon (Phone/department icon)
- field_link (tel: link)

**Best Practice**: Group by function (Disposition, Einkauf, Buchhaltung).

---

### Contact Section ✅
**Purpose**: Full contact section with form

**Fields**:
- field_heading
- field_summary
- field_contacts (Reference to contact items)
- Webform integration

---

### Team Showcase ✅
**Purpose**: Team grid with photos

**Fields**:
- field_heading
- field_team_members (Reference to person nodes or items)

**Best Practice**: Show photos, names, roles, contact info.

---

### Team by Division ✅
**Purpose**: Team filtered by department/division

**Fields**:
- field_filter_division (Taxonomy reference)
- field_heading
- field_background

**Best Practice**: Use on service pages to show relevant team.

---

## Layout & Structure

### Bento Grid ✅
**Purpose**: Modern asymmetric grid layout

**Bento Grid Item Fields**:
- field_media
- field_heading
- field_summary
- field_link
- field_size (Grid span)

**Best Practice**: Use for visual variety, homepage sections.

---

### Division Showcase ✅
**Purpose**: Business areas/divisions display

**Division Item Fields**:
- field_media
- field_heading
- field_summary
- field_link

**Best Practice**: Use on homepage to route to service pages.

---

### Dual Content ✅
**Purpose**: Two-column content layout

**Fields**:
- field_left_title, field_left_text
- field_right_title, field_right_text
- field_buttons

**Best Practice**: Use for comparison or side-by-side info.

---

### Roadmap ✅
**Purpose**: Timeline/roadmap display

**Fields**:
- field_left_paragraphs
- field_right_paragraphs
- field_show_roadline

**Best Practice**: Use for history, project timelines.

---

### Location Showcase ✅
**Purpose**: Display locations/branches

**Fields**:
- field_headline
- field_subline
- Location references

**Best Practice**: Use with map integration.

---

## Media & Content

### Media
**Purpose**: Single media display (image/video)

**Fields**:
- field_media
- field_heading (Optional caption)

---

### Embed
**Purpose**: External content (forms, videos, maps)

**Fields**:
- field_embed_code (HTML/iframe)
- field_heading (Optional title)

**Best Practice**: Use for Webform embeds, YouTube videos, maps.

---

### Gallery
**Purpose**: Image gallery with lightbox

**Fields**:
- field_media (Multiple images)
- field_heading

---

### Slider / Carousel
**Purpose**: Full-width slides

**Slider Item Fields**:
- field_media
- field_heading
- field_summary
- field_link

---

### Download
**Purpose**: File downloads section

**Download Item Fields**:
- field_file
- field_heading
- field_summary

---

### Newsletter
**Purpose**: Email signup

**Fields**:
- field_heading
- field_summary
- Newsletter form integration

**Best Practice**: Place before footer or after main content.

---

### Pricing
**Purpose**: Price comparison tables

**Pricing Card Fields**:
- field_heading (Plan name)
- field_price
- field_features (Bullet list)
- field_link (CTA)
- field_highlighted (Most Popular flag)

**Best Practice**:
- Use "Most Popular" label on recommended plan
- Add "Who it's for" description
- Include "Cancel anytime" subtext

---

### Text
**Purpose**: Rich text content

**Fields**:
- field_body (Formatted text)

---

### Bullet
**Purpose**: Bullet point lists

**Fields**:
- field_items (List items)

---

### Button
**Purpose**: Standalone CTA button

**Fields**:
- field_link
- field_button_style (primary, secondary, outline)

---

### Block Reference
**Purpose**: Embed Drupal blocks

**Fields**:
- field_block (Block reference)

**Best Practice**: Use for Webform blocks, custom blocks.

---

### Views
**Purpose**: Dynamic content lists

**Fields**:
- field_view (View reference)

**Best Practice**: Use for news, team, job listings.

---

## Gap Analysis

### Component Status (Updated)

| Component | Status | Notes |
|-----------|--------|-------|
| **Hero** | ✅ Full | Supports Eyebrow, 2 CTAs, video |
| **Testimonial/Quote** | ✅ Full | Dedicated `testimonial`, `testimonial_grid`, `testimonial_side_by_side` |
| **CTA Banner** | ✅ Full | Dedicated `cta_banner` |
| **Process Steps** | ✅ Full | Dedicated `process_steps` + `process_step` |
| **Certificate Grid** | ✅ Full | Dedicated `certificate_grid` |
| **Team with Photos** | ✅ Full | `team_showcase`, `team_by_division` |
| **Feature Grid** | ✅ Full | Dedicated `feature_grid` |
| **Pricing** | ✅ Full | With "Most Popular" support |
| **FAQ** | ✅ Full | `accordion` |
| **Bento Grid** | ✅ Full | Modern layouts |
| **Comparison Table** | ⚠️ Partial | Use `text` with HTML table |
| **Sticky CTA** | ❌ Missing | Requires theme implementation |
| **Countdown Timer** | ❌ Missing | For urgency (low priority) |

### All Available Paragraphs (55 total)

**Core Content:**
- `accordion` + `accordion_item`
- `bullet`
- `button`
- `text`
- `embed`
- `media`
- `gallery`
- `newsletter`
- `download` + `download_item`
- `block_reference`
- `views`

**Hero & CTA:**
- `hero` (with variants)
- `cta_banner`

**Cards & Grids:**
- `card_group` + `card`
- `bento_grid` + `bento_grid_item`
- `feature_grid` + `feature_item`
- `certificate_grid` + `certificate_item`

**Features & Process:**
- `feature_showcase` + `feature_showcase_item`
- `process_steps` + `process_step`
- `service_highlights` + `service_highlight_item`
- `benefit_item`

**Testimonials & Social Proof:**
- `testimonial`
- `testimonial_grid`
- `testimonial_side_by_side`
- `logo_collection`
- `statistic` + `statistic_item` + `stats_item`

**Team & Contact:**
- `contact_directory` + `contact_item`
- `contact_section`
- `team_showcase`
- `team_by_division`
- `department_assignment`

**Layout:**
- `sidebyside`
- `image_sidebyside`
- `dual_content`
- `roadmap`
- `division_showcase` + `division_item`
- `location_showcase`

**Sliders & Carousels:**
- `slider` + `slider_item`
- `carousel` + `carousel_item`

**Pricing:**
- `pricing` + `pricing_card`
