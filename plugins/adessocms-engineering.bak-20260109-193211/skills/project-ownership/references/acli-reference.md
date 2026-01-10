# acli - Atlassian CLI Reference

<purpose>
Vollständige Referenz für die Atlassian CLI (acli) zur Jira-Integration.
Projekt: DS (adesso CMS Design System)
</purpose>

## Installation & Auth

```bash
# Installation
brew install atlassian/tap/acli

# Authentifizierung
acli jira auth login

# Status prüfen
acli jira auth status
```

## Workitem Commands

### create - Ticket erstellen

```bash
acli jira workitem create \
  --project "DS" \
  --type "Story|Task|Bug|Epic" \
  --summary "Titel" \
  --description "Text" \
  --json

# Mit Beschreibung aus Datei (für Markdown)
acli jira workitem create \
  --project "DS" \
  --type "Story" \
  --summary "Titel" \
  --description-file "/tmp/description.md" \
  --label "component,frontend"

# Mit Assignee
acli jira workitem create \
  --project "DS" \
  --type "Task" \
  --summary "Titel" \
  --assignee "email@example.com"  # oder @me, default

# Sub-Task erstellen
acli jira workitem create \
  --project "DS" \
  --type "Sub-task" \
  --summary "Sub-Task Titel" \
  --parent "DS-123"
```

**Flags:**
| Flag | Beschreibung |
|------|--------------|
| `-p, --project` | Projekt-Key (z.B. "DS") |
| `-t, --type` | Story, Task, Bug, Epic, Sub-task |
| `-s, --summary` | Ticket-Titel |
| `-d, --description` | Beschreibung (plain text oder ADF) |
| `--description-file` | Beschreibung aus Datei lesen |
| `-a, --assignee` | Email, Account-ID, @me, default |
| `-l, --label` | Labels (kommasepariert) |
| `--parent` | Parent-Ticket für Sub-Tasks |
| `--json` | JSON-Output |

### search - Tickets suchen

```bash
# Alle Tickets im Projekt
acli jira workitem search --jql "project = DS"

# Mit Filter
acli jira workitem search --jql "project = DS AND status = 'To Do'"
acli jira workitem search --jql "project = DS AND labels = 'component'"
acli jira workitem search --jql "project = DS AND assignee = currentUser()"

# Output-Formate
acli jira workitem search --jql "project = DS" --json
acli jira workitem search --jql "project = DS" --csv
acli jira workitem search --jql "project = DS" --count

# Felder auswählen
acli jira workitem search --jql "project = DS" --fields "key,summary,status,assignee"

# Pagination
acli jira workitem search --jql "project = DS" --limit 50
acli jira workitem search --jql "project = DS" --paginate  # alle holen
```

**Flags:**
| Flag | Beschreibung |
|------|--------------|
| `-j, --jql` | JQL Query |
| `--filter` | Saved Filter ID |
| `-f, --fields` | Felder (default: issuetype,key,assignee,priority,status,summary) |
| `-l, --limit` | Max. Anzahl |
| `--paginate` | Alle Seiten holen |
| `--csv` | CSV-Output |
| `--json` | JSON-Output |
| `--count` | Nur Anzahl |
| `-w, --web` | Im Browser öffnen |

### view - Ticket anzeigen

```bash
acli jira workitem view DS-123
acli jira workitem view DS-123 --json
acli jira workitem view DS-123 --fields "*all"
acli jira workitem view DS-123 --fields "summary,description,comment"
acli jira workitem view DS-123 --web  # im Browser öffnen
```

**Flags:**
| Flag | Beschreibung |
|------|--------------|
| `-f, --fields` | Felder (*all, *navigable, oder spezifisch) |
| `--json` | JSON-Output |
| `-w, --web` | Im Browser öffnen |

### edit - Ticket bearbeiten

```bash
acli jira workitem edit \
  --key "DS-123" \
  --summary "Neuer Titel" \
  --yes

acli jira workitem edit \
  --key "DS-123" \
  --description "Neue Beschreibung" \
  --description-file "/tmp/new-desc.md"

acli jira workitem edit \
  --key "DS-123" \
  --assignee "email@example.com" \
  --labels "new-label" \
  --remove-labels "old-label"

# Mehrere Tickets bearbeiten
acli jira workitem edit \
  --jql "project = DS AND labels = 'old-label'" \
  --labels "new-label" \
  --yes
```

