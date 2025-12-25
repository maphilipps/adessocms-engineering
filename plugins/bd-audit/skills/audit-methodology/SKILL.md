---
name: Audit Methodology
description: Methodologie und Best Practices für Website-Audits bei adesso SE
version: 1.0.0
---

# Audit Methodology

Systematische Vorgehensweise für umfassende Website-Audits im BD-Kontext.

## Audit-Framework

### Phasen-Modell

```
┌─────────────────────────────────────────────────────────────────┐
│                     BD-AUDIT FRAMEWORK                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Phase 1: DISCOVERY                                              │
│  ├── Lead-Qualifizierung (Score 0-100)                          │
│  ├── Unternehmensrecherche                                       │
│  ├── Marktanalyse                                                │
│  ├── Wettbewerbsanalyse                                          │
│  └── Kontaktidentifikation                                       │
│                                                                  │
│  Phase 2: INVENTORY                                              │
│  ├── Tech Stack Detection                                        │
│  ├── Content Inventory                                           │
│  ├── Feature Mapping                                             │
│  └── Integration Analysis                                        │
│                                                                  │
│  Phase 3: TECHNICAL AUDIT                                        │
│  ├── Performance (Lighthouse, Web Vitals)                        │
│  ├── SEO (On-Page, Technical)                                    │
│  ├── Security Assessment                                         │
│  └── Code Quality                                                │
│                                                                  │
│  Phase 4: LEGAL & COMPLIANCE                                     │
│  ├── BFSG/Accessibility (WCAG 2.1 AA)                           │
│  ├── DSGVO/Privacy                                               │
│  └── Impressum/Legal                                             │
│                                                                  │
│  Phase 5: MARKETING                                              │
│  ├── Brand Consistency                                           │
│  ├── Content Quality                                             │
│  ├── Trust Signals                                               │
│  └── Conversion Analysis                                         │
│                                                                  │
│  Phase 6: UX                                                     │
│  ├── User Experience Audit                                       │
│  ├── Navigation Analysis                                         │
│  ├── Mobile Experience                                           │
│  └── Form Usability                                              │
│                                                                  │
│  Phase 7: EVALUATION                                             │
│  ├── CMS-Empfehlung                                              │
│  ├── Aufwandsschätzung                                           │
│  ├── TCO-Berechnung                                              │
│  └── Team-Vorschlag                                              │
│                                                                  │
│  Phase 8: SYNTHESIS                                              │
│  ├── Report Generation                                           │
│  ├── Executive Summary                                           │
│  ├── Präsentation                                                │
│  └── Handlungsempfehlungen                                       │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## Lead-Qualifizierung

### Score-Berechnung (0-100)

```
Lead Score = Σ (Faktor × Gewicht) / Σ Gewichte × 100

