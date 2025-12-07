# adessocms-engineering Plugin

AI-powered Drupal development tools that get smarter with every use. Specialized for Drupal 11, Twig, Tailwind CSS v4, and Single Directory Components.

Based on [compound-engineering](https://github.com/EveryInc/compound-engineering-plugin) philosophy: make each unit of engineering work easier than the last.

## Installation

### Step 1: Add the Marketplace

In Claude Code, run:

```
/plugin marketplace add maphilipps/adessocms-engineering
```

### Step 2: Install the Plugin

```
/plugin install adessocms-engineering
```

### Alternative: Manual Installation

```bash
# Clone to your global plugins directory (works for all projects)
mkdir -p ~/.claude/plugins
git clone https://github.com/maphilipps/adessocms-engineering.git ~/.claude/plugins/adessocms-engineering

# Or clone to a specific project
mkdir -p .claude/plugins
git clone https://github.com/maphilipps/adessocms-engineering.git .claude/plugins/adessocms-engineering
```

### Verify Installation

After installation, restart Claude Code. The plugin provides:

- **27 Agents** - Available via `@agent-name` in conversations
- **17 Commands** - Available via `/command-name`
- **10 Skills** - Available via `Skill` tool
- **2 MCP Servers** - Playwright + Context7 (auto-started)

## Components

| Component | Count |
|-----------|-------|
| Agents | 27 |
| Commands | 17 |
| Skills | 10 |
| MCP Servers | 2 |

## Agents

### Review (17)

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
| `lint` | Run linting and code quality checks (PHP, Twig, JS, CSS) |
| `pr-comment-resolver` | Address PR comments and implement fixes |
| `spec-flow-analyzer` | Analyze user flows and identify gaps in specifications |

## Commands

### Workflow Commands

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

MCP servers start automatically when the plugin is enabled.

## Usage Examples

### Code Review

```
/review
```

### Create Implementation Plan

```
/plan "Add new paragraph type for testimonials"
```

### Document a Solution

```
/compound
```

### Review Combinations

**Drupal Module PR:**
```
@drupal-reviewer @security-sentinel @test-coverage-reviewer @composer-dependency-reviewer
```

**Drupal Theme PR:**
```
@drupal-theme-reviewer @twig-template-reviewer @tailwind-reviewer @accessibility-reviewer @storybook-reviewer
```

## Requirements

- **Claude Code** CLI
- **Node.js 20+** (for MCP servers)
- **DDEV** (recommended for Drupal development)

## Troubleshooting

### MCP Servers Not Loading

Add to your project's `.claude/settings.json`:

```json
{
  "mcpServers": {
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"]
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

- Based on [compound-engineering](https://github.com/EveryInc/compound-engineering-plugin) by Kieran Klaassen and Every.to
- Drupal skills from [drupal-claude-skills](https://github.com/grasmash/drupal-claude-skills) by Matthew Grasmick

## License

MIT
