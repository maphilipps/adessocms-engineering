# Debug Pipeline Workflow

## Fehler identifizieren

```bash
# 1. Pipeline Status prüfen
glab ci status

# 2. Fehlgeschlagene Jobs finden
glab ci status --show-jobs | grep failed

# 3. Job Logs ansehen
glab ci trace <failed-job-name>
```

---

## Häufige Fehler

### YAML Syntax

```bash
# .gitlab-ci.yml validieren
glab ci lint

# Lokale Validierung
cat .gitlab-ci.yml | glab ci lint --stdin
```

### Dependency Fehler

```yaml
# In .gitlab-ci.yml
job_name:
  cache:
    key: ${CI_COMMIT_REF_SLUG}
    paths:
      - vendor/
      - node_modules/
```

### Permission Fehler

```yaml
# Script ausführbar machen
before_script:
  - chmod +x ./scripts/deploy.sh
```

---

## Job lokal debuggen

```bash
# Docker Container wie CI
docker run -it --rm \
  -v $(pwd):/app \
  -w /app \
  registry.gitlab.com/gitlab-org/gitlab-build-images:ruby-2.7 \
  /bin/bash
```

---

## Pipeline Retry

```bash
# Gesamte Pipeline
glab ci retry

# Einzelnen Job
glab ci retry --job <job-name>
```

---

## Debug Variablen

```yaml
# In .gitlab-ci.yml
debug_job:
  script:
    - echo "CI_COMMIT_REF_NAME=$CI_COMMIT_REF_NAME"
    - echo "CI_PIPELINE_SOURCE=$CI_PIPELINE_SOURCE"
    - env | grep CI_
```

---

## Artifacts zur Analyse

```yaml
# Bei Fehlern Artifacts speichern
test:
  script:
    - npm test
  artifacts:
    when: on_failure
    paths:
      - logs/
      - screenshots/
    expire_in: 1 week
```

---

## Timeout-Probleme

```yaml
# Timeout erhöhen
long_job:
  timeout: 2 hours
  script:
    - ./long-running-script.sh
```

---

## SSH Debug (Self-Hosted Runners)

```yaml
# Debug-Job mit SSH
debug:
  script:
    - sleep 3600  # 1 Stunde warten
  when: manual
```

Dann SSH zum Runner und in Container einloggen.
