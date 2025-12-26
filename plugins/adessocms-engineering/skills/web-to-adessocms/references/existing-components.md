# Existing adesso CMS Components

**Location:** `web/themes/custom/adesso_cms_theme/components/`

Before creating a new component, check if an existing one can be extended or modified!

## Navigation Components

| Component | Purpose | Key Props |
|-----------|---------|-----------|
| `site-header` | Main site header with logo, nav, CTA | `logo`, `menu_items[]`, `cta_url`, `theme` |
| `page-header` | Combined header + hero section | `hero_variant`, `background_image`, `title`, `buttons[]` |
| `main-menu` | Desktop navigation menu | `menu_items[]` |
| `mobile-menu` | Mobile slide-in drawer | `menu_items[]`, `cta_url` |
| `site-footer` | Site footer with links, social | `footer_links[]`, `social_links[]` |

## Editorial Components

| Component | Purpose | Key Props |
|-----------|---------|-----------|
| `hero` | Hero section variants | `variant`, `title`, `image`, `buttons[]` |
| `heading` | Typography headings | `level`, `text`, `size` |
| `text` | Rich text content | `content`, `modifier` |
| `accordion` | Collapsible content panels | `items[]`, `allow_multiple` |
| `sidebyside` | Two-column layouts | `left_content`, `right_content`, `reverse` |
| `headline-paragraph` | Title + text combo | `headline`, `paragraph`, `alignment` |

## Media Components

| Component | Purpose | Key Props |
|-----------|---------|-----------|
| `gallery` | Image galleries | `images[]`, `columns` |
| `embed` | Video/iframe embeds | `url`, `provider` |
| `media` | Generic media wrapper | `media_type`, `url` |
| `carousel` | Image carousel (Swiper) | `slides[]`, `autoplay` |
| `slider` | Content slider (Swiper) | `items[]`, `settings` |

## Card Components

| Component | Purpose | Key Props |
|-----------|---------|-----------|
| `card-group` | Grid of cards | `cards[]`, `columns`, `variant` |
| `recent-cards` | Latest content cards | `items[]`, `count` |
| `stat-card` | Statistics display | `value`, `label`, `icon` |
| `statistic` | Animated statistics | `items[]`, `animate` |
| `statistic-item` | Single stat item | `value`, `label` |

## Layout Components

| Component | Purpose | Key Props |
|-----------|---------|-----------|
| `bento-grid` | Feature showcase grid | `items[]`, `layout` |
| `image-sidebyside` | Image + content layout | `image`, `content`, `reverse` |
| `block-reference` | Dynamic block insert | `block_id` |

## General Components

| Component | Purpose | Key Props |
|-----------|---------|-----------|
| `button` | Button variants | `url`, `text`, `style`, `size` |
| `badge` | Status/label badges | `text`, `variant` |
| `logo` | Logo display | `url`, `alt` |
| `logo-collection` | Partner logo grid | `logos[]`, `title` |
| `download-item` | File download links | `file_url`, `title`, `size` |
| `pager` | Pagination controls | `current`, `total` |
| `newsletter-form` | Newsletter signup | `action_url`, `placeholder` |
| `pricing` | Pricing tables | `plans[]`, `features[]` |

## Claroty-Style Components (Custom)

| Component | Purpose | Key Props |
|-----------|---------|-----------|
| `claroty-header` | SaaS-style header with announcement bar | `announcement_text`, `menu_items[]`, `cta_url` |
| `claroty-hero` | Gradient hero with animated text | `title`, `buttons[]`, `background_words[]` |

## When to Create vs Extend

**Create a NEW component when:**
- Fundamentally different layout/structure
- New interaction pattern
- Completely different design language
- Reusable across multiple projects

**EXTEND an existing component when:**
- Adding a new variant (color, size)
- Minor layout modifications
- Adding optional features
- Client-specific customization

## Component Variants Pattern

Many components support variants via props:

```yaml
# In component.yml
variant:
  type: string
  enum: [default, primary, dark, minimal]
  default: default
```

```twig
{# In template #}
{% set variant = variant|default('default') %}
{% set variant_classes = {
  'default': 'bg-white text-neutral-900',
  'primary': 'bg-primary text-white',
  'dark': 'bg-black text-white',
  'minimal': 'bg-transparent',
} %}
<div class="{{ variant_classes[variant] }}">
```

## Storybook Categories

Components are organized in Storybook:
- **Editorial/** - Content-focused (Hero, Accordion, Text)
- **General/** - Base elements (Button, Badge, Logo)
- **Layout/** - Page structure (BentoGrid, Carousel)
- **Navigation/** - Nav components (SiteHeader, SiteFooter)

## File Structure Reference

```
component-name/
├── component-name.component.yml    # Schema (REQUIRED)
├── component-name.twig             # Template (REQUIRED)
├── component-name.stories.js       # Storybook (REQUIRED)
├── component-name.css              # Styles (optional)
├── component-name.behavior.js      # Drupal JS (optional)
└── templates/                      # Template overrides (optional)
    └── *.html.twig
```
