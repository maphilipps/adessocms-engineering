# Workflow: Configure Tailwind

<required_reading>
**Lies diese Referenz JETZT:**
1. references/tailwind-config.md (komplette Config)
2. references/colors.md (alle Farbwerte)
3. references/typography.md (Font-Stacks)
</required_reading>

<process>

## Step 1: Projektstand ermitteln

Prüfe:
- Existiert `tailwind.config.js` oder `tailwind.config.ts`?
- Tailwind v3 oder v4?
- Welche bestehende Konfiguration?

```bash
# In DDEV prüfen
ddev exec cat tailwind.config.js 2>/dev/null || echo "Keine Config"
ddev exec cat package.json | grep tailwind
```

## Step 2: Backup erstellen

Falls Config existiert:
```bash
ddev exec cp tailwind.config.js tailwind.config.js.backup
```

## Step 3: Config schreiben/aktualisieren

**Für neue Config:**
Kopiere vollständige Config aus `references/tailwind-config.md`

**Für bestehende Config:**
Merge die adesso-Definitionen in `theme`:

```javascript
// In theme.colors hinzufügen:
'adesso-blau': '#006ec7',
'adesso-grau': {
  DEFAULT: '#887d75',
  10: '#f4f3f2',
  // ... alle Tints
},
'accent-gelb': { /* ... */ },
// ... alle Akzentfarben

// In theme.fontFamily hinzufügen:
'headline': ['Klavika', 'Fira Sans', 'system-ui', 'sans-serif'],
'body': ['ABC Marist', 'Fira Sans', 'system-ui', 'sans-serif'],

// In theme.extend.backgroundImage hinzufügen:
'gradient-primary': 'linear-gradient(135deg, #006ec7 0%, #28dcaa 100%)',
// ... alle Gradienten
```

## Step 4: CSS Variables (Tailwind v4)

Falls Tailwind v4, erstelle/aktualisiere CSS:

```css
@import "tailwindcss";

@theme {
  --color-adesso-blau: #006ec7;
  --color-adesso-grau: #887d75;
  /* ... alle Farben */

  --font-headline: 'Klavika', 'Fira Sans', system-ui, sans-serif;
  --font-body: 'ABC Marist', 'Fira Sans', system-ui, sans-serif;
}
```

## Step 5: Fonts einrichten

Prüfe ob Fonts verfügbar:
- Klavika und ABC Marist = lizenzpflichtig
- Fira Sans = Google Fonts (Open Source)

```html
<!-- Fira Sans als Fallback (immer verfügbar) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fira+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
```

Falls Lizenzen vorhanden, Font-Files in `/fonts/` ablegen und @font-face definieren.

## Step 6: Build testen

```bash
ddev theme build
# oder
ddev exec npm run build
```

Prüfe auf Fehler.

## Step 7: Validieren

Test mit einer Komponente:

```html
<div class="bg-adesso-blau text-white font-headline text-2xl p-4">
  Test: adesso-Blau Background mit Klavika
</div>
<p class="text-adesso-grau font-body">
  Body-Text in adesso-Grau mit ABC Marist
</p>
```

</process>

<tailwind_v3_vs_v4>
**Tailwind v3:**
- Config in `tailwind.config.js`
- Farben/Fonts in `theme.extend` oder `theme`

**Tailwind v4:**
- Config optional, CSS-first
- Farben über `@theme` in CSS definierbar
- CSS Variables nativ unterstützt
</tailwind_v3_vs_v4>

<success_criteria>
Konfiguration ist vollständig wenn:
- [ ] Alle adesso-Farben verfügbar
- [ ] Alle Grau-Tints verfügbar (10-90)
- [ ] Alle Akzentfarben verfügbar
- [ ] font-headline und font-body funktionieren
- [ ] Gradienten als Utility-Klassen nutzbar
- [ ] Build läuft fehlerfrei
- [ ] Test-Komponente rendert korrekt
</success_criteria>
