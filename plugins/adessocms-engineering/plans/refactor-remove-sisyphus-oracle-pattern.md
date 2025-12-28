# Refactor: Remove Sisyphus/Oracle Pattern

**Date:** 2025-12-28
**Status:** Analysis Complete - Recommendation: REMOVE
**Author:** Claude Analysis

---

## Executive Summary

Das "Sisyphus Orchestration (Opus) und Oracle Escalation"-Pattern ist **Overengineering** und sollte entfernt werden. Die bestehenden Workflow-Commands (`/acms-plan`, `/acms-review`, `/acms-work`, `/acms-compound`) decken bereits alle Funktionalität ab.

---

## Analyse-Ergebnisse

### 1. Was Sisyphus vorgibt zu tun vs. was es wirklich tut

| Behauptung | Realität |
|------------|----------|
| "Orchestriert Plan→Review→Work→Compound" | Nein - jeder Command ist selbständig, User ruft sie manuell auf |
| "Delegiert an Specialists parallel" | Das machen `/acms-plan` und `/acms-review` bereits selbst |
| "Eskaliert nach 3 Failures an Oracle" | Wurde nie implementiert/genutzt - theoretisches Pattern |
| "Captures learnings" | Das macht `/acms-compound` bereits |

**Sisyphus ist nur eine 336-Zeilen-Dokumentation des Workflows, keine ausführende Komponente.**

### 2. Was Oracle vorgibt zu tun vs. was es wirklich tut

| Behauptung | Realität |
|------------|----------|
| "Elevated consultant nach 3 Failures" | Nie genutzt - User sagten "Oracle ist unnötig" |
| "Braucht Opus-Qualität" | Kein Nachweis dass Opus hier Mehrwert bringt |
| "Architecture decisions" | `architecture-strategist` Specialist existiert bereits |

**Oracle ist ein ungenutzter Agent, der theoretisch für "schwierige Fälle" da sein sollte.**

### 3. Redundanz-Analyse

```
┌─────────────────────────────────────────────────────────────────┐
│                    AKTUELLE STRUKTUR (REDUNDANT)                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Sisyphus-Orchestrator ──────────────┐                          │
│       │                               │ BESCHREIBT              │
│       ▼                               ▼ DASSELBE                │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │  /acms-plan  →  /plan_review  →  /acms-work  →  /acms-review │
│  │       │              │               │              │        │
│  │   Research       Specialist       Execute        Review      │
│  │    Agents         Agents           Code          Agents      │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
│  Oracle ─────────────────┐                                       │
│       │                   │ ÜBERSCHNEIDET MIT                   │
│       ▼                   ▼                                      │
│  ┌────────────────────────────────────────┐                     │
│  │  architecture-strategist               │                     │
│  │  performance-oracle (anderer Agent!)   │                     │
│  │  User kann jederzeit Opus anfordern    │                     │
│  └────────────────────────────────────────┘                     │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 4. Interview-Ergebnisse

Aus dem Deep Interview mit dem User:

| Frage | Antwort |
|-------|---------|
| Ursprünglicher Anwendungsfall? | **"War experimentell"** |
| Wie oft genutzt? | **"Selten/Nie"** |
| Was macht Sisyphus, das Commands nicht tun? | **"Unklar"** |
| Oracle nötig? | **"Oracle ist unnötig"** |
| Komplexität? | **"Sehr komplex"** (>500 LOC) |

---

## Empfehlung: ENTFERNEN

### Was entfernt werden sollte

1. **`agents/core/sisyphus-orchestrator.md`** (336 LOC)
   - Grund: Reine Dokumentation, keine Funktion

2. **`agents/core/oracle.md`** (140 LOC)
   - Grund: Nie genutzt, überschneidet mit architecture-strategist

3. **`commands/acms-init.md`** - Sisyphus-Referenzen entfernen
   - Grund: Vereinfachen auf Workflow-Commands

4. **`plugin.json` Description** - "Sisyphus orchestration (Opus) and Oracle escalation" entfernen
   - Grund: Irreführend wenn es nicht existiert

5. **CHANGELOG.md** - Aufräumen (optional, historisch OK)

### Was beibehalten werden sollte

1. **Alle Workflow-Commands:** `/acms-plan`, `/acms-review`, `/acms-work`, `/acms-compound`
2. **Alle Specialist Agents:** Die sind wertvoll und werden genutzt
3. **Core Agents:** librarian, frontend-engineer, document-writer, skill-invoker
4. **Research Agents:** repo-research-analyst, best-practices-researcher, etc.
5. **`performance-oracle`** - Dieser ist ein Specialist, kein "Oracle" im Sisyphus-Sinne

### Beibehaltener Wert

Die **echte Compound Engineering Philosophie** bleibt erhalten:

```
Plan → Review → Work → Review → Compound
         ↑                  ↑
    Specialists parallel  Specialists parallel
