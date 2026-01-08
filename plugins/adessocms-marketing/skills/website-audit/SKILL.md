---
name: website-audit
description: AI-powered website audit for Drupal relaunch projects. Use when analyzing existing websites, mapping features to Drupal architecture, creating dual estimates (traditional vs AI-assisted), or matching websites against client specifications. Uses Claude in Chrome MCP for browser automation and Accessibility MCP for WCAG testing.
---

<objective>
Audit websites for Drupal relaunches using AI-first methodology.
Map all features to Drupal entities (Content Types, Paragraphs, Views).
Generate dual estimates showing traditional vs AI-assisted development costs.
Match website against client briefings to identify gaps.
</objective>

<essential_principles>
ALL OUTPUT MUST BE IN GERMAN (Deutsch).
Reports, estimations, documentation - everything user-facing is German.

ALWAYS use Claude in Chrome MCP for browser automation:
- mcp__claude-in-chrome__navigate for navigation
- mcp__claude-in-chrome__read_page for DOM analysis
- mcp__claude-in-chrome__computer for screenshots and interactions
- mcp__claude-in-chrome__tabs_context_mcp to manage tabs

ALWAYS use Accessibility MCP for WCAG testing:
- mcp__a11y-accessibility__test_accessibility for full audits
- mcp__a11y-accessibility__check_color_contrast for contrast checks

NEVER use Puppeteer or Chrome DevTools MCP.

ALWAYS provide DUAL estimates:
- Traditional (manual development)
- AI-Assisted (Claude Code supported)

Map ALL features to Drupal entities:
- Page types → Content Types
- Components → Paragraph Types
- Categories → Taxonomies
- Listings → Views
- Forms → Webforms
</essential_principles>

<intake>
What type of audit do you need?

1. **Full Audit** - Complete analysis with VitePress documentation
2. **Quick Tech Check** - CMS detection and tech stack only
3. **Estimation Only** - Entity count → dual estimate
4. **Document Match** - Compare website against briefing/specs

Provide the website URL and any relevant documents.

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Action | Workflow |
|----------|--------|----------|
| 1, "full", "complete" | Full 11-phase audit | workflows/full-audit.md |
| 2, "quick", "tech" | CMS + stack analysis | workflows/quick-audit.md |
| 3, "estimate", "estimation" | Dual estimation | workflows/estimation-only.md |
| 4, "match", "document", "briefing" | Gap analysis | workflows/document-match.md |
</routing>

<success_criteria>
Full Audit:
- CMS detected and documented
- All page types identified and mapped to Drupal Content Types
- All components inventoried and mapped to Paragraph Types
- Taxonomies documented
- Performance metrics captured (Core Web Vitals)
- Accessibility audit completed (WCAG 2.1 AA)
- Dual estimation provided (Traditional + AI-Assisted)
- VitePress documentation site generated

Quick Tech Check:
- CMS identified with confidence
- Tech stack documented (frameworks, libraries)
- High-level architecture understood

Estimation Only:
- Entity inventory complete
- Both estimates calculated and compared
- Savings percentage shown

Document Match:
- Requirements extracted from briefing
- Website analyzed for matching features
- Gap report generated (✅ Met / ⚠️ Partial / ❌ Missing)
- Focused estimation on gaps only
</success_criteria>

<tools>
Primary Browser Tools (Claude in Chrome):
- mcp__claude-in-chrome__tabs_context_mcp - Get tab context first
- mcp__claude-in-chrome__tabs_create_mcp - Create new tab
- mcp__claude-in-chrome__navigate - Go to URL
- mcp__claude-in-chrome__read_page - Get page structure (a11y tree)
- mcp__claude-in-chrome__computer - Screenshots, clicks, interactions
- mcp__claude-in-chrome__find - Find elements by description
- mcp__claude-in-chrome__get_page_text - Extract text content

Accessibility Tools:
- mcp__a11y-accessibility__test_accessibility - WCAG audit
- mcp__a11y-accessibility__check_color_contrast - Contrast check
- mcp__a11y-accessibility__check_aria_attributes - ARIA validation

