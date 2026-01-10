<tailwind_overview>
Komplette Tailwind CSS v4 Konfiguration für das adesso Design System. Copy-paste ready.
</tailwind_overview>

<complete_config>
**tailwind.config.js - Vollständige Konfiguration:**

```javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/**/*.{html,js,jsx,ts,tsx,vue,svelte}',
    './templates/**/*.{html,twig}',
    './components/**/*.{html,twig,js}',
  ],
  theme: {
    // Farben komplett überschreiben für Brand-Konsistenz
    colors: {
      // Basis
      transparent: 'transparent',
      current: 'currentColor',
      white: '#ffffff',
      black: '#000000',

      // Primärfarben
      'adesso-blau': '#006ec7',
      'adesso-grau': {
        DEFAULT: '#887d75',
        10: '#f4f3f2',
        20: '#e9e7e5',
        30: '#dedad8',
        40: '#d3cecb',
        50: '#c8c2be',
        60: '#bdb6b1',
        70: '#b2aaa4',
        80: '#a79e97',
        90: '#9c928a',
      },

      // Akzentfarben
      'accent-gelb': {
        DEFAULT: '#ffff00',
        10: '#fffff5',
        30: '#ffffb3',
        50: '#ffff80',
        70: '#ffff4d',
        90: '#ffff1a',
      },
      'accent-orange': {
        DEFAULT: '#ff9868',
        10: '#fff7f3',
        30: '#ffdbc8',
        50: '#ffcbb4',
        70: '#ffb48e',
        90: '#ffa67a',
      },
      'accent-pink': {
        DEFAULT: '#f566ba',
        10: '#fef0f8',
        30: '#fbc4e5',
        50: '#fab3dc',
        70: '#f88cc8',
        90: '#f677c1',
      },
      'accent-violett': {
        DEFAULT: '#461ebe',
        10: '#efeafb',
        30: '#b9a6e8',
        50: '#a28fde',
        70: '#7b5fce',
        90: '#5d35c5',
      },
      'accent-tuerkis': {
        DEFAULT: '#28dcaa',
        10: '#eafcf7',
        30: '#a9f2de',
        50: '#94edd5',
        70: '#67e4c0',
        90: '#40deb0',
      },
      'accent-gruen': {
        DEFAULT: '#76c800',
        10: '#f4fbeb',
        30: '#ccea80',
        50: '#bbe366',
        70: '#9dd533',
        90: '#85cf0d',
      },
    },

    // Schriften
    fontFamily: {
      'headline': ['Klavika', 'Fira Sans', 'system-ui', 'sans-serif'],
      'body': ['ABC Marist', 'Fira Sans', 'system-ui', 'sans-serif'],
      'fallback': ['Fira Sans', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'sans-serif'],
    },

    // Font-Größen mit Zeilenhöhen
    fontSize: {
      'xs': ['0.75rem', { lineHeight: '1.4' }],      // 12px
      'sm': ['0.875rem', { lineHeight: '1.5' }],     // 14px
      'base': ['1rem', { lineHeight: '1.6' }],       // 16px
      'lg': ['1.125rem', { lineHeight: '1.6' }],     // 18px
      'xl': ['1.25rem', { lineHeight: '1.5' }],      // 20px
      '2xl': ['1.5rem', { lineHeight: '1.35' }],     // 24px
      '3xl': ['1.75rem', { lineHeight: '1.3' }],     // 28px
      '4xl': ['2.25rem', { lineHeight: '1.25' }],    // 36px
      '5xl': ['3rem', { lineHeight: '1.2' }],        // 48px
      '6xl': ['4rem', { lineHeight: '1.1' }],        // 64px
    },

    extend: {
      // Gradienten
      backgroundImage: {
        'gradient-primary': 'linear-gradient(135deg, #006ec7 0%, #28dcaa 100%)',
        'gradient-secondary': 'linear-gradient(135deg, #006ec7 0%, #f566ba 100%)',
        'gradient-subtle': 'linear-gradient(135deg, #006ec7 0%, #ffffff 100%)',
        'gradient-hero': 'linear-gradient(135deg, #28dcaa 0%, #006ec7 50%, #f566ba 100%)',
        'gradient-hero-2': 'linear-gradient(135deg, #76c800 0%, #006ec7 50%, #461ebe 100%)',
        'gradient-overlay': 'linear-gradient(135deg, rgba(0, 110, 199, 0.8) 0%, rgba(40, 220, 170, 0.6) 100%)',
      },

      // Box Shadows mit adesso-Blau
      boxShadow: {
        'adesso': '0 4px 14px 0 rgba(0, 110, 199, 0.15)',
        'adesso-lg': '0 10px 40px 0 rgba(0, 110, 199, 0.2)',
      },

      // Border Radius
      borderRadius: {
        'adesso': '0.5rem', // 8px Standard
      },

      // Spacing für Logo-Schutzzone
      spacing: {
        'logo-zone': '2rem', // Anpassen basierend auf Logo-Größe
      },
    },
  },
  plugins: [],
}
```
</complete_config>

