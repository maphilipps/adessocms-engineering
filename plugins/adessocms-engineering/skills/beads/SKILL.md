---
name: beads
description: Cross-Session Task Tracking mit Beads CLI. Verwende für persistentes Task-Management über Sessions hinweg.
---

# Beads Task Tracking

Cross-Session Persistenz für AI-Agent Workflows. Beads speichert Tasks in `.beads/` (Git-backed).

## Wann Beads vs TodoWrite?

| Kriterium | Beads | TodoWrite |
|-----------|-------|-----------|
| **Dauer** | 15-60 min pro Task | < 5 min |
| **Dateien** | 1-5 Dateien | 1 Datei, wenige Zeilen |
| **Cross-Session?** | Ja, möglicherweise | Nein, definitiv nicht |
| **Dependencies?** | Ja, Blocker möglich | Nein |
| **Beispiel** | "Workflows anpassen" | "Zeile 42 ändern" |

**Faustregel:** Ein Beads-Task = **eine Session-Arbeit** (15-60 min) mit klarem Deliverable.

## Die richtige Granularität

### ❌ Zu kleinteilig (Overhead)

```
bd-a3f8.1.1   "Öffne SKILL.md"
bd-a3f8.1.2   "Füge Zeile 10 hinzu"
bd-a3f8.1.3   "Speichere Datei"
```

**Problem:** Mehr Zeit mit `bd update`/`bd close` als mit Arbeit. → **TodoWrite nutzen!**

### ❌ Zu vage (Rückfragen nötig)

```
bd-a3f8.1     "Beads integrieren"
```

**Problem:** Was genau? Welche Dateien? → **Claude muss fragen, Plan ist nicht "executable".**

### ✅ Richtige Granularität

```
bd-a3f8           Epic: Beads Integration
├── bd-a3f8.1     Beads Skill erstellen (skills/beads/SKILL.md)
├── bd-a3f8.2     Workflows anpassen (acms-plan-review, acms-work)
├── bd-a3f8.3     README Prerequisites aktualisieren
└── bd-a3f8.4     CHANGELOG + Version Bump
```

## Was Claude braucht

Claude braucht **keine Mikro-Tasks**. Claude braucht:

1. **Klares Ziel** - Was soll am Ende existieren?
2. **Kontext** - Welche Dateien/Patterns sind relevant?
3. **Akzeptanzkriterien** - Woran erkenne ich "fertig"?

Alles andere kann Claude selbst herausfinden.

## Hierarchische IDs

Beads verwendet hierarchische IDs:

```
bd-a3f8           (Epic)
├── bd-a3f8.1     (Task)
│   └── bd-a3f8.1.1   (Sub-task)
├── bd-a3f8.2     (Task)
└── bd-a3f8.3     (Task)
```

**Beispiel:**
```bash
# Epic erstellen → ID bd-a3f8
bd create "Epic: Feature X" -t epic -p 1

# Tasks → IDs bd-a3f8.1, bd-a3f8.2
bd create "Backend-Logik" --parent bd-a3f8
bd create "Frontend anpassen" --parent bd-a3f8
```

## Quick Reference

| Command | Beschreibung |
|---------|--------------|
| `bd init` | Initialisiert `.beads/` im Repo |
| `bd ready` | Tasks ohne Blocker anzeigen |
| `bd create "Title" -t epic -p 1` | Epic erstellen |
| `bd create "Task" --parent <id>` | Subtask erstellen (ID: `<parent>.N`) |
| `bd update <id> --status in_progress` | Status ändern |
| `bd close <id> --reason "..."` | Task schließen |
| `bd dep add <child> <parent>` | Dependency erstellen |
| `bd show <id>` | Task-Details anzeigen |
| `bd sync` | Mit Git synchronisieren |

## Typischer Epic-Aufbau

**Beads-Level (Cross-Session):**
```
Epic: Feature X
├── Task: Backend-Logik implementieren
├── Task: Frontend/Twig anpassen
├── Task: Tests schreiben
└── Task: Dokumentation
```

**TodoWrite-Level (innerhalb Session):**
```
[ ] Service-Klasse erstellen
[ ] Controller-Route hinzufügen
[ ] Form-Handler implementieren
[ ] Unit-Tests für Service
```

## Handoff-Pattern

1. `/acms-plan-review` → erstellt Bead Epic mit Tasks (grobe Ebene)
2. `/acms-work` → erstellt TodoWrite aus aktuellem Task (feine Ebene)
3. Session-Ende → `bd close` für erledigte Beads, TodoWrite wird verworfen

## Notes-Format für UI-Tasks

Bei UI-Tasks (Label: `ui`, `frontend`, `twig`, `sdc`) ist eine **Verification mit Screenshot MANDATORY**.

### Struktur

```markdown
COMPLETED:
- [x] Component implementiert
- [x] Twig-Template angepasst
- [x] Styling fertig

IN PROGRESS:
- [ ] Verification läuft

VERIFIED:
- Screenshot: screenshots/bd-a3f8.1-verified.png
- URL: https://project.ddev.site/node/123
- Timestamp: 2026-01-02T14:30:00Z

NEXT:
- PR erstellen
```

### Update Notes mit bd

```bash
# Nach erfolgreicher Verification
bd update <task-id> --notes "VERIFIED: screenshots/<task-id>-verified.png at $(date -Iseconds)"

# Bei Compaction (automatisch via PreCompact Hook)
bd update <task-id> --notes "SESSION COMPACTED: See .beads/session-state.md"
```

### Warum?

- **Evidence:** Screenshot beweist, dass UI funktioniert
- **Audit Trail:** Wann, wo, was verifiziert
- **Recovery:** Nächste Session weiß, was getan wurde

## Session State (PreCompact Hook)

Bei Context-Compaction wird automatisch `.beads/session-state.md` erstellt:

```markdown
# Session State - 2026-01-02T14:30:00Z

## Active Task
ID: bd-a3f8.1
Title: Component implementieren
Status: in_progress

## Session Summary
- Was wurde erreicht: [Punkte]
- Aktuelle Arbeit: [Status]
- Offene Fragen: [falls vorhanden]

## Files Modified
[Liste der geänderten Dateien]

## Next Steps
[Empfehlung für nächste Session]
```

**Recovery:** `/acms-work` erkennt session-state.md und bietet Fortsetzung an.

## Session End: Land the Plane

Vor Session-Ende:

```bash
# 1. Follow-ups für verbleibende Arbeit
bd create "Follow-up: <title>" -d "<notes>"

# 2. Erledigte Tasks schließen
bd close <id> --reason "Implemented in commit <sha>"

# 3. Sync & Push (MANDATORY)
git pull --rebase
bd sync
git push

# 4. Verify
git status  # Muss "up to date with origin" zeigen
```

> **"Work is NOT complete until `git push` succeeds"**
