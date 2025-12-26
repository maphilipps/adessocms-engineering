# Changelog

## [1.19.6] - 2025-12-26

### Changed - All Skills Updated to Chrome-First

**All skill workflows now use Claude in Chrome as PRIMARY browser tool.**

**Updated Files:**
- `skills/generate-user-handbook/workflows/generate-handbook.md`
- `skills/generate-user-handbook/workflows/update-handbook.md`
- `skills/create-drupal-case-study/workflows/generate-case-study.md`

**Changes Made:**
- Replaced all `mcp__playwright__*` calls with `mcp__claude-in-chrome__*`
- Added proper tab context setup (`tabs_context_mcp`, `tabs_create_mcp`)
- Updated login workflows with `form_input` and `computer` actions
- Updated screenshot workflows with `resize_window` and `computer(action="screenshot")`
- Removed `browser_close` (Chrome tabs stay open for reuse)

**Playwright MCP remains documented as FALLBACK only** in:
- `skills/generate-user-handbook/references/screenshot-guidelines.md`
- `skills/web-to-adessocms/SKILL.md`

---

## [1.19.5] - 2025-12-26

### Changed - Claude in Chrome as Primary Browser Tool

**Enforces Claude in Chrome as the PRIMARY browser tool. Playwright MCP is ONLY a last-resort fallback.**

**New Core Principle:**
```
1. Claude in Chrome: ALWAYS use mcp__claude-in-chrome__* tools.
   Playwright MCP is ONLY a last-resort fallback!
```

**New Section: Browser Tool Priority**
```
┌─────────────────────────────────────────────────────────────┐
│  1. Claude in Chrome (PRIMARY - ALWAYS USE FIRST)           │
│     mcp__claude-in-chrome__tabs_context_mcp                 │
│     mcp__claude-in-chrome__navigate                         │
│     mcp__claude-in-chrome__javascript_tool                  │
│     mcp__claude-in-chrome__computer (screenshot, wait)      │
│     mcp__claude-in-chrome__resize_window                    │
├─────────────────────────────────────────────────────────────┤
│  2. Playwright MCP (FALLBACK ONLY)                          │
│     ⚠️ Only use if Chrome extension is unavailable          │
└─────────────────────────────────────────────────────────────┘
```

**Why Chrome First?**
- Direct browser control via extension
- Better JavaScript execution context
- More reliable for complex sites
- Consistent with other adesso CMS workflows

---

## [1.19.4] - 2025-12-26

### Changed - Slots-First Architecture in web-to-adessocms

**Enforces proper Drupal SDC architecture: Slots for content, Props for configuration.**

**New Core Principles:**
- **Slots-First**: ALWAYS prefer slots over props for content
- **Field Templates**: Override field templates to fill component slots

**New Sections Added:**
- **Step 3.2: Slots vs Props Decision (CRITICAL)** - Decision table for when to use each
- **Step 3.5: Create Field Templates (MANDATORY)** - Examples for text, links, media
- **Step 3.6: Integrate in Paragraph/Node Template** - `embed` vs `include` patterns
- **Slots vs Props Quick Reference** - Visual ASCII diagram
- **Field Template Pattern** - Copy-paste snippets

**Key Rules Enforced:**
```
🔴 NEVER use props for content from Drupal fields
🟢 ALWAYS use slots for field content → override field templates
🟢 ONLY use props for configuration (theme, variant, size)
```

**Example Field Templates:**
- Minimal (removes wrappers): `{{- item.content -}}`
- Links with classes: `<a href="{{ item.content['#url'] }}" class="btn">`
- Media with image style: `{{ item.content|merge({'#image_style': 'hero_large'}) }}`

**Updated Verification Checklist:**
- [ ] All content uses SLOTS (not props)
- [ ] Props are ONLY for configuration
- [ ] Field templates exist for all slots
- [ ] Field templates remove wrapper markup

---

## [1.19.3] - 2025-12-26

### Changed - web-to-adessocms Skill Rewrite

**Complete rewrite for automated browser extraction using Claude in Chrome.**

The skill now actually visits websites and extracts source code automatically instead of requiring manual input.

**Browser-First Approach:**
```
mcp__claude-in-chrome__tabs_context_mcp
mcp__claude-in-chrome__navigate(url="[SOURCE_URL]", tabId=<tab_id>)
mcp__claude-in-chrome__javascript_tool(...) → Extract HTML/CSS
```

**Automated Extraction:**
- **HTML**: `document.querySelector('[SELECTOR]').outerHTML`
- **Tailwind Classes**: Filters all classes for Tailwind patterns
- **Computed Styles**: backgroundColor, fontFamily, padding, etc.
- **Alpine.js**: Detects `x-data`, `x-show`, `@click` patterns
- **Interactive Elements**: Dropdowns, mobile menus, toggles

**Multi-Breakpoint Screenshots:**
- Desktop (1280px)
- Tablet (768px)
- Mobile (375px)

**Tailwind Mapping:**
| Source Tailwind | adesso CMS Equivalent |
|-----------------|----------------------|
| `text-sm`, `text-base` | `.p-sm`, `.p-base` |
| `max-w-7xl mx-auto px-4` | `.container` |
| `bg-gray-*`, `bg-slate-*` | `bg-neutral-*` |

**Validation Phase:**
- Visual comparison with original in Drupal
- Console error checking
- Responsive behavior verification

---

## [1.19.2] - 2025-12-26

### Added - web-to-adessocms Skill

**Moved `web-to-adessocms` skill from user skills to plugin.**

This skill converts website UI components to adesso CMS SDC components with Tailwind v4 and Alpine.js.

**Triggers:**
- "copy the navigation from [URL]"
- "replicate this hero section"
- "convert this component"
- "make a component like [website]"
- "kopiere von [URL]"

**Features:**
- Screenshots at 3 breakpoints (mobile, tablet, desktop)
- Maps to project typography classes (h-xs, h-base, etc.)
- Uses project color variables
- Proper Alpine.js patterns for interactivity
- Drupal-first approach (not just Storybook)
- Full preprocess hook examples

---

## [1.19.1] - 2025-12-26

### Added - Parallelization Mindset Section

**All three workflow commands now have a prominent "⚡ Parallelization Mindset (CRITICAL)" section.**

This reminds Claude to ALWAYS ask: "Can I run multiple agents in parallel?"

### Why This Matters

We have 46 agents for a reason - to work in parallel and get faster, better results.

```
❌ BAD (Sequential):
agent1 → wait → agent2 → wait → agent3

✅ GOOD (Parallel):
agent1 ┐
agent2 ├→ ALL complete at once → synthesize
agent3 ┘
```

### Files Updated

- `commands/workflows/acms-plan.md` - Added parallelization section
- `commands/workflows/acms-work.md` - Added parallelization section
- `commands/workflows/acms-review.md` - Added parallelization section

