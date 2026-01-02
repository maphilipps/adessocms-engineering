# Plan: Reviewer-Agents Audit & Standardisierung

## Zusammenfassung

Umfassende Überarbeitung aller Reviewer-Agents im adessocms-engineering Plugin, um Best Practices durchgängig zu gewährleisten. Der aktuelle Stand zeigt kritische Lücken zwischen dokumentierten Best Practices (aus Projekterfahrung) und den Agent-Inhalten.

---

## Kritische Erkenntnisse

### 1. Broken Workflow References
`/acms-plan-review` referenziert 3 nicht-existierende Agents:
- `@agent-dries-drupal-reviewer` - EXISTIERT NICHT
- `@agent-drupal-reviewer` - EXISTIERT NICHT (nur `drupal-specialist`)
- `@agent-code-simplicity-reviewer` - EXISTIERT NICHT (nur `code-simplifier`)

**Aktion:** Workflow auf existierende Agents umstellen.

### 2. SDC-Specialist unvollständig
Vergleich mit venneker-drupal Projektdokumentation zeigt:
- **SDC Audit Report:** 60 Components, 12 kritische Issues die nicht verhindert wurden
- **Patterns.md:** 40+ bewährte Patterns fehlen im Agent
- **Pitfalls.md:** 25+ dokumentierte Fehler die nicht gecheckt werden

**Fehlende Checks im SDC-Specialist:**
- [ ] Slot-Variable-Rendering (`{{ variable }}` statt `{% block %}`)
- [ ] Props ohne strict type constraints für Drupal render arrays
- [ ] Alpine.js x-data scope validation
- [ ] Twig `|default()` statt `??` für Enum-Props
- [ ] Twig embed `only` keyword variable scoping
- [ ] UI Icons Pack field rendering (`content.field_*` nicht `term.field_*`)
- [ ] Vite HMR behavior auto-initialization
- [ ] Alpine.js full syntax (x-on: statt @)

### 3. Agent-Struktur inkonsistent
| Agent | Zeilen | Checklist | Output Format | BAD/GOOD | Status |
|-------|--------|-----------|---------------|----------|--------|
| sdc-specialist | 509 | Ja | Ja | Ja | Unvollständig |
| paragraphs-specialist | 450 | Ja | Ja | Ja | Gut |
| drupal-specialist | 441 | NEIN | Teilweise | Ja | Kritisch |
| tailwind-specialist | 361 | Teilweise | NEIN | Ja | Kritisch |
| security-sentinel | 134 | Teilweise | Teilweise | NEIN | Kritisch |
| twig-specialist | 293 | Ja | Ja | Ja | Kurz |

---

## Umfang

### In Scope
1. **Workflow-Fix:** `/acms-plan-review` und `/acms-review` auf existierende Agents umstellen
2. **Agent-Standardisierung:** Alle Specialists auf einheitliche Struktur bringen
3. **Best Practices Integration:** Erkenntnisse aus venneker-drupal einarbeiten
4. **Ordner-Konsolidierung:** `agents/review/` auflösen, Agents nach `agents/specialists/` verschieben

### Out of Scope
- Neue Agents erstellen (z.B. drupal-community-reviewer)
- Plugin-Architektur-Änderungen
- MCP-Tool-Integration

---

## Implementierungsplan

### Phase 1: Workflow-Fix (30 Min)

**1.1 `/acms-plan-review` reparieren**
```markdown
# VORHER (broken)
Have @agent-dries-drupal-reviewer @agent-drupal-reviewer
@agent-code-simplicity-reviewer @agent-sdc-specialist
@agent-tailwind-specialist review this plan in parallel.

# NACHHER (fixed)
Have @drupal-specialist @code-simplifier @sdc-specialist
@tailwind-specialist @paragraphs-specialist review this plan in parallel.
```

**1.2 `/acms-review` prüfen und ggf. anpassen**

---

