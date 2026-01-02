---
name: acms-plan-review
description: Have multiple specialized agents review a plan in parallel
argument-hint: "[plan file path or plan content]"
---

# /acms-plan-review

**Scope:** Review und Update des Plans. Keine Implementation.

## 1. Dynamic Reviewer Selection

First, call the **reviewer-selector** agent with the plan content to determine which specialists should review:

```
Task(subagent_type="adessocms-engineering:core:reviewer-selector", prompt="Analyze this plan and select appropriate reviewers: <plan_content>")
```

The reviewer-selector returns:
```json
{
  "selected_reviewers": ["drupal-specialist", "sdc-specialist", ...],
  "matched_patterns": {...},
  "reason": "...",
  "confidence": "high|medium|low",
  "fallback_used": false
}
```

## 2. Run Selected Reviewers (Parallel)

Launch the selected reviewers in parallel to analyze the plan.

**Fallback Reviewers** (if reviewer-selector can't match patterns):
- @code-simplifier - YAGNI, over-engineering detection
- @librarian - Evidence verification with GitHub permalinks
- @architecture-strategist - Structural analysis

**Librarian verifies:** Are the plan's claims backed by actual documentation? Provides evidence with GitHub permalinks.

## 3. Deep Interview (AFTER Reviewers)

**Interview me in detail using the AskUserQuestion tool about literally anything:**

- What are the goals of this plan?
- Are there constraints I should know about?
- Concerns about the approach?
- Tradeoffs you're willing to make?
- etc.

**But make sure the questions are NOT obvious.**

**Reference what the reviewers found.** Example informed questions:
- "The drupal-specialist flagged X as not following Drupal patterns. Is that intentional?"
- "The code-simplifier found duplication. Intentional or oversight?"
- "The SDC-specialist noted missing slots/props. Should components be more flexible?"
- "The Tailwind-specialist found custom CSS where utilities exist. Prefer Tailwind v4?"
- "The paragraphs-specialist detected .value access. Is there a reason to bypass caching?"

Be very in-depth and continue interviewing me continually until the review context is complete.

## 4. Update the Plan

**Nach dem Interview den Plan aktualisieren!**

Basierend auf Reviewer-Feedback UND Interview-Antworten:
- **Entferne** Tasks die als over-engineered identifiziert wurden
- **Vereinfache** Tasks basierend auf Code-Simplifier Feedback
- **Konkretisiere** vage Tasks mit den Interview-Antworten
- **Ergänze** fehlende Schritte die im Review aufgefallen sind

**Der Plan muss nach dem Review eine "executable specification" sein:**
- Keine offenen Fragen mehr
- `/acms-work` kann den Plan OHNE weitere Klärungsfragen ausführen

## 5. Save & Present Plan

1. Save the updated plan file
2. Open in Typora:
   ```bash
   open -a Typora <plan_file_path>
   ```
3. Report completion:

> "Plan aktualisiert: `plans/<filename>.md` - Änderungen: [kurze Liste der Änderungen]. Datei wurde in Typora geöffnet."

## 6. Next Steps (MANDATORY)

**Frage den User was als nächstes passieren soll:**

```
AskUserQuestion(questions=[{
  "question": "Plan ist fertig. Was möchtest du als nächstes tun?",
  "header": "Next",
  "options": [
    {"label": "Beads erstellen", "description": "Epic + Features + Tasks aus Plan generieren (/acms-beads)"},
    {"label": "Plan vertiefen", "description": "Weitere Details und Recherche hinzufügen (/acms-deepen-plan)"},
    {"label": "Fertig", "description": "Nichts weiter, Plan ist komplett"}
  ],
  "multiSelect": false
}])
```

### Bei "Beads erstellen"

Rufe `/acms-beads` mit dem Plan-Pfad auf:

```
Skill("acms-beads", args="<plan_file_path>")
```

### Bei "Plan vertiefen"

Rufe `/acms-deepen-plan` mit dem Plan-Pfad auf:

```
Skill("acms-deepen-plan", args="<plan_file_path>")
```

### Bei "Fertig"

> "Plan abgeschlossen. Starte später `/acms-beads <plan>` für Beads oder `/acms-work` für Implementation."

**END.**