### Rules Emphasized

1. **Independent research?** → Run agents in parallel
2. **Multiple specialists needed?** → Spawn all at once
3. **Different file searches?** → Execute Grep/Glob in parallel
4. **Tests + Linting?** → Run both in parallel
5. **Never wait for one agent when you could run four**

---

## [1.19.0] - 2025-12-26

### Added - EveryInc-Inspired Workflow Enhancements

**New agents and workflow improvements inspired by EveryInc's compound-engineering plugin.**

### New Agents (2)

**Review Agents (`agents/review/`):**

| Agent | Purpose |
|-------|---------|
| `code-simplifier` | Final pass to ensure code is as simple as possible. Checks YAGNI violations, unnecessary complexity, and opportunities for LOC reduction. |
| `agent-native-reviewer` | Ensures features are agent-accessible. Verifies action parity (API/Drush for every UI action), context parity, and shared workspace patterns. |

### Workflow Changes

**`/acms-plan` - SpecFlow Analysis (MANDATORY):**
- Added Phase 2.5: SpecFlow Analysis
- Runs `acms-spec-flow-analyzer` AFTER research, BEFORE technical approach
- Maps all user flows, edge cases, and gaps
- Critical questions must be answered before proceeding
- Pattern from EveryInc: Validate specs before implementation

**`/acms-review` - Simplification Review (MANDATORY):**
- Added Step 3.5: Simplification Review
- Runs `code-simplifier` AFTER synthesis
- Checks for YAGNI violations and over-engineering
- Pattern from EveryInc: Every PR gets a simplicity check

**`/acms-review` - Agent-Native Review:**
- Added `agent-native-reviewer` to parallel specialists
- Runs for new features
- Ensures features are accessible to AI agents (not just UI)

### Updated Specialist Selection Guide

| Change Type | Required Specialists |
|-------------|----------------------|
| New Features | agent-native-reviewer |
| ALL PRs | code-simplifier (after synthesis) |

### Why These Changes

EveryInc's compound-engineering plugin runs these agents on EVERY review:
- `spec-flow-analyzer` during planning
- `code-simplicity-reviewer` after synthesis
- `agent-native-reviewer` for new features

We now match their workflow patterns for consistent quality.

---

## [1.18.6] - 2025-12-26

### Fixed - Agent Invocation Syntax (EveryInc-Style)

**Agents now use the working EveryInc syntax for actual execution.**

### The Problem

Our commands used this syntax which Claude read as TEXT, not as executable instructions:
```
Task(subagent_type="adessocms-engineering:specialists:drupal-specialist", prompt="...")
```

Result: Claude worked through everything alone without spawning agents.

### The Solution

Adopted EveryInc's proven syntax that Claude actually EXECUTES:
```
Run these specialists in parallel at the same time:

- Task drupal-specialist(task_description)
- Task sdc-specialist(component_description)
- Task security-sentinel(changes)
```

### Files Updated

**Commands (4):**
- `commands/workflows/acms-plan.md` - Research phase, plan template, specialist guide
- `commands/workflows/acms-work.md` - Specialist consultation, review section
- `commands/workflows/acms-review.md` - All 20+ parallel reviewer invocations
- `commands/reproduce-bug.md` - Bug investigation agents

### Also Fixed: docs/solutions/ Check in Planning

Added **MANDATORY** check of `docs/solutions/` in Phase 2 of `/acms-plan`:
- Search compounded knowledge BEFORE searching codebase
- Read `docs/solutions/patterns/cora-critical-patterns.md`
- Added "Compounded Knowledge" section to research findings template

This closes the compound loop:
```
/acms-compound → writes to docs/solutions/
/acms-plan     → now reads from docs/solutions/ ✅
```

---

## [1.18.5] - 2025-12-26

### Changed - Claude in Chrome as Primary Browser Tool

**Claude in Chrome is now the PRIMARY browser automation tool. Playwright MCP is only used as FALLBACK.**

### What Changed

All browser automation now uses Claude in Chrome (`mcp__claude-in-chrome__*`) by default:

| Tool | Purpose |
|------|---------|
| `mcp__claude-in-chrome__tabs_context_mcp` | Get tab context and ID |
| `mcp__claude-in-chrome__navigate` | Navigate to URL |
| `mcp__claude-in-chrome__computer(action="screenshot")` | Take screenshot |
| `mcp__claude-in-chrome__read_page` | Read accessibility tree |
| `mcp__claude-in-chrome__resize_window` | Resize browser window |
| `mcp__claude-in-chrome__read_console_messages` | Check JS errors |

### Files Updated

**Agents (5):**
- `agents/core/frontend-engineer.md` - Visual verification with Chrome
- `agents/design/design-iterator.md` - Screenshot workflow with Chrome
- `agents/design/figma-design-sync.md` - Implementation capture with Chrome
- `agents/design/design-implementation-reviewer.md` - Screenshot workflow with Chrome
- `agents/workflow/acms-bug-reproduction-validator.md` - UI bug testing with Chrome

**Commands (3):**
- `commands/workflows/acms-work.md` - Screenshot capture section
- `commands/reproduce-bug.md` - Frontend investigation
- `commands/generate-user-handbook.md` - Added Chrome to allowed-tools

**Skills (5):**
- `skills/generate-user-handbook/references/screenshot-guidelines.md` - Complete rewrite
- `skills/generate-user-handbook/workflows/capture-section.md` - Browser workflow
- `skills/generate-user-handbook/SKILL.md` - Reference description
- `skills/create-drupal-case-study/workflows/capture-screenshots.md` - Screenshot workflow
- `skills/sdc-design-factory/references/workflow-copy-showcase.md` - Reference screenshots

### Example Workflow

```
# 1. Get tab context
mcp__claude-in-chrome__tabs_context_mcp

# 2. Navigate
mcp__claude-in-chrome__navigate(url="https://example.ddev.site", tabId=<tab_id>)

# 3. Wait if needed
mcp__claude-in-chrome__computer(action="wait", duration=2, tabId=<tab_id>)

# 4. Screenshot
mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)
```

### Why This Change

1. **Native Integration**: Claude in Chrome is Anthropic's official browser extension
2. **Better Reliability**: Runs in user's actual browser with full session state
3. **Simpler Auth**: Uses existing browser session/cookies
4. **Fallback Available**: Playwright MCP remains available for edge cases

### Playwright Fallback

Playwright MCP (`mcp__plugin_adessocms-engineering_pw__*`) is still available as fallback when Claude in Chrome is unavailable (e.g., headless environments, CI/CD).

---

## [1.18.4] - 2025-12-26

### Changed - Mandatory Specialist Consultation in /acms-work

**Specialists are now MANDATORY during implementation, not optional.**

### What Changed

