---
name: beads
description: Cross-Session Task Tracking mit Beads CLI. Verwende für persistentes Task-Management über Sessions hinweg.
---

# Beads Task Tracking

Cross-Session Persistenz für AI-Agent Workflows. Beads speichert Tasks in `.beads/` (Git-backed).

## Hierarchical IDs

Beads verwendet hierarchische IDs für Epics und deren Subtasks:

```
bd-a3f8       (Epic)
bd-a3f8.1     (Task)
bd-a3f8.1.1   (Sub-task)
bd-a3f8.2     (Task)
```

**Beispiel-Workflow:**
```bash
# Epic erstellen → bekommt ID bd-a3f8
bd create "Epic: Beads Integration" -t epic -p 1

# Tasks unter Epic → bekommen IDs bd-a3f8.1, bd-a3f8.2, ...
bd create "Add Beads Skill" --parent bd-a3f8
bd create "Update Workflows" --parent bd-a3f8

# Sub-task unter Task → bekommt ID bd-a3f8.1.1
bd create "Write SKILL.md" --parent bd-a3f8.1
```

## Quick Reference

| Command | Beschreibung |
|---------|--------------|
| `bd init` | Initialisiert `.beads/` im Repo |
| `bd ready` | Tasks ohne Blocker anzeigen |
| `bd create "Title" -t epic -p 1` | Epic erstellen |
| `bd create "Task" --parent <epic-id>` | Subtask erstellen (ID: `<epic>.N`) |
| `bd update <id> --status in_progress` | Status ändern |
| `bd close <id> --reason "..."` | Task schließen |
| `bd dep add <child> <parent>` | Dependency erstellen |
| `bd show <id>` | Task-Details anzeigen |
| `bd sync` | Mit Git synchronisieren |

## TodoWrite vs Beads

| Situation | Verwende |
|-----------|----------|
| Einzelne Session, < 5 Tasks | **TodoWrite** |
| Multi-Session Epic, > 5 Tasks | **Beads** |
| Task hat Abhängigkeiten/Blocker | **Beads** |
| Schnelle Ad-hoc Aufgabe | **TodoWrite** |
| Plan wurde mit `/acms-plan` erstellt | **Beads** (Epic) + **TodoWrite** (Session-Tasks) |

## Handoff-Pattern

1. `/acms-plan-review` → erstellt Bead Epic mit Subtasks
2. `/acms-work` → erstellt TodoWrite aus Bead-Subtasks für aktuelle Session
3. Session-Ende → `bd close` für erledigte Beads, TodoWrite wird verworfen

## Session End: Land the Plane

Vor Session-Ende diese Schritte ausführen:

1. **File follow-up issues** für verbleibende Arbeit:
   ```bash
   bd create "Follow-up: <title>" -d "<notes>"
   ```

2. **Update Bead Status**:
   ```bash
   bd update <id> --status <new-status>
   bd close <id> --reason "<reason>"  # wenn fertig
   ```

3. **Sync & Push** (MANDATORY):
   ```bash
   git pull --rebase
   bd sync
   git push
   ```

4. **Verify**:
   ```bash
   git status  # Muss "up to date with origin" zeigen
   ```

> **"Work is NOT complete until `git push` succeeds"**
