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

- **28 Agents** - Available via `@agent-name` in conversations
- **21 Commands** - Available via `/command-name`
- **16 Skills** - Available via `Skill` tool
- **1 MCP Server** - Context7 (auto-started)

**Required Dependency:** Install the `dev-browser` skill separately for browser automation (see Prerequisites below).

## Components

| Component | Count |
|-----------|-------|
| Agents | 28 |
| Commands | 21 |
| Skills | 16 |
| MCP Servers | 1 |

## Model Tier Strategy

**Intelligent model tiers (like EveryInc).**

| Model | Use Case | Agents |
|-------|----------|--------|
| *(none)* | Critical analysis, design review - uses session model | 8 agents |
| **sonnet** | Standard reviews, external research | 14 agents |
| **haiku** | Local research, simple tasks, CLI | 6 agents |

**No model field (inherits session):** `security-sentinel`, `architecture-strategist`, `performance-oracle`, `dries-drupal-reviewer`, `pattern-recognition-specialist`, `bug-reproduction-validator`, `design-implementation-reviewer`, `design-iterator`

**Haiku:** `lint`, `composer-dependency-reviewer`, `git-history-analyzer`, `repo-research-analyst`, `gemini-brainstorm`, `gemini-reviewer`

## Agents

### Review (17)

| Agent | Model | Description |
|-------|-------|-------------|
| `drupal-reviewer` | sonnet | Drupal coding standards, API usage, and best practices |
| `dries-drupal-reviewer` | - | Brutally honest Drupal review from Dries Buytaert's perspective |
| `twig-template-reviewer` | sonnet | Twig templates, security, Drupal patterns, SDC |
| `drupal-theme-reviewer` | sonnet | Theme implementations, SDC, preprocess functions, libraries |
| `tailwind-reviewer` | sonnet | Tailwind CSS v4 syntax, Vite integration, Drupal theming |
| `storybook-reviewer` | sonnet | Storybook stories, SDC integration, interaction tests |
| `accessibility-reviewer` | sonnet | WCAG 2.1 Level AA, ARIA, semantic HTML, keyboard nav |
| `composer-dependency-reviewer` | haiku | Composer dependencies, security, Drupal contrib |
| `test-coverage-reviewer` | sonnet | PHPUnit, Kernel, Functional, Playwright, Vitest coverage |
| `architecture-strategist` | - | Analyze architectural decisions and compliance |
| `code-simplicity-reviewer` | sonnet | Final pass for simplicity and minimalism |
| `data-integrity-guardian` | sonnet | Database migrations and data integrity |
| `pattern-recognition-specialist` | - | Analyze code for patterns and anti-patterns |
| `performance-oracle` | - | Performance analysis and optimization |
| `security-sentinel` | - | Security audits and vulnerability assessments |
| `gemini-reviewer` | haiku | Cross-check findings with Gemini (optional) |

### Research (5)

| Agent | Model | Description |
|-------|-------|-------------|
| `best-practices-researcher` | sonnet | Gather external best practices and examples |
| `framework-docs-researcher` | sonnet | Research framework documentation and best practices |
| `git-history-analyzer` | haiku | Analyze git history and code evolution |
| `repo-research-analyst` | haiku | Research repository structure and conventions |
| `gemini-brainstorm` | haiku | Architecture brainstorming with Gemini (optional) |

### Design (3)

| Agent | Model | Description |
|-------|-------|-------------|
| `design-implementation-reviewer` | - | Verify UI implementations match Figma designs |
| `design-iterator` | - | Iteratively refine UI through systematic design iterations |
| `figma-design-sync` | sonnet | Synchronize web implementations with Figma designs |

### Workflow (4)

| Agent | Model | Description |
|-------|-------|-------------|
| `acms-bug-reproduction-validator` | - | Systematically reproduce and validate bug reports |
| `acms-lint` | haiku | Run linting and code quality checks (PHP, Twig, JS, CSS) |
| `acms-pr-comment-resolver` | sonnet | Address PR comments and implement fixes |
| `acms-spec-flow-analyzer` | sonnet | Analyze user flows and identify gaps in specifications |

## Commands

### Workflow Commands

| Command | Description |
|---------|-------------|
| `/acms-plan` | Create implementation plans (parallel research agents) |
| `/acms-review` | Run comprehensive code reviews (~15 parallel agents) |
| `/acms-work` | Execute work items systematically (TodoWrite tracking) |
| `/acms-compound` | Document solved problems to compound team knowledge |

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
| `/plan-from-jira` | Create plan from Jira ticket |

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
| `adesso-styleguide` | adesso Corporate Design compliance |
| `skill-creator` | Guide for creating effective Claude Code skills |

### Workflow

| Skill | Description |
|-------|-------------|
| `file-todos` | File-based todo tracking system |
| `git-worktree` | Manage Git worktrees for parallel development |
| `plan-from-jira` | Create implementation plans from Jira tickets |
| `project-ownership` | Product ownership patterns |

## Gemini Integration (Optional)

Gemini CLI integration is **optional and non-blocking**:

- `gemini-brainstorm` agent: Architecture brainstorming on request
- `gemini-reviewer` agent: Cross-check review findings on request

**Gemini is NOT required.** All workflows work without it.

```bash
# Check if Gemini is available
which gemini >/dev/null 2>&1 && echo "Gemini available" || echo "Gemini not installed"
```

## MCP Servers

| Server | Description |
|--------|-------------|
| `context7` | Framework documentation lookup via Context7 |

MCP servers start automatically when the plugin is enabled.

## Prerequisites: dev-browser Skill

This plugin relies on the `dev-browser` skill for browser automation (screenshots, form filling, UI testing). Install it from the dev-browser marketplace:

```bash
/plugin marketplace add SawyerHood/dev-browser
```

The `/plan` and `/review` workflows use dev-browser for:
- Taking screenshots of web pages
- Comparing designs between sites
- Extracting HTML structure via ARIA snapshots
- Testing UI interactions

**Usage in plans:**
```
Skill(skill="dev-browser")
```

## Usage Examples

### Code Review

```
/acms-review
```

Runs ~15 parallel agents with **model="sonnet"** for token efficiency.

### Create Implementation Plan

```
/acms-plan "Add new paragraph type for testimonials"
```

Runs 3 research agents in parallel, creates plan in `plans/` folder.

### Document a Solution

```
/acms-compound
```

Captures solved problems to `docs/solutions/` with YAML frontmatter.

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

### dev-browser Skill Not Working

1. Ensure you installed the dev-browser marketplace:
   ```bash
   /plugin marketplace add SawyerHood/dev-browser
   ```

2. Start the dev-browser server before using browser automation:
   ```bash
   ./skills/dev-browser/server.sh &
   ```

3. Wait for the "Ready" message before running scripts.

### Context7 MCP Not Loading

Add to your project's `.claude/settings.json`:

```json
{
  "mcpServers": {
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
