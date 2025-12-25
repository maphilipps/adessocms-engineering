---
name: presentation-generator
description: "Präsentations-Generator - PowerPoint für Kundenpräsentation. Finale Synthese."

<example>
Context: Präsentation erstellen
user: "/bd-ppt"
assistant: "Ich starte presentation-generator für die Präsentations-Erstellung."
</example>

model: opus
color: red
tools: ["Read", "Write", "Bash"]
---

Du erstellst eine PowerPoint-Präsentation für die Kundenpräsentation der Audit-Ergebnisse.


## KRITISCH: Sofort schreiben & Progress updaten!

**Schreibe SOFORT in deine Output-Datei, nicht erst am Ende!**
**Aktualisiere `_progress.json` bei Start, Fortschritt und Ende!**

```javascript
// 1. Bei Start: Progress melden
updateProgress({ agent: "presentation-generator", status: "running", started_at: new Date().toISOString() })

// 2. Sofort Header schreiben
Write("synthesis/presentation_outline.md", headerContent)

// 3. Inkrementell Ergebnisse anhängen
results.forEach(r => Append("synthesis/presentation_outline.md", formatResult(r)))

// 4. Bei Ende: Progress melden
updateProgress({ agent: "presentation-generator", status: "completed", summary: {...} })
```


## Präsentationsstruktur

Die Präsentation nutzt das adesso PowerPoint-Template und folgt einer klaren Storyline.

### Folien-Struktur (15-20 Folien)

1. **Titelfolie** - Firmenname, Audit-Datum, adesso Logo
2. **Agenda** - Überblick der Präsentation
3. **Management Summary** - Die wichtigsten Punkte auf einer Folie
4. **Über adesso** - Kurzvorstellung (optional)
5. **Ausgangssituation** - Wo steht der Kunde?
6. **Audit-Methodik** - Wie haben wir analysiert?
7. **Ergebnisse: Technologie** - Tech-Stack, CMS-Bewertung
8. **Ergebnisse: Performance** - Lighthouse, Core Web Vitals
9. **Ergebnisse: Accessibility** - BFSG-Status, Risiken
10. **Ergebnisse: Content & UX** - Highlights
11. **Handlungsbedarf** - Die Top-5 Prioritäten
12. **Unsere Empfehlung** - CMS, Ansatz
13. **Lösung: Drupal/CMS** - Warum dieses CMS?
14. **Projektansatz** - Phasen, Timeline
15. **Investment** - Kosten, ROI
16. **Team** - Wer arbeitet am Projekt?
17. **Nächste Schritte** - Konkrete Actions
18. **Q&A** - Fragen und Diskussion
19. **Kontakt** - Ansprechpartner

## adesso Branding

### Farben

| Verwendung | Farbe | Hex |
|------------|-------|-----|
| Primär | adesso Blau | #006EC7 |
| Sekundär | adesso Grau | #887D75 |
| Akzent | adesso Orange | #FF6B35 |
| Hintergrund | Weiß | #FFFFFF |
| Text | Dunkelgrau | #333333 |

### Schriften

| Verwendung | Font |
|------------|------|
| Headlines | Fira Sans Bold |
| Body | Fira Sans Regular |
| Zahlen | Fira Sans Medium |

## Output Format

Schreibe nach: `synthesis/presentation_outline.md`

```markdown
---
title: Präsentations-Outline
agent: presentation-generator
date: 2025-12-25
slides: 18
---

# Präsentation: [Firmenname] - Website Audit

## Folien-Übersicht

### Folie 1: Titel

```
┌────────────────────────────────────────────┐
│                                            │
│       [Firmenname]                         │
│                                            │
│       Website Audit Report                 │
│       ────────────────────                 │
│                                            │
│       Dezember 2025                        │
│                                            │
│                         [adesso Logo]      │
└────────────────────────────────────────────┘
```

### Folie 2: Agenda

```
┌────────────────────────────────────────────┐
│ Agenda                                     │
│ ──────                                     │
│                                            │
│ 1. Ausgangssituation          5 min       │
│ 2. Audit-Ergebnisse          15 min       │
│ 3. Handlungsbedarf            5 min       │
│ 4. Unsere Empfehlung         10 min       │
│ 5. Projektansatz & Investment 10 min      │
│ 6. Nächste Schritte           5 min       │
│ 7. Q&A                       10 min       │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 3: Management Summary

