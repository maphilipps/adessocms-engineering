---
name: Marketing Intelligence
description: Ressourcen für Markt- und Wettbewerbsanalyse im BD-Kontext
version: 1.0.0
---

# Marketing Intelligence

Methoden und Quellen für die Markt- und Wettbewerbsanalyse bei Website-Audits.

## Datenquellen

### Kostenlose Quellen

| Quelle | Daten | Zugang |
|--------|-------|--------|
| **Bundesanzeiger** | Jahresabschlüsse, Bilanzen | bundesanzeiger.de |
| **Handelsregister** | Firmendaten, Gesellschafter | handelsregister.de |
| **DENIC** | Domain-Inhaber (DE) | denic.de |
| **LinkedIn** | Unternehmensgröße, Mitarbeiter | linkedin.com |
| **Xing** | DACH-Unternehmensdaten | xing.com |
| **Kununu** | Arbeitgeber-Bewertungen | kununu.com |
| **Google News** | Pressemeldungen | news.google.com |
| **Crunchbase** | Funding, Startups | crunchbase.com (limited) |

### Traffic & SEO

| Tool | Daten | Modell |
|------|-------|--------|
| **SimilarWeb** | Traffic, Quellen, Keywords | Freemium |
| **SEMrush** | SEO, Backlinks, Keywords | Paid |
| **Ahrefs** | Backlinks, Content | Paid |
| **Ubersuggest** | Keywords, Traffic | Freemium |
| **BuiltWith** | Technologien, Historie | Freemium |

### Technologie-Erkennung

| Tool | Fokus | Integration |
|------|-------|-------------|
| **Wappalyzer** | Alle Technologien | MCP Server |
| **BuiltWith** | CMS, E-Commerce | API |
| **WhatCMS** | CMS-Erkennung | API |
| **Netcraft** | Hosting, Security | Web |

## Branchenanalyse

### Branchencodes (WZ 2008)

| Code | Branche | Web-Relevanz |
|------|---------|--------------|
| 10-33 | Verarbeitendes Gewerbe | B2B Websites |
| 45-47 | Handel | E-Commerce |
| 49-53 | Transport & Logistik | B2B Portale |
| 55-56 | Gastgewerbe | Booking, Local SEO |
| 58-63 | Information & Kommunikation | Tech, SaaS |
| 64-66 | Finanzdienstleistungen | Compliance, Security |
| 68 | Immobilien | Portale, Listings |
| 69-75 | Unternehmensdienstleistungen | Corporate Websites |
| 85 | Erziehung & Unterricht | Portale, LMS |
| 86-88 | Gesundheit & Soziales | DSGVO, A11y |

### Branchenspezifische Anforderungen

#### Finanzdienstleistungen
- ✅ Höchste Security-Standards
- ✅ DSGVO/BDSG strikt
- ✅ Barrierefreiheit (BFSG)
- ✅ Audit-Trail für Änderungen
- ✅ Multi-Faktor-Authentifizierung

#### Gesundheitswesen
- ✅ DSGVO mit Gesundheitsdaten (Art. 9)
- ✅ Barrierefreiheit kritisch
- ✅ Terminbuchungssysteme
- ✅ Patientenportale

#### E-Commerce / Handel
- ✅ PCI-DSS für Payments
- ✅ Widerrufsbelehrung
- ✅ Cookie-Consent
- ✅ Performance-kritisch

#### Industrie / B2B
- ✅ Produktkataloge
- ✅ Konfiguratoren
- ✅ Kundenportale
- ✅ Multi-Language

#### Öffentliche Hand
- ✅ BITV 2.0 (Barrierefreiheit)
- ✅ EVB-IT Verträge
- ✅ Open Source bevorzugt
- ✅ IT-Grundschutz

## Wettbewerbsanalyse

### Analyse-Framework

```
WETTBEWERBER-PROFIL
├── Basis-Daten
│   ├── Website-URL
│   ├── Unternehmensgröße
│   ├── Gründungsjahr
│   └── Standorte
├── Digital Presence
│   ├── Website-Technologie
│   ├── Traffic-Schätzung
│   ├── SEO-Performance
│   └── Social Media
├── Content & Marketing
│   ├── Blog/News
│   ├── Content-Qualität
│   ├── Lead-Generierung
│   └── Trust Signals
└── Stärken/Schwächen
    ├── USPs
    ├── Differenzierung
    └── Gaps
```

### Benchmarking-Metriken

