<gradients_overview>
Farbverläufe sind ein wichtiges Gestaltungselement bei adesso. Die wichtigste Regel: **Jeder Gradient MUSS adesso-Blau enthalten.**
</gradients_overview>

<core_rule>
**KRITISCH:** Farbverläufe ohne adesso-Blau sind NICHT erlaubt!

**Erlaubt:**
- adesso-Blau → Weiß
- adesso-Blau → Akzentfarbe
- Akzentfarbe → adesso-Blau → andere Akzentfarbe

**VERBOTEN:**
- Orange → Pink (kein Blau!)
- Grün → Türkis (kein Blau!)
- Gelb → Violett (kein Blau!)
</core_rule>

<gradient_types>

<gradient name="Blau zu Weiß">
**Verwendung:** Standard, dezent, elegant
```css
background: linear-gradient(135deg, #006ec7 0%, #ffffff 100%);
```
</gradient>

<gradient name="Blau zu Akzent">
**Verwendung:** Auffällig, modern
```css
/* Blau zu Türkis */
background: linear-gradient(135deg, #006ec7 0%, #28dcaa 100%);

/* Blau zu Pink */
background: linear-gradient(135deg, #006ec7 0%, #f566ba 100%);

/* Blau zu Violett */
background: linear-gradient(135deg, #006ec7 0%, #461ebe 100%);
```
</gradient>

<gradient name="Drei-Farben">
**Verwendung:** Hero-Bereiche, Kampagnen
```css
/* Türkis → Blau → Pink */
background: linear-gradient(135deg, #28dcaa 0%, #006ec7 50%, #f566ba 100%);

/* Grün → Blau → Orange */
background: linear-gradient(135deg, #76c800 0%, #006ec7 50%, #ff9868 100%);
```
</gradient>

</gradient_types>

<directions>
**Empfohlene Richtungen:**

| Winkel | Richtung | Verwendung |
|--------|----------|------------|
| 0deg | Unten → Oben | Vertikal |
| 90deg | Links → Rechts | Horizontal |
| 135deg | Diagonal ↘ | Standard (empfohlen) |
| 180deg | Oben → Unten | Vertikal invertiert |
| 45deg | Diagonal ↗ | Dynamisch |

**Standard: 135deg** (diagonal von links oben nach rechts unten)
</directions>

<css_examples>
**CSS Gradient-Definitionen:**

```css
:root {
  /* Standard-Gradients */
  --gradient-primary: linear-gradient(135deg, #006ec7 0%, #28dcaa 100%);
  --gradient-secondary: linear-gradient(135deg, #006ec7 0%, #f566ba 100%);
  --gradient-subtle: linear-gradient(135deg, #006ec7 0%, #ffffff 100%);

  /* Hero-Gradients */
  --gradient-hero-1: linear-gradient(135deg, #28dcaa 0%, #006ec7 50%, #f566ba 100%);
  --gradient-hero-2: linear-gradient(135deg, #76c800 0%, #006ec7 50%, #461ebe 100%);

  /* Overlay-Gradients */
  --gradient-overlay: linear-gradient(135deg, rgba(0, 110, 199, 0.8) 0%, rgba(40, 220, 170, 0.6) 100%);
}

.hero-gradient {
  background: var(--gradient-hero-1);
}

.card-gradient {
  background: var(--gradient-primary);
}

.overlay {
  background: var(--gradient-overlay);
}
```
</css_examples>

<tailwind_config>
**Tailwind Gradient-Konfiguration:**

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      backgroundImage: {
        'gradient-primary': 'linear-gradient(135deg, #006ec7 0%, #28dcaa 100%)',
        'gradient-secondary': 'linear-gradient(135deg, #006ec7 0%, #f566ba 100%)',
        'gradient-subtle': 'linear-gradient(135deg, #006ec7 0%, #ffffff 100%)',
        'gradient-hero': 'linear-gradient(135deg, #28dcaa 0%, #006ec7 50%, #f566ba 100%)',
      },
    },
  },
}
```

**Verwendung:**
```html
<div class="bg-gradient-primary">...</div>
<section class="bg-gradient-hero">...</section>
```
</tailwind_config>

<usage_guidelines>

<text_on_gradients>
**Text auf Gradienten:**
- Weiß (#ffffff) für alle Texte
- Keine dunklen Texte auf Gradienten
- Ausreichend Kontrast sicherstellen

```css
.gradient-section {
  background: var(--gradient-primary);
  color: #ffffff;
}
```
</text_on_gradients>

<gradient_overlays>
**Gradienten als Overlays:**
```css
.image-with-overlay {
  position: relative;
}

.image-with-overlay::after {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(
    135deg,
    rgba(0, 110, 199, 0.7) 0%,
    rgba(40, 220, 170, 0.5) 100%
  );
}
```
</gradient_overlays>

</usage_guidelines>

<anti_patterns>
**Gradient-Fehler vermeiden:**

- **Nie:** Gradienten ohne adesso-Blau
- **Nie:** Zu viele Farbstops (max 3)
- **Nie:** Harte Übergänge (immer smooth)
- **Nie:** Gradienten auf kleinen Elementen (Buttons ausgenommen)
- **Nie:** Dunkler Text auf Gradienten
- **Nie:** Gradienten mit adesso-Grau (zu langweilig)
</anti_patterns>
