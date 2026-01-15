# Quartz Design System - Complete Tailwind Configuration

Reference: https://quartz.1xinternet.de (Storybook v6.0.1)

---

## 🚨 CRITICAL: Architecture Overview

**Quartz uses a HYBRID architecture - understanding this is essential for cloning!**

### Tech Stack
- **Web Components**: LitElement-based custom elements (`qz-*`)
- **Styling**: Shadow DOM encapsulation + Tailwind CSS utilities
- **Build**: Storybook for documentation

### Styling Architecture

```
┌─────────────────────────────────────────────────────────────┐
│  <section class="section" data-width="..." data-theme="...">│  ← Tailwind + data attributes
│    <div class="section-inner">                              │  ← Tailwind utilities
│      <qz-accordion>                                         │  ← Web Component (Shadow DOM)
│        <article>                                            │  ← Light DOM slot content
│          <h3 data-part="invoker">...</h3>                   │  ← Slot with data attributes
│        </article>                                           │
│      </qz-accordion>                                        │
│    </div>                                                   │
│  </section>                                                 │
└─────────────────────────────────────────────────────────────┘
```

### Where Tailwind Classes ARE Used

| Location | Example Classes | Purpose |
|----------|-----------------|---------|
| Section wrapper | `section`, `section-inner` | Layout containers |
| Content elements | `flex`, `items-center`, `gap-4` | Flexbox/Grid layouts |
| Card wrappers | `max-w-sm`, `min-h-card` | Size constraints |
| Images | `lazyload` | Lazy loading |
| Typography in content | `text-lg`, `font-bold` | Text styling |

### Where Styling is in Shadow DOM (NOT Tailwind)

| Component | Styled Internally |
|-----------|-------------------|
| `<qz-button>` | All button variants, sizes, states |
| `<qz-accordion>` | Expand/collapse animation, icons |
| `<qz-card>` | Card layout, hover effects |
| `<qz-icon>` | Icon sizing, colors |
| `<qz-media>` | Media container, aspect ratios |
| `<qz-tabs>` | Tab navigation, active states |

### Implication for Cloning

**To clone Quartz, you need BOTH:**
1. ✅ Tailwind config (this document) for utilities
2. ✅ Web Component implementations (LitElement) OR equivalent SDC components

**For Drupal/SDC approach:**
- Replace `qz-*` Web Components with Drupal SDC components
- Use Twig templates instead of LitElement Shadow DOM
- Apply equivalent CSS directly in component stylesheets
- Keep the same data-attribute pattern for sections

---

## Typography

### Font Family
```js
// tailwind.config.js
fontFamily: {
  sans: ['"geomanist"', 'ui-sans-serif', 'system-ui', '-apple-system', 'BlinkMacSystemFont', '"Segoe UI"', 'Roboto', '"Helvetica Neue"', 'Arial', '"Noto Sans"', 'sans-serif', '"Apple Color Emoji"', '"Segoe UI Emoji"', '"Segoe UI Symbol"', '"Noto Color Emoji"'],
  heading: ['"geomanist"', 'ui-sans-serif', 'system-ui', '-apple-system', 'BlinkMacSystemFont', '"Segoe UI"', 'Roboto', '"Helvetica Neue"', 'Arial', '"Noto Sans"', 'sans-serif']
}
```

### Font Weight
| Name | Value | Class |
|------|-------|-------|
| light | 300 | `font-light` |
| normal | 400 | `font-normal` |
| medium | 500 | `font-medium` |
| bold | 700 | `font-bold` |

### Font Size
| Name | rem | px | Class |
|------|-----|-----|-------|
| 3xs | 0.625rem | 10px | `text-3xs` |
| 2xs | 0.688rem | 11px | `text-2xs` |
| xs | 0.75rem | 12px | `text-xs` |
| sm | 0.875rem | 14px | `text-sm` |
| base | 1rem | 16px | `text-base` |
| lg | 1.125rem | 18px | `text-lg` |
| xl | 1.25rem | 20px | `text-xl` |
| 2xl | 1.5rem | 24px | `text-2xl` |
| 3xl | 1.875rem | 30px | `text-3xl` |
| 4xl | 2.25rem | 36px | `text-4xl` |
| 5xl | 3rem | 48px | `text-5xl` |
| 6xl | 3.75rem | 60px | `text-6xl` |
| 7xl | 4.5rem | 72px | `text-7xl` |
| 8xl | 6rem | 96px | `text-8xl` |
| 9xl | 8rem | 128px | `text-9xl` |