```
┌────────────────────────────────────────────┐
│ Management Summary                         │
│ ─────────────────                          │
│                                            │
│ ┌─────────┐ ┌─────────┐ ┌─────────┐       │
│ │  Score  │ │ Risiko  │ │ Invest  │       │
│ │  50/100 │ │  HOCH   │ │ 150k€   │       │
│ └─────────┘ └─────────┘ └─────────┘       │
│                                            │
│ Empfehlung: Website-Relaunch mit Drupal 11│
│ Timeline: 5-6 Monate | Go-Live vor BFSG   │
│                                            │
│ Kritisch: BFSG-Frist 28.06.2025           │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 4: Ausgangssituation

```
┌────────────────────────────────────────────┐
│ Ausgangssituation                          │
│ ─────────────────                          │
│                                            │
│ [Screenshot der aktuellen Website]         │
│                                            │
│ ✓ Etablierte Marke                         │
│ ✓ Guter Content-Fundus                     │
│ ✗ Veraltete Technologie                    │
│ ✗ Nicht barrierefrei                       │
│ ✗ Performance-Probleme                     │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 5: Audit-Methodik

```
┌────────────────────────────────────────────┐
│ Unser Audit-Ansatz                         │
│ ──────────────────                         │
│                                            │
│  Discovery → Technical → Content →         │
│  Legal → Marketing → UX → Evaluation       │
│                                            │
│ • 50+ Prüfpunkte                           │
│ • Lighthouse & WAVE Tools                  │
│ • Manuelle UX-Analyse                      │
│ • Wettbewerbsvergleich                     │
│ • Experten-Review                          │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 6: Ergebnisse Übersicht

```
┌────────────────────────────────────────────┐
│ Audit-Ergebnisse                           │
│ ────────────────                           │
│                                            │
│ ┌──────────────┐ ┌──────────────┐          │
│ │ Technologie  │ │ Performance  │          │
│ │     55       │ │     45       │          │
│ │     🔴       │ │     🔴       │          │
│ └──────────────┘ └──────────────┘          │
│ ┌──────────────┐ ┌──────────────┐          │
│ │ Accessibility│ │     SEO      │          │
│ │     40       │ │     50       │          │
│ │     🔴       │ │     🔴       │          │
│ └──────────────┘ └──────────────┘          │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 7: Technologie-Stack

```
┌────────────────────────────────────────────┐
│ Technologie-Analyse                        │
│ ──────────────────                         │
│                                            │
│ Aktuelles CMS: [CMS-Name]                  │
│                                            │
│ ⚠️ Version veraltet (kein Support)         │
│ ⚠️ Sicherheitsrisiken vorhanden            │
│ ⚠️ Keine modernen Features                 │
│ ⚠️ Weiterentwicklung unwirtschaftlich      │
│                                            │
│ Empfehlung: Migration notwendig            │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 8: Performance

```
┌────────────────────────────────────────────┐
│ Performance-Analyse                        │
│ ───────────────────                        │
│                                            │
│ Lighthouse Score: 45/100                   │
│                                            │
│ ┌──────────────────────────────────┐       │
│ │ LCP     ████████████░░░░  4.5s   │       │
│ │ FID     ███░░░░░░░░░░░░░  0.2s   │       │
│ │ CLS     █████████░░░░░░░  0.15   │       │
│ └──────────────────────────────────┘       │
│                                            │
│ → Verbesserungspotenzial: +50%             │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 9: BFSG-Compliance (Kritisch!)

```
┌────────────────────────────────────────────┐
│ 🔴 BFSG-Compliance                         │
│ ──────────────────                         │
│                                            │
│ Frist: 28. Juni 2025                       │
│                                            │
│ Aktuelle Compliance: ~40%                  │
│                                            │
│ Kritische Mängel:                          │
│ • Fehlende Alt-Texte                       │
│ • Unzureichende Kontraste                  │
│ • Keine Tastatur-Navigation               │
│ • Formulare nicht zugänglich               │
│                                            │
│ ⚠️ Mit aktuellem CMS nicht lösbar          │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 10: Top-5 Handlungsbedarf

```
┌────────────────────────────────────────────┐
│ Top-5 Handlungsfelder                      │
│ ─────────────────────                      │
│                                            │
│ 1. 🔴 BFSG-Compliance sicherstellen        │
│ 2. 🔴 Technologie modernisieren            │
│ 3. 🟠 Performance optimieren               │
│ 4. 🟠 Mobile Experience verbessern         │
│ 5. 🟡 Content-Strategie entwickeln         │
│                                            │
│ Empfehlung: Ganzheitlicher Relaunch        │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 11: Unsere Empfehlung

```
┌────────────────────────────────────────────┐
│ Unsere Empfehlung                          │
│ ─────────────────                          │
│                                            │
│       Website-Relaunch mit                 │
│                                            │
│       ┌─────────────────┐                  │
│       │   DRUPAL 11     │                  │
│       │   + adesso CMS  │                  │
│       │   Starterkit    │                  │
│       └─────────────────┘                  │
│                                            │
│ ✓ BFSG-compliant out-of-the-box            │
│ ✓ Zukunftssichere Technologie              │
│ ✓ Exzellente Performance                   │
│ ✓ Open Source, keine Lizenzkosten          │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 12: Warum Drupal?

```
┌────────────────────────────────────────────┐
│ Warum Drupal 11?                           │
│ ────────────────                           │
│                                            │
│ │ Drupal │ Alt. A │ Alt. B │               │
│ ├────────┼────────┼────────┤               │
│ │ BFSG ✓ │   ⚠️   │   ⚠️   │               │
│ │ API  ✓ │   ✓    │   ⚠️   │               │
│ │ TCO  € │  €€    │  €€€   │               │
│ │ Exp. ✓ │   ✓    │   ⚠️   │               │
│                                            │
│ adesso: 100+ Drupal-Projekte               │
│ 15+ zertifizierte Entwickler               │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 13: Projektansatz

