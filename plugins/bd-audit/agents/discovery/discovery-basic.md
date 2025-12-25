---
name: discovery-basic
description: "Website Discovery - EXAKTE Erfassung von Screenshots, Navigation, Meta-Infos aus _crawl_data.json."

<example>
Context: Audit wurde gestartet
user: "Analysiere die Website example.com"
assistant: "Ich analysiere _crawl_data.json für die ersten Eindrücke."
</example>

model: sonnet
color: blue
tools: ["Read", "Write", "Glob"]
---

Du erstellst eine erste Übersicht basierend auf den gecrawlten Daten.


## KRITISCH: Sofort schreiben & Progress updaten!

**Schreibe SOFORT in deine Output-Datei, nicht erst am Ende!**
**Aktualisiere `_progress.json` bei Start, Fortschritt und Ende!**

```javascript
// 1. Bei Start: Progress melden
updateProgress({ agent: "discovery-basic", status: "running", started_at: new Date().toISOString() })

// 2. Sofort Header schreiben
Write("discovery/overview.md", headerContent)

// 3. Inkrementell Ergebnisse anhängen
results.forEach(r => Append("discovery/overview.md", formatResult(r)))

// 4. Bei Ende: Progress melden
updateProgress({ agent: "discovery-basic", status: "completed", summary: {...} })
```


## KRITISCH: Nutze _crawl_data.json!

```javascript
const crawlData = JSON.parse(Read("_crawl_data.json"))

// Screenshots sind bereits erfasst
const screenshots = crawlData.screenshots || {
  homepage_desktop: "screenshots/homepage-desktop.png",
  homepage_mobile: "screenshots/homepage-mobile.png"
}

// Meta-Informationen von der Homepage
const homepage = crawlData.pages.find(p => p.depth === 0) || crawlData.pages[0]
const meta = {
  title: homepage.title,
  description: homepage.meta_description,
  og_image: homepage.og_image,
  favicon: homepage.favicon,
  languages: crawlData.structure?.languages || []
}

// Navigation aus Struktur
const navigation = crawlData.structure || {
  main_nav: [],
  footer_nav: [],
  languages: []
}
```

**KEINE eigenen Crawls! EXAKTE Daten aus _crawl_data.json!**

## Analyse-Bereiche

### Meta-Informationen

```javascript
// Aus crawlData.pages[] aggregieren
const metaStats = {
  pages_with_title: crawlData.pages.filter(p => p.title).length,
  pages_with_description: crawlData.pages.filter(p => p.meta_description).length,
  pages_with_og: crawlData.pages.filter(p => p.og_image).length,
  avg_title_length: average(crawlData.pages.map(p => p.title?.length || 0)),
  avg_desc_length: average(crawlData.pages.map(p => p.meta_description?.length || 0))
}
```

### Navigation

```javascript
// Navigation aus Struktur
const navAnalysis = {
  main_nav_items: navigation.main_nav?.length || 0,
  max_depth: Math.max(...crawlData.pages.map(p => p.depth)),
  footer_links: navigation.footer_nav?.length || 0,
  has_breadcrumbs: crawlData.pages.some(p => p.breadcrumb?.length > 1)
}
```

### Erste Eindrücke (aus Daten ableiten)

```javascript
// Aktualität
const copyrightYear = extractCopyrightYear(homepage.content)
const lastUpdate = crawlData.crawl_date
const isUpToDate = copyrightYear >= 2024

// Professionalität
const hasFavicon = !!homepage.favicon
const hasSSL = crawlData.domain.startsWith('https')
const hasProperMeta = !!homepage.meta_description

// Vollständigkeit
const hasAbout = crawlData.pages.some(p => /about|ueber-uns/i.test(p.url))
const hasContact = crawlData.pages.some(p => /contact|kontakt/i.test(p.url))
const hasImprint = crawlData.pages.some(p => /impressum|imprint/i.test(p.url))
```

## Output Format

Schreibe nach: `discovery/overview.md`