### Button Links
```html
<!-- Default Button -->
<a class="button" href="#">Button</a>

<!-- Outline Button -->
<a class="button button-outline" href="#">Outline Button</a>
```

---

## Color System

### Base Colors
| Name | Hex | Class |
|------|-----|-------|
| Base White | #fff | `bg-base-white` |
| Base Black | #000 | `bg-base-black` |

### Theme Colors (CSS Variables)
| Name | CSS Variable | Class |
|------|--------------|-------|
| Theme Primary | var(--theme-primary) | `bg-theme-primary` |
| Theme Primary FG | var(--theme-primary-fg) | `text-theme-primary-fg` |
| Theme Secondary | var(--theme-secondary) | `bg-theme-secondary` |
| Theme Secondary FG | var(--theme-secondary-fg) | `text-theme-secondary-fg` |
| Theme Accent | var(--theme-accent) | `bg-theme-accent` |
| Theme Accent Medium | var(--theme-accent-medium) | `bg-theme-accent-medium` |
| Theme Accent Light | var(--theme-accent-light) | `bg-theme-accent-light` |
| Theme Text | var(--theme-text) | `text-theme-text` |

### Neutral Colors
| Name | Hex | RGB | HSL |
|------|-----|-----|-----|
| Lighter | #FDFDFC | rgb(253,253,252) | hsl(60, 20%, 99%) |
| Light | #F6F5F4 | rgb(246,245,244) | hsl(30, 9%, 96%) |
| Medium | #AFAFAA | rgb(175,175,170) | hsl(60, 3%, 67%) |
| Dark | #737571 | rgb(115,117,113) | hsl(89, 1%, 45%) |

### Status Colors
| Status | Variant | Hex | RGB | HSL |
|--------|---------|-----|-----|-----|
| Success | Lighter | #E6F9EC | rgb(230,249,236) | hsl(138, 61%, 93%) |
| Success | Light | #B5ECC5 | rgb(181,236,197) | hsl(137, 59%, 81%) |
| Success | Default | #09BF3D | rgb(9,191,61) | hsl(137, 91%, 39%) |
| Success | Dark | #06852A | rgb(6,133,42) | hsl(137, 91%, 27%) |
| Warning | Lighter | #FFF2E5 | rgb(255,242,229) | hsl(29, 100%, 94%) |
| Warning | Light | #FFD7B3 | rgb(255,215,179) | hsl(28, 100%, 85%) |
| Warning | Default | #FF7B00 | rgb(255,123,0) | hsl(28, 100%, 50%) |
| Warning | Dark | #C25D00 | rgb(194,93,0) | hsl(28, 100%, 38%) |
| Error | Lighter | #FDE6E5 | rgb(253,230,229) | hsl(2, 85%, 94%) |
| Error | Light | #F8B3B3 | rgb(248,179,179) | hsl(0, 83%, 83%) |
| Error | Default | #E60200 | rgb(230,2,0) | hsl(0, 100%, 45%) |
| Error | Dark | #A90100 | rgb(169,1,0) | hsl(0, 100%, 33%) |
| Info | Lighter | #F2F5FF | rgb(242,245,255) | hsl(226, 100%, 97%) |
| Info | Light | #9BC6CD | rgb(155,198,205) | hsl(188, 33%, 70%) |
| Info | Default | #25A0AB | rgb(37,160,171) | hsl(184, 64%, 40%) |
| Info | Dark | #1A7179 | rgb(26,113,121) | hsl(185, 64%, 28%) |

### Social Colors
| Platform | Hex | RGB | HSL |
|----------|-----|-----|-----|
| Facebook | #1877f2 | rgb(24,119,242) | hsl(213, 89%, 52%) |
| Twitter | #1da1f2 | rgb(29,161,242) | hsl(202, 89%, 53%) |
| YouTube | #ff0000 | rgb(255,0,0) | hsl(0, 100%, 50%) |