The `/acms-work` command now:

1. **Reads recommended agents from plan** (new Phase 2, Step 1)
   - Extracts agents from "Recommended Agents for Implementation" section
   - These agents MUST be consulted

2. **Consults specialists BEFORE each task** (new Phase 2, Step 2)
   - Changed from "when needed" to "MANDATORY"
   - Run all recommended specialists in PARALLEL
   - Wait for ALL responses before implementing

3. **Updated Task Execution Loop** (Phase 2, Step 3)
   - Step 3 now marked with ⭐ as mandatory
   - Clear instruction: "Never implement without specialist guidance!"

4. **Updated "When to Use Specialists" section**
   - Changed from "RECOMMENDED" to "MANDATORY"
   - Added table showing which agent provides what
   - Clear parallel execution syntax

5. **Updated Common Pitfalls**
   - Added ⚠️ warning against skipping specialist consultation
   - Emphasized this is MANDATORY, not optional

### Workflow Flow

```
/acms-plan → creates plan with "Recommended Agents" section
     ↓
/acms-work → reads agents from plan → consults them BEFORE each task
     ↓
Implementation → follows specialist guidance
```

### Why This Matters

Previously, specialists were "optional" and "when needed" - leading to them being skipped.
Now they are mandatory, ensuring every implementation gets expert guidance on:
- Correct API patterns
- Security best practices
- Accessibility compliance
- Performance optimizations

---

## [1.18.3] - 2025-12-25

### Added - Recommended Agents in Plan Template

**Plans now include a "Recommended Agents for Implementation" section with exact Task syntax.**

### What's New

The `/acms-plan` command now generates plans that specify:
- Which **Core Agents** to use (e.g., Oracle for escalation)
- Which **Specialist Agents** to consult (e.g., drupal-specialist, sdc-specialist)
- Which **Research Agents** to invoke (e.g., framework-docs-researcher)
- Exact **Task syntax** for each agent with `subagent_type` parameter

### Example Output

```markdown
## Recommended Agents for Implementation

### Specialist Agents
| Agent | When to Use | Task Syntax |
|-------|-------------|-------------|
| drupal-specialist | For Drupal API patterns | `Task(subagent_type="adessocms-engineering:specialists:drupal-specialist", prompt="...")` |
| sdc-specialist | For SDC component structure | `Task(subagent_type="adessocms-engineering:specialists:sdc-specialist", prompt="...")` |
```

### Why This Matters

Plans now serve as complete implementation guides that include both **what to do** and **which agents to use**. This ensures `/acms-work` can effectively delegate to the right specialists.

---

## [1.18.2] - 2025-12-25

### Fixed - Agent Colors Not Displaying

**Corrected all agent colors to use only the supported color palette.**

### Problem

Agent colors were not being displayed because unsupported color values were used:
- `gold`, `gray`, `orange`, `violet`, `purple` - NOT SUPPORTED

### Solution

Updated all colors to use only the supported palette: `blue`, `cyan`, `green`, `yellow`, `magenta`, `red`

| Category | Old Color | New Color | Count |
|----------|-----------|-----------|-------|
| Core | `gold` | `yellow` | 6 |
| Background | `gray` | `cyan` | 9 |
| Performance | `orange` | `red` | 1 |
| Design | `purple`/`violet` | `magenta` | 3 |

### Files Updated

19 agent files with color corrections:
- 6 core agents → `yellow`
- 9 background agents → `cyan`
- 3 design agents → `magenta`
- 1 performance-oracle → `red`

### Final Color Scheme

| Category | Color | Hex Approx |
|----------|-------|------------|
| Core | `yellow` | 🟡 |
| Specialists | `blue` | 🔵 |
| Security | `red` | 🔴 |
| Accessibility | `cyan` | 🔷 |
| Research | `green` | 🟢 |
| Design | `magenta` | 🟣 |
| Background | `cyan` | 🔷 |
| Workflow | `yellow` | 🟡 |

---

## [1.18.1] - 2025-12-25

### Fixed - Task Agent Calling Syntax

**Corrected Task tool syntax in all workflow commands to use proper `subagent_type` parameter.**

### Problem

Agents were not being invoked from slash commands because the syntax was incorrect:

```
❌ Task drupal-specialist("prompt")  // Wrong - doesn't work
```

### Solution

Updated to correct Claude Code Task tool syntax:

```
✅ Task(subagent_type="adessocms-engineering:specialists:drupal-specialist", prompt="...")
```

### Files Fixed

- `commands/workflows/acms-work.md` - All specialist invocations
- `commands/workflows/acms-plan.md` - Specialist consultation
- `commands/workflows/acms-review.md` - All 20+ parallel specialist reviews
- `commands/acms-init.md` - Generated CLAUDE.md template

### Why This Matters

The Task tool requires the full `subagent_type` parameter with the format:
`plugin-name:agent-category:agent-name`

Without this, Claude Code cannot resolve which agent to spawn.

---

## [1.18.0] - 2025-12-25

### Changed - Agent Color Scheme & Model Upgrade to Opus

**Added color coding to all agents and upgraded most agents from Sonnet to Opus.**

### Color Scheme

All agents now have a `color:` field in their frontmatter for better visual identification:

| Category | Color | Agents |
|----------|-------|--------|
| Core | gold | sisyphus-orchestrator, oracle, librarian, frontend-engineer, document-writer, skill-invoker |
| Specialist | blue | drupal-specialist, sdc-specialist, twig-specialist, code-quality-specialist, etc. |
| Specialist | red | security-sentinel (security focus) |
| Specialist | cyan | accessibility-specialist (a11y focus) |
| Specialist | orange | performance-oracle (performance focus) |
| Research | green | framework-docs-researcher, best-practices-researcher, git-history-analyzer, repo-research-analyst |
| Design | purple/violet | figma-design-sync, design-iterator, design-implementation-reviewer |
| Background | gray | context-summarizer, config-drift-detector, pattern-collector, etc. |
| Workflow | yellow | acms-lint, acms-spec-flow-analyzer, acms-pr-comment-resolver, acms-bug-reproduction-validator |

### Model Upgrade: Sonnet → Opus

Upgraded agents to use Claude Opus 4.5 for higher quality output:

**Specialist Agents (16 upgraded):**
- drupal-specialist, security-sentinel, sdc-specialist, twig-specialist
- accessibility-specialist, code-quality-specialist, component-reuse-specialist
- dries-drupal-specialist, drupal-theme-specialist, paragraphs-specialist
- tailwind-specialist, storybook-specialist, test-coverage-specialist
- data-integrity-guardian, architecture-strategist, performance-oracle, pattern-recognition-specialist

**Core Agents (3 upgraded):**
- librarian, frontend-engineer, document-writer

