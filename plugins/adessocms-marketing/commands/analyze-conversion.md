---
name: analyze-conversion
description: Conversion-fokussierte Analyse für optimale Verkaufsargumente
argument-hint: "[Firmenname] [Website-URL]"
allowed-tools: ["Task", "WebSearch", "WebFetch", "Write", "Read", "Bash", "TodoWrite"]
---

# Conversion-Analyse

Analysiere alle Faktoren, die für konvertierende Webseiten und überzeugende Kommunikation wichtig sind.

## Input

- **Firmenname**: Name des Unternehmens
- **Website-URL**: Hauptwebsite (optional)

## Voraussetzung

Prüfe ob Persona-Analyse existiert (`./analysis/[slug]/06-personas.md`). Falls nicht, empfehle zuerst `/analyze-audience`.

## Analyse-Verzeichnis

Nutze `./analysis/[firmenname-slug]/`

## Agents starten (parallel)

Starte mit dem Task-Tool:

1. **objection-handler** (`adessocms-marketing:conversion:objection-handler`)
   - Prompt: "Erstelle Einwand-Katalog für [Firmenname] ([URL]). Nutze Personas aus ./analysis/[slug]/06-personas.md. Schreibe nach ./analysis/[slug]/09-objections.md"

2. **trust-auditor** (`adessocms-marketing:conversion:trust-auditor`)
   - Prompt: "Führe Trust & Social Proof Audit für [Firmenname] ([URL]) durch. Schreibe nach ./analysis/[slug]/10-trust-proof.md"

3. **conversion-psychologist** (`adessocms-marketing:conversion:conversion-psychologist`)
   - Prompt: "Analysiere Conversion-Trigger für [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/10-trust-proof.md (anhängen)"

4. **messaging-strategist** (`adessocms-marketing:conversion:messaging-strategist`)
   - Prompt: "Erstelle Messaging Framework für [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/11-messaging.md"

5. **value-communicator** (`adessocms-marketing:conversion:value-communicator`)
   - Prompt: "Analysiere Wert-Kommunikation für [Firmenname] ([URL]). Schreibe nach ./analysis/[slug]/11-messaging.md (anhängen)"

## Nach Abschluss

1. Zeige die Top 5 Einwände und ihre Gegenargumente
2. Zeige die Primary Message und Value Proposition
3. Öffne das Messaging Framework in Typora
4. Empfehle `/analyze-brand` oder `/generate-context` als nächsten Schritt
