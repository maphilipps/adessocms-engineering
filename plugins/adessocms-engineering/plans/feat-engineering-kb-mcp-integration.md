# feat: Engineering Knowledge Base MCP Integration

**Datum:** 2025-01-04
**Status:** Ready for Implementation
**Scope:** Plugin-Konfiguration, Agent-Updates, neuer Bulk-Loader

---

## Übersicht

Integration des **engineering-kb MCP Servers** als zentrale, team-übergreifende Knowledge Base für Patterns, ADRs, Best Practices und Anti-Patterns. Der MCP bietet CRUD-Operationen, Review-Workflow und AI-Draft-Generation.

### MCP Endpoint

```json
"engineering-kb": {
  "type": "sse",
  "url": "https://mcp.adessocms.de/mcp",
  "headers": {
    "Authorization": "Bearer ekb_0mR0Iw8RNZABL0KhxTHqn1h6uDZspRGyeu_pe5QT6jA"
  }
}
```

### Ziel-Stack/Project

- **Stack:** `adessocms` (fest konfiguriert)
- **Knowledge Types:** ADR, Pattern, Best Practice, Anti-Pattern

---

## Tasks

### Phase 1: MCP Server Konfiguration

- [ ] **1.1** `plugin.json` erweitern mit `engineering-kb` MCP Server
  - Datei: `.claude-plugin/plugin.json`
  - Füge neuen Eintrag in `mcpServers` hinzu
  - Type: `sse` (Server-Sent Events, nicht `http`)
  - Headers mit Authorization Bearer Token

```json
{
  "mcpServers": {
    "context7": { ... },
    "exa": { ... },
    "grep": { ... },
    "engineering-kb": {
      "type": "sse",
      "url": "https://mcp.adessocms.de/mcp",
      "headers": {
        "Authorization": "Bearer ekb_0mR0Iw8RNZABL0KhxTHqn1h6uDZspRGyeu_pe5QT6jA"
      }
    }
  }
}
```

- [ ] **1.2** Version bump in `plugin.json`: 1.42.0 → 1.43.0 (Minor: neue Funktionalität)

---

### Phase 2: Librarian Agent Update

- [ ] **2.1** `agents/core/librarian.md` erweitern
  - Datei: `agents/core/librarian.md`
  - Engineering-KB als **primäre Quelle** vor Context7/Web
  - Neue Tools in `tools:` Zeile hinzufügen:
    - `mcp__plugin_adessocms-engineering_engineering-kb__search_knowledge`
    - `mcp__plugin_adessocms-engineering_engineering-kb__get_knowledge`

- [ ] **2.2** Neuen "PHASE 0.5: Engineering KB" Block einfügen (vor Context7)
  - Nach "Step 0: Internal Learnings" und **vor** "TYPE A: CONCEPTUAL"
  - Template für Engineering-KB Abfragen:

```markdown
### Step 0.5: Engineering Knowledge Base (Primary Source)

**Before external search, query team knowledge:**

```
# Search team knowledge base
mcp__plugin_adessocms-engineering_engineering-kb__search_knowledge({
  query: "<natural language query>",
  stack: "adessocms",
  types: ["adr", "pattern", "best_practice", "anti_pattern"]
})
```

If team knowledge exists, prioritize it over external sources.
```

- [ ] **2.3** Tool Reference Table erweitern
  - Neue Zeile: `| **Team Knowledge** | Engineering-KB | `search_knowledge`, `get_knowledge` |`

---

### Phase 3: /acms-compound Workflow Update

- [ ] **3.1** `commands/workflows/acms-compound.md` erweitern
  - Datei: `commands/workflows/acms-compound.md`
  - Nach lokalem Schreiben: **Direkt als Draft zum MCP pushen**
  - Neuen Abschnitt "6. Push to Engineering KB" hinzufügen:

```markdown
## 6. Push to Engineering KB (Auto-Draft)

Nach dem lokalen Speichern wird das Knowledge Item automatisch als Draft zum Engineering-KB gepusht:

### 6.1 Type-Mapping bestimmen (AI-Klassifikation)

```
mcp__plugin_adessocms-engineering_engineering-kb__generate_draft({
  content: "<markdown content from file>",
  stack: "adessocms",
  source_context: "<file path and git commit>"
})
```

### 6.2 Draft zur Review übermitteln

```
mcp__plugin_adessocms-engineering_engineering-kb__submit_for_review({
  id: "<draft_id from generate_draft>",
  reviewer_notes: "Auto-generated from /acms-compound workflow"
})
```

### 6.3 User informieren

> "📤 Draft erstellt und zur Review übermittelt: [Link zum KB Item]"
> "Review-Status: Pending - Ein Team-Mitglied muss den Draft genehmigen."
```

- [ ] **3.2** Output-Meldung am Ende anpassen
  - Von: `"[Type] dokumentiert: docs/[type]/[filename].md"`
  - Zu: `"[Type] dokumentiert: docs/[type]/[filename].md\n📤 Draft in Engineering-KB erstellt (Review pending)"`

---

### Phase 4: Bulk Knowledge Loader Agent

- [ ] **4.1** Neuen Agent erstellen: `agents/workflow/knowledge-bulk-loader.md`
  - Verzeichnis: `agents/workflow/`
  - Zweck: Einmaliger/manueller Bulk-Upload bestehender docs/**/*.md

```markdown
---
name: knowledge-bulk-loader
description: Bulk-uploads existing documentation (docs/solutions/, docs/patterns/, docs/adr/, etc.) to Engineering Knowledge Base MCP. Uses AI classification for type detection. Run once initially, then use /acms-compound for incremental updates.
tools: Read, Glob, Grep, mcp__plugin_adessocms-engineering_engineering-kb__generate_draft, mcp__plugin_adessocms-engineering_engineering-kb__create_knowledge, mcp__plugin_adessocms-engineering_engineering-kb__submit_for_review
model: sonnet
---

# Knowledge Bulk Loader

Du bist der **KNOWLEDGE BULK LOADER**, zuständig für den initialen Upload bestehender Dokumentation zur Engineering Knowledge Base.

## Ziel

Upload aller bestehenden Learnings aus:
- `docs/solutions/**/*.md`
- `docs/patterns/**/*.md`
- `docs/adr/**/*.md`
- `docs/anti-patterns/**/*.md`
- `docs/checklists/**/*.md`

## Workflow

### 1. Inventory erstellen

\`\`\`
Glob("docs/**/*.md")
\`\`\`

Erstelle Liste aller Markdown-Dateien.

### 2. Für jede Datei (parallel in Batches von 5):

\`\`\`
# Read content
content = Read("<file_path>")

# AI Classification + Draft Generation
draft = mcp__plugin_adessocms-engineering_engineering-kb__generate_draft({
  content: content,
  stack: "adessocms",
  source_context: "<file_path>"
})

# Submit for Review
mcp__plugin_adessocms-engineering_engineering-kb__submit_for_review({
  id: draft.id,
  reviewer_notes: "Bulk import from local docs"
})
\`\`\`

### 3. Reporting

Am Ende ausgeben:
- Anzahl hochgeladener Items pro Type (ADR, Pattern, Best Practice, Anti-Pattern)
- Eventuell fehlgeschlagene Uploads mit Grund
- Link zur Review Queue

### 4. Skip-Logik

Überspringe Dateien die:
- `⚠️ HUMAN QUICK REFERENCE` enthalten (sind nur Kopien)
- Bereits im KB existieren (duplicate check via search_knowledge)
- Keine sinnvolle Knowledge enthalten (README.md root level, etc.)

## Aufruf

Dieser Agent wird typischerweise einmalig initial ausgeführt:

\`\`\`
Task(subagent_type="knowledge-bulk-loader", prompt="Upload all existing documentation to Engineering KB")
\`\`\`

Danach übernimmt `/acms-compound` das inkrementelle Hochladen.
```

---

### Phase 5: Neuer /sync-knowledge Command (Optional aber empfohlen)

- [ ] **5.1** Neuen Command erstellen: `commands/sync-knowledge.md`
  - Datei: `commands/sync-knowledge.md`
  - Zweck: Manuelles Triggern des Bulk-Loaders