### Tailwind Config
```js
colors: {
  theme: {
    primary: {
      DEFAULT: 'var(--theme-primary)',
      fg: 'var(--theme-primary-fg)'
    },
    secondary: {
      DEFAULT: 'var(--theme-secondary)',
      fg: 'var(--theme-secondary-fg)'
    },
    accent: {
      DEFAULT: 'var(--theme-accent)',
      medium: 'var(--theme-accent-medium)',
      light: 'var(--theme-accent-light)'
    },
    text: 'var(--theme-text)'
  },
  neutral: {
    lighter: '#FDFDFC',
    light: '#F6F5F4',
    medium: '#AFAFAA',
    dark: '#737571'
  },
  status: {
    success: {
      lighter: '#E6F9EC',
      light: '#B5ECC5',
      DEFAULT: '#09BF3D',
      dark: '#06852A'
    },
    warning: {
      lighter: '#FFF2E5',
      light: '#FFD7B3',
      DEFAULT: '#FF7B00',
      dark: '#C25D00'
    },
    error: {
      lighter: '#FDE6E5',
      light: '#F8B3B3',
      DEFAULT: '#E60200',
      dark: '#A90100'
    },
    info: {
      lighter: '#F2F5FF',
      light: '#9BC6CD',
      DEFAULT: '#25A0AB',
      dark: '#1A7179'
    }
  },
  social: {
    facebook: '#1877f2',
    twitter: '#1da1f2',
    youtube: '#ff0000'
  }
}
```

---

## Responsive Breakpoints

| Screen | Threshold | Usage |
|--------|-----------|-------|
| mobile | 0px | Default (mobile-first) |
| sm | 640px | Tablet portrait |
| md | 768px | Tablet landscape |
| lg | 1024px | Laptop |
| xl | 1280px | Desktop |
| 2xl | 1536px | Wide desktop |

```js
// tailwind.config.js
screens: {
  'sm': '640px',
  'md': '768px',
  'lg': '1024px',
  'xl': '1280px',
  '2xl': '1536px'
}
```

---

## Grid System

### Column Layout by Screen
| Screen | Columns | Class |
|--------|---------|-------|
| Mobile | 4 | `grid-4` |
| Tablet (sm+) | 8 | `sm:grid-8` |
| Desktop (lg+) | 12 | `lg:grid-12` |

### Responsive Grid Pattern
```html
<div class="grid-4 sm:grid-8 lg:grid-12">
  <div class="col-span-4">Full on mobile</div>
  <div class="col-span-4 sm:col-span-4 lg:col-span-6">Half on desktop</div>
  <div class="col-span-4 sm:col-span-4 lg:col-span-6">Half on desktop</div>
</div>
```

### Default Gap
- Desktop: 2rem
- Mobile: 1rem
- Override: `!gap-4` (custom gap)

---

## Spacing Scale

| Key | rem | px | Class |
|-----|-----|-----|-------|
| 0 | 0 | 0px | `p-0`, `m-0` |
| px | 1px | 1px | `p-px`, `m-px` |
| 0.5 | 0.125rem | 2px | `p-0.5`, `m-0.5` |
| 1 | 0.25rem | 4px | `p-1`, `m-1` |
| 1.5 | 0.375rem | 6px | `p-1.5`, `m-1.5` |
| 2 | 0.5rem | 8px | `p-2`, `m-2` |
| 2.5 | 0.625rem | 10px | `p-2.5`, `m-2.5` |
| 3 | 0.75rem | 12px | `p-3`, `m-3` |
| 3.5 | 0.875rem | 14px | `p-3.5`, `m-3.5` |
| 4 | 1rem | 16px | `p-4`, `m-4` |
| 5 | 1.25rem | 20px | `p-5`, `m-5` |
| 6 | 1.5rem | 24px | `p-6`, `m-6` |
| 7 | 1.75rem | 28px | `p-7`, `m-7` |
| 8 | 2rem | 32px | `p-8`, `m-8` |
| 9 | 2.25rem | 36px | `p-9`, `m-9` |
| 10 | 2.5rem | 40px | `p-10`, `m-10` |
| 11 | 2.75rem | 44px | `p-11`, `m-11` |
| 12 | 3rem | 48px | `p-12`, `m-12` |
| 14 | 3.5rem | 56px | `p-14`, `m-14` |
| 16 | 4rem | 64px | `p-16`, `m-16` |
| 20 | 5rem | 80px | `p-20`, `m-20` |
| 24 | 6rem | 96px | `p-24`, `m-24` |
| 28 | 7rem | 112px | `p-28`, `m-28` |
| 32 | 8rem | 128px | `p-32`, `m-32` |
| 36 | 9rem | 144px | `p-36`, `m-36` |
| 40 | 10rem | 160px | `p-40`, `m-40` |
| 44 | 11rem | 176px | `p-44`, `m-44` |
| 48 | 12rem | 192px | `p-48`, `m-48` |
| 52 | 13rem | 208px | `p-52`, `m-52` |
| 56 | 14rem | 224px | `p-56`, `m-56` |
| 60 | 15rem | 240px | `p-60`, `m-60` |
| 64 | 16rem | 256px | `p-64`, `m-64` |
| 72 | 18rem | 288px | `p-72`, `m-72` |
| 80 | 20rem | 320px | `p-80`, `m-80` |
| 96 | 24rem | 384px | `p-96`, `m-96` |

