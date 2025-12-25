---
name: bd-ppt
description: "Erstellt PowerPoint Präsentation aus Audit-Report"
argument-hint: "<firmenname>"
allowed-tools: ["Read", "Glob", "Skill"]
---

Erstelle eine professionelle PowerPoint-Präsentation aus dem Audit-Report.

## Workflow

1. Finde den Report für den angegebenen Firmennamen:
```
reports/**/[firmenname]/index.md
```

2. Lade den Report und extrahiere:
   - Executive Summary
   - Lead Score
   - Top Findings
   - CMS-Empfehlung
   - Aufwand & Budget
   - Nächste Schritte

3. Nutze das `document-skills:pptx` Skill um die Präsentation zu erstellen

## Präsentationsstruktur

**Slide 1: Titelfolie**
- Logo: adesso SE
- Titel: Website-Audit [Firmenname]
- Datum

**Slide 2: Executive Summary**
- Lead Score (groß)
- 3 Key Findings
- Empfehlung in einem Satz

**Slide 3: Aktuelle Website**
- Screenshot
- Tech Stack
- Hauptprobleme

**Slide 4: Performance & Accessibility**
- Lighthouse Scores (Grafik)
- BFSG-Status
- Core Web Vitals

**Slide 5: CMS-Empfehlung**
- Empfohlenes CMS
- Warum dieses CMS?
- Vorteile

**Slide 6: Aufwand & Investition**
- Personentage
- Budget-Range
- Timeline

**Slide 7: Nächste Schritte**
- 3 konkrete Actions
- Ansprechpartner adesso
- Kontaktdaten

## Output

Speichere als:
```
reports/[jahr]/[monat]/[firmenname]/presentation.pptx
```

Gib dem Benutzer den Pfad und biete an, die Datei zu öffnen.
