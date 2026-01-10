# feat: Beads-Integration nach Anthropic Long-Running Agent Best Practices optimieren

**Erstellt:** 2026-01-02
**Status:** 📋 Geplant
**Typ:** Enhancement
**Referenz:** [Anthropic - Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)

---

## Zusammenfassung

Optimierung der bestehenden Beads-Integration (`v1.28.0+`) basierend auf Anthropics Best Practices für Long-Running Agents. Kernpunkte:

1. **PreCompact Hook** - Automatische State-Konsolidierung vor Context-Compaction
2. **Quality Gates mit webapp-testing** - Mandatory Browser-Verification für UI-Tasks
3. **Auto-Select Task Priority** - Automatische Auswahl des wichtigsten Ready-Tasks
4. **DDEV Auto-Start** - Environment-Initialisierung wie Anthropics `init.sh`

---

## Problem (IST-Zustand)

| Aktuell | Anthropic Best Practice |
|---------|------------------------|
| Beads-Notes manuell | `claude-progress.txt` automatisch aktualisiert |
| Keine Pre-Compaction Strategie | Progress-File + Git = "Memory außerhalb Context" |
| Quality Gates optional | Mandatory Browser-Verification vor Feature-Completion |
| User wählt Task manuell | Auto-Select highest-priority unblocked Feature |
| Kein Environment-Check | `init.sh` startet Dev-Server automatisch |

---

## Lösung (SOLL-Zustand)

### Architektur-Übersicht

```
┌─────────────────────────────────────────────────────────────────┐
│                    /acms-work Workflow                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. ENVIRONMENT INIT (wie Anthropic's init.sh)                  │
│     ├── Check: bd CLI installed?                                │
│     ├── Check: DDEV running? → Auto-Start if not               │
│     └── Check: .beads/ initialized?                             │
│                                                                  │
│  2. TASK SELECTION (Auto-Select Pattern)                        │
│     ├── bd ready --json --priority 1                            │
│     ├── Auto-Select highest priority unblocked Task             │
│     └── bd update <id> --status in_progress                     │
│                                                                  │
│  3. IMPLEMENTATION LOOP (Ralph Wiggum)                          │
│     ├── Read Task from .beads/work-queue.txt                    │
│     ├── Implement + Commit                                      │
│     └── Quality Gates (pre-close)                               │
│                                                                  │
│  4. QUALITY GATES (vor bd close)                                │
│     ├── Lint/Build Check (immer)                                │
│     ├── Specialist Agents (SDC/Twig/etc. by file type)          │
│     └── webapp-testing Verification (mandatory für UI-Tasks)    │
│                                                                  │
│  5. CLOSE + SYNC                                                │
│     ├── bd update --notes "VERIFIED: screenshots/..."           │
│     ├── bd close <id> --reason "Commit SHA"                     │
│     └── bd sync && git push                                     │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### PreCompact Hook

```
┌─────────────────────────────────────────────────────────────────┐
│                    PreCompact Hook                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  TRIGGER: Claude Code signalisiert Context-Compaction           │
│                                                                  │
│  ACTIONS:                                                        │
│  1. EXPORT - Beads-Status → .beads/session-state.md             │
│     ├── Aktuelle Task-ID + Status                               │
│     ├── Alle Notes des aktuellen Tasks                          │
│     └── Dependencies / Blockers                                 │
│                                                                  │
│  2. CONSOLIDATE - Wichtigen Context extrahieren (HAIKU AGENT)   │
│     ├── Architectural decisions                                 │
│     ├── Current task state                                      │
│     ├── Unresolved issues                                       │
│     └── Files touched in session                                │
│                                                                  │
│  3. UPDATE BEADS - Summary in Notes (HAIKU AGENT)               │
│     └── bd update <id> --notes "SESSION SUMMARY: ..."           │
│                                                                  │
│  OUTPUT: .beads/session-state.md (für nächste Session)          │
│                                                                  │
│  💡 HAIKU für Dokumentation: Schnell, günstig, ausreichend      │
│     für Summaries - wie bei Context-Compaction selbst           │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Implementation

### Phase 1: PreCompact Hook erstellen

**Datei:** `hooks/PreCompact/beads-state-export.md`

```yaml
---
name: beads-state-export
event: PreCompact
description: Exportiert Beads-Status vor Context-Compaction
---

# Beads State Export Hook

## Trigger
Wird automatisch vor Context-Compaction ausgeführt.

## Actions

### 1. Current State exportieren

```bash
# Aktiven Task identifizieren
current_task=$(bd list --status in_progress --json | jq -r '.[0].id // empty')

if [ -n "$current_task" ]; then
  # Task-Details exportieren
  bd show $current_task --json > /tmp/current-task.json

  # Session-State File erstellen
  cat > .beads/session-state.md << EOF
# Session State - $(date -Iseconds)

## Active Task
ID: $current_task
$(bd show $current_task)

## Session Summary
<!-- Claude: Füge hier eine Zusammenfassung der Session ein -->

## Files Modified
$(git diff --name-only HEAD~1 2>/dev/null || echo "Keine Änderungen")

