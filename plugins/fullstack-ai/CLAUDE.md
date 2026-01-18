# fullstack-ai Plugin Development

## Tech Stack

- **Next.js 15** with App Router
- **React 19** with Server Components
- **ShadCN UI** for component library
- **Tailwind CSS** for styling
- **AI SDK** (Vercel) for AI features
- **AI Elements** for chat interfaces
- **TypeScript** for type safety

## MCP Servers (6)

| MCP Server | Purpose |
|------------|---------|
| `ai-elements` | AI SDK component docs and examples |
| `shadcn` | ShadCN UI component management |
| `agent-browser` | Browser automation (Vercel) |
| `next-devtools` | Next.js dev server integration |
| `chrome-devtools` | Chrome debugging and performance |
| `context7` | Library documentation |

## Versioning Requirements

**IMPORTANT**: Every change to this plugin MUST include updates to all three files:

1. **`.claude-plugin/plugin.json`** - Bump version using semver
2. **`CHANGELOG.md`** - Document changes using Keep a Changelog format
3. **`README.md`** - Verify/update component counts and tables

### Version Bumping Rules

- **MAJOR** (1.0.0 → 2.0.0): Breaking changes, major reorganization
- **MINOR** (1.0.0 → 1.1.0): New agents, commands, or skills
- **PATCH** (1.0.0 → 1.0.1): Bug fixes, doc updates, minor improvements

### Pre-Commit Checklist

Before committing ANY changes:

- [ ] Version bumped in `.claude-plugin/plugin.json`
- [ ] CHANGELOG.md updated with changes
- [ ] README.md component counts verified
- [ ] README.md tables accurate (agents, commands, skills)
- [ ] plugin.json description matches current counts

## Directory Structure

```
agents/
├── review/     # Code review agents (nextjs-reviewer, kieran-typescript-reviewer, etc.)
├── research/   # Research and analysis agents
├── design/     # Design and UI agents
├── workflow/   # Workflow automation agents
└── docs/       # Documentation agents

commands/
├── workflows/  # Core workflow commands (plan, review, work, compound)
└── *.md        # Utility commands

skills/
├── nextjs-frontend/       # Next.js App Router patterns
├── ai-backend/            # AI SDK backend integration
├── ai-elements/           # Vercel AI Elements components
├── github/                # GitHub CLI and workflows
├── agent-native-architecture/  # Agent-native design patterns
├── agent-browser/         # Browser automation
├── compound-docs/         # Knowledge documentation
├── file-todos/            # File-based todo tracking
├── git-worktree/          # Git worktree management
└── */                     # Other skills
```

## Core Workflow

```
/workflows:plan     # Research + structured planning
      ↓
/workflows:work     # TodoWrite-driven implementation
      ↓
/workflows:review   # Parallel specialist review (agent-native-reviewer MANDATORY)
      ↓
/workflows:compound # Document learnings
```

## Full Autonomous (/lfg)

Complete workflow from idea to completion:
```
/lfg "Feature description"
  → /workflows:plan → /workflows:work → /workflows:review
  → /resolve-todo-parallel → /test-browser → DONE
```

Requires `ralph-loop` plugin for autonomous execution.

## Auto-Invoke Rules (MANDATORY)

### During Implementation (/work)

When working on features, Claude MUST invoke skills based on file types:

```
.tsx, .ts (pages/components) → Skill(skill: "nextjs-frontend")
.ts (API routes, actions)    → Skill(skill: "ai-backend")
AI chat components           → Skill(skill: "ai-elements")
GitHub PR/Actions            → Skill(skill: "github")
```

### Specialist Usage during Implementation

| Change Type | Specialists |
|-------------|-------------|
| React Components | `kieran-typescript-reviewer` |
| Next.js Pages/Routes | `nextjs-reviewer` |
| API Routes | `security-sentinel`, `performance-oracle` |
| Database/Migrations | `data-integrity-guardian` |
| Architecture | `architecture-strategist` |
| **Before every commit** | `code-simplicity-reviewer` |

### During Review (/review)

**MANDATORY**: Always include `agent-native-reviewer` in every review.

| File Pattern | Specialists to Invoke |
|--------------|----------------------|
| `.tsx`, `.ts` | `kieran-typescript-reviewer`, `nextjs-reviewer`, `julik-frontend-races-reviewer` |
| API routes | `security-sentinel` |
| All changes | `agent-native-reviewer`, `architecture-strategist` |

**Launch specialists IN PARALLEL** using multiple Task tool calls in a single message.

## Agent-Native Architecture (Critical)

This plugin enforces **agent-native principles**:

1. **Action Parity**: Every UI action has an API/tool equivalent
2. **Context Parity**: Agents see the same data users see
3. **Shared Workspace**: Agents and users work in same data space
4. **Primitives over Workflows**: Tools are atomic, not encoded logic
5. **Dynamic Context Injection**: System prompts include runtime state

Use `agent-native-reviewer` agent for architecture audits.

## code-simplicity-reviewer (MANDATORY)

After completing ANY implementation task, Claude MUST automatically invoke
the code-simplicity-reviewer agent to ensure code is minimal and simple.

**This applies to:**
- After /work completes a feature
- After any significant code changes (5+ lines)
- Before committing changes

**Invoke with:** `Task(subagent_type: "code-simplicity-reviewer", prompt: "Review and simplify the changes I just made")`

**This is MANDATORY, not optional. No exceptions.**

## Command Naming Convention

**Workflow commands** use `workflows:` prefix:
- `/workflows:plan` - Create implementation plans
- `/workflows:review` - Run comprehensive code reviews
- `/workflows:work` - Execute work items systematically
- `/workflows:compound` - Document solved problems

## Skill Compliance Checklist

When adding or modifying skills:

### YAML Frontmatter (Required)

- [ ] `name:` present and matches directory name
- [ ] `description:` present and uses **third person**

### Reference Links (Required if references/ exists)

- [ ] All files in `references/` are linked as `[filename.md](./references/filename.md)`
- [ ] Use proper markdown links, not bare backticks
