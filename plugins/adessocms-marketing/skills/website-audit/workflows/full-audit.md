# Full Website Audit Workflow

Complete 11-phase audit for Drupal relaunch projects.

## Phase 1: Discovery & Initial Analysis

### 1.1 Setup Browser Session
```
1. mcp__claude-in-chrome__tabs_context_mcp (createIfEmpty: true)
2. mcp__claude-in-chrome__tabs_create_mcp
3. mcp__claude-in-chrome__navigate (url: <website_url>)
```

### 1.2 Take Initial Screenshots
```
mcp__claude-in-chrome__computer (action: "screenshot")
```
Save to: `audit_data/screenshots/homepage.png`

### 1.3 Analyze Technology Stack
Use WebSearch to identify CMS:
```
WebSearch: "site:<domain> CMS detection"
WebSearch: "<domain> builtwith technology"
```

Check page source for CMS indicators:
```
mcp__claude-in-chrome__read_page
```

Look for: WordPress (`wp-content`), Drupal (`sites/default`), Typo3 (`typo3conf`), Magnolia (`.html` URLs, JSESSIONID)

### 1.4 Assess Content Volume
```
mcp__claude-in-chrome__navigate (url: "<domain>/sitemap.xml")
mcp__claude-in-chrome__get_page_text
```

Count URLs by pattern, categorize by type.

## Phase 2: Content Architecture Analysis

### 2.1 Identify Page Types
Sample diverse pages, document for each:
- Title/heading structure
- Body content type
- Images (hero, gallery, inline)
- Metadata (author, date, categories)
- Custom fields
- Related content sections

**Map to Drupal Content Types**

### 2.2 Inventory Content Components
Identify reusable components:
- Text blocks, images, galleries
- Videos, quotes, CTAs
- Accordions, tabs, carousels
- Cards, grids, hero sections

**Map to Drupal Paragraph Types**

### 2.3 Document Taxonomies
- Categories (hierarchical/flat)
- Tags
- Locations
- Topics

**Map to Drupal Vocabularies**

### 2.4 Analyze Media Usage
- Image formats and sizes
- Documents (PDF, DOC)
- Videos (embedded/uploaded)

**Map to Drupal Media Types**

## Phase 3: Functionality & Features Analysis

### 3.1 Interactive Features
Test and document:
- Forms (contact, registration, search)
- User features (login, profiles)
- Social integrations
- Maps, payments, APIs

### 3.2 Navigation Structure
- Main navigation (levels, mega menu)
- Footer navigation
- Breadcrumbs

### 3.3 Views & Listings
Document all listing pages:
- Layout style (grid, list, table)
- Filters and facets
- Pagination
- Sorting options

**Map to Drupal Views**

## Phase 4: Performance Analysis

### 4.1 Core Web Vitals
Note: Claude in Chrome doesn't have performance traces.
Use WebFetch to check PageSpeed Insights:
```
WebFetch: "https://pagespeed.web.dev/analysis?url=<encoded_url>"
```

Or document manual check needed.

### 4.2 Asset Optimization
Check for:
- Image optimization (WebP, lazy loading)
- CSS/JS minification
- CDN usage
- Caching headers

## Phase 5: Accessibility Analysis

### 5.1 WCAG 2.1 Audit
```
mcp__a11y-accessibility__test_accessibility (url: <website_url>, tags: ["wcag2aa"])
```

### 5.2 Color Contrast Check
For key color combinations:
```
mcp__a11y-accessibility__check_color_contrast (foreground: "#xxx", background: "#xxx")
```

### 5.3 Categorize Issues
- Critical (blocks access)
- Serious (major barrier)
- Moderate (significant barrier)
- Minor (inconvenience)

## Phase 6: Integration & System Landscape

### 6.1 Identify External Systems
- SSO/Authentication
- CRM, Marketing automation
- Analytics
- Search engines
- CDN, Video platforms
- APIs

### 6.2 Document Integration Requirements
For each integration:
- Purpose
- Technical implementation
- Data flow
- Migration complexity

## Phase 7: Migration Analysis

### 7.1 Assess Export Capabilities
Best → Worst:
1. Structured export (XML, JSON, CSV)
2. Database access
3. API with pagination
4. Web scraping (last resort)

### 7.2 Content Cleanup Requirements
- HTML cleanup
- Image path corrections
- Broken link fixing
- Content deduplication

### 7.3 Calculate Migration Effort
Use references/estimation-traditional.md formulas.

## Phase 8: Technology Comparison

### 8.1 CMS Comparison Matrix
Generate using references/cms-comparison.md

### 8.2 AI Opportunities
Identify potential for:
- Content creation
- Auto-tagging
- Search enhancement
- Chatbots

## Phase 9: Drupal Architecture Design

### 9.1 Design Content Types
For each page type:
- Machine name
- Fields with types
- Paragraph field
- View modes

### 9.2 Design Paragraph Types
For each component:
- Machine name
- Fields
- Nesting rules
- Theme component mapping

### 9.3 Design Views
For each listing:
- Display types
- Filters
- Sorting
- Caching

## Phase 10: Dual Estimation

Launch estimation agents in PARALLEL:

```
Task: traditional-estimator
Task: ai-estimator
```

Wait for both, then:
```
Task: estimation-synthesizer
```

## Phase 11: Documentation Generation

### 11.1 Compile Audit Data
Create `audit_data/audit_report.json` with all findings.

### 11.2 Generate VitePress Site
```bash
python scripts/generate_vitepress_site.py audit_data audit-docs --with-theme
```

### 11.3 Final Deliverables
- [ ] VitePress documentation site
- [ ] Estimation comparison report
- [ ] Screenshots directory
- [ ] Audit report JSON
