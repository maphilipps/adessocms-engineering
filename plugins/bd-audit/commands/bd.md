---
name: bd
description: "Vollständiger Website-Audit mit einem Befehl. Analysiert Website, Technik, Marketing, Legal und generiert VitePress Report."
argument-hint: "<url> [--quick|--tech|--marketing|--legal] [--no-deploy]"
allowed-tools: ["Task", "Read", "Write", "Bash", "WebFetch", "WebSearch", "Glob", "Grep", "TodoWrite", "mcp__playwright__*", "mcp__wappalyzer__*", "mcp__lighthouse__*"]
---

Du führst einen vollständigen Website-Audit durch. Der Benutzer ist ein Business Developer ohne technisches Wissen - halte alles einfach!

## Dein Auftrag

Führe einen umfassenden Audit der angegebenen Website durch und erstelle einen professionellen Report.

## Argumente parsen

**URL:** Erstes Argument (erforderlich)
**Optionen:**
- `--quick` → Nur Quick-Check (Discovery + Tech Stack)
- `--tech` → Nur technischer Audit
- `--marketing` → Nur Marketing-Audit
- `--legal` → Nur Legal/Compliance-Check
- `--no-deploy` → Kein Git Push / Netlify Deploy

**Wenn keine Option:** Vollständiger Audit (alle 8 Phasen)

## Workflow

### 1. Output-Verzeichnis bestimmen

```bash
# Einfache Struktur: firmenname/
OUTPUT_DIR="./${COMPANY_SLUG}/"
```

Reports werden direkt im Firmen-Ordner gespeichert und können iterativ verbessert werden.

### 2. Extrahiere Firmenname aus URL

- `locarno-film-festival.ch` → `locarno-film-festival`
- `www.mercedes-benz.de` → `mercedes-benz`

### 3. Starte Audit mit Task Tool

**WICHTIG: Nutze das Task Tool um Agenten PARALLEL zu spawnen!**

#### Quick-Check (5-10 Min)
```
Task(subagent_type="bd-audit:discovery-basic", prompt="...")
Task(subagent_type="bd-audit:tech-stack-detector", prompt="...")
```

#### Vollständiger Audit (60-90 Min)
Starte phasenweise:

**Phase 1: Discovery (parallel)**
- discovery-basic
- tech-stack-detector
- sitemap-crawler
- company-profiler
- corporate-structure
- contact-finder
- social-media-scanner
- news-scanner

**Phase 2: Inventory (parallel)**
- page-inventory
- component-detector
- corporate-design
- content-census
- forms-analyzer
- media-library
- navigation-analyzer
- footer-header-scanner

**Phase 3: Technical (parallel)**
- performance-auditor
- accessibility-auditor
- seo-auditor
- security-scanner
- integrations-detector
- technical-debt
- mobile-auditor
- pwa-auditor

**Phase 4: Legal (parallel)**
- gdpr-auditor
- cookie-auditor
- impressum-checker
- bfsg-auditor
- license-checker
- terms-analyzer

**Phase 5: Marketing (parallel)**
- market-researcher
- audience-personas
- conversion-analyzer
- brand-auditor
- competitor-analyst
- content-strategist
- trust-auditor
- email-newsletter-scanner

**Phase 6: UX (parallel)**
- ux-auditor
- design-trend-analyzer
- micro-interaction-scanner
- form-ux-auditor
- search-ux-auditor
- error-page-auditor

**Phase 7: Evaluation (parallel)**
- drupal-specialist
- typo3-specialist
- ibexa-specialist
- sulu-specialist
- storyblok-specialist
- shopware-specialist

**Phase 8: Synthesis (sequentiell, braucht alle vorherigen)**
- portfolio-matcher
- effort-estimator
- tco-calculator
- risk-assessor
- report-generator
- executive-summarizer

### 4. Generiere VitePress Report

Nach allen Agenten:
1. Sammle alle Markdown-Outputs
2. Erstelle VitePress Struktur
3. Generiere Navigation

### 5. Git Commit & Deploy (wenn nicht --no-deploy)

```bash
git add ${COMPANY_SLUG}/
git commit -m "Audit: ${COMPANY} - Score ${SCORE}/100 - ${DATE}"
git push origin main
```

### 6. Output für Business Developer

```
✅ Audit abgeschlossen: [Firmenname]

📊 Report: https://audits.adessocms.de/firmenname/
📁 Lokal:  ./firmenname/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ZUSAMMENFASSUNG

Lead Score:     78/100 (🟢 Hot Lead)
CMS:            Drupal 9 → Migration zu Drupal 11 empfohlen
Aufwand:        180 PT
Budget:         €216.000

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TOP 3 ERKENNTNISSE

1. 🔴 Performance: Lighthouse Score 42 - dringend optimieren
2. 🟡 BFSG: Nicht compliant - Deadline 28.06.2025
3. 🟢 Brand: Starkes Corporate Design vorhanden

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NÄCHSTE SCHRITTE

1. Präsentation erstellen:  /bd-ppt firmenname
2. Ansprechpartner:         Max Mustermann (CEO)
3. Report teilen:           https://audits.adessocms.de/...
```

## Wichtige Regeln

1. **Einfache Sprache** - Der BD ist kein Techniker!
2. **Immer Score** - Lead Score (0-100) ist die wichtigste Metrik
3. **Handlungsempfehlung** - Was soll der BD als nächstes tun?
4. **Visualisierung** - Nutze Emojis für schnelles Scannen
5. **Links** - Immer den Report-Link ausgeben
