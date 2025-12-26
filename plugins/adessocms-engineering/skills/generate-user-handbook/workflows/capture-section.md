# Workflow: Einzelne Sektion dokumentieren

<required_reading>
**Lies diese Referenzen JETZT:**
1. references/screenshot-guidelines.md
2. references/writing-style.md
</required_reading>

<process>
## Schritt 1: Sektion auswählen

Frage den Benutzer mit AskUserQuestion:

**Welche Sektion soll dokumentiert werden?**

Optionen:
1. Anmeldung und Oberfläche
2. Seiten erstellen
3. Seiten bearbeiten
4. Paragraphen verwenden
5. Medien verwalten
6. Menüs bearbeiten
7. Andere (Freitext)

## Schritt 2: Voraussetzungen prüfen

Frage nach:
- Site-URL
- Login-Daten (falls noch nicht eingeloggt)
- Bestehendes Handbuch-Verzeichnis (falls vorhanden)

## Schritt 3: Browser vorbereiten

**Mit Claude in Chrome (PRIMARY):**
```
mcp__claude-in-chrome__tabs_context_mcp
mcp__claude-in-chrome__resize_window(width=1280, height=800, tabId=<tab_id>)
mcp__claude-in-chrome__navigate(url="{site-url}/user/login", tabId=<tab_id>)
```

**Fallback (nur wenn Claude in Chrome nicht verfügbar):** Playwright MCP verwenden.

Falls noch nicht eingeloggt: Login durchführen.

## Schritt 4: Sektion-spezifische Screenshots

Je nach gewählter Sektion:

### Anmeldung und Oberfläche
1. Login-Seite (leer)
2. Login-Seite (mit Daten)
3. Dashboard nach Login
4. Admin-Toolbar (Hover auf "Inhalt")
5. Admin-Toolbar (Hover auf "Struktur")

### Seiten erstellen
1. /admin/content
2. "Inhalt hinzufügen" Button
3. /node/add (Content-Typ Auswahl)
4. /node/add/page (leeres Formular)
5. Titel-Feld ausgefüllt
6. Speichern-Button
7. Erfolgs-Nachricht

### Seiten bearbeiten
1. /admin/content (Liste)
2. "Bearbeiten" Dropdown
3. Bearbeitungsformular
4. Änderung durchführen
5. Speichern

### Paragraphen verwenden
1. Paragraph-Bereich auf Seite
2. "Paragraph hinzufügen" Button
3. Paragraph-Typ Auswahl
4. Hero Paragraph ausgefüllt
5. Text Paragraph ausgefüllt
6. Paragraphen sortieren (Drag)
7. Paragraph löschen

### Medien verwalten
1. /admin/content/media
2. "Medium hinzufügen"
3. Upload-Dialog
4. Bild hochgeladen
5. Bild in Content einfügen

### Menüs bearbeiten
1. /admin/structure/menu
2. Hauptmenü öffnen
3. "Link hinzufügen"
4. Link-Formular
5. Sortierung

## Schritt 5: Markdown-Seite erstellen

Nutze Template `templates/page-template.md`:

1. Titel der Sektion
2. Kurze Einleitung (1-2 Sätze)
3. Voraussetzungen (falls nötig)
4. Schritt-für-Schritt Anleitung
5. Jeden Schritt mit Screenshot
6. Tipps und Hinweise
7. Häufige Probleme (falls bekannt)

## Schritt 6: In bestehendes Handbuch integrieren

Falls Handbuch existiert:
- Datei in korrektes Verzeichnis speichern
- mkdocs.yml Navigation aktualisieren
- Screenshots in assets/images/{section}/ speichern

Falls kein Handbuch:
- Hinweis geben, dass vollständiges Handbuch empfohlen wird
- Einzelne Markdown-Datei ausgeben

## Schritt 7: Ergebnis zeigen

Präsentiere:
- Erstellte Markdown-Datei
- Anzahl Screenshots
- Vorschau der Seite (falls mkdocs läuft)
</process>

<success_criteria>
Die Sektion ist fertig wenn:

- [ ] Mindestens 3 Screenshots erstellt
- [ ] Alle Screenshots haben Bildunterschriften
- [ ] Schritt-für-Schritt Anleitung vollständig
- [ ] Text ist für Laien verständlich
- [ ] Datei ist in korrektem Verzeichnis
- [ ] mkdocs.yml aktualisiert (falls Handbuch existiert)
</success_criteria>
