---
name: landing-page-optimizer
description: |
  Plan and optimize landing pages for maximum conversion rates, focusing on lead generation (contact forms, callbacks, quote requests). Use this skill when:
  (1) Creating new landing pages from scratch based on a topic or service
  (2) Analyzing and optimizing existing pages for better conversion
  (3) Planning content structure for sales-focused pages (product pages, service pages)
  (4) Building homepage or category page layouts
  (5) User asks to "optimize", "improve", "plan" or "create" a landing page
  Supports B2B and B2C contexts with automatic detection based on content.
---

# Landing Page Optimizer

Plan and build high-converting landing pages in Drupal/adesso CMS.

## Workflow

### 1. Analyze Input

Determine what you're working with:
- **Existing URL**: Fetch and analyze current structure, identify gaps
- **Topic/Service**: Research what content elements are needed
- **Competitor URL**: Extract best practices to apply

### 2. Identify Page Type & Audience

| Page Type | Primary Goal | Key Elements |
|-----------|--------------|--------------|
| Homepage | Orient & Route | Hero, Business Areas, Trust Signals, Contact |
| Service/Product | Convert | Hero+CTA, Benefits, Features, Social Proof, Form |
| Category | Navigate | Overview, Sub-categories, Key Benefits |
| Contact | Capture Lead | Multiple Contact Options, Form, Map |

**Audience Detection**:
- B2B: Longer copy, detailed benefits, trust/certifications important
- B2C: Emotional triggers, shorter copy, urgency elements

### 3. Apply AIDA Framework

Every landing page follows **AIDA** (Attention → Interest → Desire → Action):

```
┌─────────────────────────────────────────────┐
│ HERO (Attention)                            │
│ - Clear headline with value proposition     │
│ - Supporting subheadline                    │
│ - Primary CTA button                        │
│ - Hero image/video                          │
├─────────────────────────────────────────────┤
│ PROBLEM/SOLUTION (Interest)                 │
│ - Address pain points                       │
│ - Present your solution                     │
│ - Key differentiators                       │
├─────────────────────────────────────────────┤
│ BENEFITS & FEATURES (Desire)                │
│ - 3-6 benefit cards with icons              │
│ - Feature list or comparison                │
│ - Use cases / applications                  │
├─────────────────────────────────────────────┤
│ SOCIAL PROOF (Desire)                       │
│ - Testimonials / Customer quotes            │
│ - Case studies / Success stories            │
│ - Certifications / Trust badges             │
│ - Partner logos                             │
├─────────────────────────────────────────────┤
│ TEAM/CONTACT (Action)                       │
│ - Regional contacts with photo              │
│ - Interactive map (if applicable)           │
│ - Direct phone numbers                      │
├─────────────────────────────────────────────┤
│ LEAD FORM (Action)                          │
│ - Compelling headline                       │
│ - Minimal required fields                   │
│ - Clear submit button                       │
│ - Privacy checkbox                          │
├─────────────────────────────────────────────┤
│ TRUST FOOTER                                │
│ - Certifications repeat                     │
│ - Quality seals                             │
└─────────────────────────────────────────────┘
```

### 4. Content Requirements per Section

See `references/section-templates.md` for detailed templates.

**Quick Reference - Must-Have Elements**:

| Section | Required | Optional |
|---------|----------|----------|
| Hero | H1, Subline, CTA | Background image, Video |
| Benefits | 3+ items, Icons, Titles | Descriptions |
| Features | List or Cards | Comparison table |
| Social Proof | 1+ testimonial OR certifications | Case studies |
| Contact | Form OR Phone numbers | Map, Team photos |

### 5. CTA Best Practices

**Primary CTA** (above fold):
- Action verb + benefit: "Jetzt Angebot anfordern", "Kostenlos beraten lassen"
- Contrasting color
- Repeat 2-3x on page

**Secondary CTA**:
- "Mehr erfahren", "Details ansehen"
- Links to deeper content

**Form CTA**:
- Specific: "Rückruf anfordern" > "Absenden"
- Add benefit: "Unverbindlich anfragen"

### 6. Build in adesso CMS

Use available paragraph types. See `references/adesso-cms-components.md` for full details.

**Core Component Mapping**:

| Concept | adesso CMS Paragraph | Key Fields |
|---------|---------------------|------------|
| Hero | `hero` | field_heading, field_summary, field_link, field_link2, field_media |
| Benefits Grid | `card_group` + `card` | Cards with field_icon, field_heading, field_summary |
| Text + Image | `sidebyside` | field_heading, field_summary, field_media, field_link |
| Statistics | `statistic` + `statistic_item` | field_stat_value, field_stat_label |
| Team/Contacts | `contact_directory` + `contact_item` | field_title, field_icon, field_link (tel:) |
| Lead Form | `embed` (with Webform) | field_embed_code with webform |
| Trust Badges | `logo_collection` | field_logos, field_link |
| FAQ | `accordion` + `accordion_item` | field_heading (Q), field_body (A) |
| Downloads | `download` + `download_item` | File attachments |

**Known Gaps** (use workarounds from reference):
- ❌ No dedicated `testimonial` → Use `sidebyside` with quote styling
- ❌ No `cta_banner` → Use `hero` minimal or `sidebyside` accent theme
- ❌ No `process_steps` → Use `card_group` with numbered icons

**Implementation Order**:
1. Create/update node with basic fields (title, meta)
2. Add `hero` paragraph first (above fold)
3. Add content paragraphs in AIDA order
4. Configure each paragraph with content
5. Set proper headings hierarchy (H1 in hero only → H2 → H3)
6. Add internal links and CTAs (field_link, field_link2)
7. Preview with Playwright and test form submission

### 7. Conversion Checklist

Before finalizing, verify:

- [ ] **Above the fold**: H1 + Value prop + CTA visible without scrolling
- [ ] **Single focus**: One primary conversion goal per page
- [ ] **F-pattern**: Important content on left side
- [ ] **Mobile-first**: Forms work on mobile, buttons thumb-friendly
- [ ] **Load speed**: Optimized images, no blocking resources
- [ ] **Trust signals**: At least 2 trust elements (certs, testimonials, numbers)
- [ ] **Clear next step**: Every section leads to action
- [ ] **Contact visible**: Phone/form accessible from anywhere

## Output Format

When planning a landing page, output:

```markdown
## Landing Page Plan: [Page Title]

**Page Type**: [Homepage/Service/Product/Category]
**Target Audience**: [B2B/B2C/Both]
**Primary Conversion Goal**: [e.g., Contact form submission]

### Proposed Structure

1. **Hero Section**
   - Headline: "[Proposed H1]"
   - Subline: "[Supporting text]"
   - CTA: "[Button text]" → [Link target]

2. **[Section Name]**
   - Content: [Description]
   - Drupal component: [paragraph type]

[... continue for all sections ...]

### Content to Create/Gather
- [ ] [List of images needed]
- [ ] [Text content to write]
- [ ] [Data to collect]

### Implementation Steps
1. [Step-by-step Drupal actions]
```

## References

- `references/adesso-cms-components.md` - **adesso CMS paragraph types, fields, and gap analysis**
- `references/section-templates.md` - Detailed templates for each section type
- `references/conversion-patterns.md` - Proven conversion patterns and examples (AIDA, PAS, statistics)
