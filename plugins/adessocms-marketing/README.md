# adessocms-marketing

Vollständige Marketing-Intelligence für Unternehmen - von der Recherche bis zu konversionsoptimierten Inhalten.

## Features

- **Komplettanalyse** eines Unternehmens basierend auf Name/Website
- **19 spezialisierte Agents** für tiefgehende Analysen
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

## Agents (19)

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

### Output & Synthese
- `context-generator` - AI-Kontext erstellen
- `analysis-synthesizer` - Erkenntnisse zusammenführen

## Skills (5)

- `marketing-methodology` - Analyse-Frameworks
- `conversion-psychology` - Kaufpsychologie
- `persona-development` - Persona-Methodik
- `competitive-analysis` - Wettbewerbsanalyse-Frameworks
- `brand-strategy` - Markenstrategien

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
    ├── 15-ai-context.md         # AI-Kontext-Dokument
    └── 16-website-blueprint.md  # Website-Struktur
```

## Quick Start

```bash
# Vollständige Analyse starten
/analyze Firmenname https://example.com

# Nur Zielgruppenanalyse
/analyze-audience https://example.com
```

## Version

- **v0.1.0** - Initial release
