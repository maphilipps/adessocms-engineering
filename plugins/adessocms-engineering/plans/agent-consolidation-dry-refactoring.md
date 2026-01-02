# Agent Consolidation Plan: DRY Refactoring

**Datum:** 2026-01-02
**Status:** ✅ COMPLETED
**Ziel:** Agent-Anzahl reduzieren, Duplicate Content eliminieren, Source-of-Truth etablieren

**Ergebnis:** 35 → 32 Agents, DRY durch Cross-References, v1.38.0 released

## Analyse-Ergebnis (Ultrathink)

### Identifizierte Duplicate Content

| Content | Vorkommen | Agents |
|---------|-----------|--------|
| SDC component.yml Schema | 4x | sdc, twig, drupal-theme, paragraphs |
| Props vs Slots Erklärung | 4x | sdc, twig, drupal-theme, paragraphs |
| `{% embed %}` mit `only` | 4x | sdc, twig, drupal-theme, paragraphs |
| Alpine.js Syntax | 2x | drupal-theme, sdc |
| `\|default()` vs `??` | 2x | twig, sdc |
| Context7/WebSearch Pattern | 4x | best-practices, framework-docs, librarian, repo-research |

### Konsolidierungsstrategie

**Prinzip:** Specialist = Source of Truth, andere Agents = Referenz

```
┌─────────────────────────────────────────────────────────────┐
│                    BEFORE (35 agents)                       │
├─────────────────────────────────────────────────────────────┤
│ drupal-theme-specialist (479 lines) ──┐                     │
│ twig-specialist (365 lines) ──────────┼─→ Massive Overlap   │
│ sdc-specialist (795 lines) ───────────┤                     │
│ paragraphs-specialist (451 lines) ────┘                     │
├─────────────────────────────────────────────────────────────┤
│ best-practices-researcher (56 lines) ─┐                     │
│ framework-docs-researcher (86 lines) ─┼─→ Same Tools        │
│ librarian (330 lines) ────────────────┤                     │
│ repo-research-analyst (117 lines) ────┘                     │
├─────────────────────────────────────────────────────────────┤
│ code-simplifier (230 lines) ──────────┐                     │
│ pattern-recognition-specialist (60) ──┼─→ Overlap           │
│ component-reuse-specialist (600) ─────┘                     │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    AFTER (31 agents)                        │
├─────────────────────────────────────────────────────────────┤
│ CLUSTER 1: Frontend (4 → 4, aber DRY)                       │
│ ├── sdc-specialist (Source of Truth: SDC)                   │
│ ├── twig-specialist (Source of Truth: Twig)                 │
│ ├── paragraphs-specialist (Source of Truth: Paragraphs)     │
│ └── drupal-theme-specialist (Orchestrator, referenziert)    │
├─────────────────────────────────────────────────────────────┤
│ CLUSTER 2: Research (4 → 2)                                 │
│ ├── librarian (erweitert: framework docs + best practices)  │
│ └── repo-research-analyst (lokal-fokussiert)                │
│ ✗ DELETED: best-practices-researcher                        │
│ ✗ DELETED: framework-docs-researcher                        │
├─────────────────────────────────────────────────────────────┤
│ CLUSTER 3: Code Quality (3 → 2)                             │
│ ├── code-simplifier (erweitert: pattern detection)          │
│ └── component-reuse-specialist (Drupal-spezifisch)          │
│ ✗ DELETED: pattern-recognition-specialist                   │
└─────────────────────────────────────────────────────────────┘
```

---

## Cluster 1: Frontend Agents (DRY Refactoring)

### Problem

4 Agents dokumentieren dieselben Konzepte:
- SDC component.yml Schema
- Props vs Slots
- `{% embed %}` mit `only`
- Cache-Metadata Patterns

### Lösung: Source of Truth + Referenzen

**sdc-specialist** wird Source of Truth für:
- component.yml Schema
- Props vs Slots
- Cache-safe Patterns

**twig-specialist** wird Source of Truth für:
- Twig Security (autoescape, |raw vermeiden)
- Attribute handling
- Template inheritance

**paragraphs-specialist** wird Source of Truth für:
- Field templates vs Entity templates
- Cache metadata bubbling
- `.value` vs `.entity` Patterns

**drupal-theme-specialist** wird Orchestrator:
- Referenziert die 3 Specialists
- Fokus auf Theme-Level (libraries.yml, preprocess, Vite)

### Implementation

#### 1. sdc-specialist bleibt (ist bereits umfassend)

#### 2. twig-specialist - Redundanz entfernen

Entferne aus twig-specialist:
- SDC component.yml Dokumentation (→ referenziere sdc-specialist)
- Props/Slots Details (→ referenziere sdc-specialist)

Behalte:
- Twig Security Best Practices
- Attribute Handling
- Template Inheritance

