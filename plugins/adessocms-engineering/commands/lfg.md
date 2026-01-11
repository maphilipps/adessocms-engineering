---
name: lfg
description: Full autonomous engineering workflow
argument-hint: "[feature description]"
---

Run these slash commands in order. Do not do anything else.

**Step 1:** Use the Skill tool to invoke `ralph-loop:ralph-loop` with args: `"finish all slash commands" --completion-promise "DONE"`

Then execute these commands in sequence:
- `/adessocms-engineering:workflows:plan $ARGUMENTS`
- `/adessocms-engineering:deepen-plan`
- `/adessocms-engineering:workflows:work`
- `/adessocms-engineering:workflows:review`
- `/adessocms-engineering:resolve-todo-parallel`
- `/adessocms-engineering:workflows:compound`
- `/adessocms-engineering:playwright-test`
- `/adessocms-engineering:feature-video`
- Output `<promise>DONE</promise>` when video is in PR

Start with Step 1 now - invoke the Skill tool with skill="ralph-loop:ralph-loop".
