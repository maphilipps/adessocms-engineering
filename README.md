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

## Marketplace Management

### Creating New Plugins

For detailed instructions on creating and registering new plugins in this marketplace:

- **Quick Start:** See [New Plugin Creation Checklist](docs/new-plugin-creation-checklist.md)
- **Prevention Strategies:** See [Prevention Strategies Guide](docs/prevention-strategies-marketplace-registration.md)
- **Summary:** See [Prevention Summary](docs/PREVENTION-SUMMARY.md)

### Plugin Validation

This marketplace includes automated validation to ensure all plugins are properly registered:

```bash
# Validate plugin registration
./scripts/validate-marketplace.sh
```

The validation script checks:
- All plugin directories are registered in marketplace.json
- All marketplace.json entries have corresponding directories
- Plugin metadata files exist and are valid
- Plugin names are consistent across all files
- No duplicate entries

A pre-commit hook also prevents commits with unregistered plugins.

## Documentation

See [plugins/adessocms-engineering/README.md](plugins/adessocms-engineering/README.md) for full documentation.

## Acknowledgments

- Based on [compound-engineering](https://github.com/EveryInc/compound-engineering-plugin) by Kieran Klaassen and Every.to
- Drupal skills from [drupal-claude-skills](https://github.com/grasmash/drupal-claude-skills) by Matthew Grasmick

## License

MIT
