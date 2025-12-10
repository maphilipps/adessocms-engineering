# Quartz Shadow DOM CSS - Complete Reference

**Source:** Extracted from https://quartz.1xinternet.de (v6.0.1)
**Purpose:** Exact CSS for cloning Quartz Web Components

---

## 🚨 CRITICAL: How to Use This Reference

Quartz uses **LitElement Web Components** with Shadow DOM encapsulation.
The CSS below is the ACTUAL internal styling that cannot be accessed via DevTools inspection.

**To clone a component:**
1. Copy the Shadow DOM CSS into your component's `<style>` tag
2. Use the exact HTML structure from the templates
3. Apply the same CSS Custom Properties (theme variables)

---

## 1. qz-button - Shadow DOM CSS

```css
/* Base Button Styles */
[type="button"] {
  -webkit-box-align: center;
  -webkit-box-pack: center;
  align-items: center;
  background-color: var(--theme-primary);
  border-color: transparent;
  border-radius: 4px;
  border-style: solid;
  border-width: 2px;
  color: var(--theme-primary-fg);
  cursor: pointer;
  display: inline-flex;
  font-size: 0.75rem;
  font-weight: 700;
  justify-content: center;
  letter-spacing: 1.5px;
  line-height: 1rem;
  min-height: 2.75rem;
  padding-left: 1.5rem;
  padding-right: 1.5rem;
  text-decoration-line: none;
  text-transform: uppercase;
  transition-duration: 0.15s;
  transition-property: all;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  white-space: nowrap;
}

/* Focus State */
[type="button"]:focus {
  outline: transparent solid 2px;
  outline-offset: 2px;
}

[type="button"]:focus-visible {
  --tw-shadow: 0 0 0 3px #c9b9fe;
  --tw-shadow-colored: 0 0 0 3px var(--tw-shadow-color);
  box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
}

/* Hover State */
[type="button"]:hover {
  background-color: var(--theme-primary-hover);
}

/* Active State */
[type="button"]:active {
  background-color: var(--theme-primary-active);
}

/* Disabled State */
[type="button"]:disabled {
  cursor: not-allowed;
  opacity: 0.5;
}

/* Secondary Variant */
:host([secondary]) [type="button"] {
  background-color: var(--theme-secondary);
  color: var(--theme-secondary-fg);
}

:host([secondary]) [type="button"]:hover {
  background-color: var(--theme-secondary-hover);
}

/* Ghost Variant */
:host([ghost]) [type="button"] {
  background-color: transparent;
  color: var(--theme-text);
}

:host([ghost]) [type="button"]:hover {
  background-color: var(--theme-background-light);
}

/* Outline Variant */
:host([outline]) [type="button"] {
  background-color: transparent;
  border-color: currentcolor;
  border-width: 2px;
  color: var(--theme-text);
}

:host([outline]) [type="button"]:hover {
  background-color: var(--theme-primary);
  border-color: var(--theme-primary);
  color: var(--theme-primary-fg);
}

/* Menu Variant */
:host([menu]) [type="button"] {
  background-color: transparent;
  border-radius: 0px;
  color: var(--theme-text);
  min-height: auto;
  padding: 0.5rem 0px;
  text-transform: none;
}

/* Back Variant */
:host([back]) [type="button"] {
  background-color: transparent;
  color: var(--theme-text);
  font-weight: 400;
  padding-left: 0px;
}

/* Size: Small */
:host([size="small"]) [type="button"] {
  font-size: 0.625rem;
  line-height: 0.75rem;
  min-height: 1.875rem;
  padding-left: 1rem;
  padding-right: 1rem;
}

/* Size: Medium */
:host([size="medium"]) [type="button"] {
  font-size: 0.688rem;
  line-height: 0.875rem;
  min-height: 2.375rem;
  padding-left: 1.25rem;
  padding-right: 1.25rem;
}

/* Social Media Buttons */
:host([facebook]) [type="button"] {
  --tw-bg-opacity: 1;
  background-color: rgb(24 119 242 / var(--tw-bg-opacity));
}

:host([twitter]) [type="button"] {
  --tw-bg-opacity: 1;
  background-color: rgb(29 161 242 / var(--tw-bg-opacity));
}

:host([linkedin]) [type="button"] {
  --tw-bg-opacity: 1;
  background-color: rgb(10 102 194 / var(--tw-bg-opacity));
}

:host([youtube]) [type="button"] {
  --tw-bg-opacity: 1;
  background-color: rgb(255 0 0 / var(--tw-bg-opacity));
}

:host([whatsapp]) [type="button"] {
  --tw-bg-opacity: 1;
  background-color: rgb(37 211 102 / var(--tw-bg-opacity));
}

/* Icon Variants */
:host([icon-only]) [type="button"] {
  min-width: 2.75rem;
  padding: 0px;
}

:host([icon-only][size="small"]) [type="button"] {
  min-width: 1.875rem;
}

:host([icon-only][size="medium"]) [type="button"] {
  min-width: 2.375rem;
}

/* Icon Spacing */
::slotted([slot="start"]), qz-icon:first-child, svg:first-child {
  margin-right: 0.5rem;
}

::slotted([slot="end"]), qz-icon:last-child, svg:last-child {
  margin-left: 0.5rem;
}

:host([icon-only]) ::slotted([slot="start"]),
:host([icon-only]) ::slotted([slot="end"]),
:host([icon-only]) qz-icon {
  margin: 0px;
}

/* Full Width */
:host([full]) {
  width: 100%;
}

:host([full]) [type="button"] {
  width: 100%;
}
```

