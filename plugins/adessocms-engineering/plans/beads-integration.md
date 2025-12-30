# feat: Beads Integration für Cross-Session Task Tracking

**Erstellt:** 2025-12-30
**Status:** Geplant
**Typ:** Enhancement

---

## Zusammenfassung

Integration von [Beads](https://github.com/steveyegge/beads) - einem Git-backed Task-Tracker für AI-Agenten - in den adessocms-engineering Workflow, um Cross-Session Persistenz für Pläne und Tasks zu ermöglichen.

---

## Problem

| Aktuell | Mit Beads |
|---------|-----------|
| TodoWrite geht nach Session verloren | Beads persistiert in `.beads/` (Git-backed) |
| Keine Dependencies zwischen Tasks | `bd dep add` für Blocker/Prerequisites |
| Keine "Ready" Detection | `bd ready` zeigt Tasks ohne Blocker |
| Kein Cross-Session Handoff | Beads überlebt Sessions + Compactions |

---

## Lösung: Beads als Persistenz-Layer

```
/acms-plan           → Markdown-Plan erstellen (wie bisher)
      ↓
/acms-plan-review    → Review + Interview + Plan aktualisieren
      ↓
★ BEAD ERSTELLEN ★   → bd create "Epic: <plan-title>" mit Subtasks
      ↓
/acms-work           → bd update --status in_progress
                     → TodoWrite für Session-Tasks (BEHALTEN!)
                     → bd close am Ende
      ↓
/acms-compound       → Learnings dokumentieren
```

**Wichtig:** TodoWrite wird NICHT ersetzt - es bleibt für schnelle Session-Tasks. Beads ist für das "große Bild" (Epics, Cross-Session, Dependencies).

---

## Implementation

### Phase 1: Plugin-Setup (CLI + Hooks Approach)

> **"For environments with shell access (Claude Code), the CLI + hooks approach is recommended over MCP."** - Beads Dokumentation

#### 1.1 Beads CLI als Prerequisite

**Datei:** `README.md` - Prerequisites Sektion

```markdown
## Prerequisites

### Beads CLI (für Cross-Session Task Tracking)

```bash
# Option 1: npm (empfohlen)
npm install -g @beads/bd

# Option 2: Homebrew
brew install steveyegge/beads/bd

# Option 3: Go
go install github.com/steveyegge/beads/cmd/bd@latest
```

Nach Installation im Projekt initialisieren:
```bash
cd <project-root>
bd init
```
```

#### 1.2 Beads Skill hinzufügen

**Datei:** `skills/beads/SKILL.md`

```markdown
---
name: beads
description: Cross-Session Task Tracking mit Beads CLI. Verwende für persistentes Task-Management über Sessions hinweg.
---

# Beads Task Tracking

## Quick Reference

| Command | Beschreibung |
|---------|--------------|
| `bd ready` | Tasks ohne Blocker anzeigen |
| `bd create "Title" -t epic` | Epic erstellen |
| `bd update <id> --status in_progress` | Status ändern |
| `bd close <id>` | Task schließen |
| `bd dep add <child> <parent>` | Dependency erstellen |
| `bd sync` | Mit Git synchronisieren |

## Workflow Integration

Beads wird automatisch von `/acms-plan-review` und `/acms-work` verwendet.
```

#### 1.3 Kein MCP Server nötig

CLI-Aufrufe direkt in Workflows sind für Claude Code besser als MCP:
- Schneller (kein Server-Overhead)
- Einfacher zu debuggen
- Natürliche Shell-Integration

### Phase 2: Workflow-Integration

#### 2.1 `/acms-plan-review` erweitern

**Datei:** `commands/workflows/acms-plan-review.md`

Nach Step 3 (Update the Plan), vor Output:

```markdown
## 4. Create Beads Epic (if plan is approved)

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
```

#### 2.2 `/acms-work` erweitern

**Datei:** `commands/workflows/acms-work.md`

**Am Anfang (Phase 1):**

```markdown
### 0. Check Beads Status

Prüfe ob ein Bead für diesen Plan existiert:

```bash
bd ready --json  # Zeigt Tasks ohne Blocker
bd show <epic-id>  # Details zum Plan-Epic
```

Wenn Bead existiert:
```bash
bd update <id> --status in_progress
```
```

**Am Ende (Phase 4: Ship It):**

```markdown
### 4.1 Update Beads

Nach erfolgreichem Commit:

```bash
# Task als erledigt markieren
bd close <task-id> --reason "Implemented in commit <sha>"

# Wenn Epic komplett:
bd close <epic-id> --reason "All subtasks completed"

# "Land the Plane" Protocol
bd sync
git push  # NICHT optional - Work is NOT complete until push succeeds
```
```

### Phase 3: "Land the Plane" Protocol

Füge neuen Abschnitt zu allen Workflows hinzu:

**Datei:** Alle `commands/workflows/*.md`

```markdown
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

3. **Sync & Push** (MANDATORY - nicht optional!):
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
```

---

## Beads Commands Referenz

| Command | Beschreibung |
|---------|--------------|
| `bd init` | Initialisiert `.beads/` im Repo |
| `bd create "Title" -t epic -p 1` | Erstellt Epic mit Priorität 1 |
| `bd create "Task" --parent <epic-id>` | Erstellt Subtask |
| `bd ready` | Zeigt Tasks ohne Blocker |
| `bd ready --json` | JSON-Format für Parsing |
| `bd update <id> --status in_progress` | Markiert als "in Arbeit" |
| `bd close <id> --reason "..."` | Schließt Task |
| `bd dep add <child> <parent>` | Erstellt Dependency |
| `bd show <id>` | Zeigt Task-Details |
| `bd sync` | Synchronisiert mit Git |
| `bd compact` | Komprimiert alte Tasks (Memory-sparend) |

---

## TodoWrite vs Beads

| Aspekt | TodoWrite | Beads |
|--------|-----------|-------|
| **Scope** | Session-Tasks | Cross-Session Epics |
| **Latenz** | Instant | CLI-Call |
| **UI** | Native Claude Code UI | Terminal Output |
| **Use Case** | "Die 5 Schritte jetzt" | "Das große Bild" |
| **Persistenz** | Keine | Git-backed |

**Beide behalten!** Sie ergänzen sich:
- Beads = Strategisch (Epic, Dependencies, Cross-Session)
- TodoWrite = Taktisch (Session-Tasks, schnell, einfach)

---

## Acceptance Criteria

- [ ] Beads CLI Prerequisite in README dokumentiert
- [ ] Beads Skill erstellt (`skills/beads/SKILL.md`)
- [ ] `/acms-plan-review` erstellt Bead nach erfolgreicher Review
- [ ] `/acms-work` prüft Beads am Start und updated Status
- [ ] "Land the Plane" Protocol in allen Workflows dokumentiert
- [ ] CHANGELOG mit v1.28.0 Entry
- [ ] Beads CLI funktioniert: `bd ready` zeigt Tasks

---

## Dateien zu ändern

| Datei | Änderung |
|-------|----------|
| `skills/beads/SKILL.md` | Neuer Skill für Beads CLI Reference |
| `commands/workflows/acms-plan-review.md` | Step 4: Create Beads Epic |
| `commands/workflows/acms-work.md` | Phase 0 + Phase 4.1 für Beads |
| `commands/workflows/acms-plan.md` | "Land the Plane" Sektion |
| `commands/workflows/acms-compound.md` | "Land the Plane" Sektion |
| `README.md` | Prerequisites (Beads CLI Installation) |
| `CHANGELOG.md` | v1.28.0 Entry |

---

## Prerequisite Enforcement (Review-Ergebnis)

**Entscheidung:** Beads CLI ist ein **hartes Prerequisite** - Workflow bricht ab ohne Installation.

```bash
# Am Anfang von /acms-plan-review und /acms-work:
if ! command -v bd &> /dev/null; then
  echo "❌ Beads CLI nicht installiert!"
  echo "Installation: npm install -g @beads/bd"
  echo "Dann: bd init (im Projekt-Root)"
  exit 1
fi
```

**Begründung:**
- Graceful degradation würde zu inkonsistentem Tracking führen
- Beads ist Kern des Cross-Session Workflows
- Klare Fehlermeldung hilft beim Onboarding

---

## TodoWrite ↔ Beads Handoff (Review-Ergebnis)

| Situation | Verwende |
|-----------|----------|
| Einzelne Session, < 5 Tasks | **TodoWrite** |
| Multi-Session Epic, > 5 Tasks | **Beads** |
| Task hat Abhängigkeiten/Blocker | **Beads** |
| Schnelle Ad-hoc Aufgabe | **TodoWrite** |
| Plan wurde mit `/acms-plan` erstellt | **Beads** (Epic) + **TodoWrite** (Session-Tasks) |

**Handoff-Pattern:**
1. `/acms-plan-review` → erstellt Bead Epic mit Subtasks
2. `/acms-work` → erstellt TodoWrite aus Bead-Subtasks für aktuelle Session
3. Session-Ende → `bd close` für erledigte Beads, TodoWrite wird verworfen

---

## Risiken & Mitigations

| Risiko | Mitigation |
|--------|------------|
| Beads CLI nicht installiert | **Prerequisite enforced** - Workflow bricht ab mit Installationsanleitung |
| Merge-Konflikte in `.beads/` | Hash-IDs von Beads verhindern das |
| Overhead bei kleinen Tasks | TodoWrite für kleine Tasks behalten |
| Learning Curve | Klare Doku + Examples in Workflow-Files |

---

## Nicht im Scope

- Beads Web UI / Viewer
- Linear-Integration
- Multi-Agent Koordination (später)
- Automatische Compaction
