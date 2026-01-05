---
name: acms-spec
description: Interview-driven spec creation before planning phase
argument-hint: "[path to SPEC.md or feature name]"
---

# Specification Interview

**Phase:** Pre-Planning (before `/acms-plan`)

## Hinweis: Spezifikationsphase

**Dieser Command dient der Spezifikation - keine Implementation in dieser Phase.**

- ✅ Fokus auf Fragen stellen und Antworten dokumentieren
- ✅ Fokus auf die SPEC.md schreiben
- ✅ Keine Code-Generierung in dieser Phase
- ✅ Keine Dateien außer der Spec selbst

**Nach Abschluss:** Der User entscheidet, ob `/acms-plan` gestartet wird.

---

Interview me in detail to create or refine a specification. This command uses iterative deep questioning to uncover requirements, constraints, and decisions that will make the subsequent planning phase smooth and complete.

## Input

<spec_input> #$ARGUMENTS </spec_input>

**If input is empty, ask:** "What feature or project would you like to specify? Provide a SPEC.md path or describe what you want to build."

## Workflow

### 1. Read Existing Context (if available)

If a SPEC.md or similar file exists:

1. **Read the file** completely
2. **Identify gaps** - What's missing? What's vague? What needs clarification?
3. **Note decisions already made** - Don't re-ask what's already specified

If no file exists:

1. **Create initial structure** in memory
2. **Start with broad context questions** before diving deep

### 2. Initial Context Gathering

Before diving into details, understand the big picture:

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

### 3. Deep Interview Loop (CORE)

**This is the heart of the command. Interview continuously until the spec is complete.**

#### Interview Categories

Cycle through these categories, asking **non-obvious** questions:

##### A. Technical Implementation
- What existing code/patterns should we leverage or avoid?
- What are the performance constraints?
- What data structures are involved? Where does data come from/go?
- What external dependencies or integrations are needed?
- What's the error handling strategy?
- How should this behave under edge cases (empty states, high load, offline)?

##### B. UI & UX
- What's the user's mental model? What do they expect to happen?
- What states does the UI need to handle (loading, error, empty, success)?
- What accessibility requirements apply?
- Is this mobile-first, desktop-first, or truly responsive?
- What interactions are needed (hover, click, drag, keyboard)?
- What feedback does the user need at each step?

##### C. Concerns & Risks
- What could go wrong? What are the failure modes?
- What are the security implications?
- What data privacy considerations exist?
- What backwards compatibility issues might arise?
- What's the rollback strategy if this fails?
- Are there legal/compliance requirements?

##### D. Tradeoffs & Decisions
- Speed vs. quality: What's the priority?
- Build vs. buy: Any off-the-shelf solutions to consider?
- Scope: What's explicitly out of scope?
- Technical debt: Are we accepting any? Why?
- Dependencies: Are we okay blocking on X?

##### E. Acceptance Criteria
- How do we know this is "done"?
- What tests are required?
- What's the definition of success?
- Who needs to approve/review this?

#### Interview Technique

**DO NOT ask obvious questions.** Bad examples:
- "What should the button do when clicked?" (obvious)
- "Should we handle errors?" (obviously yes)
- "Is accessibility important?" (always yes)

**DO ask probing questions.** Good examples:
- "The existing `UserService` has a `softDelete` method but you want hard delete. Migrate existing soft-deleted records first?"
- "I see the design shows a carousel, but mobile touch behavior isn't specified. Swipe gestures? Pagination dots? Auto-advance?"
- "This feature touches the checkout flow. PCI compliance requires X. How are we handling that?"
- "There are 3 existing patterns for form validation in the codebase. Which should we follow? Or create a 4th?"

**Ask follow-up questions based on answers.** Don't just check boxes.

#### Question Format

Use AskUserQuestion for each question or small related batch:

```
AskUserQuestion(questions=[{
  "question": "[Specific, non-obvious question based on context]",
  "header": "[2-3 word category]",
  "multiSelect": [true/false as appropriate],
  "options": [
    {"label": "[Option 1]", "description": "[What this means/implies]"},
    {"label": "[Option 2]", "description": "[What this means/implies]"},
    {"label": "[Option 3]", "description": "[What this means/implies]"}
  ]
}])
```

**For open-ended questions**, use the question format but make options represent common approaches, letting "Other" capture custom answers.

### 4. Continuous Until Complete

**Keep interviewing until:**

- [ ] All major technical decisions are made
- [ ] UI/UX behavior is fully specified
- [ ] Edge cases are documented
- [ ] Acceptance criteria are clear and measurable
- [ ] No "TBD" or "to be decided" items remain

