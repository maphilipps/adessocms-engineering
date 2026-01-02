---
event: PreCompact
description: Exportiert Beads-Status vor Context-Compaction für Session-Kontinuität
---

# Beads State Export Hook

Automatische State-Konsolidierung vor Context-Compaction basierend auf Anthropics Best Practices für Long-Running Agents.

## Trigger

Wird automatisch vor Context-Compaction ausgeführt.

## Actions

### 1. Prüfe ob Beads aktiv ist

```bash
# Beads nur exportieren wenn aktiv
if [ ! -d ".beads" ] || ! command -v bd &> /dev/null; then
  exit 0  # Kein Beads-Projekt, Hook überspringen
fi
```

### 2. Aktiven Task identifizieren

```bash
current_task=$(bd list --status in_progress --json 2>/dev/null | jq -r '.[0].id // empty')

if [ -z "$current_task" ]; then
  echo "ℹ️ Kein aktiver Beads-Task - State-Export übersprungen"
  exit 0
fi
```

### 3. Session-State exportieren

**Spawn Haiku Agent für schnelle Dokumentation:**

```
Task(
  subagent_type="general-purpose",
  model="haiku",
  prompt="""
    Erstelle eine kompakte Session-Summary für .beads/session-state.md.

    1. Lies den aktuellen Beads-Task:
       bd show $CURRENT_TASK_ID

    2. Lies kürzliche Änderungen:
       git diff --name-only HEAD~3 2>/dev/null || git diff --name-only

    3. Erstelle .beads/session-state.md mit diesem Format:

    ```markdown
    # Session State - [ISO-8601 Timestamp]

    ## Active Task
    ID: [task-id]
    Title: [task-title]
    Status: in_progress

    ## Session Summary
    - Was wurde erreicht: [2-3 Punkte]
    - Aktuelle Arbeit: [was gerade passiert]
    - Offene Fragen: [falls vorhanden]

    ## Files Modified
    [Liste der geänderten Dateien]

    ## Next Steps
    [Was sollte die nächste Session tun?]

    ## Architectural Decisions
    [Falls relevante Entscheidungen getroffen wurden]
    ```

    4. Update Beads Notes:
       bd update [task-id] --notes "SESSION COMPACTED: $(date -Iseconds). See .beads/session-state.md"

    5. Sync:
       bd sync

    WICHTIG: Halte die Summary unter 500 Wörter. Fokus auf Kontext für nächste Session.
  """,
  description="Export session state"
)
```

### 4. Warum Haiku?

- **Schnell:** Minimale Latenz vor Compaction
- **Günstig:** Dokumentation braucht kein großes Modell
- **Konsistent:** Wie beim Context-Compaction selbst

## Output

Nach Ausführung existiert:

1. **`.beads/session-state.md`** - Session-Kontext für Recovery
2. **Beads Notes** - Update mit SESSION COMPACTED Marker
3. **Sync** - State ist in Git persistiert

## Session Recovery

Beim nächsten `/acms-work` Start:

```bash
if [ -f ".beads/session-state.md" ]; then
  echo "📋 Vorherige Session gefunden"
  cat .beads/session-state.md
  # User kann entscheiden: Kontext übernehmen oder neu starten
fi
```

## Referenz

- [Anthropic - Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- Progress file + Git = "Memory außerhalb Context"
