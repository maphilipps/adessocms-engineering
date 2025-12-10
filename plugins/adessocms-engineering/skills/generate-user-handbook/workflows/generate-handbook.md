# Workflow: Komplettes Handbuch generieren

<required_reading>
**Lies diese Referenzen JETZT:**
1. references/mkdocs-setup.md
2. references/writing-style.md
3. references/screenshot-guidelines.md
</required_reading>

<process>
## Schritt 1: Projektinformationen sammeln

Frage den Benutzer mit AskUserQuestion:

1. **Site-URL**: Wo läuft die Drupal-Site? (z.B. `https://example.ddev.site`)
2. **Login-Daten**: Benutzername und Passwort für Redakteur-Account
3. **Ausgabeverzeichnis**: Wo soll das Handbuch erstellt werden? (Standard: `./docs/user-handbook`)

## Schritt 2: MkDocs-Projekt initialisieren

```bash
# Verzeichnis erstellen
mkdir -p {ausgabeverzeichnis}
cd {ausgabeverzeichnis}

# MkDocs initialisieren (falls nicht vorhanden)
pip install mkdocs-material mkdocs-glightbox --quiet
```

Erstelle `mkdocs.yml` aus Template `templates/mkdocs-config.yml`.

Erstelle Verzeichnisstruktur:
```
docs/
├── index.md
├── erste-schritte/
│   ├── anmeldung.md
│   └── oberflaeche.md
├── inhalte/
│   ├── seite-erstellen.md
│   ├── seite-bearbeiten.md
│   ├── paragraphen.md
│   └── medien.md
├── assets/
│   └── images/
│       ├── erste-schritte/
│       ├── inhalte/
│       └── ...
└── stylesheets/
    └── extra.css
```

## Schritt 3: Browser starten und einloggen

Nutze Playwright MCP:

```
mcp__playwright__browser_navigate → {site-url}/user/login
mcp__playwright__browser_snapshot → Snapshot für Login-Formular
mcp__playwright__browser_fill_form → Username + Password eingeben
mcp__playwright__browser_click → Login-Button klicken
mcp__playwright__browser_wait_for → Warten auf Admin-Toolbar
```

**Screenshot erstellen:** Login-Seite VOR dem Einloggen für Dokumentation.

## Schritt 4: Backend-Bereiche systematisch dokumentieren

Für jeden Bereich:

### 4.1 Erste Schritte
- [ ] Login-Seite dokumentieren
- [ ] Admin-Toolbar erklären
- [ ] Dashboard/Startseite zeigen

### 4.2 Inhalte verwalten
- [ ] Content-Übersicht (`/admin/content`)
- [ ] Neue Seite erstellen (`/node/add/page`)
- [ ] Seite bearbeiten
- [ ] Paragraphen hinzufügen (Hero, Text, Cards, etc.)
- [ ] Paragraphen sortieren/löschen

### 4.3 Medien
- [ ] Medienbibliothek (`/admin/content/media`)
- [ ] Bild hochladen
- [ ] Bild in Content einfügen

### 4.4 Menüs (falls vorhanden)
- [ ] Menü-Übersicht
- [ ] Menüpunkt hinzufügen

### 4.5 Taxonomien (falls vorhanden)
- [ ] Kategorien/Tags verwalten

## Schritt 5: Screenshots erstellen

Für jeden Screen:

1. **Browser auf 1280px Breite setzen:**
   ```
   mcp__playwright__browser_resize → width: 1280, height: 800
   ```

2. **Navigieren zum Bereich:**
   ```
   mcp__playwright__browser_navigate → {url}
   ```

3. **Warten bis geladen:**
   ```
   mcp__playwright__browser_wait_for → Warten auf Key-Element
   ```

4. **Screenshot erstellen:**
   ```
   mcp__playwright__browser_take_screenshot → filename: {section}-{action}-{step}.png
   ```

5. **Screenshot in docs/assets/images/{section}/ speichern**

## Schritt 6: Markdown-Seiten schreiben

Für jede Seite nutze Template `templates/page-template.md`:

- Titel und Einleitung
- Schritt-für-Schritt Anleitung
- Screenshots mit Bildunterschriften
- Tipps und Hinweise (Admonitions)
- Verwandte Themen (Links)

**Schreibstil beachten:** Siehe `references/writing-style.md`

## Schritt 7: Inhaltsverzeichnis (nav) in mkdocs.yml

Aktualisiere `mkdocs.yml` mit der Navigation:

```yaml
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

## Schritt 8: Testen und validieren

```bash
cd {ausgabeverzeichnis}
mkdocs serve
```

Öffne http://localhost:8000 und prüfe:
- [ ] Alle Seiten erreichbar
- [ ] Alle Screenshots sichtbar
- [ ] Links funktionieren
- [ ] Suche funktioniert

## Schritt 9: Browser schließen

```
mcp__playwright__browser_close
```

## Schritt 10: Ergebnis präsentieren

Zeige dem Benutzer:
- Pfad zum generierten Handbuch
- Befehl zum Starten (`mkdocs serve`)
- Befehl zum Bauen (`mkdocs build`)
- Anzahl der erstellten Seiten und Screenshots
</process>

<success_criteria>
Das Handbuch ist fertig wenn:

- [ ] MkDocs-Projekt läuft ohne Fehler
- [ ] Mindestens 5 Hauptseiten erstellt
- [ ] Mindestens 15 Screenshots vorhanden
- [ ] Alle Screenshots haben Bildunterschriften
- [ ] Navigation in mkdocs.yml vollständig
- [ ] `mkdocs build` erzeugt fehlerfreie HTML-Site
- [ ] Texte sind für Laien verständlich
</success_criteria>
