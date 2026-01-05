---
name: acms-compound
description: Extract patterns and ADRs from solved problems - focus on reusable knowledge, not detailed solutions
argument-hint: "[optional: brief context]"
---

# /acms-compound - Pattern & ADR Extractor

Extrahiert **wiederverwendbare Patterns** und **Architecture Decision Records** aus gelösten Problemen.

## Core Principle

> **Patterns, nicht Lösungen. Abstrakt, nicht konkret. Wiederverwendbar, nicht einmalig.**

## 1. Was soll compounded werden?

Frage User mit AskUserQuestion:

```
AskUserQuestion(questions=[{
  "question": "Was möchtest du aus dieser Session extrahieren?",
  "header": "Compound",
  "options": [
    {"label": "Pattern", "description": "Wiederverwendbares Muster (z.B. 'Caching für Views')"},
    {"label": "ADR", "description": "Architecture Decision Record (z.B. 'Warum SDC statt Block')"},
    {"label": "Anti-Pattern", "description": "Was man NICHT tun sollte"},
    {"label": "Checklist", "description": "Prüfliste für wiederkehrende Aufgaben"}
  ],
  "multiSelect": true
}])
```

## 2. Pattern-Typ spezifizieren

Falls "Pattern" gewählt:

```
AskUserQuestion(questions=[{
  "question": "Welche Art von Pattern?",
  "header": "Pattern-Typ",
  "options": [
    {"label": "Design Pattern", "description": "Architektur/Code-Struktur"},
    {"label": "UI Pattern", "description": "Spacing, Typography, Layout"},
    {"label": "Integration Pattern", "description": "API, Services, Module"},
    {"label": "Testing Pattern", "description": "Test-Strategien, Mocks"}
  ],
  "multiSelect": false
}])
```

## 3. Output-Formate

### Pattern (docs/patterns/)

```markdown
---
title: [Pattern Name]
type: design|ui|integration|testing
tags: [drupal, sdc, caching]
date: 2025-01-01
---

# [Pattern Name]

## Kontext
Wann dieses Pattern anwenden?

## Problem
Welches wiederkehrende Problem löst es?

## Lösung (abstrakt)
```
[Schematische Darstellung, KEIN konkreter Code]
```

## Konsequenzen
- ✅ Vorteile
- ⚠️ Trade-offs

## Verwandte Patterns
- [Link zu ähnlichen Patterns]
```

### ADR (docs/adr/)

```markdown
---
title: ADR-XXX: [Entscheidung]
status: accepted|proposed|deprecated
date: 2025-01-01
deciders: [Namen]
---

# ADR-XXX: [Entscheidung]

## Kontext
Was war die Situation? Welche Faktoren spielten eine Rolle?

## Entscheidung
Was haben wir entschieden? (1-2 Sätze)

## Alternativen
| Option | Pro | Contra |
|--------|-----|--------|
| A | ... | ... |
| B | ... | ... |

## Konsequenzen
Was wird einfacher/schwieriger durch diese Entscheidung?
```

### Anti-Pattern (docs/anti-patterns/)

```markdown
---
title: [Anti-Pattern Name]
severity: critical|high|medium
tags: [security, performance]
date: 2025-01-01
---

# ❌ [Anti-Pattern Name]

## Das Problem
Was sieht man oft falsch gemacht?

## Warum schlecht?
Konkrete Konsequenzen (Performance, Security, Maintainability)

## Stattdessen
→ Verweis auf korrektes Pattern (KEIN Code hier)

## Erkennung
Wie findet man dieses Anti-Pattern im Code?
```

### Checklist (docs/checklists/)

```markdown
---
title: [Checklist Name]
scope: pre-commit|review|deployment
tags: [quality, testing]
date: 2025-01-01
---

# ✅ [Checklist Name]

## Wann verwenden?
[Kontext]

## Checkliste

### Kategorie A
- [ ] Punkt 1
- [ ] Punkt 2

### Kategorie B
- [ ] Punkt 3
- [ ] Punkt 4
```

## 4. Wichtige Regeln

### ❌ NICHT dokumentieren:
- Konkrete Code-Snippets (gehören in Skills, nicht Patterns)
- Einmalige Bugfixes ohne Muster
- Projekt-spezifische Details
- Implementierungs-Details

### ✅ Dokumentieren:
- Abstrakte, wiederverwendbare Erkenntnisse
- Entscheidungen mit Begründung
- Wiederkehrende Probleme und ihre Struktur
- Trade-offs und Konsequenzen

## 5. Abschluss (Lokal)

1. **Datei schreiben** in entsprechendes Verzeichnis
2. **In Typora öffnen:**
   ```bash
   open -a Typora docs/[type]/[filename].md
   ```

---

## 6. Push to Engineering-KB (Auto-Draft)

Nach dem lokalen Speichern wird das Knowledge Item automatisch als Draft zum Engineering-KB gepusht.

### 6.1 Type-Mapping

| Lokaler Type | KB Type |
|--------------|---------|
| Pattern | `pattern` |
| ADR | `adr` |
| Anti-Pattern | `anti-pattern` |
| Checklist | `best-practice` |

### 6.2 Draft erstellen

```
mcp__plugin_adessocms-engineering_engineering-kb__generate_draft({
  type: "<mapped_type>",
  title: "<title from frontmatter>",
  context: "<full markdown content>",
  projectId: "adessocms"  // fest konfiguriert
})
```

### 6.3 Draft zur Review übermitteln

```
mcp__plugin_adessocms-engineering_engineering-kb__submit_for_review({
  id: "<draft_id from generate_draft>"
})
```

### 6.4 User informieren

Nach erfolgreichem Push:

> "[Type] dokumentiert: `docs/[type]/[filename].md`"
> "📤 Draft in Engineering-KB erstellt (ID: `<id>`)"
> "Review-Status: Pending - Ein Team-Mitglied muss den Draft genehmigen."

Bei Fehler (z.B. MCP nicht erreichbar):

> "[Type] dokumentiert: `docs/[type]/[filename].md`"
> "⚠️ Engineering-KB Push fehlgeschlagen: <error>"
> "Lokale Datei wurde gespeichert. Nutze `/sync-knowledge` für manuellen Upload."

---

## Session End: Land the Plane

```bash
git add docs/
git commit -m "docs: Add [pattern|adr|anti-pattern|checklist] - [title]"
git push
```

> **"Knowledge compounds. Each pattern makes the team smarter."**
