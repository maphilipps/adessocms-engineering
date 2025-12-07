# adessocms-engineering

AI-powered Drupal development tools that get smarter with every use.

Based on [compound-engineering](https://github.com/EveryInc/compound-engineering-plugin) philosophy: make each unit of engineering work easier than the last.

## Installation

### Step 1: Add the Marketplace

```
/plugins marketplace add maphilipps/adessocms-engineering
```

### Step 2: Install the Plugin

```
/plugins install adessocms-engineering
```

## What's Included

| Component | Count |
|-----------|-------|
| Agents | 27 |
| Commands | 17 |
| Skills | 10 |
| MCP Servers | 2 |

### Highlights

**Drupal-Specific Agents:**
- `drupal-reviewer` - Drupal coding standards & best practices
- `dries-drupal-reviewer` - Review from Dries Buytaert's perspective
- `twig-template-reviewer` - Twig templates, security, SDC
- `drupal-theme-reviewer` - Theme implementations, SDC
- `tailwind-reviewer` - Tailwind CSS v4, Vite integration
- `storybook-reviewer` - Storybook stories, interaction tests
- `accessibility-reviewer` - WCAG 2.1 Level AA compliance
- `composer-dependency-reviewer` - Composer dependencies, security
- `test-coverage-reviewer` - PHPUnit, Playwright, Vitest

**Workflow Commands:**
- `/plan` - Create implementation plans
- `/review` - Multi-agent code reviews
- `/work` - Execute work items
- `/compound` - Document solved problems

**Drupal Skills:**
- `drupal-at-your-fingertips` - Comprehensive Drupal patterns (50+ topics)
- `drupal-config-mgmt` - Configuration management
- `drupal-contrib-mgmt` - Contrib module management
- `drupal-ddev` - DDEV workflows
- `ivangrynenko-cursorrules-drupal` - Security guidelines

## Requirements

- Claude Code CLI
- Node.js 20+ (for MCP servers)
- DDEV (recommended)

## Documentation

See [plugins/adessocms-engineering/README.md](plugins/adessocms-engineering/README.md) for full documentation.

## Acknowledgments

- Based on [compound-engineering](https://github.com/EveryInc/compound-engineering-plugin) by Kieran Klaassen and Every.to
- Drupal skills from [drupal-claude-skills](https://github.com/grasmash/drupal-claude-skills) by Matthew Grasmick

## License

MIT