### Phase 2: Agent-Standardisierung (4-6h)

**Standard-Template für alle Specialists:**

```markdown
---
name: [agent-name]
color: blue
description: Dual-purpose agent for implementing [X] correctly AND reviewing [X].
model: opus
---

# [Agent Name]

## Purpose
**Dual-purpose agent** for [domain].

## When to Use
### For Implementation Guidance
- [scenarios]

### For Code Review
- [scenarios]

## Expertise
- [list]

---

## Implementation Guidelines
[Correct patterns with BAD/GOOD examples]

<review_focus_areas>
## 1. [Focus Area]
[What to check, why it matters]
</review_focus_areas>

<common_issues>
## Common Issues & Solutions
### Issue 1
❌ BAD: [Anti-pattern with code]
✅ GOOD: [Correct pattern with code]
**Why:** [Explanation]
</common_issues>

<review_checklist>
## Review Checklist
### Critical (Blocking)
- [ ] [Check 1]
- [ ] [Check 2]

### High Priority
- [ ] [Check 3]

### Medium Priority
- [ ] [Check 4]
</review_checklist>

<output_format>
## Review Output Format
```markdown
## Summary Metrics
| Metric | Value |
|--------|-------|
| Files Reviewed | X |
| Issues Found | Y (Z Critical, W High) |
| Verdict | PASS / NEEDS WORK / BLOCKED |

## Critical Issues (Blocking)
### [Issue Title] (file:line)
**Issue:** [description]
**Impact:** [why it matters]
**Fix:**
```diff
- old code
+ new code
```
**Reference:** [documentation link]
```
</output_format>

<references>
## References
- [Official docs]
</references>

<code_exploration>
Read and understand relevant files before proposing code edits.
**Exploration Limits:**
- Single-file changes: Read only changed file + direct imports
- Multi-file changes: Read changed files + 1 level of dependencies
- Never explore more than 20 files without explicit request
</code_exploration>
```

---

### Phase 3: SDC-Specialist Erweiterung (2-3h)

**Neue Checks basierend auf venneker-drupal Erfahrungen:**

#### 3.1 Slot-Variable-Rendering Pattern
```twig
{# ❌ FALSCH - block() in SDC #}
{% if block('media') is defined %}{% block media %}{% endblock %}{% endif %}

{# ✅ RICHTIG - Variable rendering #}
{% if media %}{{ media }}{% endif %}
```

#### 3.2 Props für Drupal Render Arrays
```yaml
# ❌ FALSCH - Strict type breaks with render arrays
title:
  type: string  # Causes 500 error wenn Drupal render array schickt

# ✅ RICHTIG - No strict type
title:
  title: Heading Text
  description: The heading text content (string or render array)
```

#### 3.3 Twig Default Filter
```twig
{# ❌ FALSCH - ?? funktioniert nicht für field values #}
{% set width = paragraph.field_width.value ?? 'wide' %}

{# ✅ RICHTIG - |default filter #}
{% set width = paragraph.field_width.value|default('wide') %}
```

#### 3.4 Alpine.js Syntax in Twig
```twig
{# ❌ FALSCH - Twig filtert shorthand #}
<button @click="toggle()" :class="{ 'active': open }">

{# ✅ RICHTIG - Full syntax #}
<button x-on:click="toggle()" x-bind:class="{ 'active': open }">
```

#### 3.5 Embed Variable Scoping
```twig
{# ❌ FALSCH - content nicht verfügbar in block mit 'only' #}
{% embed 'component' with { prop: value } only %}
  {% block content %}
    {{ content.field_x }}  {# UNDEFINED! #}
  {% endblock %}
{% endembed %}

{# ✅ RICHTIG - Explizit übergeben #}
{% embed 'component' with {
  prop: value,
  field_x: content.field_x
} only %}
  {% block content %}
    {{ field_x }}  {# Works! #}
  {% endblock %}
{% endembed %}
```

