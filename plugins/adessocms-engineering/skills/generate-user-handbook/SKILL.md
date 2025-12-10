---
name: generate-user-handbook
description: Generiert vollständige Benutzerhandbücher für Drupal-Backends durch automatisiertes Einloggen, Screenshot-Erstellung und MkDocs-Dokumentation. Verwendung bei Bedarf an Redakteurs-Dokumentation, Schulungsunterlagen oder Benutzeranleitungen.
---

<essential_principles>
## Grundprinzipien für Benutzerhandbücher

### 1. Zielgruppe: Technisch Unbedarfte
- **Keine Fachbegriffe** ohne Erklärung
- **Jeden Klick** explizit beschreiben
- **Visuelle Orientierung** durch Screenshots mit Markierungen
- **Schritt-für-Schritt** Anleitungen, keine Abkürzungen

### 2. Screenshot-Qualität
- **Browser-Breite**: 1280px für konsistente Screenshots
- **Fokus**: Nur relevanten Bereich zeigen, nicht gesamten Bildschirm
- **Benennung**: `{section}-{action}-{step}.png` (z.B. `content-create-01.png`)
- **Beschreibung**: Jeder Screenshot braucht ALT-Text und Bildunterschrift

### 3. MkDocs Material Theme
- Nutze Admonitions (Hinweise, Warnungen, Tipps)
- Nutze Content Tabs für alternative Wege
- Nutze Numbered Lists für Schritte
- Nutze Screenshots mit Lightbox-Funktion

### 4. Drupal-Backend Navigation
- Login über `/user/login` mit Redakteurs-Credentials
- Admin-Toolbar ist primäre Navigation
- Paragraphen-System für Content-Erstellung dokumentieren
- Media Library für Bildverwaltung
</essential_principles>

<objective>
Erstellt professionelle, benutzerfreundliche Handbücher für Drupal-Backends. Der Skill loggt sich automatisch ein, erstellt Screenshots aller relevanten Bereiche und generiert eine vollständige MkDocs-Dokumentation auf Deutsch für technisch unbedarfte Redakteure.
</objective>

<quick_start>
**Voraussetzungen:**
1. Drupal-Site läuft (lokal via DDEV oder remote)
2. Redakteurs-Login-Daten bekannt
3. MkDocs installiert (`pip install mkdocs-material`)

**Schnellstart:**
```bash
/generate-user-handbook https://example.ddev.site
```

Der Skill fragt nach Login-Daten und generiert dann das komplette Handbuch.
</quick_start>

<intake>
**Was möchtest du tun?**

1. **Komplettes Handbuch generieren** - Alle Backend-Bereiche dokumentieren
2. **Einzelne Sektion dokumentieren** - Nur einen Bereich (z.B. nur "Seiten erstellen")
3. **Bestehendes Handbuch aktualisieren** - Screenshots und Texte aktualisieren

**Warte auf Antwort bevor du fortfährst.**
</intake>

<routing>
| Antwort | Workflow |
|---------|----------|
| 1, "komplett", "alles", "vollständig" | `workflows/generate-handbook.md` |
| 2, "sektion", "bereich", "teil" | `workflows/capture-section.md` |
| 3, "aktualisieren", "update", "erneuern" | `workflows/update-handbook.md` |

**Nach dem Lesen des Workflows: Folge ihm exakt.**
</routing>

<reference_index>
Alle Referenzen in `references/`:

**Setup:** mkdocs-setup.md - MkDocs Material Konfiguration und Projektstruktur
**Schreibstil:** writing-style.md - Anleitungen für verständliche Texte
**Screenshots:** screenshot-guidelines.md - Playwright-basierte Screenshot-Erstellung
</reference_index>

<workflows_index>
| Workflow | Zweck |
|----------|-------|
| generate-handbook.md | Komplettes Handbuch von Grund auf erstellen |
| capture-section.md | Einzelne Sektion dokumentieren |
| update-handbook.md | Bestehendes Handbuch aktualisieren |
</workflows_index>

<templates_index>
| Template | Zweck |
|----------|-------|
| page-template.md | Vorlage für einzelne Handbuch-Seiten |
| mkdocs-config.yml | MkDocs Konfigurationsvorlage |
</templates_index>

<success_criteria>
Ein vollständiges Benutzerhandbuch enthält:

- [ ] MkDocs-Projekt mit Material Theme konfiguriert
- [ ] Inhaltsverzeichnis mit allen Backend-Bereichen
- [ ] Screenshots aller wichtigen Screens (min. 3 pro Sektion)
- [ ] Schritt-für-Schritt Anleitungen in einfacher Sprache
- [ ] Bildunterschriften und ALT-Texte für alle Screenshots
- [ ] Admonitions für Tipps, Warnungen, Hinweise
- [ ] Funktionierender `mkdocs serve` Befehl zum Testen
- [ ] Export-fähig als statische HTML-Site
</success_criteria>
