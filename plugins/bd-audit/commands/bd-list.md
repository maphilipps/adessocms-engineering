---
name: bd-list
description: "Zeigt alle durchgeführten Audits im Dashboard-Format"
allowed-tools: ["Read", "Glob", "Bash"]
---

Zeige alle durchgeführten Audits als übersichtliche Liste.

## Workflow

1. Suche alle Report-Verzeichnisse:
```bash
find reports/ -name "index.md" -type f 2>/dev/null | sort -r
```

2. Extrahiere Metadaten aus jedem Report (Frontmatter)

3. Zeige als Tabelle:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                        BD-AUDIT DASHBOARD
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DEZEMBER 2025
─────────────

| Lead                    | Score | CMS        | Aufwand | Status      |
|-------------------------|-------|------------|---------|-------------|
| Locarno Film Festival   | 78    | Drupal     | 180 PT  | 🟢 Hot      |
| Mercedes-Benz           | 92    | FirstSpirit| 450 PT  | 🔥 Very Hot |
| Deutsche Bank           | 45    | Custom     | 800 PT  | 🟡 Warm     |

NOVEMBER 2025
─────────────

| Lead                    | Score | CMS        | Aufwand | Status      |
|-------------------------|-------|------------|---------|-------------|
| ...                     | ...   | ...        | ...     | ...         |

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

STATISTIK
─────────
Gesamt:     24 Audits
Hot Leads:  8 (33%)
Pipeline:   €4.2M

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Report öffnen: /bd-open [firmenname]
```

## Score-Legende

- 🔥 Very Hot (90-100): Sofort anrufen!
- 🟢 Hot (70-89): Aktiv verfolgen
- 🟡 Warm (50-69): Nurturing
- 🔵 Cold (30-49): Beobachten
- ⚪ Ice (0-29): Niedrige Priorität