## Next Steps
<!-- Claude: Was sollte die nächste Session tun? -->
EOF
fi
```

### 2. Session Summary generieren (HAIKU AGENT)

**Warum Haiku?** Schnell, günstig, und für Summaries ausreichend - wie beim Compacten selbst.

```python
# Haiku Agent für Session-Summary
Task(
  subagent_type="general-purpose",
  model="haiku",  # ← Explizit Haiku für Dokumentation
  prompt="""
    Erstelle eine kompakte Session-Summary für .beads/session-state.md:

    1. Lies den aktuellen Task: bd show $current_task
    2. Lies git diff für geänderte Dateien
    3. Extrahiere:
       - Was wurde erreicht?
       - Was ist noch offen?
       - Welche Entscheidungen wurden getroffen?
       - Empfehlung für nächste Session

    Format: Markdown, max 500 Wörter.
    Fokus: Kontext für nächste Session, nicht Details.
  """,
  description="Generate session summary"
)
```

### 3. Beads Notes aktualisieren

Nach Summary-Generierung, update Notes:

```bash
bd update $current_task --notes "SESSION COMPACTED: See .beads/session-state.md for context. Last commit: $(git rev-parse --short HEAD)"
```

### 4. Sync

```bash
bd sync
```
```

---

### Phase 2: /acms-work Environment Init erweitern

**Datei:** `commands/workflows/acms-work.md` - Section 0 erweitern

```markdown
## 0. Environment Initialization (Anthropic init.sh Pattern)

### 0.1 Prerequisite Checks

```bash
# Beads CLI Check (existing)
if ! command -v bd &> /dev/null; then
  echo "❌ Beads CLI nicht installiert!"
  echo "Installation: npm install -g @beads/bd"
  exit 1
fi

# DDEV Check + Auto-Start (NEW)
if command -v ddev &> /dev/null; then
  if ! ddev describe &> /dev/null; then
    echo "🔄 DDEV nicht gestartet - starte automatisch..."
    ddev start
    echo "✅ DDEV gestartet"
  fi
fi
```

### 0.2 Session Recovery (wenn .beads/session-state.md existiert)

```bash
if [ -f ".beads/session-state.md" ]; then
  echo "📋 Vorherige Session gefunden - lade Kontext..."
  cat .beads/session-state.md

  # Frage: Kontext übernehmen?
  # → Ja: Weiter mit Task aus session-state.md
  # → Nein: Neu starten mit bd ready
fi
```
```

---

### Phase 3: Auto-Select Task Pattern

**Datei:** `commands/workflows/acms-work.md` - Section 1 ersetzen

```markdown
## 1. Auto-Select Highest Priority Task

**Statt User-Auswahl: Automatisch den wichtigsten unblocked Task wählen.**

```bash
# Highest priority ready task
next_task=$(bd ready --json | jq -r 'sort_by(.priority) | .[0].id // empty')

if [ -z "$next_task" ]; then
  echo "✅ Keine offenen Tasks - alle Beads erledigt!"
  exit 0
fi

echo "🎯 Nächster Task: $next_task"
bd show $next_task

# Markiere als in_progress
bd update $next_task --status in_progress
```

**Warum Auto-Select?**
- Anthropic: "Identify highest-priority incomplete feature"
- Reduziert Context-Overhead durch weniger User-Interaktion
- Konsistente Task-Priorisierung
```

---

### Phase 4: Quality Gates mit webapp-testing

**Datei:** `commands/workflows/acms-work.md` - Quality Gates Section erweitern

