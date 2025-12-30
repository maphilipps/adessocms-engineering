---
name: acms-plan
description: Transform feature descriptions into well-structured project plans following conventions
argument-hint: "[feature description, bug report, or improvement idea]"
---

# Create a plan for a new feature or bug fix

**Scope:** Erstelle einen Plan. Keine Implementation.

## Core Principle

> **We want the simplest change possible. We don't care about migration. Code readability matters most, and we're happy to make bigger changes to achieve it.**

## Introduction

**Note: The current year is 2025.** Use this when dating plans and searching for recent documentation.

Transform feature descriptions, bug reports, or improvement ideas into well-structured markdown files that follow project conventions and best practices.

## Feature Description

<feature_description> #$ARGUMENTS </feature_description>

**If the feature description above is empty, ask the user:** "What would you like to plan? Please describe the feature, bug fix, or improvement you have in mind."

Do not proceed until you have a clear feature description from the user.

## Main Tasks

### 0. Status Quo (Quick Context Scan)

**Understand the IST-Zustand first.**

1. **Read relevant files** - If the feature mentions specific areas, read those files
2. **Search for existing patterns** - `Grep` or `Glob` for related code
3. **Check docs/solutions/** - Look for existing learnings on this topic
4. **Understand the scope** - How big is this change? What exists already?

**This should be fast (1-2 minutes max).**

### 1. Grobe Research

Run these agents in parallel to gather initial context:

- Task repo-research-analyst(feature_description)
- Task best-practices-researcher(feature_description)
- Task framework-docs-researcher(feature_description)

**Keep findings ready for the interview.**

### 2. Deep Interview (MANDATORY)

**Interview me in detail using the AskUserQuestion tool about literally anything:**

- Technical implementation
- UI & UX
- Concerns
- Tradeoffs
- etc.

**But make sure the questions are NOT obvious.**

Be very in-depth and continue interviewing me continually until it's complete.

**Reference what you found in Status Quo AND Grobe Research.** Example informed questions:
- "I found `ExistingService.php` doing X. Should we extend it or create something new?"
- "There's already a similar pattern in `ModuleY`. Follow that or diverge?"
- "The current implementation uses caching strategy X. Keep that or change?"
- "I see no tests for this area. Is that intentional or a gap to fill?"
- "The docs say X is best practice, but your codebase does Y. Align or keep diverging?"

**Wichtig: Interview-Antworten müssen den Plan konkret machen.**

Jede Interview-Antwort muss **direkt in den Plan einfließen** als:
- **Konkrete Tasks** (nicht "klären ob X", sondern "tue X")
- **Spezifische Angaben** (nicht "Bilder optional", sondern "Bilder: ja, aus /path/to/source")
- **Explizite Vorbedingungen** (nicht "evtl. löschen", sondern "Schritt 0: Lösche 37 bestehende Einträge")

**Der Plan muss nach dem Interview eine "executable specification" sein:**
- Keine offenen Fragen mehr
- Keine "falls X, dann Y" - konkrete Entscheidungen
- `/acms-work` kann den Plan OHNE weitere Klärungsfragen ausführen

**Beispiele für schlechte vs. gute Plan-Einträge:**

❌ SCHLECHT: "Media Entities: klären ob nötig"
✅ GUT: "- [ ] Erstelle Media Entity für jedes Bild aus `/assets/vacancies/`"

❌ SCHLECHT: "Bestehende Daten: evtl. Clean Slate"
✅ GUT: "- [ ] **Vorbereitung:** Lösche alle 37 bestehenden `vacancy` Nodes"

❌ SCHLECHT: "Taxonomie: Terms on-the-fly oder vorab erstellen"
✅ GUT: "- [ ] Erstelle fehlende `job_category` Terms während der Migration (Pattern: `getOrCreateTerm()`)"

### 3. Additional Research (if needed)

If the interview reveals gaps, run additional research:

- [ ] Document all research findings with specific file paths (e.g., `web/modules/custom/example/src/Service/ExampleService.php:42`)
- [ ] Include URLs to external documentation and best practices guides
- [ ] Create a reference list of similar issues or PRs (e.g., `#123`, `#456`)
- [ ] Note any team conventions discovered in `CLAUDE.md` or team documentation

### 4. Issue Planning & Structure

**Title & Categorization:**

- [ ] Draft clear, searchable issue title using conventional format (e.g., `feat:`, `fix:`, `docs:`)
- [ ] Determine issue type: enhancement, bug, refactor

**Content Planning:**

- [ ] Choose appropriate detail level based on issue complexity
- [ ] List all necessary sections for the chosen template
- [ ] Gather supporting materials (error logs, screenshots, design mockups)
- [ ] Prepare code examples or reproduction steps if applicable

### 5. SpecFlow Analysis

After planning the issue structure, run SpecFlow Analyzer to validate and refine the feature specification:

- Task acms-spec-flow-analyzer(feature_description, research_findings)

**SpecFlow Analyzer Output:**

- [ ] Review SpecFlow analysis results
- [ ] Incorporate any identified gaps or edge cases into the issue
- [ ] Update acceptance criteria based on SpecFlow findings

### 6. Choose Implementation Detail Level

Select how comprehensive you want the issue to be. Simpler is mostly better.

#### 📄 MINIMAL (Quick Issue)

**Best for:** Simple bugs, small improvements, clear features

**Includes:**
- Problem statement or feature description
- Basic acceptance criteria
- Essential context only

#### 📋 MORE (Standard Issue)

**Best for:** Most features, complex bugs, team collaboration

**Includes everything from MINIMAL plus:**
- Detailed background and motivation
- Technical considerations
- Dependencies and risks
- Basic implementation suggestions

#### 📚 A LOT (Comprehensive Issue)

**Best for:** Major features, architectural changes, complex integrations

**Includes everything from MORE plus:**
- Detailed implementation plan with phases
- Alternative approaches considered
- Resource requirements and timeline
- Risk mitigation strategies

### 7. Issue Creation & Formatting

**Content Formatting:**

- [ ] Use clear, descriptive headings with proper hierarchy
- [ ] Include code examples in triple backticks with language syntax highlighting
- [ ] Add screenshots/mockups if UI-related
- [ ] Use task lists (- [ ]) for trackable items
- [ ] Apply appropriate emoji for visual scanning (🐛 bug, ✨ feature, 📚 docs, ♻️ refactor)

**Cross-Referencing:**

- [ ] Link to related issues/PRs using #number format
- [ ] Reference specific commits with SHA hashes when relevant
- [ ] Link to code using GitHub's permalink feature

### 8. Final Review & Submission

**Pre-submission Checklist:**

- [ ] Title is searchable and descriptive
- [ ] All template sections are complete
- [ ] Links and references are working
- [ ] Acceptance criteria are measurable
- [ ] Add names of files in pseudo code examples and todo lists

## 9. Output (END OF WORKFLOW)

**This is the final step. After this, the command is complete.**

1. Write the plan to `plans/<issue_title>.md`
2. Open in Typora:
   ```bash
   open -a Typora plans/<issue_title>.md
   ```
3. Report completion with this exact format:

> "Plan erstellt: `plans/<issue_title>.md` - Datei wurde in Typora geöffnet."

**END.** Do not continue. Do not suggest next steps. Do not offer to implement. Do not call `/acms-work`. The user will explicitly request implementation in a new message when ready.