---

## Box Shadows

| Name | Value | Class |
|------|-------|-------|
| none | none | `shadow-none` |
| small | 0 0 6px 0 rgba(0, 0, 0, 0.15) | `shadow-small` |
| regular | 0 0 10px 0 rgba(0, 0, 0, 0.15) | `shadow-regular` |
| large | 0 0 14px 0 rgba(0, 0, 0, 0.15) | `shadow-large` |
| focus | 0 0 0 3px #c9b9fe | `shadow-focus` |
| focus-button | 0 0 0 7px #c9b9fe | `shadow-focus-button` |
| accent | inset 8px 0 0 0 | `shadow-accent` |
| input | inset 0px 1px 2px 0px #dedcd6 | `shadow-input` |

```js
// tailwind.config.js
boxShadow: {
  none: 'none',
  small: '0 0 6px 0 rgba(0, 0, 0, 0.15)',
  regular: '0 0 10px 0 rgba(0, 0, 0, 0.15)',
  large: '0 0 14px 0 rgba(0, 0, 0, 0.15)',
  focus: '0 0 0 3px #c9b9fe',
  'focus-button': '0 0 0 7px #c9b9fe',
  accent: 'inset 8px 0 0 0',
  input: 'inset 0px 1px 2px 0px #dedcd6'
}
```

---

## Border Radius

| Name | Value | Class | Usage |
|------|-------|-------|-------|
| none | 0 | `rounded-none` | Override existing radius |
| DEFAULT | 4px | `rounded` | Buttons, forms, labels |
| large | 8px | `rounded-large` | Cards, tooltips |
| full | 9999px | `rounded-full` | Circles, pills |

```js
// tailwind.config.js
borderRadius: {
  none: '0',
  DEFAULT: '4px',
  large: '8px',
  full: '9999px'
}
```

---

## Opacity

| Value | Class |
|-------|-------|
| 0% | `opacity-0` |
| 20% | `opacity-20` |
| 40% | `opacity-40` |
| 60% | `opacity-60` |
| 80% | `opacity-80` |
| 100% | `opacity-100` |

---

## Section Component Attributes

### data-width Options
| Value | Description | Max-width |
|-------|-------------|-----------|
| Default | Content width | ~1024px |
| Narrow | Text width | ~768px |
| Wide | Extended content | ~1280px |
| Full | Full screen | 100% |

### data-spacing Options
| Value | Description |
|-------|-------------|
| None | No spacing |
| top-small | Small top padding (~2rem) |
| bottom-small | Small bottom padding (~2rem) |
| top-large | Large top padding (~4rem) |
| bottom-large | Large bottom padding (~4rem) |
| top-small bottom-small | Both small |
| top-large bottom-large | Both large |
| top-small bottom-large | Mixed |
| top-large bottom-small | Mixed |

### data-theme Options
| Value | Description |
|-------|-------------|
| None | Default/transparent |
| Light | Light background (secondary color) |
| Dark | Dark background (primary color + light text) |

### content-padding Options
| Value | Description |
|-------|-------------|
| Inner (default) | Standard horizontal padding |
| None | No horizontal padding |
| Outer | Extended horizontal padding |

---

## Section CSS Implementation

