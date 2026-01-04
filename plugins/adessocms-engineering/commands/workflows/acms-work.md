---
name: acms-work
description: Execute Beads (Epics/Features/Tasks) via Ralph Wiggum loop
argument-hint: "[bean-ids or leave empty for auto-select]"
---

# /acms-work - Beads Executor

Schreibt Beads in die Work-Queue und startet Ralph Wiggum.

## Schritt 1: Environment Check

```bash
# Beads CLI Check
command -v bd &> /dev/null || { echo "❌ bd nicht installiert"; exit 1; }

# DDEV Auto-Start
command -v ddev &> /dev/null && ! ddev describe &> /dev/null 2>&1 && ddev start
```

## Schritt 2: Beads sammeln

### Mit Argumenten (`/acms-work epic-001 feat-002`)

Direkt die angegebenen Bean-IDs verwenden.

### Ohne Argumente (Auto-Select)

```bash
bd ready --json | jq -r '.[].id'
```

## Schritt 3: Work-Queue schreiben

Schreibe `.claude/beads-work-queue.md`:

```markdown
# Beads Work Queue

## Pending
- [ ] epic-001: Hero Section implementieren
- [ ] feat-002: Card-Komponente erstellen
- [ ] task-003: Tailwind Config anpassen

## Done
(hier werden erledigte eingetragen)

## Instructions

Für jeden Bead in "Pending":

1. `bd show <bead-id>` - Details lesen
2. Implementieren (Epic = mehrere Commits, Feature = 1-2 Commits, Task = 1 Commit)
3. Bei **Features mit UI**: Chrome-Verification durchführen (siehe unten)
4. `bd close <bead-id>`
5. Von Pending nach Done verschieben
6. Commit + Push

## Chrome Verification (für Features/UI-Arbeit)

Wenn ein Feature UI-Änderungen enthält:

1. DDEV URL öffnen: `mcp__claude-in-chrome__navigate`
2. Screenshot machen: `mcp__claude-in-chrome__computer` mit action="screenshot"
3. Visuell prüfen ob es korrekt aussieht
4. Bei Fehlern: Fixen und erneut prüfen

## Completion

Wenn "Pending" leer ist:
- `bd sync && git push`
- Ausgabe: <promise>ALL_BEADS_COMPLETE</promise>
```

## Schritt 4: Ralph starten

```
/ralph-loop "Arbeite .claude/beads-work-queue.md ab bis fertig" --completion-promise "ALL_BEADS_COMPLETE"
```

## Nach Abschluss

```bash
bd sync
git push
```
