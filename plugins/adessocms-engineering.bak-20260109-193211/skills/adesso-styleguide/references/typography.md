<typography_overview>
Das adesso Schriftsystem besteht aus drei Schriftfamilien mit klaren Einsatzbereichen. Die Hierarchie ist strikt einzuhalten.
</typography_overview>

<font_families>

<font name="Klavika">
**Typ:** Headline-Schrift
**Schnitte:** Light, Regular, Medium, Bold
**Lizenz:** Kostenpflichtig (Monotype)

**Verwendung:**
- Alle Headlines (H1-H6)
- Große Zitate
- Hero-Texte
- Navigation (wenn prominent)
- CTAs

**Stil-Empfehlungen:**
- H1: Klavika Bold
- H2: Klavika Bold oder Medium
- H3-H4: Klavika Medium
- H5-H6: Klavika Regular

**Eigenschaften:**
- Serifenlos, geometrisch
- Markant, modern
- Gute Lesbarkeit auch groß
</font>

<font name="ABC Marist">
**Typ:** Fließtext-Schrift
**Schnitte:** Regular, Italic, Medium, Bold
**Lizenz:** Kostenpflichtig

**Verwendung:**
- Fließtext / Body Copy
- Längere Textpassagen
- Artikel, Blog-Posts
- Beschreibungen
- Listen

**Stil-Empfehlungen:**
- Body: ABC Marist Regular, 16-18px
- Lead/Intro: ABC Marist Medium, 18-20px
- Captions: ABC Marist Regular, 14px
- Hervorhebungen: ABC Marist Bold

**Eigenschaften:**
- Serifenlos, humanistisch
- Hervorragende Lesbarkeit
- Warmer, freundlicher Charakter
</font>

<font name="Fira Sans">
**Typ:** System-/Fallback-Schrift
**Schnitte:** Light, Regular, Medium, SemiBold, Bold
**Lizenz:** Open Source (Google Fonts)

**Verwendung:**
- Web-Fallback wenn Klavika/ABC Marist nicht verfügbar
- Office-Dokumente (Word, PowerPoint)
- E-Mails
- Systeme ohne Custom Fonts

**Wann Fira Sans:**
- Keine Lizenzen für Klavika/ABC Marist
- System-E-Mails
- Interne Tools
- Budget-Projekte

**Eigenschaften:**
- Serifenlos, neutral
- Sehr gute Screen-Lesbarkeit
- Mozilla-Design, Open Source
</font>

</font_families>

<hierarchy>
**Typografie-Hierarchie:**

```
+------------------+-------------+------------------+
| Element          | Schrift     | Gewicht          |
+------------------+-------------+------------------+
| H1               | Klavika     | Bold             |
| H2               | Klavika     | Bold/Medium      |
| H3               | Klavika     | Medium           |
| H4               | Klavika     | Medium           |
| H5               | Klavika     | Regular          |
| H6               | Klavika     | Regular          |
| Body             | ABC Marist  | Regular          |
| Lead             | ABC Marist  | Medium           |
| Small            | ABC Marist  | Regular          |
| Caption          | ABC Marist  | Regular (klein)  |
| Button           | Klavika     | Medium/Bold      |
| Navigation       | Klavika     | Medium           |
| Footer           | ABC Marist  | Regular          |
+------------------+-------------+------------------+
```
</hierarchy>

<sizing>
**Empfohlene Größen (Desktop):**

| Element | Größe | Zeilenhöhe |
|---------|-------|------------|
| H1 | 48-64px | 1.1-1.2 |
| H2 | 36-48px | 1.2 |
| H3 | 28-36px | 1.25 |
| H4 | 24-28px | 1.3 |
| H5 | 20-24px | 1.35 |
| H6 | 18-20px | 1.4 |
| Body | 16-18px | 1.5-1.6 |
| Small | 14px | 1.5 |
| Caption | 12-14px | 1.4 |

**Mobile-Anpassungen:**
- H1: 32-40px
- H2: 28-32px
- H3: 24-28px
- Body: 16px (nie kleiner!)
</sizing>

<web_implementation>
**CSS Font-Stack:**

```css
:root {
  --font-headline: 'Klavika', 'Fira Sans', system-ui, sans-serif;
  --font-body: 'ABC Marist', 'Fira Sans', system-ui, sans-serif;
  --font-fallback: 'Fira Sans', system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
}

h1, h2, h3, h4, h5, h6 {
  font-family: var(--font-headline);
}

body, p, li, td {
  font-family: var(--font-body);
}
```

**@font-face Beispiel:**

```css
@font-face {
  font-family: 'Klavika';
  src: url('/fonts/Klavika-Bold.woff2') format('woff2');
  font-weight: 700;
  font-display: swap;
}

@font-face {
  font-family: 'Klavika';
  src: url('/fonts/Klavika-Medium.woff2') format('woff2');
  font-weight: 500;
  font-display: swap;
}

@font-face {
  font-family: 'ABC Marist';
  src: url('/fonts/ABCMarist-Regular.woff2') format('woff2');
  font-weight: 400;
  font-display: swap;
}
```
</web_implementation>

<anti_patterns>
**Typografie-Fehler vermeiden:**

- **Nie:** Klavika für Fließtext (nur Headlines!)
- **Nie:** ABC Marist für Headlines (nur Body!)
- **Nie:** Andere Schriften als die drei definierten
- **Nie:** Body-Text unter 16px
- **Nie:** Zu enge Zeilenhöhe (< 1.4 bei Body)
- **Nie:** ALL CAPS für lange Texte
- **Nie:** Kursiv für Headlines
</anti_patterns>

<tailwind_config>
```javascript
// tailwind.config.js
module.exports = {
  theme: {
    fontFamily: {
      'headline': ['Klavika', 'Fira Sans', 'system-ui', 'sans-serif'],
      'body': ['ABC Marist', 'Fira Sans', 'system-ui', 'sans-serif'],
      'fallback': ['Fira Sans', 'system-ui', 'sans-serif'],
    },
    fontSize: {
      'xs': ['12px', { lineHeight: '1.4' }],
      'sm': ['14px', { lineHeight: '1.5' }],
      'base': ['16px', { lineHeight: '1.6' }],
      'lg': ['18px', { lineHeight: '1.6' }],
      'xl': ['20px', { lineHeight: '1.5' }],
      '2xl': ['24px', { lineHeight: '1.35' }],
      '3xl': ['28px', { lineHeight: '1.3' }],
      '4xl': ['36px', { lineHeight: '1.25' }],
      '5xl': ['48px', { lineHeight: '1.2' }],
      '6xl': ['64px', { lineHeight: '1.1' }],
    },
  },
}
```
</tailwind_config>
