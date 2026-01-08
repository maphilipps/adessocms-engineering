# Document Match Workflow

Compare website against client briefing/specifications to identify gaps.

**REMINDER: All output must be in German (Deutsch).**

## Step 1: Analyze Client Documents

### 1.1 Read Documents
User provides:
- Briefing (PDF, DOCX, MD)
- Requirements specification
- RFP/RFI documents
- Feature lists

```
Read provided documents
Extract and list all requirements
```

### 1.2 Categorize Requirements

Create requirement inventory:

| ID | Requirement | Category | Priority | Source |
|----|-------------|----------|----------|--------|
| R01 | Responsive Design | Design | Must | Briefing S.3 |
| R02 | News Section | Content | Must | RFP 2.1 |
| R03 | Multi-language | Tech | Should | Briefing S.5 |
| ... | ... | ... | ... | ... |

Categories:
- **Design:** Visual, UI/UX, Branding
- **Content:** Content types, structure, editorial
- **Tech:** Technical requirements, integrations
- **SEO:** Search optimization, analytics
- **A11y:** Accessibility requirements
- **Performance:** Speed, scalability
- **Security:** Authentication, data protection

## Step 2: Quick Website Analysis

### 2.1 Setup Browser
```
mcp__claude-in-chrome__tabs_context_mcp (createIfEmpty: true)
mcp__claude-in-chrome__tabs_create_mcp
mcp__claude-in-chrome__navigate (url: <website_url>)
```

### 2.2 Screenshot Homepage
```
mcp__claude-in-chrome__computer (action: "screenshot")
```

### 2.3 Targeted Analysis
Only analyze areas relevant to requirements:

```
mcp__claude-in-chrome__read_page
```

For each requirement category, check:
- Does the feature exist?
- How is it implemented?
- Does it meet the specification?

## Step 3: Gap Analysis

### 3.1 Compare Each Requirement

For each requirement:

| Status | Meaning |
|--------|---------|
| ✅ Erfüllt | Website has feature meeting specs |
| ⚠️ Teilweise | Feature exists but differs from specs |
| ❌ Fehlt | Feature not present on website |
| ➕ Zusätzlich | Website has feature not in specs |

### 3.2 Document Deviations

For ⚠️ and ❌ items, document:
- What is specified
- What exists (or doesn't)
- Gap description
- Estimated effort to close gap

## Step 4: Focused Estimation

Only estimate work for:
- ❌ Missing features (new development)
- ⚠️ Partial features (modifications)
- Migration of existing content

Skip estimation for:
- ✅ Features that match specifications
- Standard CMS features already available

Launch estimation agents with REDUCED scope:

```
Task: traditional-estimator
Input: Only gap items

Task: ai-estimator
Input: Only gap items
```

## Step 5: Output Report (GERMAN)

```markdown
# Gap-Analyse: [Projektname]

**Datum:** [Datum]
**Website:** [URL]
**Dokumente:** [Liste der analysierten Dokumente]

## Zusammenfassung

| Status | Anzahl | Prozent |
|--------|--------|---------|
| ✅ Erfüllt | X | XX% |
| ⚠️ Teilweise | X | XX% |
| ❌ Fehlt | X | XX% |
| ➕ Zusätzlich | X | - |

## Detaillierte Analyse

### ✅ Erfüllte Anforderungen

| ID | Anforderung | Website-Umsetzung |
|----|-------------|-------------------|
| R01 | Responsive Design | Bootstrap 5 Grid, alle Breakpoints |
| R02 | News Section | Blog mit Kategorien vorhanden |
| ... | ... | ... |

### ⚠️ Teilweise Erfüllt

| ID | Anforderung | Spezifikation | Ist-Zustand | Gap |
|----|-------------|---------------|-------------|-----|
| R05 | Suche | Volltextsuche mit Filtern | Nur einfache Suche | Filter fehlen |
| ... | ... | ... | ... | ... |

### ❌ Fehlende Funktionen

| ID | Anforderung | Beschreibung | Priorität |
|----|-------------|--------------|-----------|
| R08 | Mehrsprachigkeit | DE/EN/FR benötigt | Must |
| R12 | Event-Kalender | Veranstaltungsübersicht | Should |
| ... | ... | ... | ... |

### ➕ Zusätzliche Website-Features

| Feature | Beschreibung | Empfehlung |
|---------|--------------|------------|
| Newsletter-Popup | Exit-Intent Overlay | Übernehmen? |
| Social Sharing | Auf allen Seiten | Standard |
| ... | ... | ... |

## Handlungsbedarf

### Höchste Priorität (Must-Gaps)
1. **[R08] Mehrsprachigkeit:** Drupal Translation + Config Split
2. **[Rxx] ...:** ...

### Mittlere Priorität (Should-Gaps)
1. **[R12] Event-Kalender:** Smart Date + Views
2. **[Rxx] ...:** ...

## Fokussierte Schätzung (nur Gaps)

╔═══════════════════════════════════════════════════════════════╗
║              GAP-SCHÄTZUNG VERGLEICH                          ║
╠═══════════════════════════════════════════════════════════════╣
║ Gap-Kategorie         │ Traditionell │ KI-Unterstützt │ Erspart║
╠═══════════════════════════════════════════════════════════════╣
║ Neue Features         │ XXh          │ XXh            │ XX%    ║
║ Anpassungen           │ XXh          │ XXh            │ XX%    ║
║ Migration (Deltas)    │ XXh          │ XXh            │ XX%    ║
╠═══════════════════════════════════════════════════════════════╣
║ GAP-GESAMT            │ XXXh         │ XXXh           │ XX%    ║
╚═══════════════════════════════════════════════════════════════╝

**Hinweis:** Diese Schätzung deckt NUR die Gaps ab.
Basis-Setup und erfüllte Anforderungen sind nicht enthalten.

## Empfehlungen

### Für den Relaunch
1. [Empfehlung basierend auf Gap-Analyse]
2. [...]

### Quick Wins
- [Schnell umsetzbare Verbesserungen]

### Zu klärende Fragen
- [Offene Punkte für Auftraggeber]
```

## Duration

Estimated: 1-2 hours (depending on document size and website complexity)
