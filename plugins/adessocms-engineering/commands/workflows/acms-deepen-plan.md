---
name: acms-deepen-plan
description: Power-enhance plans with ALL agents, skills, learnings, Context7, and web research in parallel
argument-hint: "[path to existing plan file]"
---

# /acms-deepen-plan - Power Enhancement Mode

**Scope:** Vertiefen mit umfassender Recherche-Tiefe. Keine Implementation.

## Core Principle

> **Run everything in parallel. Skills, Learnings, all Agents, Context7, WebSearch. 40+ parallel tasks are fine. Comprehensive coverage over efficiency.**

## Introduction

**Note: The current year is 2025.** Use this when searching for documentation.

Nimmt einen existierenden Plan und reichert ihn an mit:
- **Alle Skills** aus allen Quellen
- **Alle Learnings** aus `docs/solutions/`, `docs/patterns/`, `docs/adr/`
- **All Review Agents** (alle verfügbaren einbeziehen)
- **Context7 MCP** für Framework-Dokumentation
- **WebSearch** für aktuelle Best Practices

## Plan File

<plan_file> #$ARGUMENTS </plan_file>

**Falls leer:** "Welchen Plan vertiefen? (z.B. `plans/feat-my-feature.md`)"

---

## 1. Parse Plan Structure

**Lese Plan und extrahiere:**
- Overview/Problem Statement
- Technical Architecture
- Implementation Phases
- Code Examples
- Technologies mentioned (Drupal, Tailwind, Alpine, etc.)
- UI/UX Components

**Erstelle Section Manifest:**
```
Section 1: [Titel] - [Was zu recherchieren]
Section 2: [Titel] - [Was zu recherchieren]
...
```

---

## 2. Skills Discovery (Parallel)

**Finde alle Skills aus allen Quellen:**

```bash
# 1. Projekt-lokal
ls .claude/skills/

# 2. User global
ls ~/.claude/skills/

# 3. Alle installierten Plugins
find ~/.claude/plugins/cache -type d -name "skills" 2>/dev/null
```

**Für jeden gefundenen Skill:**
1. Lies `SKILL.md` für Beschreibung
2. Prüfe ob relevant für Plan
3. Spawne Sub-Agent

```
Task general-purpose: "
Skill: [skill-path]/SKILL.md
1. Lies den Skill komplett
2. Wende ihn auf diesen Plan an:
[plan content]
3. Gib die Skill-Empfehlungen zurück
"
```

**Parallel spawnen - 10, 20, 30 Skill-Agents sind unbedenklich.**

---

## 3. Learnings Discovery (Parallel)

**Durchsuche dokumentierte Learnings:**

```bash
# Patterns, ADRs, Anti-Patterns, Solutions
find docs/patterns -name "*.md" 2>/dev/null
find docs/adr -name "*.md" 2>/dev/null
find docs/anti-patterns -name "*.md" 2>/dev/null
find docs/solutions -name "*.md" 2>/dev/null
find docs/checklists -name "*.md" 2>/dev/null
```

**Für jede .md Datei - Frontmatter lesen:**

```yaml
---
title: "Cache Invalidation Pattern"
tags: [drupal, caching, views]
category: performance
---
```

**Filter nach Relevanz:**
- Tags matchen Plan-Technologien?
- Category passt zum Plan-Domain?
- Symptom/Problem könnte auftreten?

**Für jedes relevante Learning - Sub-Agent spawnen:**

```
Task general-purpose: "
Learning: [path to .md]
1. Lies das Learning komplett
2. Prüfe ob es auf diesen Plan zutrifft:
[plan content]
3. Falls relevant: Erkläre WIE es anwendbar ist
4. Falls nicht: Sag 'Not applicable: [reason]'
"
```

---

## 4. Context7 Framework Documentation

**Für jede im Plan erwähnte Technologie:**

```
mcp__plugin_adessocms-engineering_context7__resolve-library-id
→ Library ID für Drupal, Tailwind, Alpine, etc.

mcp__plugin_adessocms-engineering_context7__query-docs
→ Best Practices, Patterns, API-Referenzen
```

**Queries parallel ausführen für:**
- Drupal (wenn erwähnt)
- Tailwind CSS (wenn erwähnt)
- Alpine.js (wenn erwähnt)
- Twig (wenn erwähnt)
- Weitere Frameworks aus dem Plan

---

## 5. WebSearch Current Best Practices

**Suche nach aktuellen (2024-2025) Artikeln:**

