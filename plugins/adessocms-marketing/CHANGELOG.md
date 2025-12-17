# Changelog

Alle wichtigen Änderungen an diesem Plugin werden hier dokumentiert.

Das Format basiert auf [Keep a Changelog](https://keepachangelog.com/de/1.0.0/),
und dieses Projekt folgt [Semantic Versioning](https://semver.org/lang/de/).

## [0.3.0] - 2024-12-17

### Added

- **Opus 4.5 Parallelisierungsanweisungen** für alle 7 Commands:
  - Explizite Anweisungen für parallele Task-Aufrufe
  - Model-Hinweise für optimale Agent-Performance
  - TaskOutput-Warte-Strategien zwischen Wellen

### Changed

- **Model-Selection optimiert** für 6 Agents:
  - `analysis-synthesizer` → opus (komplexe Synthese)
  - `context-generator` → opus (nuancierte Verdichtung)
  - `messaging-strategist` → opus (überzeugendes Messaging)
  - `content-strategist` → opus (strategische Planung)
  - `persona-builder` → opus (tiefe Persona-Entwicklung)
  - `conversion-psychologist` → opus (psychologische Analyse)

- **Tool-Nutzung verbessert** für 4 Agents:
  - `analysis-synthesizer` - Parallele Datei-Lektüre mit Glob+Read
  - `context-generator` - Verdichtungsstrategie
  - `company-researcher` - WebSearch/WebFetch Parallelisierung
  - `competitor-analyst` - 3-Phasen parallele Recherche

- **Parallelisierungs-Strategie** in Commands dokumentiert:
  - "KRITISCH"-Anweisungen für gleichzeitige Agent-Starts
  - Model-Tabelle in `/analyze` Command
  - Performance-Tipps für Opus 4.5

## [0.2.0] - 2024-12-17

### Added

- **3 neue Brand & Design Agents**:
  - `design-system-analyst` - Technische Corporate Design Analyse
    - Spacing System (Basis-Einheit, Scale)
    - Grid System (Columns, Breakpoints)
    - Typografie-System (Type Scale, Font Weights)
    - Farb-System (Semantic Colors, Tokens)
    - Komponenten-Bibliothek (Buttons, Cards, Forms)
    - Icon-System (Stil, Library, Größen)
    - Motion & Animation (Transitions, Easing)
    - Design Tokens Export (CSS Variables)

  - `corporate-communications-analyst` - PR, IR & Stakeholder-Kommunikation
    - Pressemitteilungen-Analyse (Frequenz, Stil, Key Messages)
    - Investor Relations (IR-Materialien, Financial Messaging)
    - Stakeholder-Matrix (Prioritäten, Kanäle, Messages)
    - Executive Communications (Leadership Voice, Thought Leadership)
    - Crisis Communications (Krisenbereitschaft, Reaktionsmuster)
    - CSR & Sustainability (ESG-Reporting, Authentizität)
    - Employer Branding (EVP, Karriere-Kommunikation)

  - `brand-consistency-auditor` - Multi-Channel Brand Audit
    - Visual Consistency (Logo, Farben, Typografie über Kanäle)
    - Verbal Consistency (Messaging, Tone of Voice)
    - Channel-by-Channel Audit (Website, LinkedIn, Twitter, etc.)
    - Inkonsistenz-Register (Kritisch, Mittel, Leicht)
    - Benchmark-Vergleich
    - Prioritierte Empfehlungen (Quick Wins, Kurzfristig, Mittelfristig)
    - Brand Governance Empfehlungen

### Changed

- Agent-Anzahl von 19 auf 22 erhöht
- Output-Dateien erweitert (15-design-system.md, 16-corporate-communications.md, 17-brand-consistency-audit.md)
- `/analyze-brand` Command um neue Agents erweitert
- `/analyze` Command Wave 4 um neue Agents erweitert

## [0.1.0] - 2024-12-14

### Added

- **7 Commands** für Marketing-Analysen:
  - `/analyze` - Vollständige Marketing-Analyse
  - `/analyze-company` - Unternehmensanalyse
  - `/analyze-market` - Markt- und Wettbewerbsanalyse
  - `/analyze-audience` - Zielgruppen- und Persona-Analyse
  - `/analyze-conversion` - Conversion-fokussierte Analyse
  - `/analyze-brand` - Marken- und Kommunikationsanalyse
  - `/generate-context` - AI-Kontext-Dokument erstellen

- **19 Agents** in 5 Kategorien:
  - **Research (5)**: company-researcher, product-analyst, market-researcher, competitor-analyst, industry-analyst
  - **Audience (4)**: persona-builder, voice-of-customer-analyst, journey-mapper, decision-analyst
  - **Conversion (5)**: objection-handler, trust-auditor, conversion-psychologist, messaging-strategist, value-communicator
  - **Brand (3)**: brand-analyst, tone-of-voice-expert, content-strategist
  - **Output (2)**: context-generator, analysis-synthesizer

- **5 Skills** mit Marketing-Wissen:
  - marketing-methodology
  - conversion-psychology
  - persona-development
  - competitive-analysis
  - brand-strategy

- Deutsche Reports und AI-Kontext-Dokumente
- Strukturierte Ausgabe in `./analysis/[firmenname]/`
- Typora-Integration für Markdown-Dokumente