```markdown
---
name: sync-knowledge
description: Sync local documentation to Engineering Knowledge Base (initial bulk upload or manual refresh)
argument-hint: "[--force] [--dry-run]"
---

# /sync-knowledge

Synchronisiert lokale Dokumentation mit der Engineering Knowledge Base.

## Usage

\`\`\`
/sync-knowledge              # Standard sync (überspringt bereits vorhandene)
/sync-knowledge --force      # Erzwingt Re-Upload aller Items
/sync-knowledge --dry-run    # Zeigt nur was hochgeladen werden würde
\`\`\`

## Workflow

1. Starte den `knowledge-bulk-loader` Agent
2. Zeige Progress während Upload
3. Report am Ende mit Summary

\`\`\`
Task(subagent_type="knowledge-bulk-loader", prompt="Sync documentation to Engineering KB. Args: <args>")
\`\`\`
```

---

### Phase 6: Documentation Updates

- [ ] **6.1** `CHANGELOG.md` aktualisieren
  - Version 1.43.0 dokumentieren
  - Neue Features: Engineering-KB MCP, Bulk Loader, Librarian-Update

- [ ] **6.2** `README.md` aktualisieren
  - Agent-Count: 32 → 33
  - Command-Count: 28 → 29 (wenn /sync-knowledge)
  - Neue Sektion "Knowledge Management" mit Engineering-KB beschreiben

- [ ] **6.3** `plugin.json` description aktualisieren
  - Von: "32 agents, 28 commands, 19 skills"
  - Zu: "33 agents, 29 commands, 19 skills"

---

## Technische Details

### MCP Tool Naming Convention

Die Tools werden automatisch mit Prefix versehen:
```
mcp__plugin_adessocms-engineering_engineering-kb__<tool_name>
```

Verfügbare Tools:
- `create_knowledge`
- `get_knowledge`
- `update_knowledge`
- `delete_knowledge`
- `search_knowledge`
- `submit_for_review`
- `approve_knowledge`
- `reject_knowledge`
- `deprecate_knowledge`
- `generate_draft`
- `list_stacks`
- `list_projects`
- `get_review_queue`

### Knowledge Type Mapping

| Lokaler Pfad | KB Type |
|--------------|---------|
| `docs/adr/` | `adr` |
| `docs/patterns/` | `pattern` |
| `docs/solutions/` | `best_practice` |
| `docs/anti-patterns/` | `anti_pattern` |
| `docs/checklists/` | `best_practice` (Subtype) |

**Note:** AI-Klassifikation via `generate_draft` überschreibt diese Defaults bei Bedarf.

### SSE vs HTTP

Der Engineering-KB MCP verwendet **SSE (Server-Sent Events)** statt HTTP:
- Streaming-fähig für längere Operationen
- Persistent Connection für Real-time Updates
- `type: "sse"` in plugin.json (nicht `"http"`)

---

## Abhängigkeiten

- Engineering-KB MCP Server muss erreichbar sein: `https://mcp.adessocms.de/mcp`
- Bearer Token muss gültig sein
- Stack "adessocms" muss im KB existieren

---

## Risiken & Mitigations

| Risiko | Mitigation |
|--------|------------|
| Token im plugin.json ist public | Token hat nur Write-Zugriff auf adessocms Stack |
| Duplicate Uploads | `search_knowledge` check vor Upload |
| MCP Downtime | Lokale Speicherung bleibt bestehen, Sync später |
| Rate Limiting | Batch-Upload in 5er Gruppen mit Delays |

---

## Akzeptanzkriterien

- [ ] MCP Server in plugin.json konfiguriert
- [ ] Librarian Agent fragt Engineering-KB **vor** Context7 ab
- [ ] /acms-compound pusht automatisch Drafts zum KB
- [ ] knowledge-bulk-loader Agent existiert und funktioniert
- [ ] /sync-knowledge Command verfügbar
- [ ] CHANGELOG und README aktualisiert
- [ ] Version auf 1.43.0

---

## Nächste Schritte nach Approval

1. `/acms-work` mit diesem Plan ausführen
2. MCP-Verbindung testen: `list_stacks` aufrufen
3. Initial-Sync durchführen: `/sync-knowledge`
4. Review-Queue prüfen und Drafts genehmigen