```css
/* Width variants */
.section[data-width="full"] { max-width: 100%; }
.section[data-width="wide"] { max-width: 1280px; }
.section[data-width="default"] { max-width: 1024px; }
.section[data-width="narrow"] { max-width: 768px; }

/* Spacing variants */
.section[data-spacing*="top-small"] { padding-top: 2rem; }
.section[data-spacing*="top-large"] { padding-top: 4rem; }
.section[data-spacing*="bottom-small"] { padding-bottom: 2rem; }
.section[data-spacing*="bottom-large"] { padding-bottom: 4rem; }

/* Theme variants */
.section[data-theme="light"] {
  background-color: var(--theme-secondary);
  color: var(--theme-secondary-fg);
}
.section[data-theme="dark"] {
  background-color: var(--theme-primary);
  color: var(--theme-primary-fg);
}

/* Section inner wrapper */
.section-inner {
  margin: 0 auto;
  padding-left: 1rem;
  padding-right: 1rem;
}

@media (min-width: 640px) {
  .section-inner {
    padding-left: 2rem;
    padding-right: 2rem;
  }
}
```

---

## Component-Specific Patterns

### Accordion
```html
<qz-accordion search="true" singleExpand="false">
  <article>
    <h3 data-part="invoker">
      <button>
        Title
        <qz-icon name="plus" opener></qz-icon>
        <qz-icon name="minus" closer></qz-icon>
      </button>
    </h3>
    <div data-part="content">
      <p>Content here...</p>
    </div>
  </article>
</qz-accordion>
```

### Image Text
```html
<qz-media-text media-align="left" has-caption="false">
  <article slot="media">
    <img alt="Example" loading="lazy" src="image.jpg" />
  </article>
  <div slot="caption">Caption text</div>
  <h3>Heading</h3>
  <p>Content here...</p>
</qz-media-text>
```

### Section Wrapper
```html
<section class="section" data-spacing="top-large bottom-large" data-width="default" data-theme="light">
  <div class="section-inner">
    <!-- Content -->
  </div>
</section>
```

---

## Font Loading

```css
/* src/assets/fonts/ */
@font-face {
  font-family: 'geomanist';
  font-style: normal;
  font-weight: 500;
  font-display: swap;
  src: local('Geomanist Medium'),
       url('./assets/fonts/geomanist-medium-webfont.woff2') format('woff2'),
       url('./assets/fonts/geomanist-medium-webfont.woff') format('woff'),
       url('./assets/fonts/geomanist-medium-webfont.ttf') format('truetype');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}
```

---

## Complete Web Component Reference

### Atoms (qz-*)

| Component | Attributes | Slots |
|-----------|------------|-------|
| `qz-button` | `variant`, `size`, `disabled`, `loading`, `icon-only` | default, `icon` |
| `qz-badge` | `variant`, `size` | default |
| `qz-icon` | `name`, `color`, `size` | - |
| `qz-link` | `href`, `animated`, `external` | default |
| `qz-spinner` | `size` | - |
| `qz-tooltip` | `position`, `text` | default |
| `qz-backdrop` | `visible` | - |
| `qz-drawer` | `open`, `position` | default |
| `qz-overlay` | `visible` | default |
| `qz-divider` | `orientation` | - |
| `qz-lazy` | - | default |

### Molecules (qz-*)

| Component | Attributes | Slots |
|-----------|------------|-------|
| `qz-accordion` | `search`, `singleExpand` | default (articles) |
| `qz-card` | `label`, `level`, `has-action`, `variant` | `media`, `action`, default |
| `qz-tabs` | - | default (qz-tab) |
| `qz-tab` | `label` | default |
| `qz-media` | `variant` | `media`, `caption` |
| `qz-media-text` | `media-align`, `has-caption` | `media`, `caption`, default |
| `qz-fact` | `number`, `prefix`, `suffix`, `decimals` | `icon`, `title`, `description` |
| `qz-dropdown` | `open` | `trigger`, default |
| `qz-message` | `variant`, `dismissible` | default |
| `qz-pager` | `current`, `total` | - |
| `qz-slide` | - | default |

### Organisms (qz-*)

| Component | Attributes | Slots |
|-----------|------------|-------|
| `qz-slider` | `autoplay`, `navigation`, `pagination` | default (qz-slide) |
| `qz-search` | `highlight`, `match-all` | default |
| `qz-mobile-menu` | `open` | default |
| `qz-mega-menu` | - | default |

### Search Components (qz-*)

| Component | Attributes | Slots |
|-----------|------------|-------|
| `qz-search-autocomplete` | - | default |
| `qz-search-filters` | - | default |
| `qz-search-facets` | - | default |
| `qz-search-sorter` | - | default |
| `qz-search-result` | - | default |

---