---

## 2. qz-card - Shadow DOM CSS

```css
:host {
  display: block;
}

.card {
  --tw-bg-opacity: 1;
  background-color: rgb(255 255 255 / var(--tw-bg-opacity));
  border-radius: 4px;
  display: flex;
  flex-direction: column;
  height: 100%;
  overflow: hidden;
  position: relative;
}

.card__content {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  padding: 2rem;
}

.card__media {
  overflow: hidden;
  position: relative;
  transition-duration: 0.5s;
  transition-property: transform;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

.card__action {
  margin-top: auto;
}

/* No Image Variant */
:host([variant="no-image"]) .card__media {
  display: none;
}

/* Full Image Variant */
:host([variant="full-image"]) .card {
  --tw-text-opacity: 1;
  color: rgb(255 255 255 / var(--tw-text-opacity));
}

:host([variant="full-image"]) .card__media {
  bottom: 0px;
  left: 0px;
  position: absolute;
  right: 0px;
  top: 0px;
}

:host([variant="full-image"]) .card__media img {
  height: 100%;
  object-fit: cover;
  width: 100%;
}

:host([variant="full-image"]) .card__content {
  background-image: linear-gradient(to bottom, transparent, #000);
  bottom: 0px;
  justify-content: flex-end;
  position: absolute;
  width: 100%;
  z-index: 10;
}

/* Compact Variant */
:host([variant="compact"]) .card__content {
  padding: 1rem;
}

/* Horizontal Variant */
:host([variant="horizontal"]) .card {
  flex-direction: row;
}

:host([variant="horizontal"]) .card__media {
  flex-shrink: 0;
  width: 33.333333%;
}

:host([variant="horizontal"]) .card__content {
  width: 66.666667%;
}

/* Animation: Brighter on Hover */
:host([animate-brighter]) .card:hover {
  filter: brightness(1.1);
}

/* Animation: Dimmer on Hover */
:host([animate-dimmer]) .card:hover {
  filter: brightness(0.9);
}

/* Animation: Expand on Hover */
:host([animate-expand]) .card:hover {
  transform: scale(1.02);
}

/* Animation: Up on Hover */
:host([animate-up]) .card:hover {
  transform: translateY(-0.5rem);
}

/* Animation: Zoom Media on Hover */
:host([animate-zoom]) .card__media {
  overflow: hidden;
}

:host([animate-zoom]) .card:hover .card__media img {
  transform: scale(1.05);
  transition-duration: 0.5s;
}

/* Link Overlay */
.card__link {
  bottom: 0px;
  left: 0px;
  position: absolute;
  right: 0px;
  top: 0px;
  z-index: 20;
}

.card__link:focus {
  outline: transparent solid 2px;
  outline-offset: 2px;
}

.card__link:focus-visible {
  --tw-shadow: 0 0 0 3px #c9b9fe;
  box-shadow: inset var(--tw-shadow);
}
```

