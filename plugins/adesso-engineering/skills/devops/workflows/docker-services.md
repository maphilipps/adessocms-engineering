# Docker Services Workflow

## Zusätzliche Services konfigurieren

### Standard Services in DDEV

```bash
# Verfügbare Add-ons
ddev get --list

# Add-on installieren
ddev get ddev/ddev-redis
ddev get ddev/ddev-solr
ddev get ddev/ddev-elasticsearch
ddev get ddev/ddev-varnish
```

---

## Redis Setup

### Installation

```bash
ddev get ddev/ddev-redis
ddev restart
```

### Drupal Konfiguration

```php
// settings.ddev.php
$settings['redis.connection']['interface'] = 'PhpRedis';
$settings['redis.connection']['host'] = 'redis';
$settings['cache']['default'] = 'cache.backend.redis';
```

### Modul aktivieren

```bash
ddev composer require drupal/redis
ddev drush en redis -y
```

---

## Solr Setup

### Installation

```bash
ddev get ddev/ddev-solr
ddev restart
```

### Core erstellen

```bash
# Solr Admin: https://project.ddev.site:8983
ddev solr create-core drupal
```

### Drupal Konfiguration

```bash
ddev composer require drupal/search_api_solr
ddev drush en search_api_solr -y
```

---

## Elasticsearch Setup

### Installation

```bash
ddev get ddev/ddev-elasticsearch
ddev restart
```

### Drupal Integration

```bash
ddev composer require drupal/elasticsearch_connector
ddev drush en elasticsearch_connector -y
```

---

## Custom Service hinzufügen

### docker-compose.custom.yaml

```yaml
# .ddev/docker-compose.custom.yaml
services:
  custom-service:
    container_name: ddev-${DDEV_SITENAME}-custom
    image: image:tag
    restart: "no"
    environment:
      - VARIABLE=value
    volumes:
      - ./data:/app/data
    labels:
      com.ddev.site-name: ${DDEV_SITENAME}
      com.ddev.approot: ${DDEV_APPROOT}
```

---

## Service Debugging

```bash
# Container Status
ddev describe

# Service Logs
docker logs ddev-projectname-redis

# In Container einloggen
docker exec -it ddev-projectname-redis sh

# Netzwerk prüfen
ddev exec ping redis
```

---

## Häufige Patterns

### Datenbank-Tools

```yaml
# .ddev/docker-compose.adminer.yaml
services:
  adminer:
    container_name: ddev-${DDEV_SITENAME}-adminer
    image: adminer:latest
    restart: "no"
    labels:
      com.ddev.site-name: ${DDEV_SITENAME}
    environment:
      - ADMINER_DEFAULT_SERVER=db
```

### Queue Worker

```yaml
# .ddev/docker-compose.worker.yaml
services:
  queue-worker:
    container_name: ddev-${DDEV_SITENAME}-worker
    image: ddev/ddev-webserver
    command: ["drush", "queue:run", "my_queue"]
    restart: "no"
```