**Flags:**
| Flag | Beschreibung |
|------|--------------|
| `-k, --key` | Ticket-Key(s) |
| `--jql` | JQL für Bulk-Edit |
| `-s, --summary` | Neuer Titel |
| `-d, --description` | Neue Beschreibung |
| `--description-file` | Beschreibung aus Datei |
| `-a, --assignee` | Neuer Assignee |
| `-l, --labels` | Labels hinzufügen |
| `--remove-labels` | Labels entfernen |
| `--remove-assignee` | Assignee entfernen |
| `-t, --type` | Typ ändern |
| `-y, --yes` | Ohne Bestätigung |

### transition - Status ändern

```bash
acli jira workitem transition \
  --key "DS-123" \
  --status "In Progress" \
  --yes

# Mehrere Tickets
acli jira workitem transition \
  --jql "project = DS AND status = 'To Do'" \
  --status "In Progress" \
  --yes
```

**Flags:**
| Flag | Beschreibung |
|------|--------------|
| `-k, --key` | Ticket-Key(s) |
| `--jql` | JQL für Bulk-Transition |
| `-s, --status` | Ziel-Status |
| `-y, --yes` | Ohne Bestätigung |

### comment - Kommentare

```bash
# Kommentar hinzufügen
acli jira workitem comment create \
  --key "DS-123" \
  --body "Kommentar-Text"

# Aus Datei
acli jira workitem comment create \
  --key "DS-123" \
  --body-file "/tmp/comment.md"

# Kommentare auflisten
acli jira workitem comment list --key "DS-123"
```

### link - Verknüpfungen

```bash
# Link erstellen
acli jira workitem link create \
  --out DS-123 \
  --in DS-456 \
  --type "Blocks"

# Verfügbare Link-Typen
acli jira workitem link type

# Links eines Tickets anzeigen
acli jira workitem link list --key "DS-123"

# Link löschen
acli jira workitem link delete \
  --out DS-123 \
  --in DS-456 \
  --type "Blocks"
```

### Weitere Commands

```bash
# Archivieren
acli jira workitem archive --key "DS-123"
acli jira workitem unarchive --key "DS-123"

# Zuweisen
acli jira workitem assign --key "DS-123" --assignee "@me"

# Klonen
acli jira workitem clone --key "DS-123"

# Löschen
acli jira workitem delete --key "DS-123" --yes
```

## Project Commands

```bash
# Projekte auflisten
acli jira project list
acli jira project list --recent
acli jira project list --json

# Projekt anzeigen
acli jira project view DS
acli jira project view DS --json
```

## Nützliche JQL-Queries

```bash
# Offene Tickets
"project = DS AND status != Done"

# Meine Tickets
"project = DS AND assignee = currentUser()"

# Unassigned
"project = DS AND assignee IS EMPTY"

# Nach Label
"project = DS AND labels = 'component'"
"project = DS AND labels IN ('component', 'frontend')"

# Nach Typ
"project = DS AND issuetype = Story"

# Kürzlich aktualisiert
"project = DS AND updated >= -7d"

# Erstellt diese Woche
"project = DS AND created >= startOfWeek()"

# Text-Suche
"project = DS AND summary ~ 'Button'"
"project = DS AND text ~ 'authentication'"

# Kombiniert
"project = DS AND status = 'To Do' AND labels = 'component' ORDER BY priority DESC"
```

## Workflow-Beispiel

```bash
# 1. Ticket erstellen
cat > /tmp/desc.md << 'EOF'
## Überblick
Implementierung der Button-Komponente als SDC.

## Acceptance Criteria
- [ ] Component hat .component.yml mit Schema
- [ ] Component hat .twig Template
- [ ] Component hat .stories.js
- [ ] Component ist WCAG 2.1 AA konform
EOF

TICKET=$(acli jira workitem create \
  --project "DS" \
  --type "Story" \
  --summary "[Component] Button - Base implementation" \
  --description-file "/tmp/desc.md" \
  --label "component,frontend,sdc" \
  --json | jq -r '.key')

echo "Created: $TICKET"

# 2. Status ändern
acli jira workitem transition --key "$TICKET" --status "In Progress" --yes

# 3. Kommentar hinzufügen
acli jira workitem comment create --key "$TICKET" --body "Implementation gestartet"

# 4. Abschließen
acli jira workitem transition --key "$TICKET" --status "Done" --yes
```

## Troubleshooting

```bash
# Auth-Status prüfen
acli jira auth status

# Neu einloggen
acli jira auth login

# Verbose Output
acli jira workitem view DS-123 --json | jq .
```
