# adesso-engineering Plugin

Drupal 11 engineering tools for adesso SE. AI-powered development tools optimized for Drupal, DDEV, and enterprise CMS development.

## Components

| Component | Count |
|-----------|-------|
| Agents | 38 |
| Commands | 32 |
| Skills | 18 |
| MCP Servers | 3 |

## Agents

Agents are organized into categories for easier discovery.

### Core (6)

| Agent | Description |
|-------|-------------|
| `frontend-engineer` | Coordinate frontend changes across SDC, Twig, Tailwind |
| `librarian` | External research and documentation lookup |
| `document-writer` | Technical documentation generation |
| `reviewer-selector` | Dynamic reviewer selection based on changes |
| `skill-invoker` | Auto-invoke skills based on file types |
| `gemini-frontend` | Frontend code generation with Gemini |

### Specialists (17)

#### Core Drupal
| Agent | Description |
|-------|-------------|
| `drupal-specialist` | Entities, API, DI patterns, Drupal core |
| `drupal-theme-specialist` | Theme architecture and hook system |
| `paragraphs-specialist` | Paragraphs module patterns and SDC integration |

#### Frontend
| Agent | Description |
|-------|-------------|
| `twig-specialist` | Template patterns and best practices |
| `sdc-specialist` | Single Directory Components architecture |
| `tailwind-specialist` | Tailwind CSS v4, @theme, responsive patterns |
| `storybook-specialist` | Component story patterns and documentation |

#### Quality
| Agent | Description |
|-------|-------------|
| `accessibility-specialist` | WCAG 2.1 Level AA compliance |
| `test-coverage-specialist` | PHPUnit, Kernel, Functional, Playwright tests |

#### Architecture
| Agent | Description |
|-------|-------------|
| `component-reuse-specialist` | DRY principles, atomic design |
| `architecture-strategist` | Architectural decisions and compliance |
| `agent-native-reviewer` | Verify features are agent-native |

#### Data & Infrastructure
| Agent | Description |
|-------|-------------|
| `composer-specialist` | Drupal contrib packages and Composer patterns |
| `data-integrity-guardian` | Database migrations and data integrity |

#### Security & Performance
| Agent | Description |
|-------|-------------|
| `security-sentinel` | Security audits, OWASP compliance |
| `performance-oracle` | Performance analysis and optimization |

#### Design
| Agent | Description |
|-------|-------------|
| `design-system-guardian` | Design tokens and system consistency |

### Review (4)

| Agent | Description |
|-------|-------------|
| `code-simplicity-reviewer` | Final pass for simplicity and minimalism |
| `data-migration-expert` | Validate data migrations and mappings |
| `deployment-verification-agent` | Create Go/No-Go deployment checklists |
| `pattern-recognition-specialist` | Analyze code for patterns and anti-patterns |

### Research (4)

| Agent | Description |
|-------|-------------|
| `best-practices-researcher` | Gather external best practices and examples |
| `framework-docs-researcher` | Research framework documentation |
| `git-history-analyzer` | Analyze git history and code evolution |
| `repo-research-analyst` | Research repository structure and conventions |

### Design (3)

| Agent | Description |
|-------|-------------|
| `design-implementation-reviewer` | Verify UI implementations match designs |
| `design-iterator` | Iteratively refine UI through systematic iterations |
| `figma-design-sync` | Synchronize web implementations with Figma |

### Workflow (4)

| Agent | Description |
|-------|-------------|
| `bug-reproduction-validator` | Systematically reproduce and validate bug reports |
| `lint` | Run linting and code quality checks |
| `pr-comment-resolver` | Address PR comments and implement fixes |
| `spec-flow-analyzer` | Analyze user flows and identify spec gaps |

## Commands

### Workflow Commands

Core workflow commands use `workflows:` prefix:

| Command | Description |
|---------|-------------|
| `/workflows:plan` | Create implementation plans |
| `/workflows:review` | Run comprehensive code reviews |
| `/workflows:work` | Execute work items systematically |
| `/workflows:compound` | Document solved problems |

### Drupal-Specific Commands

| Command | Description |
|---------|-------------|
| `/init` | Initialize Drupal project with DDEV |
| `/spec` | Interview-based specification creation |
| `/prime` | Prepare context for development |
| `/playwright-test` | Run Playwright E2E tests |
| `/create-drupal-case-study` | Generate Drupal case studies |
| `/plan-from-jira` | Create plans from Jira tickets |

