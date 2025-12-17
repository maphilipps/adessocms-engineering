---
name: analyze-market
description: Markt- und Wettbewerbsanalyse durchführen
argument-hint: "[Firmenname] [Website-URL]"
allowed-tools: ["Task", "WebSearch", "WebFetch", "Write", "Read", "Bash", "TodoWrite"]
---

# Markt- und Wettbewerbsanalyse

Analysiere den Markt, die Branche und die Wettbewerber eines Unternehmens.

## Input

- **Firmenname**: Name des Unternehmens
- **Website-URL**: Hauptwebsite (optional)

## Analyse-Verzeichnis

Erstelle/nutze `./analysis/[firmenname-slug]/`

## Agents starten (parallel)

Starte mit dem Task-Tool:

1. **market-researcher** (`adessocms-marketing:research:market-researcher`)
   - Prompt: "Recherchiere den Markt für [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/03-market.md"

2. **competitor-analyst** (`adessocms-marketing:research:competitor-analyst`)
   - Prompt: "Analysiere Wettbewerber von [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/04-competitors.md"

3. **industry-analyst** (`adessocms-marketing:research:industry-analyst`)
   - Prompt: "Analysiere die Branche von [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/05-industry.md"

## Opus 4.5 Parallelisierung

**KRITISCH**: Starte ALLE 3 Agents GLEICHZEITIG in einem Response:
```
Task(market-researcher) + Task(competitor-analyst) + Task(industry-analyst)
```

Warte dann mit `TaskOutput` auf alle 3 Agents bevor du fortfährst.

## Nach Abschluss

1. Erstelle eine Wettbewerbs-Matrix als Übersicht
2. Öffne die Ergebnisse in Typora
3. Hebe besondere Chancen und Risiken hervor
