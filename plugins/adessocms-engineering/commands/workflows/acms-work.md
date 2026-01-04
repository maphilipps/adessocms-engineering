---
name: acms-work
description: Execute Tasks from Epics/Features via Ralph Wiggum loop (always drills down to Task level)
argument-hint: "[bean-ids or leave empty to select]"
---

# /acms-work - Beads Task Executor

Arbeitet immer auf **Task-Ebene**. Epics und Features werden zu ihren Tasks aufgelöst.

## Beads Hierarchie

```
Epic (groß)
  └── Feature (mittel)
        └── Task (atomar) ← HIER wird gearbeitet
```

## 0. Environment Initialization (Anthropic init.sh Pattern)

### 0.1 Prerequisite Checks

```bash
# Beads CLI Check
if ! command -v bd &> /dev/null; then
  echo "❌ Beads CLI nicht installiert!"
  echo "Installation: npm install -g @beads/bd"
  exit 1
fi

# DDEV Check + Auto-Start
if command -v ddev &> /dev/null; then
  if ! ddev describe &> /dev/null 2>&1; then
    echo "🔄 DDEV nicht gestartet - starte automatisch..."
    ddev start
    echo "✅ DDEV gestartet"
  fi
fi
```

### 0.2 Session Recovery

```bash
if [ -f ".beads/session-state.md" ]; then
  echo "📋 Vorherige Session gefunden - lade Kontext..."
  echo ""
  cat .beads/session-state.md
  echo ""

  # Frage: Kontext übernehmen?
  AskUserQuestion(questions=[{
    "question": "Session-Kontext aus PreCompact übernehmen?",
    "header": "Recovery",
    "options": [
      {"label": "Ja, fortsetzen", "description": "Mit Task aus session-state.md weitermachen"},
      {"label": "Nein, neu starten", "description": "Session-State ignorieren, neu auswählen"}
    ],
    "multiSelect": false
  }])

  # Bei "Ja": Task-ID aus session-state.md extrahieren und direkt verwenden
  # Bei "Nein": Weiter mit normaler Auswahl
fi
```

## 1. Auto-Select oder manuelle Auswahl

### Option A: Auto-Select (Default bei `/acms-work` ohne Argumente)

**Anthropic Pattern: "Identify highest-priority incomplete feature"**

```bash
# Höchster Priority Ready Task
next_task=$(bd ready --json 2>/dev/null | jq -r 'sort_by(.priority) | .[0].id // empty')

if [ -z "$next_task" ]; then
  echo "✅ Keine offenen Tasks - alle Beads erledigt!"
  exit 0
fi

echo "🎯 Nächster Task (Auto-Select): $next_task"
bd show $next_task

# Markiere als in_progress
bd update $next_task --status in_progress
```

### Option B: Manuelle Auswahl (bei expliziten Bean-IDs)

```bash
# Liste alle offenen Beans
bd list --status open
```

Frage User mit AskUserQuestion (Mehrfachauswahl):

```
AskUserQuestion(questions=[{
  "question": "Welche Beans möchtest du bearbeiten?",
  "header": "Beans",
  "options": [
    {"label": "epic-001", "description": "[Epic] 2 Features, 5 Tasks"},
    {"label": "feat-002", "description": "[Feature] 3 Tasks"},
    {"label": "task-003", "description": "[Task] Direkt bearbeitbar"},
    ...
  ],
  "multiSelect": true
}])
```

**Labels = nur IDs** (keine Sonderzeichen!)

## 2. Zu Tasks auflösen

```bash
# Für jede ausgewählte Bean: Zu Tasks auflösen
resolve_to_tasks() {
  bean_id=$1
  type=$(bd show $bean_id --format json | jq -r '.type')

  case $type in
    epic)
      # Epic → Features → Tasks
      bd list --parent $bean_id --type feature --format json | \
        jq -r '.[].id' | while read feat_id; do
          bd list --parent $feat_id --type task --format json | jq -r '.[].id'
        done
      ;;
    feature)
      # Feature → Tasks
      bd list --parent $bean_id --type task --format json | jq -r '.[].id'
      ;;
    task)
      # Task → direkt
      echo $bean_id
      ;;
  esac
}

# Alle Tasks in Datei sammeln
> .beads/work-queue.txt
for bean_id in $selected_beans; do
  resolve_to_tasks $bean_id >> .beads/work-queue.txt
done
```

