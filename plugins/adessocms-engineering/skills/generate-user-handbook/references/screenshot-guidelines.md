<overview>
Richtlinien für die Erstellung konsistenter, hilfreicher Screenshots mit Playwright MCP.
</overview>

<browser_setup>
## Browser-Konfiguration

### Fenstergröße
Immer 1280x800px für konsistente Screenshots:

```
mcp__playwright__browser_resize
  width: 1280
  height: 800
```

### Warum 1280px?
- Gängige Laptop-Breite
- Admin-Toolbar vollständig sichtbar
- Keine Scroll-Probleme
- Konsistente Proportionen
</browser_setup>

<naming_convention>
## Dateinamenskonvention

### Format
```
{bereich}-{aktion}-{schritt}.png
```

### Beispiele
- `login-formular-01.png`
- `login-formular-02-ausgefuellt.png`
- `content-liste-01.png`
- `content-erstellen-01-formular.png`
- `content-erstellen-02-titel.png`
- `content-erstellen-03-speichern.png`
- `paragraph-hero-01-hinzufuegen.png`
- `paragraph-hero-02-felder.png`
- `medien-upload-01-dialog.png`

### Ordnerstruktur
```
docs/assets/images/
├── erste-schritte/
│   ├── login-formular-01.png
│   ├── login-formular-02-ausgefuellt.png
│   └── dashboard-01.png
├── inhalte/
│   ├── content-liste-01.png
│   ├── content-erstellen-01-formular.png
│   └── ...
├── paragraphen/
│   ├── paragraph-hero-01-hinzufuegen.png
│   └── ...
└── medien/
    ├── medien-upload-01-dialog.png
    └── ...
```
</naming_convention>

<playwright_workflow>
## Playwright MCP Workflow

### 1. Navigieren
```
mcp__playwright__browser_navigate
  url: https://example.ddev.site/admin/content
```

### 2. Warten bis geladen
```
mcp__playwright__browser_wait_for
  text: "Inhalt"
```

Oder auf Element warten:
```
mcp__playwright__browser_snapshot
```
Prüfen ob gewünschte Elemente sichtbar sind.

### 3. Screenshot erstellen
```
mcp__playwright__browser_take_screenshot
  filename: content-liste-01.png
  fullPage: false
```

**fullPage: false** für Viewport-Screenshots (empfohlen)
**fullPage: true** nur für sehr lange Seiten

### 4. Screenshot verschieben
Nach dem Erstellen in richtiges Verzeichnis verschieben:
```bash
mv content-liste-01.png docs/assets/images/inhalte/
```
</playwright_workflow>

<screenshot_types>
## Screenshot-Typen

### Übersichts-Screenshot
- Zeigt gesamten Viewport
- Für Orientierung wo man sich befindet
- Beispiel: Content-Liste, Dashboard

### Fokus-Screenshot
- Zeigt nur relevanten Bereich
- Nutze Element-Screenshot:
```
mcp__playwright__browser_take_screenshot
  ref: "form-element-ref"
  element: "Das Formular zum Erstellen"
```

### Sequenz-Screenshots
- Mehrere Screenshots für einen Ablauf
- Nummeriert: 01, 02, 03...
- Jeder Schritt ein Screenshot
</screenshot_types>

<quality_checklist>
## Qualitäts-Checkliste

Vor dem Erstellen:
- [ ] Browser auf 1280x800px
- [ ] Eingeloggt als Redakteur
- [ ] Sprache auf Deutsch gestellt
- [ ] Keine Test-/Entwickler-Daten sichtbar
- [ ] Keine persönlichen Daten sichtbar

Nach dem Erstellen:
- [ ] Screenshot ist scharf
- [ ] Relevanter Bereich ist sichtbar
- [ ] Keine Scrollbars wenn vermeidbar
- [ ] Dateiname folgt Konvention
- [ ] In korrektem Ordner gespeichert
</quality_checklist>

<content_guidelines>
## Was zeigen, was vermeiden

### Zeigen
- Standard-Drupal-UI ohne Anpassungen
- Beispielhafte aber realistische Inhalte
- Erfolgs-Nachrichten nach Aktionen
- Aktive/Hover-Zustände von Buttons

### Vermeiden
- Echte Kundendaten oder -namen
- Entwickler-spezifische Inhalte
- Fehler-Zustände (außer für Troubleshooting)
- Browser-DevTools
- Persönliche Bookmarks/Tabs
</content_guidelines>

<annotations>
## Screenshot-Annotationen (optional)

Falls Markierungen nötig sind, nutze externe Tools oder CSS-Overlay:

### Mit CSS in MkDocs
```html
<figure markdown>
  ![Screenshot](../assets/images/beispiel.png){ .annotated }
  <figcaption>
    <span class="annotation" style="top: 20%; left: 30%;">1</span>
    Der rote Kreis markiert den Speichern-Button
  </figcaption>
</figure>
```

### Besser: Beschreibung im Text
Statt Annotationen lieber im Text beschreiben:
> Der Button **Speichern** befindet sich unten rechts im Formular (blauer Button).

### Wann Annotationen sinnvoll
- Sehr komplexe Screens
- Mehrere wichtige Bereiche gleichzeitig
- Wenn Textbeschreibung nicht ausreicht
</annotations>

<alt_text>
## Alt-Texte für Barrierefreiheit

### Format
Beschreibe was zu sehen ist, nicht was getan werden soll:

**Gut:**
```markdown
![Das Formular zum Erstellen einer neuen Seite mit Feldern für Titel, URL-Alias und Inhalt](bild.png)
```

**Schlecht:**
```markdown
![Klicken Sie hier](bild.png)
```

### Elemente beschreiben
- Welcher Screen/Dialog ist zu sehen
- Welche Felder/Buttons sind sichtbar
- Welcher Zustand (leer, ausgefüllt, Fehler)
</alt_text>
