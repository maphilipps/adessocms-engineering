# TailwindPlus Component Mapping

Common mappings from TailwindPlus categories to Drupal SDC/Paragraph patterns.

## Hero Sections

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Marketing.Hero Sections.Simple centered | `hero` | `hero` | title, content, cta |
| Marketing.Hero Sections.Split with image | `hero-split` | `hero` | title, content, image, cta |
| Marketing.Hero Sections.With angled image | `hero-angled` | `hero` | title, content, image, cta |
| Marketing.Hero Sections.With app screenshot | `hero-screenshot` | `hero` | title, content, image, cta |
| Marketing.Hero Sections.With background image | `hero-background` | `hero` | title, content, background_image, cta |

### Recommended Hero SDC Structure

```yaml
# One flexible hero component with variants
props:
  variant: [centered, split-left, split-right, overlay, background]
  theme: [light, dark]

slots:
  eyebrow, title, subtitle, content, image, cta_primary, cta_secondary
```

## Feature Sections

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Marketing.Feature Sections.Simple | `feature-grid` | `features` | title, items |
| Marketing.Feature Sections.With product screenshot | `feature-showcase` | `features` | title, content, image, items |
| Marketing.Feature Sections.Alternating | `feature-alternating` | `sidebyside` | items (sidebyside paragraphs) |
| Marketing.Feature Sections.With large screenshot | `feature-screenshot` | `features` | title, image, items |

### Feature Item Pattern

```yaml
# Parent: features
slots:
  header: title, description
  items: entity_reference_revisions → feature_item

# Child: feature_item
slots:
  icon, title, content
```

## Pricing Sections

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Marketing.Pricing.Three tiers | `pricing` | `pricing` | title, items |
| Marketing.Pricing.With comparison | `pricing-comparison` | `pricing` | title, items, features_list |
| Marketing.Pricing.Single with details | `pricing-single` | `pricing_card` | title, price, features, cta |

### Pricing Structure

```yaml
# Parent: pricing
slots:
  header: title, content
  items: entity_reference_revisions → pricing_card

# Child: pricing_card
props:
  featured: boolean (highlight this tier)
slots:
  title, price, period, features, cta
```

## Testimonial Sections

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Marketing.Testimonials.Simple centered | `testimonial` | `testimonial` | quote, author, role, image |
| Marketing.Testimonials.Side by side | `testimonial-grid` | `testimonials` | items |
| Marketing.Testimonials.With large avatar | `testimonial-avatar` | `testimonial` | quote, author, role, avatar |

## Stats Sections

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Marketing.Stats.Simple on brand | `stats` | `statistic` | items |
| Marketing.Stats.Split with image | `stats-image` | `statistic` | title, image, items |
| Marketing.Stats.Transparent | `stats-transparent` | `statistic` | items |

### Stats Structure

```yaml
# Parent: statistic
slots:
  header: title
  items: entity_reference_revisions → statistic_item

# Child: statistic_item
slots:
  value, label, description
```

## CTA Sections

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Marketing.CTA Sections.Simple centered | `cta` | `cta_banner` | title, content, cta_primary, cta_secondary |
| Marketing.CTA Sections.Split with image | `cta-split` | `cta_banner` | title, content, image, cta |
| Marketing.CTA Sections.Simple stacked | `cta-stacked` | `cta_banner` | title, content, cta |

## Card Sections

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Application UI.Lists.Grid lists | `card-group` | `card_group` | items |
| eCommerce.Product Lists.With inline price | `product-grid` | `card_group` | items |
| Marketing.Blog Sections.Three column | `blog-grid` | `card_group` | items |

### Card Structure

```yaml
# Parent: card_group
props:
  columns: [2, 3, 4]
  gap: [sm, md, lg]
slots:
  header: title, content
  items: entity_reference_revisions → card

# Child: card
slots:
  media, header, title, content, footer
```

## Logo Sections

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Marketing.Logo Clouds.Simple | `logo-collection` | `logo_collection` | title, items |
| Marketing.Logo Clouds.With company name | `logo-grid` | `logo_collection` | items |

## FAQ Sections

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Marketing.FAQs.Two columns | `accordion` | `accordion` | title, items |
| Marketing.FAQs.Centered | `faq-centered` | `accordion` | title, items |
| Marketing.FAQs.Side by side | `faq-split` | `accordion` | title, content, items |

## Contact Sections

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Marketing.Contact Sections.Split with image | `contact-split` | `contact_form` | title, content, image, form |
| Marketing.Contact Sections.Centered | `contact-centered` | `contact_form` | title, content, form |
| Marketing.Contact Sections.With contact details | `contact-details` | `contact_directory` | title, items |

## Navigation Components

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Application UI.Navigation.Navbars | `site-header` | N/A (block) | logo, menu, cta |
| Marketing.Headers.Simple | `page-header` | `hero` | title, breadcrumb |

## Footer Components

| TailwindPlus Component | SDC Name | Paragraph Type | Key Slots |
|------------------------|----------|----------------|-----------|
| Marketing.Footers.Simple centered | `site-footer` | N/A (block) | logo, menu, social, copyright |
| Marketing.Footers.4-column | `site-footer` | N/A (block) | columns, social, copyright |

## Mapping Decision Flow

```
1. User requests component (e.g., "I need a features section")
   ↓
2. Search TailwindPlus: mcp__tailwindplus__search_component_names("feature")
   ↓
3. Check existing SDCs in project
   ↓
4. Decision:
   - Existing matches? → Extend with variant
   - Similar exists? → Add prop options
   - New pattern? → Create from TailwindPlus template
   ↓
5. Generate:
   - SDC component (component.yml, .twig)
   - Paragraph type (if content-editable)
   - Field configs (storage + field instance)
   - Paragraph template (connecting to SDC)
```

## TailwindPlus MCP Usage Examples

### Search for Components

```
# Find hero-related components
mcp__tailwindplus__search_component_names(search_term="hero")

# Find all marketing components
mcp__tailwindplus__list_component_names()
# Then filter by "Marketing.*"
```

### Get Component Code

```
# Get HTML code for Tailwind v4 with system theme
mcp__tailwindplus__get_component_by_full_name(
  full_name="Marketing.Hero Sections.Split with image",
  framework="html",
  tailwind_version="4",
  mode="system"
)
```

### Preview Before Deciding

```
# Get preview HTML to show user
mcp__tailwindplus__get_component_preview_by_full_name(
  full_name="Marketing.Feature Sections.Simple",
  framework="html",
  tailwind_version="4",
  mode="light"
)
```
