# Workflow: Fix Styling

<required_reading>
**Lies diese Referenzen JETZT:**
1. references/anti-patterns.md (was verboten ist)
2. references/tailwind-config.md (korrekte Klassen)
3. Plus spezifische Reference je nach Fix-Bereich
</required_reading>

<process>

## Step 1: Problem verstehen

Frage den User:
- Was genau soll gefixt werden?
- Review-Report vorhanden? (dann davon ausgehen)
- Einzelne Violation oder Batch-Fix?

## Step 2: Dateien laden

Lies die betroffenen Dateien vollständig.
Verstehe den Kontext vor dem Ändern.

## Step 3: Fixes durchführen

**Farb-Fixes:**
```css
/* VORHER (falsch) */
color: #0055a0;
color: blue;
background: linear-gradient(#ff9868, #f566ba);

/* NACHHER (korrekt) */
color: #006ec7;
color: var(--adesso-blau);
background: linear-gradient(#006ec7, #f566ba);
```

**Tailwind Farb-Fixes:**
```html
<!-- VORHER -->
<div class="text-blue-500 bg-gray-100">

<!-- NACHHER -->
<div class="text-adesso-blau bg-adesso-grau-10">
```

**Typografie-Fixes:**
```html
<!-- VORHER -->
<p class="font-headline text-sm">Body text...</p>

<!-- NACHHER -->
<p class="font-body text-base">Body text...</p>
```

**Icon-Fixes:**
```html
<!-- VORHER -->
<i class="fa-solid fa-house"></i>
<i class="fa-regular fa-user"></i>

<!-- NACHHER -->
<i class="fa-thin fa-house"></i>
<i class="fa-thin fa-user"></i>
```

## Step 4: Verifizieren

Nach jedem Fix:
1. Syntax prüfen (keine Tippfehler)
2. Klassen existieren in Tailwind Config?
3. Keine Breaking Changes eingeführt?

## Step 5: Zusammenfassung

Liste alle durchgeführten Änderungen:
```
### Fixes Applied

1. **file.css:42**
   - Was: Farbe #0055a0 → #006ec7
   - Typ: Color violation

2. **component.twig:15**
   - Was: fa-solid → fa-thin
   - Typ: Icon violation
```

</process>

<common_replacements>
**Farben:**
| Falsch | Richtig |
|--------|---------|
| blue-500, blue-600, etc. | adesso-blau |
| gray-100, gray-200, etc. | adesso-grau-10/20/etc. |
| #0055a0 (dunkles Blau) | #006ec7 |
| #3389d2 (helles Blau) | #006ec7 |

**Icons:**
| Falsch | Richtig |
|--------|---------|
| fa-solid | fa-thin |
| fa-regular | fa-thin |
| fa-light | fa-thin |
| fa-duotone | fa-thin |

**Schriften:**
| Falsch | Richtig |
|--------|---------|
| font-sans (für Headlines) | font-headline |
| font-headline (für Body) | font-body |
</common_replacements>

<success_criteria>
Fix ist vollständig wenn:
- [ ] Alle identifizierten Violations behoben
- [ ] Keine neuen Violations eingeführt
- [ ] Code kompiliert ohne Fehler
- [ ] Änderungen dokumentiert
</success_criteria>
