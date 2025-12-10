---
name: gemini-coauthor
description: Integrates Gemini CLI as a co-author to assist with planning, verification, and review workflows. Use when you need a second opinion or parallel verification during complex tasks.
---

<essential_principles>
## How Gemini Co-Author Works

This skill enables Gemini CLI to act as a co-author, providing a second perspective during planning and implementation workflows.

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
## When to Invoke Gemini

Gemini should be consulted at these workflow points:

| Workflow | Integration Point | Purpose |
|----------|-------------------|---------|
| `/plan` | After requirements gathering | Verify understanding of user input |
| `/plan` | After plan draft | Review plan structure and completeness |
| `/plan_review` | After agents return | Cross-check review findings |
| `/work` | After implementation | Verify plan was fully implemented |
</integration_points>

<intake>
What would you like to do?

1. **Verify understanding** - Check if Claude and Gemini interpret the task the same way
2. **Co-plan** - Get Gemini's input on a plan draft
3. **Review output** - Have Gemini cross-check review findings
4. **Verify implementation** - Check if implementation matches the plan
5. **Check availability** - Test if Gemini CLI is available

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Workflow |
|----------|----------|
| 1, "verify", "understanding", "interpret" | `workflows/verify-understanding.md` |
| 2, "co-plan", "plan", "draft" | `workflows/co-plan.md` |
| 3, "review", "check", "findings" | `workflows/review-output.md` |
| 4, "implementation", "verify impl", "complete" | `workflows/verify-implementation.md` |
| 5, "available", "check", "test" | Run availability check inline |

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
