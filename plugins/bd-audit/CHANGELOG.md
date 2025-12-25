# Changelog

Alle wichtigen Änderungen am BD-Audit Plugin werden hier dokumentiert.

## [1.2.0] - 2025-12-25

### Neu: Sofort-Schreiben & Progress-Tracking

**Alle 59 Agenten schreiben jetzt SOFORT ihre MD-Dateien!**

### Hinzugefügt

- **Progress-Tracking System**
  - `_progress.json` - Maschinen-lesbarer Fortschritt
  - `_progress.md` - VitePress Live-Fortschrittsanzeige
  - Jeder Agent updated Progress bei Start/Fortschritt/Ende

- **"Schreibe SOFORT" Instruktion** in allen 59 Agenten
  - Inkrementelles Schreiben statt Batch am Ende
  - Sofortiger Progress-Update

- **Mermaid-Diagramme** für visuelle Reports
  - `navigation-analyzer` - Site-Tree Diagramm
  - `business-segments-analyzer` - Organigramm mit Ansprechpartnern
  - `tech-stack-detector` - Architektur-Diagramm

- **Shared Progress-Tracking Dokumentation**
  - `agents/shared/progress-tracking.md` - Anleitung für alle Agenten

### Geändert

- Orchestrator mit vollständigem Progress-Tracking
- Alle Agent-Outputs jetzt mit YAML Frontmatter für VitePress

---

## [1.1.0] - 2025-12-25

### Architektur-Änderung: Zentralisiertes Crawling

**BREAKING:** Alle Agents nutzen jetzt `_crawl_data.json` als zentrale Datenquelle.

### Geändert

- **Phase 0 Deep Crawl** läuft jetzt ZUERST und speichert alle Daten in `_crawl_data.json`
- Alle Inventory-Agents lesen aus `_crawl_data.json` statt eigene Crawls zu machen
- Alle Discovery-Agents (außer externe Recherche) lesen aus `_crawl_data.json`

### Aktualisierte Agents

| Agent | Änderung |
|-------|----------|
| `discovery-basic` | Nutzt `_crawl_data.json` für Screenshots, Meta, Navigation |
| `tech-stack-detector` | Primär aus Crawl-Daten, Wappalyzer nur zur Validierung |
| `business-segments-analyzer` | Liest Geschäftsbereiche + Kontakte aus Crawl-Daten |
| `contact-finder` | Extrahiert Kontakte aus `_crawl_data.json` |
| `page-type-analyzer` | Klassifiziert Seiten aus Crawl-Daten |
| `form-inventory` | Aggregiert Formulare aus Crawl-Daten |
| `media-inventory` | Aggregiert Bilder/Videos/Downloads aus Crawl-Daten |
| `navigation-analyzer` | Liest Navigation-Struktur aus Crawl-Daten |
| `integration-detector` | Erkennt Third-Party-Services aus Scripts/Iframes |
| `multilang-detector` | Analysiert Sprachverteilung aus Crawl-Daten |
| `ecommerce-analyzer` | Erkennt E-Commerce-Signale aus Crawl-Daten |

### Beibehaltene externe Tools

Diese Agents behalten ihre externen Tools, da sie Daten außerhalb der Website analysieren:

- `company-profiler` - WebSearch für Unternehmensrecherche
- `corporate-structure` - WebSearch für Konzernstruktur
- `social-media-scanner` - WebFetch für Social Media
- `news-scanner` - WebSearch für Nachrichten
- `performance-auditor` - Lighthouse MCP für Live-Messungen
- `accessibility-auditor` - Live-Accessibility-Tests

### Vorteile

1. **Schneller:** Nur ein Deep-Crawl statt viele einzelne
2. **Konsistenter:** Alle Agents arbeiten mit identischen Daten
3. **Genauer:** EXAKTE Zahlen statt Schätzungen
4. **Vollständiger:** ALLE Seiten werden besucht, nicht nur Samples

## [1.0.0] - 2025-12-24

### Hinzugefügt

- Initiales Release
- 50 spezialisierte Audit-Agenten
- 8-Phasen-Workflow
- VitePress Report-Generierung
- Netlify Deploy-Integration
- Lead-Score-Berechnung
- `/bd` Hauptkommando
