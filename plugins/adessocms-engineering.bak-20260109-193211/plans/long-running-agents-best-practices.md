# Long-Running AI Agents: Best Practices Research (2025)

**Research Date:** January 2, 2026
**Sources:** Anthropic Engineering, Claude Code Documentation, CrewAI, LangGraph, Academic Research
**Focus:** Practical implementation patterns for Claude Code plugins

---

## Executive Summary

This document synthesizes best practices for building long-running AI agents that maintain progress across multiple context windows. The research is based primarily on Anthropic's engineering posts and supplementary industry research from leading agent frameworks.

**Key Insight:** The core challenge is not context window size but **attention degradation**. Every token added to the context window competes for the model's attention, causing critical constraints to get buried under accumulated noise.

---

## Table of Contents

1. [The Two-Agent Architecture Pattern](#1-the-two-agent-architecture-pattern)
2. [Pre-Compaction Strategies](#2-pre-compaction-strategies)
3. [Feature List Patterns](#3-feature-list-patterns)
4. [Quality Gates for Autonomous Agents](#4-quality-gates-for-autonomous-agents)
5. [Session Handoff Patterns](#5-session-handoff-patterns)
6. [Progress Documentation Pattern](#6-progress-documentation-pattern)
7. [Init.sh Script Pattern](#7-initsh-script-pattern)
8. [End-to-End Testing Requirements](#8-end-to-end-testing-requirements)
9. [Common Failure Modes and Mitigations](#9-common-failure-modes-and-mitigations)
10. [Agent Framework Patterns](#10-agent-framework-patterns)
11. [Practical Implementation for Claude Code Plugins](#11-practical-implementation-for-claude-code-plugins)
12. [Summary and Sources](#12-summary-and-sources)

---

## 1. The Two-Agent Architecture Pattern

### Official Anthropic Pattern

**Source:** [Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)

Anthropic developed a two-fold solution to enable effective work across many context windows:

#### 1.1 Initializer Agent (First Session Only)

The initializer agent sets up the project environment with:

1. **init.sh script** - Development server launcher for quick verification
2. **claude-progress.txt** - Log of what agents have done
3. **feature_list.json** - Comprehensive feature requirements
4. **Initial git commit** - Clean baseline for future sessions

**Purpose:** Create all artifacts needed for future sessions to quickly reconstruct state.

#### 1.2 Coding Agent (All Subsequent Sessions)

Every subsequent session focuses on incremental progress with this workflow:

1. Run `pwd` to verify working directory
2. Read git logs and progress files to understand recent work
3. Review feature list for highest-priority incomplete item
4. Run init.sh and verify basic functionality
5. Implement ONE feature at a time
6. Test thoroughly before marking complete
7. Commit with descriptive messages
8. Update progress file

**Key Principle:** "Inspiration for these practices came from knowing what effective software engineers do every day."

```
┌──────────────────────────────────────────────────────┐
│                  INITIALIZER AGENT                    │
│  (Runs once on first session)                        │
│                                                       │
│  Creates:                                             │
│  ├── init.sh (dev server startup)                    │
│  ├── claude-progress.txt (state tracking)            │
│  ├── features.json (requirements)                    │
│  └── Initial git commit                              │
└──────────────────────────────────────────────────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────┐
│                   CODING AGENT                        │
│  (Runs in subsequent sessions)                       │
│                                                       │
│  Each session:                                        │
│  1. Read git logs + progress files                   │
│  2. Select highest-priority incomplete feature       │
│  3. Make incremental progress                        │
│  4. Commit with descriptive message                  │
│  5. Update progress file                             │
│  6. Leave clean state for next session               │
└──────────────────────────────────────────────────────┘
```

---

## 2. Pre-Compaction Strategies

### 2.1 Context Compaction Fundamentals

**Source:** [Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)

Context compaction is the practice of taking a conversation nearing the context window limit, summarizing its contents, and reinitiating with the summary. This is the first lever in context engineering for long-term coherence.

**Implementation Pattern:**

```python
# Claude Code's approach to compaction
def compact_context(message_history, recently_accessed_files):
    """
    Pass message history to model for summarization.
    Preserve:
    - Architectural decisions
    - Unresolved bugs
    - Implementation details
    Discard:
    - Redundant tool outputs
    - Completed intermediate steps
    """
    compressed = model.summarize(message_history)
    return compressed + recently_accessed_files[:5]
```

**Tuning Approach:**
1. Begin by maximizing recall to capture all relevant information
2. Iterate to eliminate superfluous content
3. Tool result clearing is the lightest-touch form of compaction

### 2.2 Pre-Compaction Preservation Strategies

**Before context limits are hit, proactively preserve:**

| Preservation Target | Storage Method | Priority |
|---------------------|----------------|----------|
| Architectural decisions | External file (CLAUDE.md, ADRs) | Critical |
| Current task state | Progress tracking file | Critical |
| Unresolved issues/bugs | Structured notes file | High |
| Entity relationships | Entity memory store | Medium |
| Tool execution history | Git commits with messages | Medium |

### 2.3 Memory Tool Implementation

**Source:** [Claude Developer Platform - Context Management](https://claude.com/blog/context-management)

The memory tool allows storing and retrieving information outside the active context window through a file-based system.

**Key Capabilities:**
- Create, read, update, and delete files in a dedicated memory directory
- Persists across conversations
- Stored in your infrastructure (developer-controlled)

**Performance Impact:**
- Memory tool + context editing: **39% improvement** over baseline
- Context editing alone: **29% improvement**
- Token consumption reduction: **84%** in extended workflows

### 2.4 Progressive Disclosure Pattern

**Source:** [Claude Code Plugin Development](https://github.com/anthropics/claude-code)

Skills use a three-level progressive disclosure loading system:

```
Level 1: Metadata (always loaded)
├── Name and description (~100 words)
├── Trigger conditions
└── Used for: Skill selection

Level 2: SKILL.md body (loaded when triggered)
├── Core instructions (<5k words)
├── Common workflows
└── Used for: Task execution

Level 3: Bundled resources (loaded on-demand)
├── Reference documentation
├── Code examples
└── Scripts (executed without reading into context)
```

### 2.5 Just-In-Time Context Loading

**Pattern:** Maintain lightweight identifiers (file paths, stored queries, web links) and dynamically load data at runtime.

**Claude Code's Hybrid Approach:**
- **Eager:** CLAUDE.md files dropped into context upfront
- **Lazy:** `glob` and `grep` for just-in-time file discovery
- **Benefit:** Avoids stale indexing and complex syntax trees

---

## 3. Feature List Patterns

### 3.1 Structured Feature Tracking

**Source:** [Anthropic - Effective Harnesses](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)

Maintain a comprehensive JSON file tracking all requirements:

```json
{
  "features": [
    {
      "id": "auth-001",
      "category": "functional",
      "priority": "critical",
      "description": "User authentication with OAuth2",
      "steps": [
        "Create OAuth2 configuration",
        "Implement login flow",
        "Add session management",
        "Create logout endpoint"
      ],
      "passes": false,
      "verification_method": "e2e_test",
      "last_attempt": "2025-01-02T10:30:00Z",
      "failure_reason": null
    }
  ]
}
```

### 3.2 Immutability Rules

**CRITICAL:** Agents can ONLY modify the `passes` boolean field.

Anthropic uses "strongly-worded instructions like 'It is unacceptable to remove or edit tests because this could lead to missing or buggy functionality.'"

**Why JSON over Markdown:** "The model is less likely to inappropriately change or overwrite JSON files compared to Markdown files."

### 3.3 Feature State Machine

Track features through defined states:

```
┌─────────┐    ┌─────────────┐    ┌─────────────┐    ┌──────────┐
│ PENDING │───▶│ IN_PROGRESS │───▶│ VERIFICATION│───▶│ COMPLETE │
└─────────┘    └─────────────┘    └─────────────┘    └──────────┘
                     │                   │
                     ▼                   ▼
               ┌─────────┐         ┌─────────┐
               │ BLOCKED │         │ FAILED  │
               └─────────┘         └─────────┘
                     │                   │
                     └───────────────────┘
                              │
                              ▼
                     (Back to PENDING with notes)
```

### 3.4 Burndown Tracking Pattern

**Source:** [Atlassian - Scrum Artifacts](https://www.atlassian.com/agile/scrum/artifacts)

Adapt burndown charts for agent progress visualization:

```
Feature Burndown:
Total Features: 10
├── Completed: 4 ████░░░░░░ 40%
├── In Progress: 2 ██░░░░░░░░ 20%
├── Blocked: 1 █░░░░░░░░░ 10%
└── Remaining: 3 ███░░░░░░░ 30%

Velocity Trend:
Session 1: 1 feature
Session 2: 2 features
Session 3: 1 feature (blocked)
Average: 1.3 features/session
ETA: ~3 more sessions
```

### 3.5 Definition of Done

**Source:** [Miro - Scrum Artifacts](https://miro.com/agile/what-are-scrum-artifacts/)

Explicit completion criteria prevent premature feature marking:

```yaml
definition_of_done:
  code:
    - Implementation complete
    - Code follows style guide (linting passes)
    - No security vulnerabilities detected

  testing:
    - Unit tests written and passing
    - Integration tests written and passing
    - E2E test with Playwright/Puppeteer MCP
    - Edge cases covered

  verification:
    - Screenshot evidence captured
    - Manually verified in browser (if UI)
    - Committed with descriptive message

  documentation:
    - Progress file updated
    - Feature marked as "passes: true"
    - Git commit references feature ID
```

---

## 4. Quality Gates for Autonomous Agents

### 4.1 Two-Layer Verification Architecture

**Source:** [Academic Research on Self-Corrective Agents](https://www.emergentmind.com/topics/self-corrective-agent-architecture)

Self-corrective architectures separate core task execution from metacognitive monitoring:

```
┌─────────────────────────────────────────┐
│         Metacognitive Layer             │
│  ┌─────────────┐ ┌─────────────────────┐│
│  │ Verifier    │ │ Correction Engine   ││
│  │ - Tests     │ │ - Rollback          ││
│  │ - Linting   │ │ - Re-plan           ││
│  │ - E2E check │ │ - Alternative paths ││
│  └─────────────┘ └─────────────────────┘│
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│         Primary Task Layer              │
│        (Prompt → Plan → Act)            │
└─────────────────────────────────────────┘
```

### 4.2 Quality Gate Categories

**Source:** [Google Cloud - 2025 Lessons on Agents](https://cloud.google.com/transform/ai-grew-up-and-got-a-job-lessons-from-2025-on-agents-and-trust)

| Gate Type | Purpose | Implementation |
|-----------|---------|----------------|
| **Style Gates** | Enforce coding standards | ESLint, Prettier, PHPCS |
| **Security Gates** | Detect vulnerabilities | Snyk, OWASP checks |
| **Compliance Gates** | Policy adherence | OPA (Open Policy Agent) |
| **Quality Gates** | Code quality metrics | SonarQube |
| **Test Gates** | Verify functionality | Unit + E2E tests |

**Key Pattern:** Wire quality gates into existing CI/CD pipelines. Execute gates as jobs, fail fast on critical issues, pass everything else to human review.

### 4.3 Verification Patterns for Agent Work

**Critical Pattern: Explicit Browser Automation Testing**

Agents tend to mark features complete prematurely without proper user-flow validation. Use explicit E2E testing:

```python
# BAD: Assuming unit tests verify functionality
def verify_feature():
    return run_unit_tests()  # Insufficient!

# GOOD: Explicit end-to-end verification
async def verify_feature():
    # 1. Start dev server
    await start_server()

    # 2. Run Puppeteer/Playwright MCP
    await browser.navigate(feature_url)
    result = await browser.verify_element(expected_state)

    # 3. Screenshot for evidence
    await browser.screenshot("verification.png")

    return result.passed
```

### 4.4 Pre-Merge Quality Checklist for Agent PRs

```yaml
# .github/workflows/agent-pr-gates.yml
quality_gates:
  - name: "Static Analysis"
    tools: ["SonarQube", "Snyk", "OPA"]
    required: true

  - name: "Test Coverage"
    minimum: 80%
    required: true

  - name: "E2E Verification"
    tool: "Playwright"
    required: true

  - name: "Security Scan"
    tool: "OWASP checks"
    required: true

  - name: "Human Review"
    for: ["non-critical issues", "architectural changes"]
    required: true
```

### 4.5 Agent Undo Stacks

Treat atomicity as infrastructure, not a prompting challenge:

```python
# Pattern: Agent Undo Stack with File Checkpointing
from claude_agent_sdk import ClaudeAgentOptions

options = ClaudeAgentOptions(
    enable_file_checkpointing=True,  # Track changes for rewind
    extra_args={"replay-user-messages": None}  # Get checkpoint IDs
)

# Save checkpoint before risky operation
checkpoint_id = await save_checkpoint()

try:
    await risky_operation()
except OperationFailed:
    await client.rewind_files(checkpoint_id)
    await alternative_approach()
```

---

## 5. Session Handoff Patterns

### 5.1 Structured Handoff Protocol

**Source:** [MyShyft - Knowledge Transfer Sessions](https://www.myshyft.com/blog/knowledge-transfer-sessions/)

Allocate sufficient time for proper handoffs: minimum 30 minutes for straightforward shifts; an hour or more for complex operational states.

**Agent Session Handoff Document:**

```markdown
# Session Handoff Document

## Outgoing Session Summary
- Session ID: session-xyz-123
- Duration: 45 minutes
- Features attempted: 3
- Features completed: 2
- Features blocked: 1

## Current State
- Working directory: /project/src/auth
- Active branch: feature/oauth-integration
- Dev server: Running on port 3000
- Last commit: abc123 "Add OAuth callback handler"

## In-Progress Work
### Feature: OAuth Integration (60% complete)
- DONE: OAuth configuration, login flow
- TODO: Session persistence, logout
- BLOCKER: Need Redis connection string

## Critical Context (MUST preserve)
1. User prefers Tailwind over Bootstrap
2. OAuth provider is Auth0 (not Okta)
3. Session timeout must be 24 hours (client requirement)

## Known Issues
- Test `auth.spec.ts` flaky on CI (timing issue)
- TypeScript strict mode disabled temporarily

## Recommended Next Steps
1. Request Redis credentials from user
2. Complete session persistence
3. Re-enable TypeScript strict mode
4. Fix flaky test

## Files to Review First
- src/auth/oauth.ts (main implementation)
- tests/auth.spec.ts (test suite)
- .env.example (required env vars)
```

### 5.2 Git-Based State Recovery

Every coding agent session should execute this initialization:

```python
async def session_initialization():
    """Standard session startup sequence"""

    # 1. Verify working directory
    pwd = await bash("pwd")
    assert pwd == expected_working_dir

    # 2. Read git history for context
    git_log = await bash("git log --oneline -20")

    # 3. Read progress tracking file
    progress = await read("claude-progress.txt")

    # 4. Identify highest-priority incomplete feature
    features = await read("features.json")
    next_feature = get_highest_priority_incomplete(features)

    # 5. Start development server
    await bash("./init.sh")

    # 6. Run basic verification test
    health_check = await bash("curl localhost:3000/health")
    assert health_check.status == 200

    return {
        "context": progress,
        "next_task": next_feature,
        "environment_ready": True
    }
```

### 5.3 Knowledge Transfer Methods

**Source:** [Praxent - Knowledge Transfer Best Practices](https://praxent.com/blog/knowledge-transfer-best-practices-software-project-handoff)

| Method | Use Case | Implementation |
|--------|----------|----------------|
| **Progress File** | Standard handoff | Structured markdown with state |
| **Git History** | Code context | Descriptive commit messages |
| **Video Recording** | Complex workflows | Loom/screen recording of process |
| **Pair Programming** | Critical features | Two agents on same task |
| **Documentation** | Architecture | ADRs, README updates |

**Plan for handoff time:** At least 1 month for full project transitions:
- 2 weeks for documentation and training
- 2 weeks for active transition with support

### 5.4 Tacit vs. Explicit Knowledge Capture

**Source:** [InsArt - Knowledge Transfer in Dev Teams](https://www.insart.com/signals/knowledge-transfer-in-dev-team-best-practices)

For AI agents, prioritize **explicit knowledge** capture:

```markdown
# Explicit Knowledge Capture Template

## Decisions Made
| Decision | Rationale | Alternatives Considered |
|----------|-----------|------------------------|
| Use Redis for sessions | Performance at scale | PostgreSQL (too slow) |
| OAuth2 over SAML | Client requirement | N/A |

## Tribal Knowledge Documented
- OAuth callback URL must use HTTPS even in dev
- Redis connection pool max: 10 (memory constraint)
- User specifically requested Tailwind v3, not v4

## Error Patterns Encountered
| Error | Root Cause | Solution |
|-------|------------|----------|
| OAuth timeout | Network latency | Increased timeout to 10s |
| Redis ECONNREFUSED | Docker not running | Start Docker first |
```

---

## 6. Progress Documentation Pattern

### claude-progress.txt Format

```markdown
# Project Progress Log

## Session 1 - 2026-01-02 10:30
**Agent:** Initializer
**Actions:**
- Created project structure
- Generated feature_list.json with 45 features
- Wrote init.sh development server script
- Initial git commit: "Initial project setup"

**Next Session Should:**
- Start with feature #1: User authentication

---

## Session 2 - 2026-01-02 14:15
**Agent:** Coding
**Feature Worked On:** #1 - User can log in with email and password
**Status:** COMPLETED
**Actions:**
- Implemented login form component
- Added authentication API endpoint
- Wrote integration tests
- Verified end-to-end with browser automation

**Tests Passed:** 3/3
**Git Commit:** "feat: implement user authentication login flow"

**Next Session Should:**
- Work on feature #2: User profile view
- Note: Auth token stored in localStorage

---

## Session 3 - 2026-01-02 16:45
**Agent:** Coding
**Feature Worked On:** #2 - User can view their profile
**Status:** IN PROGRESS (context limit reached)
**Actions:**
- Created profile page component
- Added profile API endpoint
- INCOMPLETE: Profile image upload not working

**Current State:**
- Profile displays name and email correctly
- Image upload fails with 500 error
- Check server logs for image processing issue

**Next Session Should:**
- Debug image upload - check /api/profile/image endpoint
- Run: `tail -n 100 logs/server.log` for error details
- Complete feature #2 before moving on
```

### Key Elements

1. **Session identifier** with timestamp
2. **Agent type** (Initializer vs Coding)
3. **Feature being worked on** with ID reference
4. **Status** (COMPLETED, IN PROGRESS, BLOCKED)
5. **Specific actions taken**
6. **Test results** with pass/fail counts
7. **Git commit message** for reference
8. **Clear handoff instructions** for next session

---

## 7. Init.sh Script Pattern

### Purpose

The init.sh script enables agents to:
1. Quickly start the development environment
2. Run basic verification before implementing features
3. Avoid wasting time on setup each session

### Example Structure

```bash
#!/bin/bash

# init.sh - Development Environment Setup
# Generated by Initializer Agent

set -e

echo "=== Starting Development Environment ==="

# 1. Install dependencies (if needed)
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
fi

# 2. Start development server in background
echo "Starting development server..."
npm run dev &
DEV_PID=$!

# 3. Wait for server to be ready
echo "Waiting for server to start..."
sleep 5

# 4. Basic health check
echo "Running health check..."
curl -f http://localhost:3000/health || {
    echo "Health check failed!"
    kill $DEV_PID 2>/dev/null
    exit 1
}

echo "=== Environment Ready ==="
echo "Dev server PID: $DEV_PID"
echo "Access at: http://localhost:3000"

# Keep script running to maintain server
wait $DEV_PID
```

### Session Startup Sequence

```markdown
## Startup Instructions

Every coding session MUST begin with:

1. `./init.sh` - Start development environment
2. Wait for "Environment Ready" message
3. Open browser to http://localhost:3000
4. Manually verify basic functionality works
5. Read claude-progress.txt for context
6. Check git log for recent changes
7. Review feature_list.json for next task

ONLY proceed to feature implementation after steps 1-7 complete successfully.
```

---

## 8. End-to-End Testing Requirements

### The Problem

"Agents sometimes declared features complete without verifying them in a real-world environment."

### The Solution

Mandate browser automation testing using Puppeteer MCP or Playwright MCP.

### Implementation Pattern

```markdown
## Testing Requirements

Before marking ANY feature as `passes: true`:

1. **Write automated tests** covering the feature
2. **Run the test suite** and verify all tests pass
3. **Use browser automation** to verify end-to-end:
   - Open the application in a real browser
   - Perform the user actions from the feature steps
   - Verify the expected outcome
   - Take screenshots as evidence

4. **Document test results** in claude-progress.txt
5. **Commit the tests** along with the implementation

### Browser Automation Checklist

- [ ] Navigate to the correct page
- [ ] Wait for page load complete
- [ ] Perform each step from feature description
- [ ] Verify expected state after each step
- [ ] Handle error cases appropriately
- [ ] Take screenshot of final state
```

### Example Testing Prompt

```markdown
After implementing a feature, you MUST verify it works by:

1. Using the Playwright MCP tools to open a browser
2. Navigate to the relevant page
3. Perform EXACTLY the steps listed in the feature
4. Verify each step produces the expected result
5. If ANY step fails, the feature is NOT complete

Think like a user - not a developer. Test what the USER sees and does.
```

---

## 9. Common Failure Modes and Mitigations

### Failure Mode 1: One-Shot Attempts

**Problem:** "The agent tended to try to do too much at once - essentially to attempt to one-shot the app."

**Consequence:** Model runs out of context mid-implementation, leaving features half-implemented and undocumented.

**Mitigation:**
- Explicitly instruct: "Implement ONE feature per session"
- Prompt for frequent commits
- Use feature list to enforce scope boundaries
- Include in prompts: "If you cannot complete a feature in this session, document your progress and stop"

### Failure Mode 2: Premature Completion Claims

**Problem:** "The agent sees progress has been made and just declares the job done."

**Consequence:** Features marked complete without proper verification, bugs ship to production.

**Mitigation:**
- Require end-to-end testing before marking complete
- Use "passes" field that can only be changed after verification
- Include verification screenshots in progress log
- Add: "NEVER claim a feature is done without browser verification"

### Failure Mode 3: Context Window Drift

**Problem:** "Signal got drowned by accumulation" - critical constraints get buried under noise.

**Consequence:** Agent forgets important requirements or constraints as context fills.

**Mitigation:**
- Keep context minimal and focused
- Use subagents for isolated tasks
- Regularly summarize and clear context
- Store important information in external files, not just context

### Failure Mode 4: Time Wasted on Setup

**Problem:** Each session starts from scratch, re-discovering environment setup.

**Consequence:** Significant time lost on repetitive setup tasks.

**Mitigation:**
- Create init.sh script in first session
- Document environment in progress file
- Include startup checklist in coding agent prompt
- Commit environment configuration to git

### Failure Mode 5: Undocumented Progress

**Problem:** Agent makes progress but doesn't record what was done or what's next.

**Consequence:** Next session cannot reconstruct state efficiently.

**Mitigation:**
- Require progress file updates before session end
- Include specific "Next Session Should" section
- Commit progress with descriptive messages
- Log current state, not just actions taken

### Failure Mode 6: Verification Failures

**Problem:** Agent declares features done without actual testing.

**Mitigation:**
- Mandatory browser automation testing
- Screenshot evidence required
- Test result documentation in progress file
- Strongly-worded prompts about verification requirements

### Failure Mode 7: Error Propagation

**Problem:** "One early mistake cascades through subsequent decisions, compounding into larger failures."

**Mitigation:**
- Incremental commits enable rollback
- Git history provides recovery points
- Clear state documentation per session
- Explicit error handling in progress log

---

## 10. Agent Framework Patterns

### 10.1 CrewAI Memory Persistence

**Source:** [CrewAI Documentation - Memory](https://docs.crewai.com/en/concepts/memory)

CrewAI offers three memory types:

```python
from crewai import Crew, Agent, Task
from crewai.memory.short_term.short_term_memory import ShortTermMemory
from crewai.memory.long_term.long_term_memory import LongTermMemory
from crewai.memory.entity.entity_memory import EntityMemory

crew = Crew(
    agents=[agent1, agent2],
    tasks=[task1, task2],
    memory=True,  # Enables all memory types
    short_term_memory=ShortTermMemory(storage_path="./memory/short_term"),
    long_term_memory=LongTermMemory(storage_path="./memory/long_term"),
    entity_memory=EntityMemory(storage_path="./memory/entities")
)
```

**Storage Locations:**
```
~/Library/Application Support/CrewAI/{project_name}/
├── knowledge/              # Knowledge base ChromaDB files
├── short_term_memory/      # Short-term memory ChromaDB files
├── long_term_memory/       # Long-term memory ChromaDB files
├── entities/               # Entity memory ChromaDB files
└── long_term_memory_storage.db  # SQLite database
```

### 10.2 LangGraph Checkpointing

**Source:** [LangGraph - Persistence](https://langchain-ai.github.io/langgraph/persistence/)

LangGraph provides durable execution with checkpoints:

```python
from langgraph.graph import StateGraph, START, END
from langgraph.checkpoint.memory import InMemorySaver
from langchain_core.runnables import RunnableConfig

# Define state and workflow
workflow = StateGraph(State)
workflow.add_node(node_a)
workflow.add_node(node_b)
workflow.add_edge(START, "node_a")
workflow.add_edge("node_a", "node_b")
workflow.add_edge("node_b", END)

# Compile with checkpointer
checkpointer = InMemorySaver()
graph = workflow.compile(checkpointer=checkpointer)

# Thread ID enables resumption
config: RunnableConfig = {"configurable": {"thread_id": "1"}}
graph.invoke({"foo": ""}, config)
```

**Key Benefits:**
- **Durable execution:** Persist through failures and resume
- **Human-in-the-loop:** Inspect and modify agent state
- **Comprehensive memory:** Short-term + long-term across sessions

### 10.3 Claude Agent SDK Session Management

**Source:** [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk-python)

```python
from claude_agent_sdk import ClaudeAgentOptions, ClaudeSDKClient

options = ClaudeAgentOptions(
    enable_file_checkpointing=True,
    resume="session-123",  # Resume from specific session
    fork_session=True,     # Fork to new session ID when resuming
    permission_mode="acceptEdits"
)

async with ClaudeSDKClient(options=options) as client:
    # Save checkpoint after changes
    checkpoint_id = message.uuid

    # Rewind if needed
    await client.rewind_files(checkpoint_id)
```

### 10.4 Self-Corrective Architecture

**Source:** [Academic Research](https://www.emergentmind.com/topics/self-corrective-agent-architecture)

Multi-layer composition separating task execution from monitoring:

1. **Primary (Task) Layer:** Encodes the prompt-plan-act loop
2. **Metacognitive Layer:** Monitors, diagnoses, and corrects failures

**Key Strategies:**
- **Learning-from-feedback:** Promote planning ability through iteration
- **Meta-controller:** Navigate to specialized agents based on root cause
- **Early-stop mechanisms:** Prevent infinite loops and hitting round limits

---

## 11. Practical Implementation for Claude Code Plugins

### 11.1 Workflow Commands

Create workflow commands that enforce the two-agent pattern:

```markdown
# /acms-init - Initializer Agent Workflow

## Purpose
Set up a new long-running task with proper state management.

## Actions
1. Create feature_list.json from user specification
2. Generate init.sh for environment setup
3. Initialize claude-progress.txt
4. Create initial git commit
5. Document startup procedure

## Output
- Feature list with all requirements
- Executable init script
- Progress log initialized
- Clean git state
```

```markdown
# /acms-continue - Coding Agent Workflow

## Purpose
Continue work on a long-running task from previous session.

## Startup Sequence
1. Read claude-progress.txt for context
2. Check git log for recent work
3. Review feature_list.json for next task
4. Run init.sh and verify environment
5. Select highest-priority incomplete feature

## Session Rules
- Work on ONE feature only
- Test before marking complete
- Update progress file
- Commit with descriptive message
- Document handoff for next session
```

### 11.2 Hook Patterns for Automation

Use Claude Code hooks to enforce best practices:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "echo 'Remember: Update claude-progress.txt before session end'"
      }
    ],
    "Stop": [
      {
        "command": "git status && echo 'Ensure all changes committed'"
      }
    ]
  }
}
```

### 11.3 Agent Definition Pattern

```markdown
# agents/workflow/long-running-coder.md

---
name: Long-Running Coder
description: Coding agent for multi-session feature implementation
tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - mcp__playwright__*
---

## System Prompt

You are a coding agent working on a long-running project. Your session is ONE of many - you must leave the project in a clean state for the next session.

## Session Startup (MANDATORY)

Before ANY coding:
1. Read `claude-progress.txt` to understand current state
2. Run `git log --oneline -10` to see recent work
3. Review `feature_list.json` for next priority
4. Run `./init.sh` and wait for environment ready
5. Verify basic functionality works

## Session Rules

1. **ONE FEATURE PER SESSION** - Do not attempt multiple features
2. **TEST BEFORE COMPLETE** - Use browser automation to verify
3. **DOCUMENT EVERYTHING** - Update progress file with specifics
4. **COMMIT FREQUENTLY** - Each logical unit = one commit
5. **CLEAN HANDOFF** - Next session should start smoothly

## Feature Completion Checklist

Before marking `passes: true`:
- [ ] Implementation complete
- [ ] Unit tests written and passing
- [ ] End-to-end test with browser automation
- [ ] Screenshot evidence captured
- [ ] Progress file updated
- [ ] Git committed with descriptive message

## Session End

Before stopping:
1. Update `claude-progress.txt` with:
   - What was accomplished
   - Current state
   - Next steps for future session
2. Commit all changes including progress file
3. Verify git status is clean
```

### 11.4 Recommended Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    ORCHESTRATOR                          │
│  - Manages session lifecycle                            │
│  - Triggers compaction when needed                      │
│  - Coordinates handoffs                                 │
└─────────────────────────────────────────────────────────┘
           │                    │                    │
           ▼                    ▼                    ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│ TASK EXECUTOR   │  │ QUALITY GATES   │  │ MEMORY MANAGER  │
│ - Feature work  │  │ - Tests         │  │ - Compaction    │
│ - Code changes  │  │ - Linting       │  │ - Preservation  │
│ - Git commits   │  │ - E2E verify    │  │ - Recovery      │
└─────────────────┘  └─────────────────┘  └─────────────────┘
           │                    │                    │
           └────────────────────┴────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────┐
│               PERSISTENT STATE LAYER                     │
│  - claude-progress.txt                                  │
│  - features.json                                        │
│  - Git history                                          │
│  - Memory files                                         │
└─────────────────────────────────────────────────────────┘
```

### 11.5 Quality Metrics to Track

| Metric | Target | Measurement |
|--------|--------|-------------|
| Feature completion rate | >80% per session | features.json |
| Context efficiency | <50% window at compaction | Token counting |
| Verification coverage | 100% E2E for UI features | Test reports |
| Handoff quality | <10 min context recovery | Session start time |
| Rollback frequency | <5% of commits | Git history |

---

## 12. Summary and Sources

### Must Have Patterns

1. **Two-agent architecture** - Initializer + Coding agent separation
2. **Feature list with passes field** - Immutable structure, only status changes
3. **Progress file** - Session handoff documentation
4. **Init script** - Quick environment setup
5. **End-to-end testing** - Browser automation verification
6. **Git commits as checkpoints** - Incremental progress markers

### Recommended Patterns

1. **One feature per session** - Prevent context overflow
2. **Strongly-worded prompts** - Enforce verification requirements
3. **Subagent isolation** - Manage context effectively
4. **Screenshot evidence** - Document test results
5. **Clear handoff instructions** - Enable smooth continuity
6. **Quality gates** - Automated verification before merge
7. **Checkpointing** - Enable rollback and recovery

### Avoid

1. **One-shot attempts** - Breaking complex work into sessions
2. **Premature completion claims** - Always verify before marking done
3. **Undocumented progress** - Always update progress file
4. **Context accumulation** - Use subagents and external files
5. **Skipping verification** - Browser testing is mandatory

---

## Sources

### Primary Sources - Anthropic Engineering

- [Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [Claude Code: Best Practices for Agentic Coding](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Context Management](https://claude.com/blog/context-management)
- [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk-python)

### Agent Frameworks

- [CrewAI Documentation - Memory](https://docs.crewai.com/en/concepts/memory)
- [LangGraph - Persistence](https://langchain-ai.github.io/langgraph/persistence/)
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)

### Industry Best Practices

- [Google Cloud - Agents and Trust 2025](https://cloud.google.com/transform/ai-grew-up-and-got-a-job-lessons-from-2025-on-agents-and-trust)
- [Atlassian - Scrum Artifacts](https://www.atlassian.com/agile/scrum/artifacts)
- [Miro - Scrum Artifacts](https://miro.com/agile/what-are-scrum-artifacts/)
- [MyShyft - Knowledge Transfer Sessions](https://www.myshyft.com/blog/knowledge-transfer-sessions/)
- [Praxent - Knowledge Transfer Best Practices](https://praxent.com/blog/knowledge-transfer-best-practices-software-project-handoff)
- [InsArt - Knowledge Transfer in Dev Teams](https://www.insart.com/signals/knowledge-transfer-in-dev-team-best-practices)

### Academic Research

- [Self-Corrective Agent Architecture](https://www.emergentmind.com/topics/self-corrective-agent-architecture)
- [LLM Agents Papers Repository](https://github.com/AGI-Edgerunners/LLM-Agents-Papers)
- [OpenAI - Self-Evolving Agents](https://cookbook.openai.com/examples/partners/self_evolving_agents/autonomous_agent_retraining)
- [Autonomous Agents Research Repository](https://github.com/tmgthb/Autonomous-Agents)

---

**Document Version:** 2.0
**Last Updated:** 2026-01-02
**Applicability:** Claude Code Plugins, Claude Agent SDK, Long-Running Workflows
