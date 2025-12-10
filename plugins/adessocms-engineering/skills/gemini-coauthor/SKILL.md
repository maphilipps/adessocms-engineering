---
name: gemini-coauthor
description: Integrates Gemini 3 Pro as Strategic Architect for architecture decisions, system design, and strategic oversight. Claude Opus 4.5 handles implementation. Use for architecture-first planning and strategic validation during complex features.
---

<essential_principles>
## How Gemini Strategic Architect Works

**Gemini 3 Pro = Strategic Architect** (architecture, system design, oversight)
**Claude Opus 4.5 = Implementation Expert** (code, details, execution)

This skill enables Gemini 3 Pro to act as Strategic Architect, making architectural decisions and providing strategic oversight while Claude handles implementation.

### Principle 1: Availability Check First

Before using Gemini, ALWAYS check if it's available:
```bash
which gemini >/dev/null 2>&1 && echo "available" || echo "unavailable"
```

If unavailable, skip Gemini integration gracefully and continue without it.

### Principle 2: Yolo Mode for Autonomous Operation

Gemini runs in yolo mode (`-y` flag) to auto-approve actions:
```bash
gemini -y "your prompt here"
```

This enables autonomous operation without manual approval prompts.

### Principle 3: Non-Blocking Integration

Gemini is a helper, not a blocker. If Gemini:
- Times out: Continue without its input
- Returns errors: Log and continue
- Disagrees: Present both perspectives to user

### Principle 4: Typora for Plan Files

When available, open plan files in Typora for better editing experience:
```bash
open -a Typora "plans/my-plan.md" 2>/dev/null || open "plans/my-plan.md"
```
</essential_principles>

<integration_points>
## When to Invoke Gemini 3 Pro

Gemini acts as Strategic Architect at these critical points:

| Workflow | Integration Point | Purpose | Gemini Role |
|----------|-------------------|---------|-------------|
| `/plan` | FIRST (after research) | Design system architecture | Strategic Architect |
| `/plan` | Before Claude plans | Technology decisions, trade-offs | Strategic Architect |
| `/work` | Strategic checkpoints | Verify architecture alignment | Strategic Overseer |
| `/work` | Final validation | Approve implementation | Strategic Validator |
</integration_points>

<intake>
What would you like Gemini 3 Pro Strategic Architect to do?

1. **Architecture Design** - Design system architecture for a feature (CRITICAL for /plan)
2. **Strategic Checkpoint** - Review implementation progress for architecture alignment
3. **Architecture Validation** - Final validation before PR (implementation complete?)
4. **Check availability** - Test if Gemini CLI is available

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Workflow |
|----------|----------|
| 1, "architecture", "design", "architect" | `workflows/architecture-design.md` |
| 2, "checkpoint", "strategic", "review progress" | `workflows/strategic-checkpoint.md` |
| 3, "validation", "final", "approve", "complete" | `workflows/architecture-validation.md` |
| 4, "available", "check", "test" | Run availability check inline |

**After reading the workflow, follow it exactly.**
</routing>

<availability_check>
## Quick Availability Check

```bash
# Check Gemini availability
if which gemini >/dev/null 2>&1; then
  echo "Gemini CLI: available"
  gemini --version 2>/dev/null || echo "(version unknown)"
else
  echo "Gemini CLI: NOT available"
  echo "Install: npm install -g @anthropic-ai/gemini-cli"
fi

# Check Typora availability
if [ -d "/Applications/Typora.app" ]; then
  echo "Typora: available"
else
  echo "Typora: NOT available"
fi
```
</availability_check>

<gemini_prompts>
## Standard Gemini Prompts

Use these prompt templates when invoking Gemini:

**Verify Understanding:**
```
Review this task description and summarize your understanding in 3-5 bullet points.
Then list any ambiguities or questions that should be clarified.

Task: [TASK_DESCRIPTION]
```

**Co-Plan Review:**
```
Review this plan for completeness. Check:
1. Are all acceptance criteria testable?
2. Are there missing edge cases?
3. Is the technical approach sound?
4. Any obvious gaps or risks?

Plan:
[PLAN_CONTENT]
```

**Implementation Verification:**
```
Compare this implementation against the original plan.
List what was completed vs what might be missing.

Plan: [PLAN_CONTENT]

Implementation diff: [GIT_DIFF]
```
</gemini_prompts>

<workflows_index>
| Workflow | Purpose |
|----------|---------|
| verify-understanding.md | Ensure Claude and Gemini have same interpretation |
| co-plan.md | Get Gemini's input during plan creation |
| review-output.md | Cross-check review findings with Gemini |
| verify-implementation.md | Verify implementation matches plan |
</workflows_index>

<scripts_index>
| Script | Purpose |
|--------|---------|
| check-gemini.sh | Check if Gemini CLI is available |
| open-in-typora.sh | Open markdown file in Typora |
| ask-gemini.sh | Send prompt to Gemini and get response |
</scripts_index>

<success_criteria>
Gemini co-author integration is successful when:
- Gemini availability is checked before use
- Gemini runs in yolo mode for autonomous operation
- Failures are handled gracefully (non-blocking)
- Both Claude and Gemini perspectives are presented when they differ
- Plans open in Typora when available
</success_criteria>
