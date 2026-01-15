<overview>
Schreibstil-Richtlinien für Benutzerhandbücher, die für technisch unbedarfte Nutzer verständlich sind.
</overview>

<golden_rules>
## Goldene Regeln

1. **Schreibe für deine Oma** - Wenn sie es nicht verstehen würde, formuliere es um
2. **Ein Schritt = Eine Aktion** - Nie mehrere Aktionen in einem Schritt
3. **Zeige, was du meinst** - Jeder Schritt braucht einen Screenshot
4. **Vermeide "einfach"** - Was für dich einfach ist, ist es nicht für jeden
5. **Sei konkret** - "Klicken Sie auf den blauen Button 'Speichern'" statt "Speichern Sie"
</golden_rules>

<vocabulary>
## Vokabular

### Verwende
- Klicken (nicht: anklicken, drücken, betätigen)
- Eingeben (nicht: eintippen, eintragen)
- Auswählen (nicht: selektieren)
- Öffnen (nicht: aufrufen, starten)
- Schließen (nicht: beenden)
- Speichern (nicht: sichern, abspeichern)

### Vermeide
- Fachbegriffe ohne Erklärung
- Abkürzungen (CMS, UI, URL ohne Erklärung)
- Englische Begriffe wenn deutsche existieren
- Passive Formulierungen
- Negationen ("nicht vergessen" → "achten Sie darauf")

### Erkläre bei erster Verwendung
- **Admin-Toolbar**: "Die dunkle Leiste am oberen Bildschirmrand"
- **Paragraph**: "Ein Inhaltsblock, z.B. für Text oder Bilder"
- **Node**: Vermeide, sage stattdessen "Seite" oder "Inhalt"
- **Medien**: "Bilder, Videos und Dokumente"
</vocabulary>

<sentence_structure>
## Satzstruktur

### Gut
- Kurze Sätze (max. 15 Wörter)
- Aktive Formulierungen
- Direkte Ansprache (Sie)
- Imperativ für Anweisungen

### Beispiele

**Schlecht:**
> Um eine neue Seite zu erstellen, muss zunächst im Administrationsbereich der Menüpunkt "Inhalt" aufgerufen werden, wonach dann der Button "Inhalt hinzufügen" angeklickt werden sollte.

**Gut:**
> 1. Klicken Sie in der Admin-Toolbar auf **Inhalt**.
> 2. Klicken Sie auf den Button **Inhalt hinzufügen**.
</sentence_structure>

<step_format>
## Format für Schritt-für-Schritt Anleitungen

### Struktur einer Anleitung

```markdown
## Neue Seite erstellen

So erstellen Sie eine neue Seite:

1. Klicken Sie in der Admin-Toolbar auf **Inhalt**.

   ![Inhalt-Menü](../assets/images/inhalte/content-menu.png)
   *Die Admin-Toolbar mit dem Menüpunkt "Inhalt"*

2. Klicken Sie auf den blauen Button **Inhalt hinzufügen**.

   ![Inhalt hinzufügen Button](../assets/images/inhalte/add-content-button.png)
   *Der Button "Inhalt hinzufügen" befindet sich oben links*

3. Wählen Sie **Seite** aus der Liste der Inhaltstypen.

   ![Inhaltstyp auswählen](../assets/images/inhalte/content-type-list.png)
   *Klicken Sie auf "Seite"*

!!! success "Geschafft"
    Sie sehen nun das Formular zum Erstellen einer neuen Seite.
```

### Regeln für Schritte

1. **Nummerierung**: Immer nummerierte Listen, nie Aufzählungszeichen
2. **Fettdruck**: UI-Elemente immer **fett** markieren
3. **Screenshot**: Nach jedem Schritt ein Screenshot
4. **Bildunterschrift**: Erklärt was auf dem Screenshot zu sehen ist
5. **Bestätigung**: Am Ende eine Erfolgs-Admonition
</step_format>

<screenshots_in_text>
## Screenshots im Text

### Bild einfügen
```markdown
![Alt-Text für Barrierefreiheit](../assets/images/ordner/dateiname.png)
*Bildunterschrift: Beschreibung was zu sehen ist*
```

### Alt-Text schreiben
- Beschreibe was auf dem Bild zu sehen ist
- Für Screenreader-Nutzer wichtig
- Beispiel: "Das Formular zum Erstellen einer neuen Seite mit leerem Titelfeld"

### Bildunterschrift schreiben
- Beginnt mit Großbuchstaben
- Erklärt den Kontext
- Weist auf wichtige Elemente hin
- Beispiele:
  - "Der Button 'Speichern' befindet sich unten rechts"
  - "Das Dropdown-Menü zeigt alle verfügbaren Paragraphen"
  - "Die rote Markierung zeigt den Fehler an"
</screenshots_in_text>

<common_sections>
## Standardabschnitte

### Einleitung
Jede Seite beginnt mit 1-2 Sätzen, die erklären:
- Was der Benutzer lernen wird
- Warum das wichtig ist

```markdown
# Neue Seite erstellen

In diesem Abschnitt lernen Sie, wie Sie eine neue Seite für Ihre Website
erstellen. Seiten sind die Grundbausteine Ihrer Website.
```

### Voraussetzungen (optional)
Falls nötig, was der Benutzer vorher getan haben muss:

```markdown
!!! info "Voraussetzung"
    Sie müssen angemeldet sein, um Seiten erstellen zu können.
    Siehe [Anmeldung](../erste-schritte/anmeldung.md).
```

### Häufige Fragen (optional)
Am Ende einer Seite:

```markdown
## Häufige Fragen

**Kann ich eine Seite wieder löschen?**
Ja. Öffnen Sie die Seite zum Bearbeiten und klicken Sie auf **Löschen**.

**Warum sehe ich meine Änderungen nicht?**
Möglicherweise wurde die Seite noch nicht veröffentlicht.
Prüfen Sie den Status unter "Veröffentlichungsoptionen".
```
</common_sections>

<tone>
## Tonalität

### Freundlich aber professionell
- Kein Fachchinesisch
- Keine Überheblichkeit
- Geduldig erklären
- Ermutigen

### Beispiele

**Zu technisch:**
> Navigieren Sie zum Node-Add-Formular über /node/add/page.

**Zu locker:**
> Easy! Einfach auf Inhalt klicken und los geht's!

**Genau richtig:**
> Klicken Sie auf **Inhalt** in der Admin-Toolbar. Es öffnet sich die Übersicht aller Inhalte Ihrer Website.
</tone>
