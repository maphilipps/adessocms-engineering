# BD-Audit Plugin

**Comprehensive Website & Marketing Audit Plugin for adesso SE Business Developers**

```
   ____  ____        _             _ _ _
  | __ )|  _ \      / \  _   _  __| (_) |_
  |  _ \| | | |    / _ \| | | |/ _` | | __|
  | |_) | |_| |   / ___ \ |_| | (_| | | |_
  |____/|____/   /_/   \_\__,_|\__,_|_|\__|

  Website Audit System for Business Development
```

## Overview

BD-Audit is a Claude Code plugin that provides comprehensive website analysis capabilities for adesso SE Business Developers. It enables rapid lead qualification, technical audits, and automated report generation.

### Key Features

- **50 Specialized Agents** across 8 audit phases
- **Single Command Trigger**: `/bd example.com`
- **VitePress Reports**: Beautiful, shareable reports at audits.adessocms.de
- **Multi-BD Support**: Shared GitHub repository with automatic deployment
- **adesso Branding**: Consistent corporate identity

## Quick Start

```bash
# Run a complete audit
/bd https://example.com

# Run specific audit types
/bd-qualify https://example.com    # Quick lead qualification
/bd-tech https://example.com       # Technical audit only
/bd-a11y https://example.com       # Accessibility audit
/bd-report                         # Generate report from existing data
```

## Audit Phases

| Phase | Agents | Description |
|-------|--------|-------------|
| **Discovery** | 10 | Lead qualification, company research, competitor analysis |
| **Inventory** | 8 | Tech stack detection, content inventory, feature mapping |
| **Technical** | 8 | Performance, SEO, security, code quality |
| **Legal** | 6 | BFSG/Accessibility, DSGVO, impressum compliance |
| **Marketing** | 8 | Brand consistency, trust signals, conversion analysis |
| **UX** | 6 | User experience, navigation, mobile, forms |
| **Evaluation** | 6 | CMS recommendation, effort estimation, TCO |
| **Synthesis** | 6 | Report generation, executive summary, roadmap |

## Commands

| Command | Description |
|---------|-------------|
| `/bd <url>` | Full audit workflow |
| `/bd-qualify <url>` | Quick lead qualification (Score 0-100) |
| `/bd-tech <url>` | Technical audit (Lighthouse, Tech Stack) |
| `/bd-a11y <url>` | Accessibility audit (BFSG/WCAG) |
| `/bd-seo <url>` | SEO audit |
| `/bd-report [customer]` | Generate VitePress report |
| `/bd-deploy [customer]` | Deploy report to Netlify |

## Skills

The plugin includes specialized knowledge through skills:

- **cms-portfolio**: adesso CMS portfolio (Drupal, TYPO3, Magnolia, FirstSpirit, etc.)
- **audit-methodology**: Audit methodology and best practices
- **vitepress-generation**: VitePress report generation
- **effort-estimation**: Project effort estimation guidelines
- **marketing-intelligence**: Market and competitor analysis
- **legal-compliance**: BFSG, DSGVO, TMG compliance

## MCP Servers

| Server | Purpose |
|--------|---------|
| **Playwright** | Browser automation, crawling, screenshots |
| **Wappalyzer** | Technology detection (local) |
| **Lighthouse** | Performance, accessibility, SEO audits |

## Report Structure

Reports are generated as VitePress static sites with a simple flat structure:

```
<firmenname>/
├── index.md              # Executive summary + dashboard
├── discovery/
│   ├── overview.md       # Quick overview
│   ├── tech-stack.md     # Technology detection
│   ├── company.md        # Company profile
│   └── business_segments.md  # Divisions + contacts
├── technical/
│   ├── performance.md    # Lighthouse results
│   ├── accessibility.md  # BFSG/WCAG
│   └── seo.md            # SEO analysis
├── evaluation/
│   ├── cms-comparison.md # CMS recommendation
│   └── recommendation.md # Final recommendation
└── screenshots/          # Visual captures
```

**Iterative:** Re-run `/bd <url>` anytime to improve existing reports.

## Setup

### Prerequisites

- Claude Code with plugin support
- Node.js 18+
- Git access to maphilipps/bd-audit-reports

### Environment Variables

```bash
# Deployment (optional)
NETLIFY_AUTH_TOKEN=your-token
NETLIFY_SITE_ID=your-site-id
```

### First Use

1. Enable the bd-audit plugin in Claude Code
2. Run `/bd https://example.com` to start your first audit
3. Follow the prompts to complete the analysis
4. Reports are automatically deployed to audits.adessocms.de

## For Business Developers

### Lead Qualification

The lead qualifier provides a score from 0-100:

| Score | Classification | Action |
|-------|----------------|--------|
| 80-100 | 🔥 Hot Lead | Contact immediately |
| 60-79 | 🟢 Warm Lead | Active pursuit |
| 40-59 | 🟡 Neutral | Nurturing |
| 20-39 | 🟠 Cold Lead | Low priority |
| 0-19 | ❌ Unqualified | Do not pursue |

### BFSG Deadline

The BFSG (Barrierefreiheitsstärkungsgesetz) comes into effect on **28.06.2025**. All B2C websites must be WCAG 2.1 AA compliant. The audit includes specific BFSG compliance checks.

### CMS Portfolio

The plugin recommends CMS from the adesso portfolio based on requirements:

| CMS | Segment | Best For |
|-----|---------|----------|
| Drupal | Mid-Market | Flexibility, BFSG, API-first |
| TYPO3 | DACH | Enterprise Open Source |
| Magnolia | Enterprise | DXP, Personalization |
| FirstSpirit | Enterprise | Multi-Site, Headless |
| Ibexa | B2B | Commerce, PIM |
| Shopware | E-Commerce | D2C, B2B Commerce |
| Storyblok | Headless | JAMstack, Performance |

## Development

### Plugin Structure

```
bd-audit/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── commands/                 # Slash commands
├── agents/                   # 50 specialized agents
│   ├── discovery/
│   ├── inventory/
│   ├── technical/
│   ├── legal/
│   ├── marketing/
│   ├── ux/
│   ├── evaluation/
│   └── synthesis/
├── skills/                   # 6 knowledge skills
├── hooks/                    # Event hooks
├── .mcp.json                 # MCP server config
├── mcp-servers/              # Custom MCP servers
└── assets/                   # Theme & scripts
```

### Adding a New Agent

1. Create a new `.md` file in the appropriate `agents/` subdirectory
2. Add YAML frontmatter with name, description, model, color, tools
3. Write detailed instructions for the agent
4. The agent will be automatically discovered

### Contributing

1. Fork the plugin repository
2. Create a feature branch
3. Submit a pull request

## Support

- **Issues**: File issues in the plugin repository
- **Contact**: Marc Philipps (marc.philipps@adesso.de)

## License

Proprietary - adesso SE

---

**adesso SE** - Solutions for Digital Business
