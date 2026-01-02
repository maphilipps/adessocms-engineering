# Plan: Ultimate Worktool Quality Improvement

**Ziel:** adessocms-engineering Plugin von Architecture Health Score 7/10 auf 10/10 bringen
**Scope:** Alle gefundenen Issues aus 10 parallelen Agent-Reviews fixen
**Quality Level:** Perfekt - keine technische Schulden

---

## Review-Feedback Integration

> **Dieses Plan-Update basiert auf Feedback von 4 parallelen Reviewern:**
> - Drupal-Specialist: MCP Namespacing, Playwright Tools, Bash-Risiko
> - Architecture-Strategist: Pre-commit Hook verbessern, Deprecation-Aliases
> - Code-Simplifier: Scope-Warnung (ignoriert per User-Entscheidung)
> - Librarian: `plan_review` existiert NICHT als Underscore-Command (Korrektur)

---

## Vorbereitung

- [ ] **Git Status bereinigen:** Uncommitted changes committen (code-simplifier, agent-native-reviewer Moves)
- [ ] **Backup:** `git stash` falls nötig, sauberer Ausgangspunkt

---

## Phase 1: Strukturelle Fixes (Breaking Changes)

### 1.1 Agent Location Consolidation
**Finding:** code-simplifier und agent-native-reviewer sind in falschen Ordnern

- [ ] **DELETE** `agents/review/` Ordner komplett (git status zeigt bereits gelöscht)
- [ ] **VERIFY** `agents/specialists/code-simplifier.md` existiert
- [ ] **VERIFY** `agents/specialists/agent-native-reviewer.md` existiert
- [ ] **UPDATE** alle Referenzen von `review:code-simplifier` → `specialists:code-simplifier`
- [ ] **UPDATE** alle Referenzen von `review:agent-native-reviewer` → `specialists:agent-native-reviewer`

### 1.2 Duplikat-Agent Entfernen
**Finding:** code-quality-specialist = code-simplifier (70-80% identisch, verifiziert durch Librarian)

- [ ] **DELETE** `agents/specialists/code-quality-specialist.md`
- [ ] **SEARCH** alle Referenzen zu code-quality-specialist
- [ ] **REPLACE** mit code-simplifier wo referenziert
- [ ] **UPDATE** README.md Agent-Tabelle

### 1.3 Command Naming Migration (Breaking Change)
**Finding:** 3 Commands nutzen Unterstriche (KORRIGIERT: plan_review existiert nicht)

| Alt | Neu |
|-----|-----|
| `resolve_parallel` | `resolve-parallel` |
| `resolve_pr_parallel` | `resolve-pr-parallel` |
| `resolve_todo_parallel` | `resolve-todo-parallel` |

- [ ] **RENAME** `commands/resolve_parallel.md` → `commands/resolve-parallel.md`
- [ ] **RENAME** `commands/resolve_pr_parallel.md` → `commands/resolve-pr-parallel.md`
- [ ] **RENAME** `commands/resolve_todo_parallel.md` → `commands/resolve-todo-parallel.md`
- [ ] **UPDATE** name field in YAML frontmatter jeder Datei
- [ ] **SEARCH** alle Referenzen und aktualisieren

### 1.4 Deprecation-Aliases (NEU - Architecture-Strategist Empfehlung)
**Für 1 Version-Cycle alte Namen als Aliases behalten:**

- [ ] **CREATE** `commands/resolve_parallel.md` als Symlink/Redirect zu `resolve-parallel.md`
- [ ] **ADD** Deprecation-Warning in alten Command-Files:
  ```markdown
  > ⚠️ DEPRECATED: Use `/resolve-parallel` instead. This alias will be removed in v1.33.0.
  ```

### 1.5 Neuer Agent: reviewer-selector (NEU - User Request)
**AI-basierter Agent der dynamisch passende Reviewers wählt:**

