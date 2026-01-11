---
name: lfg
description: Full autonomous engineering workflow
argument-hint: "[feature description]"
---

Run these slash commands in order. Do not do anything else.

1. `/ralph-loop:ralph-loop "finish all slash commands" --completion-promise "DONE"`
2. `/workflows:plan $ARGUMENTS`
3. `/deepen-plan`
4. `/workflows:work`
5. `/workflows:review`
6. `/resolve-todo-parallel`
7. `/workflows:compound`
8. `/playwright-test`
9. `/feature-video`
10. Output `<promise>DONE</promise>` when video is in PR

Start with step 1 now.
