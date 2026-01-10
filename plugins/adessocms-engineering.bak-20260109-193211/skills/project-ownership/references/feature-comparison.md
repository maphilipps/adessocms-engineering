# Feature Comparison: adesso CMS vs 1xInternet Quartz

## Component Parity Matrix

### Legend
- ✅ Exists in adesso CMS
- ❌ Missing - needs implementation
- 🔄 Partial - exists but needs enhancement
- ➡️ Similar - different name/approach

---

## Atoms

| Quartz | adesso CMS | Status | Notes |
|--------|------------|--------|-------|
| Backdrop | - | ❌ | Overlay background for modals |
| Badge | badge | ✅ | |
| Button | button | ✅ | |
| Divider | - | ❌ | Visual separator line |
| Drawer | - | ❌ | Slide-out panel |
| HeadingGroup | heading | 🔄 | Enhance with subheading |
| Icon | - | ❌ | Standalone icon component |
| Lazy | - | ❌ | Lazy loading wrapper |
| Link | - | ❌ | Styled link component |
| Overlay | - | ❌ | Modal overlay |
| Panel | - | ❌ | Content container |
| Section | - | ❌ | Page section wrapper |
| Spinner | - | ❌ | Loading indicator |
| Tooltip | - | ❌ | Hover tooltip |
| Two Column | sidebyside | ✅ | |

## Molecules

| Quartz | adesso CMS | Status | Notes |
|--------|------------|--------|-------|
| Accordion | accordion | ✅ | |
| Card | card-group | 🔄 | Card exists in group |
| Cookie Consent | - | ❌ | GDPR banner (Klaro exists) |
| Dropdown | - | ❌ | Dropdown menu |
| Fact | stat-card | ➡️ | Similar concept |
| Infographic | - | ❌ | Data visualization |
| LoadMore | - | ❌ | "Load more" pagination |
| Media | media | ✅ | |
| Media Text | sidebyside | ➡️ | Image/video + text |
| Message | - | ❌ | Alert/notification |
| MiniPager | - | ❌ | Compact pagination |
| Pager | pager | ✅ | |
| Slide | slider (child) | ✅ | Part of slider |
| Tabs | - | ❌ | Tabbed content |

## Organisms

| Quartz | adesso CMS | Status | Notes |
|--------|------------|--------|-------|
| Calendar | - | ❌ | Event calendar |
| DropdownMenu | - | ❌ | Navigation dropdown |
| Local Menu | - | ❌ | Section navigation |
| Mega Menu | - | ❌ | Full-width navigation |
| Mobile Menu | mobile-menu | ✅ | |
| Search | - | 🔄 | Search API exists, no SDC |
| Slider | slider, carousel | ✅ | |

## Search Components

| Quartz | adesso CMS | Status | Notes |
|--------|------------|--------|-------|
| Autocomplete | - | ❌ | Search suggestions |
| Filters | - | ❌ | Filter UI |
| Refresh | - | ❌ | Refresh results |
| Reset | - | ❌ | Clear filters |
| Search Result | - | ❌ | Result display |
| Sorter | - | ❌ | Sort controls |
| Summary | - | ❌ | Results summary |
| Facets | - | ❌ | Faceted search UI |

## Sections (Paragraphs)

| Quartz | adesso CMS | Status | Notes |
|--------|------------|--------|-------|
| Accordion | accordion | ✅ | |
| Custom Box | - | ❌ | Flexible container |
| Facts | statistic | ➡️ | Statistics |
| Files | download-item | ✅ | |
| Grid | card-group | ➡️ | Card grid |
| Headline | headline-paragraph | ✅ | |
| Image | media | ✅ | |
| Image Text | sidebyside | ✅ | |
| Page References | recent-cards | ➡️ | Related content |
| Slideshow | gallery, slider | ✅ | |
| Tabs | - | ❌ | Tabbed sections |
| Text | text | ✅ | |
| Two Column | sidebyside | ✅ | |
| Video | media | ✅ | |
| Video Text | sidebyside | ✅ | |

## Regions

| Quartz | adesso CMS | Status | Notes |
|--------|------------|--------|-------|
| Footer | site-footer | ✅ | |
| Header | site-header | ✅ | |
| Sidebar | - | ❌ | Page sidebar |

---

## Gap Summary

### High Priority (Core UX)
1. **Tabs** - Essential for content organization
2. **Dropdown/DropdownMenu** - Navigation patterns
3. **Message** - User feedback/alerts
4. **Spinner** - Loading states
5. **Search Components** - Autocomplete, Filters, Facets

### Medium Priority (Enhanced UX)
6. **Cookie Consent** - GDPR (Klaro module exists, needs SDC)
7. **Tooltip** - Contextual help
8. **LoadMore** - Alternative pagination
9. **Mega Menu** - Complex navigation
10. **Sidebar** - Page layouts

### Lower Priority (Nice to have)
11. **Calendar** - Event display
12. **Infographic** - Data viz
13. **Backdrop/Overlay** - Modal support
14. **Drawer** - Slide panels

---

## adesso CMS Unique Features

Components adesso CMS has that Quartz doesn't emphasize:
- **bento-grid** - Modern grid layouts
- **pricing** - Pricing tables
- **newsletter-form** - Email signup
- **logo-collection** - Partner/client logos
- **block-reference** - Reusable blocks
