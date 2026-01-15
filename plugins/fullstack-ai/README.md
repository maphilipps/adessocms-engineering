# fullstack-ai Plugin

AI-powered development tools for the Next.js / ShadCN / AI SDK stack. Build modern AI-powered web applications with comprehensive tooling.

## Tech Stack

- **Next.js 15** with App Router
- **React 19** with Server Components
- **ShadCN UI** for component library
- **Tailwind CSS** for styling
- **AI SDK** (Vercel) for AI features
- **AI Elements** for chat interfaces
- **TypeScript** for type safety

## Components

| Component | Count |
|-----------|-------|
| Agents | 23 |
| Commands | 23 |
| Skills | 14 |
| MCP Servers | 6 |

## MCP Servers

| Server | Description |
|--------|-------------|
| `ai-elements` | AI SDK component docs and examples |
| `shadcn` | ShadCN UI component management |
| `agent-browser` | Browser automation (Vercel) |
| `next-devtools` | Next.js dev server integration |
| `chrome-devtools` | Chrome debugging and performance |
| `context7` | Library documentation lookup |

## Agents

### Review (12)

| Agent | Description |
|-------|-------------|
| `agent-native-reviewer` | Verify features are agent-native (action + context parity) |
| `architecture-strategist` | Analyze architectural decisions and compliance |
| `code-simplicity-reviewer` | Final pass for simplicity and minimalism |
| `data-integrity-guardian` | Database migrations and data integrity |
| `data-migration-expert` | Validate ID mappings and data correctness |
| `deployment-verification-agent` | Create deployment checklists |
| `kieran-typescript-reviewer` | TypeScript code review with strict conventions |
| `julik-frontend-races-reviewer` | Review JavaScript for race conditions |
| `nextjs-reviewer` | Next.js App Router patterns and best practices |
| `pattern-recognition-specialist` | Analyze code for patterns and anti-patterns |
| `performance-oracle` | Performance analysis and optimization |
| `security-sentinel` | Security audits and vulnerability assessments |

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
| `design-iterator` | Iteratively refine UI through design iterations |
| `figma-design-sync` | Synchronize implementations with Figma designs |

### Workflow (4)

| Agent | Description |
|-------|-------------|
| `bug-reproduction-validator` | Reproduce and validate bug reports |
| `lint` | Run linting and code quality checks |
| `pr-comment-resolver` | Address PR comments and implement fixes |
| `spec-flow-analyzer` | Analyze user flows and identify gaps |

## Commands

### Workflow Commands

Core workflow commands use `workflows:` prefix:

| Command | Description |
|---------|-------------|
| `/workflows:plan` | Create implementation plans |
| `/workflows:review` | Run comprehensive code reviews |
| `/workflows:work` | Execute work items systematically |
| `/workflows:compound` | Document solved problems |

### Autonomous Workflow

| Command | Description |
|---------|-------------|
| `/lfg` | Full autonomous workflow (plan → work → review → done) |

### Utility Commands

| Command | Description |
|---------|-------------|
| `/changelog` | Create engaging changelogs |
| `/create-agent-skill` | Create or edit Claude Code skills |
| `/generate_command` | Generate new slash commands |
| `/plan_review` | Multi-agent plan review in parallel |
| `/report-bug` | Report a bug in the plugin |
| `/reproduce-bug` | Reproduce bugs using logs and console |
| `/resolve_parallel` | Resolve TODO comments in parallel |
| `/resolve_pr_parallel` | Resolve PR comments in parallel |
| `/resolve_todo_parallel` | Resolve todos in parallel |
| `/triage` | Triage and prioritize issues |
| `/test-browser` | Run browser tests on PR-affected pages |
| `/agent-native-audit` | Audit codebase for agent-native compliance |

## Skills

### Next.js & React

| Skill | Description |
|-------|-------------|
| `nextjs-frontend` | Next.js App Router, Server Components, ShadCN, Tailwind |
| `frontend-design` | Create production-grade frontend interfaces |

### AI Development

| Skill | Description |
|-------|-------------|
| `ai-backend` | AI SDK backend integration (streaming, tools, RAG) |
| `ai-elements` | Vercel AI Elements for chat interfaces |

### Architecture & Design

| Skill | Description |
|-------|-------------|
| `agent-native-architecture` | Build AI agents using prompt-native architecture |
| `create-agent-skills` | Expert guidance for creating Claude Code skills |
| `skill-creator` | Guide for creating effective Claude Code skills |

### Developer Tools

| Skill | Description |
|-------|-------------|
| `github` | GitHub CLI for PRs, issues, actions, releases |
| `compound-docs` | Capture solved problems as documentation |
| `file-todos` | File-based todo tracking system |
| `git-worktree` | Manage Git worktrees for parallel development |

### Browser & Media

| Skill | Description |
|-------|-------------|
| `agent-browser` | Browser automation using Vercel's agent-browser |
| `gemini-imagegen` | Generate and edit images using Gemini API |
| `rclone` | Upload files to cloud storage |

## Installation

```bash
claude /plugin install fullstack-ai
```

## Quick Start

### Full Autonomous Workflow

```bash
/lfg "Add a chat interface with AI streaming"
```

This runs: plan → work → review → resolve todos → test → done

### Manual Workflow

```bash
/workflows:plan "Feature description"
/workflows:work
/workflows:review
/workflows:compound
```

## Agent-Native Architecture

This plugin enforces **agent-native principles**:

1. **Action Parity**: Every UI action has an API/tool equivalent
2. **Context Parity**: Agents see the same data users see
3. **Shared Workspace**: Agents and users work in same data space
4. **Primitives over Workflows**: Tools are atomic, not encoded logic
5. **Dynamic Context Injection**: System prompts include runtime state

Use `/agent-native-audit` to verify compliance.

## Configuration

MCP servers start automatically when the plugin is enabled. For manual configuration:

```json
{
  "mcpServers": {
    "ai-elements": {
      "type": "http",
      "url": "https://registry.ai-sdk.dev/api/mcp"
    },
    "shadcn": {
      "type": "stdio",
      "command": "npx",
      "args": ["shadcn@latest", "mcp"]
    },
    "next-devtools": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "next-devtools-mcp@latest"]
    },
    "chrome-devtools": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"]
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

## License

MIT
