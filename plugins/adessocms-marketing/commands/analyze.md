---
name: analyze
description: Vollständige Marketing-Analyse eines Unternehmens starten
argument-hint: "[Firmenname] [Website-URL]"
allowed-tools: ["Task", "WebSearch", "WebFetch", "Write", "Read", "Bash", "Glob", "TodoWrite"]
---

# Vollständige Marketing-Analyse

Du führst eine umfassende Marketing-Analyse für ein Unternehmen durch. Ziel ist es, ALLE Informationen zu sammeln, die für konvertierende Webseiten und effektive Marketing-Kommunikation nötig sind.

## Input verarbeiten

Extrahiere aus den Argumenten:
- **Firmenname**: Der Name des zu analysierenden Unternehmens
- **Website-URL**: Die Hauptwebsite (falls angegeben)

Falls nur ein Argument angegeben wurde, versuche die Website zu finden oder frage nach.

## Analyse-Verzeichnis

Erstelle das Verzeichnis `./analysis/[firmenname-slug]/` (kebab-case, lowercase).

## Analyse-Workflow

Starte die Analyse in **5 parallelen Wellen**:

### Welle 1: Research & Discovery (parallel)
Starte diese Agents gleichzeitig mit dem Task-Tool:
1. `company-researcher` - Unternehmensrecherche
2. `product-analyst` - Produkt-/Serviceanalyse
3. `market-researcher` - Marktforschung
4. `competitor-analyst` - Wettbewerbsanalyse
5. `industry-analyst` - Branchenanalyse

### Welle 2: Zielgruppe & Psychologie (parallel, nach Welle 1)
1. `persona-builder` - Buyer Personas
2. `voice-of-customer-analyst` - Kundensprache
3. `journey-mapper` - Customer Journey
4. `decision-analyst` - Kaufentscheidungen

### Welle 3: Konversion (parallel, nach Welle 2)
1. `objection-handler` - Einwände
2. `trust-auditor` - Trust & Social Proof
3. `conversion-psychologist` - Conversion Trigger
4. `messaging-strategist` - Messaging Framework
5. `value-communicator` - Wert-Kommunikation

### Welle 4: Marke & Content (parallel, nach Welle 3)
1. `brand-analyst` - Markenanalyse
2. `tone-of-voice-expert` - Voice Guidelines
3. `content-strategist` - Content-Strategie

### Welle 5: Synthese (nach allen anderen)
1. `analysis-synthesizer` - Alles zusammenführen
2. `context-generator` - AI-Kontext erstellen

## Agent-Aufruf Format

Für jeden Agent-Aufruf:
```
Task mit subagent_type="adessocms-marketing:[kategorie]:[agent-name]"
Prompt: "Analysiere [Firmenname] ([URL]). Schreibe das Ergebnis nach ./analysis/[slug]/[XX-filename].md"
```

## Nach Abschluss

1. Erstelle eine Übersicht in `./analysis/[slug]/00-overview.md`
2. Öffne die Übersicht in Typora: `open -a Typora "./analysis/[slug]/00-overview.md"`
3. Zeige dem Benutzer eine Zusammenfassung der wichtigsten Erkenntnisse

## Wichtig

- Alle Reports auf **Deutsch**
- Nutze **WebSearch** und **WebFetch** intensiv für aktuelle Daten
- Speichere Zwischenergebnisse sofort (nicht alles am Ende)
- Bei Fehlern: Dokumentiere was gefunden wurde und was nicht