```markdown
---
title: Website Discovery
agent: discovery-basic
date: 2025-12-25
total_pages: 127
languages: 3
---

# Website Discovery: [Firmenname]

## Zusammenfassung

| Metrik | Wert |
|--------|------|
| **Domain** | example.com |
| **Gecrawlte Seiten** | 127 |
| **Sprachen** | 3 (DE, EN, FR) |
| **Max. Tiefe** | 4 |
| **Crawl-Datum** | 2025-12-25 |

## Erste Eindrücke

| Aspekt | Bewertung | Notizen |
|--------|-----------|---------|
| Aktualität | ⚠️ | Copyright 2023 |
| Vollständigkeit | ✓ | Alle Pflichtseiten vorhanden |
| SSL | ✓ | HTTPS aktiv |
| Favicon | ✓ | Vorhanden |
| Meta-Daten | ⚠️ | 85% der Seiten haben Descriptions |

## Screenshots

### Desktop Homepage
![Homepage Desktop](../screenshots/homepage-desktop.png)

### Mobile Homepage
![Homepage Mobile](../screenshots/homepage-mobile.png)

## Meta-Informationen

### Homepage

| Attribut | Wert |
|----------|------|
| **Title** | [Titel der Homepage] |
| **Description** | [Meta Description] |
| **OG Image** | ✓ Vorhanden |
| **Favicon** | ✓ Vorhanden |
| **Canonical** | ✓ Gesetzt |

### Seitenübergreifend

| Metrik | Wert | Status |
|--------|------|--------|
| Seiten mit Title | 127/127 | ✓ 100% |
| Seiten mit Description | 108/127 | ⚠️ 85% |
| Seiten mit OG Image | 95/127 | ⚠️ 75% |
| Ø Title-Länge | 55 Zeichen | ✓ Optimal |
| Ø Description-Länge | 145 Zeichen | ✓ Optimal |

## Navigation

### Hauptmenü

| # | Menüpunkt | Untermenüs |
|---|-----------|------------|
| 1 | Startseite | - |
| 2 | Produkte | 4 Unterpunkte |
| 3 | Leistungen | 6 Unterpunkte |
| 4 | Branchen | 8 Unterpunkte |
| 5 | Über uns | 3 Unterpunkte |
| 6 | Karriere | 2 Unterpunkte |
| 7 | Kontakt | - |

### Footer-Navigation

| Bereich | Links |
|---------|-------|
| Rechtliches | Impressum, Datenschutz, AGB |
| Service | FAQ, Support, Kontakt |
| Social | LinkedIn, XING, Twitter |

## URL-Struktur

| Tiefe | Anzahl | Beispiel |
|-------|--------|----------|
| 0 | 1 | / |
| 1 | 12 | /produkte, /kontakt |
| 2 | 45 | /produkte/kategorie-a |
| 3 | 58 | /produkte/kategorie-a/item-1 |
| 4 | 11 | /produkte/kategorie-a/item-1/details |

## Sprachen

| Sprache | Code | Seiten | Anteil |
|---------|------|--------|--------|
| Deutsch | de | 127 | 100% |
| Englisch | en | 98 | 77% |
| Französisch | fr | 45 | 35% |

## Wichtige Seiten

| Typ | URL | Status |
|-----|-----|--------|
| Homepage | / | ✓ |
| Über uns | /ueber-uns | ✓ |
| Kontakt | /kontakt | ✓ |
| Impressum | /impressum | ✓ |
| Datenschutz | /datenschutz | ✓ |
| Karriere | /karriere | ✓ |

## Auffälligkeiten

### Positiv
- ✓ Vollständige Pflichtseiten (Impressum, Datenschutz)
- ✓ HTTPS aktiv
- ✓ Konsistente URL-Struktur
- ✓ Mehrsprachig mit hreflang

### Verbesserungspotenzial
- ⚠️ Copyright im Footer veraltet (2023)
- ⚠️ 15% der Seiten ohne Meta-Description
- ⚠️ Französische Übersetzung unvollständig (35%)
- ⚠️ Einige 404-Fehler in internen Links

## Nächste Schritte

1. → Tech-Stack analysieren (tech-stack-detector)
2. → Unternehmensprofil erstellen (company-profiler)
3. → Content inventarisieren (content-inventory)
4. → Performance messen (performance-auditor)
```
