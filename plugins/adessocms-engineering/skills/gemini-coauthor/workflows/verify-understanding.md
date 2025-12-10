# Workflow: Verify Understanding

<purpose>
Ensure Claude and Gemini have the same interpretation of the user's task before proceeding with planning or implementation.
</purpose>

<when_to_use>
- At the start of `/plan` workflow after gathering initial requirements
- When a task description is ambiguous
- Before starting complex implementations
</when_to_use>

<process>
## Step 1: Check Gemini Availability

```bash
if ! which gemini >/dev/null 2>&1; then
  echo "SKIP: Gemini not available, continuing without co-author verification"
  exit 0
fi
```

If unavailable, skip this workflow and continue.

## Step 2: Prepare Task Summary

Summarize the user's request in your own words:
- What is being asked?
- What is the expected outcome?
- What constraints or requirements exist?

## Step 3: Send to Gemini

```bash
gemini -y "Review this task and provide your understanding in 3-5 bullet points.
Then list any ambiguities or questions that need clarification.

Task Description:
[INSERT_TASK_DESCRIPTION]

Claude's Understanding:
[INSERT_YOUR_SUMMARY]

Do you agree with this interpretation? If not, what differs?"
```

## Step 4: Compare Interpretations

Analyze Gemini's response:

**If interpretations align:**
- Note agreement
- Proceed with confidence

**If interpretations differ:**
- Identify specific differences
- Formulate joint clarifying questions
- Present both interpretations to user with questions

## Step 5: Formulate Joint Questions (if needed)

If there are differences or ambiguities:

```markdown
## Clarification Needed

Both Claude and Gemini reviewed your request. We have some questions:

**Claude's Understanding:**
[Your interpretation]

**Gemini's Understanding:**
[Gemini's interpretation]

**Joint Questions:**
1. [Question about ambiguity 1]
2. [Question about ambiguity 2]

Please clarify so we can proceed with the correct understanding.
```

Use `AskUserQuestion` tool to present these options and questions.
</process>

<success_criteria>
- Gemini availability checked
- Both interpretations documented
- Differences identified and resolved
- Joint clarifying questions formulated if needed
- User has confirmed the correct understanding
</success_criteria>
