<colors_overview>
Das adesso Farbsystem besteht aus zwei Primärfarben und sechs Akzentfarben. Die korrekte Anwendung ist essentiell für Brand-Konsistenz.
</colors_overview>

<primary_colors>

<color name="adesso-Blau">
**Hex:** #006ec7
**RGB:** 0 | 110 | 199
**CMYK:** 100 | 30 | 0 | 0

**Verwendung:**
- Hauptfarbe für Headlines, CTAs, Links
- Logo-Farbe
- Muss in jedem Gradient vorkommen

**KRITISCH:** Keine Abstufungen/Tints erlaubt! Niemals #006ec7 aufhellen oder abdunkeln.

**Bei Kontrast-Problemen:**
- Weiß (#ffffff) als Hintergrund
- adesso-Grau als Alternative
- NICHT: Hellblau-Varianten erfinden
</color>

<color name="adesso-Grau">
**Hex:** #887d75
**RGB:** 136 | 125 | 117
**CMYK:** 38 | 37 | 40 | 19

**Verwendung:**
- Sekundäre Texte
- Hintergründe
- Linien und Trenner
- Dezente UI-Elemente

**Tints erlaubt (10%-90%):**
| Tint | Hex | Verwendung |
|------|-----|------------|
| 10% | #f4f3f2 | Helle Hintergründe |
| 20% | #e9e7e5 | Hover-States |
| 30% | #dedad8 | Borders |
| 40% | #d3cecb | Disabled States |
| 50% | #c8c2be | Placeholder Text |
| 60% | #bdb6b1 | Sekundärer Text |
| 70% | #b2aaa4 | Icons (inaktiv) |
| 80% | #a79e97 | Schatten |
| 90% | #9c928a | Dunkle Akzente |
</color>

</primary_colors>

<accent_colors>

<color name="Gelb">
**Hex:** #ffff00
**CMYK:** 0 | 0 | 90 | 0
**Verwendung:** Highlights, Badges, Aufmerksamkeit
**Vorsicht:** Sehr dominant, sparsam einsetzen
</color>

<color name="Orange">
**Hex:** #ff9868
**CMYK:** 0 | 50 | 60 | 0
**Verwendung:** Warnungen, sekundäre CTAs, Akzente
</color>

<color name="Pink">
**Hex:** #f566ba
**CMYK:** 0 | 70 | 0 | 0
**Verwendung:** Kreative Akzente, Marketing
</color>

<color name="Violett">
**Hex:** #461ebe
**CMYK:** 90 | 90 | 0 | 0
**Verwendung:** Innovation, Tech-Themen
</color>

<color name="Türkis">
**Hex:** #28dcaa
**CMYK:** 65 | 0 | 45 | 0
**Verwendung:** Erfolg, Wachstum, positive States
</color>

<color name="Grün">
**Hex:** #76c800
**CMYK:** 60 | 0 | 100 | 0
**Verwendung:** Nachhaltigkeit, Success-States
</color>

</accent_colors>

<accent_tints>
Alle Akzentfarben haben Abstufungen (10%-90%):

**Gelb-Tints:**
| Tint | Hex |
|------|-----|
| 10% | #fffff5 |
| 30% | #ffffb3 |
| 50% | #ffff80 |
| 70% | #ffff4d |
| 90% | #ffff1a |

**Orange-Tints:**
| Tint | Hex |
|------|-----|
| 10% | #fff7f3 |
| 30% | #ffdbc8 |
| 50% | #ffcbb4 |
| 70% | #ffb48e |
| 90% | #ffa67a |

**Pink-Tints:**
| Tint | Hex |
|------|-----|
| 10% | #fef0f8 |
| 30% | #fbc4e5 |
| 50% | #fab3dc |
| 70% | #f88cc8 |
| 90% | #f677c1 |

**Violett-Tints:**
| Tint | Hex |
|------|-----|
| 10% | #efeafb |
| 30% | #b9a6e8 |
| 50% | #a28fde |
| 70% | #7b5fce |
| 90% | #5d35c5 |

**Türkis-Tints:**
| Tint | Hex |
|------|-----|
| 10% | #eafcf7 |
| 30% | #a9f2de |
| 50% | #94edd5 |
| 70% | #67e4c0 |
| 90% | #40deb0 |

**Grün-Tints:**
| Tint | Hex |
|------|-----|
| 10% | #f4fbeb |
| 30% | #ccea80 |
| 50% | #bbe366 |
| 70% | #9dd533 |
| 90% | #85cf0d |
</accent_tints>

<color_combinations>
**Empfohlene Kombinationen:**
- adesso-Blau + Weiß (Standard)
- adesso-Blau + adesso-Grau (10-30%)
- adesso-Blau + eine Akzentfarbe
- adesso-Grau + eine Akzentfarbe

**Verbotene Kombinationen:**
- Mehrere Akzentfarben gleichzeitig dominant
- adesso-Blau Tints (existieren nicht!)
- Akzentfarben ohne adesso-Blau Präsenz
</color_combinations>

<css_variables>
```css
:root {
  /* Primärfarben */
  --adesso-blau: #006ec7;
  --adesso-grau: #887d75;

  /* adesso-Grau Tints */
  --adesso-grau-10: #f4f3f2;
  --adesso-grau-20: #e9e7e5;
  --adesso-grau-30: #dedad8;
  --adesso-grau-40: #d3cecb;
  --adesso-grau-50: #c8c2be;
  --adesso-grau-60: #bdb6b1;
  --adesso-grau-70: #b2aaa4;
  --adesso-grau-80: #a79e97;
  --adesso-grau-90: #9c928a;

  /* Akzentfarben */
  --accent-gelb: #ffff00;
  --accent-orange: #ff9868;
  --accent-pink: #f566ba;
  --accent-violett: #461ebe;
  --accent-tuerkis: #28dcaa;
  --accent-gruen: #76c800;
}
```
</css_variables>
