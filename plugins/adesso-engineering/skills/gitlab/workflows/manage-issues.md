# Manage Issues Workflow

## Issue erstellen

```bash
# Einfaches Issue
glab issue create \
  --title "Bug: Login funktioniert nicht" \
  --description "Beim Login erscheint ein Fehler..."

# Mit Labels und Assignee
glab issue create \
  --title "Feature: Dark Mode" \
  --description "Implementiere Dark Mode Support" \
  --label "feature,frontend" \
  --assignee @username \
  --milestone "Sprint 5"
```

---

## Issues auflisten

```bash
# Alle offenen Issues
glab issue list

# Mir zugewiesene
glab issue list --assignee @me

# Mit Label-Filter
glab issue list --label "bug"

# Geschlossene Issues
glab issue list --state closed
```

---

## Issue ansehen

```bash
# Issue Details
glab issue view 42

# Im Browser öffnen
glab issue view 42 --web
```

---

## Issue bearbeiten

```bash
# Labels hinzufügen
glab issue update 42 --label "priority::high"

# Assignee ändern
glab issue update 42 --assignee @newuser

# Milestone setzen
glab issue update 42 --milestone "Sprint 6"
```

---

## Issue schließen/öffnen

```bash
# Schließen
glab issue close 42

# Wieder öffnen
glab issue reopen 42
```

---

## Kommentare

```bash
# Kommentar hinzufügen
glab issue note 42 --message "Working on this now"

# Aus Datei
glab issue note 42 --message "$(cat notes.md)"
```

---

## Issue aus MR verlinken

```bash
# In MR Description
# "Closes #42" oder "Fixes #42"

glab mr create \
  --title "Fix: resolve issue #42" \
  --description "Closes #42"
```

---

## Board-Workflow

```bash
# Issue zu Board hinzufügen (via Label)
glab issue update 42 --label "board::in-progress"

# Nach "Done" verschieben
glab issue update 42 --unlabel "board::in-progress" --label "board::done"
```

---

## Templates nutzen

Issue Templates liegen in `.gitlab/issue_templates/`:

```markdown
<!-- .gitlab/issue_templates/Bug.md -->
## Description

## Steps to Reproduce

1.
2.
3.

## Expected Behavior

## Actual Behavior

## Environment
- Browser:
- OS:
```

```bash
# Mit Template erstellen (interaktiv)
glab issue create -i
```
