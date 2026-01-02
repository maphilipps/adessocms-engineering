---
name: acms-beads
description: Create Beads (Epic/Features/Tasks) from an existing plan
argument-hint: "[path to plan file]"
---

# /acms-beads - Plan to Beads Converter

Erzeugt Beads (Epic → Features → Tasks) aus einem existierenden Plan.

## Plan File

<plan_file> #$ARGUMENTS </plan_file>

**Falls leer:** "Welchen Plan in Beads umwandeln? (z.B. `plans/feat-my-feature.md`)"

---

## 1. Plan analysieren

**Lese Plan und extrahiere Struktur:**

```bash
cat [plan_file]
```

**Identifiziere:**
- Haupt-Titel → **Epic**
- Major Sections / Phasen → **Features**
- Checkboxen `- [ ]` und Tasks → **Tasks**

---

## 2. Beads-Struktur ableiten

**Mapping:**

| Plan-Element | Bead-Typ |
|--------------|----------|
| Plan-Titel | Epic |
| `## Phase X` / `## Section Y` | Feature |
| `- [ ] Task beschreibung` | Task |
| Nummerierte Schritte `1. ...` | Task |

**Beispiel:**

```markdown
# User Authentication implementieren    → EPIC

## Phase 1: Backend                      → FEATURE
- [ ] Login Endpoint erstellen           → TASK
- [ ] JWT Token generieren               → TASK

## Phase 2: Frontend                     → FEATURE
- [ ] Login Form erstellen               → TASK
- [ ] Token Storage implementieren       → TASK
```

---

## 3. Vorschau zeigen

**Zeige extrahierte Struktur:**

```
📋 BEADS PREVIEW
================

EPIC: User Authentication implementieren

├── FEATURE: Phase 1 - Backend
│   ├── TASK: Login Endpoint erstellen
│   └── TASK: JWT Token generieren
│
└── FEATURE: Phase 2 - Frontend
    ├── TASK: Login Form erstellen
    └── TASK: Token Storage implementieren

Total: 1 Epic, 2 Features, 4 Tasks
```

---

## 4. Bestätigung

```
AskUserQuestion(questions=[{
  "question": "Beads so erstellen?",
  "header": "Confirm",
  "options": [
    {"label": "Ja, erstellen", "description": "Beads mit bd create anlegen"},
    {"label": "Anpassen", "description": "Struktur erst anpassen"},
    {"label": "Abbrechen", "description": "Nichts erstellen"}
  ],
  "multiSelect": false
}])
```

---

## 5. Beads erstellen

**Bei "Ja, erstellen":**

```bash
# Epic erstellen
epic_id=$(bd create "[Epic-Titel]" --type epic -d "[Plan-Link]")
echo "✅ Epic: $epic_id"

# Features erstellen
for feature in features; do
  feat_id=$(bd create "[Feature-Titel]" --type feature --parent $epic_id)
  echo "  ✅ Feature: $feat_id"

  # Tasks erstellen
  for task in feature.tasks; do
    task_id=$(bd create "[Task-Titel]" --type task --parent $feat_id)
    echo "    ✅ Task: $task_id"
  done
done

bd sync
```

---

## 6. Abschluss

**Output:**

```
✅ BEADS ERSTELLT
=================

Epic: epic-abc123 - User Authentication implementieren
  Feature: feat-def456 - Phase 1 - Backend (2 Tasks)
  Feature: feat-ghi789 - Phase 2 - Frontend (2 Tasks)

Total: 1 Epic, 2 Features, 4 Tasks

Nächste Schritte:
  /acms-beads list     → Alle Beads anzeigen
  /acms-work           → Mit Arbeit beginnen
```

---

## Optionen

### Flache Struktur (nur Tasks)

Falls Plan keine klaren Phasen hat:

```
EPIC: [Plan-Titel]
├── TASK: [Task 1]
├── TASK: [Task 2]
└── TASK: [Task 3]
```

### Bestehenden Epic erweitern

Falls `--parent [epic-id]` angegeben:
- Kein neues Epic erstellen
- Features/Tasks unter bestehendem Epic anlegen

---

> **"Plan → Beads. Struktur wird automatisch erkannt."**
