# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

BD-Audit is a Claude Code plugin for comprehensive website audits aimed at adesso SE Business Developers. It orchestrates 50+ specialized agents across 8 audit phases to analyze websites, generate lead scores, and produce VitePress reports.

**Target Users:** Business Developers (non-technical) - keep all output simple and actionable.

## Commands

| Command | Description |
|---------|-------------|
| `/bd <url>` | Full 8-phase audit (60-90 min) |
| `/bd <url> --quick` | Quick check: Discovery + Tech Stack only |
| `/bd <url> --tech` | Technical audit (phases 1-3) |
| `/bd <url> --marketing` | Marketing audit (phases 1, 5, 6) |
| `/bd <url> --legal` | Legal/compliance check (phases 1, 4) |
| `/bd-list` | Dashboard of all audits |
| `/bd-ppt <name>` | Generate PowerPoint from audit |
| `/bd-open <name>` | Open existing report |
| `/bd-onepager <name>` | Generate one-page summary |

## Architecture

### 8 Audit Phases

```
Phase 1: DISCOVERY (8 agents)  → Company research, tech stack, sitemap
Phase 2: INVENTORY (8 agents)  → Content, components, media, forms
Phase 3: TECHNICAL (8 agents)  → Performance, a11y, SEO, security
Phase 4: LEGAL (6 agents)      → BFSG, GDPR, cookies, imprint
Phase 5: MARKETING (8 agents)  → Brand, competitors, conversion
Phase 6: UX (6 agents)         → Navigation, forms, mobile, search
Phase 7: EVALUATION (6 agents) → CMS specialists (Drupal, TYPO3, etc.)
Phase 8: SYNTHESIS (6 agents)  → Report generation (SEQUENTIAL!)
```

**Phases 1-7:** Run agents in parallel using Task tool
**Phase 8:** Must run sequentially (depends on all previous phases)

### Agent Spawning Pattern

```
Task(subagent_type="bd-audit:discovery-basic", prompt="Analysiere ${URL}")
Task(subagent_type="bd-audit:tech-stack-detector", prompt="...")
```

Spawn all agents within a phase in parallel, wait for phase completion, then proceed to next phase.

### Directory Structure

```
bd-audit/
├── agents/              # 50+ specialized audit agents
│   ├── discovery/       # Company & tech research
│   ├── inventory/       # Content & feature mapping
│   ├── technical/       # Performance, SEO, security
│   ├── legal/           # Compliance (BFSG, GDPR)
│   ├── marketing/       # Brand, conversion, trust
│   ├── ux/              # User experience analysis
│   ├── evaluation/      # CMS specialists
│   └── synthesis/       # Report generation
├── commands/            # Slash command definitions
├── skills/              # Domain knowledge (CMS portfolio, methodology)
├── mcp-servers/         # Custom MCP servers (Wappalyzer)
└── .mcp.json            # MCP server configuration
```

### MCP Servers

- **Playwright:** Browser automation, screenshots, crawling, visual testing
- **Wappalyzer:** Technology detection (local, no API required)
- **Lighthouse:** Performance/a11y/SEO audits

**Crawling:** Use Playwright MCP for website crawling (`browser_navigate`, `browser_snapshot`, `browser_take_screenshot`).

## Report Output

Reports are generated as VitePress markdown in a simple flat structure:

```
<firmenname>/
├── index.md              # Executive summary
├── discovery/            # Company, tech, business segments
├── inventory/            # Content inventory
├── technical/            # Lighthouse, a11y, SEO
├── legal/                # BFSG, GDPR compliance
├── marketing/            # Brand & competitor analysis
├── ux/                   # UX findings
├── evaluation/           # CMS recommendation
└── screenshots/          # Visual captures
```

**Iterative Improvement:** Re-run `/bd <url>` to update an existing report.

## Lead Score System

| Score | Status | Action |
|-------|--------|--------|
| 90-100 | 🔥 Very Hot | Contact immediately |
| 70-89 | 🟢 Hot | Active pursuit |
| 50-69 | 🟡 Warm | Nurturing |
| 30-49 | 🔵 Cold | Monitor |
| 0-29 | ⚪ Ice | Low priority |

Score weights: Technical (30%), Marketing (25%), Legal (15%), UX (15%), Fit (15%)

## Key Dates

**BFSG Deadline: 28.06.2025** - All B2C websites must be WCAG 2.1 AA compliant.

## Adding New Agents

1. Create `.md` file in appropriate `agents/` subdirectory
2. Add YAML frontmatter:
   ```yaml
   ---
   name: agent-name
   description: "What this agent does"
   model: opus|sonnet|haiku
   color: white
   tools: ["Task", "Read", "WebFetch", ...]
   ---
   ```
3. Write detailed agent instructions
4. Agent is auto-discovered by the orchestrator

## CMS Portfolio Reference

Primary CMS recommendations from adesso portfolio:

| Requirement | Recommended CMS |
|-------------|-----------------|
| BFSG/Accessibility | Drupal (Starterkit) |
| B2B Commerce | Ibexa, Shopware |
| Headless/API-first | Storyblok, Drupal |
| Multi-Site Enterprise | FirstSpirit, Magnolia |
| DACH region | TYPO3, Drupal |
| Marketing DXP | Magnolia |

See `skills/cms-portfolio/SKILL.md` for detailed CMS comparison and TCO data.
