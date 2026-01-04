---
name: sync-knowledge
description: Sync local documentation to Engineering Knowledge Base (initial bulk upload or manual refresh)
argument-hint: "[--force] [--dry-run] [--path=docs/patterns/]"
---

# /sync-knowledge

Synchronisiert lokale Dokumentation mit der Engineering Knowledge Base.

## Usage

```bash
/sync-knowledge              # Standard sync (überspringt bereits vorhandene)
/sync-knowledge --force      # Erzwingt Re-Upload aller Items
/sync-knowledge --dry-run    # Zeigt nur was hochgeladen werden würde
/sync-knowledge --path=docs/patterns/  # Nur bestimmtes Verzeichnis
```

## Workflow

### 1. Parse Arguments

| Argument | Effekt |
|----------|--------|
| (keine) | Standard-Sync mit Duplicate-Check |
| `--force` | Überspringt Duplicate-Check, lädt alles hoch |
| `--dry-run` | Zeigt Report ohne tatsächlichen Upload |
| `--path=<dir>` | Limitiert auf angegebenes Verzeichnis |

### 2. Starte Bulk Loader Agent

```
Task(subagent_type="knowledge-bulk-loader", prompt="<constructed prompt based on args>")
```

**Prompt-Konstruktion:**

- Standard: `"Upload all existing documentation to Engineering KB"`
- Mit `--force`: `"Force re-upload all documentation to Engineering KB, skip duplicate check"`
- Mit `--dry-run`: `"Dry-run: Show what would be uploaded to Engineering KB without actually uploading"`
- Mit `--path=docs/patterns/`: `"Upload only docs/patterns/ to Engineering KB"`

### 3. Report anzeigen

Der Agent liefert einen strukturierten Report zurück. Zeige diesen dem User.

## Beispiele

### Initialer Sync (erstes Mal)

```
> /sync-knowledge

📊 Starte Synchronisation mit Engineering-KB...

[Agent läuft und gibt Fortschritt aus]

✅ Sync abgeschlossen:
- 12 ADRs hochgeladen
- 8 Patterns hochgeladen
- 23 Best Practices hochgeladen
- 3 Anti-Patterns hochgeladen

Alle Items sind als Draft markiert und warten auf Review.
```

### Dry-Run

```
> /sync-knowledge --dry-run

📋 Dry-Run Analyse:

Würde hochgeladen werden:
- docs/adr/001-sdc-vs-blocks.md → ADR
- docs/patterns/caching-views.md → Pattern
- docs/solutions/twig-debugging.md → Best Practice

Würde übersprungen werden:
- docs/README.md → Keine Knowledge-Datei
- docs/solutions/quick-ref.md → Enthält "HUMAN QUICK REFERENCE"

Gesamt: 45 Items zum Upload, 2 übersprungen
```

### Nach /acms-compound (Nachsync)

```
> /sync-knowledge --path=docs/patterns/

📤 Synchronisiere docs/patterns/...

Neue Dateien gefunden:
- docs/patterns/new-pattern.md → Pattern

✅ 1 Pattern hochgeladen (Draft, pending Review)
```

## Wann verwenden?

| Situation | Command |
|-----------|---------|
| Erstes Mal im Projekt | `/sync-knowledge` |
| Nach manuellem Hinzufügen von Docs | `/sync-knowledge` |
| Debugging / Was würde passieren? | `/sync-knowledge --dry-run` |
| Alles neu hochladen (Reset) | `/sync-knowledge --force` |
| Nur ein Verzeichnis syncen | `/sync-knowledge --path=docs/adr/` |

## Hinweise

- **Lokal bleibt erhalten**: Der Sync ist one-way (lokal → KB), lokale Dateien werden nicht verändert
- **Review erforderlich**: Alle Uploads landen als "draft" und brauchen Team-Approval
- **Idempotent**: Standard-Sync überspringt bereits vorhandene Items automatisch
- **Engineering-KB muss erreichbar sein**: Bei Netzwerkproblemen werden Fehler angezeigt

---

> **"Keep your team knowledge in sync."**
