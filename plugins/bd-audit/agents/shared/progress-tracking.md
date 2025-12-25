---
name: progress-tracking
description: "Shared Progress-Tracking Instruktionen für alle Agenten"
---

# Progress Tracking System

## Für alle Agenten VERBINDLICH

### 1. SOFORT Schreiben

**Schreibe deine MD-Datei SOFORT wenn du Daten hast - nicht erst am Ende!**

```javascript
// FALSCH: Alles sammeln, am Ende schreiben
const allData = []
pages.forEach(p => allData.push(analyze(p)))
Write("output.md", formatAll(allData))  // ❌ Zu spät!

// RICHTIG: Inkrementell schreiben
Write("output.md", getHeader())  // ✓ Sofort Header
pages.forEach(p => {
  const result = analyze(p)
  Append("output.md", formatResult(result))  // ✓ Sofort jedes Ergebnis
})
Write("output.md", getFooter())  // ✓ Footer am Ende
```

### 2. Progress-Datei aktualisieren

**Jeder Agent MUSS `_progress.json` aktualisieren:**

```javascript
// Am Start des Agents
updateProgress({
  agent: "tech-stack-detector",
  status: "running",
  started_at: new Date().toISOString(),
  output_file: "discovery/tech-stack.md"
})

// Bei Fortschritt
updateProgress({
  agent: "tech-stack-detector",
  status: "running",
  progress: 45,  // Prozent
  message: "Analysiere Frontend-Frameworks..."
})

// Am Ende
updateProgress({
  agent: "tech-stack-detector",
  status: "completed",
  completed_at: new Date().toISOString(),
  output_file: "discovery/tech-stack.md",
  summary: {
    cms: "WordPress",
    frontend: "React",
    issues: 3
  }
})
```

### 3. Progress-Datei Format

`_progress.json`:

```json
{
  "audit_id": "adesso-2025-12-25",
  "base_url": "https://example.com",
  "started_at": "2025-12-25T10:00:00Z",
  "current_phase": 2,
  "phases": {
    "0": {"name": "Deep Crawl", "status": "completed", "agents": 1, "completed": 1},
    "1": {"name": "Discovery", "status": "completed", "agents": 8, "completed": 8},
    "2": {"name": "Inventory", "status": "running", "agents": 9, "completed": 5},
    "3": {"name": "Technical", "status": "pending", "agents": 8, "completed": 0},
    "4": {"name": "Legal", "status": "pending", "agents": 6, "completed": 0},
    "5": {"name": "Marketing", "status": "pending", "agents": 8, "completed": 0},
    "6": {"name": "UX", "status": "pending", "agents": 6, "completed": 0},
    "7": {"name": "Evaluation", "status": "pending", "agents": 6, "completed": 0},
    "8": {"name": "Synthesis", "status": "pending", "agents": 6, "completed": 0}
  },
  "agents": {
    "sitemap-crawler": {
      "phase": 0,
      "status": "completed",
      "started_at": "2025-12-25T10:00:00Z",
      "completed_at": "2025-12-25T10:15:00Z",
      "duration_seconds": 900,
      "output_file": "discovery/sitemap.md",
      "summary": {"pages_crawled": 127, "screenshots": 254}
    },
    "tech-stack-detector": {
      "phase": 1,
      "status": "completed",
      "started_at": "2025-12-25T10:15:00Z",
      "completed_at": "2025-12-25T10:17:00Z",
      "duration_seconds": 120,
      "output_file": "discovery/tech-stack.md",
      "summary": {"cms": "WordPress", "frontend": "jQuery"}
    },
    "content-inventory": {
      "phase": 2,
      "status": "running",
      "started_at": "2025-12-25T10:17:00Z",
      "progress": 65,
      "message": "Analysiere Seiten 82/127...",
      "output_file": "inventory/content.md"
    }
  },
  "errors": [
    {
      "agent": "social-media-scanner",
      "error": "LinkedIn API rate limited",
      "timestamp": "2025-12-25T10:16:30Z"
    }
  ],
  "statistics": {
    "total_agents": 58,
    "completed": 15,
    "running": 4,
    "pending": 38,
    "failed": 1,
    "progress_percent": 26
  }
}
```

### 4. Progress-MD für VitePress

Zusätzlich wird `_progress.md` für Live-Ansicht in VitePress generiert:

```markdown
---
title: Audit Progress
layout: progress
---

# Audit Progress: example.com

**Gestartet:** 25.12.2025 10:00 | **Fortschritt:** 26%

## Phasen-Übersicht

| Phase | Name | Status | Agenten |
|-------|------|--------|---------|
| 0 | Deep Crawl | ✅ | 1/1 |
| 1 | Discovery | ✅ | 8/8 |
| 2 | Inventory | 🔄 | 5/9 |
| 3 | Technical | ⏳ | 0/8 |
| 4 | Legal | ⏳ | 0/6 |
| 5 | Marketing | ⏳ | 0/8 |
| 6 | UX | ⏳ | 0/6 |
| 7 | Evaluation | ⏳ | 0/6 |
| 8 | Synthesis | ⏳ | 0/6 |

## Aktive Agenten

- 🔄 **content-inventory** (65%) - Analysiere Seiten 82/127...
- 🔄 **component-detector** (40%) - Erkenne UI-Patterns...
- 🔄 **media-inventory** (30%) - Zähle Bilder...
- 🔄 **form-inventory** (80%) - Fast fertig...

## Fertige Reports

- ✅ [Sitemap](./discovery/sitemap.md) - 127 Seiten gecrawlt
- ✅ [Tech Stack](./discovery/tech-stack.md) - WordPress + jQuery
- ✅ [Unternehmensprofil](./discovery/company.md)
- ✅ [Geschäftsbereiche](./discovery/business_segments.md)

## Fehler

- ⚠️ **social-media-scanner**: LinkedIn API rate limited
```