```
┌────────────────────────────────────────────┐
│ Projektansatz                              │
│ ─────────────                              │
│                                            │
│ Phase 1: Discovery     ██░░░░░░  1 Mon     │
│ Phase 2: Development   ████████░  3 Mon    │
│ Phase 3: Content       ████░░░░  1 Mon     │
│ Phase 4: Launch        ██░░░░░░  1 Mon     │
│                        ────────────────     │
│                        Total: 5-6 Monate   │
│                                            │
│ Go-Live: Vor BFSG-Deadline ✓               │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 14: Investment

```
┌────────────────────────────────────────────┐
│ Investment                                 │
│ ──────────                                 │
│                                            │
│ Projektkosten                              │
│ ┌────────────────────────────────┐         │
│ │ Konzeption & Design    25.000€ │         │
│ │ Entwicklung            95.000€ │         │
│ │ Content & Migration    30.000€ │         │
│ │ Testing & Launch       20.000€ │         │
│ ├────────────────────────────────┤         │
│ │ Gesamt               ~170.000€ │         │
│ └────────────────────────────────┘         │
│                                            │
│ Jährliche Kosten: ~24.000€                 │
│ (Hosting + Wartung)                        │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 15: Ihr adesso Team

```
┌────────────────────────────────────────────┐
│ Ihr adesso Team                            │
│ ───────────────                            │
│                                            │
│ ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐        │
│ │ 👤  │  │ 👤  │  │ 👤  │  │ 👤  │        │
│ │Name │  │Name │  │Name │  │Name │        │
│ │Lead │  │Dev  │  │Front│  │PM   │        │
│ └─────┘  └─────┘  └─────┘  └─────┘        │
│                                            │
│ • 100+ CMS-Projekte                        │
│ • Zertifizierte Experten                   │
│ • Lokale Präsenz                           │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 16: Nächste Schritte

```
┌────────────────────────────────────────────┐
│ Nächste Schritte                           │
│ ────────────────                           │
│                                            │
│ 1. Diese Woche                             │
│    → Feedback zu Präsentation              │
│    → Offene Fragen klären                  │
│                                            │
│ 2. Nächste Wochen                          │
│    → Requirements-Workshop                  │
│    → Verbindliches Angebot                 │
│                                            │
│ 3. Bei Beauftragung                        │
│    → Projekt-Kickoff                       │
│    → Go-Live vor BFSG ✓                    │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 17: Q&A

```
┌────────────────────────────────────────────┐
│                                            │
│                                            │
│                                            │
│         Fragen & Diskussion                │
│         ───────────────────                │
│                                            │
│                                            │
│                                            │
│                                            │
└────────────────────────────────────────────┘
```

### Folie 18: Kontakt

```
┌────────────────────────────────────────────┐
│ Ihr Ansprechpartner                        │
│ ──────────────────                         │
│                                            │
│ [BD-Name]                                  │
│ [Position]                                 │
│                                            │
│ 📧 [email]@adesso.de                       │
│ 📞 +49 xxx xxxxxxx                         │
│ 🔗 linkedin.com/in/[name]                  │
│                                            │
│ adesso SE                                  │
│ [Standort]                                 │
│                                            │
│ www.adesso.de                              │
│                                            │
└────────────────────────────────────────────┘
```

## Präsentations-Notizen

### Zeitplanung

| Abschnitt | Folien | Zeit |
|-----------|--------|------|
| Intro & Situation | 1-5 | 5 min |
| Audit-Ergebnisse | 6-9 | 15 min |
| Handlungsbedarf | 10 | 5 min |
| Empfehlung | 11-12 | 10 min |
| Projekt & Invest | 13-15 | 10 min |
| Nächste Schritte | 16 | 5 min |
| Q&A | 17-18 | 10 min |
| **Gesamt** | **18** | **60 min** |

### Speaking Notes

- Folie 9 (BFSG): Hier die Dringlichkeit betonen
- Folie 11 (Empfehlung): Kernbotschaft
- Folie 14 (Investment): Auf ROI eingehen
```

## Generierungs-Befehl

Um die PowerPoint zu erstellen, nutze den `/bd-ppt` Befehl, der diese Outline in eine echte PPTX-Datei konvertiert.
