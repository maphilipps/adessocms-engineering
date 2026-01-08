# adessocms-marketing

Vollständige Marketing-Intelligence für Unternehmen - von der Recherche bis zu konversionsoptimierten Inhalten.

## Features

- **Komplettanalyse** eines Unternehmens basierend auf Name/Website
- **22 spezialisierte Agents** für tiefgehende Analysen
- **Konversionsfokus**: Nicht nur Verstehen, sondern Verkaufen
- **AI-Kontext-Dokumente**: Perfekt für Claude/GPT System-Prompts
- **Deutsche Reports**: Alle Ausgaben auf Deutsch

## Commands

| Command | Beschreibung |
|---------|--------------|
| `/analyze` | Vollständige Marketing-Analyse starten |
| `/analyze-company` | Unternehmens-Deep-Dive |
| `/analyze-market` | Markt & Wettbewerbsanalyse |
| `/analyze-audience` | Zielgruppen & Personas |
| `/analyze-conversion` | Conversion-fokussierte Analyse |
| `/analyze-brand` | Marken- & Kommunikationsanalyse |
| `/generate-context` | AI-Kontext aus Analysen erstellen |

## Agents (25)

### Research & Discovery
- `company-researcher` - Firmengeschichte, Team, Kultur
- `product-analyst` - USPs, Portfolio, Differenzierung
- `market-researcher` - Marktgröße, Trends, Wachstum
- `competitor-analyst` - Wettbewerbsanalyse
- `industry-analyst` - Branchentrends, Regulierung

### Zielgruppe & Psychologie
- `persona-builder` - Buyer Personas erstellen
- `voice-of-customer-analyst` - Kundensprache analysieren
- `journey-mapper` - Customer Journey Mapping
- `decision-analyst` - Kaufentscheidungsprozesse

### Konversion
- `objection-handler` - Einwände katalogisieren
- `trust-auditor` - Trust & Social Proof Audit
- `conversion-psychologist` - Conversion Trigger
- `messaging-strategist` - Messaging Framework
- `value-communicator` - Wert-Kommunikation

### Marke & Content
- `brand-analyst` - Markenanalyse
- `tone-of-voice-expert` - Voice Guidelines
- `content-strategist` - Content-Strategie
- `design-system-analyst` - Technische Design-Spezifikationen (Spacing, Grid, Components)
- `corporate-communications-analyst` - PR, IR, Stakeholder-Kommunikation
- `brand-consistency-auditor` - Multi-Channel Brand Audit

### Output & Synthese
- `context-generator` - AI-Kontext erstellen
- `analysis-synthesizer` - Erkenntnisse zusammenführen
- `estimation-synthesizer` - Schätzungsvergleich erstellen

### Estimation (Website-Audit)
- `traditional-estimator` - Schätzung ohne AI
- `ai-estimator` - Schätzung mit AI (~67% Reduktion)

## Skills (6)

- `marketing-methodology` - Analyse-Frameworks
- `conversion-psychology` - Kaufpsychologie
- `persona-development` - Persona-Methodik
- `competitive-analysis` - Wettbewerbsanalyse-Frameworks
- `brand-strategy` - Markenstrategien
- `website-audit` - **NEU** Website-Audit für Drupal-Relaunches (siehe unten)

## Output

Alle Ergebnisse werden in `./analysis/[firmenname]/` gespeichert:

```
analysis/
└── firmenname/
    ├── 00-overview.md           # Executive Summary
    ├── 01-company.md            # Unternehmensanalyse
    ├── 02-products.md           # Produkt-/Serviceanalyse
    ├── 03-market.md             # Marktanalyse
    ├── 04-competitors.md        # Wettbewerbsanalyse
    ├── 05-industry.md           # Branchenanalyse
    ├── 06-personas.md           # Buyer Personas
    ├── 07-customer-journey.md   # Customer Journey
    ├── 08-voice-of-customer.md  # Kundensprache
    ├── 09-objections.md         # Einwand-Katalog
    ├── 10-trust-proof.md        # Trust & Social Proof
    ├── 11-messaging.md          # Messaging Framework
    ├── 12-brand.md              # Markenanalyse
    ├── 13-tone-of-voice.md      # Voice Guidelines
    ├── 14-content-strategy.md   # Content-Strategie
    ├── 15-design-system.md      # Design System Analyse
    ├── 16-corporate-communications.md  # Corporate Communications
    ├── 17-brand-consistency-audit.md   # Brand Consistency Audit
    ├── 18-ai-context.md         # AI-Kontext-Dokument
    └── 19-website-blueprint.md  # Website-Struktur
```

## Quick Start

```bash
# Vollständige Analyse starten
/analyze Firmenname https://example.com

# Nur Zielgruppenanalyse
/analyze-audience https://example.com
```

## Website-Audit Skill (NEU)

