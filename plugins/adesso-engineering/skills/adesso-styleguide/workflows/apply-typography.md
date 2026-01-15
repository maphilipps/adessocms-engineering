# Workflow: Apply Typography

<required_reading>
**Lies diese Referenz JETZT:**
1. references/typography.md (Schriftfamilien, Hierarchie, Größen)
</required_reading>

<process>

## Step 1: Texttyp identifizieren

Frage den User:
- Was für Text? (Headline, Body, Button, Navigation, Caption, etc.)
- Welche Hierarchie-Ebene? (H1, H2, H3, oder Body)
- Desktop oder Mobile?

## Step 2: Schrift auswählen

**Entscheidungsbaum:**

```
Ist es eine Headline (H1-H6)?
  → Klavika (font-headline)

Ist es ein Button oder CTA?
  → Klavika (font-headline)

Ist es Navigation?
  → Klavika (font-headline)

Ist es Fließtext/Body?
  → ABC Marist (font-body)

Ist es ein Footer-Text?
  → ABC Marist (font-body)

Fallback/System?
  → Fira Sans (font-fallback)
```

## Step 3: Größe und Gewicht wählen

**Headlines:**
| Element | Größe (Desktop) | Größe (Mobile) | Gewicht |
|---------|-----------------|----------------|---------|
| H1 | 48-64px (text-5xl/6xl) | 32-40px | Bold (700) |
| H2 | 36-48px (text-4xl/5xl) | 28-32px | Bold/Medium |
| H3 | 28-36px (text-3xl/4xl) | 24-28px | Medium (500) |
| H4 | 24-28px (text-2xl/3xl) | 20-24px | Medium |
| H5 | 20-24px (text-xl/2xl) | 18-20px | Regular (400) |
| H6 | 18-20px (text-lg/xl) | 16-18px | Regular |

**Body:**
| Element | Größe | Zeilenhöhe |
|---------|-------|------------|
| Body | 16-18px (text-base/lg) | 1.5-1.6 |
| Lead | 18-20px (text-lg/xl) | 1.5 |
| Small | 14px (text-sm) | 1.5 |
| Caption | 12-14px (text-xs/sm) | 1.4 |

## Step 4: Code schreiben

**Tailwind:**
```html
<!-- Headlines -->
<h1 class="font-headline text-5xl md:text-6xl font-bold text-adesso-blau">
  Headline H1
</h1>

<h2 class="font-headline text-3xl md:text-4xl font-medium text-adesso-blau">
  Headline H2
</h2>

<!-- Body -->
<p class="font-body text-base md:text-lg text-adesso-grau leading-relaxed">
  Body text paragraph...
</p>

<!-- Lead/Intro -->
<p class="font-body text-lg md:text-xl font-medium text-adesso-grau">
  Lead paragraph...
</p>

<!-- Button -->
<button class="font-headline font-medium text-base">
  Button Text
</button>

<!-- Caption -->
<span class="font-body text-sm text-adesso-grau-60">
  Caption text
</span>
```

**CSS:**
```css
h1 {
  font-family: var(--font-headline);
  font-size: 3rem; /* 48px */
  font-weight: 700;
  line-height: 1.2;
  color: #006ec7;
}

p {
  font-family: var(--font-body);
  font-size: 1rem; /* 16px */
  font-weight: 400;
  line-height: 1.6;
  color: #887d75;
}
```

## Step 5: Responsive anpassen

**Mobile-First Pattern:**
```html
<h1 class="
  font-headline
  text-3xl      /* Mobile: 28px */
  md:text-4xl   /* Tablet: 36px */
  lg:text-5xl   /* Desktop: 48px */
  xl:text-6xl   /* Large: 64px */
">
```

**Zeilenhöhe anpassen:**
```html
<p class="
  font-body
  text-base
  leading-relaxed   /* 1.625 */
  md:leading-loose  /* 2 für mehr Luft */
">
```

## Step 6: Verifizieren

Checkliste:
- [ ] Richtige Schriftfamilie (Klavika vs ABC Marist)
- [ ] Angemessene Größe für Hierarchie
- [ ] Zeilenhöhe nicht zu eng (min 1.4)
- [ ] Body-Text nicht unter 16px
- [ ] Responsive Anpassungen
- [ ] Farbe passt zum Kontext

</process>

<typography_cheatsheet>
**Schnellreferenz Tailwind:**

| Element | Classes |
|---------|---------|
| H1 | `font-headline text-5xl font-bold` |
| H2 | `font-headline text-4xl font-bold` |
| H3 | `font-headline text-3xl font-medium` |
| Body | `font-body text-base leading-relaxed` |
| Lead | `font-body text-lg font-medium` |
| Small | `font-body text-sm` |
| Button | `font-headline font-medium` |
| Nav | `font-headline font-medium` |
</typography_cheatsheet>

<success_criteria>
Typografie ist korrekt wenn:
- [ ] Klavika nur für Headlines/CTAs/Nav
- [ ] ABC Marist für allen Fließtext
- [ ] Body-Text mindestens 16px
- [ ] Zeilenhöhe mindestens 1.4 (Body 1.5-1.6)
- [ ] Responsive Größen definiert
- [ ] Hierarchie visuell klar erkennbar
</success_criteria>
