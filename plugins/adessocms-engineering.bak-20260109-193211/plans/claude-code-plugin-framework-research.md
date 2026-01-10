# Claude Code Plugin Framework Research Findings

## Executive Summary

This document provides comprehensive research on Claude Code's plugin framework, session persistence mechanisms, cross-session state management, file-based communication patterns, hooks/lifecycle events, agent orchestration patterns, and the Beads CLI tool.

---

## 1. Session Persistence Mechanisms

### SessionStart Hook with CLAUDE_ENV_FILE

The primary mechanism for session persistence is the `SessionStart` hook combined with the `CLAUDE_ENV_FILE` environment variable.

**Key Capabilities:**
- SessionStart hooks have access to `CLAUDE_ENV_FILE` - a file path where you can persist environment variables for subsequent bash commands
- Environment variables written to this file are available to all subsequent Bash tool invocations within the session
- Executes when Claude Code session begins - use for loading context and setting environment

**Example Pattern:**
```bash
#!/bin/bash
# SessionStart hook - persist environment
echo "PROJECT_STATE=active" >> "$CLAUDE_ENV_FILE"
echo "LAST_SESSION=$(date -Iseconds)" >> "$CLAUDE_ENV_FILE"
```

### SessionEnd for Cleanup and State Preservation

SessionEnd hooks execute when the session terminates, enabling:
- Cleanup of temporary resources
- Logging session activity
- State preservation for future sessions

