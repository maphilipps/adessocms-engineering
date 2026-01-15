# adesso CMS Development Roadmap

**Last Updated**: 2024-12-07
**Reference**: 1xInternet Quartz Design System
**Jira Project**: DS

---

## Vision

Build adesso CMS to feature parity with 1xInternet Quartz while maintaining
clean Atomic Design principles, full i18n support, and consistent quality standards.

---

## Phase 1: Foundation & Quality (Current)

**Goal**: Establish quality baseline and fill critical gaps

### Quality Improvements

| Priority | Task | Status | Jira | Notes |
|----------|------|--------|------|-------|
| P1 | Audit all existing SDCs | Planned | - | Check schema, stories, i18n |
| P1 | Add missing Storybook stories | Planned | - | All components need stories |
| P1 | Implement i18n for all components | Planned | - | Use `|t` filter everywhere |
| P1 | Standardize paragraph templates | Planned | - | Consistent fields across all |
| P2 | Add component README files | Planned | - | Usage docs per component |

### Missing Core Components

| Priority | Component | Category | Status | Jira | Effort |
|----------|-----------|----------|--------|------|--------|
| P1 | Tabs | Molecule | Planned | - | M |
| P1 | Message/Alert | Molecule | Planned | - | S |
| P1 | Spinner | Atom | Planned | - | S |
| P1 | Divider | Atom | Planned | - | S |
| P2 | Tooltip | Atom | Planned | - | M |
| P2 | LoadMore | Molecule | Planned | - | M |

---

## Phase 2: Navigation & Search

**Goal**: Complete navigation patterns and search UI

### Components

| Priority | Component | Category | Status | Jira | Effort |
|----------|-----------|----------|--------|------|--------|
| P1 | Dropdown | Molecule | Planned | - | M |
| P1 | DropdownMenu | Organism | Planned | - | L |
| P1 | Mega Menu | Organism | Planned | - | XL |
| P2 | Local Menu | Organism | Planned | - | M |
| P2 | Breadcrumb | Molecule | Planned | - | S |

### Search Components

| Priority | Component | Category | Status | Jira | Effort |
|----------|-----------|----------|--------|------|--------|
| P1 | Search Autocomplete | Molecule | Planned | - | L |
| P1 | Search Filters | Molecule | Planned | - | L |
| P1 | Search Results | Molecule | Planned | - | M |
| P2 | Facets | Molecule | Planned | - | L |
| P2 | Search Sorter | Atom | Planned | - | S |

---

## Phase 3: Enhanced Sections

**Goal**: Rich content sections and layouts

### Components

| Priority | Component | Category | Status | Jira | Effort |
|----------|-----------|----------|--------|------|--------|
| P1 | Tabbed Section | Section | Planned | - | L |
| P1 | Custom Box | Section | Planned | - | M |
| P2 | Page References | Section | Planned | - | M |
| P2 | Sidebar | Region | Planned | - | M |
| P3 | Calendar | Organism | Planned | - | XL |

### Layout Enhancements

| Priority | Task | Status | Jira | Notes |
|----------|------|--------|------|-------|
| P1 | Multi-column support for all sections | Planned | - | 1-4 columns |
| P1 | Consistent spacing options | Planned | - | none/sm/md/lg |
| P2 | Background variants | Planned | - | light/dark/primary |

---

## Phase 4: Polish & Documentation

**Goal**: Production-ready quality

### Tasks

| Priority | Task | Status | Jira | Notes |
|----------|------|--------|------|-------|
| P1 | Design System documentation | Planned | - | Foundation docs |
| P1 | Component API documentation | Planned | - | All props documented |
| P2 | Usage guidelines | Planned | - | When to use what |
| P2 | Migration guide | Planned | - | For existing sites |
| P3 | Video tutorials | Planned | - | Editor training |

### Performance

| Priority | Task | Status | Jira | Notes |
|----------|------|--------|------|-------|
| P1 | Lazy loading audit | Planned | - | Images, components |
| P2 | Bundle size optimization | Planned | - | Code splitting |
| P2 | Core Web Vitals | Planned | - | LCP, CLS, FID |

---

## Completed

| Component/Task | Completed | Jira | Notes |
|----------------|-----------|------|-------|
| accordion | Existing | - | Needs i18n audit |
| badge | Existing | - | Needs story variants |
| button | Existing | - | |
| card-group | Existing | - | |
| carousel | Existing | - | |
| gallery | Existing | - | |
| hero | Existing | - | |
| ... | ... | ... | ... |

---

## Success Metrics

### Component Coverage
- Target: 60+ components (Quartz parity)
- Current: ~33 components
- Gap: ~27 components

### Quality Metrics
- All components have Storybook stories: 0% → 100%
- All components have schema: ? → 100%
- All strings translatable: ? → 100%
- All paragraphs standardized: ? → 100%

### Performance Targets
- Lighthouse Performance: >90
- Accessibility: >95
- Best Practices: >95
- SEO: >95

---

## Notes

- Priorities may shift based on client needs
- Each component needs full quality checklist before "done"
- Jira tickets created only after approval
- Reference Quartz Storybook for design patterns
