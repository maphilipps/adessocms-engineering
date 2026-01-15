# Workflow: Bestehendes Handbuch aktualisieren

<required_reading>
**Lies diese Referenzen JETZT:**
1. references/screenshot-guidelines.md
</required_reading>

<process>
## Schritt 1: Handbuch-Verzeichnis identifizieren

Frage den Benutzer:
- Pfad zum bestehenden Handbuch-Verzeichnis
- Site-URL (für neue Screenshots)
- Login-Daten

Prüfe ob `mkdocs.yml` existiert:
```bash
ls {handbuch-verzeichnis}/mkdocs.yml
```

## Schritt 2: Aktuellen Stand analysieren

Lies die bestehende Struktur:
```bash
find {handbuch-verzeichnis}/docs -name "*.md" | sort
```

Liste bestehende Screenshots:
```bash
find {handbuch-verzeichnis}/docs/assets/images -name "*.png" | wc -l
```

Zeige dem Benutzer:
- Anzahl Seiten
- Anzahl Screenshots
- Letzte Änderung

## Schritt 3: Update-Umfang bestimmen

Frage mit AskUserQuestion:

**Was soll aktualisiert werden?**

1. Alle Screenshots erneuern (UI hat sich geändert)
2. Nur bestimmte Sektion aktualisieren
3. Neue Sektion hinzufügen
4. Texte überarbeiten (keine neuen Screenshots)

## Schritt 4: Browser vorbereiten (falls Screenshots)

**Claude in Chrome (PRIMARY):**

```
# 1. Tab-Kontext holen
mcp__claude-in-chrome__tabs_context_mcp

# 2. Neuen Tab erstellen
mcp__claude-in-chrome__tabs_create_mcp

# 3. Browser-Größe setzen
mcp__claude-in-chrome__resize_window(width=1280, height=800, tabId=<tab_id>)

# 4. Zur Login-Seite navigieren
mcp__claude-in-chrome__navigate(url="{site-url}/user/login", tabId=<tab_id>)

# 5. Login durchführen (Formular ausfüllen + Button klicken)
mcp__claude-in-chrome__read_page(tabId=<tab_id>)
mcp__claude-in-chrome__form_input(ref="<username_ref>", value="username", tabId=<tab_id>)
mcp__claude-in-chrome__form_input(ref="<password_ref>", value="password", tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="left_click", ref="<login_button_ref>", tabId=<tab_id>)
```

## Schritt 5: Update durchführen

### Bei "Alle Screenshots erneuern":
1. Backup der alten Screenshots erstellen
   ```bash
   cp -r docs/assets/images docs/assets/images.backup
   ```
2. Durch alle Seiten navigieren
3. Neue Screenshots mit GLEICHEN Dateinamen erstellen
4. Alte Backup löschen wenn erfolgreich

### Bei "Bestimmte Sektion":
1. Sektion auswählen lassen
2. Nur diese Screenshots erneuern
3. Markdown prüfen und ggf. anpassen

### Bei "Neue Sektion":
1. Workflow `capture-section.md` aufrufen
2. mkdocs.yml Navigation erweitern

### Bei "Texte überarbeiten":
1. Zu überarbeitende Seiten identifizieren
2. Texte nach `references/writing-style.md` anpassen
3. Keine Screenshots ändern

## Schritt 6: Validieren

```bash
cd {handbuch-verzeichnis}
mkdocs build --strict
```

Prüfe auf:
- [ ] Fehlende Bilder
- [ ] Kaputte Links
- [ ] Markdown-Fehler

## Schritt 7: Diff zeigen

Zeige dem Benutzer was sich geändert hat:
- Anzahl aktualisierter Screenshots
- Geänderte Markdown-Dateien
- Neue Seiten (falls hinzugefügt)

## Schritt 8: Browser schließen

**Claude in Chrome:**
```
# Tab kann offen bleiben für weitere Nutzung
# Nur bei Bedarf manuell schließen
```

**Hinweis:** Claude in Chrome Tabs bleiben offen. Bei Bedarf manuell im Browser schließen.
</process>

<success_criteria>
Das Update ist fertig wenn:

- [ ] Alle gewünschten Änderungen durchgeführt
- [ ] `mkdocs build --strict` läuft ohne Fehler
- [ ] Keine kaputten Bild-Referenzen
- [ ] Benutzer hat Änderungen bestätigt
</success_criteria>
