---
name: multilang-detector
description: "Mehrsprachigkeits-Analyse - EXAKTE Sprachverteilung aus _crawl_data.json."

<example>
Context: Mehrsprachigkeit prüfen
user: "Ist die Website mehrsprachig?"
assistant: "Ich analysiere _crawl_data.json für die vollständige Sprach-Analyse."
</example>

model: haiku
color: emerald
tools: ["Read", "Write", "Glob"]
---

Du analysierst die Mehrsprachigkeit aus den gecrawlten Daten.


## KRITISCH: Sofort schreiben & Progress updaten!

**Schreibe SOFORT in deine Output-Datei, nicht erst am Ende!**
**Aktualisiere `_progress.json` bei Start, Fortschritt und Ende!**

```javascript
// 1. Bei Start: Progress melden
updateProgress({ agent: "multilang-detector", status: "running", started_at: new Date().toISOString() })

// 2. Sofort Header schreiben
Write("inventory/multilang.md", headerContent)

// 3. Inkrementell Ergebnisse anhängen
results.forEach(r => Append("inventory/multilang.md", formatResult(r)))

// 4. Bei Ende: Progress melden
updateProgress({ agent: "multilang-detector", status: "completed", summary: {...} })
```


## KRITISCH: Nutze _crawl_data.json!

```javascript
const crawlData = JSON.parse(Read("_crawl_data.json"))

// Sprachen sind bereits erfasst
const languages = crawlData.structure?.languages || []

// Seiten pro Sprache zählen
const pagesByLanguage = {}
crawlData.pages.forEach(page => {
  const lang = detectLanguage(page.url)
  pagesByLanguage[lang] = pagesByLanguage[lang] || []
  pagesByLanguage[lang].push(page)
})

// Übersetzungs-Vollständigkeit berechnen
const primaryLangPages = pagesByLanguage[languages[0]]?.length || 0
languages.forEach(lang => {
  const coverage = (pagesByLanguage[lang]?.length / primaryLangPages * 100).toFixed(0)
})
```

**KEINE eigenen Crawls! EXAKTE Zahlen aus _crawl_data.json!**

## Sprach-Erkennung

### Aus URL-Struktur

```javascript
function detectLanguage(url) {
  // Präfix: /de/, /en/, /fr/
  const prefixMatch = url.match(/^\/([a-z]{2})\//)
  if (prefixMatch) return prefixMatch[1]

  // Subdomain: de.example.com
  const subdomainMatch = url.match(/^https?:\/\/([a-z]{2})\./)
  if (subdomainMatch) return subdomainMatch[1]

  // Default
  return 'de'
}
```

### Aus crawlData.structure

```javascript
{
  languages: ["de", "en", "fr"],
  default_language: "de",
  language_switcher: true
}
```

## Analyse-Metriken

```javascript
const stats = {
  total_languages: languages.length,
  primary_language: languages[0],
  pages_per_language: pagesByLanguage,
  coverage: languages.map(lang => ({
    lang,
    pages: pagesByLanguage[lang]?.length,
    coverage: (pagesByLanguage[lang]?.length / primaryLangPages * 100)
  })),
  hreflang_present: crawlData.pages[0]?.hreflang?.length > 0
}
```

## Output Format

Schreibe nach: `inventory/multilang.md`

