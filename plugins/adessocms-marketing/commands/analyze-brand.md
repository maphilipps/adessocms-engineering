---
name: analyze-brand
description: Marken- und Kommunikationsanalyse durchführen
argument-hint: "[Firmenname] [Website-URL]"
allowed-tools: ["Task", "WebSearch", "WebFetch", "Write", "Read", "Bash", "TodoWrite"]
---

# Marken- und Kommunikationsanalyse

Analysiere die Markenidentität und entwickle Kommunikationsrichtlinien.

## Input

- **Firmenname**: Name des Unternehmens
- **Website-URL**: Hauptwebsite (optional)

## Analyse-Verzeichnis

Nutze `./analysis/[firmenname-slug]/`

## Agents starten (parallel)

Starte mit dem Task-Tool:

1. **brand-analyst** (`adessocms-marketing:brand:brand-analyst`)
   - Prompt: "Analysiere die Marke [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/12-brand.md"

2. **tone-of-voice-expert** (`adessocms-marketing:brand:tone-of-voice-expert`)
   - Prompt: "Entwickle Tone of Voice Guidelines für [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/13-tone-of-voice.md"

3. **content-strategist** (`adessocms-marketing:brand:content-strategist`)
   - Prompt: "Entwickle Content-Strategie für [Firmenname] ([URL]). Nutze vorhandene Analysen. Schreibe nach ./analysis/[slug]/14-content-strategy.md"

## Nach Abschluss

1. Zeige die Kernelemente der Markenidentität
2. Zeige 3-5 Beispiel-Formulierungen im definierten Tone of Voice
3. Öffne die Brand-Datei in Typora
4. Empfehle `/generate-context` als finalen Schritt
