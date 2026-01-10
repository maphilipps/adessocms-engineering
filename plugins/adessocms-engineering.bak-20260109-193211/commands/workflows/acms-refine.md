---
name: acms-refine
description: Interview-driven spec creation with Feature-List output for Ralph Loop execution
argument-hint: "[feature name or task/<task-name>]"
---

# Specification Refiner

**Phase:** Pre-Implementation (creates feature-list.json for `/acms-work`)

## Hinweis: Spezifikationsphase

**Dieser Command erstellt die Feature-Liste für die Ralph Loop Execution.**

- Interview durchführen
- Feature-List (feature-list.json) generieren
- SPEC.md schreiben
- Keine Code-Generierung in dieser Phase

**Nach Abschluss:** `/acms-work` startet die iterative Abarbeitung.

---

## Input

<refine_input> #$ARGUMENTS </refine_input>

**If input is empty, ask:** "What feature or project would you like to specify? Provide a task name or describe what you want to build."

---

## Workflow

### Phase 1: Task Setup

```bash
# Create task directory
TASK_NAME="<kebab-case-name>"
mkdir -p tasks/${TASK_NAME}
```

### Phase 2: Initial Context Gathering

```
AskUserQuestion(questions=[{
  "question": "What's the primary goal of this feature/project?",
  "header": "Goal",
  "multiSelect": false,
  "options": [
    {"label": "New Feature", "description": "Adding functionality that doesn't exist"},
    {"label": "Enhancement", "description": "Improving existing functionality"},
    {"label": "Bug Fix", "description": "Fixing broken behavior"},
    {"label": "Refactor", "description": "Restructuring without changing behavior"}
  ]
}])
```

### Phase 3: Deep Interview Loop

**Interview until the spec is complete.** Ask **non-obvious** questions across:

- **Technical**: Existing patterns, performance, data structures, dependencies
- **UI/UX**: User mental model, states, accessibility, responsive behavior
- **Risks**: Failure modes, security, backwards compatibility
- **Tradeoffs**: Speed vs quality, build vs buy, scope
- **Acceptance**: Definition of done, required tests

### Phase 4: Research Phase (Optional)

After interview, optionally start parallel research agents:

```
Task(subagent_type="adessocms-engineering:research:repo-research-analyst", ...)
Task(subagent_type="adessocms-engineering:core:librarian", ...)
```

### Phase 5: Generate Feature-List (CRITICAL)

**Key output for Ralph Loop execution.**

#### Feature Sizing (Anthropic Harness Rules)
- Each feature completable in ONE session
- 2-3 sentences to describe max
- Clear, verifiable acceptance criteria

#### Priority Order (STRICT)
1. Database/Config → 2. Backend → 3. Frontend → 4. Tests → 5. Docs

#### Format: `tasks/<task>/feature-list.json`

```json
{
  "project": "<task-name>",
  "branch": "feat/<task-name>",
  "description": "Brief description",
  "created": "YYYY-MM-DD",
  "features": [
    {
      "id": "F001",
      "title": "Short title",
      "description": "What needs to be done",
      "type": "backend|frontend|config|test|docs",
      "skill": "drupal-backend|adessocms-frontend|devops|gitlab|github",
      "acceptance_criteria": ["Criterion 1", "Typecheck passes"],
      "priority": 1,
      "passes": false,
      "notes": ""
    }
  ]
}
```

#### Skill Assignment

| Type | Skill |
|------|-------|
| Drupal entities, fields, config | `drupal-backend` |
| SDC, Twig, Tailwind, Alpine | `adessocms-frontend` |
| DDEV, CI/CD, deployment | `devops` |
| GitLab MRs, pipelines | `gitlab` |
| GitHub PRs, actions | `github` |

### Phase 6: Write SPEC.md

Create `tasks/<task>/SPEC.md` with: Overview, Goals, Non-Goals, Technical Design, UX, Acceptance Criteria.

### Phase 7: Output

1. Write `tasks/<task>/feature-list.json`
2. Write `tasks/<task>/SPEC.md`
3. Create `tasks/<task>/claude-progress.txt`
4. Open in Typora: `open -a Typora tasks/<task>/SPEC.md`

> "Nächster Schritt: `/acms-work tasks/<task>` startet die Ralph Loop."

---

## Critical Rules

1. **Features must be atomic** - Completable in one session
2. **Strict priority order** - Database → Backend → Frontend → Tests
3. **No TBDs** - Resolve all questions during interview
4. **Verifiable criteria** - Objectively testable
5. **Skill assignment** - Every feature has a skill for auto-invocation