Research Tools:
- WebSearch - Tech stack detection (BuiltWith, Wappalyzer data)
- WebFetch - Fetch sitemap, robots.txt, API responses
</tools>

<estimation_agents>
For dual estimation, launch these agents in PARALLEL:

Agent 1: traditional-estimator
- Uses references/estimation-traditional.md
- Calculates hours assuming manual development
- No AI assistance assumed

Agent 2: ai-estimator
- Uses references/estimation-ai-assisted.md
- Calculates hours assuming Claude Code support
- ~67% reduction applied

Agent 3: estimation-synthesizer (after 1+2 complete)
- Combines both estimates
- Shows side-by-side comparison
- Calculates total savings
- Generates comparison report
</estimation_agents>

<drupal_mapping>
Content Architecture Mapping:

| Website Feature | Drupal Entity | Estimation Factor |
|-----------------|---------------|-------------------|
| Page type with fields | Content Type | Medium complexity |
| Reusable component | Paragraph Type | Varies by complexity |
| Category/classification | Taxonomy | Simple unless hierarchical |
| Content listing | View | Medium unless filtered |
| Contact/inquiry form | Webform | Medium unless multi-step |
| Static block | Block | Simple |
| Custom functionality | Custom Module | Complex |
| UI component | SDC Theme Component | Varies |

Complexity Guidelines:
- **Simple:** Standard patterns, <5 fields, no custom logic
- **Medium:** 5-10 fields, some custom behavior, references
- **Complex:** >10 fields, custom workflows, integrations
</drupal_mapping>

<references>
Estimation:
- references/estimation-traditional.md - Manual development hours
- references/estimation-ai-assisted.md - AI-assisted hours (67% reduction)
- references/baseline_adessocms.md - Reference project (693h baseline)

Technical:
- references/drupal_architecture_patterns.md - Entity patterns
- references/migration-patterns.md - Migration strategies
- references/cms-detection.md - CMS identification
- references/cms-comparison.md - Drupal vs alternatives
- references/audit_methodology.md - Full methodology

VitePress:
- scripts/generate_vitepress_site.py - Documentation generator
- assets/vitepress-template/ - Site templates
</references>

<output_format>
All audit results saved to: ./audit_data/[projekt-name]/

Files generated (ALL IN GERMAN):
- audit_report.json - Strukturierte Audit-Daten
- schaetzung_vergleich.md - Dualer Schätzungsbericht
- screenshots/ - Visuelle Dokumentation
- [VitePress-Site bei Full Audit]

Estimation Report Format (DEUTSCH):
```
╔═══════════════════════════════════════════════════════════════╗
║              PROJEKT-SCHÄTZUNG VERGLEICH                       ║
╠═══════════════════════════════════════════════════════════════╣
║ Kategorie             │ Traditionell │ KI-Unterstützt │ Erspart║
╠═══════════════════════════════════════════════════════════════╣
║ Inhaltstypen          │ XXh          │ XXh            │ XX%    ║
║ Paragraphs            │ XXh          │ XXh            │ XX%    ║
║ Views                 │ XXh          │ XXh            │ XX%    ║
║ Theme-Komponenten     │ XXh          │ XXh            │ XX%    ║
║ Migration             │ XXh          │ XXh            │ XX%    ║
╠═══════════════════════════════════════════════════════════════╣
║ ZWISCHENSUMME         │ XXXh         │ XXXh           │        ║
║ + Multiplikatoren     │ XXXh         │ XXXh           │        ║
║ + Projektmanagement   │ XXXh         │ XXXh           │        ║
║ + Puffer              │ XXXh         │ XXXh           │        ║
╠═══════════════════════════════════════════════════════════════╣
║ GESAMT                │ XXXh         │ XXXh           │ XX%    ║
║ Zeitplan (40h/Woche)  │ XX Wochen    │ XX Wochen      │        ║
╠═══════════════════════════════════════════════════════════════╣
║ KI-ERSPARNIS          │         XX% Reduktion (XXXh)          ║
╚═══════════════════════════════════════════════════════════════╝
```
</output_format>