### Utility Commands

| Command | Description |
|---------|-------------|
| `/lfg` | Full autonomous workflow (plan → work → review → PR) |
| `/deepen-plan` | Enhance plans with parallel research |
| `/changelog` | Create engaging changelogs |
| `/create-agent-skill` | Create or edit Claude Code skills |
| `/generate-command` | Generate new slash commands |
| `/heal-skill` | Fix skill documentation issues |
| `/report-bug` | Report a bug in the plugin |
| `/reproduce-bug` | Reproduce bugs using logs |
| `/resolve-parallel` | Resolve TODO comments in parallel |
| `/resolve-pr-parallel` | Resolve PR comments in parallel |
| `/resolve-todo-parallel` | Resolve todos in parallel |
| `/triage` | Triage and prioritize issues |
| `/feature-video` | Record video walkthroughs |

### Image Generation Commands

| Command | Description |
|---------|-------------|
| `/generate-flat-illustration` | Flat illustration style |
| `/generate-gradient-mesh` | Gradient mesh style |
| `/generate-isometric-3d` | Isometric 3D style |
| `/generate-line-art` | Line art style |
| `/generate-realistic-photo` | Realistic photo style |
| `/generate-watercolor` | Watercolor style |
| `/generate-user-handbook` | Generate user handbook documentation |

## Skills

### Meta-Skills (Domain Expertise)

| Skill | Description | Files |
|-------|-------------|-------|
| `adessocms-frontend` | SDC, Tailwind v4, Twig, Alpine.js patterns | 15 |
| `drupal-backend` | Entities, Services, Plugins, Config, Migrations | 20 |
| `devops` | DDEV, Composer, CI/CD, Docker | 9 |
| `github` | gh CLI, PRs, Actions | 8 |
| `gitlab` | glab CLI, MRs, Pipelines | 8 |

### Specialized Skills

| Skill | Description |
|-------|-------------|
| `adesso-styleguide` | adesso corporate design compliance |
| `ivangrynenko-cursorrules-drupal` | Drupal security patterns (OWASP) |
| `create-drupal-case-study` | Drupal.org case study generation |
| `landing-page-optimizer` | AIDA framework conversion patterns |
| `plan-from-jira` | Jira ticket integration |
| `project-ownership` | Product ownership patterns |
| `skill-guardian` | Skill governance and auditing |
| `generate-user-handbook` | User documentation generation |

### Utility Skills

| Skill | Description |
|-------|-------------|
| `agent-native-architecture` | AI agent prompt-native architecture |
| `compound-docs` | Capture solved problems as documentation |
| `create-agent-skills` | Expert guidance for creating skills |
| `file-todos` | File-based todo tracking system |
| `gemini-imagegen` | Generate and edit images with Gemini |

## MCP Servers

| Server | Description |
|--------|-------------|
| `context7` | Framework documentation lookup (100+ frameworks) |
| `exa` | AI-powered web search for Drupal research |
| `grep` | GitHub code search for module examples |

### Setup

MCP servers require environment variables:

```bash
# For exa server
export EXA_API_KEY="your-api-key"

# For Gemini image generation
export GEMINI_API_KEY="your-api-key"
```

## Installation

```bash
claude /plugin install adesso-engineering
```

### Manual MCP Server Setup

If MCP servers don't auto-load, add to `.claude/settings.json`:

```json
{
  "mcpServers": {
    "context7": {
      "type": "http",
      "url": "https://mcp.context7.com/mcp"
    },
    "tailwindplus": {
      "type": "http",
      "url": "https://tailwindui-for-context.vercel.app/mcp"
    }
  }
}
```

## Workflow

```
/workflows:plan     → Research + structured planning
      ↓
/deepen-plan        → Add implementation details (optional)
      ↓
/workflows:work     → TodoWrite-driven implementation
      ↓
/workflows:review   → Parallel specialist review
      ↓
/workflows:compound → Document learnings
```

### Full Autonomous (/lfg)

```bash
/lfg "Implement user profile page with avatar upload"
```

Executes complete workflow: plan → work → review → tests → PR

## Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

## License

MIT

## Author

Marc Philipps (@marcphilipps)
Solutions Lead Drupal @ adesso SE
https://www.drupal.org/u/philipps
