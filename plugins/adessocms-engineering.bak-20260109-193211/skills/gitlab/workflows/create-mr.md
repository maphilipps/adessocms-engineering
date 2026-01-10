# Create Merge Request Workflow

## Standard MR erstellen

```bash
# 1. Feature Branch erstellen (falls noch nicht geschehen)
git checkout -b feat/my-feature

# 2. Änderungen committen
git add .
git commit -m "feat: implement feature X"

# 3. Branch pushen
git push -u origin feat/my-feature

# 4. MR erstellen
glab mr create \
  --title "feat: implement feature X" \
  --description "## Summary
- Added feature X
- Updated tests

## Testing
- [ ] Unit tests pass
- [ ] Manual testing done" \
  --target-branch main
```

---

## MR mit Template

```bash
# Template verwenden (falls .gitlab/merge_request_templates/ existiert)
glab mr create \
  --title "feat: implement feature X" \
  --fill  # Füllt aus Template
```

---

## MR Optionen

```bash
glab mr create \
  --title "Fix: resolve issue #42" \
  --description "Fixes the bug described in #42" \
  --target-branch main \
  --assignee @username \
  --reviewer @reviewer1,@reviewer2 \
  --label "bug,priority::high" \
  --milestone "Sprint 5" \
  --remove-source-branch \
  --squash
```

---

## Draft MR

```bash
# Als Draft erstellen
glab mr create \
  --title "Draft: WIP feature" \
  --draft
```

---

## MR aus Issue erstellen

```bash
# Issue-Referenz im MR
glab mr create \
  --title "Closes #42: Fix authentication bug" \
  --description "Closes #42"
```

---

## Nach MR-Erstellung

```bash
# MR im Browser öffnen
glab mr view --web

# MR Status prüfen
glab mr view

# Pipeline Status
glab ci status
```

---

## Interaktiver Modus

```bash
# Interaktiv alle Felder ausfüllen
glab mr create -i
```