#### 3. paragraphs-specialist - Redundanz entfernen

Entferne:
- SDC Syntax Details (→ referenziere sdc-specialist)

Behalte:
- Field template Patterns
- Cache metadata bubbling
- Paragraph-spezifische Patterns

#### 4. drupal-theme-specialist - Zu Orchestrator machen

Entferne:
- Alle SDC Details (→ @sdc-specialist)
- Twig Details (→ @twig-specialist)

Behalte:
- Theme-Level Config (info.yml, libraries.yml)
- Vite/Build Setup
- Preprocess Functions
- Asset Libraries

Füge hinzu:
```markdown
## Referenzen zu Specialists

Für Detail-Fragen zu spezifischen Themen, nutze die entsprechenden Specialists:

- **SDC Komponenten:** @sdc-specialist (component.yml, Props, Slots)
- **Twig Templates:** @twig-specialist (Security, Attributes, Inheritance)
- **Paragraphs:** @paragraphs-specialist (Field Templates, Cache Bubbling)
```

---

## Cluster 2: Research Agents (Merge)

### Problem

4 Agents mit fast identischem Toolset:
- best-practices-researcher: Context7, WebSearch, WebFetch
- framework-docs-researcher: Context7, WebSearch, WebFetch
- librarian: Context7, WebSearch, Grep, Glob
- repo-research-analyst: Glob, Grep, Bash, Read

### Lösung: 2 Agents

**librarian** erweitert zu:
- External Research (was: best-practices + framework-docs)
- Evidence-based Answers mit Permalinks
- Context7, WebSearch, WebFetch, Grep, Glob

**repo-research-analyst** bleibt:
- Lokal-fokussiert (keine Web-Tools)
- Codebase-Analyse

### Implementation

#### 1. Lösche best-practices-researcher.md

#### 2. Lösche framework-docs-researcher.md

#### 3. Erweitere librarian.md

Füge hinzu:
- Framework documentation research (von framework-docs-researcher)
- Best practices gathering (von best-practices-researcher)
- Klarere Abgrenzung: "Für EXTERNE Quellen"

---

## Cluster 3: Code Quality (Merge)

### Problem

- code-simplifier: YAGNI, Over-engineering
- pattern-recognition-specialist: Design Patterns, Anti-Patterns
- component-reuse-specialist: DRY, Atomic Design

Overlap bei Anti-Pattern Detection.

### Lösung: 2 Agents

**code-simplifier** erweitert:
- Pattern/Anti-Pattern Detection (von pattern-recognition)
- YAGNI + Simplicity

**component-reuse-specialist** bleibt:
- Drupal-spezifische DRY Patterns
- SDC Reuse

### Implementation

#### 1. Lösche pattern-recognition-specialist.md

#### 2. Erweitere code-simplifier.md

Füge hinzu:
- Design Pattern Detection
- Anti-Pattern Erkennung
- Code Smell Detection

---

## Migrations-Checkliste

### Cluster 1 (Frontend) ✅ COMPLETED
- [x] sdc-specialist: Source of Truth + Cross-References
- [x] twig-specialist: Source of Truth + Cross-References
- [x] paragraphs-specialist: Source of Truth + Cross-References
- [x] drupal-theme-specialist: Orchestrator mit Referenzen

### Cluster 2 (Research) ✅ COMPLETED
- [x] librarian erweitern (framework-docs + best-practices Funktionalität)
- [x] best-practices-researcher.md löschen
- [x] framework-docs-researcher.md löschen

### Cluster 3 (Code Quality) ✅ COMPLETED
- [x] code-simplifier erweitern (pattern-recognition Funktionalität)
- [x] pattern-recognition-specialist.md löschen

### Plugin Updates ✅ COMPLETED
- [x] plugin.json Version bump (1.37.0 → 1.38.0)
- [x] CHANGELOG.md aktualisieren
- [x] README.md Agent-Counts anpassen (32 agents)

---

## Erwartetes Ergebnis

| Metrik | Vorher | Nachher | Änderung |
|--------|--------|---------|----------|
| Agent-Anzahl | 35 | 31 | -4 |
| Duplicate Content | ~2000 Zeilen | ~200 Zeilen | -90% |
| Maintenance Burden | Hoch | Niedrig | ↓ |
| Consistency | Inkonsistent | Konsistent | ↑ |

## Risiken

1. **Breaking Change für bestehende Workflows**
   - Mitigation: Alte Agent-Namen als Aliases behalten? Nein, clean break.

2. **Referenzen in anderen Files**
   - Mitigation: Grep nach gelöschten Agent-Namen, aktualisieren

3. **Funktionalitätsverlust**
   - Mitigation: Merge ALLE unique Features, nichts löschen was nicht doppelt ist