- [ ] **CREATE** `agents/core/reviewer-selector.md`:
  ```markdown
  ---
  name: reviewer-selector
  description: AI-based agent that analyzes plan content and selects appropriate specialist reviewers dynamically
  tools: Read, Glob, Grep, Task
  model: haiku
  color: blue
  ---

  # Reviewer Selector

  ## Purpose
  Analyzes plan content to dynamically select the most relevant specialist agents for review.
  Replaces static reviewer lists with intelligent, context-aware selection.

  ## When to Use
  - Called by /acms-plan-review before launching reviewers
  - When reviewing plans with mixed or unclear domain focus
  - To ensure no relevant specialist is missed

  ## How It Works
  1. Read the plan file content
  2. Analyze for domain keywords and patterns
  3. Match against available specialists
  4. Return list of relevant agent IDs

  ## Selection Logic

  | Pattern in Plan | Triggers Agent |
  |-----------------|----------------|
  | drupal, module, hook, entity | drupal-specialist |
  | twig, template, render | twig-specialist |
  | tailwind, css, utility | tailwind-specialist |
  | sdc, component, slot, prop | sdc-specialist |
  | paragraph, field, bundle | paragraphs-specialist |
  | security, xss, sql, csrf | security-sentinel |
  | test, phpunit, coverage | test-coverage-specialist |
  | performance, cache, query | performance-oracle |
  | accessibility, wcag, aria | accessibility-specialist |
  | storybook, story, variant | storybook-specialist |
  | composer, dependency, package | composer-specialist |
  | architecture, pattern, design | architecture-strategist |
  | simple, yagni, over-engineer | code-simplifier |

  ## Fallback
  If NO patterns match, return Core-Reviewers:
  - code-simplifier
  - librarian
  - architecture-strategist

  ## Output Format
  ```json
  {
    "selected_reviewers": ["drupal-specialist", "sdc-specialist", "twig-specialist"],
    "reason": "Plan mentions Drupal module with SDC components and Twig templates",
    "confidence": "high"
  }
  ```
  ```

- [ ] **UPDATE** `commands/workflows/acms-plan-review.md` to use reviewer-selector

---

## Phase 2: Tools Field für alle Agents (Tiered Approach)

### 2.1 Workflow-Agents (Volle Tool-Suite)
**Diese Agents bekommen ALLE verfügbaren Tools:**

```yaml
tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch, WebSearch, TodoWrite, Task, mcp__context7__resolve-library-id, mcp__context7__query-docs, mcp__exa__web_search_exa, mcp__grep__searchGitHub, mcp__pw__browser_snapshot, mcp__pw__browser_click, mcp__pw__browser_navigate, mcp__pw__browser_take_screenshot, mcp__pw__browser_fill_form, mcp__pw__browser_evaluate, mcp__pw__browser_wait_for
```

> **KORREKTUR (Drupal-Specialist):** MCP Tool-Namen ohne `plugin_adessocms-engineering_` Prefix
> **ERGÄNZUNG (Drupal-Specialist):** Fehlende Playwright Tools hinzugefügt (fill_form, evaluate, wait_for)

Agents:
- [ ] `agents/core/librarian.md` ✅ (bereits gemacht - MCP Namen korrigieren)
- [ ] `agents/core/skill-invoker.md`
- [ ] `agents/core/frontend-engineer.md`
- [ ] `agents/core/document-writer.md`
- [ ] `agents/core/reviewer-selector.md` (NEU)
- [ ] `agents/workflow/acms-lint.md`
- [ ] `agents/workflow/acms-spec-flow-analyzer.md`
- [ ] `agents/workflow/acms-pr-comment-resolver.md`
- [ ] `agents/workflow/acms-bug-reproduction-validator.md`

### 2.2 Research-Agents (Research Tool-Suite)
**Diese Agents bekommen Research-fokussierte Tools:**

```yaml
tools: Read, Glob, Grep, WebFetch, WebSearch, mcp__context7__resolve-library-id, mcp__context7__query-docs, mcp__exa__web_search_exa, mcp__grep__searchGitHub
```

Agents:
- [ ] `agents/research/framework-docs-researcher.md`
- [ ] `agents/research/best-practices-researcher.md`
- [ ] `agents/research/git-history-analyzer.md`
- [ ] `agents/research/repo-research-analyst.md`

### 2.3 Specialist-Agents (Code-Review Tool-Suite)
**Diese Agents bekommen Code-Analyse Tools:**

```yaml
tools: Read, Glob, Grep
```

> **KORREKTUR (Drupal-Specialist):** Bash ENTFERNT - Code-Review Agents brauchen keine Command-Execution.
> Least-Privilege-Prinzip: Nur Read-Only Analyse-Tools.