<css_variables>
**CSS Variables (Tailwind v4 Style):**

```css
/* app.css oder globals.css */
@import "tailwindcss";

@theme {
  /* Primärfarben */
  --color-adesso-blau: #006ec7;
  --color-adesso-grau: #887d75;
  --color-adesso-grau-10: #f4f3f2;
  --color-adesso-grau-20: #e9e7e5;
  --color-adesso-grau-30: #dedad8;
  --color-adesso-grau-40: #d3cecb;
  --color-adesso-grau-50: #c8c2be;
  --color-adesso-grau-60: #bdb6b1;
  --color-adesso-grau-70: #b2aaa4;
  --color-adesso-grau-80: #a79e97;
  --color-adesso-grau-90: #9c928a;

  /* Akzentfarben */
  --color-accent-gelb: #ffff00;
  --color-accent-orange: #ff9868;
  --color-accent-pink: #f566ba;
  --color-accent-violett: #461ebe;
  --color-accent-tuerkis: #28dcaa;
  --color-accent-gruen: #76c800;

  /* Schriften */
  --font-headline: 'Klavika', 'Fira Sans', system-ui, sans-serif;
  --font-body: 'ABC Marist', 'Fira Sans', system-ui, sans-serif;
}
```
</css_variables>

<utility_classes>
**Typische Verwendung:**

```html
<!-- Farben -->
<div class="bg-adesso-blau text-white">Primärer CTA</div>
<div class="bg-adesso-grau-10 text-adesso-grau">Heller Hintergrund</div>
<div class="text-accent-tuerkis">Erfolgs-Text</div>
<div class="border-adesso-blau border-2">Border</div>

<!-- Typografie -->
<h1 class="font-headline text-5xl text-adesso-blau">Headline</h1>
<p class="font-body text-base text-adesso-grau">Body Text</p>

<!-- Gradienten -->
<section class="bg-gradient-hero text-white">Hero Section</section>
<button class="bg-gradient-primary text-white">Gradient Button</button>

<!-- Kombinationen -->
<div class="bg-adesso-grau-10 p-6 rounded-adesso shadow-adesso">
  <h2 class="font-headline text-2xl text-adesso-blau mb-4">Card Title</h2>
  <p class="font-body text-adesso-grau">Card content...</p>
</div>
```
</utility_classes>

<component_examples>
**Button-Komponenten:**

```html
<!-- Primary Button -->
<button class="
  bg-adesso-blau
  text-white
  font-headline
  px-6 py-3
  rounded-adesso
  hover:bg-adesso-blau/90
  transition-colors
">
  Primary Action
</button>

<!-- Secondary Button -->
<button class="
  bg-transparent
  text-adesso-blau
  font-headline
  px-6 py-3
  rounded-adesso
  border-2 border-adesso-blau
  hover:bg-adesso-blau hover:text-white
  transition-colors
">
  Secondary Action
</button>

<!-- Gradient Button -->
<button class="
  bg-gradient-primary
  text-white
  font-headline
  px-6 py-3
  rounded-adesso
  hover:opacity-90
  transition-opacity
">
  Gradient Action
</button>
```

**Card-Komponente:**

```html
<div class="bg-white rounded-adesso shadow-adesso overflow-hidden">
  <div class="bg-gradient-subtle p-6">
    <h3 class="font-headline text-xl text-white">Card Header</h3>
  </div>
  <div class="p-6">
    <p class="font-body text-adesso-grau">Card content goes here.</p>
    <button class="mt-4 text-adesso-blau font-headline flex items-center gap-2">
      Learn more
      <i class="fa-thin fa-arrow-right"></i>
    </button>
  </div>
</div>
```

**Hero Section:**

```html
<section class="bg-gradient-hero py-24 px-6">
  <div class="max-w-4xl mx-auto text-center">
    <h1 class="font-headline text-5xl md:text-6xl text-white mb-6">
      GROW TOGETHER
    </h1>
    <p class="font-body text-xl text-white/90 mb-8">
      Subtitle text goes here
    </p>
    <button class="
      bg-white
      text-adesso-blau
      font-headline
      px-8 py-4
      rounded-adesso
      hover:bg-adesso-grau-10
      transition-colors
    ">
      Get Started
    </button>
  </div>
</section>
```
</component_examples>

<validation_checklist>
**Tailwind-Konfiguration validieren:**

- [ ] Alle adesso-Farben definiert (Blau, Grau + Tints, 6 Akzentfarben)
- [ ] Keine Standard-Tailwind-Farben (blue-500, gray-200, etc.) in Verwendung
- [ ] Font-Families für headline und body konfiguriert
- [ ] Gradienten mit adesso-Blau definiert
- [ ] Keine unerlaubten Farb-Tints (z.B. adesso-blau-50)
- [ ] Box-Shadows mit adesso-Blau
- [ ] Border-Radius konsistent
</validation_checklist>