**Source:** [Claude Code Hooks Reference](https://code.claude.com/docs/en/hooks)

---

## 2. Cross-Session State Management

### File-Based State with `.local.md` Pattern

Claude Code plugins use the `.local.md` convention for storing per-project, per-session state:

**File Location:** `.claude/<plugin-name>.local.md`

**Structure:**
```markdown
---
enabled: true
setting1: value1
numeric_setting: 42
list_setting: ["item1", "item2"]
---

# Additional Context

Task descriptions, instructions, or notes here.
```

**Benefits:**
- YAML frontmatter for structured configuration
- Markdown body for freeform context
- `.local.md` suffix signals these should be gitignored
- Hooks can read/write this state between sessions

### Pattern 2: Agent State Management

For multi-agent coordination, state files track:
- Agent name and identification
- Task numbers and PR references
- Coordinator session references
- Dependencies between tasks
- Enable/disable flags

**Example Agent State:**
```markdown
---
agent_name: auth-implementation
task_number: 3.5
pr_number: 1234
coordinator_session: team-leader
enabled: true
dependencies: ["Task 3.4"]
---

# Task: Implement Authentication
Build JWT-based authentication for the REST API.
```

**Source:** [Claude Code Plugin Settings](https://github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/plugin-settings/SKILL.md)

---

## 3. File-Based Communication Patterns

### Inter-Session Communication via State Files

Plugins communicate between sessions using the `.claude/` directory:

1. **Write state at session end** - SessionEnd hook writes current state
2. **Read state at session start** - SessionStart hook restores context
3. **Update during session** - Hooks update state files as work progresses

### Multi-Agent Communication via tmux

For real-time multi-agent coordination:

```bash
#!/bin/bash
# Send notification to coordinator session
NOTIFICATION="Agent ${AGENT_NAME} is idle."
if tmux has-session -t "$COORDINATOR_SESSION" 2>/dev/null; then
  tmux send-keys -t "$COORDINATOR_SESSION" "$NOTIFICATION" Enter
fi
```

### Workflow State Files

For complex workflows that span sessions:

```markdown
---
stage: deployment
started_at: "2025-01-02T10:00:00Z"
environment: staging
branch: feature/new-feature
tests_passed: true
---

# Deployment Workflow State

Current stage: deployment
Next action: Run integration tests
```

---

## 4. Hooks and Lifecycle Events

### All Eight Hook Events

| Event | When It Fires | Use Cases |
|-------|---------------|-----------|
| **SessionStart** | Session initialization | Load context, set environment |
| **SessionEnd** | Session termination | Cleanup, logging, state preservation |
| **UserPromptSubmit** | User submits prompt | Validation, security, logging |
| **PreToolUse** | Before tool execution | Verify standards, block dangerous ops |
| **PostToolUse** | After tool completion | Logging, notifications, state updates |
| **Stop** | Main agent finishes | Finalization, Ralph loop control |
| **SubagentStop** | Subagent completes | Coordination, result collection |
| **PreCompact** | Before context compaction | Save critical context |

### Hook Configuration

```json
{
  "hooks": {
    "SessionStart": [{
      "hooks": [{
        "type": "command",
        "command": "bash .claude/hooks/session-start.sh"
      }]
    }],
    "Stop": [{
      "matcher": ".*",
      "hooks": [{
        "type": "command",
        "command": "bash .claude/hooks/stop.sh",
        "timeout": 45
      }]
    }]
  }
}
```

### Cross-Event Workflows

Hooks can coordinate across events:
1. SessionStart sets up tracking
2. PreToolUse/PostToolUse record activity
3. Stop aggregates and persists state
4. Next SessionStart restores context

**Source:** [Claude Code Hooks Mastery](https://github.com/disler/claude-code-hooks-mastery)

---

## 5. Agent Orchestration Patterns

### Multi-Agent Swarm Coordination

Three coordination modes:

1. **Team Leader** - One agent orchestrates others
2. **Collaborative** - Peer coordination, shared responsibilities
3. **Autonomous** - Independent work, minimal coordination

### Task Tool for Subagent Orchestration

```json
{
  "subagent_type": "general-purpose",
  "description": "Analyze conversation for patterns",
  "prompt": "You are analyzing... [detailed instructions]"
}
```

### Dependency-Based Orchestration

Using state files to track dependencies:
```yaml
dependencies: ["Task 3.4", "Task 4.1"]
```

Agents wait until dependencies are complete before proceeding.

### Real-Time Notifications

Agents notify coordinators via tmux when:
- Tasks complete
- Blockers encountered
- Agents become idle

---

## 6. Beads (`bd`) CLI Tool

### Overview

Beads is a lightweight, Git-backed issue tracker designed for AI coding agents. It provides persistent task memory that survives context compaction.

**Key Insight:** Tasks created with `bd` persist even when conversation history is compacted.

**Source:** [Beads GitHub](https://github.com/steveyegge/beads)

### Core Commands

| Command | Purpose |
|---------|---------|
| `bd create "Task" -p 1` | Create task with priority |
| `bd ready` | List unblocked tasks |
| `bd update <id> --status in_progress` | Update status |
| `bd update <id> --notes "..."` | Add context notes |
| `bd close <id> --reason "..."` | Complete task |
| `bd sync` | Force git sync |
| `bd dep add <a> <b>` | Add dependency |
| `bd show <id>` | View task details |

### Hierarchical Task Management

Beads supports:
- **Epics** - High-level features
- **Tasks** - Individual work items
- **Convoys** - Release milestones that auto-complete

**Dependency Types:**
- `blocks` - Task A blocks Task B
- `parent-child` - Epic contains tasks
- `discovered-from` - New work from existing task
- `tracks` - Convoy tracks issues

### Cross-Session Persistence

**Session Handoff Workflow:**

```bash
# Session 1: Save context
bd update auth-task --notes "COMPLETED: JWT integrated
IN PROGRESS: Testing refresh
NEXT: Rate limiting"

# [Context compacted - history deleted]

# Session 2: Resume work
bd ready
bd show auth-task
# Agent continues exactly where it left off
```

**Notes Field Format:**
```
COMPLETED: [specific deliverables]
IN PROGRESS: [current state, next steps]
BLOCKERS: [obstacles]
KEY DECISIONS: [important context]
```

### Git Integration

- Issues stored in `.beads/issues.jsonl`
- Versioned, branched, merged like code
- Hash-based IDs (bd-a1b2) prevent merge collisions
- Automatic sync across machines via git

**Source:** [Beads Documentation](https://steve-yegge.medium.com/introducing-beads-a-coding-agent-memory-system-637d7d92514a)

---

## 7. Long-Running Tasks & Context Window Handling

### The Ralph Wiggum Technique

Ralph Wiggum is a technique for creating autonomous, iterative development loops.

**How It Works:**
1. Run `/ralph-loop "Task description" --completion-promise "DONE"`
2. Claude works on the task
3. Tries to exit
4. Stop hook blocks exit (exit code 2)
5. Same prompt is fed back
6. Loop continues until completion promise detected

**State Persistence:**
```bash
# .claude/ralph-loop.local.md
---
iteration: 1
max_iterations: 20
completion_promise: "DONE"
started_at: "2025-01-02T10:00:00Z"
---

Original task prompt here...
```

**Safety Features:**
- `--max-iterations` prevents infinite loops
- Completion promise detection
- Rate limiting (100 calls/hour)
- Circuit breaker for error detection

**Source:** [Ralph Wiggum Plugin](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum)

### Context Compaction Survival

When Claude's context window fills up, it compacts history. Survival strategies:

1. **Beads Notes** - Write critical context to `bd update --notes`
2. **State Files** - Persist to `.claude/*.local.md`
3. **PreCompact Hook** - Save context before compaction
4. **Git Commits** - Code changes survive compaction

### PreCompact Hook

```json
{
  "PreCompact": [{
    "hooks": [{
      "type": "command",
      "command": "bash .claude/hooks/save-context.sh"
    }]
  }]
}
```

---

## 8. Implementation Recommendations

### For Epic-Level Work (Multi-Session)

1. **Use Beads** for task tracking
   - Create epic with subtasks
   - Track dependencies
   - Use notes for context preservation

2. **State Files** for configuration
   - `.claude/workflow.local.md` for current state
   - YAML frontmatter for structured data

3. **Hooks** for automation
   - SessionStart: Restore context
   - Stop: Save progress
   - PreCompact: Preserve critical info

### For Long-Running Tasks (Single Session)

1. **Ralph Wiggum** for iteration
   - Set reasonable max iterations
   - Define clear completion promise
   - Include escape hatch instructions

2. **Regular State Updates**
   - Update Beads notes frequently
   - Commit code changes often
   - Write to state files at milestones

### For Multi-Agent Coordination

1. **Team Leader Pattern**
   - One coordinator agent
   - Worker agents report via tmux/state files
   - Dependency tracking via Beads or state

2. **File-Based Communication**
   - Each agent has its own `.local.md` state file
   - Coordinator monitors all state files
   - Updates trigger via hooks

---

## References

### Official Documentation
- [Claude Code Hooks Reference](https://code.claude.com/docs/en/hooks)
- [Claude Code Plugin Development](https://github.com/anthropics/claude-code/tree/main/plugins)
- [Hook Configuration Blog Post](https://claude.com/blog/how-to-configure-hooks)

### Tools & Plugins
- [Beads GitHub Repository](https://github.com/steveyegge/beads)
- [Claude Code Hooks Mastery](https://github.com/disler/claude-code-hooks-mastery)
- [Ralph Wiggum Plugin](https://github.com/anthropics/claude-code-official/tree/main/plugins/ralph-wiggum)

### Articles & Guides
- [Introducing Beads](https://steve-yegge.medium.com/introducing-beads-a-coding-agent-memory-system-637d7d92514a)
- [The Beads Revolution](https://steve-yegge.medium.com/the-beads-revolution-how-i-built-the-todo-system-that-ai-agents-actually-want-to-use-228a5f9be2a9)
- [Understanding Claude Code's Full Stack](https://alexop.dev/posts/understanding-claude-code-full-stack/)
- [Ralph Wiggum Autonomous Loops](https://paddo.dev/blog/ralph-wiggum-autonomous-loops/)