#### 3.6 UI Icons Pack Rendering
```twig
{# ❌ FALSCH - Direct access #}
{{ term.field_icon.0 }}  {# Type conversion error! #}

{# ✅ RICHTIG - Rendered field #}
{{ content.field_icon }}
```

#### 3.7 Vite HMR Behavior Pattern
```javascript
// MANDATORY: Auto-initialization für Vite HMR
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => {
    Drupal.behaviors.myBehavior.attach(document, {});
  });
} else {
  Drupal.behaviors.myBehavior.attach(document, {});
}
```

---

### Phase 4: Weitere Specialists (2-3h)

**4.1 drupal-specialist erweitern:**
- `<review_checklist>` Section hinzufügen
- Strukturiertes `<output_format>`

**4.2 tailwind-specialist erweitern:**
- `<output_format>` Section hinzufügen
- Review Checklist in Tags wrappen

**4.3 security-sentinel erweitern:**
- Auf ~300 Zeilen erweitern
- BAD/GOOD Code-Beispiele für Drupal
- OWASP Top 10 Drupal-spezifisch

**4.4 twig-specialist erweitern:**
- Mehr BAD/GOOD Beispiele
- Drupal-spezifische Patterns

---

### Phase 5: Ordner-Konsolidierung (30 Min)

1. `agents/review/code-simplifier.md` → `agents/specialists/code-simplifier.md`
2. `agents/review/agent-native-reviewer.md` → `agents/specialists/agent-native-reviewer.md`
3. `agents/review/` Ordner löschen
4. plugin.json aktualisieren
5. README.md Agent-Counts aktualisieren

---

## Zeitschätzung

| Phase | Aufwand |
|-------|---------|
| Phase 1: Workflow-Fix | 30 Min |
| Phase 2: Agent-Template erstellen | 1h |
| Phase 3: SDC-Specialist | 2-3h |
| Phase 4: Weitere Specialists | 2-3h |
| Phase 5: Ordner-Konsolidierung | 30 Min |
| **GESAMT** | **6-8h** |

---

## Akzeptanzkriterien

### Workflows
- [ ] `/acms-plan-review` funktioniert ohne Fehler
- [ ] `/acms-review` funktioniert ohne Fehler

### Agent-Struktur
- [ ] Alle Specialists haben `<review_checklist>` Section
- [ ] Alle Specialists haben `<output_format>` Section
- [ ] Alle Specialists haben `<common_issues>` mit BAD/GOOD Beispielen
- [ ] Alle Specialists haben `<code_exploration>` Section

### SDC-Specialist
- [ ] Alle 7 neuen Checks aus Phase 3 integriert
- [ ] Erfahrungen aus venneker-drupal dokumentiert
- [ ] Checklist auf 30+ Items erweitert

### Ordner-Struktur
- [ ] `agents/review/` nicht mehr vorhanden
- [ ] Alle Agents in `agents/specialists/`
- [ ] plugin.json aktualisiert
- [ ] README.md aktualisiert

---

## Risiken

| Risiko | Wahrscheinlichkeit | Impact | Mitigation |
|--------|-------------------|--------|------------|
| Agent-Länge zu groß für Context | Mittel | Hoch | Fokus auf kritische Checks, Referenz zu docs/solutions |
| Breaking Changes in Workflows | Niedrig | Hoch | Gründliches Testen vor Commit |
| Zu viele Checks = langsame Reviews | Mittel | Mittel | Prioritäts-basierte Checkliste (Critical/High/Medium) |

---

## Nächste Schritte nach Approval

1. Phase 1 sofort umsetzen (Workflow-Fix)
2. Phase 3 als Priorität (SDC-Specialist ist am kritischsten laut User)
3. Parallel: Phase 4 für andere Specialists
4. Zum Schluss: Phase 5 Ordner-Konsolidierung

**Plan-Status:** BEREIT ZUR REVIEW
