<icons_overview>
adesso verwendet ausschließlich FontAwesome Icons im **Thin** Style. Andere Icon-Styles oder Icon-Sets sind nicht erlaubt.
</icons_overview>

<fontawesome_thin>

<rule name="Nur Thin Style">
**KRITISCH:** Ausschließlich `fa-thin` verwenden!

**Erlaubt:**
```html
<i class="fa-thin fa-house"></i>
<i class="fa-thin fa-user"></i>
<i class="fa-thin fa-envelope"></i>
```

**VERBOTEN:**
```html
<!-- NIEMALS diese Styles: -->
<i class="fa-solid fa-house"></i>     <!-- Solid -->
<i class="fa-regular fa-house"></i>   <!-- Regular -->
<i class="fa-light fa-house"></i>     <!-- Light -->
<i class="fa-duotone fa-house"></i>   <!-- Duotone -->
```
</rule>

<characteristics>
**Eigenschaften von FA Thin:**
- Sehr feine Linien (1px Strichstärke)
- Elegant und modern
- Gute Lesbarkeit bei größeren Größen
- Passt zum minimalistischen adesso Design

**Visuelle Wirkung:**
- Leicht und luftig
- Nicht aufdringlich
- Harmoniert mit Klavika Headlines
- Reduziert, nicht überladen
</characteristics>

</fontawesome_thin>

<usage_guidelines>

<sizing>
**Empfohlene Größen:**

| Kontext | Klasse | Größe |
|---------|--------|-------|
| Inline mit Text | fa-sm | 14px |
| Standard | fa-lg | 18px |
| Navigation | fa-xl | 24px |
| Feature Icons | fa-2x | 32px |
| Hero Icons | fa-3x | 48px |
| Illustrationen | fa-4x+ | 64px+ |

**Thin Icons nie zu klein:**
- Minimum: 14px (fa-sm)
- Unter 14px: Linien werden unsichtbar
</sizing>

<colors>
**Icon-Farben:**

**Primär:**
- adesso-Blau (#006ec7) für CTAs, Links
- adesso-Grau (#887d75) für sekundäre Icons
- Weiß auf dunklem Hintergrund

**Akzent (sparsam):**
- Akzentfarben nur für Status-Icons
- Grün: Success
- Orange: Warning
- Pink/Violett: Specials

```css
.icon-primary { color: #006ec7; }
.icon-secondary { color: #887d75; }
.icon-success { color: #76c800; }
.icon-warning { color: #ff9868; }
```
</colors>

<spacing>
**Abstände:**

**Neben Text:**
```html
<i class="fa-thin fa-envelope me-2"></i> E-Mail
<!-- oder -->
<span class="inline-flex items-center gap-2">
  <i class="fa-thin fa-envelope"></i>
  E-Mail
</span>
```

**In Buttons:**
```html
<button class="flex items-center gap-2">
  <i class="fa-thin fa-arrow-right"></i>
  Weiter
</button>
```
</spacing>

</usage_guidelines>

<common_icons>
**Häufig verwendete Icons:**

| Zweck | Icon | Klasse |
|-------|------|--------|
| Navigation | Pfeil rechts | `fa-thin fa-arrow-right` |
| Navigation | Pfeil links | `fa-thin fa-arrow-left` |
| Menü | Hamburger | `fa-thin fa-bars` |
| Schließen | X | `fa-thin fa-xmark` |
| Suche | Lupe | `fa-thin fa-magnifying-glass` |
| User | Person | `fa-thin fa-user` |
| Mail | Briefumschlag | `fa-thin fa-envelope` |
| Telefon | Hörer | `fa-thin fa-phone` |
| Download | Pfeil runter | `fa-thin fa-download` |
| Extern | Link extern | `fa-thin fa-arrow-up-right-from-square` |
| Check | Haken | `fa-thin fa-check` |
| Info | Info-Kreis | `fa-thin fa-circle-info` |
| Warnung | Dreieck | `fa-thin fa-triangle-exclamation` |
| Kalender | Kalender | `fa-thin fa-calendar` |
| Uhr | Uhr | `fa-thin fa-clock` |
| Ort | Pin | `fa-thin fa-location-dot` |
</common_icons>

<implementation>
**FontAwesome Pro einbinden:**

```html
<!-- Kit (empfohlen) -->
<script src="https://kit.fontawesome.com/YOUR-KIT-ID.js" crossorigin="anonymous"></script>

<!-- Oder via npm -->
<!-- npm install @fortawesome/fontawesome-pro -->
```

```javascript
// JavaScript Import
import { library } from '@fortawesome/fontawesome-svg-core';
import { faThin } from '@fortawesome/pro-thin-svg-icons';

library.add(faThin);
```

**CSS-only (wenn nötig):**
```css
@import url('https://kit.fontawesome.com/YOUR-KIT-ID.css');

/* Nur Thin laden für Performance */
@import url('@fortawesome/fontawesome-pro/css/thin.css');
```
</implementation>

<anti_patterns>
**Icon-Fehler vermeiden:**

- **Nie:** Andere FA-Styles (solid, regular, light, duotone)
- **Nie:** Andere Icon-Sets (Material, Heroicons, etc.)
- **Nie:** Icons unter 14px
- **Nie:** Icons ohne ausreichend Kontrast
- **Nie:** Zu viele Icons auf einmal (max 5-6 pro Bereich)
- **Nie:** Icons als alleinige Aktion (immer mit Label/Tooltip)
- **Nie:** Dekorative Icons ohne aria-hidden="true"

**Accessibility:**
```html
<!-- Dekorativ: verstecken -->
<i class="fa-thin fa-star" aria-hidden="true"></i>

<!-- Funktional: Label hinzufügen -->
<button aria-label="Favorit hinzufügen">
  <i class="fa-thin fa-star" aria-hidden="true"></i>
</button>
```
</anti_patterns>

<tailwind_integration>
```html
<!-- Tailwind + FontAwesome -->
<i class="fa-thin fa-house text-adesso-blau text-xl"></i>
<i class="fa-thin fa-user text-adesso-grau text-lg"></i>
<i class="fa-thin fa-check text-accent-gruen text-2xl"></i>
```
</tailwind_integration>