Faktoren:
├── Relaunch-Dringlichkeit (0-10) × 3
├── Budget-Passung (0-10) × 3
├── Entscheider-Zugang (0-10) × 2
├── Technologie-Veralterung (0-10) × 2
├── BFSG-Dringlichkeit (0-10) × 2
├── Unternehmensgröße-Match (0-10) × 1
└── Referenzpotenzial (0-10) × 1
```

### Score-Interpretation

| Score | Klassifikation | Handlung |
|-------|----------------|----------|
| 80-100 | 🔥 Hot Lead | Sofort kontaktieren |
| 60-79 | 🟢 Warm Lead | Aktiv verfolgen |
| 40-59 | 🟡 Neutral | Nurturing |
| 20-39 | 🟠 Cold Lead | Niedrige Priorität |
| 0-19 | ❌ Unqualifiziert | Nicht verfolgen |

## Datenerhebung

### Automatisierte Quellen

| Quelle | Daten | Tool |
|--------|-------|------|
| Wappalyzer | Tech Stack | MCP Server |
| Lighthouse | Performance, A11y, SEO | Playwright |
| BuiltWith | Technologien, Historie | WebFetch |
| SimilarWeb | Traffic, Keywords | WebFetch |
| LinkedIn | Kontakte, Unternehmen | WebFetch |
| Bundesanzeiger | Finanzdaten | WebFetch |
| DENIC | Domain-Info | WebFetch |

### Manuelle Erhebung

| Aspekt | Methode |
|--------|---------|
| Brand-Analyse | Screenshot-Review |
| Content-Qualität | Stichproben-Analyse |
| UX-Bewertung | Walkthrough |
| Wettbewerber | Desk Research |

## Bewertungssysteme

### Performance-Scoring

| Metrik | Gut | Mittel | Schlecht |
|--------|-----|--------|----------|
| LCP | < 2.5s | 2.5-4s | > 4s |
| FID | < 100ms | 100-300ms | > 300ms |
| CLS | < 0.1 | 0.1-0.25 | > 0.25 |
| Performance Score | > 90 | 50-90 | < 50 |

### Accessibility-Scoring

| Level | Kriterien | Status |
|-------|-----------|--------|
| WCAG A | Grundlegend | Minimum |
| WCAG AA | Standard | **BFSG-Ziel** |
| WCAG AAA | Erweitert | Optional |

### SEO-Scoring

| Aspekt | Gewicht | Prüfpunkte |
|--------|---------|------------|
| Technical SEO | 30% | Crawlability, Indexing, Speed |
| On-Page SEO | 40% | Titles, Metas, Headings, Content |
| Off-Page SEO | 30% | Backlinks, Authority, Social |

## Dokumentation

### Knowledge Store Struktur

```
storage/app/leads/<leadId>/
├── discovery/
│   ├── company.json         # Unternehmensdaten
│   ├── market.json          # Marktanalyse
│   ├── competitors.json     # Wettbewerber
│   └── contacts.json        # Ansprechpartner
├── inventory/
│   ├── tech_stack.json      # Technologien
│   ├── content.json         # Content Inventory
│   ├── features.json        # Feature Map
│   └── integrations.json    # Integrationen
├── technical/
│   ├── performance.json     # Lighthouse Results
│   ├── seo.json             # SEO Audit
│   ├── security.json        # Security Check
│   └── quality.json         # Code Quality
├── legal/
│   ├── accessibility.json   # BFSG/WCAG
│   ├── privacy.json         # DSGVO
│   └── impressum.json       # Legal Check
├── marketing/
│   ├── brand.json           # Brand Analysis
│   ├── content.json         # Content Quality
│   ├── trust.json           # Trust Signals
│   └── conversion.json      # Conversion
├── ux/
│   ├── usability.json       # UX Audit
│   ├── navigation.json      # Navigation
│   ├── mobile.json          # Mobile UX
│   └── forms.json           # Form UX
├── evaluation/
│   ├── cms.json             # CMS Empfehlung
│   ├── effort.json          # Aufwand
│   ├── tco.json             # TCO
│   └── team.json            # Team
└── synthesis/
    ├── report.md            # Hauptreport
    ├── executive.md         # Summary
    ├── recommendations.md   # Empfehlungen
    └── roadmap.md           # Timeline
```

### JSON-Schema für Ergebnisse

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["agent", "timestamp", "version", "data"],
  "properties": {
    "agent": { "type": "string" },
    "timestamp": { "type": "string", "format": "date-time" },
    "version": { "type": "string" },
    "data": { "type": "object" },
    "metadata": {
      "type": "object",
      "properties": {
        "duration_ms": { "type": "integer" },
        "sources": { "type": "array" },
        "confidence": { "type": "number", "minimum": 0, "maximum": 1 }
      }
    }
  }
}
```

## Best Practices

### Datenqualität

1. **Mehrfache Quellen** - Jede Aussage mit mindestens 2 Quellen belegen
2. **Aktualität** - Nur Daten < 7 Tage alt verwenden
3. **Vollständigkeit** - Alle Pflichtfelder ausfüllen
4. **Objektivität** - Fakten von Meinungen trennen

### Präsentation

1. **Executive-First** - Zusammenfassung zuerst
2. **Visualisierung** - Zahlen in Grafiken
3. **Priorisierung** - Kritisches zuerst
4. **Call-to-Action** - Klare nächste Schritte

### Timing

| Phase | Typische Dauer |
|-------|----------------|
| Quick-Qualification | 15 Min |
| Standard-Audit | 2-4 Stunden |
| Deep-Dive | 1-2 Tage |
| Enterprise-Audit | 1 Woche |

## Qualitätssicherung

### Checkliste vor Abgabe

- [ ] Alle Pflicht-Agents ausgeführt
- [ ] Keine kritischen Datenlücken
- [ ] Scores plausibel
- [ ] Empfehlungen konsistent
- [ ] Rechtschreibung geprüft
- [ ] Formatierung einheitlich
- [ ] Links funktionsfähig
- [ ] Bilder eingebettet
- [ ] PDF generiert
- [ ] VitePress deployed

### Review-Prozess

1. **Automatische Validierung** - Schema-Check
2. **Peer Review** - Zweite Meinung
3. **BD-Freigabe** - Finale Prüfung