- [ ] `agents/specialists/drupal-specialist.md`
- [ ] `agents/specialists/drupal-theme-specialist.md`
- [ ] `agents/specialists/tailwind-specialist.md`
- [ ] `agents/specialists/twig-specialist.md`
- [ ] `agents/specialists/sdc-specialist.md`
- [ ] `agents/specialists/paragraphs-specialist.md`
- [ ] `agents/specialists/storybook-specialist.md`
- [ ] `agents/specialists/composer-specialist.md`
- [ ] `agents/specialists/test-coverage-specialist.md`
- [ ] `agents/specialists/security-sentinel.md`
- [ ] `agents/specialists/accessibility-specialist.md`
- [ ] `agents/specialists/performance-oracle.md`
- [ ] `agents/specialists/pattern-recognition-specialist.md`
- [ ] `agents/specialists/architecture-strategist.md`
- [ ] `agents/specialists/component-reuse-specialist.md`
- [ ] `agents/specialists/code-simplifier.md`
- [ ] `agents/specialists/agent-native-reviewer.md`
- [ ] `agents/specialists/data-integrity-guardian.md`

### 2.4 Design-Agents (Browser + Design Tools)
**Diese Agents bekommen Browser-Automation Tools:**

```yaml
tools: Read, Write, Edit, Glob, Grep, mcp__pw__browser_snapshot, mcp__pw__browser_click, mcp__pw__browser_navigate, mcp__pw__browser_take_screenshot, mcp__pw__browser_fill_form, mcp__pw__browser_evaluate, mcp__pw__browser_wait_for, mcp__figma-dev-mode-mcp-server__get_design_context, mcp__figma-dev-mode-mcp-server__get_screenshot
```

- [ ] `agents/design/figma-design-sync.md`
- [ ] `agents/design/design-implementation-reviewer.md`
- [ ] `agents/design/design-iterator.md`

---

## Phase 3: Agent Standardisierung

### 3.1 Standard-Sections für ALLE Agents
**Jeder Agent muss diese Sections haben:**

```markdown
---
name: agent-name
description: One-line description
tools: [tool list]
model: sonnet|opus|haiku
color: blue|green|yellow|red|purple|cyan
---

# Agent Name

## Purpose
[2-3 sentences: What this agent does]

## When to Use
[Bullet list: Trigger conditions]

## How It Works
[Numbered steps: Process overview]

## Example Output
[Optional: Sample output format]
```

Agents ohne standardisierte Struktur (20 total):
- [ ] Alle in Phase 2 gelisteten Agents durchgehen
- [ ] Missing sections ergänzen
- [ ] Existing content in neue Struktur migrieren

### 3.2 Color Scheme Konsistenz
**Color-Schema nach Funktion:**

| Kategorie | Farbe | Agents |
|-----------|-------|--------|
| Core/Workflow | blue | librarian, skill-invoker, frontend-engineer, reviewer-selector |
| Research | yellow | framework-docs-researcher, best-practices-researcher, etc. |
| Specialists | green | drupal-specialist, sdc-specialist, etc. |
| Design | purple | figma-design-sync, design-iterator |
| Security | red | security-sentinel |

- [ ] `agents/specialists/code-simplifier.md`: green → blue (war Fehler)
- [ ] Alle anderen Agents prüfen und korrigieren

---

## Phase 4: Opus 4.5 Optimization

### 4.1 Anti-Pattern Removal
**Ersetze diese Patterns in ALLEN .md Dateien:**

| Anti-Pattern | Replacement |
|--------------|-------------|
| `CRITICAL:` | `Important:` oder natürliche Betonung |
| `MUST` (caps) | `should` oder `needs to` |
| `ALWAYS` (caps) | `consistently` oder weglassen |
| `NEVER` (caps) | `avoid` oder `do not` |
| `IMPORTANT:` | In Kontext einbauen ohne Label |
| `think step by step` | Weglassen (Opus macht das automatisch) |
| `Let's think` | Weglassen |

> **AUSNAHME (Drupal-Specialist):** security-sentinel.md behält starke Sprache, nur ohne ALL-CAPS.
> Beispiel: "Security vulnerabilities **must** be caught" statt "CRITICAL: YOU MUST"

