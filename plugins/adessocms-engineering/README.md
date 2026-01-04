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
- **29 Commands** - Available via `/command-name`
- **19 Skills** - Available via `Skill` tool
- **4 MCP Servers** - Engineering-KB, Context7, Exa, grep.app

**Required Dependency:** Install the `dev-browser` skill separately for browser automation (see Prerequisites below).

## Components

| Component | Count |
|-----------|-------|
| Agents | 33 |
| Commands | 29 |
| Skills | 19 |
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

### Workflow Commands

| Command | Description |
|---------|-------------|
| `/acms-spec` | Interview-driven specification creation (pre-planning) |
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
| `tailwindplus-sdc-builder` | Build SDC + Paragraphs from TailwindPlus templates (DRY-first) |
| `sdc-design-factory` | Create beautiful SDC components with design philosophy |
| `compound-docs` | Capture solved problems as categorized documentation |
| `create-agent-skills` | Expert guidance for creating Claude Code skills |
| `frontend-design` | Create production-grade frontend interfaces |
| `adesso-styleguide` | adesso Corporate Design compliance |
| `skill-creator` | Guide for creating effective Claude Code skills |
| `beads` | Cross-Session Task Tracking mit Beads CLI |

### Workflow

| Skill | Description |
|-------|-------------|
| `file-todos` | File-based todo tracking system |
| `git-worktree` | Manage Git worktrees for parallel development |
| `plan-from-jira` | Create implementation plans from Jira tickets |
| `project-ownership` | Product ownership patterns |
| `landing-page-optimizer` | Plan and optimize landing pages for conversion (AIDA framework) |

## MCP Servers

| Server | Description |
|--------|-------------|
| `context7` | Framework documentation lookup via Context7 |

MCP servers start automatically when the plugin is enabled.

## Prerequisites

### Beads CLI (Cross-Session Task Tracking)

Beads enables persistent task tracking across Claude sessions. Install the CLI:

```bash
# Option 1: npm (recommended)
npm install -g @beads/bd

# Option 2: Homebrew
brew install steveyegge/beads/bd

# Option 3: Go
go install github.com/steveyegge/beads/cmd/bd@latest
```

After installation, initialize in your project:
```bash
cd <project-root>
bd init
```

**Anthropic Best Practices (v1.37.0):**

The `/acms-work` workflow now implements patterns from [Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents):

- **Environment Init:** DDEV auto-starts if not running
- **Session Recovery:** PreCompact Hook exports state to `.beads/session-state.md`
- **Auto-Select:** Highest priority unblocked task is auto-selected
- **Quality Gates:** Mandatory browser verification for UI-Tasks (via webapp-testing)

### webapp-testing Skill

Required for UI verification in Quality Gates. Install from the claude-plugins marketplace:

```bash
/plugin marketplace add claude-plugins-official
```

The `/acms-work` workflow uses webapp-testing for:
- **Mandatory UI Verification:** Screenshot evidence before closing UI-Tasks
- Playwright-based E2E testing
- Visual regression checks

### dev-browser Skill

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