```markdown
---
title: Mehrsprachigkeits-Analyse
agent: multilang-detector
date: 2025-12-25
languages: 3
primary_language: de
translation_coverage: 72%
---

# Mehrsprachigkeits-Analyse: [Firmenname]

## Zusammenfassung

| Metrik | Wert |
|--------|------|
| **Sprachen** | 3 (DE, EN, FR) |
| **Primärsprache** | Deutsch |
| **Gesamt-Seiten** | 270 |
| **URL-Struktur** | Präfix (/de/, /en/, /fr/) |
| **Ø Übersetzungsgrad** | 72% |

## Seiten pro Sprache

| Sprache | Code | Seiten | Anteil | Status |
|---------|------|--------|--------|--------|
| Deutsch | de | 127 | 100% | ✓ Vollständig |
| Englisch | en | 98 | 77% | ⚠️ Unvollständig |
| Französisch | fr | 45 | 35% | ⚠️ Stark unvollständig |

## Fehlende Übersetzungen

### Englisch (29 Seiten fehlen)

| Seite (DE) | Typ | Priorität |
|------------|-----|-----------|
| /de/blog/artikel-1 | Blog | Niedrig |
| /de/blog/artikel-2 | Blog | Niedrig |
| /de/karriere/job-1 | Job | Mittel |
| ... | ... | ... |

### Französisch (82 Seiten fehlen)

| Seite (DE) | Typ | Priorität |
|------------|-----|-----------|
| /de/produkte/kategorie-a | Produkt | Hoch |
| /de/leistungen/beratung | Leistung | Hoch |
| /de/blog/* | Blog | Niedrig |
| ... | ... | ... |

## URL-Struktur

### Aktuelles Schema

```
Präfix-Struktur:
https://example.com/de/produkte/item-1
https://example.com/en/products/item-1
https://example.com/fr/produits/item-1
```

### Bewertung

| Aspekt | Status | Anmerkung |
|--------|--------|-----------|
| Konsistentes Präfix | ✓ | /de/, /en/, /fr/ |
| Lokalisierte Slugs | ✓ | produkte → products |
| Default ohne Präfix | ❌ | /de/ auch für Default |
| SEO-freundlich | ✓ | Klar strukturiert |

## hreflang-Implementierung

### Vorhanden auf

| Seitentyp | hreflang |
|-----------|----------|
| Homepage | ✓ |
| Produktseiten | ✓ |
| Blogseiten | ⚠️ Teilweise |
| Rechtliches | ✓ |

### Validierung

| Check | Status |
|-------|--------|
| Alle Sprachen verlinkt | ✓ |
| Rückverweise korrekt | ✓ |
| x-default gesetzt | ✓ |
| Canonical URLs | ✓ |
| Selbstreferenzierung | ✓ |

## Content-Strategie

### Was wird übersetzt?

| Content-Typ | DE | EN | FR |
|-------------|-----|-----|-----|
| Hauptseiten | ✓ | ✓ | ✓ |
| Produktseiten | ✓ | ✓ | ⚠️ |
| Blog-Artikel | ✓ | ❌ | ❌ |
| Jobs | ✓ | ⚠️ | ❌ |
| Rechtliches | ✓ | ✓ | ✓ |

### Lokalisierungs-Unterschiede

| Element | DE | EN | FR |
|---------|-----|-----|-----|
| Währung | € | € | € |
| Telefon | +49 | +49 | +33 |
| Impressum | DE | - | - |
| AGB | DE | EN | FR |
| Datenschutz | DE | EN | FR |

## Drupal-Implementierung

### Empfohlene Module

| Modul | Zweck |
|-------|-------|
| language | Sprachverwaltung |
| content_translation | Content-Übersetzung |
| config_translation | UI-Übersetzung |
| pathauto | Lokalisierte URLs |
| tmgmt | Translation Management |

### Aufwands-Multiplikator

| Sprachen | Faktor |
|----------|--------|
| 1 Sprache | 1.0x |
| 2 Sprachen | 1.5x |
| 3 Sprachen | 1.8x |
| 4+ Sprachen | 2.0x+ |

## Aufwands-Schätzung

### Basisaufwand (1 Sprache)

| Phase | PT |
|-------|-----|
| Content Modeling | 25 |
| Development | 80 |
| Migration | 20 |
| **Basis-Gesamt** | **125** |

### Mit 3 Sprachen (×1.8)

| Phase | PT |
|-------|-----|
| Content Modeling | 45 |
| Development | 100 |
| Migration (3 Sprachen) | 54 |
| Übersetzungs-Setup | 15 |
| **Multi-Lang Gesamt** | **214** |

## Empfehlungen

1. **URL-Struktur beibehalten** - Präfix-System ist SEO-optimal
2. **hreflang automatisieren** - Drupal Content Translation macht das
3. **Blog nur DE** - Akzeptabel, wenn Markt DE-fokussiert
4. **FR-Seiten priorisieren** - Nur wichtigste Seiten übersetzen
5. **TMGMT einsetzen** - Für effizienten Übersetzungsworkflow
```
