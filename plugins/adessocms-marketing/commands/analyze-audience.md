---
name: analyze-audience
description: Zielgruppen- und Persona-Analyse durchführen
argument-hint: "[Firmenname] [Website-URL]"
allowed-tools: ["Task", "WebSearch", "WebFetch", "Write", "Read", "Bash", "TodoWrite"]
---

# Zielgruppen- und Persona-Analyse

Erstelle detaillierte Buyer Personas und analysiere die Zielgruppen eines Unternehmens.

## Input

- **Firmenname**: Name des Unternehmens
- **Website-URL**: Hauptwebsite (optional)

## Voraussetzung

Prüfe ob `./analysis/[slug]/01-company.md` existiert. Falls nicht, empfehle zuerst `/analyze-company` auszuführen.

## Analyse-Verzeichnis

Erstelle/nutze `./analysis/[firmenname-slug]/`

## Agents starten (parallel)

Starte mit dem Task-Tool:

1. **persona-builder** (`adessocms-marketing:audience:persona-builder`)
   - Prompt: "Erstelle Buyer Personas für [Firmenname] ([URL]). Nutze vorhandene Analysen in ./analysis/[slug]/. Schreibe nach ./analysis/[slug]/06-personas.md"

2. **journey-mapper** (`adessocms-marketing:audience:journey-mapper`)
   - Prompt: "Erstelle Customer Journey Map für [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/07-customer-journey.md"

3. **voice-of-customer-analyst** (`adessocms-marketing:audience:voice-of-customer-analyst`)
   - Prompt: "Sammle Voice of Customer für [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/08-voice-of-customer.md"

4. **decision-analyst** (`adessocms-marketing:audience:decision-analyst`)
   - Prompt: "Analysiere Kaufentscheidungsprozesse für [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/07-customer-journey.md (anhängen)"

## Nach Abschluss

1. Zeige die wichtigsten Personas als Kurzübersicht
2. Öffne die Persona-Datei in Typora
3. Weise auf `/analyze-conversion` als nächsten Schritt hin
