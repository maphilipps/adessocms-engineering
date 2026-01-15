# Workflow: Validate Icons

<required_reading>
**Lies diese Referenz JETZT:**
1. references/icons.md (FontAwesome Thin Regeln)
</required_reading>

<process>

## Step 1: Icons finden

Suche nach allen Icon-Verwendungen im Projekt:

```bash
# FontAwesome Klassen finden
ddev exec grep -r "fa-" --include="*.twig" --include="*.html" --include="*.js" .

# Oder spezifisch
ddev exec grep -rn "fa-solid\|fa-regular\|fa-light\|fa-duotone" --include="*.twig" .
```

## Step 2: Violations identifizieren

**Prüfe auf:**

1. **Falsche FA-Styles:**
```html
<!-- VIOLATION -->
<i class="fa-solid fa-house"></i>
<i class="fa-regular fa-user"></i>
<i class="fa-light fa-envelope"></i>
<i class="fa-duotone fa-phone"></i>
```

2. **Andere Icon-Sets:**
```html
<!-- VIOLATION -->
<span class="material-icons">home</span>
<svg class="heroicon">...</svg>
<i class="bi bi-house"></i>
```

3. **Zu kleine Icons:**
```html
<!-- VIOLATION: unter 14px -->
<i class="fa-thin fa-house" style="font-size: 10px;"></i>
<i class="fa-thin fa-house text-xs"></i>  <!-- 12px -->
```

## Step 3: Violations dokumentieren

Format:
```
### Icon Violation
**Datei:** templates/header.twig:25
**Problem:** `fa-solid fa-bars` (Solid statt Thin)
**Fix:** `fa-thin fa-bars`
```

## Step 4: Fixes anwenden

**Style-Fixes:**
```html
<!-- VORHER -->
<i class="fa-solid fa-house"></i>
<i class="fa-regular fa-user"></i>
<i class="fa-light fa-envelope"></i>

<!-- NACHHER -->
<i class="fa-thin fa-house"></i>
<i class="fa-thin fa-user"></i>
<i class="fa-thin fa-envelope"></i>
```

**Größen-Fixes:**
```html
<!-- VORHER (zu klein) -->
<i class="fa-thin fa-house text-xs"></i>

<!-- NACHHER (min 14px) -->
<i class="fa-thin fa-house text-sm"></i>
```

**Icon-Set Ersetzung:**
```html
<!-- Material Icon → FontAwesome -->
<!-- VORHER -->
<span class="material-icons">home</span>
<!-- NACHHER -->
<i class="fa-thin fa-house"></i>

<!-- Heroicon → FontAwesome -->
<!-- VORHER -->
<svg class="heroicon-outline"><!-- path --></svg>
<!-- NACHHER -->
<i class="fa-thin fa-[equivalent]"></i>
```

## Step 5: Accessibility prüfen

```html
<!-- Dekorative Icons: verstecken -->
<i class="fa-thin fa-star" aria-hidden="true"></i>

<!-- Funktionale Icons: Label hinzufügen -->
<button aria-label="Suche">
  <i class="fa-thin fa-magnifying-glass" aria-hidden="true"></i>
</button>

<!-- Mit sichtbarem Text -->
<a href="/contact" class="flex items-center gap-2">
  <i class="fa-thin fa-envelope" aria-hidden="true"></i>
  Kontakt
</a>
```

## Step 6: Verifizieren

Nach allen Fixes:
```bash
# Erneut prüfen - sollte keine Ergebnisse liefern
ddev exec grep -rn "fa-solid\|fa-regular\|fa-light\|fa-duotone" --include="*.twig" .
```

</process>

<icon_mapping>
**Häufige Icon-Ersetzungen:**

| Material | Heroicon | FontAwesome Thin |
|----------|----------|------------------|
| home | home | fa-thin fa-house |
| menu | bars-3 | fa-thin fa-bars |
| close | x-mark | fa-thin fa-xmark |
| search | magnifying-glass | fa-thin fa-magnifying-glass |
| person | user | fa-thin fa-user |
| mail | envelope | fa-thin fa-envelope |
| phone | phone | fa-thin fa-phone |
| arrow_forward | arrow-right | fa-thin fa-arrow-right |
| arrow_back | arrow-left | fa-thin fa-arrow-left |
| check | check | fa-thin fa-check |
| info | information-circle | fa-thin fa-circle-info |
| warning | exclamation-triangle | fa-thin fa-triangle-exclamation |
</icon_mapping>

<size_reference>
**FontAwesome Größen-Klassen:**

| Klasse | Größe | Erlaubt? |
|--------|-------|----------|
| (keine) | 16px | ✓ |
| fa-xs | 10px | ✗ (zu klein) |
| fa-sm | 14px | ✓ (Minimum) |
| fa-lg | 18px | ✓ |
| fa-xl | 24px | ✓ |
| fa-2x | 32px | ✓ |
| fa-3x | 48px | ✓ |
| fa-4x | 64px | ✓ |

**Tailwind Größen:**
| Klasse | Größe | Erlaubt? |
|--------|-------|----------|
| text-xs | 12px | ✗ |
| text-sm | 14px | ✓ (Minimum) |
| text-base | 16px | ✓ |
| text-lg | 18px | ✓ |
| text-xl | 20px | ✓ |
| text-2xl | 24px | ✓ |
</size_reference>

<success_criteria>
Icon-Validierung ist vollständig wenn:
- [ ] Alle Icons nutzen fa-thin
- [ ] Keine anderen Icon-Sets verwendet
- [ ] Alle Icons mindestens 14px
- [ ] Accessibility-Attribute gesetzt
- [ ] Grep-Suche findet keine Violations
</success_criteria>