**Check in periodically:**

```
AskUserQuestion(questions=[{
  "question": "We've covered [topics]. Anything else before I write the spec?",
  "header": "Complete?",
  "multiSelect": false,
  "options": [
    {"label": "Yes, write the spec", "description": "All questions answered, ready to document"},
    {"label": "I have more to add", "description": "Continue the interview"},
    {"label": "Review what we have", "description": "Show summary before deciding"}
  ]
}])
```

### 4.5 Optional: Research Phase

**Nach dem Interview, VOR dem Schreiben der Spec:**

Frage ob zusätzlicher Research-Kontext gewünscht ist:

```
AskUserQuestion(questions=[{
  "question": "Soll ich Research Agents für zusätzlichen Kontext starten?",
  "header": "Research?",
  "multiSelect": false,
  "options": [
    {"label": "Ja, Research starten", "description": "Starte repo-research-analyst + librarian parallel für Codebase-Patterns und externe Docs"},
    {"label": "Nein, direkt zur Spec", "description": "Interview-Ergebnisse reichen aus, Spec direkt schreiben"}
  ]
}])
```

**Wenn "Ja, Research starten":**

Starte diese Agents parallel mit dem Feature-Kontext aus dem Interview:

```
# Parallel Research Agents
Task(subagent_type="adessocms-engineering:research:repo-research-analyst",
     prompt="Analysiere die Codebase für: [feature_description]. Finde relevante Patterns, existierende Implementierungen, und Konventionen.")

Task(subagent_type="adessocms-engineering:core:librarian",
     prompt="Recherchiere externe Dokumentation für: [feature_description]. Finde Best Practices, Framework-Docs, und relevante Beispiele mit Permalinks.")

# Für UI/Design Features zusätzlich:
Task(subagent_type="adessocms-engineering:specialists:design-system-guardian",
     prompt="Analysiere Design Tokens und existierende Komponenten für: [feature_description]. Welche können wiederverwendet werden?")
```

**Research Findings integrieren:**

- Füge relevante Findings in die Spec ein (separater Abschnitt "Research Findings")
- Verlinke zu gefundenen Code-Beispielen und Dokumentation
- Notiere Patterns die befolgt werden sollten

### 5. Write the Specification

When the interview is complete, write a structured spec:

```markdown
# [Feature Name] Specification

## Overview
[2-3 sentence summary of what this is]

## Goals
- [Primary goal]
- [Secondary goals]

## Non-Goals (Explicitly Out of Scope)
- [What we're NOT doing]

## Technical Design

### Data Model
[Entities, fields, relationships]

### Architecture
[Components, services, integrations]

### API/Interface
[Endpoints, methods, parameters]

## User Experience

### User Flow
[Step-by-step user journey]

### States
- Loading: [behavior]
- Error: [behavior]
- Empty: [behavior]
- Success: [behavior]

### Edge Cases
[Documented edge cases and how to handle them]

## Acceptance Criteria
- [ ] [Specific, measurable criterion]
- [ ] [Another criterion]

## Research Findings (if research was conducted)
[Findings from repo-research-analyst, librarian, design-system-guardian]
- Relevant code patterns: [links]
- External documentation: [links]
- Reusable components: [list]

## Open Questions (if any)
[Only if truly unresolved - prefer resolving during interview]

## Interview Notes
[Key decisions made during interview with rationale]
```

### 6. Output

1. **Write the spec** to the appropriate location:
   - If input was a file path: Update that file
   - If input was a feature name: Write to `specs/[feature-name].md` or `plans/[feature-name]-spec.md`

2. **Open in Typora:**
   ```bash
   open -a Typora [spec-file-path]
   ```

3. **Report completion:**

> "Spec erstellt: `[path]` - Datei wurde in Typora geöffnet. Nächster Schritt: Plan Mode aktivieren für die Planung."

## Integration with Workflow

```
/acms-spec  →  CC Plan Mode  →  CC Implementation  →  /acms-review  →  /acms-compound
    ↑              ↑                    ↑
  (this)      (uses spec)       (uses plan)
```

**This command produces input for Claude Code's native Plan Mode.** The spec should be detailed enough that planning requires no additional clarification from the user.

## Hinweis: Ende der Spezifikationsphase

Dieser Command endet nach dem Schreiben der Spezifikation:
- Fokus bleibt auf Dokumentation
- Keine automatische Weiterleitung zu Plan Mode

**Nächster Schritt:** Der User aktiviert Claude Code Plan Mode manuell für die Planung.
