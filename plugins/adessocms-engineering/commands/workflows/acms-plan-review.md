---
name: acms-plan-review
description: Have multiple specialized agents review a plan in parallel
argument-hint: "[plan file path or plan content]"
---

# /acms-plan-review

**Scope:** Review und Update des Plans. Keine Implementation.

## 1. Run Reviewers (Parallel)

Have @agent-dries-drupal-reviewer @agent-drupal-reviewer @agent-code-simplicity-reviewer review this plan in parallel.

## 2. Deep Interview (AFTER Reviewers)

**Interview me in detail using the AskUserQuestion tool about literally anything:**

- What are the goals of this plan?
- Are there constraints I should know about?
- Concerns about the approach?
- Tradeoffs you're willing to make?
- etc.

**But make sure the questions are NOT obvious.**

**Reference what the reviewers found.** Example informed questions:
- "Dries-reviewer flagged X as over-engineered. Is that complexity necessary?"
- "The drupal-reviewer suggested Y pattern. Any reason you chose Z instead?"
- "The code-simplifier found duplication. Intentional or oversight?"

Be very in-depth and continue interviewing me continually until the review context is complete.

## 3. Update the Plan

**Nach dem Interview den Plan aktualisieren!**

Basierend auf Reviewer-Feedback UND Interview-Antworten:
- **Entferne** Tasks die als over-engineered identifiziert wurden
- **Vereinfache** Tasks basierend auf Code-Simplifier Feedback
- **Konkretisiere** vage Tasks mit den Interview-Antworten
- **Ergänze** fehlende Schritte die im Review aufgefallen sind

**Der Plan muss nach dem Review eine "executable specification" sein:**
- Keine offenen Fragen mehr
- `/acms-work` kann den Plan OHNE weitere Klärungsfragen ausführen

## 4. Create Beads Epic

**Prerequisite Check:**
```bash
if ! command -v bd &> /dev/null; then
  echo "❌ Beads CLI nicht installiert!"
  echo "Installation: npm install -g @beads/bd"
  echo "Dann: bd init (im Projekt-Root)"
  exit 1
fi
```

Nach erfolgreichem Review, erstelle einen Bead für Cross-Session Tracking:

```bash
# Epic erstellen
bd create "Epic: <plan-title>" -t epic -p 1 -d "<plan-summary>"

# Subtasks aus dem Plan extrahieren und als Dependencies hinzufügen
# Für jeden Task im Plan:
bd create "<task-title>" --parent <epic-id>
```

**Output Format:**
```
Bead erstellt: bd-<hash> - Epic: <plan-title>
Subtasks: bd-<hash>.1, bd-<hash>.2, ...
```

## 5. Output (END OF WORKFLOW)

**This is the final step. After this, the command is complete.**

1. Save the updated plan file
2. Open in Typora:
   ```bash
   open -a Typora <plan_file_path>
   ```
3. Report completion with this exact format:

> "Plan aktualisiert: `plans/<filename>.md` - Änderungen: [kurze Liste der Änderungen]. Datei wurde in Typora geöffnet."

**END.** Do not continue. Do not suggest next steps. Do not offer to implement. Do not call `/acms-work`. The user will explicitly request implementation in a new message when ready.
