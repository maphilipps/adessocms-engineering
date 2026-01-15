<logo_overview>
Das adesso Logo ist das wichtigste Markenelement. Es gibt klare Regeln für Varianten, Schutzzone, Mindestgrößen und verbotene Anwendungen.
</logo_overview>

<logo_variants>

<variant name="Standard (Blau)">
**Verwendung:** Primäre Variante auf weißem/hellem Hintergrund
**Datei:** adesso-logo-blue.svg
**Farbe:** adesso-Blau (#006ec7)
</variant>

<variant name="Weiß (Negativ)">
**Verwendung:** Auf dunklem Hintergrund, auf Fotos
**Datei:** adesso-logo-white.svg
**Farbe:** Weiß (#ffffff)
</variant>

<variant name="Schwarz">
**Verwendung:** Nur für SW-Druck, Fax, Stempel
**Datei:** adesso-logo-black.svg
**Farbe:** Schwarz (#000000)
</variant>

<variant name="Mit Claim">
**Claim:** "GROW TOGETHER"
**Verwendung:** Kampagnen, Image-Materialien
**Platzierung:** Claim unter oder neben Logo
</variant>

</logo_variants>

<protection_zone>
**Schutzzone:**
Die Schutzzone entspricht der **Höhe des kleinen "d"** im Logo.

```
    ┌─────────────────────────────┐
    │                             │
    │  ┌───┐                      │
    │  │ d │ ← Höhe = Schutzzone  │
    │  └───┘                      │
    │     adesso                  │
    │                             │
    └─────────────────────────────┘

    Mindestabstand zu allen Seiten = Höhe "d"
```

**Innerhalb der Schutzzone:**
- Keine anderen Elemente
- Keine Texte
- Keine Grafiken
- Keine Linien
</protection_zone>

<minimum_sizes>
**Mindestgrößen:**

| Medium | Breite | Höhe |
|--------|--------|------|
| Print | 25mm | - |
| Digital | 100px | - |
| Favicon | 32x32px | (Symbol) |
| App Icon | 512x512px | (Symbol) |

**Unter Mindestgröße:**
- Logo nicht verwenden
- Nur Wort-Bild-Marke, nie nur Symbol
</minimum_sizes>

<backgrounds>
**Erlaubte Hintergründe:**

**Blaues Logo auf:**
- Weiß
- Helles Grau (bis 30% adesso-Grau)
- Helle, ruhige Flächen

**Weißes Logo auf:**
- adesso-Blau
- Dunkles Grau (ab 70%)
- Dunkle Fotos (mit Overlay)
- Farbverläufe mit adesso-Blau

**NICHT erlaubt:**
- Logo auf unruhigen Hintergründen
- Logo auf bunten Flächen (außer adesso-Blau)
- Logo mit Schatten
- Logo mit Outline/Stroke
</backgrounds>

<donts>
**Logo Don'ts - NIEMALS:**

<dont name="Farbe ändern">
Logo nie in anderen Farben als Blau, Weiß oder Schwarz
</dont>

<dont name="Verzerren">
Logo nie strecken, stauchen oder drehen
</dont>

<dont name="Effekte">
- Kein Schatten
- Keine Outline
- Kein Glow
- Keine Transparenz (außer Hintergrund)
</dont>

<dont name="Elemente hinzufügen">
- Keine Rahmen
- Keine Unterstreichung
- Keine zusätzlichen Grafiken in Schutzzone
</dont>

<dont name="Hintergrund">
- Nicht auf bunten Hintergründen
- Nicht auf unruhigen Fotos ohne Overlay
- Nicht auf Mustern
</dont>

<dont name="Platzierung">
- Nicht in Fließtext einbetten
- Nicht als Bullet Point
- Nicht rotieren
</dont>

</donts>

<implementation>
**Web-Implementation:**

```html
<!-- Standard -->
<img src="/images/adesso-logo-blue.svg"
     alt="adesso"
     class="h-8 w-auto">

<!-- Auf dunklem Hintergrund -->
<img src="/images/adesso-logo-white.svg"
     alt="adesso"
     class="h-8 w-auto">

<!-- Responsive -->
<img src="/images/adesso-logo-blue.svg"
     alt="adesso"
     class="h-6 md:h-8 lg:h-10 w-auto">
```

**Als Inline SVG (für Farbsteuerung):**
```html
<svg class="h-8 w-auto fill-adesso-blau" viewBox="...">
  <!-- Logo paths -->
</svg>
```

**Favicon:**
```html
<link rel="icon" type="image/svg+xml" href="/favicon.svg">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
```
</implementation>

<file_formats>
**Dateiformate:**

| Format | Verwendung |
|--------|------------|
| SVG | Web (bevorzugt), Print |
| PNG | Web Fallback, transparent |
| EPS | Print, Druckereien |
| PDF | Print, Dokumente |

**Keine JPG-Logos!** (Artefakte, kein Transparenz)
</file_formats>
