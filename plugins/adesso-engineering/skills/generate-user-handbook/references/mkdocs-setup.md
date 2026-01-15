<overview>
MkDocs mit Material Theme ist die Grundlage für das Benutzerhandbuch. Diese Referenz beschreibt die Konfiguration und Projektstruktur.
</overview>

<installation>
## Installation

```bash
pip install mkdocs-material mkdocs-glightbox
```

**mkdocs-material**: Das Theme mit allen Features
**mkdocs-glightbox**: Lightbox für Screenshot-Vergrößerung
</installation>

<project_structure>
## Projektstruktur

```
user-handbook/
├── mkdocs.yml              # Hauptkonfiguration
├── docs/
│   ├── index.md            # Startseite
│   ├── erste-schritte/     # Kapitel 1
│   │   ├── anmeldung.md
│   │   └── oberflaeche.md
│   ├── inhalte/            # Kapitel 2
│   │   ├── seite-erstellen.md
│   │   ├── seite-bearbeiten.md
│   │   ├── paragraphen.md
│   │   └── medien.md
│   ├── assets/
│   │   └── images/         # Alle Screenshots
│   │       ├── erste-schritte/
│   │       ├── inhalte/
│   │       └── ...
│   └── stylesheets/
│       └── extra.css       # Anpassungen
└── site/                   # Generierte HTML-Site
```
</project_structure>

<mkdocs_config>
## mkdocs.yml Konfiguration

```yaml
site_name: Benutzerhandbuch
site_description: Anleitung für Redakteure
site_author: Ihr Unternehmen

theme:
  name: material
  language: de
  palette:
    - scheme: default
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-7
        name: Dunkelmodus aktivieren
    - scheme: slate
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-4
        name: Hellmodus aktivieren
  features:
    - navigation.tabs
    - navigation.sections
    - navigation.expand
    - navigation.top
    - search.suggest
    - search.highlight
    - content.tabs.link
    - content.code.copy
  icon:
    logo: material/book-open-page-variant

plugins:
  - search:
      lang: de
  - glightbox:
      touchNavigation: true
      loop: false
      effect: zoom
      width: 100%
      height: auto
      zoomable: true
      draggable: true

markdown_extensions:
  - admonition
  - pymdownx.details
  - pymdownx.superfences
  - pymdownx.tabbed:
      alternate_style: true
  - attr_list
  - md_in_html
  - pymdownx.emoji:
      emoji_index: !!python/name:material.extensions.emoji.twemoji
      emoji_generator: !!python/name:material.extensions.emoji.to_svg

extra_css:
  - stylesheets/extra.css

nav:
  - Startseite: index.md
  - Erste Schritte:
    - Anmeldung: erste-schritte/anmeldung.md
    - Die Oberfläche: erste-schritte/oberflaeche.md
  - Inhalte bearbeiten:
    - Neue Seite erstellen: inhalte/seite-erstellen.md
    - Seite bearbeiten: inhalte/seite-bearbeiten.md
    - Paragraphen verwenden: inhalte/paragraphen.md
    - Medien einfügen: inhalte/medien.md
```
</mkdocs_config>

<extra_css>
## Extra CSS (stylesheets/extra.css)

```css
/* Screenshot-Styling */
.md-content img {
  border: 1px solid #e0e0e0;
  border-radius: 4px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  margin: 1rem 0;
}

/* Bildunterschriften */
.md-content figure {
  margin: 1.5rem 0;
}

.md-content figcaption {
  font-size: 0.875rem;
  color: #666;
  text-align: center;
  font-style: italic;
  margin-top: 0.5rem;
}

/* Nummerierte Schritte hervorheben */
.md-content ol > li {
  margin-bottom: 1.5rem;
}

/* Admonition Icons */
.md-typeset .admonition.tip {
  border-color: #00bfa5;
}

.md-typeset .admonition.warning {
  border-color: #ff9100;
}
```
</extra_css>

<admonitions>
## Admonitions (Hinweisboxen)

**Tipp:**
```markdown
!!! tip "Tipp"
    Hier steht ein hilfreicher Hinweis.
```

**Warnung:**
```markdown
!!! warning "Achtung"
    Diese Aktion kann nicht rückgängig gemacht werden.
```

**Info:**
```markdown
!!! info "Hinweis"
    Zusätzliche Information für den Benutzer.
```

**Erfolg:**
```markdown
!!! success "Geschafft"
    Die Aktion war erfolgreich.
```

**Aufklappbar:**
```markdown
??? note "Mehr erfahren"
    Dieser Text ist zunächst versteckt.
```
</admonitions>

<commands>
## Wichtige Befehle

**Entwicklung:**
```bash
mkdocs serve
# Öffnet http://localhost:8000 mit Live-Reload
```

**Bauen:**
```bash
mkdocs build
# Erstellt statische Site in ./site/
```

**Strikt bauen (zeigt Fehler):**
```bash
mkdocs build --strict
# Bricht bei Warnungen ab
```

**Deployment (GitHub Pages):**
```bash
mkdocs gh-deploy
```
</commands>
