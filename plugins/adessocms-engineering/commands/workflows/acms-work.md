---
name: acms-work
description: Ralph Loop - Execute features one-by-one from feature-list.json
argument-hint: "[tasks/<task-name>]"
---

# Ralph Work Loop

**Phase:** Implementation (executes features from `/acms-refine`)

Arbeitet die feature-list.json Feature für Feature ab. Jede Feature wird mit einem **Completion Promise** implementiert.

---

## Input

<work_input> #$ARGUMENTS </work_input>

**If input is empty:** List available tasks in `tasks/` directory and ask which one to work on.

---

## Session Start Protocol

**ALWAYS execute at session start:**

```bash
# 1. Orientate
pwd && git status

# 2. Read feature list
cat tasks/<task>/feature-list.json

# 3. Read progress
cat tasks/<task>/claude-progress.txt 2>/dev/null || echo "No progress yet"

# 4. Find next incomplete feature (first with "passes": false)
```

---

## Ralph Loop Pattern

### Step 1: Select Next Feature

Find first feature with `passes: false`. Display:

```
## Current Feature: F00X - [title]

**Type:** [type] | **Skill:** [skill]

**Acceptance Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Typecheck passes
```

### Step 2: Define Task & Completion Promise

**Generate the Ralph task for this feature:**

```
TASK: 'Implement F00X ([title]) with the following:
  - [Acceptance criterion 1]
  - [Acceptance criterion 2]
  - Typecheck must pass (ddev exec phpcs)
  - For frontend: Visual verification with Claude in Chrome
  - All changes committed atomically

If waiting on tests/builds, do not waste time - use pr-review-toolkit
agents to verify code quality, or trace through the test flow documenting
in progress file.'

COMPLETION PROMISE: 'F00X is fully implemented. All acceptance criteria
have been verified with evidence. The feature has been committed. The
feature-list.json has "passes": true for this feature. I have not taken
any shortcuts or faked anything to meet these requirements.'
```

### Step 3: Invoke Skill (AUTOMATIC)

Based on `feature.skill`, automatically invoke:

```
Skill(skill="<feature.skill>")
```

| Skill | Domain |
|-------|--------|
| `drupal-backend` | Entity API, Services, Plugins, Config |
| `adessocms-frontend` | SDC, Tailwind v4, Twig, Alpine.js |
| `devops` | DDEV, Composer, CI/CD |
| `gitlab` | glab CLI, MRs, Pipelines |
| `github` | gh CLI, PRs, Actions |

### Step 4: Implement & Verify

**Work until completion promise can be truthfully made:**

1. Read relevant existing code
2. Implement the feature
3. Verify EACH criterion with evidence:

```
## Acceptance Criteria Check

- [x] Criterion 1 - VERIFIED: [specific evidence]
- [x] Criterion 2 - VERIFIED: [specific evidence]
- [x] Typecheck passes - VERIFIED: `ddev exec phpcs` returned 0 errors
```

**Frontend verification (ALWAYS for UI features):**
```
mcp__claude-in-chrome__tabs_context_mcp
mcp__claude-in-chrome__navigate(url="https://project.ddev.site/path")
mcp__claude-in-chrome__computer(action="screenshot")
```

### Step 5: Run code-simplifier (MANDATORY)

**Before committing, ALWAYS invoke code-simplifier:**

```
Task(subagent_type: "code-simplifier", prompt: "Review and simplify the changes I just made for feature F00X")
```

This is **MANDATORY** - no exceptions. The code-simplifier ensures code is minimal, clear, and follows best practices.

### Step 6: Fulfill Completion Promise

**ONLY when you can truthfully make the completion promise:**

1. **Update feature-list.json:**
   - Set `"passes": true`
   - Add notes with evidence

2. **Commit atomically:**
   ```bash
   git add .
   git commit -m "feat(F00X): [title]

   - [Implementation summary]
   - [Key decisions]
   - [code-simplifier applied]

   Completion promise fulfilled. All criteria verified."
   ```

3. **Update progress file:**
   ```
   ## F00X: [title]
   Completed: YYYY-MM-DD HH:MM

   Evidence:
   - Criterion 1: [how verified]
   - Criterion 2: [how verified]

   Completion promise: FULFILLED
   ---
   ```

### Step 7: Loop or Complete

```bash
grep -c '"passes": false' tasks/<task>/feature-list.json
```

**If features remain:** Continue to next feature (back to Step 1)
**If all complete:** Report summary and suggest `/acms-review`

---

## Completion Promise Integrity

**The completion promise is sacred.** You may ONLY mark a feature as passed when you can truthfully state:

> "All acceptance criteria have been verified with evidence. I have not
> taken any shortcuts or faked anything to meet these requirements."

**NEVER:**
- Mark passed without verification evidence
- Skip criteria because they seem trivial
- Fake test results or screenshots
- Remove or modify acceptance criteria
- Mark as passed with "will fix later"

**ALWAYS:**
- Provide specific evidence for each criterion
- Run actual tests, don't assume they pass
- Take actual screenshots for visual features
- Be honest about blockers

---

## Blocker Handling

If you cannot fulfill the completion promise:

1. **Do NOT fake completion**
2. **Document blocker:**
   ```json
   "notes": "BLOCKED: [reason]. Cannot fulfill completion promise because [specific issue]."
   ```
3. **Ask user for guidance**
4. **Update progress file** with blocker details

---

## While Waiting (Don't Waste Time)

If waiting on CI, tests, or builds:

- Run pr-review-toolkit agents on your changes
- Trace through test flow, documenting in progress file
- Review related code for issues
- Prepare for next feature
- **Do NOT sit idle**

---

## Integration

```
/acms-refine  →  /acms-work  →  /acms-review  →  /acms-compound
     ↓              ↓               ↓                ↓
 feature-list   Ralph Loop      Specialist       Knowledge
               (promises)        Review           Base
```
