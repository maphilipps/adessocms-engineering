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

- **33 Agents** - Available via `@agent-name` in conversations (DRY consolidated in v1.38.0)
- **31 Commands** - Available via `/command-name`
- **17 Skills** - Available via `Skill` tool (5 consolidated Meta-Skills + skill-guardian in v3.1.0)
- **4 MCP Servers** - Engineering-KB, Context7, Exa, grep.app

**Required Dependency:** Install the `dev-browser` skill separately for browser automation (see Prerequisites below).

## Components

| Component | Count |
|-----------|-------|
| Agents | 33 |
| Commands | 31 |
| Skills | 17 |
| MCP Servers | 4 |

## Model Tier Strategy

**Intelligent model tiers (like EveryInc).**

| Model | Use Case | Agents |
|-------|----------|--------|
| *(none)* | Critical analysis, design review - uses session model | 6 agents |
| **sonnet** | Standard reviews, external research | 21 agents |
| **haiku** | Local research, simple tasks | 5 agents |

**No model field (inherits session):** `security-sentinel`, `architecture-strategist`, `performance-oracle`, `acms-bug-reproduction-validator`, `design-implementation-reviewer`, `design-iterator`

**Haiku:** `acms-lint`, `composer-specialist`, `git-history-analyzer`, `repo-research-analyst`, `reviewer-selector`

## Agents

### Specialists (18) - Dual-Purpose Agents

**Specialists provide both implementation guidance AND code review.** Use them:
- **Before implementing**: Get correct patterns with `Task(subagent_type="...:specialists:drupal-specialist", prompt="How should I implement X?")`
- **After implementing**: Review code with `Task(subagent_type="...:specialists:drupal-specialist", prompt="Review: {changes}")`

| Agent | Model | Description |
|-------|-------|-------------|
| `drupal-specialist` | sonnet | Drupal coding standards, API usage, DI patterns, Entity Query |
| `twig-specialist` | sonnet | Twig templates, security, SDC embed patterns, attributes |
| `drupal-theme-specialist` | sonnet | Theme implementations, SDC, preprocess functions, libraries |
| `tailwind-specialist` | sonnet | Tailwind CSS v4 syntax, @theme, responsive patterns |
| `storybook-specialist` | sonnet | Storybook stories, SDC integration, interaction tests |
| `accessibility-specialist` | sonnet | WCAG 2.1 Level AA, ARIA, semantic HTML, keyboard nav |
| `composer-specialist` | haiku | Composer dependencies, security, Drupal contrib |
| `test-coverage-specialist` | sonnet | PHPUnit, Kernel, Functional, Playwright, Vitest coverage |
| `architecture-strategist` | - | Architectural decisions and compliance |
| `code-simplifier` | sonnet | Simplicity, YAGNI, pattern detection (consolidated) |
| `data-integrity-guardian` | sonnet | Database migrations and data integrity |
| `performance-oracle` | - | Performance analysis and optimization |
| `security-sentinel` | - | Security implementation and audits (OWASP) |
| `sdc-specialist` | sonnet | SDC props/slots, component.yml schema, cache patterns |
| `paragraphs-specialist` | sonnet | Field templates, SDC integration, cache metadata |
| `component-reuse-specialist` | sonnet | DRY principle, component reuse, atomic design |
| `agent-native-reviewer` | sonnet | Agent-native design, agent-user parity |
| `design-system-guardian` | sonnet | Design tokens, component discovery, reuse |

### Research (2)

| Agent | Model | Description |
|-------|-------|-------------|
| `git-history-analyzer` | haiku | Analyze git history and code evolution |
| `repo-research-analyst` | haiku | Research repository structure and conventions |

### Core (5)

| Agent | Model | Description |
|-------|-------|-------------|
| `librarian` | sonnet | External docs, framework research, best practices (consolidated) |
| `frontend-engineer` | sonnet | Visual changes, UI/UX, Tailwind, Alpine.js |
| `document-writer` | sonnet | README, API docs, user guides |
| `reviewer-selector` | haiku | Dynamic reviewer selection for plan review |
| `skill-invoker` | sonnet | Skill matching and invocation |

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

### Workflow Commands (Ralph Loop)

