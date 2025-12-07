# adessocms-engineering Plugin

AI-powered Drupal development tools that get smarter with every use. Specialized for Drupal 11, Twig, Tailwind CSS v4, and Single Directory Components.

Based on [compound-engineering](https://github.com/EveryInc/every-marketplace) philosophy: make each unit of engineering work easier than the last.

## Components

| Component | Count |
|-----------|-------|
| Agents | 26 |
| Commands | 19 |
| Skills | 11 |
| MCP Servers | 2 |

## Agents

Agents are organized into categories for easier discovery.

### Review (15)

| Agent | Description |
|-------|-------------|
| `drupal-reviewer` | Drupal coding standards, API usage, and best practices |
| `dries-drupal-reviewer` | Brutally honest Drupal review from Dries Buytaert's perspective |
| `twig-template-reviewer` | Twig templates, security, Drupal patterns, SDC |
| `drupal-theme-reviewer` | Theme implementations, SDC, preprocess functions, libraries |
| `tailwind-reviewer` | Tailwind CSS v4 syntax, Vite integration, Drupal theming |
| `storybook-reviewer` | Storybook stories, SDC integration, interaction tests |
| `accessibility-reviewer` | WCAG 2.1 Level AA, ARIA, semantic HTML, keyboard nav |
| `composer-dependency-reviewer` | Composer dependencies, security, Drupal contrib |
| `test-coverage-reviewer` | PHPUnit, Kernel, Functional, Playwright, Vitest coverage |
| `architecture-strategist` | Analyze architectural decisions and compliance |
| `code-simplicity-reviewer` | Final pass for simplicity and minimalism |
| `data-integrity-guardian` | Database migrations and data integrity |
| `pattern-recognition-specialist` | Analyze code for patterns and anti-patterns |
| `performance-oracle` | Performance analysis and optimization |
| `security-sentinel` | Security audits and vulnerability assessments |

### Research (4)

| Agent | Description |
|-------|-------------|
| `best-practices-researcher` | Gather external best practices and examples |
| `framework-docs-researcher` | Research framework documentation and best practices |
| `git-history-analyzer` | Analyze git history and code evolution |
| `repo-research-analyst` | Research repository structure and conventions |

### Design (3)

| Agent | Description |
|-------|-------------|
| `design-implementation-reviewer` | Verify UI implementations match Figma designs |
| `design-iterator` | Iteratively refine UI through systematic design iterations |
| `figma-design-sync` | Synchronize web implementations with Figma designs |

### Workflow (4)

| Agent | Description |
|-------|-------------|
| `bug-reproduction-validator` | Systematically reproduce and validate bug reports |
| `lint` | Run linting and code quality checks |
| `pr-comment-resolver` | Address PR comments and implement fixes |
| `spec-flow-analyzer` | Analyze user flows and identify gaps in specifications |

## Commands

### Workflow Commands

Core workflow commands (use the short form for autocomplete):

| Command | Description |
|---------|-------------|
| `/plan` | Create implementation plans |
| `/review` | Run comprehensive code reviews |
| `/work` | Execute work items systematically |
| `/compound` | Document solved problems to compound team knowledge |

### Utility Commands

| Command | Description |
|---------|-------------|
| `/changelog` | Create engaging changelogs for recent merges |
| `/create-agent-skill` | Create or edit Claude Code skills |
| `/generate_command` | Generate new slash commands |
| `/heal-skill` | Fix skill documentation issues |
| `/plan_review` | Multi-agent plan review in parallel |
| `/prime` | Prime/setup command |
| `/report-bug` | Report a bug in the plugin |
| `/reproduce-bug` | Reproduce bugs using logs and console |
| `/resolve_parallel` | Resolve TODO comments in parallel |
| `/resolve_pr_parallel` | Resolve PR comments in parallel |
| `/triage` | Triage and prioritize issues |

## Skills

### Drupal Development

| Skill | Description |
|-------|-------------|
| `drupal-at-your-fingertips` | Comprehensive Drupal patterns from Selwyn Polit's d9book (50+ topics) |
| `drupal-config-mgmt` | Configuration management best practices |
| `drupal-contrib-mgmt` | Contrib module management and patching |
| `drupal-ddev` | DDEV integration and workflows |
| `ivangrynenko-cursorrules-drupal` | Drupal security guidelines (OWASP-based) |

### Development Tools

| Skill | Description |
|-------|-------------|
| `compound-docs` | Capture solved problems as categorized documentation |
| `create-agent-skills` | Expert guidance for creating Claude Code skills |
| `frontend-design` | Create production-grade frontend interfaces |
| `skill-creator` | Guide for creating effective Claude Code skills |

### Workflow

| Skill | Description |
|-------|-------------|
| `file-todos` | File-based todo tracking system |
| `git-worktree` | Manage Git worktrees for parallel development |

## MCP Servers

| Server | Description |
|--------|-------------|
| `playwright` | Browser automation via `@playwright/mcp` |
| `context7` | Framework documentation lookup via Context7 |

### Playwright

**Tools provided:**
- `browser_navigate` - Navigate to URLs
- `browser_take_screenshot` - Take screenshots
- `browser_click` - Click elements
- `browser_fill_form` - Fill form fields
- `browser_snapshot` - Get accessibility snapshot
- `browser_evaluate` - Execute JavaScript

### Context7

**Tools provided:**
- `resolve-library-id` - Find library ID for a framework/package
- `get-library-docs` - Get documentation for a specific library

Supports Drupal, PHP, Tailwind, and 100+ other frameworks.

MCP servers start automatically when the plugin is enabled.

## Usage with adesso CMS

This plugin is optimized for the adesso CMS tech stack:

```bash
# Start development
ddev start
ddev theme dev          # Vite HMR
ddev theme storybook    # Storybook

# Review workflow
/review                 # Multi-agent code review
/plan                   # Create implementation plan
/work                   # Execute work items

# Drupal-specific
# Uses drupal-at-your-fingertips skill for patterns
# Uses drupal-config-mgmt for CMI workflows
# Uses composer-dependency-reviewer for contrib
```

### Recommended Review Combinations

**Drupal Module PR:**
```
@drupal-reviewer
@security-sentinel
@test-coverage-reviewer
@composer-dependency-reviewer
```

**Drupal Theme PR:**
```
@drupal-theme-reviewer
@twig-template-reviewer
@tailwind-reviewer
@accessibility-reviewer
@storybook-reviewer
```

**Security Fix:**
```
@security-sentinel
@test-coverage-reviewer
@data-integrity-guardian
```

## Installation

This plugin is bundled with the adesso CMS project in `.claude/plugins/adessocms-engineering/`.

To use standalone:

```bash
# Clone to your project
mkdir -p .claude/plugins
git clone https://github.com/adesso/adessocms-engineering .claude/plugins/adessocms-engineering
```

## Known Issues

### MCP Servers Not Auto-Loading

**Workaround:** Add to your project's `.claude/settings.json`:

```json
{
  "mcpServers": {
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"],
      "env": {}
    },
    "context7": {
      "type": "http",
      "url": "https://mcp.context7.com/mcp"
    }
  }
}
```

## Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

## Acknowledgments

- Based on [compound-engineering](https://github.com/EveryInc/every-marketplace) by Kieran Klaassen and Every.to
- Drupal skills from [drupal-claude-skills](https://github.com/grasmash/drupal-claude-skills) by Matthew Grasmick

## License

MIT