```markdown
## Quality Gates (vor bd close)

### Gate 1: Basis-Checks (IMMER)

```bash
# Code kompiliert/läuft
ddev drush cr  # Cache clear
ddev exec phpcs --standard=Drupal,DrupalPractice <changed_files>
```

### Gate 2: Specialist Agents (by file type)

| Datei-Pattern | Agent |
|---------------|-------|
| `*.component.yml`, `components/*.twig` | @agent-sdc-specialist |
| `*.html.twig` (nicht in components/) | @agent-twig-specialist |
| `paragraph--*.html.twig` | @agent-paragraphs-specialist |

### Gate 3: UI Verification (MANDATORY für UI-Tasks)

**Wenn Task Label `ui`, `frontend`, `twig`, `sdc` hat ODER Twig/CSS-Dateien geändert wurden:**

```python
# Invoke webapp-testing Skill
Skill("webapp-testing")

# Playwright Script für Verification
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()

    # DDEV URL
    page.goto('https://PROJECT.ddev.site/PATH')
    page.wait_for_load_state('networkidle')

    # Screenshot für Evidence
    screenshot_path = f'screenshots/{task_id}-verified.png'
    page.screenshot(path=screenshot_path, full_page=True)

    browser.close()

# Update Beads Notes mit Screenshot-Pfad
bd update <task-id> --notes "VERIFIED: $screenshot_path"
```

**CRITICAL: Task darf NICHT geschlossen werden ohne Verification-Screenshot bei UI-Tasks!**
```

---

### Phase 5: Verification Evidence in Beads

**Notes-Format für Verification:**

```markdown
## Beads Notes Format für UI-Tasks

COMPLETED:
- [x] Component implementiert
- [x] Twig-Template angepasst

IN PROGRESS:
- Verification läuft

VERIFIED:
- Screenshot: screenshots/bd-a3f8.1-verified.png
- URL: https://project.ddev.site/node/123
- Timestamp: 2026-01-02T14:30:00Z

NEXT:
- PR erstellen
```

---

## Model-Selection Pattern für Agenten

**Prinzip:** Richtige Modell-Größe für den Task wählen - nicht immer das größte Modell.

| Task-Typ | Model | Begründung |
|----------|-------|------------|
| **Dokumentation/Summaries** | `haiku` | Schnell, günstig, ausreichend für Text-Generierung |
| **Session-State Export** | `haiku` | Wie Context-Compaction selbst |
| **Beads Notes Updates** | `haiku` | Strukturierte Text-Formatierung |
| **Code Review** | `sonnet` | Braucht Reasoning für Code-Analyse |
| **Specialist Agents** | `sonnet` | SDC/Twig/etc. brauchen Domain-Wissen |
| **Architektur-Entscheidungen** | `opus` | Komplexes Reasoning, Trade-offs |
| **Komplexe Refactorings** | `opus` | Multi-File, Cross-Cutting Concerns |

### Implementation in Task-Calls

```python
# Dokumentation → Haiku
Task(
  subagent_type="adessocms-engineering:core:document-writer",
  model="haiku",  # ← Explizit
  prompt="...",
  description="Write docs"
)

# Code Review → Sonnet (default)
Task(
  subagent_type="adessocms-engineering:specialists:sdc-specialist",
  # model nicht gesetzt → erbt Parent (meist Sonnet)
  prompt="...",
  description="SDC review"
)

# Architektur → Opus
Task(
  subagent_type="adessocms-engineering:specialists:architecture-strategist",
  model="opus",  # ← Explizit für komplexe Entscheidungen
  prompt="...",
  description="Architecture review"
)
```

---

## Dateien zu ändern

| Datei | Änderung |
|-------|----------|
| `hooks/PreCompact/beads-state-export.md` | NEU: Hook für State-Export vor Compaction |
| `commands/workflows/acms-work.md` | ERWEITERN: Environment Init, Auto-Select, Quality Gates |
| `skills/beads/SKILL.md` | ERWEITERN: Notes-Format Dokumentation |
| `.claude-plugin/plugin.json` | Version bump |
| `CHANGELOG.md` | Entry für v1.30.0 |
| `README.md` | Prerequisites aktualisieren |

---

## Acceptance Criteria

### PreCompact Hook
- [ ] Hook wird bei PreCompact Event ausgeführt
- [ ] `.beads/session-state.md` wird erstellt mit aktuellem Task-Status
- [ ] Beads Notes werden mit SESSION COMPACTED aktualisiert
- [ ] `bd sync` wird automatisch ausgeführt

### Environment Init
- [ ] DDEV wird automatisch gestartet wenn nicht läuft
- [ ] Session-Recovery wenn `.beads/session-state.md` existiert
- [ ] Prerequisite-Checks wie bisher (bd CLI)

### Auto-Select
- [ ] Höchster Priority Task wird automatisch gewählt
- [ ] Keine User-Interaktion für Task-Auswahl nötig
- [ ] Task wird automatisch auf `in_progress` gesetzt

### Quality Gates
- [ ] UI-Tasks MÜSSEN webapp-testing Verification haben
- [ ] Screenshot-Pfad wird in Beads Notes dokumentiert
- [ ] Task kann nicht geschlossen werden ohne Verification bei UI-Label

### Verification Evidence
- [ ] Notes-Format ist dokumentiert
- [ ] Screenshots werden in `screenshots/` gespeichert
- [ ] Timestamp und URL werden dokumentiert

---

## Risiken & Mitigations

| Risiko | Mitigation |
|--------|------------|
| PreCompact Hook läuft nicht | Fallback: Manuelles bd sync vor Session-Ende |
| DDEV Auto-Start schlägt fehl | Graceful degradation: Warning statt Error |
| webapp-testing zu langsam | Nur bei UI-Labels, nicht bei Backend-Tasks |
| Screenshot-Storage wächst | .gitignore für screenshots/, nur temporär |

---

## Nicht im Scope

- Automatische Compaction von Beads (bd admin compact)
- Multi-Agent Koordination
- Linear/Jira Integration für External Task Sync
- Video-Recording statt Screenshots

---

## Referenzen

- [Anthropic - Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Anthropic - Effective Context Engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [Research: Long-Running Agent Best Practices](plans/long-running-agents-best-practices.md)
- [Beads Integration v1.28.0](plans/beads-integration.md)
- [webapp-testing Skill](~/.claude/skills/webapp-testing/SKILL.md)

---

## Version

Diese Änderung wird als **v1.30.0** released (Minor: neue Features).