**Design Agents (3 upgraded):**
- figma-design-sync, design-iterator, design-implementation-reviewer

**Workflow Agents (3 upgraded):**
- acms-spec-flow-analyzer, acms-pr-comment-resolver, acms-bug-reproduction-validator

**Research Agents (4 upgraded):**
- framework-docs-researcher, best-practices-researcher, git-history-analyzer, repo-research-analyst

### Agents Keeping Haiku (efficiency)

These agents remain on Haiku for efficiency:
- All Background agents (9 total)
- composer-specialist
- skill-invoker
- acms-lint

### Why This Change

1. **Color coding**: Visual distinction between agent categories in Claude Code UI
2. **Opus upgrade**: Higher quality reasoning and output for complex tasks
3. **Consistency**: Standardized frontmatter structure across all agents

---

## [1.17.1] - 2025-12-25

### Fixed - Missing Agent Frontmatter

**Added missing `name:` and `description:` fields to 14 Specialist agents.**

### Fixed

All Specialist agents now have proper YAML frontmatter with `name:` and `description:` fields, which is required for Claude Code's agent referencing system.

**Agents fixed:**
- `accessibility-specialist`
- `code-quality-specialist`
- `component-reuse-specialist`
- `composer-specialist`
- `dries-drupal-specialist`
- `drupal-specialist`
- `drupal-theme-specialist`
- `paragraphs-specialist`
- `sdc-specialist`
- `security-sentinel`
- `storybook-specialist`
- `tailwind-specialist`
- `test-coverage-specialist`
- `twig-specialist`

### Why This Fix

Claude Code requires the `name:` field in agent frontmatter to properly reference agents via `Task(subagent_type="...")`. Without this field, agents could not be invoked by the workflow commands (`/acms-plan`, `/acms-work`, `/acms-review`).

---

## [1.17.0] - 2025-12-25

### Changed - Claude Opus 4.5 Optimization

**Optimized all agent prompts for Claude Opus 4.5 model behavior.**

### Changed

