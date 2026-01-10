# Workflow: Apply Colors

<required_reading>
**Lies diese Referenzen JETZT:**
1. references/colors.md (alle Farbwerte + Verwendung)
2. references/gradients.md (falls Verläufe benötigt)
3. references/anti-patterns.md (Farb-Violations)
</required_reading>

<process>

## Step 1: Anwendungsfall klären

Frage den User:
- Was soll eingefärbt werden? (Button, Hintergrund, Text, Border, etc.)
- Welcher Kontext? (Hero, Card, Navigation, Footer, etc.)
- Welche Stimmung? (Primär, Sekundär, Akzent, Erfolg, Warnung)

## Step 2: Farbe auswählen

**Entscheidungsbaum:**

```
Ist es der primäre Call-to-Action?
  → Ja: adesso-Blau (#006ec7)
  → Nein: Weiter

Ist es Text?
  → Headline/wichtig: adesso-Blau
  → Body/sekundär: adesso-Grau
  → Auf dunklem Hintergrund: Weiß

Ist es ein Hintergrund?
  → Primär/Hero: adesso-Blau oder Gradient
  → Sekundär/dezent: adesso-Grau-10 bis 30
  → Karte: Weiß mit Grau-Border

Ist es ein Status?
  → Erfolg: accent-gruen (#76c800)
  → Warnung: accent-orange (#ff9868)
  → Highlight: accent-gelb oder accent-tuerkis

Braucht es Aufmerksamkeit?
  → Ja: Eine Akzentfarbe (max 2 pro Design!)
  → Nein: Primärfarben bleiben
```

## Step 3: Farbwert anwenden

**CSS/SCSS:**
```css
/* Primär */
color: #006ec7;
color: var(--adesso-blau);

/* Grau mit Tint */
background-color: #f4f3f2; /* 10% */
background-color: var(--adesso-grau-10);

/* Akzent */
color: #28dcaa; /* Türkis */
```

**Tailwind:**
```html
<!-- Primär -->
<div class="text-adesso-blau">
<div class="bg-adesso-blau">

<!-- Grau -->
<div class="bg-adesso-grau-10">
<div class="text-adesso-grau">
<div class="border-adesso-grau-30">

<!-- Akzent -->
<span class="text-accent-tuerkis">
<div class="bg-accent-gelb-10">
```

## Step 4: Kontrast prüfen

**Mindestkontrast (WCAG AA):**
- Normaler Text: 4.5:1
- Großer Text (18px+ oder 14px bold): 3:1
- UI-Elemente: 3:1

**Sichere Kombinationen:**
| Hintergrund | Text | Kontrast |
|-------------|------|----------|
| Weiß | adesso-Blau | ✓ 5.2:1 |
| Weiß | adesso-Grau | ✓ 4.6:1 |
| adesso-Blau | Weiß | ✓ 5.2:1 |
| adesso-Grau-10 | adesso-Blau | ✓ 4.9:1 |
| Gradient | Weiß | ✓ (prüfen!) |

**Kritische Kombinationen (vorsichtig!):**
- Akzentfarben auf Weiß (manchmal zu wenig Kontrast)
- Helle Tints als Text (zu wenig Kontrast)

## Step 5: Im Kontext testen

Prüfe die Farbwahl im Browser:
1. Stimmt die Hierarchie?
2. Ist der Kontrast ausreichend?
3. Funktioniert es im Dark Mode (falls nötig)?
4. Konsistent mit anderen Bereichen?

</process>

<color_cheatsheet>
**Schnellreferenz:**

| Verwendung | Farbe | Tailwind |
|------------|-------|----------|
| Primary CTA | #006ec7 | `bg-adesso-blau` |
| Secondary CTA | transparent + border | `border-adesso-blau` |
| Link | #006ec7 | `text-adesso-blau` |
| Body Text | #887d75 | `text-adesso-grau` |
| Light BG | #f4f3f2 | `bg-adesso-grau-10` |
| Border | #dedad8 | `border-adesso-grau-30` |
| Success | #76c800 | `text-accent-gruen` |
| Warning | #ff9868 | `text-accent-orange` |
| Highlight | #ffff00 | `bg-accent-gelb` |
</color_cheatsheet>

<success_criteria>
Farbanwendung ist korrekt wenn:
- [ ] Richtige Farbe für den Kontext gewählt
- [ ] Kontrast WCAG AA konform
- [ ] Keine verbotenen Farben (Blau-Tints, Herbstfarben)
- [ ] Max 2 Akzentfarben im Design
- [ ] Konsistent mit umliegenden Elementen
</success_criteria>