---

## 3. qz-accordion - CSS (Global + Shadow DOM)

```css
/* Shadow DOM (minimal) */
:host {
  display: block;
}

:host(:focus) {
  outline: transparent solid 2px;
  outline-offset: 2px;
}

.accordion {
  display: flex;
  flex-direction: column;
}

:host mark {
  background-color: var(--theme-accent-light);
}

/* Global CSS (for accordion items) */
qz-accordion [data-part="invoker"] {
  padding-bottom: 1.5rem;
  padding-top: 1.5rem;
  --tw-border-opacity: 1 !important;
  border-color: rgb(246 245 244 / var(--tw-border-opacity)) !important;
  border-top-width: 1px !important;
  color: currentcolor !important;
  margin-bottom: 0px !important;
}

qz-accordion article:first-of-type [data-part="invoker"] {
  border-width: 0px !important;
}

qz-accordion [data-part="invoker"] button {
  -webkit-box-align: center;
  -webkit-box-pack: justify;
  align-items: center;
  display: flex;
  font-size: 1.25rem;
  font-weight: 500;
  justify-content: space-between;
  line-height: 1.75rem;
  text-align: left;
  width: 100%;
}

qz-accordion [data-part="invoker"] button:focus {
  outline: transparent solid 2px;
  outline-offset: 2px;
}

qz-accordion [data-part="invoker"] button:focus-visible {
  --tw-shadow: 0 0 0 3px #c9b9fe;
  border-radius: 4px;
  box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
}

/* Accordion Icon Toggle */
qz-accordion [data-part="invoker"] qz-icon {
  pointer-events: none;
}

qz-accordion [data-part="invoker"] qz-icon[opener] {
  display: block;
}

qz-accordion [data-part="invoker"] qz-icon[closer] {
  display: none;
}

qz-accordion [data-part="invoker"][expanded] qz-icon[opener] {
  display: none;
}

qz-accordion [data-part="invoker"][expanded] qz-icon[closer] {
  display: block;
}

/* Accordion Content Animation */
qz-accordion [data-part="content"] {
  margin: 0px;
  max-height: 0px;
  opacity: 0;
  overflow-y: hidden;
  transition-duration: 0.5s;
  transition-property: all;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

qz-accordion [data-part="content"][expanded] {
  color: currentcolor;
  margin-bottom: 1.5rem;
  max-height: 9999px;
  opacity: 1;
  overflow-y: visible;
}
```

---

## 4. qz-icon - Shadow DOM CSS