```
WebSearch: "[technology] best practices 2025"
WebSearch: "[pattern] implementation guide"
WebSearch: "[problem from plan] solution"
```

**Für jede Major Section des Plans eine Suche.**

---

## 6. Run All Review Agents (Parallel)

**Finde alle verfügbaren Agents:**

```bash
# Plugin Agents (alle außer workflow/)
find agents/review -name "*.md"
find agents/research -name "*.md"
find agents/specialists -name "*.md"
find agents/design -name "*.md"
find agents/core -name "*.md"

# Projekt Agents
find .claude/agents -name "*.md" 2>/dev/null

# User Agents
find ~/.claude/agents -name "*.md" 2>/dev/null
```

**Wichtig: Alle verfügbaren Agents einbeziehen für umfassende Coverage.**

```
Für jeden gefundenen Agent:
  Task [agent-name]: "Review diesen Plan mit deiner Expertise: [plan content]"
```

**40+ parallele Agents sind unbedenklich. Umfassende Coverage anstreben.**

**Erwartete Agents:**
- drupal-specialist
- sdc-specialist
- twig-specialist
- tailwind-specialist
- paragraphs-specialist
- storybook-specialist
- accessibility-specialist
- security-sentinel
- performance-oracle
- architecture-strategist
- code-simplifier (includes pattern detection)
- component-reuse-specialist
- design-system-guardian
- test-coverage-specialist
- data-integrity-guardian
- composer-specialist
- drupal-theme-specialist
- agent-native-reviewer
- ... und alle weiteren verfügbaren

---

## 7. Wait and Synthesize

**Sammle Outputs von allen Quellen:**

| Quelle | Was extrahieren |
|--------|-----------------|
| Skills | Patterns, Code-Beispiele, Workflows |
| Learnings | Vergangene Lösungen, Pitfalls |
| Context7 | Framework-Dokumentation, APIs |
| WebSearch | Aktuelle Best Practices |
| Agents | Reviews, Empfehlungen, Warnungen |

**Deduplizieren und Priorisieren:**
- Ähnliche Empfehlungen mergen
- Nach Impact priorisieren
- Konflikte markieren
- Nach Plan-Section gruppieren

---

## 8. Enhance Plan Sections

**Format für jede Section:**

```markdown
## [Original Section Title]

[Original content preserved]

### Research Insights

**Best Practices:**
- [Konkrete Empfehlung 1]
- [Konkrete Empfehlung 2]

**Performance:**
- [Optimierung]
- [Benchmark/Metrik]

**Security:**
- [Consideration]

**Edge Cases:**
- [Edge Case und Handling]

**Learnings Applied:**
- [Relevantes Learning aus docs/]

**References:**
- [Context7 Doc Link]
- [WebSearch Article]
```

---

## 9. Add Enhancement Summary

```markdown
## Enhancement Summary

| Metric | Value |
|--------|-------|
| **Date** | 2025-01-01 |
| **Sections** | X |
| **Skills** | Y |
| **Learnings** | Z |
| **Agents** | N |

### Key Improvements
1. [Major improvement]
2. [Major improvement]

### New Considerations
- [Edge case found]
- [Risk identified]
```

---

## 10. Post-Enhancement Options

**Nach dem Schreiben - AskUserQuestion:**

```
AskUserQuestion(questions=[{
  "question": "Plan vertieft. Was als nächstes?",
  "header": "Next",
  "options": [
    {"label": "View diff", "description": "git diff zeigen"},
    {"label": "/acms-plan-review", "description": "Plan reviewen lassen"},
    {"label": "/acms-work", "description": "Implementation starten"},
    {"label": "Deepen more", "description": "Bestimmte Sections weiter vertiefen"},
    {"label": "Done", "description": "Fertig, in Typora öffnen"}
  ],
  "multiSelect": false
}])
```

**Basierend auf Auswahl:**
- **View diff** → `git diff [plan_path]`
- **/acms-plan-review** → Skill ausführen
- **/acms-work** → Skill ausführen
- **Deepen more** → Welche Sections? Dann nochmal agents spawnen
- **Done** → `open -a Typora [plan_path]`

---

## Quality Checks

- [ ] Original content preserved
- [ ] Research insights clearly marked
- [ ] Code examples syntactically correct
- [ ] No contradictions between sections
- [ ] Enhancement summary accurate

---

> **"Comprehensive research depth. Run everything. Let agents decide relevance."**