## 3. Ralph Wiggum Loop starten

**Hinweis: Der Prompt sollte statisch sein - keine Variablen, keine Bean-IDs.**

```
Skill ralph-wiggum:ralph-loop
```

**Exakter Loop-Prompt (copy-paste, NICHTS ändern):**

```
Beads work queue loop
```

Das ist der gesamte Prompt. Keine IDs, keine Details. Alles steht in `.beads/work-queue.txt`.

**Was Claude im Loop tut:**

```
1. task_id=$(head -1 .beads/work-queue.txt)
   Falls leer → EXIT

2. bd show $task_id
   → Details lesen

3. Implementieren + Commit

4. bd close $task_id
   sed -i '' '1d' .beads/work-queue.txt

5. → Schritt 1
```

## 4. Abschlusskriterien (Exit Conditions)

**Alle ausgewählten Beans sind FERTIG wenn:**
- [ ] Jede Bean (Epic/Task) wurde bearbeitet
- [ ] Alle Subtasks von Epics haben Status "closed"
- [ ] Alle Commits gepusht: `git push`

**Nach jeder Bean:**
```bash
bd close <bean-id> --reason "Completed"
bd sync
```

**Am Ende aller Beans:**
```bash
git push
```

## 5. Bei Blockern

Falls ein Task nicht abgeschlossen werden kann:

```bash
# Task als blocked markieren
bd update <task-id> --status blocked -d "Grund: <beschreibung>"

# Weiter zum nächsten Task
→ zurück zu Schritt 1
```

## Quality Gates (pro Task)

Vor `bd close`:

### Gate 1: Basis-Checks

```bash
# Code kompiliert/läuft
ddev drush cr  # Cache clear
ddev exec phpcs --standard=Drupal,DrupalPractice <changed_files>
```

- [ ] Code kompiliert/läuft
- [ ] Tests passen (falls vorhanden)
- [ ] Commit erstellt

### Gate 2: Specialist Agents (by file type)

| Datei-Pattern | Agent |
|---------------|-------|
| `*.component.yml`, `components/*.twig` | @agent-sdc-specialist |
| `*.html.twig` (nicht in components/) | @agent-twig-specialist |
| `paragraph--*.html.twig` | @agent-paragraphs-specialist |

**Invoke Specialist für Review:**
```
Task(
  subagent_type="adessocms-engineering:specialists:sdc-specialist",
  prompt="Review these SDC changes for best practices: <list_of_changed_files>",
  description="SDC review"
)
```

### Gate 3: UI Verification (bei UI-Tasks)

**Hinweis: UI-Tasks sollten vor dem Schliessen einen Verification-Screenshot haben.**

**Trigger:** Task hat Label `ui`, `frontend`, `twig`, `sdc` ODER Twig/CSS-Dateien wurden geändert.

**Invoke webapp-testing Skill:**

```
Skill("webapp-testing")
```

**Playwright Verification Script:**

```python
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()

    # DDEV URL navigieren
    page.goto('https://PROJECT.ddev.site/PATH')
    page.wait_for_load_state('networkidle')

    # Screenshot für Evidence
    screenshot_path = f'screenshots/{task_id}-verified.png'
    page.screenshot(path=screenshot_path, full_page=True)

    browser.close()
```

**Nach erfolgreicher Verification:**

```bash
# Update Beads Notes mit Screenshot-Pfad
bd update <task-id> --notes "VERIFIED: screenshots/<task-id>-verified.png at $(date -Iseconds)"
```

### Agent-Feedback verarbeiten

- **Critical Issues**: Sollten behoben werden vor `bd close`
- **High Priority**: Sollten behoben werden
- **Medium/Low**: Optional, nach Ermessen

### Notes-Format für UI-Tasks

```markdown
COMPLETED:
- [x] Component implementiert
- [x] Twig-Template angepasst

VERIFIED:
- Screenshot: screenshots/bd-a3f8.1-verified.png
- URL: https://project.ddev.site/node/123
- Timestamp: 2026-01-02T14:30:00Z

NEXT:
- PR erstellen
```

## Land the Plane

Nach Epic-Abschluss:

```bash
bd sync
git push
git status  # "up to date with origin"
```

> **"Work is NOT complete until `git push` succeeds"**
