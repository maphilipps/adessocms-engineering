# Manage Issues Workflow

## Issue erstellen

```bash
# Einfaches Issue
gh issue create \
  --title "Bug: Login funktioniert nicht" \
  --body "Beim Login erscheint ein Fehler..."

# Mit Labels und Assignee
gh issue create \
  --title "Feature: Dark Mode" \
  --body "Implementiere Dark Mode Support" \
  --label "feature,frontend" \
  --assignee @me \
  --milestone "Sprint 5"
```

---

## Issues auflisten

```bash
# Alle offenen Issues
gh issue list

# Mir zugewiesene
gh issue list --assignee @me

# Mit Label-Filter
gh issue list --label "bug"

# Geschlossene Issues
gh issue list --state closed

# Suche
gh issue list --search "login in:title"
```

---

## Issue ansehen

```bash
# Issue Details
gh issue view 42

# Im Browser öffnen
gh issue view 42 --web

# Mit Kommentaren
gh issue view 42 --comments
```

---

## Issue bearbeiten

```bash
# Labels hinzufügen
gh issue edit 42 --add-label "priority:high"

# Labels entfernen
gh issue edit 42 --remove-label "needs-triage"

# Assignee ändern
gh issue edit 42 --add-assignee @newuser

# Milestone setzen
gh issue edit 42 --milestone "Sprint 6"

# Titel ändern
gh issue edit 42 --title "New Title"
```

---

## Issue schließen/öffnen

```bash
# Schließen
gh issue close 42

# Mit Kommentar schließen
gh issue close 42 --comment "Fixed in PR #123"

# Als Duplikat schließen
gh issue close 42 --reason "duplicate"

# Wieder öffnen
gh issue reopen 42
```

---

## Kommentare

```bash
# Kommentar hinzufügen
gh issue comment 42 --body "Working on this now"

# Aus Datei
gh issue comment 42 --body-file notes.md

# Interaktiv
gh issue comment 42
```

---

## Issue aus PR verlinken

```bash
# In PR Description oder Commit
# "Closes #42", "Fixes #42", "Resolves #42"

gh pr create \
  --title "Fix: resolve issue #42" \
  --body "Closes #42"
```

---

## Issue Development Workflow

```bash
# 1. Branch für Issue erstellen
gh issue develop 42

# 2. Arbeiten...
git add . && git commit -m "Fix #42: description"

# 3. PR erstellen
gh pr create --title "Closes #42: Fix description"
```

---

## Issue Transfer

```bash
# Zu anderem Repo transferieren
gh issue transfer 42 owner/other-repo
```

---

## Issue Pin/Unpin

```bash
# Issue anpinnen
gh issue pin 42

# Issue lösen
gh issue unpin 42
```

---

## Labels verwalten

```bash
# Labels auflisten
gh label list

# Label erstellen
gh label create "priority:high" --color "FF0000" --description "High priority"

# Label löschen
gh label delete "old-label"
```
