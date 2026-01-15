# Actions Status Workflow

## Workflow Runs anzeigen

```bash
# Letzte Runs auflisten
gh run list

# Nur bestimmter Workflow
gh run list --workflow=ci.yml

# Mit Status-Filter
gh run list --status=failure
gh run list --status=success
gh run list --status=in_progress
```

---

## Bestimmten Run ansehen

```bash
# Run Details
gh run view <run-id>

# Mit Jobs
gh run view <run-id> --verbose

# Logs eines Jobs
gh run view <run-id> --log

# Im Browser
gh run view <run-id> --web
```

---

## Live-Status beobachten

```bash
# Run beobachten
gh run watch <run-id>

# Oder aktuellsten Run
gh run watch
```

---

## Job Logs

```bash
# Alle Logs
gh run view <run-id> --log

# Fehlgeschlagene Logs
gh run view <run-id> --log-failed

# Spezifischer Job
gh run view <run-id> --job=<job-id>
```

---

## Workflow manuell triggern

```bash
# Workflow triggern
gh workflow run ci.yml

# Mit Branch
gh workflow run ci.yml --ref feature-branch

# Mit Inputs
gh workflow run ci.yml -f environment=staging
```

---

## Workflow Runs verwalten

```bash
# Run erneut ausführen
gh run rerun <run-id>

# Nur fehlgeschlagene Jobs
gh run rerun <run-id> --failed

# Run abbrechen
gh run cancel <run-id>
```

---

## Artifacts herunterladen

```bash
# Alle Artifacts eines Runs
gh run download <run-id>

# Spezifisches Artifact
gh run download <run-id> --name coverage-report

# In bestimmten Ordner
gh run download <run-id> --dir ./artifacts
```

---

## PR Checks

```bash
# Checks für aktuellen Branch
gh pr checks

# Checks für spezifischen PR
gh pr checks <pr-number>

# Auf alle Checks warten
gh pr checks --watch
```

---

## Monitoring Pattern

```bash
# Automatisch auf CI warten
gh run watch && echo "CI passed!" || echo "CI failed!"

# Mit Benachrichtigung (macOS)
gh run watch && osascript -e 'display notification "CI Passed" with title "GitHub Actions"'
```
