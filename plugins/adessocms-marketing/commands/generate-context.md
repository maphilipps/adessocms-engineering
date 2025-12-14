---
name: generate-context
description: AI-Kontext-Dokument aus vorhandenen Analysen generieren
argument-hint: "[Firmenname]"
allowed-tools: ["Task", "Write", "Read", "Bash", "Glob", "TodoWrite"]
---

# AI-Kontext-Dokument generieren

Erstelle ein kompaktes, aber vollständiges Kontext-Dokument, das als System-Prompt für AI-Assistenten (Claude, GPT, etc.) verwendet werden kann.

## Input

- **Firmenname**: Name des Unternehmens (Analyse muss bereits existieren)

## Voraussetzung

Prüfe ob Analyse-Verzeichnis existiert: `./analysis/[firmenname-slug]/`

Falls nicht oder leer: Empfehle zuerst `/analyze [Firmenname]`.

## Verfügbare Analysen lesen

Lies alle vorhandenen Analyse-Dateien:
```
./analysis/[slug]/01-company.md
./analysis/[slug]/02-products.md
./analysis/[slug]/06-personas.md
./analysis/[slug]/08-voice-of-customer.md
./analysis/[slug]/09-objections.md
./analysis/[slug]/11-messaging.md
./analysis/[slug]/13-tone-of-voice.md
```

## Agents starten

1. **context-generator** (`adessocms-marketing:output:context-generator`)
   - Prompt: "Erstelle AI-Kontext-Dokument für [Firmenname] aus den Analysen in ./analysis/[slug]/. Schreibe nach ./analysis/[slug]/15-ai-context.md"

2. **analysis-synthesizer** (`adessocms-marketing:output:analysis-synthesizer`)
   - Prompt: "Erstelle Executive Summary für [Firmenname] aus allen Analysen in ./analysis/[slug]/. Schreibe nach ./analysis/[slug]/00-overview.md"

## AI-Kontext Format

Das generierte Dokument soll enthalten:

```markdown
# [Firmenname] - AI-Kontext

## Unternehmen
[Kurzfassung der wichtigsten Fakten]

## Produkte/Services
[USPs, Hauptangebote, Differenzierung]

## Zielgruppen
[Personas in Kurzform]

## Tone of Voice
[Kommunikationsrichtlinien]

## Kernbotschaften
[Primary Message, Value Propositions]

## Wichtige Einwände & Antworten
[Top 5 Einwände mit Gegenargumenten]

## Do's & Don'ts
[Was die AI tun/sagen soll und was nicht]
```

## Nach Abschluss

1. Öffne das AI-Kontext-Dokument in Typora: `open -a Typora "./analysis/[slug]/15-ai-context.md"`
2. Erkläre wie das Dokument verwendet werden kann:
   - Als System-Prompt in Claude/ChatGPT
   - Als CLAUDE.md in Projekten
   - Als Briefing für Content-Erstellung
3. Biete an, das Dokument für spezifische Anwendungsfälle anzupassen
