---
name: Effort Estimation
description: Aufwandsschätzung und Kalkulationsrichtlinien für Website-Projekte
version: 1.0.0
---

# Effort Estimation

Methodologie und Richtwerte für die Aufwandsschätzung von Website-Projekten.

## Schätzmethodik

### T-Shirt Sizing → PT-Mapping

| Size | Personentage (PT) | Beschreibung |
|------|-------------------|--------------|
| XS | 0.5 - 1 | Triviale Anpassung |
| S | 2 - 3 | Kleine Feature |
| M | 5 - 8 | Mittleres Feature |
| L | 13 - 20 | Komplexes Feature |
| XL | 34 - 55 | Epic |
| XXL | 55+ | Projekt |

### Confidence Levels

| Level | Multiplikator | Wann anwenden |
|-------|--------------|---------------|
| Hoch | 1.0x | Bekannte Technologie, klare Requirements |
| Mittel | 1.3x | Teilweise bekannt, normale Komplexität |
| Niedrig | 1.6x | Neue Technologie, unklare Requirements |
| Sehr niedrig | 2.0x | R&D, Prototyping |

## Starterkit-Baselines

### adesso Drupal Starterkit

Bereits im Starterkit enthalten (0 PT zusätzlich):

| Feature | Status |
|---------|--------|
| Theme-Basis (Tailwind + Alpine.js) | ✅ |
| SDC-Framework | ✅ |
| 40 Standard-Paragraphs | ✅ |
| BFSG-Grundlagen | ✅ |
| Storybook Integration | ✅ |
| CI/CD Pipeline | ✅ |
| DDEV Setup | ✅ |
| Admin Theme | ✅ |

**Starterkit-Bonus:** ~30% Zeitersparnis vs. Greenfield

### Typische Projektaufwände

| Projekttyp | PT-Range | Bemerkung |
|------------|----------|-----------|
| Landing Page | 10 - 25 | Einfach, wenig Seiten |
| Corporate Website S | 40 - 60 | 10-30 Seiten |
| Corporate Website M | 60 - 100 | 30-100 Seiten, Mehrsprachig |
| Corporate Website L | 100 - 150 | 100+ Seiten, Integrationen |
| Portal | 150 - 300 | User-Accounts, komplexe Features |
| E-Commerce | 200 - 400 | Shop-Funktionalität |

## Modul-Aufwände

### Discovery & Konzeption

| Aktivität | PT | Beschreibung |
|-----------|----|--------------|
| Kick-off Workshop | 1 | Anforderungen aufnehmen |
| Requirements Engineering | 3-5 | User Stories, Akzeptanzkriterien |
| Architektur-Konzept | 2-3 | Technische Architektur |
| Content-Strategie | 2-3 | Sitemap, Content Types |
| **Summe Discovery** | **8-12** | |

### UX/UI Design

| Aktivität | PT | Beschreibung |
|-----------|----|--------------|
| Wireframes | 3-5 | Low-Fidelity Layouts |
| Mockups | 5-10 | High-Fidelity Designs |
| Design System | 3-5 | Komponenten-Bibliothek |
| Prototyping | 2-3 | Interaktive Prototypen |
| **Summe Design** | **13-23** | |

### Entwicklung

#### Theme & Frontend

| Komponente | PT | Voraussetzung |
|------------|----|--------------|
| Theme-Setup | 1 | Starterkit vorhanden |
| Custom Paragraphs (je) | 0.5-2 | Komplexität abhängig |
| Navigation | 2-3 | Mega-Menu, Mobile |
| Header/Footer | 1-2 | Layout-Elemente |
| Suchseite | 2-3 | Mit Search API |
| 404/Error Pages | 0.5 | Standard |
| **Typisch Theme** | **15-30** | |

#### Backend & Content

| Komponente | PT | Beschreibung |
|------------|----|--------------|
| Content Types (je) | 1-3 | Fields, Displays |
| Views (je) | 0.5-1 | Listings, Teaser |
| Taxonomies | 0.5-1 | Pro Vokabular |
| Media-Typen | 1-2 | Bilder, Video, Dokumente |
| Workflows | 2-4 | Editorial Workflow |
| Berechtigungen | 1-2 | Rollen-Setup |
| **Typisch Backend** | **10-20** | |

#### Integrationen

| Integration | PT | Komplexität |
|-------------|----|--------------|
| LDAP/SSO | 5-8 | Abhängig von Setup |
| CRM (Hubspot, Salesforce) | 5-10 | API-Integration |
| Analytics (GA4) | 1-2 | GTM Setup |
| Newsletter (Mailchimp) | 2-3 | Double-Opt-In |
| Social Media | 1-2 | Sharing, Feeds |
| DAM-Anbindung | 5-10 | Abhängig vom System |
| PIM-Anbindung | 10-20 | Komplexe Sync |
| E-Commerce | 15-30 | Shop-Anbindung |
| Suche (Solr/Elastic) | 5-8 | Externe Suche |

#### Mehrsprachigkeit

| Sprachen | Zusatz-PT | Bemerkung |
|----------|-----------|-----------|
| 2 Sprachen | +15% | Grundkonfiguration |
| 3-5 Sprachen | +25% | Language Fallback |
| 6+ Sprachen | +40% | Komplexe Workflows |

