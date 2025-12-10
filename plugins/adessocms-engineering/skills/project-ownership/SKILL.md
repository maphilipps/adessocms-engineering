---
name: project-ownership
description: Manages adesso CMS development roadmap, gap analysis against 1xInternet Quartz reference, ticket proposals, and quality standards. Use when planning features, comparing to reference implementations, or proposing Jira tickets.
---

<objective>
Own the adesso CMS product development by:
1. Tracking feature parity with 1xInternet Quartz/Volcano reference
2. Maintaining a prioritized roadmap
3. Proposing well-structured Jira tickets (DS project)
4. Ensuring SDC quality and coding standards
5. Coordinating component development
</objective>

<essential_principles>
## Reference Implementation
The 1xInternet CMS (Quartz design system, Volcano/Granite theme) serves as our benchmark.
- **Storybook**: https://trydrupal.1xinternet.de/themes/custom/volcano/design-system/storybook-static/
- **Demo**: https://trydrupal.1xinternet.de/guided-tours
- **Product Page**: https://www.1xinternet.com/en/solutions/content-management-system

## Jira Integration (via acli CLI)
- **Board**: https://adesso-app-mgt.atlassian.net/jira/software/projects/DS/boards/186
- **Project Key**: DS
- **CLI**: `acli` (Atlassian CLI) - siehe `references/acli-reference.md`
- **Workflow**: Tickets MUST be proposed and approved before creation
- Never create tickets directly - always propose first

Available acli operations:
- `acli jira workitem search` - Tickets suchen
- `acli jira workitem create` - Ticket erstellen (nach Approval)
- `acli jira workitem edit` - Ticket bearbeiten
- `acli jira workitem transition` - Status ändern
- `acli jira workitem comment create` - Kommentar hinzufügen

## Quality Gates
Every component/feature must meet:
1. SDC structure compliance (schema, template, story, behavior)
2. Storybook story with all variants
3. Drupal coding standards (PHPCS, ESLint, Stylelint)
4. Accessibility (WCAG 2.1 AA)
5. Responsive design (mobile-first)
6. Performance (lazy loading, optimized assets)

## Development Principles
**YAGNI** - You Ain't Gonna Need It
- Only implement what's needed NOW
- No speculative features
- Simplest solution that works

**DRY** - Don't Repeat Yourself
- Extract shared logic into reusable components
- Use Twig includes/embeds for repeated patterns
- Consolidate similar paragraph types

## Atomic Design Hierarchy
Components MUST follow Atomic Design:
- **Atoms**: Basic elements (button, badge, icon, heading)
- **Molecules**: Groups of atoms (card, accordion-item, form-field)
- **Organisms**: Complex sections (header, hero, card-group)
- **Templates**: Page layouts
- **Pages**: Specific instances

## Translation Requirements (i18n)
ALL user-facing strings MUST be translatable:
- Twig: `{{ 'Text'|t }}` or `{{ 'Hello @name'|t({'@name': name}) }}`
- JS: `Drupal.t('Text')` or `Drupal.t('Hello @name', {'@name': name})`
- PHP: `$this->t('Text')` or `$this->t('Hello @name', ['@name' => $name])`
- NO hardcoded strings in templates!

## Paragraph Standards
ALL paragraph types MUST have:
- Consistent field naming (`field_heading`, `field_subheading`, etc.)
- Standard options: `field_background`, `field_spacing`
- Multi-column support where applicable
- Proper form/view display configuration
- Mapping to corresponding SDC

## Multi-Column Layouts
Section components SHOULD support:
- 1, 2, 3, 4 column options
- Column ratio variants (50/50, 60/40, 70/30)
- Responsive collapse behavior
- Consistent gap spacing
</essential_principles>

<intake>
What would you like to do?

1. **Gap Analysis** - Compare adesso CMS to Quartz reference
2. **Roadmap** - View/update development roadmap
3. **Propose Tickets** - Create Jira ticket proposals for review
4. **Quality Review** - Check component/feature quality
5. **Status Report** - Current progress overview

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Workflow |
|----------|----------|
| 1, "gap", "compare", "missing" | workflows/gap-analysis.md |
| 2, "roadmap", "plan", "priorities" | workflows/roadmap-planning.md |
| 3, "ticket", "jira", "propose" | workflows/ticket-proposal.md |
| 4, "quality", "review", "check" | workflows/quality-review.md |
| 5, "status", "progress", "report" | workflows/status-report.md |

**After reading the workflow, follow it exactly.**
</routing>

<quick_reference>
## Component Gap Summary (as of analysis)

### Quartz Has, adesso CMS Missing:
**Atoms**: Backdrop, Divider, Drawer, Lazy, Overlay, Spinner, Tooltip
**Molecules**: Cookie Consent, Dropdown, Fact, Infographic, LoadMore, Message, MiniPager, Slide, Tabs
**Organisms**: Calendar, DropdownMenu, Local Menu, Mega Menu
**Search**: Autocomplete, Filters, Facets, Search Result, Sorter, Summary

### ✅ Fully Documented for Cloning:
**Foundation**: Design tokens, Typography, Colors, Spacing, Grid, Shadows, Radius, Motion/Animations
**Shadow DOM CSS**: qz-button, qz-card, qz-accordion, qz-icon, qz-media-text (all variants & states)

### adesso CMS Has:
accordion, badge, bento-grid, block-reference, button, card-group, carousel,
download-item, embed, gallery, heading, headline-paragraph, hero, image-sidebyside,
logo, logo-collection, main-menu, media, mobile-menu, newsletter-form, page-header,
pager, pricing, recent-cards, sidebyside, site-footer, site-header, slider,
stat-card, statistic, statistic-item, text
</quick_reference>

<reference_index>
## References
- references/quartz-components.md - Full Quartz component inventory
- references/quartz-design-system.md - **COMPLETE Tailwind CSS configuration** (Typography, Colors, Spacing, Grid, Shadows, Radius)
- references/quartz-shadow-dom-css.md - **🚨 SHADOW DOM CSS** (Button, Card, Accordion, Icon, MediaText, Motion/Animations)
- references/1xinternet-paragraphs.md - **ALL 23 Paragraph types with fields and frontend output**
- references/adesso-components.md - Current adesso CMS components
- references/feature-comparison.md - Feature parity matrix
- references/sdc-standards.md - SDC quality requirements
- references/coding-guidelines.md - Coding standards
- references/quality-checklist.md - Complete quality checklist (i18n, Atomic, Paragraphs)
- references/acli-reference.md - Atlassian CLI (acli) Kommando-Referenz

## Roadmap
- ROADMAP.md - Development roadmap with phases and priorities

## Templates
- templates/jira-ticket.md - Ticket proposal format
- templates/roadmap-item.md - Roadmap entry format
- templates/component-spec.md - Component specification

## External Resources
- **1xINTERNET Website**: https://www.1xinternet.com/de
- **Try Drupal Demo**: https://41043c2cd16280e.qaack.1xinter.net (trydrupal/trydrupal)
- **Quartz Storybook**: https://quartz.1xinternet.de (v6.0.1)
</reference_index>