Applied systematic prompt optimizations based on the [claude-opus-4-5-migration](https://github.com/claude-code-plugins) skill guidelines:

#### 1. Tool Overtriggering Prevention
Softened aggressive language that can cause excessive tool calls with Opus 4.5:

| Pattern | Before | After |
|---------|--------|-------|
| CRITICAL | `**CRITICAL**:` | (removed or softened) |
| MUST | `you MUST:` | `you should:` |
| ALWAYS | `ALWAYS search` | `Search` |
| NEVER | `NEVER do this` | `Don't do this` |

#### 2. Thinking Sensitivity
Replaced "think" patterns that can trigger excessive internal reasoning:

| Before | After |
|--------|-------|
| `think like an attacker` | `reason like an attacker` |
| `think in tradeoffs` | `reason in tradeoffs` |
| `think outside the box` | `explore outside the box` |
| `Think step by step` | `Consider step by step` |
| `What I Think:` | `My View:` |

#### 3. Affected Agents

**Core Agents (3):**
- `sisyphus-orchestrator` - Removed CRITICAL, ALWAYS
- `oracle` - Softened CRITICAL, MUST, ALWAYS; replaced "think"
- `librarian` - Softened MUST, ALWAYS

**Specialist Agents (5):**
- `paragraphs-specialist` - Removed CRITICAL
- `composer-specialist` - Changed CRITICAL to Important
- `sdc-specialist` - Softened NEVER, MUST
- `security-sentinel` - Replaced "think"
- `dries-drupal-specialist` - Replaced "What I Think"

**Background Agents (2):**
- `compound-documenter` - Removed CRITICAL, softened MUST
- `prompt-optimizer` - Replaced "Think step by step"

**Design Agents (1):**
- `design-iterator` - Replaced "think outside the box"

### Why This Change

Claude Opus 4.5 has different behavioral characteristics than previous models:

1. **More sensitive to emphatic language** - CRITICAL/MUST/NEVER can trigger over-compliance and excessive tool usage
2. **Thinking token sensitivity** - Words like "think" can cause unnecessarily long internal reasoning chains
3. **Better baseline behavior** - Opus 4.5 follows instructions well without aggressive emphasis

### Migration

No breaking changes. Agent functionality remains identical, but prompts are now optimized for Opus 4.5's characteristics.

### References

- [Claude Opus 4.5 Migration Skill](https://github.com/claude-code-plugins)
- [Anthropic Model Behavior Guidelines](https://docs.anthropic.com/)

---

## [1.16.3] - 2025-12-25

### Fixed - Agent Description YAML Parsing

**Fixed 20 agents that had broken descriptions due to YAML multi-line block scalar format.**

### Fixed

- **Core agents**: sisyphus-orchestrator, oracle, librarian, document-writer, frontend-engineer
- **Workflow agents**: acms-lint, acms-spec-flow-analyzer, acms-pr-comment-resolver, acms-bug-reproduction-validator
- **Research agents**: framework-docs-researcher, best-practices-researcher, git-history-analyzer, repo-research-analyst
- **Design agents**: figma-design-sync, design-iterator, design-implementation-reviewer
- **Specialist agents**: architecture-strategist, performance-oracle, pattern-recognition-specialist, data-integrity-guardian

### Root Cause

Claude Code's YAML parser doesn't correctly parse multi-line block scalar format (`description: |`). The parser only captured the `|` character and ignored the actual description text on subsequent lines.

### Solution

Converted all agent descriptions from multi-line format:
```yaml
description: |
  Long description
  spanning multiple lines
```

To single-line format:
```yaml
description: Concise single-line description with key capabilities.
```

This ensures all agents are now properly registered and accessible via the Task tool.

---

## [1.16.2] - 2025-12-23

### Removed - All Noisy Hooks

**Removed all remaining noisy hooks that generated system reminder messages.**

### Removed

- **`UserPromptSubmit`** hook category entirely (including prevent-sleep.sh)
- **`Stop`** hook category entirely (including allow-sleep.sh)
- **`SessionStart`** hook category entirely (including context-persistence.py)
- **`PreCompact`** hook category entirely (including context-persistence.py)
- **`context-persistence.py`** from SessionEnd hooks
- **`version-reminder.py`** from SubagentStop hooks

### Remaining Hooks

Only essential, low-noise hooks remain:
- **SessionEnd**: `session-insights-trigger.py` (runs once at session end)
- **SubagentStop**: `background-agents-trigger.py` (spawns background agents after task completion)

### Why This Change

The removed hooks were firing frequently and generating noisy "Success" messages in system reminders, cluttering the conversation context without providing significant value.

---

## [1.16.1] - 2025-12-23

### Removed - Noisy UserPromptSubmit Hooks

**Removed sisyphus-orchestrator-trigger and prompt-optimizer-trigger from UserPromptSubmit hooks.**

### Removed

- **`sisyphus-orchestrator-trigger.py`** from UserPromptSubmit hooks
- **`prompt-optimizer-trigger.py`** from UserPromptSubmit hooks

### Why This Change

These hooks fired on every user prompt and generated noisy "Success" messages in the system reminders. The prevent-sleep hook remains active for Mac sleep prevention during sessions.

---

## [1.13.1] - 2025-12-17

### Fixed - Explicit EnterPlanMode Prohibition

**Added explicit instruction to NEVER use Claude's `EnterPlanMode` tool.**

### Fixed

- **`/acms-plan` command**: Added critical warning against using `EnterPlanMode` tool
  - Clear blockquote warning: "DO NOT use `EnterPlanMode` tool!"
  - Instruction to always write plan to `plans/<slug>.md` using Write tool
  - Updated note about command output being a Markdown file

### Why This Fix

Claude Code has a built-in `EnterPlanMode` tool that switches to a read-only mode. The `/acms-plan` command is designed to write a Markdown plan file, not enter this mode. This explicit prohibition prevents confusion between:

1. **Claude's EnterPlanMode** - Read-only mode, no file creation
2. **`/acms-plan`** - Writes `plans/<slug>.md` file through collaboration

---

## [1.13.0] - 2025-12-17

### Changed - Interactive `/acms-plan` Command

**`/acms-plan` now uses iterative user feedback at each planning phase.**

Instead of generating a complete plan in one go, the command now:
1. Presents each phase for review
2. Asks for user feedback using `AskUserQuestion`
3. Allows adjustments before proceeding
4. Only writes the final plan after all phases are approved

### Changed

- **`/acms-plan` workflow**: Now interactive with 7 phases
  - Phase 1: Understand Task → GET FEEDBACK
  - Phase 2: Research & DRY Analysis → GET FEEDBACK
  - Phase 3: Technical Approach → GET FEEDBACK
  - Phase 4: Implementation Steps → GET FEEDBACK
  - Phase 5: Acceptance Criteria → GET FEEDBACK
  - Phase 6: Write Final Plan (only after all approvals)
  - Phase 7: Open in Typora + Offer Next Steps

- **Clear distinction from native Plan Mode**:
  - Native Plan Mode (`--permission-mode plan`) = Read-only, blocks writes
  - `/acms-plan` = Collaborative planning that WRITES a plan document
  - Added explanation in command header

- **Visual flow diagram**: Added ASCII flowchart showing the interactive process

- **Specialist table**: Combined selection guide with recommended model tier

### Why This Change

1. **User control**: Each phase can be adjusted before proceeding
2. **Prevents wasted effort**: Catch misunderstandings early, not after full plan
3. **Better collaboration**: Plan is co-created, not just generated
4. **Opus 4.5 optimized**: Prompt structure improved for latest model

### Migration

No breaking changes. The command now asks for confirmation at each step.

---

## [1.12.0] - 2025-12-16

### BREAKING CHANGE - Review Agents → Dual-Purpose Specialists

**All 18 review agents renamed and enhanced to serve as dual-purpose specialists.**

Specialists can now be used for:
1. **Implementation Guidance** - Get correct patterns BEFORE implementing code
2. **Code Review** - Review code AFTER implementation

### Breaking Changes

- **Directory renamed**: `agents/review/` → `agents/specialists/`
- **Agent references changed**: `adessocms-engineering:review:*-reviewer` → `adessocms-engineering:specialists:*-specialist`

### Agent Renames

| Old Name | New Name |
|----------|----------|
| `drupal-reviewer` | `drupal-specialist` |
| `twig-template-reviewer` | `twig-specialist` |
| `drupal-theme-reviewer` | `drupal-theme-specialist` |
| `tailwind-reviewer` | `tailwind-specialist` |
| `storybook-reviewer` | `storybook-specialist` |
| `accessibility-reviewer` | `accessibility-specialist` |
| `composer-dependency-reviewer` | `composer-specialist` |
| `test-coverage-reviewer` | `test-coverage-specialist` |
| `sdc-best-practices-reviewer` | `sdc-specialist` |
| `paragraphs-best-practices-reviewer` | `paragraphs-specialist` |
| `dry-component-reuse-reviewer` | `component-reuse-specialist` |
| `architecture-strategist` | `architecture-strategist` (unchanged) |
| `code-simplicity-reviewer` | `code-quality-specialist` |
| `data-integrity-guardian` | `data-integrity-guardian` (unchanged) |
| `pattern-recognition-specialist` | `pattern-recognition-specialist` (unchanged) |
| `performance-oracle` | `performance-oracle` (unchanged) |
| `security-sentinel` | `security-sentinel` (unchanged) |
| `dries-drupal-reviewer` | `dries-drupal-specialist` |

### Agent Enhancements

Each specialist now has:
- **Dual-purpose structure**: "For Implementation Guidance" + "For Code Review" sections
- **Implementation Guidelines**: Code examples and patterns for correct implementation
- **Integration with `/acms-work`**: Consult specialists before implementing complex tasks

### Workflow Updates

**`/acms-plan`**:
- Added "Consult Specialists for Guidance" section
- Specialist table showing which specialist to use for each task type
- Plan template includes "Specialist Guidance Required" section

**`/acms-work`**:
- Added Phase 2 specialist consultation step
- Consult specialists BEFORE implementing complex functionality
- Updated agent references to use new specialist paths

**`/acms-review`**:
- Updated all agent paths to use specialists
- Same parallel review capabilities with new naming

### Why This Change

1. **Proactive guidance**: Get correct patterns BEFORE writing code, not just review AFTER
2. **Consistent naming**: "Specialist" better reflects dual-purpose nature
3. **Reduced rework**: Implementing correctly from the start saves iteration cycles
4. **Better integration**: Specialists now integral part of plan → work → review flow

### Migration

Update any custom scripts or hooks that reference agents:

```bash
# Old
Task(subagent_type="adessocms-engineering:review:drupal-reviewer", ...)

# New
Task(subagent_type="adessocms-engineering:specialists:drupal-specialist", ...)
```

---

## [1.11.1] - 2025-12-14

### Changed - Playwright MCP Isolation

**Added `--isolated` flag to Playwright MCP server configuration.**

### Changed

- **Playwright MCP**: Added `--isolated` flag for isolated browser contexts
  - Each browser session runs in complete isolation
  - No shared cookies, storage, or state between sessions
  - Improves security and test reliability

---

## [1.11.0] - 2025-12-14

### Added - Landing Page Optimizer Skill

**New skill for planning and optimizing landing pages in Drupal/adesso CMS.**

### Added

- **`landing-page-optimizer` skill** - Plan and build high-converting landing pages
  - AIDA framework (Attention → Interest → Desire → Action) for page structure
  - Page type detection: Homepage, Service, Product, Category
  - B2B/B2C audience analysis
  - adesso CMS paragraph type mapping (hero, card_group, sidebyside, statistic, etc.)
  - Conversion checklist for optimization
  - Reference files:
    - `references/adesso-cms-components.md` - Paragraph types and field mappings
    - `references/section-templates.md` - Detailed section templates
    - `references/conversion-patterns.md` - Proven conversion patterns

### Use Cases

- Creating new landing pages from scratch
- Analyzing and optimizing existing pages
- Planning content structure for sales pages
- Building homepage or category layouts

### Skill Count

- Before: 16 skills
- After: 17 skills (+1 landing-page-optimizer)

---

## [1.10.1] - 2025-12-14

### Fixed - SDC Documentation Accuracy

**Corrected SDC patterns based on official Drupal.org documentation research.**

### Fixed

- **`paragraphs-best-practices-reviewer`**: Corrected field template patterns
  - Field templates should delegate to SDC, not duplicate markup
  - Added "When to Use Field Templates" guidance
  - Showed correct pattern: SDC controls `<h2>`, not field template
  - Added "No Field Template - Handle in Paragraph Template" as BEST approach

- **`sdc-best-practices-reviewer`**: Added heading component pattern
  - New section: "6. Heading Component Pattern"
  - Shows `heading_html_tag` prop pattern for semantic heading levels
  - Added `only` keyword guidance for embed
  - Updated checklist: "Semantic HTML only in SDC, NOT Drupal templates"

- **`drupal-theme-reviewer`**: Fixed prop drilling anti-pattern in examples
  - Changed `image.url`/`image.alt` props → `image` slot
  - Added `heading_html_tag` prop to card example
  - Added "Using the Component" section with embed + only pattern

- **`twig-template-reviewer`**: Updated SDC examples
  - Added Props vs Slots distinction in component docblock
  - Added Key SDC Principles section
  - Updated component.yml with proper slots

### Key Corrections

1. **Semantic HTML Ownership**: `<h1>`-`<h6>`, `<figure>`, `<blockquote>` etc. should ONLY exist in SDC components, never in Drupal templates or field templates

2. **Prop Drilling Anti-Pattern**: Image URL/alt as separate props is wrong - use slot for rendered field that preserves cache metadata

3. **embed with only**: Always use `{% embed 'theme:component' with {...} only %}` to prevent context leaking

4. **Field Templates with SDC**: If using SDC, field templates should either:
   - Delegate to SDC component (call include/embed)
   - Or not be used at all (handle in paragraph template)

### Sources

- [Drupal.org SDC Documentation](https://www.drupal.org/docs/develop/theming-drupal/using-single-directory-components)
- [Props and Slots Guide](https://www.drupal.org/docs/develop/theming-drupal/using-single-directory-components/what-are-props-and-slots-in-drupal-sdc-theming)
- [ChromaticHQ SDC + Paragraphs](https://chromatichq.com/insights/dynamic-duo-sdc-paragraphs/)

---

## [1.10.0] - 2025-12-14

### Removed - Gemini Integration

**Gemini completely removed from the plugin.**

### Removed

- **`gemini-brainstorm` agent** - External Gemini architecture brainstorming
- **`gemini-reviewer` agent** - External Gemini review cross-check
- **`plans/optional-gemini-planner.md`** - Gemini planning template

### Changed

- **`/acms-plan`**: Removed Gemini architecture draft step
  - Planning now uses Claude agents only (repo-research-analyst, best-practices-researcher, framework-docs-researcher)
  - No external API dependencies
- **`/acms-review`**: Removed Gemini cross-check section
  - Reviews use parallel Claude agents only
- **README.md**: Removed Gemini Integration section, updated agent counts

### Why This Change

1. Simplifies plugin - no external dependencies
2. Claude agents provide comprehensive research and review
3. Removes latency from external API calls
4. All planning and reviews handled by specialized Claude agents

### Agent Count

- Before: 31 agents
- After: 29 agents (-2 Gemini agents)

---

## [1.9.0] - 2025-12-14

### Added - SDC, Paragraphs, and DRY Review Agents

**3 new specialized review agents for frontend best practices.**

### New Agents

- **`sdc-best-practices-reviewer`** - Reviews Single Directory Components
  - Props vs Slots design decisions
  - component.yml schema validation
  - JSON Schema best practices
  - Cache-safe integration patterns
  - Component replacement requirements

- **`paragraphs-best-practices-reviewer`** - Reviews Paragraphs implementations
  - Field template overrides vs `.value` access (CRITICAL)
  - SDC integration with `{% embed %}` / `{% include %}`
  - Cache metadata preservation
  - Preprocess function usage
  - Paragraph View Modes

- **`dry-component-reuse-reviewer`** - Reviews DRY principle adherence
  - Component reuse analysis
  - Atomic Design violations
  - CSS/Tailwind duplication
  - PHP preprocess duplication
  - "3 occurrences before abstraction" rule

### Changed

- **`/acms-review`**: Added 3 new agents to review workflow
  - SDC Components → sdc-best-practices, dry-component-reuse, storybook
  - Paragraphs → paragraphs-best-practices, sdc-best-practices
  - All frontend → dry-component-reuse (DRY always checked)

- **`/acms-plan`**: Added DRY Analysis section
  - Step 1b: Search existing components before designing new
  - "Component Reuse Analysis" section in plan template
  - DRY questions checklist

### Why These Agents

**SDC Best Practices**: Props vs Slots is a critical design decision that affects caching, maintainability, and composition. This reviewer ensures components follow Drupal's SDC patterns.

**Paragraphs Best Practices**: The `.value` anti-pattern breaks Drupal's render caching. This reviewer enforces field template overrides and proper render array handling.

**DRY Component Reuse**: Before creating new components, always check if existing ones can be extended. This reviewer prevents unnecessary duplication and enforces atomic design principles.

### Sources

- [Drupal SDC Documentation](https://www.drupal.org/docs/develop/theming-drupal/using-single-directory-components)
- [UI Patterns Best Practices](https://project.pages.drupalcode.org/ui_patterns/2-authors/2-best-practices)
- [Paragraphs + SDC Integration](https://chromatichq.com/insights/dynamic-duo-sdc-paragraphs/)
- [Claude Opus 4.5 Migration Skill](https://github.com/claude-code-plugins) - Prompt engineering patterns

---

## [1.8.4] - 2025-12-12

### Changed - Restore 3 Claude Agents, Gemini Optional, Playwright MCP

**`/acms-plan` now uses 3 parallel Claude agents as primary research, with Gemini as optional.**

This reverts the v1.8.3 change that made Gemini required.

### Changed

- **`/acms-plan` workflow**: Restored 3 parallel Claude agents as Step 2
  - `repo-research-analyst` - Analyzes codebase for patterns
  - `best-practices-researcher` - Finds Drupal best practices
  - `framework-docs-researcher` - Gathers framework documentation
- **Gemini moved to Step 2b (Optional)**
  - Use for complex architectural decisions
  - Non-blocking if unavailable
- **Plan template updated**:
  - "Research Findings" section with 3 agent subsections
  - "Gemini Architecture Draft" marked as optional

### Added

- **Playwright MCP server** re-added for browser automation
  - Now 2 MCP servers: Playwright + Context7
  - Complements dev-browser skill for different use cases

### Why This Change

1. Not everyone has Gemini CLI installed
2. 3 parallel Claude agents provide comprehensive multi-perspective research
3. Gemini adds latency (external API call)
4. Multi-agent synthesis often better than single-AI perspective
5. Gemini remains available as enhancement for complex decisions
6. Playwright MCP provides additional browser automation capabilities

---

## [1.8.3] - 2025-12-12

### Changed - Gemini as Primary Architecture Source

**`/acms-plan` now requires Gemini for initial architecture draft.**

Based on [EveryInc/compound-engineering-plugin#34](https://github.com/EveryInc/compound-engineering-plugin/issues/34).

### Changed

- **`/acms-plan` workflow**: Gemini brainstorm is now REQUIRED (not optional)
  - Step 2 calls `gemini-brainstorm` agent before any research
  - Gemini provides: Architecture recommendations, trade-offs, risks, alternatives
  - Technical approach is built on Gemini's draft
- **Plan template**: New "Gemini Architecture Draft" section
  - Recommendations
  - Trade-offs table
  - Risks & Mitigations
- **Graceful fallback**: If Gemini unavailable, continues with note in plan

### Why This Change

Getting a second AI perspective (Gemini 3 Pro) on architecture decisions early in planning helps:
1. Catch blind spots in initial approach
2. Surface alternative implementation strategies
3. Identify risks before implementation begins
4. Provide trade-off analysis with different AI reasoning

---

## [1.8.2] - 2025-12-12

### Changed - Workflow Commands and Agents Renamed with acms- Prefix

**Renamed workflow commands to avoid naming conflicts with other plugins.**

Commands:
- `/plan` → `/acms-plan`
- `/review` → `/acms-review`
- `/work` → `/acms-work`
- `/compound` → `/acms-compound`
- `/codify` → `/acms-codify`

Agents:
- `bug-reproduction-validator` → `acms-bug-reproduction-validator`
- `lint` → `acms-lint`
- `pr-comment-resolver` → `acms-pr-comment-resolver`
- `spec-flow-analyzer` → `acms-spec-flow-analyzer`

---

## [1.8.0] - 2025-12-12

### Removed - Triage and Duplicated dev-browser

**Simplified plugin by removing triage workflow and dev-browser duplication.**

### Removed

- **`/triage` command** - Triage decisions are made by the user before planning
- **Bundled dev-browser skill** - Now references externally installed skill
  - Removed ~150MB of node_modules from plugin
  - Users must install `SawyerHood/dev-browser` marketplace separately
  - `/plan` workflow already uses `Skill(skill="dev-browser")` correctly

### Changed

- **dev-browser is now a prerequisite** - Install via `/plugin marketplace add SawyerHood/dev-browser`
- **Component counts**: 28 agents, 21 commands, 16 skills, 1 MCP server
- **Updated README** with Prerequisites section and troubleshooting

### Why This Change

1. **No duplication**: dev-browser skill should be installed once, not bundled
2. **Simpler triage**: Users decide what to plan - no intermediate triage step needed
3. **Smaller plugin**: Removed unnecessary node_modules bloat

---

## [1.7.0] - 2025-12-11

### Added - dev-browser Skill

**Migrated from Playwright MCP to dev-browser skill for persistent browser automation.**

### Added

- **dev-browser skill** - Browser automation with persistent page state
  - Maintains browser state across script executions
  - ARIA snapshot for element discovery (`getAISnapshot()`)
  - Stable element refs for interactions (`selectSnapshotRef()`)
  - Works with local/DDEV sites out of the box

### Removed

- **Playwright MCP server** - Replaced by dev-browser skill
  - More reliable persistent state
  - Better element discovery with ARIA snapshots
  - Simpler script-based approach

### Changed

- Plugin now has 1 MCP server (context7) instead of 2
- Browser automation via skill instead of MCP tools

### Usage

```bash
# Set path variable
export DEV_BROWSER_DIR="$HOME/.claude/plugins/marketplaces/adessocms-marketplace/plugins/adessocms-engineering/skills/dev-browser"

# Start server
$DEV_BROWSER_DIR/server.sh &

# Run scripts
cd $DEV_BROWSER_DIR && bun x tsx <<'EOF'
import { connect, waitForPageLoad } from "@/client.js";
const client = await connect("http://localhost:9222");
const page = await client.page("main");
await page.goto("https://eab.ddev.site");
await waitForPageLoad(page);
console.log({ title: await page.title(), url: page.url() });
await client.disconnect();
EOF
```

---

## [1.6.0] - 2025-12-11

### Added - Plan Triage Agent for Token Optimization

**New orchestrator agent that right-sizes planning effort based on task complexity.**

### Added

- **plan-triage agent** - Opus-based orchestrator that classifies tasks and acts accordingly
  - TRIVIAL: Writes minimal plan with commands (no research agents)
  - SIMPLE: Writes checklist plan (no research agents)
  - COMPLEX: Spawns research agents in parallel, synthesizes comprehensive plan
- **Consistent markdown output** - ALL classifications produce `plans/<slug>.md`

### Changed

- `/plan` workflow: Now delegates entirely to plan-triage agent
  - Single agent invocation instead of hardcoded 3 parallel research agents
  - Research agents only spawned for COMPLEX tasks
  - Plan file always created and opened in Typora

### Token Savings

| Task Type | Before (v1.5) | After (v1.6) | Savings |
|-----------|---------------|--------------|---------|
| TRIVIAL (install module) | ~150k tokens | ~15k tokens | 90% |
| SIMPLE (add field) | ~150k tokens | ~25k tokens | 83% |
| COMPLEX (SSO integration) | ~150k tokens | ~150k tokens | 0% (appropriate) |

### Example Classifications

| Task | Classification | Research Agents |
|------|----------------|-----------------|
| "Install drupal/memcache" | TRIVIAL | None |
| "Add phone field to contact" | SIMPLE | None |
| "Implement Azure AD SSO" | COMPLEX | 3 parallel |

---

## [1.5.0] - 2025-12-11

### Changed - Token Optimization & Simplified Architecture

**BREAKING: Major simplification for token efficiency**

This release removes ~50,000 tokens of overhead per workflow cycle by eliminating Beans and simplifying Gemini integration.

### Removed

- **Beans System** - Replaced with native TodoWrite for task tracking
- **beans-maintainer agent** - No longer needed
- **gemini-coauthor skill** - Replaced with simple CLI agents
- **Strategic Checkpoints** - Removed 4x Gemini calls during /work
- **Opus model tier** - All agents now use Sonnet or Haiku

### Added

- **gemini-brainstorm agent** - Simple CLI-based architecture brainstorming (optional)
- **gemini-reviewer agent** - Simple CLI-based review cross-check (optional)

### Modified

- `/plan` workflow: Uses TodoWrite instead of Beans, Gemini is optional
- `/work` workflow: Uses TodoWrite, no strategic checkpoints, simpler flow
- `/review` workflow: Direct markdown output instead of Beans, Gemini optional
- **Critical agents**: Removed model field (inherits session model)
  - dries-drupal-reviewer, security-sentinel, performance-oracle, architecture-strategist
- **Standard agents**: Changed from Opus to Sonnet
  - design-iterator: opus → sonnet

### Token Savings

| Component | Before | After | Savings |
|-----------|--------|-------|---------|
| Beans (per cycle) | ~30,000 | 0 | -30,000 |
| Gemini Checkpoints | ~20,000 | 0-2,000 | -18,000+ |
| Opus Agents (5x) | ~25,000 | ~8,000 | -17,000 |
| **Total** | ~75,000 | ~10,000 | **~65,000** |

### Model Tier Strategy (EveryInc-Style)

| Model | Count | Use Case |
|-------|-------|----------|
| *(none)* | 8 | Critical analysis, design review - inherits session model |
| sonnet | 14 | Standard reviews, external research |
| haiku | 6 | Local research, simple tasks, CLI |

### Gemini Integration

Gemini is now **optional and non-blocking**:
- Only invoked when explicitly requested
- Uses simple CLI: `gemini -m gemini-3-pro-preview -p "..." --output-format json`
- Failures are ignored (graceful degradation)

### Migration

1. Remove any Beans hooks from `~/.claude/settings.json`
2. TodoWrite now handles all task tracking
3. Gemini agents are opt-in, not automatic

---

## [1.4.0] - 2025-12-10

### Changed - Architecture-First with Gemini 3 Pro

**Note: This version was superseded by 1.5.0 due to high token usage.**

- Gemini 3 Pro as Strategic Architect
- Beans integration for task tracking
- Strategic checkpoints during /work

---

# Changelog

All notable changes to the adessocms-engineering plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2024-12-08

### Added

- **New Skill**: `generate-user-handbook` - Generiert vollständige Benutzerhandbücher für Drupal-Backends
  - Automatisches Login und Screenshot-Erstellung via Playwright
  - MkDocs Material Theme mit deutscher Lokalisierung
  - Schritt-für-Schritt Anleitungen für technisch unbedarfte Nutzer
  - 3 Workflows: generate-handbook, capture-section, update-handbook
  - Umfangreiche References für Schreibstil und Screenshot-Guidelines
- **New Command**: `/generate-user-handbook` - Startet die Handbuch-Generierung

---

## [1.1.0] - 2024-12-08

### Added

- **New Skill**: `create-drupal-case-study` - Generate Drupal.org case study submissions
  - Analyzes project codebase (composer.json, modules, theme, config)
  - Asks targeted questions about client, goals, and outcomes
  - Creates structured sections ready for Drupal.org submission
  - Optional Playwright-based screenshot capture of live sites
- **New Command**: `/create-drupal-case-study` - Invoke case study generation skill

---

## [1.0.0] - 2024-12-07

Initial release of the adessocms-engineering plugin, forked from compound-engineering and adapted for Drupal 11 development.

### Added

**9 New Drupal-Specific Agents**

*Review Agents*
- `drupal-reviewer` - Drupal coding standards, API usage, and best practices
- `dries-drupal-reviewer` - Brutally honest Drupal review from Dries Buytaert's perspective
- `twig-template-reviewer` - Twig templates, security, Drupal patterns, SDC
- `drupal-theme-reviewer` - Theme implementations, SDC, preprocess functions, libraries
- `tailwind-reviewer` - Tailwind CSS v4 syntax, Vite integration, Drupal theming
- `storybook-reviewer` - Storybook stories, SDC integration, interaction tests
- `accessibility-reviewer` - WCAG 2.1 Level AA, ARIA, semantic HTML, keyboard nav
- `composer-dependency-reviewer` - Composer dependencies, security, Drupal contrib
- `test-coverage-reviewer` - PHPUnit, Kernel, Functional, Playwright, Vitest coverage

**4 Drupal Skills from grasmash/drupal-claude-skills**
- `drupal-at-your-fingertips` - Comprehensive Drupal patterns (50+ topics)
- `drupal-config-mgmt` - Configuration management best practices
- `drupal-contrib-mgmt` - Contrib module management and patching
- `drupal-ddev` - DDEV integration and workflows
- `ivangrynenko-cursorrules-drupal` - Drupal security guidelines (OWASP)

### Changed

- **Plugin renamed** from `compound-engineering` to `adessocms-engineering`
- **Keywords updated** for Drupal, PHP, Twig, Tailwind, Storybook
- **MCP Servers** retained: Playwright and Context7 (useful for all projects)

### Removed

**7 Language-Specific Agents** (Rails/Ruby/Python/TypeScript)
- `kieran-rails-reviewer`
- `kieran-python-reviewer`
- `kieran-typescript-reviewer`
- `dhh-rails-reviewer`
- `julik-frontend-races-reviewer`
- `ankane-readme-writer`
- `every-style-editor`

**5 Language-Specific Skills** (Ruby)
- `andrew-kane-gem-writer`
- `dhh-ruby-style`
- `dspy-ruby`
- `every-style-editor`
- `gemini-imagegen`

### Summary

| Component | Original | adessocms | Change |
|-----------|----------|-----------|--------|
| Agents | 24 | 26 | +2 (9 new, -7 removed) |
| Commands | 19 | 19 | unchanged |
| Skills | 11 | 11 | +5 Drupal, -5 Ruby |
| MCP Servers | 2 | 2 | unchanged |

### Tech Stack Focus

This plugin is optimized for:
- **CMS**: Drupal 11.x
- **Backend**: PHP 8.3, MariaDB
- **Frontend**: Vite, Tailwind CSS v4, Flowbite
- **Components**: Single Directory Components (SDC)
- **Testing**: PHPUnit, Playwright, Vitest, Storybook
- **Dev Environment**: DDEV

---

## Acknowledgments

Based on [compound-engineering](https://github.com/EveryInc/every-marketplace) by Kieran Klaassen and Every.to.

Drupal skills integrated from [drupal-claude-skills](https://github.com/grasmash/drupal-claude-skills) by Matthew Grasmick.