### Migration

| Content-Menge | PT | Strategie |
|---------------|----|-----------|
| < 50 Seiten | 3-5 | Manuell |
| 50-200 Seiten | 5-10 | Semi-automatisch |
| 200-500 Seiten | 10-20 | Migrate-Skripte |
| 500-1000 Seiten | 20-30 | Migrate + Review |
| 1000+ Seiten | 30-50 | Vollautomatisch |

**Zusätzliche Faktoren:**
- Komplexe Medien: +20%
- Datenbereinigung: +30%
- Multi-Source: +50%

### Testing & QA

| Aktivität | PT | Beschreibung |
|-----------|----|--------------|
| Unit Tests | 3-5 | PHP/JS Tests |
| Functional Testing | 3-5 | End-to-End |
| Accessibility Testing | 2-3 | WCAG 2.1 AA |
| Performance Testing | 1-2 | Lighthouse, Profiling |
| Security Testing | 2-3 | OWASP, Drupal SA |
| UAT Begleitung | 2-3 | User Acceptance |
| **Summe QA** | **13-21** | |

### Deployment & Launch

| Aktivität | PT | Beschreibung |
|-----------|----|--------------|
| Hosting-Setup | 2-3 | Server-Konfiguration |
| CI/CD Pipeline | 2-3 | GitHub Actions/GitLab |
| DNS/SSL | 0.5 | Umstellung |
| Go-Live | 1 | Launch-Begleitung |
| Hypercare | 3-5 | 2 Wochen Support |
| **Summe Launch** | **8.5-12.5** | |

## Gesamtkalkulation

### Beispiel: Mittelgroße Corporate Website

```
Discovery & Konzeption     10 PT
UX/UI Design               18 PT
Theme & Frontend           25 PT
Backend & Content          15 PT
Integrationen               8 PT
Migration                  10 PT
Testing & QA               15 PT
Deployment & Launch        10 PT
─────────────────────────────────
Basis-Aufwand             111 PT

Buffer (15%)              +17 PT
─────────────────────────────────
Gesamt                    128 PT
```

### Aufwand → Kosten

| Tagessatz | PT | Kosten |
|-----------|----|---------|
| 1.200 € | 100 | 120.000 € |
| 1.200 € | 128 | 153.600 € |
| 1.200 € | 150 | 180.000 € |

**Übliche Tagessätze:**
- Junior: 800 - 1.000 €
- Mid-Level: 1.000 - 1.200 €
- Senior: 1.200 - 1.500 €
- Lead/Architect: 1.400 - 1.800 €

## Risiko-Zuschläge

| Risiko | Zuschlag |
|--------|----------|
| Unklare Requirements | +15-25% |
| Komplexe Legacy-Migration | +20-30% |
| Neue/unbekannte Technologie | +20-40% |
| Enge Timeline | +15-25% |
| Verteiltes Team | +10-15% |
| Externe Abhängigkeiten | +10-20% |
| Enterprise-Compliance | +15-25% |

## Team-Kalkulation

### Typische Team-Zusammensetzung

| Projektgröße | Team | Duration |
|--------------|------|----------|
| S (40-60 PT) | 2-3 | 2-3 Monate |
| M (60-100 PT) | 3-4 | 3-4 Monate |
| L (100-150 PT) | 4-5 | 4-6 Monate |
| XL (150+ PT) | 5-7 | 6+ Monate |

### Rollen-Verteilung

| Rolle | Anteil | Aufgaben |
|-------|--------|----------|
| Projektleitung | 10-15% | Koordination, Kunde |
| Technical Lead | 15-20% | Architektur, Reviews |
| Backend Dev | 25-30% | Drupal, PHP |
| Frontend Dev | 20-25% | Theme, JS |
| UX Designer | 10-15% | Design, Konzeption |
| QA | 5-10% | Testing |

## TCO-Berechnung

### 3-Jahres-TCO

```
Jahr 0 (Projekt)
├── Entwicklung: 150.000 €
├── Konzeption: 20.000 €
└── Migration: 15.000 €
    = 185.000 €

Jahr 1
├── Hosting: 6.000 €
├── Wartung: 18.000 €
└── Support: 6.000 €
    = 30.000 €

Jahr 2
├── Hosting: 6.000 €
├── Wartung: 18.000 €
├── Support: 6.000 €
└── Weiterentwicklung: 20.000 €
    = 50.000 €

Jahr 3
├── Hosting: 6.000 €
├── Wartung: 18.000 €
├── Support: 6.000 €
└── Weiterentwicklung: 20.000 €
    = 50.000 €

─────────────────────────────────
3-Jahres-TCO: 315.000 €
```

## Quick Reference

### Schnellschätzung

| Kategorie | Quick-Formel |
|-----------|--------------|
| Simple | Seiten × 0.5 PT |
| Standard | Seiten × 1.0 PT |
| Komplex | Seiten × 2.0 PT |
| + Integrationen | + 5-20 PT je |
| + Multi-Lang | + 15-40% |
| + Migration | + 10-30% |
| + Buffer | + 15% |
