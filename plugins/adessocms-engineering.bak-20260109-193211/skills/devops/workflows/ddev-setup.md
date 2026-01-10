# DDEV Setup Workflow

## Neues Projekt initialisieren

```bash
# 1. Verzeichnis erstellen
mkdir ~/Sites/project-name && cd ~/Sites/project-name

# 2. DDEV konfigurieren
ddev config --project-type=drupal --docroot=web --php-version=8.3

# 3. Drupal installieren
ddev composer create drupal/recommended-project .

# 4. Drush hinzufügen
ddev composer require drush/drush

# 5. Container starten
ddev start

# 6. Site installieren
ddev drush site:install --account-name=admin --account-pass=admin
```

---

## Bestehendes Projekt klonen

```bash
# 1. Repository klonen
git clone git@gitlab.example.com:project/repo.git project-name
cd project-name

# 2. DDEV starten (liest .ddev/config.yaml)
ddev start

# 3. Dependencies installieren
ddev composer install

# 4. Datenbank importieren
ddev import-db --file=dump.sql.gz

# 5. Config importieren
ddev drush cim -y

# 6. Cache leeren
ddev drush cr
```

---

## .ddev/config.yaml Konfiguration

```yaml
name: project-name
type: drupal
docroot: web
php_version: "8.3"
webserver_type: nginx-fpm
database:
  type: mariadb
  version: "10.11"
nodejs_version: "20"

# Performance
mutagen_enabled: true  # macOS Performance

# Hooks
hooks:
  post-start:
    - exec: composer install
    - exec: drush cr
```

---

## Zusätzliche Services

### Redis

```yaml
# .ddev/docker-compose.redis.yaml
services:
  redis:
    container_name: ddev-${DDEV_SITENAME}-redis
    image: redis:7-alpine
    restart: "no"
    labels:
      com.ddev.site-name: ${DDEV_SITENAME}
```

### Solr

```bash
ddev get ddev/ddev-solr
```

### Mailhog (Standard)

Bereits integriert: `https://project-name.ddev.site:8026`

---

## Verification

```bash
# Status prüfen
ddev describe

# URLs anzeigen
ddev launch

# Logs prüfen
ddev logs -f
```