```

Der Unterschied: **User orchestriert**, nicht ein fiktiver "Sisyphus-Agent".

---

## Implementation Steps

### Phase 1: Entfernen der Agents

```bash
# Sisyphus und Oracle entfernen
rm agents/core/sisyphus-orchestrator.md
rm agents/core/oracle.md
```

### Phase 2: acms-init vereinfachen

Die `/acms-init` Command sollte vereinfacht werden:

**Vorher:**
```markdown
## Workflow: Sisyphus Orchestration
...Oracle Escalation...
...Failure Protocol...
```

**Nachher:**
```markdown
## Workflow Commands

| Command | Purpose |
|---------|---------|
| `/acms-plan` | Create implementation plan with research agents |
| `/acms-review` | Review code with specialist agents |
| `/acms-work` | Execute work plan |
| `/acms-compound` | Document learnings |

## Agent Categories

- **Specialists:** domain-specific expertise (drupal, sdc, twig, etc.)
- **Research:** parallel codebase analysis
- **Core:** librarian, frontend-engineer, document-writer
```

### Phase 3: plugin.json aktualisieren

**Vorher:**
```json
"description": "AI-powered Drupal development with Sisyphus orchestration (Opus) and Oracle escalation. Full workflow: Plan→Review→Work→Review→Compound. 36 agents, 21 commands, 17 skills."
```

**Nachher:**
```json
"description": "AI-powered Drupal development with Plan→Review→Work→Compound workflow. 34 agents, 21 commands, 17 skills."
```

### Phase 4: Versioning

- Bump version: 1.24.0 → **1.25.0** (Minor - Feature removal)
- CHANGELOG: Document simplification

---

## Risiko-Analyse

| Risiko | Einschätzung | Mitigation |
|--------|--------------|------------|
| Funktionalität geht verloren | **Keins** - Sisyphus/Oracle wurden nie genutzt | - |
| Breaking Change | **Keins** - Niemand ruft diese Agents auf | - |
| Dokumentations-Verlust | **Minimal** - Workflow-Docs bleiben in Commands | Workflow bleibt in `/acms-*` Commands dokumentiert |

---

## Erwarteter Nutzen

1. **Reduzierte Komplexität:** ~476 LOC weniger zu pflegen
2. **Klareres Mental Model:** "4 Commands" statt "Sisyphus + Oracle + 4 Commands"
3. **Ehrliche Dokumentation:** Beschreibt was tatsächlich existiert
4. **Performance:** Weniger Agents = schnellere Plugin-Ladung
5. **Wartbarkeit:** Weniger Verwirrung für neue Teammitglieder

---

## Fazit

> **"Das beste Code ist der, den man nicht schreiben muss."**

Sisyphus und Oracle sind genau das Gegenteil: Code der geschrieben wurde, aber nie gebraucht wird. Die bestehenden Workflow-Commands sind self-contained, gut dokumentiert, und werden aktiv genutzt. Sisyphus/Oracle fügen nur Komplexität und Verwirrung hinzu.

**Empfehlung: Entfernen und Plugin vereinfachen.**

---

## Acceptance Criteria

- [ ] `sisyphus-orchestrator.md` entfernt
- [ ] `oracle.md` entfernt
- [ ] `acms-init.md` vereinfacht (keine Sisyphus/Oracle Referenzen)
- [ ] `plugin.json` Description aktualisiert
- [ ] CHANGELOG.md dokumentiert die Änderung
- [ ] Version auf 1.25.0 gebumpt
- [ ] README.md Agent-Count aktualisiert (36 → 34)
