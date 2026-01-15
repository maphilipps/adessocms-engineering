# Debug Actions Workflow

## Fehler identifizieren

```bash
# 1. Fehlgeschlagene Runs finden
gh run list --status=failure

# 2. Run Details ansehen
gh run view <run-id>

# 3. Fehlgeschlagene Logs anzeigen
gh run view <run-id> --log-failed
```

---

## Workflow Syntax validieren

```bash
# Lokale Validierung mit actionlint
actionlint .github/workflows/*.yml

# Installation (macOS)
brew install actionlint
```

---

## Häufige Fehler

### Permissions

```yaml
# In workflow
permissions:
  contents: read
  pull-requests: write
  issues: write
```

### Checkout Fehler

```yaml
steps:
  - uses: actions/checkout@v4
    with:
      fetch-depth: 0  # Für vollständige Git-History
```

### Caching Probleme

```yaml
- uses: actions/cache@v3
  with:
    path: ~/.composer/cache
    key: composer-${{ hashFiles('composer.lock') }}
    restore-keys: |
      composer-
```

---

## Debug Logging aktivieren

```bash
# Re-run mit Debug
gh run rerun <run-id> --debug

# Oder via Repository Secrets
# ACTIONS_STEP_DEBUG = true
# ACTIONS_RUNNER_DEBUG = true
```

---

## Lokales Debugging mit act

```bash
# act installieren
brew install act

# Workflow lokal ausführen
act -j build

# Mit Secrets
act --secret-file .secrets

# Dry run
act -n
```

---

## Job neu ausführen

```bash
# Gesamten Run
gh run rerun <run-id>

# Nur fehlgeschlagene Jobs
gh run rerun <run-id> --failed
```

---

## Workflow Logs durchsuchen

```bash
# Logs in Datei speichern
gh run view <run-id> --log > logs.txt

# Nach Fehler suchen
gh run view <run-id> --log | grep -i error
```

---

## Self-hosted Runner debuggen

```bash
# Runner Status
gh runner list

# Runner Logs
# Auf dem Runner:
cat /var/log/github-runner/*.log
```

---

## Artifacts zur Fehleranalyse

```yaml
# Bei Fehlern Artifacts speichern
- name: Upload logs on failure
  if: failure()
  uses: actions/upload-artifact@v4
  with:
    name: failure-logs
    path: |
      logs/
      screenshots/
```

```bash
# Artifacts herunterladen
gh run download <run-id> --name failure-logs
```

---

## Matrix Debugging

```yaml
strategy:
  fail-fast: false  # Alle Matrix-Jobs laufen lassen
  matrix:
    php: [8.1, 8.2, 8.3]
```

```bash
# Spezifischen Matrix-Job ansehen
gh run view <run-id> --verbose
```