Files zu prüfen (10+ mit Anti-Patterns):
- [ ] `commands/workflows/acms-plan.md`
- [ ] `commands/workflows/acms-review.md`
- [ ] `commands/workflows/acms-work.md`
- [ ] `commands/workflows/acms-compound.md`
- [ ] `agents/core/librarian.md`
- [ ] `agents/specialists/drupal-specialist.md`
- [ ] `agents/specialists/security-sentinel.md` (Hybrid-Approach: Bold statt CAPS)
- [ ] `agents/specialists/sdc-specialist.md`
- [ ] `agents/specialists/tailwind-specialist.md`
- [ ] `agents/specialists/twig-specialist.md`
- [ ] Alle anderen Agents scannen

### 4.2 Natural Language Rewrite
**Beispiel-Transformation:**

```markdown
# VORHER
CRITICAL: You MUST ALWAYS check for security vulnerabilities. NEVER skip this step.

# NACHHER (Normal)
Security review is an essential part of every code review. Check for common vulnerabilities before approving any changes.

# NACHHER (Security-Sentinel - Hybrid)
**Security review is mandatory.** Every code review must check for common vulnerabilities before approval. This step cannot be skipped.
```

---

## Phase 5: Documentation Update

### 5.1 Auto-Count Pre-Commit Hook (VERBESSERT)
**Erstelle robustes Script das Counts automatisch aktualisiert:**

> **KORREKTUR (Architecture-Strategist):** Präzisere Regex, Atomic Updates mit Backup

- [ ] **CREATE** `scripts/update-counts.sh`:
  ```bash
  #!/bin/bash
  set -e  # Exit on error

  # Calculate counts
  AGENTS=$(find agents -name "*.md" -type f | wc -l | tr -d ' ')
  COMMANDS=$(find commands -name "*.md" -type f | wc -l | tr -d ' ')
  SKILLS=$(find skills -name "*.md" -type f | wc -l | tr -d ' ')

  # Backup original files (atomic safety)
  cp .claude-plugin/plugin.json .claude-plugin/plugin.json.bak
  cp README.md README.md.bak

  # Update plugin.json with PRECISE regex
  sed -i '' "s/\"description\": \"[^\"]*\([0-9]\+\) agents/\"description\": \"AI-powered Drupal development with Plan→Review→Work→Compound workflow. ${AGENTS} agents/" .claude-plugin/plugin.json

  # Update README.md Component Count Table
  sed -i '' "/^| Agents |/s/| [0-9]\+/| ${AGENTS}/" README.md
  sed -i '' "/^| Commands |/s/| [0-9]\+/| ${COMMANDS}/" README.md
  sed -i '' "/^| Skills |/s/| [0-9]\+/| ${SKILLS}/" README.md

  # Verify changes
  if ! git diff --quiet .claude-plugin/plugin.json README.md; then
    echo "✅ Counts updated: Agents=${AGENTS}, Commands=${COMMANDS}, Skills=${SKILLS}"
    rm -f .claude-plugin/plugin.json.bak README.md.bak
  else
    echo "⚠️  No changes needed"
    mv .claude-plugin/plugin.json.bak .claude-plugin/plugin.json
    mv README.md.bak README.md
  fi
  ```

- [ ] **CREATE** `.git/hooks/pre-commit` (Standard Git Hook, nicht custom Claude Hook):
  ```bash
  #!/bin/bash
  bash scripts/update-counts.sh
  if ! git diff --quiet .claude-plugin/plugin.json README.md; then
    git add .claude-plugin/plugin.json README.md
    echo "📊 Auto-updated component counts"
  fi
  ```

- [ ] **CREATE** `scripts/install-hooks.sh`:
  ```bash
  #!/bin/bash
  ln -sf ../../scripts/pre-commit .git/hooks/pre-commit
  chmod +x .git/hooks/pre-commit
  echo "✅ Git hooks installed"
  ```

- [ ] **TEST** Hook funktioniert: `bash scripts/update-counts.sh`

### 5.2 README.md Komplett-Update

- [ ] **UPDATE** Component Counts (nach Auto-Script)
- [ ] **UPDATE** Agent-Tabelle (nach Duplikat-Entfernung)
- [ ] **ADD** MCP Server Section:
  ```markdown
  ## MCP Servers

  | Server | Type | Purpose | Key Tools |
  |--------|------|---------|-----------|
  | pw (Playwright) | stdio | Browser automation, screenshots, E2E testing | browser_snapshot, browser_click, browser_fill_form |
  | context7 | http | Library documentation lookup | resolve-library-id, query-docs |
  | exa | http | Web search, code context | web_search_exa, get_code_context_exa |
  | grep | http | GitHub code search | searchGitHub |
  ```