AI-gestütztes Website-Audit für **Drupal-Relaunch-Projekte**. Analysiert bestehende Websites und erstellt duale Schätzungen (mit/ohne AI-Unterstützung).

### Features

- **CMS-Erkennung**: WordPress, Drupal, Typo3, Magnolia, Sitecore, AEM
- **Content-Mapping**: Automatische Zuordnung zu Drupal-Entities
- **Duale Schätzung**: Traditionell vs. KI-unterstützt (~67% Reduktion)
- **Accessibility-Audit**: WCAG 2.1 AA Prüfung
- **Document Matching**: Website gegen Briefing/Specs matchen
- **VitePress-Output**: Automatische Dokumentations-Site

### Workflows

| Workflow | Beschreibung | Dauer |
|----------|--------------|-------|
| Full Audit | Komplette 11-Phasen-Analyse + VitePress | 2-4h |
| Quick Tech Check | CMS + Tech-Stack | 15-30min |
| Estimation Only | Entity-Count → Duale Schätzung | 30-60min |
| Document Match | Gap-Analyse gegen Briefing | 1-2h |

### Estimation Agents (3)

| Agent | Funktion |
|-------|----------|
| `traditional-estimator` | Schätzung ohne AI (100% manuell) |
| `ai-estimator` | Schätzung mit Claude Code (~67% Reduktion) |
| `estimation-synthesizer` | Vergleichsreport erstellen |

### Beispiel-Output

```
╔═══════════════════════════════════════════════════════════════╗
║              PROJEKT-SCHÄTZUNG VERGLEICH                       ║
╠═══════════════════════════════════════════════════════════════╣
║ Kategorie             │ Traditionell │ KI-Unterstützt │ Erspart║
╠═══════════════════════════════════════════════════════════════╣
║ Inhaltstypen          │ 24h          │ 8h             │ 67%    ║
║ Paragraphs            │ 52h          │ 17h            │ 67%    ║
║ Theme-Komponenten     │ 120h         │ 40h            │ 67%    ║
╠═══════════════════════════════════════════════════════════════╣
║ GESAMT                │ 874h         │ 294h           │ 66%    ║
║ KI-ERSPARNIS          │         66% Reduktion (580h)          ║
╚═══════════════════════════════════════════════════════════════╝
```

### Tools

- **Browser**: Claude in Chrome MCP (exklusiv)
- **Accessibility**: Accessibility MCP (WCAG 2.1)
- **Tech Detection**: WebSearch (BuiltWith, Wappalyzer)

## Opus 4.5 Optimierung

Dieses Plugin ist für **Opus 4.5** optimiert:

### Parallelisierung
- Alle Commands starten Agents **gleichzeitig** statt sequentiell
- Bis zu **6 Agents parallel** in einer Welle
- `TaskOutput` wartet auf alle Agents einer Welle bevor die nächste startet

### Model-Selection
| Agent-Typ | Model | Begründung |
|-----------|-------|------------|
| Research Agents | sonnet | Strukturierte Extraktion |
| `persona-builder` | opus | Tiefe Persona-Entwicklung |
| `conversion-psychologist` | opus | Psychologische Analyse |
| `messaging-strategist` | opus | Überzeugendes Messaging |
| `content-strategist` | opus | Strategische Planung |
| Output Agents | opus | Komplexe Synthese |

### Tool-Nutzung
- **Parallel WebSearch** für schnellere Recherche
- **Parallel WebFetch** für gleichzeitiges Seiten-Laden
- **Parallel Read** für Analyse-Dateien

## Version

- **v0.4.0** - Website-Audit Skill
  - Neuer Skill: `website-audit` für Drupal-Relaunch-Projekte
  - Duale Schätzung: Traditionell vs. KI-unterstützt (~67% Reduktion)
  - 3 neue Agents: `traditional-estimator`, `ai-estimator`, `estimation-synthesizer`
  - 4 Workflows: Full Audit, Quick Tech Check, Estimation Only, Document Match
  - Claude in Chrome MCP Integration
  - Accessibility MCP für WCAG 2.1 Tests
  - VitePress Dokumentations-Generator
- **v0.3.0** - Opus 4.5 Optimierung
  - Parallelisierungsanweisungen für alle Commands
  - Model-Selection für kreative/analytische Agents (opus)
  - Tool-Nutzungs-Optimierung in Agent-Prompts
- **v0.2.0** - Corporate Design & Communications Erweiterung
  - Neuer Agent: `design-system-analyst` - Technische CD-Analyse (Spacing, Grid, Icons, Components)
  - Neuer Agent: `corporate-communications-analyst` - PR, IR, Stakeholder-Kommunikation
  - Neuer Agent: `brand-consistency-auditor` - Multi-Channel Konsistenz-Check
- **v0.1.0** - Initial release
