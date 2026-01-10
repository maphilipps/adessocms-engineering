---
name: lfg
description: Full autonomous engineering workflow
argument-hint: "[feature description]"
---

Run these slash commands in order. Do not do anything else.

1. `/ralph-loop:ralph-loop "finish all slash commands" --completion-promise "DONE"`
2. `/adessocms-engineering:workflows:plan $ARGUMENTS`
3. `/adessocms-engineering:deepen-plan`
4. `/adessocms-engineering:workflows:work`
5. `/adessocms-engineering:workflows:review`
6. `/adessocms-engineering:resolve-todo-parallel`
7. `/adessocms-engineering:compound`
8. `/adessocms-engineering:playwright-test`
9. `/adessocms-engineering:feature-video`
10. Output `<promise>DONE</promise>` when video is in PR

Start with step 1 now.