- [ ] **UPDATE** Installation instructions
- [ ] **VERIFY** alle Links funktionieren

### 5.3 plugin.json Update

- [ ] **UPDATE** version: 1.32.0
- [ ] **UPDATE** description mit korrekten Counts
- [ ] **VERIFY** MCP server definitions korrekt

### 5.4 CHANGELOG.md Update

- [ ] **ADD** v1.32.0 Entry mit allen Änderungen:
  - Breaking: Command renames (underscore → hyphen)
  - Removed: code-quality-specialist (duplicate)
  - Changed: Agent folder structure consolidated (review/ → specialists/)
  - Added: reviewer-selector agent for dynamic review loading
  - Added: Tools field to all agents (tiered approach)
  - Added: Standard sections to all agents
  - Changed: Opus 4.5 anti-patterns removed (except security-sentinel hybrid)
  - Added: Robust auto-count Git pre-commit hook
  - Updated: MCP documentation with all 4 servers
  - Added: Deprecation aliases for renamed commands

---

## Phase 6: Verification

### 6.1 Strukturelle Checks

- [ ] `find agents -name "*.md" | wc -l` = erwartete Anzahl
- [ ] `find commands -name "*.md" | wc -l` = erwartete Anzahl
- [ ] Keine Dateien in `agents/review/`
- [ ] Keine Underscore-Commands mehr (außer Deprecation-Aliases)
- [ ] Kein `code-quality-specialist.md`
- [ ] `reviewer-selector.md` existiert in `agents/core/`

### 6.2 Content Checks

- [ ] Alle Agents haben `tools` field
- [ ] Alle Agents haben `## Purpose` section
- [ ] Alle Agents haben `## When to Use` section
- [ ] Keine CRITICAL/MUST/ALWAYS/NEVER in caps (außer security-sentinel mit Bold)

### 6.3 Functional Checks

- [ ] `/acms-plan` funktioniert
- [ ] `/acms-plan-review` nutzt reviewer-selector für dynamische Auswahl
- [ ] `/acms-review` funktioniert mit allen Specialists
- [ ] `/acms-work` funktioniert
- [ ] Librarian findet Dokumentation
- [ ] Pre-commit Hook aktualisiert Counts

### 6.4 Browser Verification

- [ ] Playwright MCP kann Screenshots machen
- [ ] Chrome DevTools MCP funktioniert
- [ ] Design-Agents können Figma abfragen

---

## Phase 7: acms-plan-review Update (NEU)

### 7.1 Integration von reviewer-selector

- [ ] **UPDATE** `commands/workflows/acms-plan-review.md`:
  ```markdown
  ## 1. Dynamic Reviewer Selection

  First, use the reviewer-selector agent to analyze the plan and select appropriate reviewers:

  ```
  Task reviewer-selector(plan_file_path)
  → Returns: { selected_reviewers: [...], reason: "...", confidence: "high|medium|low" }
  ```

  ## 2. Run Selected Reviewers (Parallel)

  Based on reviewer-selector output, launch the selected specialists in parallel.

  **Fallback (if no patterns match or low confidence):**
  Launch Core-Reviewers: @code-simplifier @librarian @architecture-strategist

  ## 3. Deep Interview (AFTER Reviewers)
  [... rest unchanged ...]
  ```

---

## Execution Order

1. **Phase 1.1-1.5** - Strukturelle Breaking Changes + reviewer-selector erstellen
2. **Phase 2** - Tools zu allen Agents hinzufügen
3. **Phase 3** - Agent Standardisierung
4. **Phase 4** - Opus 4.5 Optimization
5. **Phase 5** - Documentation
6. **Phase 6** - Verification
7. **Phase 7** - acms-plan-review Integration

**Geschätzte Tasks:** ~85 individuelle Änderungen
**Empfehlung:** Mit parallelen Agents in Batches abarbeiten

---

## Notes

- Breaking Changes in Phase 1 erfordern Update aller Referenzen
- Deprecation-Aliases in Phase 1.4 ermöglichen sanfte Migration
- reviewer-selector ist ein haiku-Model Agent für schnelle Analyse
- Pre-commit Hook nutzt Standard Git Hooks (nicht custom Claude Hooks)
- security-sentinel behält starke Sprache, nur ohne CAPS (Hybrid-Approach)
- Verification sollte nach JEDEM Phase-Abschluss laufen, nicht nur am Ende
