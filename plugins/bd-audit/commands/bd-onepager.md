---
name: bd-onepager
description: "Erstellt Executive Summary als 1-Seiter (PDF)"
argument-hint: "<firmenname>"
allowed-tools: ["Read", "Glob", "Skill"]
---

Erstelle einen professionellen 1-Seiter (Executive Summary) aus dem Audit-Report.

## Workflow

1. Finde den Report für den angegebenen Firmennamen

2. Extrahiere die wichtigsten Informationen:
   - Lead Score
   - Top 3 Findings
   - CMS-Empfehlung
   - Budget-Range
   - Nächste Schritte

3. Nutze das `document-skills:pdf` Skill um das PDF zu erstellen

## Layout (A4, 1 Seite)

```
┌─────────────────────────────────────────────────────────┐
│  [adesso Logo]                           [Datum]        │
│                                                         │
│  WEBSITE-AUDIT                                          │
│  ═══════════════════════════════════════════════════    │
│  [Firmenname]                                           │
│                                                         │
│  ┌─────────────┐                                        │
│  │   SCORE     │  🟢 Hot Lead - Aktiv verfolgen         │
│  │     78      │                                        │
│  └─────────────┘                                        │
│                                                         │
│  TOP FINDINGS                                           │
│  ───────────────────────────────────────────────────    │
│  1. 🔴 Performance kritisch (Lighthouse 42)             │
│  2. 🟡 BFSG-Compliance fehlt (Deadline 28.06.2025)     │
│  3. 🟢 Starkes Brand vorhanden                          │
│                                                         │
│  CMS-EMPFEHLUNG                                         │
│  ───────────────────────────────────────────────────    │
│  Drupal 11 - Flexibel, Open Source, Enterprise-ready   │
│                                                         │
│  INVESTITION                                            │
│  ───────────────────────────────────────────────────    │
│  Aufwand:  180 Personentage                             │
│  Budget:   €180.000 - €250.000                          │
│  Timeline: 6-8 Monate                                   │
│                                                         │
│  NÄCHSTE SCHRITTE                                       │
│  ───────────────────────────────────────────────────    │
│  □ Workshop Termin vereinbaren                          │
│  □ Anforderungen detaillieren                           │
│  □ Angebot erstellen                                    │
│                                                         │
│  ───────────────────────────────────────────────────    │
│  Ihr Ansprechpartner:                                   │
│  [Name] | drupal@adesso.de | +49 xxx xxx xxx           │
└─────────────────────────────────────────────────────────┘
```

## Output

Speichere als:
```
reports/[jahr]/[monat]/[firmenname]/onepager.pdf
```
