# Create Pull Request Workflow

## Standard PR erstellen

```bash
# 1. Feature Branch erstellen (falls noch nicht geschehen)
git checkout -b feat/my-feature

# 2. Änderungen committen
git add .
git commit -m "feat: implement feature X"

# 3. Branch pushen
git push -u origin feat/my-feature

# 4. PR erstellen
gh pr create \
  --title "feat: implement feature X" \
  --body "## Summary
- Added feature X
- Updated tests

## Testing
- [ ] Unit tests pass
- [ ] Manual testing done" \
  --base main
```

---

## PR mit Template

```bash
# Template verwenden (falls .github/pull_request_template.md existiert)
gh pr create --fill
```

---

## PR Optionen

```bash
gh pr create \
  --title "Fix: resolve issue #42" \
  --body "Fixes the bug described in #42" \
  --base main \
  --assignee @me \
  --reviewer @reviewer1,@reviewer2 \
  --label "bug,priority:high" \
  --milestone "Sprint 5"
```

---

## Draft PR

```bash
# Als Draft erstellen
gh pr create \
  --title "Draft: WIP feature" \
  --draft
```

---

## PR aus Issue erstellen

```bash
# Issue-Referenz im PR
gh pr create \
  --title "Closes #42: Fix authentication bug" \
  --body "Closes #42"
```

---

## Nach PR-Erstellung

```bash
# PR im Browser öffnen
gh pr view --web

# PR Status prüfen
gh pr status

# PR Checks ansehen
gh pr checks
```

---

## Interaktiver Modus

```bash
# Interaktiv alle Felder ausfüllen
gh pr create --web  # Öffnet im Browser
```

---

## PR aus aktuellem Branch

```bash
# Wenn Branch bereits gepusht
gh pr create

# Mit aktuellem Commit als Titel
gh pr create --fill
```
