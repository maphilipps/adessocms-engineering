<overview>
Richtlinien für die Erstellung konsistenter, hilfreicher Screenshots mit Claude in Chrome (Primary) oder Playwright MCP (Fallback).
</overview>

<browser_setup>
## Browser-Konfiguration

### Fenstergröße
Immer 1280x800px für konsistente Screenshots:

**Claude in Chrome (Primary):**
```
mcp__claude-in-chrome__tabs_context_mcp
mcp__claude-in-chrome__resize_window(width=1280, height=800, tabId=<tab_id>)
```

**Playwright (Fallback - nur wenn Claude in Chrome nicht verfügbar):**
```
mcp__plugin_adessocms-engineering_pw__browser_resize(width=1280, height=800)
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

<claude_in_chrome_workflow>
## Claude in Chrome Workflow (PRIMARY)

### 1. Tab-Kontext holen
```
mcp__claude-in-chrome__tabs_context_mcp
```
Notiere die `tabId` für nachfolgende Befehle.

### 2. Navigieren
```
mcp__claude-in-chrome__navigate(url="https://example.ddev.site/admin/content", tabId=<tab_id>)
```

### 3. Warten bis geladen
```
mcp__claude-in-chrome__computer(action="wait", duration=2, tabId=<tab_id>)
```

### 4. Seite lesen (optional)
```
mcp__claude-in-chrome__read_page(tabId=<tab_id>)
```
Prüfen ob gewünschte Elemente sichtbar sind.

### 5. Screenshot erstellen
```
mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)
```

### 6. Screenshot verschieben
Nach dem Erstellen in richtiges Verzeichnis verschieben:
```bash
mv screenshot.png docs/assets/images/inhalte/content-liste-01.png
```
</claude_in_chrome_workflow>

<playwright_fallback>
## Playwright Workflow (FALLBACK)

**Nur verwenden wenn Claude in Chrome nicht verfügbar ist!**

### Navigieren
```
mcp__plugin_adessocms-engineering_pw__browser_navigate(url="https://example.ddev.site/admin/content")
```

### Warten bis geladen
```
mcp__plugin_adessocms-engineering_pw__browser_wait_for(text="Inhalt")
```

### Screenshot erstellen
```
mcp__plugin_adessocms-engineering_pw__browser_take_screenshot(filename="content-liste-01.png")
```
</playwright_fallback>

<screenshot_types>
## Screenshot-Typen

### Übersichts-Screenshot
- Zeigt gesamten Viewport
- Für Orientierung wo man sich befindet
- Beispiel: Content-Liste, Dashboard

### Fokus-Screenshot
- Zeigt nur relevanten Bereich
- Mit Claude in Chrome: Scroll zum Element, dann Screenshot

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