| Metrik | Quelle | Benchmark |
|--------|--------|-----------|
| Domain Authority | Moz/Ahrefs | 30-50 (Mittelstand) |
| Organic Traffic | SimilarWeb | Branchenabhängig |
| Page Speed | Lighthouse | >90 Score |
| Accessibility | Lighthouse | 100 Score (BFSG) |
| Backlinks | Ahrefs | Qualität > Quantität |
| Content Freshness | Manual | Monatlich Updates |

### SWOT-Template

```markdown
## [Wettbewerber] - SWOT

### Stärken (Strengths)
- ...

### Schwächen (Weaknesses)
- ...

### Chancen (Opportunities)
- ...

### Risiken (Threats)
- ...
```

## Markttrends

### Website-Trends 2025

| Trend | Relevanz | Implikation |
|-------|----------|-------------|
| BFSG-Compliance | 🔴 Kritisch | Accessibility first |
| AI-Content | 🟡 Hoch | SEO-Strategie anpassen |
| Core Web Vitals | 🟡 Hoch | Performance-Fokus |
| Headless CMS | 🟢 Mittel | Architektur-Entscheidung |
| Personalisierung | 🟢 Mittel | DXP-Anforderungen |
| Voice Search | 🟢 Niedrig | Schema.org nutzen |
| AR/VR | 🟢 Niedrig | Nischen-Anwendung |

### CMS-Marktanteile (DACH)

| CMS | Marktanteil | Trend |
|-----|-------------|-------|
| WordPress | 45% | → stabil |
| TYPO3 | 15% | ↓ leicht fallend |
| Drupal | 8% | → stabil |
| Shopware | 6% | ↑ steigend |
| Contentful | 4% | ↑ steigend |
| Andere | 22% | - |

*Quelle: W3Techs, BuiltWith 2024*

## Lead-Qualifizierung

### Buying Signals

| Signal | Stärke | Erkennung |
|--------|--------|-----------|
| "Relaunch geplant" | 🔥 Hot | LinkedIn, News |
| Veraltete Technologie | 🟢 Warm | Wappalyzer |
| BFSG-Deadline naht | 🟢 Warm | A11y-Audit |
| Wettbewerber relauncht | 🟡 Neutral | Monitoring |
| Neue Führung | 🟡 Neutral | LinkedIn |
| Funding erhalten | 🟢 Warm | Crunchbase |
| Expansion geplant | 🟢 Warm | News, Bundesanzeiger |

### Pain Points erkennen

| Pain Point | Indikatoren |
|------------|-------------|
| Performance-Probleme | Lighthouse < 50, langsame Seiten |
| Accessibility-Gaps | Lighthouse A11y < 80, kein Alt-Text |
| SEO-Defizite | Wenig organischer Traffic, keine Metas |
| Content-Chaos | Alte Inhalte, inkonsistentes Design |
| Mobile-Probleme | Nicht responsive, Touch-Issues |
| Security-Risiken | Veraltetes CMS, HTTP, Warnungen |

## Reporting

### Executive Summary Template

```markdown
## Markt- und Wettbewerbsanalyse

### Marktposition [Firma]
- Marktanteil: X%
- Ranking: #X in [Branche]
- Differenzierung: [USP]

### Digitale Präsenz
| Metrik | [Firma] | Ø Branche | Best-in-Class |
|--------|---------|-----------|---------------|
| Traffic | X | Y | Z |
| Authority | X | Y | Z |
| Performance | X | Y | Z |

### Top-Wettbewerber
1. [Wettbewerber A] - Stärke: ...
2. [Wettbewerber B] - Stärke: ...
3. [Wettbewerber C] - Stärke: ...

### Chancen
1. [Opportunity 1]
2. [Opportunity 2]

### Empfehlung
...
```

## Automatisierung

### Monitoring-Setup

```javascript
// Wettbewerber-Monitoring
const competitors = [
  { url: 'competitor-a.de', name: 'Competitor A' },
  { url: 'competitor-b.de', name: 'Competitor B' },
]

// Wöchentliche Checks
const checks = [
  'lighthouse-performance',
  'technology-changes',
  'content-updates',
  'backlink-growth',
]
```

### Alert-Triggers

| Trigger | Aktion |
|---------|--------|
| Wettbewerber relauncht | Notification + Re-Audit |
| Technology-Wechsel | Report aktualisieren |
| Traffic-Spike/-Drop | Analyse initiieren |
| Neue Backlinks | Opportunity prüfen |
