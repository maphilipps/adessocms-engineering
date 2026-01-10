# Workflow: Review Compliance

<required_reading>
**Lies diese Referenzen JETZT:**
1. references/anti-patterns.md (Quick-Check Liste)
2. references/colors.md (wenn Farben im Scope)
3. references/typography.md (wenn Schriften im Scope)
4. references/icons.md (wenn Icons im Scope)
</required_reading>

<process>

## Step 1: Scope identifizieren

Frage den User:
- Welche Dateien/Komponenten sollen geprüft werden?
- Fokus auf bestimmte Bereiche (Farben, Typo, Icons, alles)?

## Step 2: Dateien lesen

Lade alle relevanten Dateien:
- CSS/SCSS/Tailwind-Klassen
- Twig/HTML Templates
- JavaScript (falls Styling-relevant)
- Tailwind Config (falls vorhanden)

## Step 3: Systematisch prüfen

**Farb-Check:**
```
[ ] Kein adesso-Blau Tint (nur #006ec7)
[ ] Keine Herbstfarben
[ ] Gradienten enthalten adesso-Blau
[ ] Max 2 Akzentfarben pro Section
[ ] Keine Standard-Tailwind-Farben (blue-500, etc.)
```

**Typografie-Check:**
```
[ ] Headlines mit Klavika/font-headline
[ ] Body mit ABC Marist/font-body
[ ] Body-Text min 16px
[ ] Keine fremden Schriften
```

**Icon-Check:**
```
[ ] Nur fa-thin Icons
[ ] Min 14px Größe
[ ] Keine anderen Icon-Sets
```

**Logo-Check (falls vorhanden):**
```
[ ] Korrekte Farbvariante
[ ] Nicht verzerrt
[ ] Schutzzone eingehalten
[ ] Keine Effekte
```

## Step 4: Violations dokumentieren

Für jede Violation:
1. **Datei + Zeile** angeben
2. **Was falsch ist** (mit Code-Snippet)
3. **Warum falsch** (Styleguide-Regel)
4. **Korrektur** vorschlagen

**Format:**
```
### Violation: [Name]
**Severity:** critical/high/medium/low
**Datei:** path/to/file.css:42
**Problem:**
  `color: #0055a0;` (dunkles Blau)
**Regel:**
  adesso-Blau (#006ec7) hat keine erlaubten Tints
**Fix:**
  `color: #006ec7;` oder `color: var(--adesso-blau);`
```

## Step 5: Report erstellen

Zusammenfassung:
- Anzahl kritischer/hoher/mittlerer/niedriger Violations
- Top-3 Problembereiche
- Priorisierte Fix-Liste

</process>

<severity_levels>
| Level | Bedeutung | Action |
|-------|-----------|--------|
| critical | Brand-Verstoß, muss sofort gefixt werden | Blocker |
| high | Deutlich sichtbarer Verstoß | Vor Release fixen |
| medium | Inkonsistenz | Sollte gefixt werden |
| low | Optimierungspotenzial | Nice-to-have |
</severity_levels>

<success_criteria>
Review ist vollständig wenn:
- [ ] Alle relevanten Dateien geprüft
- [ ] Alle Violations mit Severity eingestuft
- [ ] Jede Violation hat konkrete Fix-Empfehlung
- [ ] Report an User übergeben
</success_criteria>
