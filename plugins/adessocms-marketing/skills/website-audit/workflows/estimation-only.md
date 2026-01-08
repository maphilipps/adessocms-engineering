# Estimation Only Workflow

Fast dual estimation based on entity inventory.

**REMINDER: All output must be in German (Deutsch).**

## Step 1: Gather Entity Inventory

### Option A: From User Input
User provides counts directly:
- Content Types: X (simple/medium/complex breakdown)
- Paragraph Types: X
- Taxonomies: X
- Views: X
- Webforms: X
- Custom Modules: X
- Theme Components: X
- Content items to migrate: X

### Option B: Quick Website Scan
```
mcp__claude-in-chrome__tabs_context_mcp (createIfEmpty: true)
mcp__claude-in-chrome__tabs_create_mcp
mcp__claude-in-chrome__navigate (url: <website_url>)
mcp__claude-in-chrome__read_page
```

Identify:
- Distinct page types (→ Content Types)
- Reusable components (→ Paragraphs)
- Category systems (→ Taxonomies)
- Listing pages (→ Views)
- Forms (→ Webforms)

## Step 2: Launch Estimation Agents (PARALLEL)

Launch both agents simultaneously with the entity inventory:

```
Task: traditional-estimator
Input: Entity inventory from Step 1
Reference: references/estimation-traditional.md

Task: ai-estimator
Input: Entity inventory from Step 1
Reference: references/estimation-ai-assisted.md
```

Wait for both agents to complete.

## Step 3: Synthesize Results

```
Task: estimation-synthesizer
Input: Results from both estimation agents
```

The synthesizer combines both estimates into a comparison report.

## Step 4: Output Report (GERMAN)

```markdown
# Projekt-Schätzung: [Projektname]

## Entity-Inventar

| Kategorie | Einfach | Mittel | Komplex | Gesamt |
|-----------|---------|--------|---------|--------|
| Inhaltstypen | X | X | X | X |
| Paragraphs | X | X | X | X |
| Taxonomien | X | X | X | X |
| Views | X | X | X | X |
| Webforms | X | X | X | X |
| Custom Modules | X | X | X | X |
| Theme-Komponenten | X | X | X | X |

**Migration:** X Inhalte (X einfach, X mittel, X komplex)

## Schätzungsvergleich

╔═══════════════════════════════════════════════════════════════╗
║              PROJEKT-SCHÄTZUNG VERGLEICH                       ║
╠═══════════════════════════════════════════════════════════════╣
║ Kategorie             │ Traditionell │ KI-Unterstützt │ Erspart║
╠═══════════════════════════════════════════════════════════════╣
║ Inhaltstypen          │ XXh          │ XXh            │ XX%    ║
║ Paragraphs            │ XXh          │ XXh            │ XX%    ║
║ Taxonomien            │ XXh          │ XXh            │ XX%    ║
║ Views                 │ XXh          │ XXh            │ XX%    ║
║ Webforms              │ XXh          │ XXh            │ XX%    ║
║ Custom Modules        │ XXh          │ XXh            │ XX%    ║
║ Theme-Komponenten     │ XXh          │ XXh            │ XX%    ║
║ Migration             │ XXh          │ XXh            │ XX%    ║
╠═══════════════════════════════════════════════════════════════╣
║ ZWISCHENSUMME         │ XXXh         │ XXXh           │        ║
║ + Testing (25%/10%)   │ XXXh         │ XXXh           │        ║
║ + Dokumentation       │ XXXh         │ XXXh           │        ║
║ + QA                  │ XXXh         │ XXXh           │        ║
║ + Projektmanagement   │ XXXh         │ XXXh           │        ║
║ + Puffer (20%/15%)    │ XXXh         │ XXXh           │        ║
╠═══════════════════════════════════════════════════════════════╣
║ GESAMT                │ XXXh         │ XXXh           │ XX%    ║
║ Zeitplan (40h/Woche)  │ XX Wochen    │ XX Wochen      │        ║
╠═══════════════════════════════════════════════════════════════╣
║ KI-ERSPARNIS          │         XX% Reduktion (XXXh)          ║
╚═══════════════════════════════════════════════════════════════╝

## Empfehlung

**KI-Unterstützte Entwicklung wird empfohlen:**
- Zeitersparnis: XX Wochen
- Kostenersparnis: €XX.XXX (bei €150/h)
- Gleiche Qualität durch AI-Review

## Voraussetzungen für KI-Schätzung

- Claude Code oder vergleichbares AI-Tool verfügbar
- Team in AI-Workflows geschult
- Standard Drupal Patterns verwendet
- Keine AI-Verbote durch Auftraggeber
```

## Estimation Formulas Reference

### Traditional Development
```
Base Hours = Σ (Entity Count × Complexity Factor)

Multipliers:
+ Testing: 25%
+ Documentation: 15%
+ QA: 20%
+ PM: 18%
+ Buffer: 20%

Total = Base × 1.98
```

### AI-Assisted Development
```
Base Hours = Traditional Base × 0.33

Multipliers:
+ Testing: 10%
+ Documentation: 5%
+ QA: 10%
+ PM: 15%
+ Buffer: 15%

Total = Base × 1.55
```

## Duration

Estimated: 30-60 minutes (depending on entity count method)
