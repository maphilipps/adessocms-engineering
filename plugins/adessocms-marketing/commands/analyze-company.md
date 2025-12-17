---
name: analyze-company
description: Tiefgehende Unternehmensanalyse durchführen
argument-hint: "[Firmenname] [Website-URL]"
allowed-tools: ["Task", "WebSearch", "WebFetch", "Write", "Read", "Bash", "TodoWrite"]
---

# Unternehmensanalyse

Führe eine detaillierte Analyse des Unternehmens durch.

## Input

- **Firmenname**: Name des Unternehmens
- **Website-URL**: Hauptwebsite (optional)

## Analyse-Verzeichnis

Erstelle/nutze `./analysis/[firmenname-slug]/`

## Agents starten (parallel)

Starte mit dem Task-Tool:

1. **company-researcher** (`adessocms-marketing:research:company-researcher`)
   - Prompt: "Recherchiere [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/01-company.md"

2. **product-analyst** (`adessocms-marketing:research:product-analyst`)
   - Prompt: "Analysiere Produkte/Services von [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/02-products.md"

## Opus 4.5 Parallelisierung

**KRITISCH**: Starte BEIDE Agents GLEICHZEITIG in einem Response:
```
Task(company-researcher) + Task(product-analyst)
```

Warte dann mit `TaskOutput` auf beide Agents bevor du fortfährst.

## Nach Abschluss

1. Fasse die wichtigsten Erkenntnisse zusammen
2. Öffne die Ergebnisse in Typora: `open -a Typora "./analysis/[slug]/"`
3. Weise auf nächste sinnvolle Analyse-Schritte hin (z.B. `/analyze-audience`)
