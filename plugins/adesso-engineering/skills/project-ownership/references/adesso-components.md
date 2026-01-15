# adesso CMS Components

Location: `web/themes/custom/adesso_cms_theme/components/`

## Current Components (33 total)

| Component | Type | Has Story | Has Schema | Status |
|-----------|------|-----------|------------|--------|
| accordion | Molecule | ? | ? | Active |
| badge | Atom | ? | ? | Active |
| bento-grid | Organism | ? | ? | Active |
| block-reference | Utility | ? | ? | Active |
| button | Atom | ? | ? | Active |
| card-group | Organism | ? | ? | Active |
| carousel | Organism | ? | ? | Active |
| download-item | Molecule | ? | ? | Active |
| embed | Utility | ? | ? | Active |
| gallery | Organism | ? | ? | Active |
| heading | Atom | ? | ? | Active |
| headline-paragraph | Molecule | ? | ? | Active |
| hero | Organism | ? | ? | Active |
| image-sidebyside | Molecule | ? | ? | Active |
| logo | Atom | ? | ? | Active |
| logo-collection | Organism | ? | ? | Active |
| main-menu | Organism | ? | ? | Active |
| media | Atom | ? | ? | Active |
| mobile-menu | Organism | ? | ? | Active |
| newsletter-form | Molecule | ? | ? | Active |
| page-header | Organism | ? | ? | Active |
| pager | Molecule | ? | ? | Active |
| pricing | Organism | ? | ? | Active |
| recent-cards | Organism | ? | ? | Active |
| sidebyside | Molecule | ? | ? | Active |
| site-footer | Region | ? | ? | Active |
| site-header | Region | ? | ? | Active |
| slider | Organism | ? | ? | Active |
| stat-card | Molecule | ? | ? | Active |
| statistic | Molecule | ? | ? | Active |
| statistic-item | Atom | ? | ? | Active |
| text | Atom | ? | ? | Active |

## Tech Stack (adesso CMS)

- **Framework**: Drupal SDC (Single Directory Components)
- **Styling**: Tailwind CSS v4
- **Components**: Flowbite
- **Docs**: Storybook with vite-plugin-twig-drupal
- **Build**: Vite

## Component Structure Standard

```
components/
└── [component-name]/
    ├── [component-name].component.yml  # Required: Schema & Props
    ├── [component-name].twig           # Required: Template
    ├── [component-name].stories.js     # Required: Storybook
    ├── [component-name].css            # Optional: Styles
    └── [component-name].js             # Optional: Behavior
```

## Categories by Type

### Atoms (Basic elements)
- badge, button, heading, logo, media, statistic-item, text

### Molecules (Combined elements)
- accordion, download-item, headline-paragraph, image-sidebyside,
  newsletter-form, pager, sidebyside, stat-card, statistic

### Organisms (Complex sections)
- bento-grid, card-group, carousel, gallery, hero, logo-collection,
  main-menu, mobile-menu, page-header, pricing, recent-cards, slider

### Regions (Page structure)
- site-footer, site-header

### Utilities
- block-reference, embed