| Command | Description |
|---------|-------------|
| `/acms-refine` | Interview + Feature-List creation (was `/acms-spec`) |
| `/acms-work` | Ralph Loop - Work feature-by-feature from `feature-list.json` |
| `/acms-review` | Run comprehensive code reviews (~15 parallel agents) |
| `/acms-compound` | Document solved problems to compound team knowledge |

**New in v3.0.0:** Ralph Loop workflow based on Anthropic's Feature-List approach. See CLAUDE.md for detailed workflow.

### Utility Commands

| Command | Description |
|---------|-------------|
| `/changelog` | Create engaging changelogs for recent merges |
| `/create-agent-skill` | Create or edit Claude Code skills |
| `/generate_command` | Generate new slash commands |
| `/heal-skill` | Fix skill documentation issues |
| `/report-bug` | Report a bug in the plugin |
| `/reproduce-bug` | Reproduce bugs using logs and console |
| `/resolve_parallel` | Resolve TODO comments in parallel |
| `/resolve_pr_parallel` | Resolve PR comments in parallel |
| `/plan-from-jira` | Create plan from Jira ticket |

## Skills

### Consolidated Meta-Skills (v3.0.0)

**Domain Expertise Pattern:** Each Meta-Skill has `SKILL.md (router) → workflows/ → references/`

| Skill | Description | Files |
|-------|-------------|-------|
| `adessocms-frontend` | SDC, Tailwind v4, Twig, Alpine.js, Storybook | 15 files |
| `drupal-backend` | Entities, Services, Plugins, Config, Migration, Security | 20 files |
| `devops` | DDEV, Composer, Docker, CI/CD | 9 files |
| `gitlab` | glab CLI, MRs, Pipelines, Issues | 8 files |
| `github` | gh CLI, PRs, Actions, Issues | 8 files |

### Drupal Security

| Skill | Description |
|-------|-------------|
| `ivangrynenko-cursorrules-drupal` | Drupal security guidelines (OWASP-based) |

### Development Tools

| Skill | Description |
|-------|-------------|
| `compound-docs` | Capture solved problems as categorized documentation |
| `create-agent-skills` | Expert guidance for creating Claude Code skills |
| `adesso-styleguide` | adesso Corporate Design compliance |
| `gemini-imagegen` | Generate/edit images with Gemini API (text-to-image, editing, composition) |

### Workflow

| Skill | Description |
|-------|-------------|
| `file-todos` | File-based todo tracking system |
| `plan-from-jira` | Create implementation plans from Jira tickets |
| `project-ownership` | Product ownership patterns |
| `landing-page-optimizer` | Plan and optimize landing pages for conversion (AIDA framework) |
| `skill-guardian` | Skill quality governance, auditing, optimization, consistency enforcement |

## MCP Servers

| Server | Description |
|--------|-------------|
| `context7` | Framework documentation lookup via Context7 |

MCP servers start automatically when the plugin is enabled.

## Prerequisites

### webapp-testing Skill

Optional for UI verification. Install from the claude-plugins marketplace:

```bash
/plugin marketplace add claude-plugins-official
```

Use for:
- Playwright-based E2E testing
- Visual regression checks
- Screenshot evidence for UI changes

### dev-browser Skill

This plugin relies on the `dev-browser` skill for browser automation (screenshots, form filling, UI testing). Install it from the dev-browser marketplace:

```bash
/plugin marketplace add SawyerHood/dev-browser
```

Use dev-browser for:
- Taking screenshots of web pages
- Comparing designs between sites
- Extracting HTML structure via ARIA snapshots
- Testing UI interactions

**Usage in plans:**
```
Skill(skill="dev-browser")
```

## Usage Examples

### Full Workflow (Ralph Loop)

```bash
# 1. Create Feature-List
/acms-refine "Add new paragraph type for testimonials"

# 2. Work feature-by-feature (Ralph Loop)
/acms-work

# 3. Review code
/acms-review

# 4. Document learnings
/acms-compound
```

### Quick Actions

```bash
# Just review current changes
/acms-review

# Just document a solved problem
/acms-compound
```

### Specialist Combinations

**Drupal Module PR:**
```
@drupal-specialist @security-sentinel @test-coverage-specialist @composer-specialist
```

**Drupal Theme PR:**
```
@drupal-theme-specialist @twig-specialist @tailwind-specialist @accessibility-specialist @storybook-specialist
```

**SDC Components:**
```
@sdc-specialist @component-reuse-specialist @storybook-specialist @accessibility-specialist
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