```css
:host {
  display: inline-block;
  flex-shrink: 0;
}

.icon {
  -webkit-box-align: center;
  -webkit-box-pack: center;
  align-items: center;
  color: currentcolor;
  display: flex;
  flex-shrink: 0;
  justify-content: center;
}

svg {
  width: 100%;
}

/* Hover Variant */
:host([hover]) .icon {
  color: var(--theme-primary);
}

:host([hover]) .icon:hover {
  color: var(--theme-accent);
}

/* Color Variants */
:host([color="brand"]) .icon {
  color: var(--theme-primary);
}

:host([color="light"]) .icon {
  color: var(--theme-secondary);
}

:host([color="gray"]) .icon {
  --tw-text-opacity: 1;
  color: rgb(175 175 170 / var(--tw-text-opacity));
}

:host([color="accent"]) .icon {
  color: var(--theme-accent);
}

:host([color="white"]) .icon {
  --tw-text-opacity: 1;
  color: rgb(255 255 255 / var(--tw-text-opacity));
}

/* Circle Wrapper */
.circle {
  -webkit-box-align: center;
  -webkit-box-pack: center;
  align-items: center;
  background-color: var(--theme-primary);
  border-color: var(--theme-primary-fg);
  border-radius: 9999px;
  display: flex;
  justify-content: center;
}

/* Circle Fill Colors */
:host([circle-fill-color="primary"]) .circle {
  background-color: var(--theme-primary);
  color: var(--theme-primary-fg);
}

:host([circle-fill-color="secondary"]) .circle {
  background-color: var(--theme-secondary);
  color: var(--theme-secondary-fg);
}

:host([circle-fill-color="accent"]) .circle {
  background-color: var(--theme-accent);
}

:host([circle-fill-color="accent-medium"]) .circle {
  background-color: var(--theme-accent-medium);
}

:host([circle-fill-color="accent-light"]) .circle {
  background-color: var(--theme-accent-light);
}

/* Social Media Circle Colors */
:host([circle-fill-color="facebook"]) .circle {
  --tw-bg-opacity: 1;
  background-color: rgb(24 119 242 / var(--tw-bg-opacity));
}

:host([circle-fill-color="twitter"]) .circle {
  --tw-bg-opacity: 1;
  background-color: rgb(29 161 242 / var(--tw-bg-opacity));
}

:host([circle-fill-color="youtube"]) .circle {
  --tw-bg-opacity: 1;
  background-color: rgb(255 0 0 / var(--tw-bg-opacity));
}

:host([circle-fill-color="black"]) .circle {
  --tw-bg-opacity: 1;
  background-color: rgb(0 0 0 / var(--tw-bg-opacity));
}

:host([circle-fill-color="white"]) .circle {
  --tw-bg-opacity: 1;
  background-color: rgb(255 255 255 / var(--tw-bg-opacity));
}

/* Circle Border Colors */
:host([circle-border-color="primary"]) .circle {
  border-color: var(--theme-primary);
}

:host([circle-border-color="secondary"]) .circle {
  border-color: var(--theme-secondary);
}

:host([circle-border-color="accent"]) .circle {
  border-color: var(--theme-accent);
}

:host([circle-border-color="facebook"]) .circle {
  --tw-border-opacity: 1;
  border-color: rgb(24 119 242 / var(--tw-border-opacity));
}

:host([circle-border-color="twitter"]) .circle {
  --tw-border-opacity: 1;
  border-color: rgb(29 161 242 / var(--tw-border-opacity));
}
```

---

## 5. qz-media-text - Shadow DOM CSS

```css
:host {
  display: block;
}

@media (min-width: 1024px) {
  .media-text {
    -webkit-box-align: center;
    -webkit-box-pack: justify;
    align-items: center;
    display: flex;
    justify-content: space-between;
  }
}

.media-text__content {
  padding-top: 2rem;
}

@media (min-width: 1024px) {
  .media-text__content {
    padding-left: 0.5rem;
    padding-top: 0px;
    width: 41.6667%;
  }

  .media-text__media {
    padding-right: 0.5rem;
    width: 50%;
  }

  /* Right Aligned Media */
  :host([media-align="right"]) .media-text__content {
    padding-left: 0px;
    padding-right: 0.5rem;
  }

  :host([media-align="right"]) .media-text__media {
    -webkit-box-ordinal-group: 2;
    order: 1;
    padding-right: 0px;
    padding-left: 0.5rem;
  }
}

.media__caption {
  display: block;
  font-size: 0.875rem;
  line-height: 1.25rem;
  padding-top: 1rem;
}

/* Global CSS for video/iframe handling */
qz-media-text [slot="media"] {
  min-height: 100%;
}

qz-media-text iframe,
qz-media-text video {
  --tw-ring-color: transparent;
  aspect-ratio: 16 / 9;
  height: 100%;
  max-width: none;
  object-fit: cover;
  outline: transparent solid 2px;
  outline-offset: 2px;
  width: 100%;
}

qz-media-text iframe:focus-visible,
qz-media-text video:focus-visible {
  --tw-shadow: 0 0 0 3px #c9b9fe;
  border-radius: 4px;
  box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow, 0 0 #0000);
}
```

---

## 6. Motion / Animation System

### Keyframes

