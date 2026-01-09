# Pipeline Status Workflow

## Aktuellen Status prüfen

```bash
# Status der aktuellen Branch-Pipeline
glab ci status

# Detaillierte Ansicht
glab ci view

# Im Browser öffnen
glab ci view --web
```

---

## Pipeline Jobs anzeigen

```bash
# Alle Jobs der aktuellen Pipeline
glab ci status --show-jobs

# Spezifische Pipeline
glab ci view <pipeline-id>
```

---

## Job Logs ansehen

```bash
# Live Logs eines Jobs
glab ci trace <job-name>

# Beispiel
glab ci trace test
glab ci trace deploy_staging
```

---

## Pipeline History

```bash
# Letzte Pipelines auflisten
glab ci list

# Mit Status-Filter
glab ci list --status=failed
glab ci list --status=success
```

---

## Pipeline Actions

```bash
# Pipeline neu starten
glab ci retry

# Pipeline abbrechen
glab ci cancel

# Manuellen Job triggern
glab ci run <job-name>
```

---

## Artifacts herunterladen

```bash
# Job Artifacts
glab ci artifact download <job-name>

# Beispiel: Test Coverage Report
glab ci artifact download coverage --path=coverage/
```

---

## Pipeline Variables

```bash
# Pipeline mit Variablen triggern
glab ci trigger --variables KEY=value
```

---

## Monitoring Pattern

```bash
# Pipeline beobachten bis fertig
watch -n 5 glab ci status

# Oder mit Loop
while glab ci status | grep -q "running"; do
  echo "Pipeline running..."
  sleep 10
done
echo "Pipeline finished!"
```