## Complete HTML Examples for Cloning

### Card with All Features
```html
<qz-card class="max-w-sm min-h-card" label="Card Title" has-action="" level="4">
  <article slot="media" alt="media">
    <img
      alt="Example"
      data-sizes="auto"
      loading="lazy"
      data-src="assets/card-sm.jpg"
      data-srcset="assets/card-sm.jpg 240w, assets/card-md.jpg 500w, assets/card-lg.jpg 1024w"
      class="lazyload"
      src="data:image/jpeg;base64,..."
    />
  </article>
  <p>Card description text goes here.</p>
  <qz-link animated="" slot="action" href="#">Read more</qz-link>
</qz-card>
```

### Accordion with Search
```html
<section class="section" data-width="default" data-spacing="top-large bottom-large">
  <div class="section-inner">
    <qz-search highlight="" match-all="">
      <qz-accordion search="true" singleExpand="false">
        <article>
          <h3 data-part="invoker" style="order: 1;">
            <button id="invoker-xxx" aria-controls="content-xxx" aria-expanded="false">
              Question Title
              <qz-icon name="plus" color="gray" opener="" aria-hidden="true"></qz-icon>
              <qz-icon name="minus" color="gray" closer="" aria-hidden="true"></qz-icon>
            </button>
          </h3>
          <div data-part="content" content-height="56" id="content-xxx" style="max-height: 0px; order: 1;">
            <p>Answer content here.</p>
          </div>
        </article>
      </qz-accordion>
    </qz-search>
  </div>
</section>
```

### Facts/Statistics
```html
<section class="section" data-width="default" data-spacing="top-large bottom-large" data-theme="dark">
  <div class="section-inner">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <qz-fact prefix="$" suffix="M" number="150" decimals="1">
        <img slot="icon" src="icon.svg" alt="" />
        <span slot="title">Revenue</span>
        <span slot="description">Annual growth rate</span>
      </qz-fact>
    </div>
  </div>
</section>
```

### Media Text (Side-by-Side)
```html
<section class="section" data-width="wide" data-spacing="top-large bottom-large">
  <div class="section-inner">
    <qz-media-text media-align="left" has-caption="false">
      <article slot="media">
        <img alt="Feature image" loading="lazy" src="image.jpg" />
      </article>
      <h2>Heading</h2>
      <p>Content paragraph with description.</p>
      <qz-button>Call to Action</qz-button>
    </qz-media-text>
  </div>
</section>
```

### Tabs
```html
<section class="section" data-width="default">
  <div class="section-inner">
    <qz-tabs>
      <qz-tab label="Tab 1">
        <p>Content for tab 1</p>
      </qz-tab>
      <qz-tab label="Tab 2">
        <p>Content for tab 2</p>
      </qz-tab>
    </qz-tabs>
  </div>
</section>
```

### Slider/Carousel
```html
<section class="section" data-width="full">
  <div class="section-inner">
    <qz-slider autoplay="true" navigation="true" pagination="true">
      <qz-slide>
        <img src="slide1.jpg" alt="Slide 1" />
        <h2>Slide Title</h2>
      </qz-slide>
      <qz-slide>
        <img src="slide2.jpg" alt="Slide 2" />
        <h2>Slide Title 2</h2>
      </qz-slide>
    </qz-slider>
  </div>
</section>
```

---

## Lazy Loading Pattern

All images use lazysizes library:

```html
<img
  alt="Description"
  data-sizes="auto"
  loading="lazy"
  data-src="image.jpg"
  data-srcset="image-sm.jpg 240w, image-md.jpg 500w, image-lg.jpg 1024w"
  class="lazyload"
  src="data:image/jpeg;base64,..." <!-- Low-quality placeholder (LQIP) -->
/>
```

**Required JS:** `lazysizes` library for `data-src` → `src` swap on scroll.

---

## Icon System

Icons use `qz-icon` component with name attribute:

```html
<qz-icon name="plus" color="gray" aria-hidden="true"></qz-icon>
<qz-icon name="minus" color="gray" aria-hidden="true"></qz-icon>
<qz-icon name="arrow-right"></qz-icon>
<qz-icon name="chevron-down"></qz-icon>
<qz-icon name="search"></qz-icon>
<qz-icon name="menu"></qz-icon>
<qz-icon name="close"></qz-icon>
```

Available icon names: See Storybook → Foundation → Icons