```css
@keyframes spin {
  100% { transform: rotate(1turn); }
}

@keyframes ping {
  75%, 100% { opacity: 0; transform: scale(2); }
}

@keyframes pulse {
  50% { opacity: 0.5; }
}

@keyframes bounce {
  0%, 100% {
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
    transform: translateY(-25%);
  }
  50% {
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
    transform: none;
  }
}

@keyframes fade-in {
  0% { opacity: 0; }
  100% { opacity: 1; }
}

@keyframes fade-out {
  0% { opacity: 1; }
  100% { opacity: 0; }
}

@keyframes advance {
  0% { width: 0px; }
  100% { width: 100%; }
}

@keyframes retreat {
  0% { width: 100%; }
  100% { width: 0px; }
}

@keyframes slide-in {
  0% { transform: translateX(100%); }
  100% { transform: translateX(0px); }
}

@keyframes slide-out {
  0% { transform: translateX(0px); }
  100% { transform: translateX(100%); }
}

@keyframes woosh {
  40%, 60% { left: 0px; right: 0px; }
  90%, 100% { left: 100%; right: 0px; }
}
```

### Animation Classes

| Name | Class | Value |
|------|-------|-------|
| none | `animate-none` | `none` |
| spin | `animate-spin` | `spin 1s linear infinite` |
| ping | `animate-ping` | `ping 1s cubic-bezier(0, 0, 0.2, 1) infinite` |
| pulse | `animate-pulse` | `pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite` |
| bounce | `animate-bounce` | `bounce 1s infinite` |
| fade-in | `animate-fade-in` | `fade-in 200ms ease-out forwards` |
| fade-out | `animate-fade-out` | `fade-out 200ms ease-in forwards` |
| advance | `animate-advance` | `advance 10s linear forwards` |
| retreat | `animate-retreat` | `retreat 10s linear forwards` |
| slide-in | `animate-slide-in` | `slide-in 400ms linear forwards` |
| slide-out | `animate-slide-out` | `slide-out 400ms linear forwards` |
| woosh | `animate-woosh` | `woosh 2s cubic-bezier(0, 0.5, 0, 1) infinite` |

### Group Hover Animations

All animations can be triggered on group hover:
```css
.group:hover .group-hover\:animate-fade-in { animation: 0.2s ease-out forwards fade-in; }
.group:hover .group-hover\:animate-bounce { animation: 1s ease infinite bounce; }
/* etc. */
```

---

## 7. CSS Custom Properties (Theme Variables)

These variables MUST be defined for components to work:

```css
:root {
  /* Primary Colors */
  --theme-primary: #6366f1;
  --theme-primary-fg: #ffffff;
  --theme-primary-hover: #4f46e5;
  --theme-primary-active: #4338ca;

  /* Secondary Colors */
  --theme-secondary: #e5e7eb;
  --theme-secondary-fg: #1f2937;
  --theme-secondary-hover: #d1d5db;

  /* Accent Colors */
  --theme-accent: #f59e0b;
  --theme-accent-medium: #fbbf24;
  --theme-accent-light: #fef3c7;

  /* Text & Background */
  --theme-text: #232222;
  --theme-background: #ffffff;
  --theme-background-light: #f6f5f4;

  /* Focus Ring */
  --focus-ring-color: #c9b9fe;
}
```

---

## Usage Example: Cloning qz-button in SDC

```twig
{# button.twig #}
<button
  type="button"
  class="qz-button {{ variant ? 'qz-button--' ~ variant : '' }} {{ size ? 'qz-button--' ~ size : '' }}"
  {% if disabled %}disabled{% endif %}
>
  {% if icon_start %}
    <span class="qz-button__icon qz-button__icon--start">{{ icon_start }}</span>
  {% endif %}
  {{ label }}
  {% if icon_end %}
    <span class="qz-button__icon qz-button__icon--end">{{ icon_end }}</span>
  {% endif %}
</button>

<style>
/* Copy the qz-button CSS from above, replacing :host([...]) with .qz-button--... */
.qz-button {
  /* Base styles from [type="button"] */
}
.qz-button--secondary { /* ... */ }
.qz-button--ghost { /* ... */ }
.qz-button--small { /* ... */ }
/* etc. */
</style>
```
